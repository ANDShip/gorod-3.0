extends Node2D

var houses = []
var fields = []
var roads = []
var delete_mode = false


var money = 1000
var wheat = 0


var houses_count = 0
var fields_count = 0


var is_obj_follow_mouse = false
var path_from_worker

var is_all_fields_blinking = false
var going_with_man = false

var all_mans = []
var choosen_man 
var all_obj_names = ["test_house","field","g_house","road","well","market"]
var is_mouse_on_window = false
