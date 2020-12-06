using UnityEngine;
using UnityEngine.Rendering.HighDefinition;

public class PositionToBGColor : MonoBehaviour
{
    [SerializeField] Transform _kickNode = null;
    [SerializeField] Transform _snareNode = null;

    HDAdditionalCameraData _camera;

    void Start()
      => _camera = Camera.main.GetComponent<HDAdditionalCameraData>();

    void Update()
    {
        var x = _kickNode.localPosition.y + _snareNode.localPosition.y;
        _camera.backgroundColorHDR = Color.white * x;
    }
}
