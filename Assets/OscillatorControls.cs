using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OscillatorControls : MonoBehaviour
{
    public Material mattTheSquid;
    public Shader shadey;
    public GameObject master;

    public int oscNumber;

    public Sprite[] spritoes;

    //public float[] floatVector = new float[4] {1,1,1,1};
    public Vector4 floatVector = new Vector4(1, 1, 1, 1);

    void Start()
    {
        if (oscNumber == 0)
        {
            enableOscs(true);
        }
        else
        {
            enableOscs(false);
        }

        enableX(true);
        setXMult(0.5f);
        enableY(false);
        setYMult(0.5f);
        enableTime(false);
        setTimeMult(1);
        setAmpMult(1);
        setFreqMult(0.5f);
        setAdd(0);
        Math1OpChange(0);
        Math1SourceChange(0);
        Math1AmtChange(0);
        Math1Invert(false);
        Math2OpChange(0);
        Math2SourceChange(0);
        Math2AmtChange(0);
        Math2Invert(false);
        Math3OpChange(0);
        Math3SourceChange(0);
        Math3AmtChange(0);
        Math3Invert(false);

        HarmonicType(0);
        HarmonicNum(0);
        HarmonicInv(false);

        finalAdd(0);
        finalMult(1);

        OscMode(0);
    }

    void setAFloat(string var, float val)
    {
        floatVector = mattTheSquid.GetVector(var);
        Debug.Log(var + ", " + val.ToString() + ", " + floatVector.ToString());
        floatVector[oscNumber] = val;
        mattTheSquid.SetVector(var, floatVector);
    }

    

    public void finalAdd(float val)
    {
        setAFloat("finalAdd", 5 * val);
    }
    public void finalMult(float val)
    {
        setAFloat("finalMult", 2 * val - 1);
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

    public void OscMode(int value)
    {
        setAFloat("oscMode", value);
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
        setAFloat("sinAmp",value * 6 - 3);
    }

    public void setFreqMult(float value)
    {
        setAFloat("sinFreqMult",value * 10);
    }

    public void setAdd(float value)
    {
        setAFloat("sinAdd", value * 3);
    }






    public void HarmonicType(int value)
    {
        setAFloat("HarmMode", value);
    }
    public void HarmonicNum(float value)
    {
        setAFloat("HarmNum", value * 99 + 1);
    }
    public void HarmonicInv(bool tog)
    {
        if (tog)
        {
            setAFloat("HarmInv", 1);
        }
        else
        {
            setAFloat("HarmInv", 0);
        }
    }





    public void Math1OpChange(int value)
    {
        setAFloat("sinMath1Op", value);
    }

    public void Math1SourceChange(int value)
    {
        setAFloat("sinMath1Other", value);
    }

    public void Math1AmtChange(float value)
    {
        setAFloat("sinMath1Factor", Mathf.Pow(7 * value, 2));
    }

    public void Math2OpChange(int value)
    {
        setAFloat("sinMath2Op", value);
    }

    public void Math2SourceChange(int value)
    {
        setAFloat("sinMath2Other", value);
    }

    public void Math2AmtChange(float value)
    {
        setAFloat("sinMath2Factor", Mathf.Pow(7 * value, 2));
    }

    public void Math3OpChange(int value)
    {
        setAFloat("sinMath3Op", value);
    }

    public void Math3SourceChange(int value)
    {
        setAFloat("sinMath3Other", value);
    }

    public void Math3AmtChange(float value)
    {
        setAFloat("sinMath3Factor", Mathf.Pow(7 * value, 2));
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
