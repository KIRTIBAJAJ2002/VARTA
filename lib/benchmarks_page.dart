import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class BenchmarksSection extends StatelessWidget {
  const BenchmarksSection({Key? key}) : super(key: key);

  final List<String> sliderItems = const [
    "Benchmark 1: Speech Recognition Accuracy",
    "Benchmark 2: Customer Satisfaction Rate",
    "Benchmark 3: Reduction in Call Handling Time",
    "Benchmark 4: Uptime and Reliability",
  ]; @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final List<Widget> cards = sliderItems.map((note) {
      return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: 1.5, // Rectangular shape (wider than tall)
            child: Center(
              child: Text(
                note,
                style: TextStyle(fontSize: width > 600 ? 18 : 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }).toList();

    final List<String> titles = List.generate(sliderItems.length, (_) => '');

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000), // Increased container width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Benchmarks',
              style: TextStyle(fontSize: width > 600 ? 36 : 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: width > 600 ? 600 : 400, // Adjusted height for smaller screens
              child: VerticalCardPager(
                titles: titles,
                images: cards,
                onPageChanged: (page) {},
                onSelectedItem: (index) {},
                initialPage: 0,
                align: ALIGN.CENTER,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





