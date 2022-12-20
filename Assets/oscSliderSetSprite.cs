using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class oscSliderSetSprite : MonoBehaviour
{
    public GameObject parent;
    public GameObject handleFunny;
    public GameObject handle;
    public int oscNum;

    // Start is called before the first frame update
    void Start()
    {
        parent = transform.parent.gameObject;

        oscNum = parent.GetComponent<OscillatorControls>().oscNumber;
        handleFunny = transform.Find("Handle Slide Area").gameObject;
        handle = handleFunny.transform.Find("Handle").gameObject;
        handle.GetComponent<Image>().sprite = parent.GetComponent<OscillatorControls>().spritoes[oscNum];
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
