void Hexagon_float(float2 pos, float scroll, float time, out float output)
{
    float phi = atan2(pos.y, pos.x) / (2 * PI) + 0.5;
    float seg = floor(phi * 6);

    float theta = (seg + 0.5) / 6 * PI * 2;
    float2 dir1 = float2(cos(theta), sin(theta));
    float2 dir2 = float2(-dir1.y, dir1.x);

    float l = dot(dir1, pos);
    float w = sin(seg * 31.374) * 18 + 20;
    float prog = l / w + scroll;
    float idx = floor(prog);

    float th1 = frac(273.84937 * sin(idx * 54.67458 + floor(time    )));
    float th2 = frac(273.84937 * sin(idx * 54.67458 + floor(time + 1)));
    float thresh = lerp(th1, th2, smoothstep(0.75, 1, frac(time)));

    float l2 = dot(dir2, pos);
    float slide = frac(idx * 32.74853) * 50 * scroll;
    float w2 = frac(idx * 39.721784) * 500;
    float prog2 = (l2 + slide) / w2;

    float th3 = lerp(0.2, 1, smoothstep(frac(0.5 + time * 2), 0, 0.2));
    output = frac(prog) > min(thresh, th3);
    output *= frac(prog2) > min(1 - thresh, th3);
    return;

    float c = saturate((frac(prog) - thresh) * w * 0.3);
    c *= saturate((frac(prog2) - 1 + thresh) * w2 * 0.3);

    output = c;
}
