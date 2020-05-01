import 'package:flutter/material.dart';
import 'package:liveinfo/services/stocks.dart';

class StocksList extends StatefulWidget {
  final stocks;

  const StocksList(this.stocks);

  @override
  _StocksListState createState() => _StocksListState();
}

class _StocksListState extends State<StocksList>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  AnimationController _animationController;
  Animation animation;
  var stocksList;

  @override
  void initState() {
    super.initState();
    updateUI(widget.stocks);
    animateScrolling();
  }

  void updateUI(dynamic stocksData) {
    setState(() {
      stocksList = stocksData;
    });
  }

  void animateScrolling() {
    _animationController = AnimationController(
      duration: Duration(seconds: 8),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.ease, parent: _animationController));

    _animationController.forward();

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            curve: Curves.linear, duration: Duration(seconds: 8));
      });
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scrollController.animateTo(_scrollController.position.minScrollExtent,
            curve: Curves.linear, duration: Duration(seconds: 8));
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            curve: Curves.linear, duration: Duration(seconds: 8));
        _animationController.forward();
      }
    });
  }

  double getStockDiff(int index) {
    double price = double.parse(stocksList[index]['c'].toString());
    double open = double.parse(stocksList[index]['o'].toString());

    if (price == null || open == null) {
      return 0;
    }

    return price - open;
  }

  String getStockPrice(int index) {
    if (stocksList[index]['c'] == null) {
      return '0';
    }
    return ': ${stocksList[index]['c'].toString()}';
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: stocksList.length,
        itemBuilder: (context, index) {
          double diffPrice = getStockDiff(index);
          String symbol = diffPrice > 0 ? '▲' : '▼';

          return Card(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.blueGrey[300]
                : Colors.blueGrey[900],
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    '${stocksSymbols[index]} ${getStockPrice(index)}',
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text('$symbol${diffPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: diffPrice > 0 ? Colors.green : Colors.red)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
