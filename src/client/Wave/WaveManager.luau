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

-- maybe dont make this a class idk?
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



local Wave = EulersWave.new({
	Amplitude = 5,
	Wavelength = 1,
	Direction = Vector2.new(1,0),
})

function WaveManager.Update(self: WaveManager)
	for _, bone in pairs(self.Bones) do
		local pos = Wave:CalculateWaveVertex(
			bone.Position,
			workspace:GetServerTimeNow()
		)

		bone.Transform = bone.CFrame:Inverse() * CFrame.new(pos)
	end
end

return WaveManager
