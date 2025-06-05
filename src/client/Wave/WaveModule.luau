--!strict
-- fucked up module 
local RunService = game:GetService("RunService")
local WaveManager = require(script.Parent.WaveManager)
local Plane = game.Workspace:WaitForChild("Plane")

local WaveModule = {
	Running = false :: boolean,
	Plane = Plane :: MeshPart,
	Manager = WaveManager.new(Plane, 10) :: WaveManager.Data,
}

function WaveModule.Start()
	if WaveModule.Running == true then
		return
	end
	RunService:BindToRenderStep("Wave", 0, function()
		WaveModule.Manager:Update(WaveModule.GetPlane())
	end)
end

function WaveModule.Stop()
	if WaveModule.Running == false then
		return
	end
	RunService:UnbindFromRenderStep("Wave")
end

function WaveModule.GetPlane()
	return WaveModule.Plane
end

function WaveModule.SetPlane(plane: MeshPart)
	WaveModule.Plane = plane
end

return WaveModule
