extends Node

@export_subgroup('Static Layer Objects', 'SLO')
@export var SLO_VersionLabel : Label

@export_subgroup('Animated Layer Objects', 'ALO')
@export var ALO_CharacterRing : Node2D

@export_subgroup('AnimationPlayers', 'AP')
@export var AP_Intro : AnimationPlayer

# States
# 0 - intro
# 1 - flash
# 2 - finished
var state : int = 0
var state_running : bool = false

func _ready():
	if Title.COMPLETED_INTRO:
		state = 2
	
	if SLO_VersionLabel:
		SLO_VersionLabel.text = 'Sinco and Portilizen v'+ProjectSettings.get_setting("application/config/version")
		SLO_VersionLabel.text += '\nRunning on Godot Engine '+Engine.get_version_info().string
	
	if AP_Intro: if not AP_Intro.animation_finished.is_connected(AP_IntroFinished): AP_Intro.animation_finished.connect(AP_IntroFinished)
	else: state = 2

func _process(_delta):
	if not state_running and state < 2:
		process_state(state)
	

func process_state(state : int = 0):
	if state == 0:
		if AP_Intro: AP_Intro.play('intro')
	elif state == 1:
		if AP_Intro: AP_Intro.play('flash')
	else:
		if AP_Intro: AP_Intro.play('RESET')
	

func AP_IntroFinished(anim_name):
	match anim_name:
		'intro': state = 1
		'flash': state = 2
