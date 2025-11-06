aws-switch() {
  local input_profile="$1"
  local profile

  profiles=()
  while IFS= read -r line; do
    [[ -n $line ]] && profiles+=("$line")
  done < <(aws configure list-profiles)

  if [[ -n "$input_profile" ]]; then
    profile="$input_profile"

    if ! printf '%s\n' "${profiles[@]}" | grep -Fxq "$profile"; then
      echo "⚠️ Profile '$profile' not found."
      return 1
    fi
  else
    echo "-----------------------------"
    echo "📋 Available AWS SSO Profiles:"
    echo "-----------------------------"
    for i in {1..${#profiles[@]}}; do
      echo "$i) ${profiles[$i]}"
    done

    echo ""
    read "selection?👉 Enter the number of the profile to switch to: "

    if [[ "$selection" =~ ^[0-9]+$ ]] && (( selection >= 1 && selection <= ${#profiles[@]} )); then
      profile="${profiles[$selection]}"
    else
      echo "❌ Invalid selection: $selection"
      return 1
    fi
  fi

  echo "🔍 Checking SSO session for profile: $profile"
  if aws sts get-caller-identity --profile "$profile" >/dev/null 2>&1; then
    echo "✅ Valid SSO session already present for profile: $profile"
  else
    echo "🔐 Logging in with profile: $profile"
    if ! aws sso login --profile "$profile"; then
      echo "❌ SSO login failed or was cancelled for profile: $profile"
      return 1
    fi
  fi

  echo "🚫 Unsetting any existing static credentials..."
  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN

  echo "🌍 Exporting SSO credentials for: $profile"
  creds_output=$(aws configure export-credentials --profile "$profile" --format env 2>&1)
  if [[ $? -ne 0 ]]; then
    echo "❌ Failed to export credentials for profile: $profile"
    echo "$creds_output"
    return 1
  fi

  export AWS_PROFILE="$profile"
  source <(echo "$creds_output")

  echo "✅ Switched to AWS profile: $profile"
}
