import 'package:dio/dio.dart';
import 'package:food_store/core/core.dart';
import 'package:food_store/data/data.dart';
import 'package:food_store/data/main/main.dart';
import 'package:food_store/data/main/main_screen/models/models.dart';
import 'package:get_it/get_it.dart';

class StocksApi {
  Future<List<StockModel>> getStockApi({int? limit}) async {
    String isLimit = limit != null ? '$limit' : '';
    try {
      var response = await GetIt.I<Dio>().request(
        '$urlApi/Inventory/low-stock-products?limit=$isLimit',
        options: Options(method: 'GET'),
      );

      List stocksApi = response.data;

      List<StockModel> stockList = [];

      for (var i = 0; i < stocksApi.length; i++) {
        stockList.add(StockModel.fromJson(stocksApi[i]));
      }

      return stockList;
    } on Exception catch (e, st) {
      Logger().handle(e, st);
      return [];
    }
  }
}
