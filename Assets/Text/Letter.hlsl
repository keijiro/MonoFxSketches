void Letter_float(float2 uv, float seed, out float output)
{
    uint2 pos = uv * 7;
    bool2 odd = pos & 1;

    bool c = any(odd); // grid lines
    c = c && (JenkinsHash(pos.y * 8 + pos.x + seed * 32) & 1); // random removal
    c = c || all(odd); // border and center points
    c = c && all(pos > 0) && all(pos < 6); // cropping

    bool mask = Hash((uint)seed ^ 0x8147d6eu) < 0.6;

    output = c * mask;
}
