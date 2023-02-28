const GOOGLE_API_KEY = "AIzaSyB1Ha_m2fBeSQxtJYis5Y-tmhRz77C_KlE";

class LocationHelper {
  static String generateLocationPreview({double? longitude, double? latitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }
}
