using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;
using UnityEngine.UI;
using UnityEngine.InputSystem;




public class things : MonoBehaviour
{
    public Material mattTheSquid;
    public AudioSource audio;
    bool sampleAgain = true;
    public bool doFlash = false;

    public GameObject[] funnyFarts;

    public List<bool> steps = new List<bool>();
    public int currentStep = 0;

    public GameObject canvas;

    private float clipSampleRate;
    private int sampleDataLength = 1024;

    float fixedFlashTime = 1.0f;

    public float theUnityTime;

    float timeAccel;
    public float timeAccelCoeff = 10;
    float timeToResample = 0;
    float totalTimeAdded = 0;
    float greenPow = 0;

    float BPM = 150;
    public float beatDelay;
    public int BPMCheckRes = 100;

    int totalStepNos = 64;

    public float envVal;

    float lastTime = 0;

    public bool doSequence = true;

    public int[] sequencerSends = new int[4]{ 0, 0, 0, 0};
    public float[] sendInit = new float[4] { 1, 1, 1, 1 };
    public float[] sendFinal = new float[4] { 1, 0, 0, 0 };
    public float[] currentAmt = new float[4] { 0, 0, 0, 0 };
    public bool[] scrolls = new bool[4] { false, false, false, false };
    public bool[] negative = new bool[4] { false, false, false, false };
    public float[] decayTime = new float[4] { 0.8f, 0.8f, 0.8f, 0.8f };
    public float[] valToPass = new float[4] { 0, 0, 0, 0 };

    float lastTrigTime;

    void Start()
    {
        Application.targetFrameRate = 60;
        beatDelay = 60 / BPM;
        Time.timeScale = 4 / (50 * beatDelay);

        for (int i = 0; i < totalStepNos; i++)
        {
            steps.Add(false);
        }
    }

