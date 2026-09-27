extends SceneTree

var failures := 0
func _initialize() -> void:
	call_deferred("run")
func check(ok: bool, label: String) -> void:
	print("PASS " if ok else "FAIL ", label)
	if not ok:
		failures += 1
func click(control: Control) -> void:
	var pos := control.get_global_rect().get_center()
	for pressed in [true, false]:
		var event := InputEventMouseButton.new()
		event.position = pos
		event.global_position = pos
		event.button_index = MOUSE_BUTTON_LEFT
		event.pressed = pressed
		root.push_input(event, true)
		await process_frame
func run() -> void:
	root.size = Vector2i(1600, 1000)
	var demo: Node = load("res://main.tscn").instantiate()
	root.add_child(demo)
	await process_frame
	await process_frame
	print("INITIAL slider=", demo.brush_size_slider.value, " brush=", demo.brush.width, " eraser=", demo.eraser.width)
	check(demo.brush.width == 64 and demo.eraser.width == 64, "initial brush and eraser match slider")
	check(demo.drawing_canvas.texture == demo.drawable_texture, "canvas shares drawable texture")
	check(demo.cube.get_active_material(0).albedo_texture == demo.drawable_texture and demo.sphere.get_active_material(0).albedo_texture == demo.drawable_texture, "both meshes share canvas texture")
	await click(demo.godot_stamp)
	check(demo.brush_mode == 1, "stamp GUI click selects logo")
	for swatch: ColorRect in demo.color_rects:
		await click(swatch)
		check(demo.brush_mode == 0 and demo.brush.gradient.get_color(0) == swatch.color and demo.brush.gradient.get_color(1).a == 0.0, "swatch GUI click " + swatch.name)
	demo.brush_size_slider.grab_focus()
	for code in [KEY_END, KEY_HOME]:
		for pressed in [true, false]:
			var event := InputEventKey.new()
			event.keycode = code
			event.pressed = pressed
			root.push_input(event, true)
			await process_frame
		var expected := int(demo.brush_size_slider.max_value if code == KEY_END else demo.brush_size_slider.min_value)
		check(demo.brush.width == expected and demo.brush.height == expected and demo.eraser.width == expected and demo.eraser.height == expected, "keyboard brush size " + str(expected))
	var viewport: SubViewport = demo.get_node("HBox/SubViewportContainer/SubViewport")
	for button_name in ["SphereButton", "CubeButton"]:
		var button: Button = viewport.get_node("ButtonsHBox/" + button_name)
		button.grab_focus()
		for pressed in [true, false]:
			var event := InputEventKey.new()
			event.keycode = KEY_ENTER
			event.pressed = pressed
			viewport.push_input(event, true)
			await process_frame
		check(demo.sphere.visible == (button_name == "SphereButton") and demo.cube.visible == (button_name == "CubeButton"), "focused Enter toggles mesh " + button_name)
	print("HEADLESS STATE ONLY; GPU painting, erasing, stamp pixels and films unverified. failures=", failures)
	demo.queue_free()
	await process_frame
	quit(1 if failures else 0)
