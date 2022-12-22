using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class sequencerControls : MonoBehaviour
{
    public int funnyNumber;
    public GameObject master;

    public void setInitial(float val)
    {
        master.GetComponent<things>().sendInit[funnyNumber] = Mathf.Pow(val, 4);
    }
    
    public void setFinal(float val)
    {
        master.GetComponent<things>().sendFinal[funnyNumber] = Mathf.Pow(val, 4);
    }
    
    public void setDecay(float val)
    {
        master.GetComponent<things>().decayTime[funnyNumber] = Mathf.Pow(10 - (10 * val),2);
    }

    public void setScroll(bool tog)
    {
        if (tog)
        {
            master.GetComponent<things>().scrolls[funnyNumber] = true;
        }
        else
        {
            master.GetComponent<things>().scrolls[funnyNumber] = false;
        }
    }
    
    public void setSign(bool tog)
    {
        if (tog)
        {
            master.GetComponent<things>().negative[funnyNumber] = true;
        }
        else
        {
            master.GetComponent<things>().negative[funnyNumber] = false;
        }
    }

    public void sendLocation(int value)
    {
        master.GetComponent<things>().sequencerSends[funnyNumber] = value;
    }
}
