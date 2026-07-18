local interact_area = {
	extends = Area3D,
}

function interact_area:_ready()
	local InteractableStateController = require("InteractableStateController")
	local InteractableFunctions = require("InteractableFunctions")
	local first = {"house", "...", ":D"}
	local second = {"meow meow meow"}
	InteractableStateController.new(self, "INTERACT", false, function() InteractableFunctions.spawnTextBox(first, second) end)
end;

function interact_area:_input(event)
	self:input(event)
end

function interact_area:_process(dt)
	self:process(dt)
end

function interact_area:_physics_process(dt)
	self:physics_process(dt)
end

return interact_area;
