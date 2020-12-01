Shader "Flame/Update"
{
    Properties
    {
        _BPM("BPM", Float) = 128
    }

    CGINCLUDE

    #include "UnityCustomRenderTexture.cginc"
    #include "Packages/jp.keijiro.noiseshader/Shader/SimplexNoise3D.hlsl"

    float _BPM;

    float4 Fragment
      (float4 vertex : SV_POSITION,
       float2 uv : TEXCOORD0) : SV_Target
    {
        // Beat synched progress value
        float time = _Time.y;
        float beat = time * _BPM / 60;

        // Ellipse
        float l = length((uv - 0.5) * 2);
        float r = 0.4 * smoothstep(0, 1, 1 - frac(beat));

        // Displacement
        float3 np = float3(uv * 5, time * 0.7);
        float phi = snoise(np) * 6;
        float2 disp = float2(cos(phi), sin(phi)) * 0.01;

        // Advection + displacement
        float2 uv2 = (uv - 0.5) * 0.95 + 0.5 + disp;

        // Feedback and composition
        float decay = 0.92;
        float mask = beat >= 1;
        return (tex2D(_SelfTexture2D, uv2).x * decay + (l < r)) * mask;
    }

    ENDCG

    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        Pass
        {
            Name "Update"
            CGPROGRAM
            #pragma vertex CustomRenderTextureVertexShader
            #pragma fragment Fragment
            ENDCG
        }
    }
}
