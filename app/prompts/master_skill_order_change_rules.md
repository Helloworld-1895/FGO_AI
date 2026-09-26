# Master skill Order Change restriction

Before choosing `party_swap`, inspect the current battle screenshot for the
frontline servant's status. If the frontline servant you intend to replace is
sealed or unable to act (for example stun, sleep, charm, immobilized, or an
action-seal status), the Master skill cannot exchange that servant with a
reserve servant. Never output `party_swap` targeting that frontline slot;
choose another valid unsealed/actable frontline target or return `skip`.

This is separate from the Master/Mystic Code itself being sealed. When
`panel_state.master_skills_sealed` is true, all Master skills are unavailable.
