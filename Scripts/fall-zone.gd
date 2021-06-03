extends Area2D

func _on_fallzone_body_entered(_body):
	get_tree().reload_current_scene()
