#!/bin/bash

set -eu

if [[ "$(uname)" == "Darwin"  ]]; then
	export OS="Mac"
else
	export OS="Linux"
fi

export CONFIG_BASE="$(realpath "$(dirname "$0")")"

for f in "${CONFIG_BASE}"/setup.d/*.sh; do
	[[ -r "${f}" ]] && bash "${f}"
done
[[ "${OS}" == "Mac" ]] && "${CONFIG_BASE}/mac/setup.sh"
