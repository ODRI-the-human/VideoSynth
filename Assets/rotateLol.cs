using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rotateLol : MonoBehaviour
{
    public float speed = 1f;

    public float xMult = 0;
    public float yMult = 0;
    public float zMult = 0;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.rotation *= Quaternion.Euler(xMult * speed, yMult * speed, zMult * speed);
    }
}
