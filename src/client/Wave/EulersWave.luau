--!strict

export type WaveData = {
    Amplitude: number,
    Speed: number,
    Wavelength: number,
    Direction: Vector2,
}

export type Data = {
    CalculateWaveVertex: (self: Data, vertex2: Vector2, time: number) -> Vector3,
    GetWaveData: (self: Data) -> WaveData,
    SetWaveData: (self: Data, wavedata: WaveData) -> (),
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

function EulersWave.SetWaveData(self: EulersWave, wavedata)
    self.WaveData = wavedata
end

function EulersWave.CalculateWaveVertex(self: EulersWave, vertex2: Vector2, time: number)
    local EULERS_CONSTANT = 2.718281828459045
    local vertexPosition = vertex2
    local k = 2 * math.pi / self.WaveData.Wavelength
    local c = math.sqrt(9.8 / k)
    local d = self.WaveData.Direction.Unit:Dot(vertexPosition)
    return self.WaveData.Amplitude * EULERS_CONSTANT ^ math.sin(k * d - c * time) - 1
end


return EulersWave