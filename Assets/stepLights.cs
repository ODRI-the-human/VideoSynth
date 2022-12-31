using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class stepLights : MonoBehaviour
{
    public Sprite[] epics;
    public int currentStep;
    public List<GameObject> lights = new List<GameObject>();
    int lightNoToAssign = 0;

    public GameObject master;

    void Start()
    {
        foreach (Transform child in transform)
        {
            lights.Add(child.GetChild(1).gameObject);
            child.gameObject.GetComponent<stepSequencer>().stepNo = lightNoToAssign;
            lightNoToAssign++;
        }
    }

    void Update()
    {
        currentStep = master.GetComponent<things>().currentStep;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        foreach (GameObject light in lights)
        {
            if (light.GetComponent<Image>().sprite == epics[1])
            {
                light.GetComponent<Image>().sprite = epics[0];
            }
        }
        lights[currentStep].GetComponent<Image>().sprite = epics[1];
    }
}
