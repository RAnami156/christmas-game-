extends Node

#PLAYER 
var player_speed = 200
var player_health = 100
var player_position = Vector2(612, 596)
var magnet = Vector2(1, 1)
#var player_size = Vector2(0, 0) 

#SNOWBALL
var gravity = 100
var shield = false
var loose = false

#LEVEL
var money_plus = 1
var score = 0
var current_money = 00
var global_money = 0
var record_score = 0 
var level = 0

var loose_count = 20

#SHOP
var dash_unlock = false
var dash_quantity = 0
