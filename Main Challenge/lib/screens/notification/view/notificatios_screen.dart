import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/components/buy_full_ui_kit.dart';







class NotificationScreen extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Molestic libero neque sem cras enim, amet.',
      time: '2 min ago',
    ),
    NotificationItem(
      title: 'Egestas nisl sapien amet lectus molestie id euismod.',
      time: '6 hours ago',
    ),
    NotificationItem(
      title: 'Ullamcorper ac ornare ipsum ut sed integer turpis felis viverra…',
      time: '4 days ago',
    ),
    NotificationItem(
      title: 'Facilisis in proin ultrices in tincidunt adipiscing turpis praesent non.',
      time: '5 days ago',
    ),
    NotificationItem(
      title: 'Pellentesque proin risus pellentesque odio a.',
      time: '1 week ago',
    ),
    NotificationItem(
      title: 'Enim, proin ac ut nullam nec.',
      time: '1 week ago',
    ),
    NotificationItem(
      title: 'Molestic libero neque sem cras enim, amet.',
      time: '1 week ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(notification: notifications[index]);
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String time;

  NotificationItem({
    required this.title,
    required this.time,
  });
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(84, 58, 50, 1), // ✅ Change card background color
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              notification.time,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("Notifications"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/DotsV.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
          )
        ],
      ),
      body: NotificationScreen(),
    );
  }
}
