using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class destroyBriefly : MonoBehaviour
{
    int timer = 0;

    // Update is called once per frame
    void FixedUpdate()
    {
        if (timer == 1)
        {
            Destroy(gameObject);
        }
        timer++;
    }
}
