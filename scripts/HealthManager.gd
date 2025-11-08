# HealthManager.gd

extends Node

var max_health := 3
var current_health := max_health
var hearts_node: Node = null

func register_hearts(node: Node):
	hearts_node = node
	print("[HM] register_hearts -> ", hearts_node)
	update_health_ui()

func update_health_ui():
	if hearts_node == null:
		print("[HM] update_health_ui skipped: hearts_node is NULL")
		return
	print("[HM] update_health_ui current_health=", current_health,
		  " children=", hearts_node.get_child_count())
	for i in range(hearts_node.get_child_count()):
		var heart = hearts_node.get_child(i)
		heart.visible = (i < current_health)
		# helpful:
		# print("[HM] heart ", heart.name, " visible=", heart.visible)

func lose_one_heart():
	if current_health > 0:
		current_health -= 1
	print("[HM] lose_one_heart -> current_health=", current_health)
	update_health_ui()
