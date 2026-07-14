local StateController = {
	currentState = {
		Exit = function (self)
			if not self.name then self.name = "<<Unknown>>" end;
			print("Initializing State Machine for " .. self.name .. "...")
		end;
	};
}

StateController.new = function(Node, defaultState)
	Node.currentState = StateController.currentState;
	Node.switchState = StateController.switchState;
	Node.process = StateController.process;
	Node.physics_process = StateController.physics_process;
	Node.input = StateController.input;
  Node:switchState(defaultState);
end;

StateController.switchState = function (self, state)
	self.currentState.Exit(self)
	self.currentState = state;
	self.currentState.Enter(self);
end;

StateController.process = function (self, dt)
	self.currentState.Update(self, dt);
end;

StateController.physics_process = function (self, dt)
	self.currentState.Physics_Update(self, dt);
end;

StateController.input = function (self, event)
	self.currentState.Input(self, event);
end;

return StateController;
