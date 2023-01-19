using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class fitUIToScreen : MonoBehaviour
{
    public float height;

    public float xMov = 0;
    public float yMov = 0;
    public float scaleMov = 0;

    bool buttonIsHeld;
    Vector2 movDir;

    public Camera cameron;
    public InputAction UIPos;
    public InputAction UIScale;
    public InputAction UIHide;

    bool isUIThere = true;
    float thingy = 0;

    private void OnEnable()
    {
        UIPos.Enable();
        UIScale.Enable();
        UIHide.Enable();
    }
    
    private void OnDisable()
    {
        UIPos.Disable();
        UIScale.Disable();
        UIHide.Disable();
    }

    // Update is called once per frame
    void Update()
    {
        height = Screen.height;

        transform.localScale = (scaleMov + 1) * new Vector3(height, height, 0) / 512 * 0.95f;
        transform.position = new Vector3(xMov * 50 + thingy, Screen.height + yMov * 50, 0);

        if (!buttonIsHeld)
        {
            movDir = UIPos.ReadValue<Vector2>();
            yMov += movDir.y;
            xMov += movDir.x;

            scaleMov += 0.2f * UIScale.ReadValue<float>();

            if (UIHide.ReadValue<float>() != 0)
            {
                if (isUIThere)
                {
                    thingy = -500000;
                    isUIThere = false;
                }
                else
                {
                    thingy = 0;
                    isUIThere = true;
                }
            }
        }

        if (UIPos.ReadValue<Vector2>().magnitude != 0 || UIScale.ReadValue<float>() != 0 || UIHide.ReadValue<float>() != 0)
        {
            buttonIsHeld = true;
        }
        else
        {
            buttonIsHeld = false;
        }

        //if (Input.GetButtonDown("Up"))
        //{
        //    yMov++;
        //}

            //if (Input.GetButtonDown("Down"))
            //{
            //    yMov--;
            //}

            //if (Input.GetButtonDown("Left"))
            //{
            //    xMov--;
            //}

            //if (Input.GetButtonDown("Right"))
            //{
            //    xMov++;
            //}

            //if (Input.GetButtonDown("ScaleUp"))
            //{
            //    scaleMov += 0.2f;
            //}

            //if (Input.GetButtonDown("ScaleDown"))
            //{
            //    scaleMov -= 0.2f;
            //}
    }
}
