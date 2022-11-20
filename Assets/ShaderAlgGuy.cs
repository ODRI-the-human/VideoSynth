using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderAlgGuy : MonoBehaviour
{
    public Material mattTheSquid;
    public Shader shadey;

    public Vector4 floatVector = new Vector4(1, 1, 1, 1);

    // Start is called before the first frame update
    void setAFloat(string var, float val, int which)
    {
        floatVector = mattTheSquid.GetVector(var);
        floatVector[which] = val;
        mattTheSquid.SetVector(var, floatVector);
        Debug.Log(var + ", " + val.ToString() + ", " + floatVector.ToString());
    }

    public void AmpAlgSrc1(int value)
    {
        setAFloat("ampAlgOrder", value, 0);
    }
    public void AmpAlgSrc2(int value)
    {
        setAFloat("ampAlgOrder", value, 1);
    }
    public void AmpAlgSrc3(int value)
    {
        setAFloat("ampAlgOrder", value, 2);
    }
    public void AmpAlgSrc4(int value)
    {
        setAFloat("ampAlgOrder", value, 3);
    }
    public void AmpAlgOp1(int value)
    {
        setAFloat("ampAlgOps", value, 0);
    }
    public void AmpAlgOp2(int value)
    {
        setAFloat("ampAlgOps", value, 1);
    }
    public void AmpAlgOp3(int value)
    {
        setAFloat("ampAlgOps", value, 2);
    }





    public void RAlgSrc1(int value)
    {
        setAFloat("RAlgOrder", value, 0);
    }
    public void RAlgSrc2(int value)
    {
        setAFloat("RAlgOrder", value, 1);
    }
    public void RAlgSrc3(int value)
    {
        setAFloat("RAlgOrder", value, 2);
    }
    public void RAlgSrc4(int value)
    {
        setAFloat("RAlgOrder", value, 3);
    }
    public void RAlgOp1(int value)
    {
        setAFloat("RAlgOps", value, 0);
    }
    public void RAlgOp2(int value)
    {
        setAFloat("RAlgOps", value, 1);
    }
    public void RAlgOp3(int value)
    {
        setAFloat("RAlgOps", value, 2);
    }





    public void GAlgSrc1(int value)
    {
        setAFloat("GAlgOrder", value, 0);
    }
    public void GAlgSrc2(int value)
    {
        setAFloat("GAlgOrder", value, 1);
    }
    public void GAlgSrc3(int value)
    {
        setAFloat("GAlgOrder", value, 2);
    }
    public void GAlgSrc4(int value)
    {
        setAFloat("GAlgOrder", value, 3);
    }
    public void GAlgOp1(int value)
    {
        setAFloat("GAlgOps", value, 0);
    }
    public void GAlgOp2(int value)
    {
        setAFloat("GAlgOps", value, 1);
    }
    public void GAlgOp3(int value)
    {
        setAFloat("GAlgOps", value, 2);
    }




    public void BAlgSrc1(int value)
    {
        setAFloat("BAlgOrder", value, 0);
    }
    public void BAlgSrc2(int value)
    {
        setAFloat("BAlgOrder", value, 1);
    }
    public void BAlgSrc3(int value)
    {
        setAFloat("BAlgOrder", value, 2);
    }
    public void BAlgSrc4(int value)
    {
        setAFloat("BAlgOrder", value, 3);
    }
    public void BAlgOp1(int value)
    {
        setAFloat("BAlgOps", value, 0);
    }
    public void BAlgOp2(int value)
    {
        setAFloat("BAlgOps", value, 1);
    }
    public void BAlgOp3(int value)
    {
        setAFloat("BAlgOps", value, 2);
    }
}
