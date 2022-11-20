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

    public void setXYScale(float value)
    {
        mattTheSquid.SetFloat("xyScale", value);
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
