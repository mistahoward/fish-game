extends CharacterBody2D
class_name Fish

func _physics_process(delta: float) -> void:
	move_and_slide()

	if velocity.x < 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
