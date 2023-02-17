using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;

public class modelHandler : MonoBehaviour
{
    public GameObject cat;

    public Material mattTheSquid;
    public Shader shadey;
    public GameObject master;

    public Vector4 floatVector = new Vector4(1, 1, 1, 1);

    public GameObject cameron;

    public Texture2D blboblbl = null;

    void Start()
    {
        setXScale(0.5f);
        setYScale(0.5f);
        setXOffset(0.5f);
        setYOffset(0.5f);
        setTScale(0.5f);
        distModeX(0);
        distModeY(0);
        distModeT(0);
        pixelateAmt(0);
        rotate(0);
        rotatePost(0);
        allScale(0.333f);

        finalMathEnableChannel1(false);
        finalMathEnableChannel2(false);
        finalMathEnableChannel3(false);
        finalMathEnableChannel4(false);
        finalMath1Fac(0);
        finalMath2Fac(0);
        finalMath1OpChange(0);
        finalMath2OpChange(0);

        setFeedbackAmt(0);
        setFinalFinalOut(1);
    }


    void Update()
    {
        Resources.UnloadUnusedAssets();

        if (cameron.GetComponent<visualFeedback>().texToPass != null)
        {
            blboblbl = cameron.GetComponent<visualFeedback>().texToPass;
        }
        mattTheSquid.SetTexture("whomble", blboblbl);
    }


    public void setFeedbackAmt(float value)
    {
        mattTheSquid.SetFloat("feedbackAmt", 16 * value);
    }
    
    public void setFinalFinalOut(float value)
    {
        mattTheSquid.SetFloat("finalFinalFinalOut", value);
    }

    void setAFloat(string var, float val, int num)
    {
        floatVector = mattTheSquid.GetVector(var);
        Debug.Log(var + ", " + val.ToString() + ", " + floatVector.ToString());
        floatVector[num] = val;
        mattTheSquid.SetVector(var, floatVector);
    }


    public void finalMath1Fac(float value)
    {
        setAFloat("finalMathFactor", Mathf.Pow(7 * value, 2), 0);
    }
    public void finalMath2Fac(float value)
    {
        setAFloat("finalMathFactor", Mathf.Pow(7 * value, 2), 1);
    }
    public void finalMath1OpChange(int value)
    {
        setAFloat("finalMathOp", value, 0);
    }
    public void finalMath2OpChange(int value)
    {
        setAFloat("finalMathOp", value, 1);
    }
    public void finalMathEnableChannel1(bool tog)
    {
        if (tog)
        {
            setAFloat("finalMathSendToChannels", 1, 0);
        }
        else
        {
            setAFloat("finalMathSendToChannels", 0, 0);
        }
    }
    public void finalMathEnableChannel2(bool tog)
    {
        if (tog)
        {
            setAFloat("finalMathSendToChannels", 1, 1);
        }
        else
        {
            setAFloat("finalMathSendToChannels", 0, 1);
        }
    }
    public void finalMathEnableChannel3(bool tog)
    {
        if (tog)
        {
            setAFloat("finalMathSendToChannels", 1, 2);
        }
        else
        {
            setAFloat("finalMathSendToChannels", 0, 2);
        }
    }
    public void finalMathEnableChannel4(bool tog)
    {
        if (tog)
        {
            setAFloat("finalMathSendToChannels", 1, 3);
        }
        else
        {
            setAFloat("finalMathSendToChannels", 0, 3);
        }
    }



    public void rotatePost(float value)
    {
        mattTheSquid.SetFloat("postDistRotAngle", 2 * Mathf.PI * value);
    }

    public void allScale(float value)
    {
        mattTheSquid.SetFloat("allScale", Mathf.Pow(3.333f * value, 2));
    }


    public void distModeX(int value)
    {
        mattTheSquid.SetFloat("distModeX", value);
    }
    public void distModeY(int value)
    {
        mattTheSquid.SetFloat("distModeY", value);
    }
    public void distModeT(int value)
    {
        mattTheSquid.SetFloat("distModeT", value);
    }



    public void pixelateAmt(float value)
    {
        mattTheSquid.SetFloat("pixelateAmt", 4096 * value);
    }
    public void rotate(float value)
    {
        mattTheSquid.SetFloat("rotAngle", .66666f * Mathf.PI * value);
    }



    public void setXScale(float value)
    {
        mattTheSquid.SetFloat("xScale", 2 * value);
    }

    public void setYScale(float value)
    {
        mattTheSquid.SetFloat("yScale", 2 * value);
    }

    public void setTScale(float value)
    {
        mattTheSquid.SetFloat("tScale", 20 * value);
    }

    public void setXOffset(float value)
    {
        mattTheSquid.SetFloat("xOffset", 4 * value - 2);
    }

    public void setYOffset(float value)
    {
        mattTheSquid.SetFloat("yOffset", 4 * value - 2);
    }

    public void setSpeed(float value)
    {
        cat.GetComponent<rotateLol>().speed = 8 * value;
    }

    public void setSize(float value)
    {
        cat.transform.localScale = 1000 * value * new Vector3(1,1,1);
    }

    public void setXRot(float value)
    {
        cat.GetComponent<rotateLol>().xMult = 2 * value - 1;
    }
    
    public void setYRot(float value)
    {
        cat.GetComponent<rotateLol>().yMult = 2 * value - 1;
    }

    public void setZRot(float value)
    {
        cat.GetComponent<rotateLol>().zMult = 2 * value - 1;
    }
}
