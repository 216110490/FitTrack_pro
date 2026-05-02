import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tip_provider.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TipProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tips'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: provider.loadTip,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.errorMessage != null
                ? Center(child: Text(provider.errorMessage!))
                : Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.tips_and_updates, size: 40),
                          const SizedBox(height: 16),
                          Text(
                            provider.tip?.title ?? 'Fitness Tip',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            provider.tip?.body ??
                                'Press refresh to load a fitness tip.',
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'This screen demonstrates REST API integration with loading and error handling.',
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
