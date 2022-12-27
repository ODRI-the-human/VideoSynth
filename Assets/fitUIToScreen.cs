using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class fitUIToScreen : MonoBehaviour
{
    public float height;

    public float xMov = 0;
    public float yMov = 0;
    public float scaleMov = 0;

    public Camera cameron;

    // Update is called once per frame
    void Update()
    {
        height = Screen.height;

        transform.localScale = (scaleMov + 1) * new Vector3(height, height, 0) / 512 * 0.95f;
        transform.position = new Vector3(xMov * 50, Screen.height + yMov * 50, 0);

        if (Input.GetButtonDown("Up"))
        {
            yMov++;
        }

        if (Input.GetButtonDown("Down"))
        {
            yMov--;
        }

        if (Input.GetButtonDown("Left"))
        {
            xMov--;
        }

        if (Input.GetButtonDown("Right"))
        {
            xMov++;
        }

        if (Input.GetButtonDown("ScaleUp"))
        {
            scaleMov += 0.2f;
            Debug.Log("Pooman");
        }

        if (Input.GetButtonDown("ScaleDown"))
        {
            scaleMov -= 0.2f;
        }
    }
}
