Shader "Custom/shadey"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Width("Width", Float) = 2
        _Height("Height", Float) = 2
        _Time("Time", Float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        float unityTime;
        float greenPow;

        float functionx = 1;
        float functiony = 1;
        float functionz = 1;

        static const float PI = 3.14159265f;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        float _Width;
        float _Height;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            float2 position = IN.uv_MainTex;
            //position = round(position);
            //position /= 200;
            position *= 1.5f + 0.5f * sin(0.1f * unityTime * position.x);
            position *= 2.3f + 1.2f * sin(0.01f * unityTime);
            position /= 5;
            position.x *= 1 + 0.1f * sin(3 * position.y + 0.2f * unityTime);
            //position.x += 0.01f * unityTime;
            position.y *= 1 + 0.2f * sin(5 * position.x + 0.2f * unityTime);
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            functionx = 3 * round(sin(50 * sin(0.01f * unityTime) * position.x) + cos(0.1f * position.y)) / 2;
            functiony = round((cos(50 * sin(0.01f * unityTime) * (position.x - sin(position.y * 50 * sin(0.01f * unityTime))))));
            functionz = pow(cos(50 * sin(0.01f * unityTime) * position.x), 0.5f);

            position *= 300;
            float functionNoise = 2 * sin(unityTime * position.x * position.y);

            o.Albedo = (greenPow * functiony * functionx * (1 + 0.3f * cos(0.03f * unityTime))) * float3(cos(0.1f * unityTime), cos(0.1f * unityTime + PI/3), cos(0.1f * unityTime + 2 * PI / 3)) + (functionNoise) * float3(cos(0.1f * unityTime), cos(0.1f * unityTime + PI / 3), cos(0.1f * unityTime + 2 * PI / 3));
            //o.Albedo = (greenPow * functiony * functionx * (1 + 0.3f * cos(0.03f * unityTime))) * float3(0.5f, 0.5f, 0.5f) + (functionNoise) * float3(0.5f, 0.5f, 0.5f);
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
