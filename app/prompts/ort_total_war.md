## ORT total-war strategy (mode-scoped override)

This section applies ONLY when LOCAL_FACTS.ort_total_war.enabled is true
and phase_two=false (form=walking): 第21节第一形态 DATA LOST 总体战.
It overrides generic farming/long-survival strategy, never the phase-specific
JSON schema, action whitelist, eligibility, active_slots, or screenshot facts.

The player explicitly requests ONE servant per sortie. Keep an existing
deployable level > 1 Mash or clearly advantageous servant after confirmation;
opening the roster is not mandatory. When choosing a replacement, Mash is
chosen whenever currently available; prioritize level > 1 currently deployable
servants, preferring counters to the CURRENT enemy class. After a complete scan
finds none, level 1 is allowed as a fallback. Never reject the local selector's
confirmed level-one fallback merely because the servant was not fed EXP.
The optional local_selection setting accepts a favorable current-page optimum
only after confirming level-descending sorting and Mash's unavailability;
otherwise preserve the full scan and Mash priority. Selection is locally owned.
Do not recruit a support, add back-line members, change the party, or propose
feeding EXP. Do not invent a second or third active servant.
The player preconfigures the Craft Essence. Replace the existing first servant
directly; never unload it as a preparatory step. Only extra servants beyond
the one retained slot may be removed. The local selector owns these actions.
If a roster visit is unnecessary, the local selector closes its top-left
Close button and rechecks the original formation before Start. At equal
confirmed affinity, preserving the original avoids pointless replacements.
Roster red-up/blue-down arrows are auxiliary evidence; both may be visible
together. They do not identify a class or an exact attack multiplier. Trust
recognized class relations over a color-only inference.
Prefer the stationary enemy-class display on party confirmation. The roster
header rotates other information, so it must not overwrite that confirmed
reading. Returning to confirmation is a recheck, not an obligation to start:
the local selector may replace the same slot again when clearer evidence
changes affinity, preserving its Craft Essence.
Current facts contain sortie count and current selection, not a persistent
inventory/HP budget. Do not claim a long-term reserve plan, predict the next
random class, or invent remaining bars/available servants from sortie count.
The one servant is actionable whenever the current skill/card phase and local
active_slots confirm it. FGO does not require a separate highlighted turn
owner to use that servant's ready skills; do not request a nonexistent active
slot highlight. Trust ready/eligible skill evidence and actual skill effects.

The objective is maximum useful damage / one break before this servant becomes
DATA LOST. Ordinary servant loss and a break-triggered wipe are expected progress,
not reasons to seek a paid revival, stop after a fixed loss/action count, or
retry a lost servant. Do not reset the total war. Do not use command seals,
Saint Quartz, Leyline Stones, Order Change, or voluntary retreat. The local ORT
workflow owns roster selection, result dismissal and the next sortie.

ORT retains HP across sorties. Its first class is Foreigner; subsequent classes
change randomly AFTER EACH BATTLE. Trust only current screenshot/local enemy
class evidence; never derive the next class from a rotation or prior battle.
Foreigner is especially important: Alter Ego is a full offensive counter with
defensive advantage; Foreigner vs Foreigner is mutual offensive advantage;
Berserker is disadvantaged against Foreigner. Lack of a known enemy class is
uncertainty, not permission to assume Berserker advantage.
在战斗卡面上，WEAK/红色克制提示描述的是这张己方卡对敌人的攻击优势，不是敌人克制己方。Alterego 攻击 Foreigner 有利，Foreigner 攻击 Alterego 不利，不能把方向倒写。名单上的红/蓝箭头还可能同时表达攻防两方向，不能把名单箭头与战斗卡面的 WEAK/RESIST 混为一个字段；按当前已确认的职阶和对应方向复核。

Prefer immediate, useful damage in turns 1–4. On turn 5 or after a break,
analysis forcibly strips active buffs, drains NP/stars, seals skills and makes
further buffs ineffective; ORT gains major damage and invincibility pierce.
Do not plan an imaginary second-bar loop or hoard a ready useful NP for later
waves. Do not treat buff-removal resistance, ordinary invincibility or Guts as
a guaranteed answer to this script. No local code should force-stop at turn 5:
if legal cards remain, keep acting on the real frame until the outcome appears.

ORT 宝具补充：本次 allowed_nps 中 ready=true、无明确禁用且能造成有效伤害的宝具，默认尽早释放，配两张有效普通卡；只有具体可见的伤害阻挡、副作用或更强当前方案才保留。缺精确倍率、relative_power=1.0、普通卡分数更高或场次未知都不足以否决。不要把给玛修防御宝具的取舍推广成所有从者不放宝具。玛修及其他辅助宝具也要按已知增益或能争取的额外输出回合主动比较；不因满槽自动释放，不因非伤害自动忽略。
np_slots.effect_known=false 表示本地身份/效果资料未匹配，不等于宝具无伤害、辅助型或不可用。ready/allowed_nps 由当前充能和封印判断；结合当前宝具卡及可读说明补足作用证据，不要把效果未知编成无效。若舍弃已就绪且有明确收益的宝具，reason 必须指出具体阻挡、副作用或更优当前方案。
奥伯龙宝具会在造成伤害后给敌方无敌；无无敌贯通/解除等对应手段时，应将需要命中的普通卡放在宝具之前，宝具置后，不能默认“宝具先放再补刀”。梦之终结仍须权衡永久睡眠；不因单骑模式自动首回合自封行动，也不因此漏用无此代价的夜之帷幕。

Use batteries to reach a useful NP now, then appropriate damage/crit/card buffs
before the attack they improve. NP drain, buff theft and repeated max-HP loss make slow NP banking unreliable. Defensive
skills are worthwhile when they actually buy another damaging action, not for
indefinite survival. Phase-specific field buffs and effects must be observed,
not assumed to persist across story transitions. This first-form strategy
does not include the second form’s turn-end field HP loss.

Mash: account for the visible anti-Threat-to-Humanity buff, starting/per-turn NP,
crit availability, and the actual form/skill knowledge. Prefer well-supported
Buster critical damage when available; use charge/buffs/defense according to
their real effects. QAB for a Mighty chain or a brave chain can be useful, but
do not hard-code QAB, a skill number, an unobserved star supply or a Mystic Code.
Her NP is defensive, not a damaging NP: do not choose it automatically solely
because NP is full. It can be useful if its actual buffs or survival give more
total damage than attacking immediately. Mash recovers between some sorties;
current deployability is authoritative, never the sortie counter alone.

This mode targets the DATA LOST total-war portions, not the independent final
ORT Xibalba / ORT·希巴尔巴 quest. If evidence contradicts the phase, report it
instead of applying these scripted assumptions to an unrelated boss.
