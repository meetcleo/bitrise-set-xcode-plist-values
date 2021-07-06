#!/bin/bash
set -e
set -x

echo "------START--------"

# Required parameters

if [ -z "${plist_path}" ] ; then
  echo "💥 Missing required input: plist_path 💥"
  exit 1
fi
if [ ! -f "${plist_path}" ] ; then
  echo "💥 File doesn't exist at specified Info.plist path: ${plist_path} 💥"
  exit 1
fi

if [ -z "${plist_keys_list}" ] ; then
  echo "💥 No key for plist specified 💥"
  exit 1
fi

if [ -z "${plist_values_list}" ] ; then
  echo "💥 No value for plist specified 💥"
  exit 1
fi

# Configs

CONFIG_project_info_plist_path="${plist_path}"

CONFIG_plist_keys_list=()
while read -r line; do
   CONFIG_plist_keys_list+=("$line")
done <<< "${plist_keys_list}"

CONFIG_plist_values_list=()
while read -r line; do
   CONFIG_plist_values_list+=("$line")
done <<< "${plist_values_list}"

echo "ℹ️ Provided Info.plist path: ${CONFIG_project_info_plist_path}"
echo "ℹ️ Plist Keys: ${CONFIG_plist_keys_list[*]}"
echo "ℹ️ Plist values: ${CONFIG_plist_values_list[*]}"

# ---- Change Plist Values:
for i in "${!CONFIG_plist_keys_list[@]}"; do 
  /usr/libexec/PlistBuddy -c "Set :${CONFIG_plist_keys_list[$i]} ${CONFIG_plist_values_list[$i]}" "${CONFIG_project_info_plist_path}"
done
# ==> Plist value changed
