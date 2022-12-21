using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class stepSequencer : MonoBehaviour
{
    public int stepNo;
    public GameObject mister;

    void setAFloat(bool val)
    {
        mister.GetComponent<things>().steps[stepNo] = val;
    }

    public void enableStep(bool tog)
    {
        if (tog)
        {
            setAFloat(true);
        }
        else
        {
            setAFloat(false);
        }
    }
}
