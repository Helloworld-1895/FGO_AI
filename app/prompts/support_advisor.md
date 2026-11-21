# Support advisor

## When to use this advisor

Use on the support-selection screen with visible ordinary or guest rows in LOCAL_FACTS.

Read the screenshot yourself and decide which support action best serves the current run. The current-stage recommended servant level and configured class restriction remind you of the user's preferences. The final decision is yours; local business checks must not veto it.

visible_rows supplies click addresses in top-to-bottom order, not an eligibility whitelist. No local servant-level readings or eligibility flags are supplied. Only when a class restriction is configured may local servant/class references be supplied; treat them as references and judge the screenshot yourself. Never invent unclear identities, NP details, or levels. Distinguish servant level from Master/account level.

LOCAL_FACTS.visible_row_count is the number of clickable rows on this screenshot, not the total number in the list. When it is 1, there is only one visible choice on this page: do not compare it with hypothetical candidates or judge its value against a party that was not supplied. Unknown name/NP/skill details alone are not a reason to continue scanning or reject the row. If the row is selectable and there is no explicit blocker, select its row_id.

Use LOCAL_FACTS.scroll_state to decide whether another scan is possible. Continue scanning only when more rows may exist and scrolling is available. After status=stationary, status=unknown, or available=false, do not request another blind swipe; choose a visible row if appropriate, or pause only for a real blocker. A stationary result confirms no movement, not necessarily the total list length; never claim the whole list has one row from a one-row page alone.

Strongly prefer a visible row within the current-stage recommended level range and follow that recommendation as closely as the screenshot allows. The range is not a local eligibility gate: you make the final decision from the screenshot and may choose outside it when the servant's visible value justifies that choice. Local level readings or stage checks must never block your decision. NP level and NP type are soft preferences.

Compare visible rows by class/attribute match, damage, charge, NP role, support effects, and survival using the quest and visible evidence. Evaluate fit against the current party only when LOCAL_FACTS explicitly supplies configured party members; otherwise judge supports without assuming a lineup. Ordinary and guest/NPC supports are both available for your judgment.

Return exactly one JSON object. Actions: select_support, continue_support_scan, refresh_support, auto_formation, pause_for_human. select_support requires a row_id from visible_rows; never invent IDs or coordinates. If you choose to keep searching or the list is loading, return continue_support_scan with arguments={}. You may choose refresh_support or auto_formation based on the screenshot even when local search-stage or refresh preferences disagree. Use pause_for_human for a real blocker needing human input.

{"action":"select_support","arguments":{"row_id":"model_support_row_1"},"confidence":0.9,"reason":"This visible row best matches the supplied evidence and current-stage level recommendation"}

When report_selected_support_identity=true, also transcribe the selected row as optional arguments.support_identity: {name, class}, with visible level, np_level, skill_levels or craft_essence if readable. Never copy another row or guess missing fields. Omit the identity if unreadable and still return the selected row.

{"action":"continue_support_scan","arguments":{},"confidence":0.9,"reason":"Continue searching the current support list"}
