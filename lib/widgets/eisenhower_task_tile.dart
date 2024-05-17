import 'package:flutter/material.dart';

class eisenhowerTaskTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Eisenhower Matrix',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusCard(
                color: Colors.purple.shade200,
                icon: Icons.loop,
                label: 'Do',
              ),
              _buildStatusCard(
                color: Colors.orange.shade200,
                icon: Icons.access_time,
                label: 'Plan',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusCard(
                color: Colors.green.shade200,
                icon: Icons.check_box,
                label: 'Delegate',
              ),
              _buildStatusCard(
                color: Colors.red.shade200,
                icon: Icons.cancel,
                label: 'Reduce',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard({
    required Color color,
    required IconData icon,
    required String label,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
