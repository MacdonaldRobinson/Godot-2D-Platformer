extends CanvasLayer

func _ready():
	Globals.reset_stats()
	update_health()
	
func update_health():	
	
	var heart = $HealthStat/Heart.duplicate()
	
	for child in $HealthStat.get_children():
		$HealthStat.remove_child(child)
			
	for i in Globals.player_health:
		var node = heart.duplicate()
		node.rect_position.x += 50 * i	
		$HealthStat.add_child(node)		
	
func _process(delta):
	$KillStat/EnemyKillCount.text = String(Globals.enemy_kill_count)	
		
func _on_Player_taking_damage():
	update_health()
