using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StepSeqEnable : MonoBehaviour
{
    public GameObject master;
    public List<bool> stepsBackup = new List<bool>();
    public bool isActive;

    public void enableStepSeq(bool tog)
    {
        if (tog)
        {
            master.GetComponent<things>().doSequence = true;
            transform.position -= new Vector3(5000, 0, 0);
        }
        else
        {
            master.GetComponent<things>().doSequence = false;
            transform.position += new Vector3(5000, 0, 0);
        }
    }
}
