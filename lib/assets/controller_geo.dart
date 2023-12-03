
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxBool _isload = true.obs;
  final RxDouble _latitud = 0.0.obs;
  final RxDouble _longitud = 0.0.obs;

  RxBool checkLoad() => _isload;
  RxDouble getLatitud() => _latitud;
  RxDouble getLongitud() => _longitud;

 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(_isload.isTrue){
      getLocation();
    }
  }

  getLocation() async{
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isServiceEnabled){
      return Future.error('Location not enable');
    }

    locationPermission = await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.deniedForever){
      return Future.error('Location permission denied forever');
    }else if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied){
        return Future.error('Location permission denied');
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high).then((value) 
      {
        _latitud.value = value.latitude;
        _longitud.value = value.longitude;
        _isload.value = false;
      });
  }

}