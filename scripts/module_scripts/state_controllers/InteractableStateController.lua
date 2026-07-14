local InteractableStateController = {};
local StateController = require("StateController");
local InteractableStates = require("InteractableStates");

InteractableStateController.new = function(AreaNode, Type, Destroy, Callback)
	if not AreaNode or AreaNode:get_class() ~= "Area3D" then
		error("Interactable .new() takes an Area3D Node as its first parameter");
	elseif Type ~= "INTERACT" and Type ~= "TOUCH" then
		error("Interactable .new() takes either \'INTERACT\' or \'TOUCH\' as second parameter for type of interaction\n\'INTERACT\' = Interact key pressed, \'TOUCH\' = Interact area entered")
	elseif type(Destroy) ~= "boolean" then
		error("Interactable .new() takes a boolean as its third parameter\ntrue - destroy on interact / false - dont destroy on interact")
	elseif not Callback then
		error("Interactable .new() takes a function to be executed on interaction as its fourth parameter");
	end;
	
	AreaNode:connect("body_entered", Callable(function() AreaNode.entered = true end))
	AreaNode:connect("body_exited", Callable(function() AreaNode.entered = false end))
	AreaNode.Type = Type;
	AreaNode.Destroy = Destroy
	AreaNode.Callback = Callback;
	StateController.new(AreaNode, InteractableStates.Idle);
end;

return InteractableStateController;
