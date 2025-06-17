aws-switch() {
  profiles=("${(@f)$(aws configure list-profiles)}")
  echo "-----------------------------"
  echo "📋 Available AWS SSO Profiles:"
  echo "-----------------------------"
  for i in {1..${#profiles[@]}}; do
    echo "$i) ${profiles[$i]}"
  done

  echo ""
  read "selection?👉 Enter the number of the profile to switch to: "

  if [[ "$selection" =~ '^[0-9]+$' ]] && (( selection >= 1 && selection <= ${#profiles[@]} )); then
    profile="${profiles[$selection]}"
    echo "🔐 Logging in with profile: $profile"
    aws sso login --profile "$profile"

    echo "🚫 Unsetting any existing static credentials..."
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN

    echo "🌍 Exporting SSO credentials for: $profile"
    export AWS_PROFILE="$profile"
    source <(aws configure export-credentials --profile "$profile" --format env)

    echo "✅ Switched to AWS profile: $profile"
  else
    echo "❌ Invalid selection: $selection"
  fi
}
