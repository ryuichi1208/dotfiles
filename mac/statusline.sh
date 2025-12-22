#!/bin/bash
# Read JSON input from stdin
input=$(cat)

# ANSI color codes
GREEN='\033[32m'
CYAN='\033[36m'
BLUE='\033[34m'
YELLOW='\033[33m'
RED='\033[31m'
MAGENTA='\033[35m'
WHITE='\033[37m'
RESET='\033[0m'

# Function to format numbers with K suffix
format_number() {
    local num=$1
    if [ "$num" -ge 1000 ]; then
        echo "$((num / 1000))K"
    else
        echo "$num"
    fi
}

# Extract values using jq
MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')

# Get context info (total_input_tokens + total_output_tokens)
TOTAL_INPUT=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
TOTAL_OUTPUT=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
CONTEXT_MAX=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
CONTEXT_USED=$((TOTAL_INPUT + TOTAL_OUTPUT))

# Calculate context usage percentage
if [ "$CONTEXT_MAX" -gt 0 ] && [ "$CONTEXT_USED" -gt 0 ]; then
    CONTEXT_PERCENT=$((CONTEXT_USED * 100 / CONTEXT_MAX))
    USED_DISPLAY=$(format_number $CONTEXT_USED)
    MAX_DISPLAY=$(format_number $CONTEXT_MAX)
    if [ "$CONTEXT_PERCENT" -ge 80 ]; then
        CONTEXT_COLOR=$RED
    elif [ "$CONTEXT_PERCENT" -ge 50 ]; then
        CONTEXT_COLOR=$YELLOW
    else
        CONTEXT_COLOR=$GREEN
    fi
    CONTEXT_INFO="${CONTEXT_COLOR}${USED_DISPLAY}/${MAX_DISPLAY} (${CONTEXT_PERCENT}%)${RESET}"
else
    MAX_DISPLAY=$(format_number $CONTEXT_MAX)
    CONTEXT_INFO="${WHITE}-/${MAX_DISPLAY}${RESET}"
fi

# Repository name (directory name)
REPO_NAME="${CURRENT_DIR##*/}"

# Show git branch and status if in a git repository
GIT_INFO=""
LINES_INFO=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    if [ -n "$BRANCH" ]; then
        # Get org name from remote URL
        REMOTE_URL=$(git remote get-url origin 2>/dev/null)
        ORG_NAME=""
        if [ -n "$REMOTE_URL" ]; then
            # SSH format: git@github.com:org/repo.git
            # SSH URL format: ssh://git@github.com/org/repo.git
            # HTTPS format: https://github.com/org/repo.git
            if [[ "$REMOTE_URL" =~ git@[^:]+:([^/]+)/ ]]; then
                ORG_NAME="${BASH_REMATCH[1]}"
            elif [[ "$REMOTE_URL" =~ ://[^/]+/([^/]+)/ ]]; then
                ORG_NAME="${BASH_REMATCH[1]}"
            fi
        fi

        # Get status counts
        STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
        UNSTAGED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
        UNTRACKED=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

        # Get lines changed (added/deleted)
        DIFF_STATS=$(git diff --numstat 2>/dev/null | awk '{add+=$1; del+=$2} END {printf "%d %d", add+0, del+0}')
        CACHED_STATS=$(git diff --cached --numstat 2>/dev/null | awk '{add+=$1; del+=$2} END {printf "%d %d", add+0, del+0}')

        ADDED=$(echo "$DIFF_STATS $CACHED_STATS" | awk '{print $1+$3}')
        DELETED=$(echo "$DIFF_STATS $CACHED_STATS" | awk '{print $2+$4}')

        STATUS=""
        [ "$STAGED" -gt 0 ] && STATUS="${STATUS}${GREEN}+${STAGED}${RESET}"
        [ "$UNSTAGED" -gt 0 ] && STATUS="${STATUS}${YELLOW}~${UNSTAGED}${RESET}"
        [ "$UNTRACKED" -gt 0 ] && STATUS="${STATUS}${RED}?${UNTRACKED}${RESET}"

        # org/repo(branch) format
        if [ -n "$ORG_NAME" ]; then
            GIT_INFO="${WHITE}${ORG_NAME}/${REPO_NAME}${RESET}(${MAGENTA}${BRANCH}${RESET})"
        else
            GIT_INFO="${WHITE}${REPO_NAME}${RESET}(${MAGENTA}${BRANCH}${RESET})"
        fi

        # Status
        if [ -n "$STATUS" ]; then
            GIT_INFO="${GIT_INFO} ${STATUS}"
        fi

        # Lines changed
        if [ "$ADDED" -gt 0 ] || [ "$DELETED" -gt 0 ]; then
            LINES_INFO="${GREEN}+${ADDED}${RESET}/${RED}-${DELETED}${RESET}"
        fi
    fi
fi

# Output: model | org/repo(branch) git status | lines changed | context
OUTPUT="${CYAN}${MODEL_DISPLAY}${RESET}"

if [ -n "$GIT_INFO" ]; then
    OUTPUT="${OUTPUT} | ${GIT_INFO}"
fi

if [ -n "$LINES_INFO" ]; then
    OUTPUT="${OUTPUT} | ${LINES_INFO}"
fi

OUTPUT="${OUTPUT} | ${CONTEXT_INFO}"

echo -e "$OUTPUT"

