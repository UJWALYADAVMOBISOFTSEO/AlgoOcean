import 'package:algoocean/Features/Home/data/api_services/api_provider.dart';
import 'package:algoocean/Features/Home/data/model/HomeModal.dart';

class HomeRepository {
  final HomeApiServices _apiProvider = HomeApiServices();

  Future<HomeModal> getHomeData() {
    return _apiProvider.getHomeData();
  }
}
