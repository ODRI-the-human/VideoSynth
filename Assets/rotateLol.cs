using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rotateLol : MonoBehaviour
{
    int timer = 0;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        timer++;
        transform.rotation = Quaternion.Euler(-90, 0, timer);
    }
}
