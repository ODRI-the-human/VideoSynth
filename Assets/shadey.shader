Shader "Custom/shadey"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _FeedbackTex("whomble", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0
        _Width("Width", Float) = 2
        _Height("Height", Float) = 2
        _unityTime("Time", Float) = 0

        _xScale("xScale", Float) = 1
        _yScale("yScale", Float) = 1
        _xOffset("xOffset", Float) = 0
        _yOffset("yOffset", Float) = 0
        _tScale("tScale", Float) = 1

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

        _sinMath1Op("sinMath1Op", Float) = (0, 0, 0, 0)
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
        _ampAlgOps("ampAlgOps", Float) = (0, 0, 0, 0)
        _ampAlgFinals("ampAlgFinals", Float) = (0, 1, 0, 0)

        _RAlgOrder("RAlgOrder", Float) = (0, 1, 2, 3)
        _RAlgOps("RAlgOps", Float) = (0, 0, 0, 0)
        _RAlgFinals("RAlgFinals", Float) = (0, 1, 0, 0)

        _GAlgOrder("GAlgOrder", Float) = (0, 1, 2, 3)
        _GAlgOps("GAlgOps", Float) = (0, 0, 0, 0)
        _GAlgFinals("GAlgFinals", Float) = (0, 1, 0, 0)

        _BAlgOrder("BAlgOrder", Float) = (0, 1, 2, 3)
        _BAlgOps("BAlgOps", Float) = (0, 0, 0, 0)
        _BAlgFinals("BAlgFinals", Float) = (0, 1, 0, 0)




        _HarmMode("HarmMode", Float) = (0,0,0,0)
        _HarmNum("HarmNum", Float) = (1,1,1,1)
        _HarmInv("HarmInv", Float) = (0,0,0,0)



        _finalAdd("finalAdd", Float) = (0,0,0,0)
        _finalMult("finalMult", Float) = (1,1,1,1)

        _distModeX("distModeX", Float) = 0
        _distModeY("distModeY", Float) = 0
        _distModeT("distModeT", Float) = 0

        _oscMode("oscMode", Float) = (0,0,0,0)
        _rotAngle("rotAngle", Float) = 0
        _postDistRotAngle("postDistRotAngle", Float) = 0
        _allScale("allScale", Float) = 1
        _pixelateAmt("pixellateAmt", Float) = 0

        _finalMathOp("finalMathOp", Float) = (0, 0, 0, 0)
        _finalMathFactor("finalMathFactor", Float) = (0, 0, 0, 0)
        _finalMathSendToChannels("finalMathSendToChannels", Float) = (0, 0, 0, 0)

        _feedbackAmt("feedbackAmt", Float) = 0
        _finalFinalFinalOut("finalFinalFinalOut", Float) = 1
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

        float nrand(float2 uv)
        {
            return frac(sin(dot(5 * uv, float2(12.9898, 78.233))) * 43758.5453 * sin(unityTime));
        }

        

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        float4 oscsEnabled = float4 (1, 0, 0, 0); // tick box.

        float xOffset = 0;
        float yOffset = 0;

        float xScale = 1;
        float yScale = 1;
        float tScale = 1;

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

        float4 ampAlgOps = float4 (0, 0, 0, 0);
        float4 RAlgOps = float4 (0, 0, 0, 0);
        float4 GAlgOps = float4 (0, 0, 0, 0);
        float4 BAlgOps = float4 (0, 0, 0, 0);

        float4 ampAlgFinals = float4 (0, 1, 0, 0);
        float4 RAlgFinals = float4 (0, 1, 0, 0);
        float4 GAlgFinals = float4 (0, 1, 0, 0);
        float4 BAlgFinals = float4 (0, 1, 0, 0);


        float4 HarmMode = float4 (0, 0, 0, 0);
        float4 HarmNum = float4 (1, 1, 1, 1);
        float4 HarmInv = float4 (0, 0, 0, 0);


        float4 finalAdd = float4 (0, 0, 0, 0);
        float4 finalMult = float4 (1, 1, 1, 1);

        float distModeX = 0;
        float distModeY = 0;
        float distModeT = 0;

        float4 oscMode = (0, 0, 0, 0);
        float rotAngle = 0;
        float postDistRotAngle = 0;
        float allScale = 1;
        float pixelateAmt = 0;

        float2 finalMathOp = (0, 0);
        float2 finalMathFactor = (1, 1);
        float4 finalMathSendToChannels = (0, 0, 0, 0);

        sampler2D whomble;
        float feedbackAmt = 0;
        float finalFinalFinalOut = 1;



        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 position = allScale * IN.uv_MainTex;

            position = round(position * (4096 - pixelateAmt)) / (4096 - pixelateAmt);

            float orgPosx = position.x - 0.5f;
            float orgPosy = position.y - 0.5f;

            position.x = orgPosx * cos(postDistRotAngle) - orgPosy * sin(postDistRotAngle);
            position.y = orgPosx * sin(postDistRotAngle) + orgPosy * cos(postDistRotAngle);

            position.x += xOffset;
            position.y += yOffset;

            position.x *= xScale;
            position.y *= yScale;
            unityTime *= tScale;

            float distMode = 0;
            float pos = 0;

            for (int r = 0; r < 3; r++)
            {
                switch (r)
                {
                case 0:
                    distMode = distModeT;
                    pos = unityTime;
                    break;
                case 1:
                    distMode = distModeX;
                    pos = position.x;
                    break;
                case 2:
                    distMode = distModeY;
                    pos = position.y;
                    break;
                }

                switch (distMode)
                {
                case 0:
                    //penis (nothing)
                    break;
                case 1:
                    pos *= sin(4 * position.x * position.y);
                    break;
                case 2:
                    pos += sin(unityTime);
                    break;
                case 3:
                    pos += pow(position.x * position.y, 2);
                    break;
                case 4:
                    pos -= pow(position.x, 3);
                    break;
                case 5:
                    pos -= pow(position.y, 3);
                    break;
                case 6:
                    pos += pow(position.y, position.x);
                    break;
                case 7:
                    pos += cos(90 * position.x) - sin(90 * rotAngle * position.y);
                    break;
                case 8:
                    pos += sin(90 * rotAngle * position.x) + cos(90 * rotAngle * position.y);
                    break;
                }

                switch (r)
                {
                case 0:
                    unityTime = pos;
                    break;
                case 1:
                    position.x = pos;
                    break;
                case 2:
                    position.y = pos;
                    break;
                }

                float dorgPosx = position.x - 0.5f;
                float dorgPosy = position.y - 0.5f;

                position.x = dorgPosx * cos(rotAngle) - dorgPosy * sin(rotAngle);
                position.y = dorgPosx * sin(rotAngle) + dorgPosy * cos(rotAngle);
            }

            float4 sinVal = float4 (0,0,0,0);

            float4 sinMathOp = float4 (1,1,1,1);
            float4 sinMathOther = float4 (1, 1, 1, 1);
            float4 sinMathFactor = float4 (1, 1, 1, 1);
            float4 sinMathInvert = float4 (1, 1, 1, 1);

            for (int i = 0; i < 4; i++)
            {
                float2 oldPos = position;

                float sinInBracketVal = 1; // 1 by default, doesn't need slider.
                switch (oscMode[i])
                {
                case 0:
                    //funney
                    break;
                case 1:
                    position.x += sinYMultAmt[i] * .005f * sin(20 * position.y);
                    break;
                case 2:
                    position.y += sinXMultAmt[i] * .005f * sin(20 * position.x);
                    break;
                case 3:
                    position.x += round(position.y * sinYMultAmt[i]) / sinYMultAmt[i];
                    break;
                case 4:
                    position.x += round(position.y * sinYMultAmt[i]) / sinYMultAmt[i];
                    break;
                case 5:
                    position.x += round(position.y * sinYMultAmt[i]) / sinYMultAmt[i];
                    position.y += round(position.x * sinXMultAmt[i]) / sinXMultAmt[i];
                    break;
                case 6:
                    position.x = (position.x - 0.5f) * round(cos(position.x) * sinYMultAmt[i]) / sinYMultAmt[i] - (position.y - 0.5f) * round(sin(position.x) * sinYMultAmt[i]) / sinYMultAmt[i];
                    position.y = (position.y - 0.5f) * round(cos(position.y) * sinXMultAmt[i]) / sinXMultAmt[i] - (position.x - 0.5f) * round(sin(position.y) * sinXMultAmt[i]) / sinXMultAmt[i];
                    break;
                }

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

                    sinInBracketVal *= sinFreqMult[i];
                    float funnySin = 0;
                    bool doHarmonic = false;

                    for (float p = 1; p < 100; p++)
                    {
                        switch (HarmMode[i])
                        {
                            case 0:
                                doHarmonic = true;
                                break;
                            case 1:
                                if (p % 2 == 0)
                                {
                                    doHarmonic = true;
                                }
                                break;
                            case 2:
                                if (p % 3 == 0)
                                {
                                    doHarmonic = true;
                                }
                                break;
                            case 3:
                                if (p % 4 == 0)
                                {
                                    doHarmonic = true;
                                }
                                break;
                            case 4:
                                if (p % 5 == 0)
                                {
                                    doHarmonic = true;
                                }
                                break;
                        }

                        if (HarmInv[i] == 1)
                        {
                            if (doHarmonic)
                            {
                                doHarmonic = false;
                            }
                            else
                            {
                                doHarmonic = true;
                            }
                        }

                        if (doHarmonic && p <= HarmNum[i])
                        {
                            funnySin += (1 / p) * sin(p * sinInBracketVal);
                        }
                    }

                    switch (i)
                    {
                    case 0:
                        sinVal.x = sinAmp[i] * funnySin + sinAdd[i];
                        break;
                    case 1:
                        sinVal.y = sinAmp[i] * funnySin + sinAdd[i];
                        break;
                    case 2:
                        sinVal.z = sinAmp[i] * funnySin + sinAdd[i];
                        break;
                    case 3:
                        sinVal.w = sinAmp[i] * funnySin + sinAdd[i];
                        break;
                    }

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
                                sinMathAmt = 0.4f * sin(unityTime) + 0.6f;
                                break;
                            case 4: // sin(x)
                                sinMathAmt = 0.4f * sin(position.x) + 0.6f;
                                break;
                            case 5: // sin(x * unityTime)
                                sinMathAmt = 0.4f * sin(position.x * unityTime) + 0.6f;
                                break;
                            case 6: // sin(y)
                                sinMathAmt = 0.4f * sin(position.y) + 0.6f;
                                break;
                            case 7: // sin(y * unityTime)
                                sinMathAmt = 0.4f * sin(position.y * unityTime) + 0.6f;
                                break;
                            case 8: // sin(x * y)
                                sinMathAmt = 0.4f * sin(position.x * position.y) + 0.6f;
                                break;
                            case 9: // sin(x * y * unityTime)
                                sinMathAmt = 0.4f * sin(position.x * position.y * unityTime) + 0.6f;
                                break;
                            case 10: // sin(y) * sin(x)
                                sinMathAmt = 0.4f * (sin(position.x) * sin(position.y)) + 0.6f;
                                break;
                            case 11: // sin(y) * sin(x) * sin(time)
                                sinMathAmt = 0.4f * (sin(position.x) * sin(position.y) * sin(unityTime)) + 0.6f;
                                break;
                            case 12: // inBracketVal
                                sinMathAmt = 0.4f * sin(sinInBracketVal) + 0.6f;
                                break;
                            case 13:
                                sinMathAmt = nrand(0.5f * position);
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
                            sinVal[i] = sinVal[i] + sinMathAmt * sinMathFactor[i];
                            break;
                        case 2: // subtract
                            sinVal[i] = sinVal[i] - sinMathAmt * sinMathFactor[i];
                            break;
                        case 3: // mult
                            sinVal[i] = sinVal[i] * sinMathAmt * sinMathFactor[i];
                            break;
                        case 4: // div
                            sinVal[i] = sinVal[i] / clamp((sinMathAmt * sinMathFactor[i]), 0.01f, 99999999);
                            break;
                        case 5: // power
                            sinVal[i] = pow(sinVal[i], sinMathAmt * sinMathFactor[i]);
                            break;
                        case 6: // reciprocal power
                            sinVal[i] = pow(sinVal[i], 1 / clamp((sinMathAmt * sinMathFactor[i]), 0.01f, 99999999));
                            break;
                        case 7: // other power
                            sinVal[i] = pow(sinMathAmt * sinMathFactor[i], sinVal[i]);
                            break;
                        case 8: // other reciprocal power
                            sinVal[i] = pow(sinMathAmt * sinMathFactor[i], 1 / sinVal[i]);
                            break;
                        case 9: // abs
                            sinVal[i] = abs(sinVal[i]);
                            break;
                        case 10: // round
                            sinVal[i] = round(sinMathAmt * sinMathFactor[i] * sinVal[i]) / clamp(sinMathAmt * sinMathFactor[i],0.01f,99999999);
                            break;
                        case 11: // clampMin
                            sinVal[i] = clamp(sinVal[i], sinMathAmt * sinMathFactor[i], 999);
                            break;
                        case 12: // clampMax
                            sinVal[i] = clamp(-999, sinVal[i], sinMathAmt * sinMathFactor[i]);
                            break;
                        }

                        sinVal = clamp(sinVal, -4, 4);
                    }
                }
                position = oldPos;

                sinVal[i] = sinVal[i] * finalMult[i] + finalAdd[i];
            }

            //sinVal.x = position.x;

            // Algorithmz
            float4 algOrder = float4 (0, 1, 2, 3);
            float4 algOps = float4 (0, 0, 0, 0);
            float4 algFinals = float4 (0, 1, 0, 0);
            float funcResult = 0;
            float4 ampRGB = float4(0, 0, 0, 0);
            
            for (int k = 0; k < 4; k++) // K represents whether the shader is looking at the algorithm for brightness, R, G or B.
            {
                //int k = 0;
                switch (k)
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


                    switch (ampAlgOps[j])
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

                if (algOrder.x == 4)
                {
                    funcResult = 1;
                }

                switch (k)
                {
                case 0:
                    ampRGB.x = funcResult * algFinals[1] + algFinals[0];
                    break;
                case 1:
                    ampRGB.y = funcResult * algFinals[1] + algFinals[0];
                    break;
                case 2:
                    ampRGB.z = funcResult * algFinals[1] + algFinals[0];
                    break;
                case 3:
                    ampRGB.w = funcResult * algFinals[1] + algFinals[0];
                    break;
                }
            }

            // final math
            for (int m = 0; m < 4; m++)
            {
                for (int s = 0; s < 2; s++)
                {
                    int spinMathOp = finalMathOp[s];
                    float spinMathFactor = finalMathFactor[s];

                    float thingToFuck = 0;

                    if (finalMathSendToChannels[m] != 0)
                    {
                        switch (m)
                        {
                        case 0:
                            thingToFuck = ampRGB.x;
                            break;
                        case 1:
                            thingToFuck = ampRGB.y;
                            break;
                        case 2:
                            thingToFuck = ampRGB.z;
                            break;
                        case 3:
                            thingToFuck = ampRGB.w;
                            break;
                        }

                        switch (spinMathOp)
                        {
                        case 0: // noffin
                            break;
                        case 1: // Add
                            thingToFuck = thingToFuck + spinMathFactor;
                            break;
                        case 2: // subtract
                            thingToFuck = thingToFuck - spinMathFactor;
                            break;
                        case 3: // mult
                            thingToFuck = thingToFuck * spinMathFactor;
                            break;
                        case 4: // div
                            thingToFuck = thingToFuck / clamp((spinMathFactor), 0.01f, 99999999);
                            break;
                        case 5: // power
                            thingToFuck = pow(thingToFuck, spinMathFactor);
                            break;
                        case 6: // reciprocal power
                            thingToFuck = pow(thingToFuck, 1 / clamp((spinMathFactor), 0.01f, 99999999));
                            break;
                        case 7: // other power
                            thingToFuck = pow(spinMathFactor, thingToFuck);
                            break;
                        case 8: // other reciprocal power
                            thingToFuck = pow(spinMathFactor, 1 / thingToFuck);
                            break;
                        case 9: // abs
                            thingToFuck = abs(thingToFuck);
                            break;
                        case 10: // round
                            thingToFuck = round(spinMathFactor * thingToFuck) / clamp(spinMathFactor, 0.01f, 99999999);
                            break;
                        case 11: // clampMin
                            thingToFuck = clamp(thingToFuck, spinMathFactor, 999);
                            break;
                        case 12: // clampMax
                            thingToFuck = clamp(-999, thingToFuck, spinMathFactor);
                            break;
                        }

                        switch (m)
                        {
                        case 0:
                            ampRGB.x = thingToFuck;
                            break;
                        case 1:
                            ampRGB.y = thingToFuck;
                            break;
                        case 2:
                            ampRGB.z = thingToFuck;
                            break;
                        case 3:
                            ampRGB.w = thingToFuck;
                            break;
                        }
                    }
                }
            }
            
            float4 fuckHead = tex2D(whomble, IN.uv_MainTex);
            float3 flimHead = float3(fuckHead.x, fuckHead.y, fuckHead.z);

            o.Albedo = finalFinalFinalOut * (feedbackAmt * flimHead + clamp(ampRGB[0] * float3(ampRGB[1], ampRGB[2], ampRGB[3]), 0, 8));

            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = 1;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
