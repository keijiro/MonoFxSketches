void Noise_float(float2 pos, float time, out float output)
{
    uint seed = 1000 * (uint)pos.y + (uint)pos.x + (uint)(time * 28917743);
    output = Hash(seed);
}
