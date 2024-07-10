#!/bin/bash
set -ex

readonly output_file="output.json"

upload_task() {
    curl --silent -f \
        -o "$output_file" \
        -F whats_new="$release_notes" \
        -F build_type="bitrise" \
        -F "app=@$app_path" \
        -X PUT https://getupdraft.com/api/app_upload/$app_key/$api_key/
}

if ! upload_task; then
    err "Uploading error"
    exit 1
fi

cat "$output_file"

envman add --key UPDRAFT_DEPLOY_STEP_OUTPUT --value "$output_file"

echo "Uploaded succesfuly"