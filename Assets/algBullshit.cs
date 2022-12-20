using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class algBullshit : MonoBehaviour
{
    public Material mattTheSquid;
    public Shader shadey;

    public Vector4 floatVector = new Vector4(1, 1, 1, 1);

    void Start()
    {
        setAmpOrder1(0);
        setAmpOrder2(1);
        setAmpOrder3(2);
        setAmpOrder4(3);
        setAmpOps1(0);
        setAmpOps2(0);
        setAmpOps3(0);
        
        setROrder1(4);
        setROrder2(4);
        setROrder3(4);
        setROrder4(4);
        setROps1(0);
        setROps2(0);
        setROps3(0);
        
        setGOrder1(4);
        setGOrder2(4);
        setGOrder3(4);
        setGOrder4(4);
        setGOps1(0);
        setGOps2(0);
        setGOps3(0);
        
        setBOrder1(4);
        setBOrder2(4);
        setBOrder3(4);
        setBOrder4(4);
        setBOps1(0);
        setBOps2(0);
        setBOps3(0);

        setAmpFinalAdd(0);
        setAmpFinalMult(1);
        setRFinalAdd(0);
        setRFinalMult(1);
        setGFinalAdd(0);
        setGFinalMult(1);
        setBFinalAdd(0);
        setBFinalMult(1);
    }

    public void setAFloat(string var, int val, int which)
    {
        floatVector = mattTheSquid.GetVector(var);
        floatVector[which] = val;
        Debug.Log(var + ", " + val.ToString() + ", " + floatVector.ToString());
        mattTheSquid.SetVector(var, floatVector);
    }

    public void setAFloatReal(string var, float val, int which)
    {
        floatVector = mattTheSquid.GetVector(var);
        Debug.Log(var + ", " + val.ToString() + ", " + floatVector.ToString());
        floatVector[which] = val;
        mattTheSquid.SetVector(var, floatVector);
    }

    public void setAmpOrder1(int val)
    {
        setAFloat("ampAlgOrder", val, 0);
    }
    public void setAmpOrder2(int val)
    {
        setAFloat("ampAlgOrder", val, 1);
    }
    public void setAmpOrder3(int val)
    {
        setAFloat("ampAlgOrder", val, 2);
    }
    public void setAmpOrder4(int val)
    {
        setAFloat("ampAlgOrder", val, 3);
    }

    public void setAmpOps1(int val)
    {
        setAFloat("ampAlgOps", val, 0);
    }
    public void setAmpOps2(int val)
    {
        setAFloat("ampAlgOps", val, 1);
    }
    public void setAmpOps3(int val)
    {
        setAFloat("ampAlgOps", val, 2);
    }

    public void setAmpFinalAdd(float val)
    {
        setAFloatReal("ampAlgFinals", val * 5, 0);
    }
    public void setAmpFinalMult(float val)
    {
        setAFloatReal("ampAlgFinals", val * 2 - 1, 1);
    }


    public void setROrder1(int val)
    {
        setAFloat("RAlgOrder", val, 0);
    }
    public void setROrder2(int val)
    {
        setAFloat("RAlgOrder", val, 1);
    }
    public void setROrder3(int val)
    {
        setAFloat("RAlgOrder", val, 2);
    }
    public void setROrder4(int val)
    {
        setAFloat("RAlgOrder", val, 3);
    }

    public void setROps1(int val)
    {
        setAFloat("RAlgOps", val, 0);
    }
    public void setROps2(int val)
    {
        setAFloat("RAlgOps", val, 1);
    }
    public void setROps3(int val)
    {
        setAFloat("RAlgOps", val, 2);
    }

    public void setRFinalAdd(float val)
    {
        setAFloatReal("RAlgFinals", val * 5, 0);
    }
    public void setRFinalMult(float val)
    {
        setAFloatReal("RAlgFinals", val * 2 - 1, 1);
    }

    public void setGOrder1(int val)
    {
        setAFloat("GAlgOrder", val, 0);
    }
    public void setGOrder2(int val)
    {
        setAFloat("GAlgOrder", val, 1);
    }
    public void setGOrder3(int val)
    {
        setAFloat("GAlgOrder", val, 2);
    }
    public void setGOrder4(int val)
    {
        setAFloat("GAlgOrder", val, 3);
    }

    public void setGOps1(int val)
    {
        setAFloat("GAlgOps", val, 0);
    }
    public void setGOps2(int val)
    {
        setAFloat("GAlgOps", val, 1);
    }
    public void setGOps3(int val)
    {
        setAFloat("GAlgOps", val, 2);
    }

    public void setGFinalAdd(float val)
    {
        setAFloatReal("GAlgFinals", val * 5, 0);
    }
    public void setGFinalMult(float val)
    {
        setAFloatReal("GAlgFinals", val * 2 - 1, 1);
    }

    public void setBOrder1(int val)
    {
        setAFloat("BAlgOrder", val, 0);
    }
    public void setBOrder2(int val)
    {
        setAFloat("BAlgOrder", val, 1);
    }
    public void setBOrder3(int val)
    {
        setAFloat("BAlgOrder", val, 2);
    }
    public void setBOrder4(int val)
    {
        setAFloat("BAlgOrder", val, 3);
    }

    public void setBOps1(int val)
    {
        setAFloat("BAlgOps", val, 0);
    }
    public void setBOps2(int val)
    {
        setAFloat("BAlgOps", val, 1);
    }
    public void setBOps3(int val)
    {
        setAFloat("BAlgOps", val, 2);
    }

    public void setBFinalAdd(float val)
    {
        setAFloatReal("BAlgFinals", val * 5, 0);
    }
    public void setBFinalMult(float val)
    {
        setAFloatReal("BAlgFinals", val * 2 - 1, 1);
    }
}
