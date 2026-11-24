#!/bin/sh

# Shows the number of unread GitHub notifications, using the gh CLI's login.

PATH="/opt/homebrew/bin:$PATH"

. "$(dirname "$0")/badge.sh"

# The API returns 50 per page, so count across all pages
COUNT="$(gh api --paginate 'notifications?per_page=100' --jq '.[].id' | wc -l | tr -d ' ')" || exit 0
set_badge "$COUNT"
