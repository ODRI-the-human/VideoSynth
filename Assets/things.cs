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

    public GameObject canvas;

    private float clipSampleRate;
    private int sampleDataLength = 1024;

    float fixedFlashTime = 1.0f;

    float timeAccel;
    float timeAccelCoeff = 10;
    float timeToResample = 0;
    float totalTimeAdded = 0;
    float greenPow = 1;

    float lastTime = 0;

    void Start()
    {
        Application.targetFrameRate = 60;
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

        if ((clipLoudness > 0.43f && timeToResample <= 50 && sampleAgain)) // ((Mathf.Round(Time.time % fixedFlashTime) * 10)/10 == 0 && timeToResample <= 0)
        {
            timeAccel = timeAccelCoeff;
            greenPow = 2;
            sampleAgain = false;
            timeToResample = 75;
        }
        else
        {
            sampleAgain = true;
        }

        timeToResample--;

        float theUnityTime = Time.time + totalTimeAdded;
        float deltaTime = (theUnityTime - lastTime) * timeAccel;
        totalTimeAdded += deltaTime;
        float newTime = lastTime + deltaTime;
        mattTheSquid.SetFloat("unityTime", newTime);

        greenPow -= 0.1f;
        greenPow = Mathf.Clamp(greenPow, 1, 900);
        mattTheSquid.SetFloat("greenPow", greenPow);

        timeAccel /= 1.1f;
        //timeAccel = Mathf.Clamp(timeAccel, 0.03f, 900);

        lastTime = Time.time + totalTimeAdded;
    }
}
