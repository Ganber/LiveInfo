import 'package:liveinfo/services/networking.dart';

const stocksApiKey = 'bqjuu6frh5r9t8htdlhg';
const stocksUrl = 'https://finnhub.io/api/v1/quote';

const List<String> stocksSymbols = [
  'TSLA',
  'AMD',
  'NKE',
  'INTC',
  'IBM',
  'JNJ',
  'FB',
  'AAPL',
  'AMZN',
];

class Stocks {
  Future<dynamic> getOneStock(String symbol) async {
    var stock = 'symbol=$symbol';

    var url = '$stocksUrl?$stock&token=$stocksApiKey';
    NetworkHelper networkHelper = NetworkHelper(url);

    var response = await networkHelper.getData();
    return response;
  }

  Future<dynamic> getStocksData() async {
    List<dynamic> stocksList = List();

    for (var symbol in stocksSymbols) {
      var stock = await getOneStock(symbol);
      stocksList.add(stock);
    }

    return stocksList;
  }
}
