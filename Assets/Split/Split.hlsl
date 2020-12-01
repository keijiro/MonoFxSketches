void Split_float(float2 uv, float seed, float threshold, out float output)
{
    // Position & border width
    float4 p = float4(uv, 0.002, 0.002);

    // Area ID (random number seed)
    uint id = seed;

    // Stop switch
    bool stop = false;

    for (uint i = 0; i < 5; i++)
    {
        // Horizontal split
        {
            // Zooming in
            p.xz = frac(p.xz) * (stop ? 1 : 2);
            // ID branching
            id = (id + (p.x > 1)) << 1;
            // Stop randomly
            stop = stop || (Hash(id + 10000) > 0.9 - 0.15 * i);
        }

        // Vertical split
        {
            // Zooming in
            p.yw = frac(p.yw) * (stop ? 1 : 2);
            // ID branching
            id = (id + (p.y > 1)) << 1;
            // Stop randomly
            stop = stop || (Hash(id + 10000) > 0.9 - 0.15 * i);
        }
    }

    p.xy = frac(p.xy);

    // Border mask
    bool mask = all(p.xy > p.zw) && all(p.xy < 1 - p.zw);

    // Random direction
    uint hash = JenkinsHash(id);
    float x = (hash & 1) ? p.x : p.y;
    x = (hash & 2) ? x : 1 - x;

    // Composition
    output = (hash & 4) * (x < threshold) * mask;
}
