local CameraStates = {
	extends = Node,
}

CameraStates.Locked = {
	Enter = function()
		print('camera is lock now')
		return;
	end;

	Exit = function()
		print('camera is unlockin')
		return;
	end;

	Update = function()

	end;

	Physics_Update = function()

	end;
}

CameraStates.Unlocked = {
	Enter = function()
		print('camera is unlock now')
		return;
	end;

	Exit = function()
		print('camera is lockin')
		return;
	end;

	Update = function()

	end;

	Physics_Update = function()

	end;
}

return CameraStates;
