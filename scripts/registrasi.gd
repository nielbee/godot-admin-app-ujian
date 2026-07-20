extends Control

@onready var indexScreen := preload("res://index.tscn")
@onready var dialog :=preload("res://resources/dialog/ujianappadmin.dialogue")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_registrasi_button_pressed() -> void:
	$HTTPRequest.request(UjianApp.BASE_URL+'user/register',UjianApp.header,HTTPClient.METHOD_POST,JSON.stringify({
		"name":$Control/Panel/VBoxContainer/TextEditNama.text,
		"npsn": $Control/Panel/VBoxContainer/TextEditNPSN.text,
		"email": $Control/Panel/VBoxContainer/TextEditEmail.text,
		"password": $Control/Panel/VBoxContainer/TextEditPass.text
	}))


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result == HTTPRequest.RESULT_TIMEOUT:
		DialogueManager.show_dialogue_balloon(dialog,"serverTimeout")
	else:
		print(body.get_string_from_utf8())
		
		if response_code == 200:
			DialogueManager.show_dialogue_balloon(dialog,"SuccessRegister")
			var resDictionary = JSON.parse_string(body.get_string_from_utf8())
		elif response_code==0:
			DialogueManager.show_dialogue_balloon(dialog,"serverTimeout")
		else:
			DialogueManager.show_dialogue_balloon(dialog,"ErrorRegister")


func _on_button_keluar_pressed() -> void:
	get_tree().change_scene_to_file("res://index.tscn")
