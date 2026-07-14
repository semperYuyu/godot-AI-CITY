local InteractableStates = {}

InteractableStates.Idle = {
	Enter = function(self)
		return;
	end;

	Exit = function(self)
		return;
	end;

	Input = function(self, event)
		return;
	end;

	Update = function(self, dt)
		if self.entered then
			self:switchState(InteractableStates.Interactable)
			return;
		end;
		return;
	end;

	Physics_Update = function(self, dt)
		return;
	end;
}

InteractableStates.Interactable = {
	Enter = function(self)
		self.interacted = false
		self.cooldown = 1
		return;
	end;

	Exit = function(self)
		self.interacted = nil;
		return;
	end;

	Input = function(self, event)
		return;
	end;

	Update = function(self, dt)
		if not self.interacted then
			if self.Type == "INTERACT" then
				if Input:is_action_just_pressed("INTERACT") then
					self.Callback()
					self.interacted = true;
				end;
			elseif self.Type == "TOUCH" then
				self.Callback()
				self.interacted = true;
			end
		else
			if self.Destroy then
				self:queue_free()
			elseif not self.entered or self.Type == "INTERACT" then
				self:switchState(InteractableStates.Idle)
			end
		end
		return;
	end;

	Physics_Update = function(self, dt)
		return;
	end;
}

return InteractableStates
