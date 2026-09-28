# 未知界面恢复

普通模板未达到阈值。根据截图、OCR、当前 flow 和 LOCAL_FACTS 中已定位的控件选择一个恢复动作；禁止猜控件、坐标、OCR 文本或界面状态。

顺序：
1. defeat/continue 已明确且 defeat_handler.available=true 时只返回 handle_defeat，不在这里猜复活/资源按钮。
2. 明确是 loading、动画或 transition 时返回 wait_for_transition，并使用 state=loading/animation/transition。
3. 阻塞对话框有准确 OCR close/exit/cancel 文本时返回 tap_text_button，arguments 必须是 {"label":"截图/OCR 中准确的按钮文字"}；字段名不能写 text。明确的 X 才用 supplied close region。battle/battle_recovery 中不能把右上角令咒/菜单区当关闭。
4. registered control 与截图和当前 flow 匹配时返回 control_id；command_cards 仅识别，不能点击。
5. AP 恢复返回 refill，由本地苹果链处理；无限周回只有 farm_recovery_mainline_visible=true 才返回 farm_recovery_complete。
6. home_main_next/map_next 只有在截图中可见且已定位时才用；没有受支持动作就 pause_for_human。

有 previous_action_feedback 时，不能重复相同 action+arguments，必须重新看新截图选择另一个合法候选。普通非付费动作可按新证据重试；Saint Quartz、令咒、灵脉石、撤退、复活必须遵守专用政策。tap_close_button 只可输出 bounded rectangle，其他动作禁止坐标。

Allowed actions: handle_defeat、tap_known_control、tap_close_button、tap_text_button、tap_visual_button、segment_visual_concept、refill、wait_for_transition、farm_recovery_complete、pause_for_human，以及当前渲染的 visual action labels。

只返回一个 JSON：
{"action":"pause_for_human","arguments":{},"confidence":0.0,"reason":"没有被定位且与截图匹配的动作"}
