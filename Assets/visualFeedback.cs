using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class visualFeedback : MonoBehaviour
{
    public Texture2D texToPass;

    // Update is called once per frame (as is onrenderimage)
    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Destroy(texToPass);
        texToPass = toTexture2D(src);

        Graphics.Blit(texToPass, dest);
    }

    Texture2D toTexture2D(RenderTexture rTex)
    {
        Texture2D tex = new Texture2D(Screen.width, Screen.height, TextureFormat.RGBA32, true);
        // ReadPixels looks at the active RenderTexture.
        RenderTexture.active = rTex;
        tex.ReadPixels(new Rect(0, 0, Screen.width, Screen.height), 0, 0);
        tex.Apply();
        texToPass = tex;

        return tex;

        Destroy(tex);
    }
}
