extends CanvasLayer

@onready var level_label = $"Control/Level Label"
@onready var hp_label = $"Control/HP Label"
@onready var mp_label = $"Control/MP Label"
@onready var description_label = $"Control/Description Label"

var isPlayerTurn: bool = false
var rng = RandomNumberGenerator.new()
var enemy: Dictionary

#var tween: Tween

var giant_rat = {
  "name": "giant_rat",
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
	hp_label.text = "HP: " + str(PlayerAttributes.currentHP) + "/" + str(PlayerAttributes.maxHP)
	mp_label.text = "MP: " + str(PlayerAttributes.currentMP) + "/" + str(PlayerAttributes.maxMP)
	
	decideTurnOrder()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_attack_button_pressed():
	#print(giant_rat["attack"])
	attack()
	
func decideTurnOrder():
	var player_speed = getRandNumRange(0.1, PlayerAttributes.speed)
	var enemy_speed = getRandNumRange(0.1, giant_rat.speed)
	if(player_speed > enemy_speed):
		isPlayerTurn = true
	print("players turn?: " + str(isPlayerTurn))
	
func getRandNumRange(percent: float, num: int):
	return rng.randi_range(num - percent*num, num + percent*num)
	
func attack():
	
	var initial_attack_damage: int = PlayerAttributes.attack/2.0 - enemy.defense/4.0
	var final_attack_damage: int = getRandNumRange(0.1, initial_attack_damage)
	enemy.current_hp -= final_attack_damage
	if(enemy.current_hp <= 0):
		textbox_animation("Battle Won!")
		return
	textbox_animation("Player did " + str(final_attack_damage) + " damage!")
	print("attack damage: ", final_attack_damage)
	print("enemy_hp: ", enemy.current_hp)
	
func textbox_animation(text):
	var tween = create_tween()
	description_label.text = text
	description_label.visible_ratio = 0
	tween.tween_property(description_label, "visible_ratio", 1.0, 0.25)
