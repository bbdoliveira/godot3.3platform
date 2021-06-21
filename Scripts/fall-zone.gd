extends Area2D
#warnings-disable
func _on_fallzone_body_entered(_body):
	get_tree().reload_current_scene()
	Global.fruits = 0
