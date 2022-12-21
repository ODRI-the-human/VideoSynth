using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;
using UnityEngine.UI;



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
    float greenPow = 1;

    public float BPM = 128;
    public float beatDelay;
    public int BPMCheckRes = 100;

    float lastTime = 0;

    void Start()
    {
        Application.targetFrameRate = 60;
        beatDelay = 60 / BPM;
        Time.timeScale = 4 / (50 * beatDelay);

        for (int i = 0; i < 16; i++)
        {
            steps.Add(false);
        }
    }

    void Update()
    {
        if (Input.GetButtonDown("Restart"))
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        }

        if (Input.GetButtonDown("Hide"))
        {
            if (canvas.GetComponent<CanvasScaler>().scaleFactor == 1)
            {
                canvas.GetComponent<CanvasScaler>().scaleFactor = 0;
            }
            else
            {
                canvas.GetComponent<CanvasScaler>().scaleFactor = 1;
            }
        }
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
        float deltaTime = (theUnityTime - lastTime) * timeAccel;
        totalTimeAdded += deltaTime;
        float newTime = lastTime + deltaTime;
        mattTheSquid.SetFloat("unityTime", newTime);

        greenPow -= 0.1f;
        greenPow = Mathf.Clamp(greenPow, 1, 900);
        mattTheSquid.SetFloat("flashAmount", greenPow);

        timeAccel /= 1.1f;
        //timeAccel = Mathf.Clamp(timeAccel, 0.03f, 900);

        lastTime = Time.time + totalTimeAdded;
    }

    void FixedUpdate()
    {
        Debug.Log("nightmare city");
        if (steps[currentStep])
        {
            Debug.Log("cock life");
            timeAccel = timeAccelCoeff;
            greenPow = 2;

            Instantiate(funnyFarts[Random.Range(0, 4)]);
        }
        currentStep++;

        if (currentStep == steps.Count)
        {
            currentStep = 0;
        }
    }
}
