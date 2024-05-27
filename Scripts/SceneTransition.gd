extends CanvasLayer

func change_scene_to_file(target: String, transition_type: String = 'bar_slide') -> void:
	$AnimationPlayer.play(transition_type)
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards(transition_type)

func transition_func(to_run) -> void:
	$AnimationPlayer.play('chevron')
	await $AnimationPlayer.animation_finished
	to_run.call()
	$AnimationPlayer.play_backwards('chevron')
