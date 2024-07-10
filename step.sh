#!/bin/bash
set -ex

readonly output_file="output.json"

upload_task() {
    curl --silent -f \
        -o "$output_file" \
        -F whats_new="$release_notes" \
        -F "app=@$app_path" \
        -X PUT https://getupdraft.com/api/app_upload/$APP_KEY/$API_KEY/
}

cat "$output_file"

if ! upload_task; then
    err "Uploading error"
    exit 1
fi

envman add --key UPDRAFT_DEPLOY_STEP_OUTPUT --value "$output_file"

echo "Uploaded succesfuly"