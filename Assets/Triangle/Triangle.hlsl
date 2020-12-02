void Triangle_float(float2 pos, float scroll, float time, out float output)
{
    float phi = atan2(pos.y, pos.x);
    float seg = frac(phi / (2 * PI) + 0.5 - 0.5 / 6) * 3;

    float theta = (floor(seg) * 2 / 3 + 0.5) * PI;
    float2 dir = float2(-cos(theta), -sin(theta));

    float y = dot(dir, pos);
    float pr = y - scroll;
    float id = floor(pr) - floor(time);

    float th1 = frac( id      / 2) * 2;
    float th2 = frac((id + 1) / 2) * 2;
    float thp = min(1, frac(time) + frac(seg) * 0.2);
    float th = (1 - lerp(th1, th2, smoothstep(0.8, 1.0, thp))) / 2;

    th *= smoothstep(0, 0.25, frac(time));

    output = abs(0.5 - frac(pr)) > th;
}
