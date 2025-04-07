import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data - in a real app this would come from your backend
    final currentUserId = 'user5'; // The ID of the current logged-in user

    // Sample leaderboard data
    final streakData = [
      UserRanking(id: 'user1', name: 'Alex', value: 32, rank: 1),
      UserRanking(id: 'user2', name: 'Taylor', value: 28, rank: 2),
      UserRanking(id: 'user3', name: 'Jordan', value: 25, rank: 3),
      UserRanking(id: 'user4', name: 'Casey', value: 23, rank: 4),
      UserRanking(
          id: 'user5', name: 'Morgan', value: 20, rank: 5), // Current user
      UserRanking(id: 'user6', name: 'Riley', value: 18, rank: 6),
    ];

    final donateData = [
      UserRanking(id: 'user7', name: 'Jamie', value: 500, rank: 1),
      UserRanking(id: 'user8', name: 'Drew', value: 450, rank: 2),
      UserRanking(
          id: 'user5',
          name: 'Morgan',
          value: 400,
          rank: 3), // Current user in top 3
      UserRanking(id: 'user9', name: 'Sam', value: 350, rank: 4),
      UserRanking(id: 'user10', name: 'Avery', value: 300, rank: 5),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboards'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: LeaderboardWidget(
                    title: 'Streak',
                    rankings: streakData,
                    currentUserId: currentUserId,
                    valueLabel: 'days',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: LeaderboardWidget(
                    title: 'Donate',
                    rankings: donateData,
                    currentUserId: currentUserId,
                    valueLabel: '\$',
                    valuePrefix: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardWidget extends StatelessWidget {
  final String title;
  final List<UserRanking> rankings;
  final String currentUserId;
  final String valueLabel;
  final bool valuePrefix;

  const LeaderboardWidget({
    Key? key,
    required this.title,
    required this.rankings,
    required this.currentUserId,
    required this.valueLabel,
    this.valuePrefix = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Find current user ranking
    final currentUserRanking = rankings.firstWhere(
      (user) => user.id == currentUserId,
      orElse: () =>
          UserRanking(id: currentUserId, name: 'You', value: 0, rank: 0),
    );

    // Check if current user is in top 3
    final isCurrentUserInTop3 = currentUserRanking.rank <= 3;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: title == 'Streak' ? Colors.blue : Colors.orange,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Top 3 users
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Display top 3 users
                ...rankings.where((user) => user.rank <= 3).map(
                      (user) => LeaderboardItem(
                        user: user,
                        isCurrentUser: user.id == currentUserId,
                        valueLabel: valueLabel,
                        valuePrefix: valuePrefix,
                      ),
                    ),

                const Divider(height: 24),

                // Display current user if not in top 3
                if (!isCurrentUserInTop3)
                  LeaderboardItem(
                    user: currentUserRanking,
                    isCurrentUser: true,
                    valueLabel: valueLabel,
                    valuePrefix: valuePrefix,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderboardItem extends StatelessWidget {
  final UserRanking user;
  final bool isCurrentUser;
  final String valueLabel;
  final bool valuePrefix;

  const LeaderboardItem({
    Key? key,
    required this.user,
    required this.isCurrentUser,
    required this.valueLabel,
    this.valuePrefix = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color:
            isCurrentUser ? Colors.amber.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _getRankColor(user.rank),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${user.rank}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // User name
          Expanded(
            child: Text(
              user.name,
              style: TextStyle(
                fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Value
          Text(
            valuePrefix
                ? '$valueLabel${user.value}'
                : '${user.value} $valueLabel',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber.shade700; // Gold
      case 2:
        return Colors.grey.shade400; // Silver
      case 3:
        return Colors.brown.shade300; // Bronze
      default:
        return Colors.grey.shade600;
    }
  }
}

class UserRanking {
  final String id;
  final String name;
  final int value;
  final int rank;

  UserRanking({
    required this.id,
    required this.name,
    required this.value,
    required this.rank,
  });
}

// Example of how to use this widget in your main app
void main() {
  runApp(
    const MaterialApp(
      home: LeaderboardPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
