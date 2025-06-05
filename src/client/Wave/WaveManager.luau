--!strict
local EulersWave = require(script.Parent.EulersWave)

export type Data = {
	Update: (self: Data, plane: MeshPart) -> (),
	Plane: MeshPart,
	Bones: { Bone },
}

type _Data = {}

local WaveManager = {}
WaveManager.__index = WaveManager

type WaveManager = typeof(setmetatable({} :: _Data, WaveManager)) & Data

function WaveManager.new(plane: MeshPart, octaves: number)
	local self = setmetatable({}, WaveManager) :: WaveManager
	self:constructor(plane, octaves)
	return self
end

function WaveManager.constructor(self: WaveManager, plane, octaves)
	self.Plane = plane
	self.Bones = {}
	for _, bone in pairs(self.Plane:GetDescendants()) do
		if bone:IsA("Bone") then
			table.insert(self.Bones, bone)
		end
	end
end

function WaveManager.Update(self: WaveManager)
	local Wave = EulersWave.new({
		Amplitude = 5,
		Phase = 1,
		Wavelength = 2,
		Direction = Vector2.new(1, 1),
	})

	for _, bone in pairs(self.Bones) do
		if bone:IsA("Bone") then
            local vertex2 = Vector2.new(bone.Position.X, bone.Position.Z)
            bone.Position = Wave:CalculateWaveVertex(vertex2, game.Workspace:GetServerTimeNow())
		end
	end
end

return WaveManager
