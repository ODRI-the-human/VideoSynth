Shader "Custom/shadey"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0
        _Width("Width", Float) = 2
        _Height("Height", Float) = 2
        _unityTime("Time", Float) = 0
        _xyScale("xyScale", Float) = 1

        _oscsEnabled("oscsEnabled", Float) = (1, 0, 0, 0)

        _sinXMult("sinXMult", Float) = (1, 1, 1, 1)
        _sinXMultAmt("sinXMultAmt", Float) = (1, 1, 1, 1)

        _sinYMult("sinYMult", Float) = (0, 0, 0, 0)
        _sinYMultAmt("sinYMultAmt", Float) = (1, 1, 1, 1)

        _sinTimeMult("sinTimeMult", Float) = (0, 0, 0, 0)
        _sinTimeMultAmt("sinTimeMultAmt", Float) = (1, 1, 1, 1)

        _sinFreqMult("sinFreqMult", Float) = (1, 1, 1, 1)
        _sinAmp("sinAmp", Float) = (1, 1, 1, 1)
        _sinAdd("sinAdd", Float) = (0, 0, 0, 0)

        _sinMath1Op("sinMat1hOp", Float) = (0, 0, 0, 0)
        _sinMath1Other("sinMath1Other", Float) = (0, 0, 0, 0)
        _sinMath1Factor("sinMath1Factor", Float) = (1, 1, 1, 1)
        _sinMath1Invert("sinMath1Invert", Float) = (0, 0, 0, 0)

        _sinMath2Op("sinMath2Op", Float) = (0, 0, 0, 0)
        _sinMath2Other("sinMath2Other", Float) = (0, 0, 0, 0)
        _sinMath2Factor("sinMath2Factor", Float) = (1, 1, 1, 1)
        _sinMath2Invert("sinMath2Invert", Float) = (0, 0, 0, 0)

        _sinMath3Op("sinMath3Op", Float) = (0, 0, 0, 0)
        _sinMath3Other("sinMath3Other", Float) = (0, 0, 0, 0)
        _sinMath3Factor("sinMath3Factor", Float) = (1, 1, 1, 1)
        _sinMath3Invert("sinMath3Invert", Float) = (0, 0, 0, 0)

        _ampAlgOrder("ampAlgOrder", Float) = (0, 1, 2, 3)
        _ampAlgOps("ampAlgOps", Float) = (2, 1, 3)
        _ampAlgFinals("ampAlgFinals", Float) = (0, 1)

        _RAlgOrder("RAlgOrder", Float) = (0, 1, 2, 3)
        _RAlgOps("RAlgOps", Float) = (2, 1, 3)
        _RAlgFinals("RAlgFinals", Float) = (0, 1)

        _GAlgOrder("GAlgOrder", Float) = (0, 1, 2, 3)
        _GAlgOps("GAlgOps", Float) = (2, 1, 3)
        _GAlgFinals("GAlgFinals", Float) = (0, 1)

        _BAlgOrder("BAlgOrder", Float) = (0, 1, 2, 3)
        _BAlgOps("BAlgOps", Float) = (2, 1, 3)
        _BAlgFinals("BAlgFinals", Float) = (0, 1)
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

        float4 oscsEnabled = float4 (1, 0, 0, 0); // tick box.

        float xyScale = 1;

        float4 sinXMult = float4 (1, 1, 1, 1); // tick box.
        float4 sinXMultAmt = float4 (1, 1, 1, 1); // slider

        float4 sinYMult = float4 (0, 0, 0, 0); // tick box.
        float4 sinYMultAmt = float4 (1, 1, 1, 1); // slider

        float4 sinTimeMult = float4 (0, 0, 0, 0); // tick box
        float4 sinTimeMultAmt = float4 (1, 1, 1, 1); // slider

        float4 sinFreqMult = float4 (1, 1, 1, 1); // slider
        float4 sinAmp = float4 (1, 1, 1, 1); // slider.
        float4 sinAdd = float4 (0, 0, 0, 0); // slider

        float4 sinMath1Op = float4 (0, 0, 0, 0); // needs select box.
        float4 sinMath1Other = float4 (0, 0, 0, 0); // select box.
        float4 sinMath1Factor = float4 (1, 1, 1, 1);
        float4 sinMath1Invert = float4 (0, 0, 0, 0);

        float4 sinMath2Op = float4 (0, 0, 0, 0); // needs select box.
        float4 sinMath2Other = float4 (0, 0, 0, 0); // select box.
        float4 sinMath2Factor = float4 (1, 1, 1, 1);
        float4 sinMath2Invert = float4 (0, 0, 0, 0);

        float4 sinMath3Op = float4 (0, 0, 0, 0); // needs select box.
        float4 sinMath3Other = float4 (0, 0, 0, 0); // select box.
        float4 sinMath3Factor = float4 (1, 1, 1, 1);
        float4 sinMath3Invert = float4 (0, 0, 0, 0);

        float4 ampAlgOrder = float4 (0, 1, 2, 3);
        float4 RAlgOrder = float4 (0, 1, 2, 3);
        float4 GAlgOrder = float4 (0, 1, 2, 3);
        float4 BAlgOrder = float4 (0, 1, 2, 3);

        float3 ampAlgOps = float3 (2, 1, 3);
        float3 RAlgOps = float3 (2, 1, 3);
        float3 GAlgOps = float3 (2, 1, 3);
        float3 BAlgOps = float3 (2, 1, 3);

        float2 ampAlgFinals = float2 (0, 1);
        float2 RAlgFinals = float2 (0, 1);
        float2 GAlgFinals = float2 (0, 1);
        float2 BAlgFinals = float2 (0, 1);

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 position = IN.uv_MainTex;
            
            position *= xyScale;

            //position = round(position / 2) * 2;

            bool useSin1 = true;
            float Rval = 1;
            float Gval = 1;
            float Bval = 1;

            float4 sinVal = float4 (0,0,0,0);

            float4 sinMathOp = float4 (1,1,1,1);
            float4 sinMathOther = float4 (1, 1, 1, 1);
            float4 sinMathFactor = float4 (1, 1, 1, 1);
            float4 sinMathInvert = float4 (1, 1, 1, 1);

            for (int i = 0; i < 4; i++)
            {
                float sinInBracketVal = 1; // 1 by default, doesn't need slider.
                sinVal[i] = 0;
                if (oscsEnabled[i] == 1)
                {
                    if (sinXMult[i] == 1)
                    {
                        sinInBracketVal = sinInBracketVal + sinXMultAmt[i] * position.x;
                    }
                    if (sinYMult[i] == 1)
                    {
                        sinInBracketVal = sinInBracketVal + sinYMultAmt[i] * position.y;
                    }
                    if (sinTimeMult[i] == 1)
                    {
                        sinInBracketVal = sinInBracketVal + sinTimeMultAmt[i] * unityTime;
                    }

                    sinVal[i] = sinAmp[i] * sin(sinInBracketVal * sinFreqMult[i]) + sinAdd[i];

                    for (int j = 0; j < 3; j++)
                    {
                        switch (j)
                        {
                        case 0:
                            sinMathOp = sinMath1Op;
                            sinMathOther = sinMath1Other;
                            sinMathFactor = sinMath1Factor;
                            sinMathInvert = sinMath1Invert;
                            break;
                        case 1:
                            sinMathOp = sinMath2Op;
                            sinMathOther = sinMath2Other;
                            sinMathFactor = sinMath2Factor;
                            sinMathInvert = sinMath2Invert;
                            break;
                        case 2:
                            sinMathOp = sinMath3Op;
                            sinMathOther = sinMath3Other;
                            sinMathFactor = sinMath3Factor;
                            sinMathInvert = sinMath3Invert;
                            break;
                        }

                        float sinMathAmt = 1;

                        if (sinMathOther[i] != 0)
                        {
                            switch (sinMathOther[i])
                            {
                            case 1: // x
                                sinMathAmt = position.x;
                                break;
                            case 2: // y
                                sinMathAmt = position.y;
                                break;
                            case 3: // sin(time)
                                sinMathAmt = 0.5f * sin(unityTime) + 0.3f;
                                break;
                            case 4: // sin(x)
                                sinMathAmt = 0.5f * sin(position.x) + 0.3f;
                                break;
                            case 5: // sin(x * unityTime)
                                sinMathAmt = 0.5f * sin(position.x * unityTime) + 0.3f;
                                break;
                            case 6: // sin(y)
                                sinMathAmt = 0.5f * sin(position.y) + 0.3f;
                                break;
                            case 7: // sin(y * unityTime)
                                sinMathAmt = 0.5f * sin(position.y * unityTime) + 0.3f;
                                break;
                            case 8: // sin(x * y)
                                sinMathAmt = 0.5f * sin(position.x * position.y) + 0.3f;
                                break;
                            case 9: // sin(x * y * unityTime)
                                sinMathAmt = 0.5f * sin(position.x * position.y * unityTime) + 0.3f;
                                break;
                            case 10: // sin(y) * sin(x)
                                sinMathAmt = 0.5f * (sin(position.x) * sin(position.y)) + 0.3f;
                                break;
                            case 11: // sin(y) * sin(x) * sin(time)
                                sinMathAmt = 0.5f * (sin(position.x) * sin(position.y) * sin(unityTime)) + 0.3f;
                                break;
                            }
                        }

                        if (sinMathInvert[i] == 1)
                        {
                            sinMathAmt = 1 - sinMathAmt;
                        }

                        switch (sinMathOp[i])
                        {
                        case 0: // noffin
                            break;
                        case 1: // Add
                            sinVal = sinVal + sinMathAmt * sinMathFactor[i];
                            break;
                        case 2: // subtract
                            sinVal = sinVal - sinMathAmt * sinMathFactor[i];
                            break;
                        case 3: // mult
                            sinVal = sinVal * sinMathAmt * sinMathFactor[i];
                            break;
                        case 4: // div
                            sinVal = sinVal / clamp((sinMathAmt * sinMathFactor[i]), 0.01f, 99999999);
                            break;
                        case 5: // power
                            sinVal = pow(sinVal, sinMathAmt * sinMathFactor[i]);
                            break;
                        case 6: // reciprocal power
                            sinVal = pow(sinVal, 1 / clamp((sinMathAmt * sinMathFactor[i]), 0.01f, 99999999));
                            break;
                        case 7: // other power
                            sinVal = pow(sinMathAmt * sinMathFactor[i], sinVal);
                            break;
                        case 8: // other reciprocal power
                            sinVal = pow(sinMathAmt * sinMathFactor[i], 1 / sinVal);
                            break;
                        case 9: // abs
                            sinVal = abs(sinVal);
                            break;
                        case 10: // round
                            sinVal = round(sinMathAmt * sinMathFactor[i] * sinVal) / clamp(sinMathAmt * sinMathFactor[i],0.01f,99999999);
                            break;
                        }

                        sinVal[i] = clamp(sinVal[i], -10, 10);
                    }
                }
            }
            //bool cycleColours = true;
            //float colourCycleSpeed = 2;
            //if (cycleColours)
            //{
            //    Rval = 0.5f * sin(colourCycleSpeed * (unityTime)) + 0.5f;
            //    Gval = 0.5f * sin(colourCycleSpeed * (unityTime + 2 * PI/3)) + 0.5f;
            //    Bval = 0.5f * sin(colourCycleSpeed * (unityTime + 4 * PI/3)) + 0.5f;
            //}

            float4 algOrder = float4 (0, 0, 0, 0);
            float3 algOps = float3 (0, 0, 0);
            float2 algFinals = float2 (0, 0);
            float funcResult = 0;

            float4 ampRGB = float4(0, 0, 0, 0);

            for (int i = 0; i < 4; i++)
            {
                switch (i)
                {
                case 0:
                    algOrder = ampAlgOrder;
                    algOps = ampAlgOps;
                    algFinals = ampAlgFinals;
                    break;
                case 1:
                    algOrder = RAlgOrder;
                    algOps = RAlgOps;
                    algFinals = RAlgFinals;
                    break;
                case 2:
                    algOrder = GAlgOrder;
                    algOps = GAlgOps;
                    algFinals = GAlgFinals;
                    break;
                case 3:
                    algOrder = BAlgOrder;
                    algOps = BAlgOps;
                    algFinals = BAlgFinals;
                    break;
                }

                for (int j = 0; j < 3; j++)
                {

                    if (j == 0)
                    {
                        funcResult = sinVal[algOrder[0]];
                    }

                    switch (ampAlgOps[i])
                    {
                    case 0: //Add
                        funcResult += sinVal[algOrder[j + 1]];
                        break;
                    case 1: //Subtract
                        funcResult -= sinVal[algOrder[j + 1]];
                        break;
                    case 2: //Mult
                        funcResult *= sinVal[algOrder[j + 1]];
                        break;
                    case 3: //Divide
                        funcResult /= sinVal[algOrder[j + 1]];
                        break;
                    }
                }

                ampRGB[i] = (funcResult + algFinals[0]) * algFinals[1];
            }


            o.Albedo = ampRGB[0] * float3(Rval * ampRGB[1], Gval * ampRGB[2], Bval * ampRGB[3]);
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
