import 'package:liveinfo/services/location.dart';
import 'package:liveinfo/services/networking.dart';

const newsKeyApi = 'dec40d31557a419c8cd78a5dae46e2cb';
const newsApiUrl = 'http://newsapi.org/v2/top-headlines?country=us';

class News {
  Future<dynamic> getNewsData() async {
//    Location location = Location();
//    await location.getCurrentLocation();

    var url = '$newsApiUrl&apiKey=$newsKeyApi';
    NetworkHelper networkHelper = NetworkHelper(url);

    var newsData = await networkHelper.getData();
    return newsData;
  }
}
