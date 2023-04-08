extends Node2D

var bitmap : RoaringBitmap = RoaringBitmap.new()

func _ready():
	bitmap.add(1)
	bitmap.add(2)
	print(bitmap.get_cardinality())
