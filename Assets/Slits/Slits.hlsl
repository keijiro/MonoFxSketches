#include "Packages/jp.keijiro.noiseshader/Shader/SimplexNoise2D.hlsl"

void Slits_float(float2 position, float threshold, out float output)
{
    output = abs(snoise(position)) < threshold;
}
