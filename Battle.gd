extends CanvasLayer

@onready var level_label = $"Control/Level Label"
@onready var hp_label = $"Control/HP Label"
@onready var mp_label = $"Control/MP Label"
@onready var description_label = $"Control/Description Label"
@onready var attack_button = $"Control/Attack Button"
@onready var magic_button = $"Control/Magic Button"
@onready var item_button = $"Control/Item Button"
@onready var run_button = $"Control/Run Button"

var isPlayerTurn: bool = false
var rng = RandomNumberGenerator.new()
var enemy: Dictionary

#var tween: Tween

var giant_rat = {
  "name": "Giant Rat",
  "attack": 10,
  "defense": 10,
  "speed": 10,
  "max_hp": 5,
  "current_hp": 5,
  "max_mp": 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy = giant_rat
	level_label.text = "Level: " + str(PlayerAttributes.level)
	hp_label.text = "HP: " + str(PlayerAttributes.current_hp) + "/" + str(PlayerAttributes.max_hp)
	mp_label.text = "MP: " + str(PlayerAttributes.current_mp) + "/" + str(PlayerAttributes.max_mp)
	textbox_animation(str(enemy.name) + " appears!")
	
	decideTurnOrder()
	if(not isPlayerTurn):
		enemy_attack()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_attack_button_pressed():
	attack()
	
func decideTurnOrder():
	var player_speed = getRandNumRange(0.1, PlayerAttributes.speed)
	var enemy_speed = getRandNumRange(0.1, giant_rat.speed)
	if(player_speed > enemy_speed):
		isPlayerTurn = true
	
func getRandNumRange(percent: float, num: int):
	return rng.randi_range(num - percent*num, num + percent*num)
	
func attack():
	setButtonsDisabled(true)
	var initial_attack_damage: int = PlayerAttributes.attack/2.0 - enemy.defense/4.0
	var final_attack_damage: int = getRandNumRange(0.1, initial_attack_damage)
	enemy.current_hp -= final_attack_damage
	if(enemy.current_hp <= 0):
		textbox_animation(str(enemy.name) + " is defeated!\n" + "Battle Won!")
		setButtonsDisabled(true)
		return
	textbox_animation("Player Attacks!\n" + "Player did " + str(final_attack_damage) + " damage!")
	await get_tree().create_timer(2).timeout
	enemy_attack()

func enemy_attack():
	setButtonsDisabled(true)
	var initial_attack_damage: int = enemy.attack/2.0 - PlayerAttributes.defense/4.0
	var final_attack_damage: int = getRandNumRange(0.1, initial_attack_damage)
	PlayerAttributes.current_hp -= final_attack_damage
	hp_label.text = "HP: " + str(PlayerAttributes.current_hp) + "/" + str(PlayerAttributes.max_hp)
	if(PlayerAttributes.current_hp <= 0):
		textbox_animation("Battle Lost!")
		return
	textbox_animation(str(enemy.name) + " Attacks!\n" + str(enemy.name) + " did " + str(final_attack_damage) + " damage!")
	await get_tree().create_timer(2).timeout
	setButtonsDisabled(false)
	
func textbox_animation(text):
	var tween = create_tween()
	description_label.text = text
	description_label.visible_ratio = 0
	tween.tween_property(description_label, "visible_ratio", 1.0, 0.25)
	
func setButtonsDisabled(boolVar):
	attack_button.disabled = boolVar
	magic_button.disabled = boolVar
	item_button.disabled = boolVar
	run_button.disabled = boolVar
