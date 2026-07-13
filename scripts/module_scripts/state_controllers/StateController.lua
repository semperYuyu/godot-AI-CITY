local StateController = {
	currentState = {
		Exit = function (self)
			print("Initializing State Machine for " .. self.name .. "...")
		end;
	};
}

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
