import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class BenchmarksSection extends StatelessWidget {
  const BenchmarksSection({Key? key}) : super(key: key);

  // List of 4 slider items
  final List<String> sliderItems = const [
    "Benchmark 1: Performance is top-notch.",
    "Benchmark 2: Scalability exceeds expectations.",
    "Benchmark 3: Reliability is industry-leading.",
    "Benchmark 4: Exceptional security and integration.",
  ];

  @override
  Widget build(BuildContext context) {
    // Build a list of card widgets from the slider items.
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
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }).toList();

    // Provide required titles as a list of empty strings.
    final List<String> titles = List.generate(sliderItems.length, (_) => '');

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000), // Increased container width
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Benchmarks',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 600, // Increased height for the carousel
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
