extends "PureStatus.gd"

export (int, 0, 100) var chance:int = 100

func notify(fighter, id:String, args):
	if id == "round_ending" and status_effects.size() > 0:
		if effect_chance_succeeds(fighter, chance):
			var order = BattleOrder.new(fighter, BattleOrder.OrderType.FIGHT, self, {})
			fighter.battle.queue_turn_action(order)
	return .notify(fighter, id, args)

func apply_statuses(user, target, attack_params = {}):
	assert (status_effects.size() > 0)
	for effect in target.status.get_effects():
		if effect.effect.is_removable:
			if effect.effect.is_buff:
				target.status.remove_child(effect)
				effect.queue_free()
			if effect.effect.is_debuff:
				target.status.remove_child(effect)
				effect.queue_free()
		
	.apply_statuses(user, target, attack_params)
