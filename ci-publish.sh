#!/bin/bash

# Path to your Bazel WORKSPACE directory
workspace_path=$PWD
# Path to your Bazel executable
bazel_path="bazelisk"
# Starting Revision SHA
previous_revision=${1:-"HEAD^1"}
# Final Revision SHA
final_revision="main"

starting_hashes_json="/tmp/starting_hashes.json"
final_hashes_json="/tmp/final_hashes.json"
impacted_targets_path="/tmp/impacted_targets.txt"
impacted_test_targets_path="/tmp/impacted_test_targets.txt"
bazel_diff="/tmp/bazel_diff"

shared_flags=""

# Uncomment the line below to see debug information
# shared_flags="--config=verbose"

$bazel_path run :bazel-diff $shared_flags --script_path="$bazel_diff"

git -C $workspace_path checkout $previous_revision --quiet

echo "Generating Hashes for Revision '$previous_revision'"
$bazel_diff generate-hashes -w $workspace_path -b $bazel_path $starting_hashes_json

git -C $workspace_path checkout $final_revision --quiet

echo "Generating Hashes for Revision '$final_revision'"
$bazel_diff generate-hashes -w $workspace_path -b $bazel_path $final_hashes_json

echo "Determining Impacted Targets"
$bazel_diff get-impacted-targets -sh $starting_hashes_json -fh $final_hashes_json -o $impacted_targets_path

list=$(grep :container_push$ $impacted_targets_path)

while IFS= read -r line; do
    [[ $line =~ ^[\s]*$ ]] && continue
    bazel run ${line}
    [[ ${line} =~ \/\/(.*):container_push ]] && bazel run //tools:publish $PWD/${BASH_REMATCH[1]}/Chart
done <<< "$list"
