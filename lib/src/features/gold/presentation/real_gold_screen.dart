import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stream_gold_rate/src/features/gold/data/real_gold_api.dart';

class RealGoldScreen extends StatelessWidget {
  const RealGoldScreen({super.key});
  @override
  Widget build(BuildContext context) {
    /// Platzhalter für den Goldpreis
    /// soll durch den Stream `getGoldPriceStream()` ersetzt werden
    double? goldPrice = 69.22;
    //double newPrice = 1000.0;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Text('Live Kurs:',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              // TODO: Verwende einen StreamBuilder, um den Goldpreis live anzuzeigen
              // statt des konstanten Platzhalters
              StreamBuilder(
                stream: getRealGoldPriceStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.active) {
                    goldPrice = snapshot.data;
                    return Text(
                      NumberFormat.simpleCurrency(locale: 'de_DE')
                          .format(goldPrice),
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: Theme.of(context).colorScheme.primary),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Image(
          image: AssetImage('assets/bars.png'),
          width: 100,
        ),
        Text('Gold', style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}
