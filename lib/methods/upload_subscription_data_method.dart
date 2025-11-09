import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<void> uploadSubscriptionData() async {
  final firestore = FirebaseFirestore.instance;
  final subscriptions = [
    {
      "name": "Netflix",
      "iconUrl":
          "https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg",
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
          "https://upload.wikimedia.org/wikipedia/commons/1/19/Spotify_logo_without_text.svg",
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
          "https://upload.wikimedia.org/wikipedia/commons/e/ef/Youtube_logo.png",
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
          "https://upload.wikimedia.org/wikipedia/commons/0/04/ChatGPT_logo.svg",
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
          "https://upload.wikimedia.org/wikipedia/commons/3/3e/Disney%2B_logo.svg",
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
          "https://upload.wikimedia.org/wikipedia/commons/1/17/HBO_Max_Logo.svg",
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
          "https://upload.wikimedia.org/wikipedia/commons/d/df/Apple_Music_logo.svg",
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
          "https://upload.wikimedia.org/wikipedia/commons/5/5f/Adobe_Creative_Cloud_rainbow_icon.svg",
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
          "https://upload.wikimedia.org/wikipedia/commons/0/08/Canva_icon_2021.svg",
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
          "https://upload.wikimedia.org/wikipedia/commons/4/44/Microsoft_logo.svg",
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
