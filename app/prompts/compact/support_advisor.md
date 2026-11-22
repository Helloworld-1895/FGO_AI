# Support selection

Read the screenshot yourself. Strongly prefer a row in the current-stage recommended level range and follow it as closely as the screenshot allows. The range is not a local eligibility gate: your screenshot-based judgment controls the action, and you may select outside it when the servant's visible value justifies that choice. Local level/class readings, eligibility checks, search stages, and refresh counters must not veto it. Configured class restriction is a reminder of user preference; the final decision remains yours.

LOCAL_FACTS.visible_rows contains click-address row_ids from top to bottom, not eligible candidates. No local servant-level readings or eligibility flags are supplied. Only with a configured class restriction may local servant/class references be provided. Judge the screenshot yourself; do not invent identity, NP, level, or coordinates. Distinguish servant level from Master level. NP preferences are soft. Consider class match, damage, charge, support effects, and survival using the quest and visible evidence. Compare with configured party members only when LOCAL_FACTS supplies them; otherwise do not assume a lineup. Guest and ordinary rows are both available.

LOCAL_FACTS.visible_row_count counts clickable rows on this screenshot, not the entire list. If it is 1, there is only one visible choice: do not compare hypothetical candidates or judge value against an unsupplied party. Unknown name/NP/skills alone do not justify scanning or rejecting the row. If selectable with no explicit blocker, select its row_id. Check LOCAL_FACTS.scroll_state before continuing: scan only if more rows may exist and scrolling is available. After stationary, unknown, or available=false, do not request another blind swipe; select a visible row when appropriate or pause only for a real blocker. One visible row does not prove the full list has only one row.

Return one JSON object. Actions: select_support (row_id from visible_rows), continue_support_scan (arguments={}), refresh_support, auto_formation, pause_for_human. Continue scanning for loading or when you choose to search further; pause only for an actual blocker needing a human. Refresh and formation remain your decision based on the screenshot.

从者等级只读每行最左侧头像上沿、职阶图标旁的「等级 120/120」，取斜线左侧。玩家名一栏靠右、紧邻「最后登录」的「等级 190」是御主账号等级；蓝色「宝具」栏是宝具等级。两者都不能用于筛选从者等级或填写 support_identity.level。头像等级看不清就省略。confidence 为顶层 0 到 1 的 JSON 数字，不加引号或百分号。

{"action":"select_support","arguments":{"row_id":"model_support_row_1"},"confidence":0.9,"reason":"Best fit from the screenshot within the current-stage recommended level range"}

report_selected_support_identity=true 时，在选中行的 arguments 另带可读的 support_identity={name,class}，可附可读的 level、np_level、skill_levels、craft_essence。只抄当前选中行，字段读不清就省略；姓名或职阶读不清也照常返回 row_id。

{"action":"continue_support_scan","arguments":{},"confidence":0.9,"reason":"Continue searching the current support list"}
