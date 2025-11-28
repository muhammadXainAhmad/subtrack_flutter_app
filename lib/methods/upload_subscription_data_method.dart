import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<void> uploadSubscriptionData() async {
  final firestore = FirebaseFirestore.instance;
  final subscriptions = [
    {
      "name": "Netflix",
      "iconUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Netflix_2015_logo.svg/512px-Netflix_2015_logo.svg.png",
      "category": "Entertainment",
      "website": "https://www.netflix.com",
      "plans": [
        {
          "name": "Mobile",
          "price": 250,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Basic",
          "price": 450,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Standard",
          "price": 800,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Premium",
          "price": 1100,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },
    {
      "name": "Spotify",
      "iconUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Spotify_logo_without_text.svg/250px-Spotify_logo_without_text.svg.png",
      "category": "Music",
      "website": "https://www.spotify.com",
      "plans": [
        {
          "name": "Individual",
          "price": 299,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Duo",
          "price": 390,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Family",
          "price": 479,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Student",
          "price": 149,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },
    {
      "name": "YouTube Premium",
      "iconUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbp_NWLckKr9VPB180t8lPqVv0XAUR88na1g&s",
      "category": "Entertainment",
      "website": "https://www.youtube.com/premium",
      "plans": [
        {
          "name": "Individual",
          "price": 479,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Family",
          "price": 899,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Student",
          "price": 329,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },
    {
      "name": "ChatGPT Plus",
      "iconUrl":
          "https://static.vecteezy.com/system/resources/previews/021/059/827/non_2x/chatgpt-logo-chat-gpt-icon-on-white-background-free-vector.jpg",
      "category": "Productivity",
      "website": "https://chat.openai.com",
      "plans": [
        {
          "name": "Plus",
          "price": 5500,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },
    {
      "name": "Disney+",
      "iconUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Disney%2B_logo.svg/250px-Disney%2B_logo.svg.png",
      "category": "Entertainment",
      "website": "https://www.disneyplus.com",
      "plans": [
        {
          "name": "Monthly",
          "price": 799,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Annual",
          "price": 7999,
          "currency": "PKR",
          "billingCycle": "Yearly",
        },
      ],
    },
    {
      "name": "Amazon Prime Video",
      "iconUrl":
          "https://upload.wikimedia.org/wikipedia/commons/f/f1/Prime_Video.png",
      "category": "Entertainment",
      "website": "https://www.primevideo.com",
      "plans": [
        {
          "name": "Monthly",
          "price": 570,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Annual",
          "price": 5700,
          "currency": "PKR",
          "billingCycle": "Yearly",
        },
      ],
    },
    {
      "name": "HBO Max",
      "iconUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/HBO_Max_Logo.svg/512px-HBO_Max_Logo.svg.png",
      "category": "Entertainment",
      "website": "https://www.hbomax.com",
      "plans": [
        {
          "name": "With Ads",
          "price": 699,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Ad-Free",
          "price": 999,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Ultimate Ad-Free",
          "price": 1199,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },
    {
      "name": "Apple Music",
      "iconUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-SIOh8VlhZgdD5l2irbSJKz8DPMUTfIGM8A&s",
      "category": "Music",
      "website": "https://www.music.apple.com",
      "plans": [
        {
          "name": "Individual",
          "price": 299,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Family",
          "price": 479,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Student",
          "price": 149,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },
    {
      "name": "Adobe Creative Cloud",
      "iconUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Adobe_Creative_Cloud_rainbow_icon.svg/250px-Adobe_Creative_Cloud_rainbow_icon.svg.png",
      "category": "Productivity",
      "website": "https://www.adobe.com/creativecloud.html",
      "plans": [
        {
          "name": "All Apps",
          "price": 9000,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Photography",
          "price": 1800,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Illustrator",
          "price": 2200,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },
    {
      "name": "Canva Pro",
      "iconUrl":
          "https://1000logos.net/wp-content/uploads/2020/03/Canva-icon.png",
      "category": "Productivity",
      "website": "https://www.canva.com",
      "plans": [
        {
          "name": "Pro",
          "price": 1799,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Teams",
          "price": 3499,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },
    {
      "name": "Microsoft 365",
      "iconUrl":
          "https://cdn-icons-png.flaticon.com/512/732/732222.png",
      "category": "Productivity",
      "website": "https://www.microsoft.com/microsoft-365",
      "plans": [
        {
          "name": "Personal",
          "price": 1450,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Family",
          "price": 1950,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Business Standard",
          "price": 2400,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },
  ];

  // Supporting data
  final billingCycles = ["Monthly", "Quarterly", "Yearly"];
  final paymentModes = ["Credit Card", "Debit Card", "JazzCash", "EasyPaisa"];
  final notificationAlerts = ["1 Day Before", "3 Days Before", "1 Week Before"];

  // Upload subscriptions
  for (final sub in subscriptions) {
    final docId = sub['name'].toString().toLowerCase().replaceAll(' ', '_');
    await firestore.collection('subscriptions').doc(docId).set(sub);
  }

  // Upload other collections
  for (final cycle in billingCycles) {
    await firestore.collection('billingCycles').doc(cycle.toLowerCase()).set({
      "label": cycle,
    });
  }

  for (final mode in paymentModes) {
    await firestore
        .collection('paymentModes')
        .doc(mode.toLowerCase().replaceAll(' ', '_'))
        .set({"label": mode});
  }

  for (final alert in notificationAlerts) {
    await firestore
        .collection('notificationAlerts')
        .doc(alert.toLowerCase().replaceAll(' ', '_'))
        .set({"label": alert});
  }

  if (kDebugMode) {
    print("✅ Firestore seeding complete!");
  }
}


Future<void> updateSubscriptionIcons() async {
  final firestore = FirebaseFirestore.instance;

  // Map of subscription names to their new icon URLs
  final Map<String, String> iconUpdates = {
    "Netflix":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Netflix_2015_logo.svg/512px-Netflix_2015_logo.svg.png",
    "Spotify":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Spotify_logo_without_text.svg/250px-Spotify_logo_without_text.svg.png",
    "YouTube Premium":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbp_NWLckKr9VPB180t8lPqVv0XAUR88na1g&s",
    "ChatGPT Plus":
        "https://static.vecteezy.com/system/resources/previews/021/059/827/non_2x/chatgpt-logo-chat-gpt-icon-on-white-background-free-vector.jpg",
    "Disney+":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Disney%2B_logo.svg/250px-Disney%2B_logo.svg.png",
    "Amazon Prime Video":
        "https://upload.wikimedia.org/wikipedia/commons/f/f1/Prime_Video.png",
    "HBO Max":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/HBO_Max_Logo.svg/512px-HBO_Max_Logo.svg.png",
    "Apple Music":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-SIOh8VlhZgdD5l2irbSJKz8DPMUTfIGM8A&s",
    "Adobe Creative Cloud":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Adobe_Creative_Cloud_rainbow_icon.svg/250px-Adobe_Creative_Cloud_rainbow_icon.svg.png",
    "Canva Pro":
        "https://1000logos.net/wp-content/uploads/2020/03/Canva-icon.png",
    "Microsoft 365":
        "https://cdn-icons-png.flaticon.com/512/732/732222.png",
  };

  for (final entry in iconUpdates.entries) {
    final docId = entry.key.toLowerCase().replaceAll(' ', '_');

    try {
      await firestore
          .collection('subscriptions')
          .doc(docId)
          .update({"iconUrl": entry.value});
      if (kDebugMode) {
        print("✅ Updated iconUrl for ${entry.key}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("❌ Failed to update ${entry.key}: $e");
      }
    }
  }
}