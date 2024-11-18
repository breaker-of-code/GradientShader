Shader "Custom/SimpleGradient"
{
    Properties
    {
        _ColorTop ("Top Color", Color) = (1, 0, 0, 1)
        _ColorBottom ("Bottom Color", Color) = (0, 0, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            fixed4 _ColorTop;
            fixed4 _ColorBottom;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Interpolate between top and bottom colors based on the y-coordinate
                return lerp(_ColorBottom, _ColorTop, i.uv.y);
            }
            
            ENDCG
        }
    }
}
