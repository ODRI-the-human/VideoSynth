using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class fitUIToScreen : MonoBehaviour
{
    public float height;
    public Camera cameron;

    // Update is called once per frame
    void Update()
    {
        height = Screen.height;

        transform.localScale = new Vector3(height, height, 0) / 512 * 0.95f;
    }
}
