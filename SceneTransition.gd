extends CanvasLayer

func change_scene_to_file(target: String) -> void:
	$AnimationPlayer.play('bar_slide')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards('bar_slide')

func transition_func(to_run) -> void:
	$AnimationPlayer.play('square_expand')
	await $AnimationPlayer.animation_finished
	to_run.call()
	$AnimationPlayer.play_backwards('square_expand')
