local StateController = {
	currentState = {
		Exit = function (self)
			print("Initializing State Machine...")
		end;
	}
}

StateController.new = function (Node, defaultState)
	if not defaultState then
		error(".new() function needs a state passed as second parameter as a default\n.new(Node, State)")
	end;
	Node.currentState = StateController.currentState;
	Node.switchState = StateController.switchState;
	Node.process = StateController.process;
	Node.physics_process = StateController.physics_process;
	Node:switchState(defaultState);
end;

StateController.switchState = function (self, state)
	print('switching states')
	self.currentState.Exit(self)
	self.currentState = state;
	self.currentState.Enter(self);
end;

StateController.process = function (self, dt)
	self.currentState.Update(self, dt)
end;

StateController.physics_process = function (self, dt)
	self.currentState.Physics_Update(self, dt)
end;

return StateController;
