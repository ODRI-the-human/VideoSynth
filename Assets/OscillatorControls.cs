using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OscillatorControls : MonoBehaviour
{
    public Material mattTheSquid;
    public Shader shadey;
    public GameObject master;

    public int oscNumber;

    //public float[] floatVector = new float[4] {1,1,1,1};
    public Vector4 floatVector = new Vector4(1, 1, 1, 1);

    void Start()
    {
        //gameObject.SetActive(false);
    }

    void setAFloat(string var, float val)
    {
        floatVector = mattTheSquid.GetVector(var);
        Debug.Log(var + ", " + val.ToString() + ", " + floatVector.ToString());
        floatVector[oscNumber] = val;
        mattTheSquid.SetVector(var, floatVector);
    }

    // Update is called once per frame
    public void enableOscs(bool tog)
    {
        if (tog)
        {
            setAFloat("oscsEnabled", 1);
        }
        else
        {
            setAFloat("oscsEnabled", 0);
        }
    }

    public void enableX(bool tog)
    {
        if (tog)
        {
            setAFloat("sinXMult", 1);
        }
        else
        {
            setAFloat("sinXMult", 0);
        }
    }

    public void setXMult(float value)
    {
        setAFloat("sinXMultAmt", Mathf.Pow(10 * value, 2));
    }

    public void enableY(bool tog)
    {
        if (tog)
        {
            setAFloat("sinYMult", 1);
        }
        else
        {
            setAFloat("sinYMult", 0);
        }
    }

    public void setYMult(float value)
    {
        setAFloat("sinYMultAmt", Mathf.Pow(10 * value, 2));
    }

    public void enableTime(bool tog)
    {
        if (tog)
        {
            setAFloat("sinTimeMult", 1);
        }
        else
        {
            setAFloat("sinTimeMult", 0);
        }
    }

    public void setTimeMult(float value)
    {
        setAFloat("sinTimeMultAmt",value * 10 - 5);
    }

    public void setAmpMult(float value)
    {
        setAFloat("sinAmp",value * 3);
    }

    public void setFreqMult(float value)
    {
        setAFloat("sinFreqMult",value * 10);
    }

    public void setAdd(float value)
    {
        setAFloat("sinAdd", value * 3);
    }

    public void Math1OpChange(int value)
    {
        setAFloat("sinMath1Op", value);
    }

    public void Math1SourceChange(int value)
    {
        setAFloat("sinMath1Other", value);
    }

    public void Math1AmtChange(string value)
    {
        setAFloat("sinMath1Factor", float.Parse(value));
    }

    public void Math2OpChange(int value)
    {
        setAFloat("sinMath2Op", value);
    }

    public void Math2SourceChange(int value)
    {
        setAFloat("sinMath2Other", value);
    }

    public void Math2AmtChange(string value)
    {
        setAFloat("sinMath2Factor", float.Parse(value));
    }

    public void Math3OpChange(int value)
    {
        setAFloat("sinMath3Op", value);
    }

    public void Math3SourceChange(int value)
    {
        setAFloat("sinMath3Other", value);
    }

    public void Math3AmtChange(string value)
    {
        setAFloat("sinMath3Factor", float.Parse(value));
    }

    public void Math1Invert(bool tog)
    {
        if (tog)
        {
            setAFloat("sinMath1Invert", 1);
        }
        else
        {
            setAFloat("sinMath1Invert", 0);
        }
    }
    
    public void Math2Invert(bool tog)
    {
        if (tog)
        {
            setAFloat("sinMath2Invert", 1);
        }
        else
        {
            setAFloat("sinMath2Invert", 0);
        }
    }
    
    public void Math3Invert(bool tog)
    {
        if (tog)
        {
            setAFloat("sinMath3Invert", 1);
        }
        else
        {
            setAFloat("sinMath3Invert", 0);
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
