import 'package:flutter/material.dart';

class LiveSeatsWidget extends StatelessWidget {
  final int seatCount;
  final Function(int seatIndex) onSeatTap;

  const LiveSeatsWidget({
    super.key,
    this.seatCount = 6,
    required this.onSeatTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: seatCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onSeatTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.amberAccent.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.purple.withOpacity(0.4),
                    child: const Icon(
                      Icons.mic_none_rounded,
                      color: Colors.amberAccent,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'مقعد ${index + 1}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
