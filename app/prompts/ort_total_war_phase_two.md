## ORT total-war strategy — phase two / flying form (mode-scoped override)

This section applies ONLY when LOCAL_FACTS.ort_total_war.enabled is true
and phase_two=true (form=flying). The player explicitly selected 第22节飞碟总体战.
Do not load walking-form tactics or infer the form from sortie/turn counts.

### 二阶段独立机制与决策

- 本阶段为第22节 DATA LOST 飞碟／飞行生命体总体战：总计5条、每条120万HP。
  这是整个阶段的资料，不代表当前还剩5条或当前HP仍为120万；当前血条以画面为准。
- 第一形态后半的艾蕾支援不会继承，本阶段回到魔力支援；不得按前一阶段的
  额外伤害、NP回收、星量推演本阶段连发。只计本帧可见／已确认的支援。
- 宇宙线障碍：我方攻击ORT或受到ORT攻击都会使最大HP减少，并加剧效果。
  部分飞碟战有 Galactica Supercell／ギャラクティカ・スーパーセル：生效时每回合结束
  我方全体受到约1800～2200伤害（约2000），同时加剧宇宙线障碍。
  有效回避／无敌可以阻挡这段回合末伤害；宇宙线障碍加剧与最大HP损失另算，
  不能视为被无敌重置。回数制保护还须检查普攻后是否剩余次数覆盖追加伤害。
  不能仅凭飞碟外观认定当前一定有这项被动：Atlas飞碟总体战前两组含此被动，
  后三组未列出；先看本帧状态／已见结算，不用出击数猜当前组别。未知时计入
  风险但不把每回合约2000扣血写成已发生，也不在确认不存在时继续扣算。
- 用当前HP、最大HP、回合末扣血和下一次攻击收益比较续命与立即爆发。治疗
  只能回复当前最大HP之内的可回复部分，不恢复被机制扣掉的最大HP。
- 仍优先尽早兑现有效宝具／克制卡与增伤，不能照搬第一形态低配多回合连发。
  飞碟关卡也有第5回合敌方阶段的解析脚本，并非第一形态专属；据此提前兑现
  第5回合敌方行动前的输出。不凭回合数虚构本帧已解析、NP清零或技能封印，
  也不因尚未到第5回合就忽略场地致死风险。破条后的压制按当前事实判断。
- 敌方另有随当前职阶而异的吸收强化、弱化解除、复制攻击强化、NP吸收等效果，
  按下表形成风险预判，再用当前被动／状态和技能结算校正。
- 玩家仍要求单骑，攻略中允许多人辅助不构成添加第二槽的授权。
- 本开关不适用于 DATA LOST 已解除的第22节进度7（300万HP独立战），
  也不适用于进度8 ORT Xibalba／ORT·希巴尔巴。看见这些证据时报告阶段不符，
  不套用5条120万或从者损失策略；不要自动修改玩家开关。

### 当前职阶对应的被动风险

下列是飞碟总体战的关卡资料，不是本帧已触发的事件。当前职阶已确认即可据表
预判风险；未知职阶不套齐全部被动。概率效果不视为必然触发，当前明确效果优先。

| 被动（日文识别名） | 适用当前敌阶 | 决策含义 |
| --- | --- | --- |
| 强化吸收 ダークマター・プランクトン | 弓／枪／术／狂／降 | 回合末概率吸收我方攻击与防御强化；优先兑现本轮增伤，跨回合保护和增益须重读，不能假定已被偷或必然保留。 |
| 攻击附弱化 エルンスト・ユニオン | 弓／枪／骑／术 | 攻击时附毒、灼伤、诅咒、防御下降、HP回复量下降之一；计入可见持续伤害与防御下降风险，回复量下降影响治疗收益；不凭表格捏造当前弱化。 |
| 回合末自净增攻 パラドックス・キャンセラー | 剑／术／杀／狂／降 | 回合末有弱化时解除自身最多3个弱化，每个成功解除可带来增攻；防御下降可用于当前输出，不能保证降攻／控制跨回合保留，也不因会被解除就一律不放有用弱化。 |
| 强化复制 パラダイム・インフレーション | 剑／弓／枪／骑／杀／降 | 技能触发攻击强化时可复制部分攻击力、暴击威力、宝具威力、特攻等效果给ORT；复制不等于立刻偷走我方增益，亦不等于所有卡色、充能、防御、宝具效果都被复制。 |
| NP吸收 エーテル・ドランカー | 剑／骑／杀／狂 | 每2回合概率吸收我方NP；可用充能凑出本轮有效宝具时尽早兑现，不为了囤到下轮承担掉回释放门槛以下的风险；实际NP与敌充能重新读取，不编必扣数值／固定触发回合。 |

有强化复制／吸收风险不等于禁止从者或御主增伤：比较本轮能兑现的伤害与敌方
增攻后的生存风险，不能为了“不喂buff”一律跳过有效技能。已确认的敌方增攻／
暴击强化要进入防御判断；不把技能图标的猜测当成已验证的免复制白名单。
敌方自净不等于我方御主净化；对方会解除弱化不构成空放伊西斯之雨的理由。

### 充能攻击、加速充能与解析：三个不同威胁

- 充能攻击 ロスト・スーパーノヴァ（Lost Supernova）先解除我方强化，再全体
  攻击，随后施加强化无效（3次／5回合）、NP增加效果量下降和NP获得下降（5回合）。
  无明确有效的强化解除耐性／不可解除保护时，普通可解除无敌／回避会先被剥掉，
  不能把挡场地伤害的结论套给此攻击；不把名义充能值当实际能获得的NP。
