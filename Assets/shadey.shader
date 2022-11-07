Shader "Custom/shadey"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Width("Width", Float) = 8
        _Height("Height", Float) = 8
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
            //position *= float2(_Width, _Height);
            //position = round(position);
            //position /= float2(_Width, _Height);
            float x = position[1];
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            float functionx = (0.1f * sin(0.1f * unityTime) + 0.8f) * (pow(sin(25 * (-position.x * position.y + 0.2f * unityTime)), 5 * (sin(unityTime))) + sin(3 * position.x));
            float functionz = (0.1f * cos(0.1f * unityTime) + 0.8f) * (pow(sin(25 * (position.x * position.y + 0.3f * unityTime)), (sin(2 * unityTime))));
            float functiony = pow((pow(functionx,functionz) + 0.3f),greenPow);
            o.Albedo = greenPow * float3(functionx, functiony, functionz);
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
