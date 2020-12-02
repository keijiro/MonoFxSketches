using UnityEngine;

[ExecuteInEditMode]
sealed class NoiseController : MonoBehaviour
{
    public float intensity
    {
        get => _intensity;
        set => _intensity = value;
    }

    [SerializeField] float _intensity = 0.5f;

    MaterialPropertyBlock _prop;

    void LateUpdate()
    {
        if (_prop == null) _prop = new MaterialPropertyBlock();
        _prop.SetFloat("_Intensity", _intensity);
        GetComponent<Renderer>().SetPropertyBlock(_prop);
    }
}
