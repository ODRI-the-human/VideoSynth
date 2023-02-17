using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class fitPlaneToScreen : MonoBehaviour
{
    public float height;
    public float width;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        height = Screen.height;
        width = Screen.width;

        transform.localScale = new Vector3(-width / height, 1, -1);
    }
}
