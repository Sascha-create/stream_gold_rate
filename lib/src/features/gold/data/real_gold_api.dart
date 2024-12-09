import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:stream_gold_rate/src/features/gold/data/api_key.dart';

double newPrice = 1000.0;

Stream<double> getRealGoldPriceStream() async* {
  yield* Stream<double>.periodic(const Duration(seconds: 5), (price) {
    getNewPrice();
    
      return newPrice.toDouble();
    
  });
}

void getNewPrice() async {
  double price = await getGoldPrice();
  newPrice = price;
}

Future<double> getGoldPrice() async {
  final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/goldprice'),
      headers: {'X-Api-Key': apiKey});
  final jsonData = response.body;

  final jsonObject = jsonDecode(jsonData);

  final double goldPrice = jsonObject['price'];

  return goldPrice;
}
