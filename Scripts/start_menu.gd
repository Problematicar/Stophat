extends Node2D

# Variables
var background_music: AudioStreamPlayer2D
var sound: AudioStreamPlayer2D
var background: Sprite2D
var texture1: Texture
var texture2: Texture
var play_label: Label
var quit_label: Label
var fade: AnimationPlayer
var is_animation_playing: bool
var fade_white: ColorRect
var fade_black: ColorRect

# Initialize variables
func _ready():
	background_music = $Sound/BackgroundMusic
	sound = $Sound/SoundEffect
	sound.stop()
	background = $Background
	texture1 = load("res://Images/Backgrounds/Menu/bk_title.png") 
	texture2 = load("res://Images/Backgrounds/Menu/bk_title1.png")
	play_label = $UI/Play
	quit_label = $UI/Exit
	fade_white = $UI/FadeWhite
	fade_black = $UI/FadeBlack 
	fade = $UI/FadePlayer
	fade.play("fade_out_white")
	is_animation_playing = true

# Main loop
func _process(_delta):
	# Play background music if not playing
	if !background_music.playing:
		background_music.play()
	# Adjust volume based on fade color
	var volume = -20 * max(fade_white.get_color().a, fade_black.get_color().a)
	background_music.set_volume_db(volume)
	# Check for input
	if !is_animation_playing:
		if Input.is_action_just_pressed("_left"):
			change_background(texture1, play_label, quit_label)
		elif Input.is_action_just_pressed("_right"):
			change_background(texture2, quit_label, play_label)
		elif Input.is_action_just_pressed("_down"):
			fade_animation()

# Play sound effect with random pitch
func play_sound_effect():
	sound.pitch_scale = randf_range(0.8, 1.2)
	if sound.playing:
		sound.stop()
	sound.play()

# Change background texture and label visibility
func change_background(texture: Texture, labelToShow: Label, labelToHide: Label):
	play_sound_effect()
	background.texture = texture
	labelToShow.show()
	labelToHide.hide()

# Start fade animation based on background texture
func fade_animation():
	if background.texture == texture1:
		fade.play("fade_in_white")
	elif background.texture == texture2:
		fade.play("fade_in_black")
	is_animation_playing = true

# Handle animation completion
func _on_animation_player_animation_finished(anim_name):
	is_animation_playing = false
	match anim_name:
		"fade_in_white":
			get_tree().change_scene_to_file("res://Scenes/Elevator.tscn")
		"fade_in_black":
			get_tree().quit()
