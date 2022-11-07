using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;



public class things : MonoBehaviour
{
    public Material mattTheSquid;
    public AudioSource audio;
    bool sampleAgain = true;

    public TextMeshProUGUI timeAccelText;

    private float clipSampleRate;
    private int sampleDataLength = 1024;

    float timeAccel;
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

        if (clipLoudness > 0.4f && timeToResample <= 50 && sampleAgain)
        {
            Debug.Log(clipLoudness.ToString());
            timeAccel = 3;
            greenPow = 2;
            sampleAgain = false;
            timeToResample = 60;
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

        timeAccelText.text = timeAccel.ToString();

        timeAccel /= 1.1f;
        //timeAccel = Mathf.Clamp(timeAccel, 0.03f, 900);

        lastTime = Time.time + totalTimeAdded;
    }
}