    public void Restart()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }

    void LateUpdate()
    {
        float[] clipSampleData = new float[sampleDataLength];
        audio.GetOutputData(clipSampleData, 0); //I read 1024 samples, which is about 80 ms on a 44khz stereo clip, beginning at the current sample position of the clip.
        float clipLoudness = 0f;
        foreach (var sample in clipSampleData)
        {
            clipLoudness += Mathf.Abs(sample);
        }
        clipLoudness /= sampleDataLength; //clipLoudness is what you are looking for

        //if ((clipLoudness > 0.43f && timeToResample <= 50 && sampleAgain && doFlash)) // ((Mathf.Round(Time.time % fixedFlashTime) * 10)/10 == 0 && timeToResample <= 0)
        //{
        //    timeAccel = timeAccelCoeff;
        //    greenPow = 2;
        //    sampleAgain = false;
        //    timeToResample = 75;
        //}
        //else
        //{
        //    sampleAgain = true;
        //}

        timeToResample--;

        theUnityTime = Time.time + totalTimeAdded;
        mattTheSquid.SetFloat("unityTime", theUnityTime);
        timeAccel /= 1.1f;
        lastTime = Time.time + totalTimeAdded;

        // Sending envelope values to their sources.
        for (int i = 0; i < 4; i++)
        {
            currentAmt[i] = Mathf.Pow(Mathf.Clamp(1 - (Time.time - lastTrigTime) * decayTime[i], 0, 1), 4);

            string valToEffect = "bongo";
            float baseVal = sendFinal[i];
            float initVal = sendInit[i];

            float varVal = 0;
            Vector4 varValVec = new Vector4(0, 0, 0, 0);
            Vector4 valToPassVec = new Vector4(0,0,0,0);
            int oscToFunny = -5;
            float destMultAmt = 1;

            // need a switch for setting which value to manipulate, the initial value, final value, decay amount, and whether or not the value 'scrolls', i.e. whether it continually increases over time or returns to original value after each trigger.
            // So what it should do is use a getfloat or getvector to get the value from the shader, then add the envelope amount to the respective part of the vector/float, then pass it back to shader.
            switch (sequencerSends[i])
            {
                case 1:
                    valToEffect = "xOffset";
                    break;
                case 2:
                    valToEffect = "xScale";
                    break;
                case 3:
                    valToEffect = "yOffset";
                    break;
                case 4:
                    valToEffect = "yScale";
                    break;
                case 5:
                    valToEffect = "tScale";
                    break;
                case 6:
                    valToEffect = "sinFreqMult";
                    oscToFunny = 0;
                    break;
                case 7:
                    valToEffect = "finalMult";
                    oscToFunny = 0;
                    break;
                case 8:
                    valToEffect = "finalAdd";
                    oscToFunny = 0;
                    break;
                case 9:
                    valToEffect = "sinFreqMult";
                    oscToFunny = 1;
                    break;
                case 10:
                    valToEffect = "finalMult";
                    oscToFunny = 1;
                    break;
                case 11:
                    valToEffect = "finalAdd";
                    oscToFunny = 1;
                    break;
                case 12:
                    valToEffect = "sinFreqMult";
                    oscToFunny = 2;
                    break;
                case 13:
                    valToEffect = "finalMult";
                    oscToFunny = 2;
                    break;
                case 14:
                    valToEffect = "finalAdd";
                    oscToFunny = 2;
                    break;
                case 15:
                    valToEffect = "sinFreqMult";
                    oscToFunny = 3;
                    break;
                case 16:
                    valToEffect = "finalMult";
                    oscToFunny = 3;
                    break;
                case 17:
                    valToEffect = "finalAdd";
                    oscToFunny = 3;
                    break;
                case 18:
                    valToEffect = "sinMath1Fac";
                    oscToFunny = 0;
                    break;
                case 19:
                    valToEffect = "sinMath1Fac";
                    oscToFunny = 1;
                    break;
                case 20:
                    valToEffect = "sinMath1Fac";
                    oscToFunny = 2;
                    break;
                case 21:
                    valToEffect = "sinMath1Fac";
                    oscToFunny = 3;
                    break;
                case 22:
                    valToEffect = "sinMath2Fac";
                    oscToFunny = 0;
                    break;
                case 23:
                    valToEffect = "sinMath2Fac";
                    oscToFunny = 1;
                    break;
                case 24:
                    valToEffect = "sinMath2Fac";
                    oscToFunny = 2;
                    break;
                case 25:
                    valToEffect = "sinMath2Fac";
                    oscToFunny = 3;
                    break;
                case 26:
                    valToEffect = "sinMath3Fac";
                    oscToFunny = 0;
                    break;
                case 27:
                    valToEffect = "sinMath3Fac";
                    oscToFunny = 1;
                    break;
                case 28:
                    valToEffect = "sinMath3Fac";
                    oscToFunny = 2;
                    break;
                case 29:
                    valToEffect = "sinMath3Fac";
                    oscToFunny = 3;
                    break;
                case 30:
                    valToEffect = "ampAlgFinals";
                    oscToFunny = 1;
                    break;
                case 31:
                    valToEffect = "ampAlgFinals";
                    oscToFunny = 0;
                    break;
                case 32:
                    valToEffect = "RAlgFinals";
                    oscToFunny = 1;
                    break;
                case 33:
                    valToEffect = "RAlgFinals";
                    oscToFunny = 0;
                    break;
                case 34:
                    valToEffect = "GAlgFinals";
                    oscToFunny = 1;
                    break;
                case 35:
                    valToEffect = "GAlgFinals";
                    oscToFunny = 0;
                    break;
                case 36:
                    valToEffect = "BAlgFinals";
                    oscToFunny = 1;
                    break;
                case 37:
                    valToEffect = "BAlgFinals";
                    oscToFunny = 0;
                    break;
                case 38:
                    valToEffect = "rotAngle";
                    destMultAmt = 0.5f;
                    break;
                case 39:
                    valToEffect = "pixelateAmt";
                    destMultAmt = 4095 * 2;
                    break;
            }
        
            if (oscToFunny == -5)
            {
                varVal = mattTheSquid.GetFloat(valToEffect);
                if (scrolls[i])
                {
                    valToPass[i] = varVal + destMultAmt * Mathf.Lerp(baseVal, initVal, currentAmt[i]);//varVal + destMultAmt * currentAmt[i];
                    mattTheSquid.SetFloat(valToEffect, valToPass[i]);
                }
                else
                {
                    valToPass[i] = destMultAmt * Mathf.Lerp(baseVal, initVal, currentAmt[i]);
                    mattTheSquid.SetFloat(valToEffect, valToPass[i]);
                }
            }
            else
            {
                varValVec = mattTheSquid.GetVector(valToEffect);
                if (scrolls[i])
                {
                    valToPass[i] = varValVec[oscToFunny] + destMultAmt * Mathf.Lerp(baseVal, initVal, currentAmt[i]);
                    valToPassVec = varValVec;
                    valToPassVec[oscToFunny] = valToPass[i];
                    mattTheSquid.SetVector(valToEffect, valToPassVec);
                }
                else
                {
                    valToPass[i] = destMultAmt * Mathf.Lerp(baseVal, initVal, currentAmt[i]);
                    valToPass[i] = Mathf.Clamp(valToPass[i], baseVal, 99999999);
                    valToPassVec = varValVec;
                    valToPassVec[oscToFunny] = valToPass[i];
                    mattTheSquid.SetVector(valToEffect, valToPassVec);
                }
            }
        }
    }

    public void OnTrigger(InputAction.CallbackContext context)
    {
        if (context.started)
        {
            TrigModSources();
        }
    }

    public void TrigModSources()
    {
        lastTrigTime = Time.time;
        Debug.Log("Not gaslit");
    }

    void FixedUpdate()
    {
        if (doSequence)
        {
            if (steps[currentStep])
            {
                TrigModSources();
            }

            currentStep++;

            if (currentStep >= totalStepNos)
            {
                currentStep = 0;
            }
        }
    }
}
