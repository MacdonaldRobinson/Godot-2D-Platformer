extends CanvasLayer

func _ready():	
	pass
	
func _process(delta):
	$Controls/EnemyKillCount.text = String(Globals.enemy_kill_count)
