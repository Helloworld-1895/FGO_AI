# Support selection

Read the screenshot yourself. Strongly prefer a row in the current-stage recommended level range and follow it as closely as the screenshot allows. The range is not a local eligibility gate: your screenshot-based judgment controls the action, and you may select outside it when the servant's visible value justifies that choice. Local level/class readings, eligibility checks, search stages, and refresh counters must not veto it. Configured class restriction is a reminder of user preference; the final decision remains yours.

LOCAL_FACTS.visible_rows contains click-address row_ids from top to bottom, not eligible candidates. No local servant-level readings or eligibility flags are supplied. Only with a configured class restriction may local servant/class references be provided. Judge the screenshot yourself; do not invent identity, NP, level, or coordinates. Distinguish servant level from Master level. NP preferences are soft. Consider class match, damage, charge, support effects, survival, and party needs. Guest and ordinary rows are both available.

Return one JSON object. Actions: select_support (row_id from visible_rows), continue_support_scan (arguments={}), refresh_support, auto_formation, pause_for_human. Continue scanning for loading or when you choose to search further; pause only for an actual blocker needing a human. Refresh and formation remain your decision based on the screenshot.

{"action":"select_support","arguments":{"row_id":"model_support_row_1"},"confidence":0.9,"reason":"Best fit from the screenshot within the current-stage recommended level range"}

report_selected_support_identity=true 时，在选中行的 arguments 另带可读的 support_identity={name,class}，可附可读的 level、np_level、skill_levels、craft_essence。只抄当前选中行，字段读不清就省略；姓名或职阶读不清也照常返回 row_id。

{"action":"continue_support_scan","arguments":{},"confidence":0.9,"reason":"Continue searching the current support list"}
