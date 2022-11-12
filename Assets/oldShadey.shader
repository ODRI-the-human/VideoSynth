Shader "Custom/shadey"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0
        _Width("Width", Float) = 2
        _Height("Height", Float) = 2
        _unityTime("Time", Float) = 0

        _sin1XMult("sin1XMult", Int) = 1
        _sin1XMultAmt("sin1XMultAmt", Float) = 20.1

        _sin1YMult("sin1YMult", Int) = 0
        _sin1YMultAmt("sin1YMultAmt", Float) = 20.1

        _sin1TimeMult("sin1TimeMult", Int) = 0
        _sin1TimeMultAmt("sin1TimeMultAmt", Float) = 20.1

        _sin1FreqMult("sin1FreqMult", Float) = 1
        _sin1Amp("sin1Amp", Float) = 1
        _sin1Add("sin1Add", Float) = 1

        _sin1Math1Op("sin1Math1Op", Int) = 0
        _sin1Math1Other("sin1Math1Other", Int) = 0

        _sin1Math2Op("sin1Math2Op", Int) = 0
        _sin1Math2Other("sin1Math2Other", Int) = 0

        _sin1Math3Op("sin1Math3Op", Int) = 0
        _sin1Math3Other("sin1Math3Other", Int) = 0

        _sin1Math1Factor("sin1Math1Factor", Float) = 1
        _sin1Math2Factor("sin1Math2Factor", Float) = 1
        _sin1Math2Factor("sin1Math3Factor", Float) = 1

        _sin1Math1Invert("sin1Math1Invert", Int) = 0
        _sin1Math2Invert("sin1Math2Invert", Int) = 0
        _sin1Math3Invert("sin1Math3Invert", Int) = 0
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

        static const float PI = 3.14159265f;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        float _Width = 5;
        float _Height;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        // ORIGINAL CODE:
        //position = round(position);
        //position /= 200;
        //position *= 1.5f + 0.5f * sin(0.1f * unityTime * position.x);
        //position *= 2.3f + 1.2f * sin(0.01f * unityTime);
        //position /= 5;
        //position.x *= 1 + 0.1f * sin(3 * position.y + 0.2f * unityTime);
        //position.x += 0.01f * unityTime;
        //position.y *= 1 + 0.2f * sin(5 * position.x + 0.2f * unityTime);
        //fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
        //functionx = 3 * round(sin(50 * sin(0.01f * unityTime) * position.x) + cos(0.1f * position.y)) / 2;
        //functiony = round((cos(50 * sin(0.01f * unityTime) * (position.x - sin(position.y * 50 * sin(0.01f * unityTime))))));
        //functionz = pow(cos(50 * sin(0.01f * unityTime) * position.x), 0.5f);
        //float functionNoise = 2 * sin(unityTime * position.x * position.y);
        //o.Albedo = (greenPow * functiony * functionx * (1 + 0.3f * cos(0.03f * unityTime))) * float3(cos(0.1f * unityTime), cos(0.1f * unityTime + PI / 3), cos(0.1f * unityTime + 2 * PI / 3)) + (0.5f * functionNoise) * float3(cos(0.1f * unityTime), cos(0.1f * unityTime + PI / 3), cos(0.1f * unityTime + 2 * PI / 3));

        int sin1XMult = 1; // tick box.
        float sin1XMultAmt = 1.5f; // slider

        int sin1YMult = 1; // tick box.
        float sin1YMultAmt = 1.5f; // slider

        int sin1TimeMult = 0; // tick box
        float sin1TimeMultAmt = 1.5f; // slider

        float sin1FreqMult = 1; // slider
        float sin1Amp = 1; // slider.
        float sin1Add = 1; // slider

        int sin1Math1Op = 0; // needs select box.
        int sin1Math1Other = 0; // select box.

        int sin1Math2Op = 0; // select box.
        int sin1Math2Other = 0; // select box.

        int sin1Math3Op = 0; // select box.
        int sin1Math3Other = 0; // select box.

        float sin1Math1Factor = 1;
        float sin1Math2Factor = 1;
        float sin1Math3Factor = 1;

        int sin1Math1Invert = 0;
        int sin1Math2Invert = 0;
        int sin1Math3Invert = 0;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 position = IN.uv_MainTex;

            float sin1Math1Amt = 1; // slider.
            float sin1Math2Amt = 1; // slider.
            float sin1Math3Amt = 1; // slider.

            bool useSin1 = true;
            float Rval = 1;
            float Gval = 1;
            float Bval = 1;

            float sin1Val = 1; // 1 by default, doesn't need slider (gets overridden if sin1 is active)

            float sin1InBracketVal = 1; // 1 by default, doesn't need slider.

            if (useSin1)
            {
                if (sin1XMult == 1)
                {
                    sin1InBracketVal = sin1InBracketVal + sin1XMultAmt * position.x;
                }
                if (sin1YMult)
                {
                    sin1InBracketVal = sin1InBracketVal + sin1YMultAmt * position.y;
                }
                if (sin1TimeMult)
                {
                    sin1InBracketVal = sin1InBracketVal + sin1TimeMultAmt * unityTime;
                }

                sin1Val = sin1Amp * sin(sin1InBracketVal * sin1FreqMult) + sin1Add;

                if (sin1Math1Other != 0)
                {
                    switch (sin1Math1Other)
                    {
                    case 1: // x
                        sin1Math1Amt = position.x;
                        break;
                    case 2: // y
                        sin1Math1Amt = position.y;
                        break;
                    case 3: // sin(time)
                        sin1Math1Amt = 0.5f * sin(unityTime) + 0.5f;
                        break;
                    case 4: // sin(x)
                        sin1Math1Amt = 0.5f * sin(position.x) + 0.5f;
                        break;
                    case 5: // sin(x * unityTime)
                        sin1Math1Amt = 0.5f * sin(position.x * unityTime) + 0.5f;
                        break;
                    case 6: // sin(y)
                        sin1Math1Amt = 1 - 0.5f * sin(position.y) + 0.5f;
                        break;
                    case 7: // sin(y * unityTime)
                        sin1Math1Amt = 1 - 0.5f * sin(position.y * unityTime) + 0.5f;
                        break;
                    case 8: // sin(x * y)
                        sin1Math1Amt = 0.5f * sin(position.x * position.y) + 0.5f;
                        break;
                    case 9: // sin(x * y * unityTime)
                        sin1Math1Amt = 0.5f * sin(position.x * position.y) + 0.5f;
                        break;
                    case 10: // sin(y) * sin(x)
                        sin1Math1Amt = 0.5f * (sin(position.x) * sin(position.y)) + 0.5f;
                        break;
                    case 11: // sin(y) * sin(x) * sin(time)
                        sin1Math1Amt = 0.5f * (sin(position.x) * sin(position.y) * sin(unityTime)) + 0.5f;
                        break;
                    }
                }

                if (sin1Math1Invert == 1)
                {
                    sin1Math1Amt = 1 - sin1Math1Amt;
                }

                switch (sin1Math1Op)
                {
                case 0: // noffin
                    break;
                case 1: // Add
                    sin1Val = sin1Val + sin1Math1Amt * sin1Math1Factor;
                    break;
                case 2: // subtract
                    sin1Val = sin1Val - sin1Math1Amt * sin1Math1Factor;
                    break;
                case 3: // mult
                    sin1Val = sin1Val * sin1Math1Amt * sin1Math1Factor;
                    break;
                case 4: // div
                    sin1Val = sin1Val / (sin1Math1Amt * sin1Math1Factor);
                    break;
                case 5: // power
                    sin1Val = pow(sin1Val, sin1Math1Amt * sin1Math1Factor);
                    break;
                case 6: // reciprocal power
                    sin1Val = pow(sin1Val, 1 / (sin1Math1Amt * sin1Math1Factor));
                    break;
                case 7: // other power
                    sin1Val = pow(sin1Math1Amt * sin1Math1Factor, sin1Val);
                    break;
                case 8: // other reciprocal power
                    sin1Val = pow(sin1Math1Amt * sin1Math1Factor, 1 / sin1Val);
                    break;
                case 9: // abs
                    sin1Val = abs(sin1Val);
                    break;
                case 10: // round
                    sin1Val = round(sin1Math1Amt * sin1Math1Factor * sin1Val) / sin1Math1Amt * sin1Math1Factor;
                    break;
                }

                sin1Val = clamp(sin1Val, 0, 10);

                if (sin1Math2Other != 0)
                {
                    switch (sin1Math2Other)
                    {
                    case 1: // x
                        sin1Math2Amt = position.x;
                        break;
                    case 2: // y
                        sin1Math2Amt = position.y;
                        break;
                    case 3: // sin(time)
                        sin1Math2Amt = 0.5f * sin(unityTime) + 0.5f;
                        break;
                    case 4: // sin(x)
                        sin1Math2Amt = 0.5f * sin(position.x) + 0.5f;
                        break;
                    case 5: // sin(x * unityTime)
                        sin1Math2Amt = 0.5f * sin(position.x * unityTime) + 0.5f;
                        break;
                    case 6: // sin(y)
                        sin1Math2Amt = 1 - 0.5f * sin(position.y) + 0.5f;
                        break;
                    case 7: // sin(y * unityTime)
                        sin1Math2Amt = 1 - 0.5f * sin(position.y * unityTime) + 0.5f;
                        break;
                    case 8: // sin(x * y)
                        sin1Math2Amt = 0.5f * sin(position.x * position.y) + 0.5f;
                        break;
                    case 9: // sin(x * y * unityTime)
                        sin1Math2Amt = 0.5f * sin(position.x * position.y) + 0.5f;
                        break;
                    case 10: // sin(y) * sin(x)
                        sin1Math2Amt = 0.5f * (sin(position.x) * sin(position.y)) + 0.5f;
                        break;
                    case 11: // sin(y) * sin(x) * sin(time)
                        sin1Math2Amt = 0.5f * (sin(position.x) * sin(position.y) * sin(unityTime)) + 0.5f;
                        break;
                    }
                }

                if (sin1Math2Invert == 1)
                {
                    sin1Math2Amt = 1 - sin1Math2Amt;
                }

                switch (sin1Math2Op)
                {
                case 0: // noffin
                    break;
                case 1: // Add
                    sin1Val = sin1Val + sin1Math2Amt * sin1Math2Factor;
                    break;
                case 2: // subtract
                    sin1Val = sin1Val - sin1Math2Amt * sin1Math2Factor;
                    break;
                case 3: // mult
                    sin1Val = sin1Val * sin1Math2Amt * sin1Math2Factor;
                    break;
                case 4: // div
                    sin1Val = sin1Val / (sin1Math2Amt * sin1Math2Factor);
                    break;
                case 5: // power
                    sin1Val = pow(sin1Val, sin1Math2Amt * sin1Math2Factor);
                    break;
                case 6: // reciprocal power
                    sin1Val = pow(sin1Val, 1 / (sin1Math2Amt * sin1Math2Factor));
                    break;
                case 7: // other power
                    sin1Val = pow(sin1Math2Amt * sin1Math2Factor, sin1Val);
                    break;
                case 8: // other reciprocal power
                    sin1Val = pow(sin1Math2Amt * sin1Math2Factor, 1 / sin1Val);
                    break;
                case 9: // abs
                    sin1Val = abs(sin1Val);
                    break;
                case 10: // round
                    sin1Val = round(sin1Math2Amt * sin1Math2Factor * sin1Val) / sin1Math2Amt * sin1Math2Factor;
                    break;
                }

                sin1Val = clamp(sin1Val, 0, 10);

                if (sin1Math3Other != 0)
                {
                    switch (sin1Math3Other)
                    {
                    case 1: // x
                        sin1Math3Amt = position.x;
                        break;
                    case 2: // y
                        sin1Math3Amt = position.y;
                        break;
                    case 3: // sin(time)
                        sin1Math3Amt = 0.5f * sin(unityTime) + 0.5f;
                        break;
                    case 4: // sin(x)
                        sin1Math3Amt = 0.5f * sin(position.x) + 0.5f;
                        break;
                    case 5: // sin(x * unityTime)
                        sin1Math3Amt = 0.5f * sin(position.x * unityTime) + 0.5f;
                        break;
                    case 6: // sin(y)
                        sin1Math3Amt = 1 - 0.5f * sin(position.y) + 0.5f;
                        break;
                    case 7: // sin(y * unityTime)
                        sin1Math3Amt = 1 - 0.5f * sin(position.y * unityTime) + 0.5f;
                        break;
                    case 8: // sin(x * y)
                        sin1Math3Amt = 0.5f * sin(position.x * position.y) + 0.5f;
                        break;
                    case 9: // sin(x * y * unityTime)
                        sin1Math3Amt = 0.5f * sin(position.x * position.y) + 0.5f;
                        break;
                    case 10: // sin(y) * sin(x)
                        sin1Math3Amt = 0.5f * (sin(position.x) * sin(position.y)) + 0.5f;
                        break;
                    case 11: // sin(y) * sin(x) * sin(time)
                        sin1Math3Amt = 0.5f * (sin(position.x) * sin(position.y) * sin(unityTime)) + 0.5f;
                        break;
                    }
                }

                if (sin1Math3Invert == 1)
                {
                    sin1Math3Amt = 1 - sin1Math3Amt;
                }

                switch (sin1Math3Op)
                {
                case 0: // noffin
                    break;
                case 1: // Add
                    sin1Val = sin1Val + sin1Math3Amt * sin1Math3Factor;
                    break;
                case 2: // subtract
                    sin1Val = sin1Val - sin1Math3Amt * sin1Math3Factor;
                    break;
                case 3: // mult
                    sin1Val = sin1Val * sin1Math3Amt * sin1Math3Factor;
                    break;
                case 4: // div
                    sin1Val = sin1Val / (sin1Math3Amt * sin1Math3Factor);
                    break;
                case 5: // power
                    sin1Val = pow(sin1Val, sin1Math3Amt * sin1Math3Factor);
                    break;
                case 6: // reciprocal power
                    sin1Val = pow(sin1Val, 1 / (sin1Math3Amt * sin1Math3Factor));
                    break;
                case 7: // other power
                    sin1Val = pow(sin1Math3Amt * sin1Math3Factor, sin1Val);
                    break;
                case 8: // other reciprocal power
                    sin1Val = pow(sin1Math3Amt * sin1Math3Factor, 1 / sin1Val);
                    break;
                case 9: // abs
                    sin1Val = abs(sin1Val);
                    break;
                case 10: // round
                    sin1Val = round(sin1Math3Amt * sin1Math3Factor * sin1Val) / sin1Math3Amt * sin1Math3Factor;
                    break;
                }

                sin1Val = clamp(sin1Val, 0, 10);
            }
            
            bool cycleColours = true;
            float colourCycleSpeed = 2;
            if (cycleColours)
            {
                Rval = 0.5f * sin(colourCycleSpeed * (unityTime)) + 0.5f;
                Gval = 0.5f * sin(colourCycleSpeed * (unityTime + 2 * PI/3)) + 0.5f;
                Bval = 0.5f * sin(colourCycleSpeed * (unityTime + 4 * PI/3)) + 0.5f;
            }


            o.Albedo = sin1Val * float3(Rval, Gval, Bval);
            //o.Albedo = sin1XMult * float3(Rval, Gval, Bval);
            // Metallic and smoothness come from slider variables
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
