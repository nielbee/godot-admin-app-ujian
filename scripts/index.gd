extends Control

@onready var registrasiScreen := preload("res://registrasi.tscn")
@onready var dialog := preload("res://resources/dialog/ujianappadmin.dialogue")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$HTTPRequest.request(UjianApp.BASE_URL+"login",UjianApp.header,HTTPClient.METHOD_POST,JSON.stringify(
		{
			"npsn":$CanvasLayer/Panel/VBoxContainer/TextEdit.text,
			"password":$CanvasLayer/Panel/VBoxContainer/TextEdit2.text
		}
	))

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var response_data = JSON.parse_string(body.get_string_from_utf8())
	#print(response_data)

	
	if response_code==0 or result == HTTPRequest.RESULT_TIMEOUT:
		DialogueManager.show_dialogue_balloon(dialog,"serverTimeout")
		return
	else :
		if response_code == 200:
			UjianApp.header.append("Authorization: Bearer "+response_data.access_token)
			print(UjianApp.header)
		else:
			DialogueManager.show_dialogue_balloon(dialog,"ErrorLogin")
	


func _on_registrasi_button_pressed() -> void:
	get_tree().change_scene_to_packed(registrasiScreen)
