using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

public class BpmSyncFlash : MonoBehaviour
{
    [SerializeField] float _initialDelay = 1;
    [SerializeField] float _bpm = 120;
    [SerializeField] AnimationCurve _curve = null;

    HDAdditionalCameraData _camera;

    void Start()
      => _camera = Camera.main.GetComponent<HDAdditionalCameraData>();

    void Update()
    {
        var t = (Time.time - _initialDelay) / 60 * _bpm;
        if (t < 0) return;
        _camera.backgroundColorHDR = Color.white * _curve.Evaluate(t);
    }
}
