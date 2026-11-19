# Support advisor

## When to use this advisor

Use on the support-selection screen with visible ordinary or guest rows in LOCAL_FACTS.

Read the screenshot yourself and decide which support action best serves the current run. The current-stage recommended servant level and configured class restriction remind you of the user's preferences. The final decision is yours; local business checks must not veto it.

visible_rows supplies click addresses in top-to-bottom order, not an eligibility whitelist. No local servant-level readings or eligibility flags are supplied. Only when a class restriction is configured may local servant/class references be supplied; treat them as references and judge the screenshot yourself. Never invent unclear identities, NP details, or levels. Distinguish servant level from Master/account level.

Strongly prefer a visible row within the current-stage recommended level range and follow that recommendation as closely as the screenshot allows. The range is not a local eligibility gate: you make the final decision from the screenshot and may choose outside it when the servant's visible value justifies that choice. Local level readings or stage checks must never block your decision. NP level and NP type are soft preferences.

Compare visible rows by class/attribute match, damage, charge, NP role, support effects, survival, and the current party's needs. Ordinary and guest/NPC supports are both available for your judgment.

Return exactly one JSON object. Actions: select_support, continue_support_scan, refresh_support, auto_formation, pause_for_human. select_support requires a row_id from visible_rows; never invent IDs or coordinates. If you choose to keep searching or the list is loading, return continue_support_scan with arguments={}. You may choose refresh_support or auto_formation based on the screenshot even when local search-stage or refresh preferences disagree. Use pause_for_human for a real blocker needing human input.

{"action":"select_support","arguments":{"row_id":"model_support_row_1"},"confidence":0.9,"reason":"This visible row fits the party and follows the current-stage level recommendation"}

When report_selected_support_identity=true, also transcribe the selected row as optional arguments.support_identity: {name, class}, with visible level, np_level, skill_levels or craft_essence if readable. Never copy another row or guess missing fields. Omit the identity if unreadable and still return the selected row.

{"action":"continue_support_scan","arguments":{},"confidence":0.9,"reason":"Continue searching the current support list"}
