--!strict
export type WaveData = {
    Amplitude: number,
    Phase: number,
    Wavelength: number,
    Direction: Vector2,
}

export type Data = {
    CalculateWaveVertex: (self: Data, vertex2: Vector2, time: number) -> Vector3,
    WaveData: WaveData,
}

type _Data = {}

local EulersWave = {}
EulersWave.__index = EulersWave

type EulersWave = typeof(setmetatable({} :: _Data, EulersWave)) & Data

function EulersWave.new(wavedata: WaveData)
	local self = setmetatable({}, EulersWave) :: EulersWave
	self:constructor(wavedata)
	return self
end

function EulersWave.constructor(self: EulersWave, wavedata)
    self.WaveData = wavedata
end

function EulersWave.GetWaveData(self: EulersWave)
    return self.WaveData
end

function EulersWave.CalculateWaveVertex(self: EulersWave, vertex2: Vector2, time: number)
    local EULERS_CONSTANT = 2.718281828459045
    local vertexPosition = vertex2
    local dotProduct = self.WaveData.Direction.Unit:Dot(vertexPosition)
    local phaseTerm = self.WaveData.Phase * dotProduct + time * self.WaveData.Phase
    local offsetY = self.WaveData.Amplitude * (EULERS_CONSTANT ^ math.sin(phaseTerm) - 1)
    return Vector3.new(vertexPosition.X, offsetY, vertexPosition.Y)
end


return EulersWave
