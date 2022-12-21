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
        mattTheSquid.SetFloat("rotAngle", 2 * Mathf.PI * value);
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
