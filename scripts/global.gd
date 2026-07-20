extends Node


const BASE_URL = 'http://127.0.0.1:8000/api/'
@onready var header := ["Content-Type: application/json"]
@onready var tokenBearer : = ""



@onready var audioPlayer := AudioStreamPlayer.new()
@onready var clickedSoundEffect :=preload("res://assets/soundreality-snap-sound-423219.mp3")

func _ready() -> void:
	add_child(audioPlayer)
	audioPlayer.stream = clickedSoundEffect

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		audioPlayer.play()
