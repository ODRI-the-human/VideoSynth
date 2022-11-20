using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OscillatorControls : MonoBehaviour
{
    public Material mattTheSquid;
    public Shader shadey;
    public GameObject master;

    public int oscNumber;

    int[] intVector = new int[4];
    float[] floatVector = new float[4];

    void Start()
    {
        gameObject.SetActive(false);
    }

    // Update is called once per frame
    public void enableX(bool tog)
    {
        Debug.Log(tog.ToString());
        if (tog)
        {
            mattTheSquid.SetInteger("sin1XMult"[0], 1);
        }
        else
        {
            mattTheSquid.SetInteger("sin1XMult"[0], 0);
        }
    }

    public void setXMult(float value)
    {
        mattTheSquid.SetFloat("sin1XMultAmt"[0], Mathf.Pow(10 * value,2));
    }

    public void enableY(bool tog)
    {
        Debug.Log(tog.ToString());
        if (tog)
        {
            mattTheSquid.SetInteger("sin1YMult"[0], 1);
        }
        else
        {
            mattTheSquid.SetInteger("sin1YMult"[0], 0);
        }
    }

    public void setYMult(float value)
    {
        mattTheSquid.SetFloat("sin1YMultAmt"[0], Mathf.Pow(10 * value, 2));
    }

    public void enableTime(bool tog)
    {
        Debug.Log(tog.ToString());
        if (tog)
        {
            mattTheSquid.SetInteger("sin1TimeMult"[0], 1);
        }
        else
        {
            mattTheSquid.SetInteger("sin1TimeMult"[0], 0);
        }
    }

    public void setTimeMult(float value)
    {
        mattTheSquid.SetFloat("sin1TimeMultAmt"[0], value * 10 - 5);
    }

    public void setAmpMult(float value)
    {
        mattTheSquid.SetFloat("sin1Amp"[0], value * 3);
    }

    public void setFreqMult(float value)
    {
        mattTheSquid.SetFloat("sin1FreqMult"[0], value * 10);
    }

    public void setAdd(float value)
    {
        mattTheSquid.SetFloat("sin1Add"[0], value * 3);
    }

    public void Math1OpChange(int value)
    {
        mattTheSquid.SetInteger("sin1Math1Op", value);
    }

    public void Math1SourceChange(int value)
    {
        mattTheSquid.SetInteger("sin1Math1Other", value);
    }

    public void Math1AmtChange(string value)
    {
        mattTheSquid.SetFloat("sin1Math1Factor", float.Parse(value));
    }

    public void Math2OpChange(int value)
    {
        mattTheSquid.SetInteger("sin1Math2Op", value);
    }

    public void Math2SourceChange(int value)
    {
        mattTheSquid.SetInteger("sin1Math2Other", value);
    }

    public void Math2AmtChange(string value)
    {
        mattTheSquid.SetFloat("sin1Math2Factor", float.Parse(value));
    }

    public void Math3OpChange(int value)
    {
        mattTheSquid.SetInteger("sin1Math3Op", value);
    }

    public void Math3SourceChange(int value)
    {
        mattTheSquid.SetInteger("sin1Math3Other", value);
    }

    public void Math3AmtChange(string value)
    {
        mattTheSquid.SetFloat("sin1Math3Factor", float.Parse(value));
    }

    public void Math1Invert(bool tog)
    {
        if (tog)
        {
            mattTheSquid.SetInteger("sin1Math1Invert", 1);
        }
        else
        {
            mattTheSquid.SetInteger("sin1Math1Invert", 0);
        }
    }
    
    public void Math2Invert(bool tog)
    {
        if (tog)
        {
            mattTheSquid.SetInteger("sin1Math2Invert", 1);
        }
        else
        {
            mattTheSquid.SetInteger("sin1Math2Invert", 0);
        }
    }
    
    public void Math3Invert(bool tog)
    {
        if (tog)
        {
            mattTheSquid.SetInteger("sin1Math3Invert", 1);
        }
        else
        {
            mattTheSquid.SetInteger("sin1Math3Invert", 0);
        }
    }

    public void setFlashCoeff(float value)
    {
        master.GetComponent<things>().timeAccelCoeff = value * 20;
    }

    public void EnableFlash(bool tog)
    {
        if (tog)
        {
            master.GetComponent<things>().doFlash = true;
        }
        else
        {
            master.GetComponent<things>().doFlash = false;
        }
    }
}