- ＰＰチェイン／セブンエーテル是延迟发动的每回合充能至满状态；看见其倒计时
  或已生效状态要缩短输出窗口，不能只按当前空充能条推断还安全数回合。不同
  职阶充能格数也不同，以当前条为准，不统一套5格，不编固定发动时间。
- 飞碟数据的第5回合敌方阶段及破条后有解析／解码／禁用
  アナライズ／デコード／ディセーブル：强制解除强化、削减NP与星、施加不可解除
  的解析结束（强化无效、技能封印、回复／NP／打星能力下降、毅力后HP削减），
  敌方自净并获得对解析结束特攻及无敌贯通。将它作为提前爆发的风险窗口，
  本帧是否已执行仍看当前证据；不要将此解析与充能攻击后的普通可解除弱化混为一谈。
  解析已确认时，不指望普通净化、无敌、减CD或毅力重置机制；继续当前仍合法
  且有收益的攻击，不按第5回合或任意动作数主动停止。
- 飞碟敌人资料为星属性／超巨大／人类威胁，非从者；人类威胁等特攻可按技能
  条件使用，不能因显示职阶／宝具条就套对从者、人型或神性特攻。另有猪化无效，
  不把喀耳刻的猪化当作必能争取一轮的控制；有伤害的宝具仍独立评估。

Mechanics reference (not a live-screen observation):
https://appmedia.jp/fategrandorder/76437520
https://appmedia.jp/fategrandorder/76436533
https://kamigame.jp/fgo/ストーリークエスト/2部7章/22節.html
https://kamigame.jp/fgo/ストーリークエスト/2部7章/コラム-ORT総力戦.html
https://api.atlasacademy.io/nice/JP/quest/3001902/1
https://api.atlasacademy.io/nice/JP/quest/3002308/1
https://api.atlasacademy.io/nice/JP/NP/810
https://api.atlasacademy.io/nice/JP/ai/svt/307810
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

ORT retains HP across sorties. Classes vary between battles; do not assume a new sortie starts as Foreigner. Trust only current screenshot/local enemy
class evidence; never derive the next class from a rotation or prior battle.
Foreigner is especially important: Alter Ego is a full offensive counter with
defensive advantage; Foreigner vs Foreigner is mutual offensive advantage;
Berserker is disadvantaged against Foreigner. Lack of a known enemy class is
uncertainty, not permission to assume Berserker advantage.
在战斗卡面上，WEAK/红色克制提示描述的是这张己方卡对敌人的攻击优势，不是敌人克制己方。Alterego 攻击 Foreigner 有利，Foreigner 攻击 Alterego 不利，不能把方向倒写。名单上的红/蓝箭头还可能同时表达攻防两方向，不能把名单箭头与战斗卡面的 WEAK/RESIST 混为一个字段；按当前已确认的职阶和对应方向复核。

Prefer immediate useful damage before max-HP loss and any active flying-field
damage end this sortie. A break-triggered wipe is expected. Do not plan an imaginary
second-bar loop or hoard a ready useful NP. Judge buff stripping, NP drain,
seals and enemy invincibility pierce from current state/effect evidence,
never by importing the walking-form script. Continue legal useful actions
until the actual result; never force-stop at a fixed turn/action count.

ORT 宝具补充：本次 allowed_nps 中 ready=true、无明确禁用且能造成有效伤害的宝具，默认尽早释放，配两张有效普通卡；只有具体可见的伤害阻挡、副作用或更强当前方案才保留。缺精确倍率、relative_power=1.0、普通卡分数更高或场次未知都不足以否决。不要把给玛修防御宝具的取舍推广成所有从者不放宝具。玛修及其他辅助宝具也要按已知增益或能争取的额外输出回合主动比较；不因满槽自动释放，不因非伤害自动忽略。
np_slots.effect_known=false 表示本地身份/效果资料未匹配，不等于宝具无伤害、辅助型或不可用。ready/allowed_nps 由当前充能和封印判断；结合当前宝具卡及可读说明补足作用证据，不要把效果未知编成无效。若舍弃已就绪且有明确收益的宝具，reason 必须指出具体阻挡、副作用或更优当前方案。
奥伯龙宝具会在造成伤害后给敌方无敌；无无敌贯通/解除等对应手段时，应将需要命中的普通卡放在宝具之前，宝具置后，不能默认“宝具先放再补刀”。梦之终结仍须权衡永久睡眠；不因单骑模式自动首回合自封行动，也不因此漏用无此代价的夜之帷幕。

Use batteries to reach a useful NP now, then appropriate damage/crit/card buffs
before the attack they improve. NP drain, buff theft, repeated max-HP loss and
any active flying field’s turn-end HP loss make slow NP banking unreliable. Defensive
skills are worthwhile when they actually buy another damaging action, not for
indefinite survival. Phase-specific field buffs and effects must be observed,
not assumed to carry over from the first form.
飞碟普攻／暴击可能让万血单骑在首轮退场，不按满HP、低充能或第1回合判安全。
高风险且没有已生效保护时，应尽早考虑当前合法防御，错开从者与御主保护；
不因宇宙线障碍仍存在就放弃能挡普攻与回合末伤害的无敌／回避。

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
