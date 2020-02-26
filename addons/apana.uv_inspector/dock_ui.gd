tool
extends Control

var editor: EditorInterface

var offset = Vector2(10, 120)
var scale = 400

var uv_index = Mesh.ARRAY_TEX_UV

var color_background = Color.black
var color_line = Color.white

func _draw():
	$Label.text = editor.get_current_path()
	var selected_node = load(editor.get_current_path())
	if (selected_node is ArrayMesh):
		var mesh = selected_node as ArrayMesh
		var arrays = mesh.surface_get_arrays(0)
		
		print(arrays[uv_index].size())
		print(arrays[Mesh.ARRAY_INDEX].size())
			
		draw_rect(Rect2(offset, Vector2(scale, scale)), color_background)
			
		for index in arrays[Mesh.ARRAY_INDEX].size() / 3:
			var i0 = arrays[Mesh.ARRAY_INDEX][index * 3]
			var i1 = arrays[Mesh.ARRAY_INDEX][index * 3 + 1]
			var i2 = arrays[Mesh.ARRAY_INDEX][index * 3 + 2]
			var uv0 = arrays[uv_index][i0] * scale
			var uv1 = arrays[uv_index][i1] * scale
			var uv2 = arrays[uv_index][i2] * scale
			
			draw_line(uv0 + offset, uv1 + offset, color_line)
			draw_line(uv1 + offset, uv2 + offset, color_line)
			draw_line(uv0 + offset, uv2 + offset, color_line)
			
		$Label.text += " [ArrayMesh]"
	else:
		$Label.text += " (not an ArrayMesh)"
		
func render_uv_0():
	uv_index = Mesh.ARRAY_TEX_UV
	update()
	
func render_uv_1():
	uv_index = Mesh.ARRAY_TEX_UV2
	update()
