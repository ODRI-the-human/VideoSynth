using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GetShaderProperties : MonoBehaviour
{
    float xVal;
    float yVal;

    float sinVal;

    public Material mattTheSquid;

    int timer = 1;

    // Update is called once per frame
    void Update()
    {
        xVal = mattTheSquid.GetFloat("outputPostionX");
        yVal = mattTheSquid.GetFloat("outputPostionY");

        sinVal = 1 * Mathf.Sin(xVal);
        mattTheSquid.SetFloat("inputAmpMult", sinVal);
        Resources.UnloadUnusedAssets();
    }
}
