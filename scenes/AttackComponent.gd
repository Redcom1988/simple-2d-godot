extends Node2D

var attack_damage := 10.0
var attack_cd := 0.5

func _on_hitbox_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.attack_position = global_position
		attack.attack_cd = attack_cd
		
		hitbox.damage(attack)
