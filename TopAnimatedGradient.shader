Shader "Custom/TopAnimatedGradient"
{
    Properties
    {
        _ColorTop ("Top Color", Color) = (0,0,0,0)
        _ColorBottom ("Bottom Color", Color) = (0,0,0,0)
        _Speed ("Transition Speed", Float) = 1.0
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 100

        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            fixed4 _ColorTop;
            fixed4 _ColorBottom;
            float _Speed;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float transition = (sin(_Time.y * _Speed) + 1.0) / 2.0;
                fixed4 colorGradient = lerp(_ColorBottom, _ColorTop, i.uv.y);
                return lerp(_ColorBottom, colorGradient, transition);
            }
            
            ENDCG
        }
    }
}