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
      "color": "#E50914",
      "rating": 4.8,
      "description":
          "Netflix offers a wide selection of movies, TV shows, and exclusive original content across all genres.",
      "features": [
        "Huge library of movies & shows",
        "High-quality streaming",
        "Multiple profiles",
        "Offline downloads",
        "4K HDR available",
      ],
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
      "color": "#1DB954",
      "rating": 4.9,
      "description":
          "Spotify provides access to millions of songs, podcasts, and personalized playlists.",
      "features": [
        "Personalized playlists",
        "High-quality music streaming",
        "Offline downloads",
        "Podcasts",
        "Cross-device sync",
      ],
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
      "color": "#FF0000",
      "rating": 4.7,
      "description":
          "YouTube Premium removes ads, enables background play, and includes YouTube Music.",
      "features": [
        "Ad-free videos",
        "Background play",
        "Offline downloads",
        "YouTube Music included",
        "Exclusive content",
      ],
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
      "color": "#10A37F",
      "rating": 4.9,
      "description":
          "ChatGPT Plus provides faster responses, priority access, and the latest GPT models.",
      "features": [
        "Access to GPT-4.1",
        "Priority availability",
        "Faster responses",
        "Advanced reasoning",
        "Tools & plugins",
      ],
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
      "color": "#113CCF",
      "rating": 4.6,
      "description":
          "Disney+ offers movies and shows from Disney, Marvel, Pixar, Star Wars and National Geographic.",
      "features": [
        "Disney, Marvel, Pixar & Star Wars",
        "4K HDR streaming",
        "Download for offline viewing",
        "Ad-free experience",
        "Kid profiles",
      ],
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
      "color": "#00A8E1",
      "rating": 4.5,
      "description":
          "Prime Video includes thousands of movies and original series with HD and 4K support.",
      "features": [
        "Amazon Originals",
        "4K HDR content",
        "Offline watching",
        "Multiple profiles",
        "X-Ray info for scenes",
      ],
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
      "color": "#5B38FF",
      "rating": 4.4,
      "description":
          "HBO Max features HBO classics, Max Originals, movies, and premium award-winning shows.",
      "features": [
        "HBO Originals",
        "High-quality streaming",
        "Offline downloads",
        "Exclusive Max content",
        "Kid profiles",
      ],
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
      "color": "#FA2D48",
      "rating": 4.8,
      "description":
          "Apple Music offers high-quality music streaming with lossless and spatial audio support.",
      "features": [
        "Lossless audio",
        "Dolby Atmos spatial sound",
        "Lyrics view",
        "Offline listening",
        "Personalized mixes",
      ],
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
      "color": "#ED2224",
      "rating": 4.7,
      "description":
          "Adobe Creative Cloud offers industry-standard tools for design, video editing, and creativity.",
      "features": [
        "Photoshop, Illustrator, Premiere Pro",
        "Cloud storage",
        "Cross-platform sync",
        "Fonts & stock assets",
        "Professional-grade tools",
      ],
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
      "color": "#00C4CC",
      "rating": 4.8,
      "description":
          "Canva is a design platform that enables easy creation of graphics, posts, and presentations.",
      "features": [
        "Drag-and-drop editor",
        "Premium templates",
        "Brand kits",
        "Team collaboration",
        "Unlimited cloud storage",
      ],
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
      "iconUrl": "https://cdn-icons-png.flaticon.com/512/732/732222.png",
      "category": "Productivity",
      "website": "https://www.microsoft.com/microsoft-365",
      "color": "#F25022",
      "rating": 4.7,
      "description":
          "Microsoft 365 provides access to Word, Excel, PowerPoint, OneDrive, and Teams with cloud sync.",
      "features": [
        "Office apps",
        "1TB OneDrive",
        "Real-time collaboration",
        "Cloud backup",
        "Cross-device access",
      ],
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

    {
      "name": "LinkedIn Premium",
      "iconUrl":
          "https://upload.wikimedia.org/wikipedia/commons/c/ca/LinkedIn_logo_initials.png",
      "category": "Productivity",
      "website": "https://www.linkedin.com/premium",
      "color": "#0A66C2",
      "rating": 4.5,
      "description":
          "LinkedIn Premium gives professional networking features, insights, and learning resources.",
      "features": [
        "InMail messaging",
        "Profile insights",
        "Learning courses",
        "Job insights",
        "Open profile access",
      ],
      "plans": [
        {
          "name": "Career",
          "price": 2300,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Business",
          "price": 4500,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },

    {
      "name": "Notion",
      "iconUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgI_LaFz94ki9oLRxzjB88ZInTeJzXkWLdBQ&s",
      "category": "Productivity",
      "website": "https://www.notion.so",
      "color": "#000000",
      "rating": 4.8,
      "description":
          "Notion is an all-in-one workspace for notes, docs, and project management.",
      "features": [
        "Notes & databases",
        "Templates",
        "Team collaboration",
        "Cross-device sync",
        "Task management",
      ],
      "plans": [
        {
          "name": "Plus",
          "price": 1100,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Business",
          "price": 2100,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },

    {
      "name": "Slack",
      "iconUrl":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Slack_icon_2019.svg/512px-Slack_icon_2019.svg.png",
      "category": "Productivity",
      "website": "https://slack.com",
      "color": "#4A154B",
      "rating": 4.7,
      "description":
          "Slack is a messaging app for teams that brings all communication together in one place.",
      "features": [
        "Channels for team communication",
        "File sharing",
        "Integration with apps",
        "Video/voice calls",
        "Searchable message history",
      ],
      "plans": [
        {
          "name": "Pro",
          "price": 2500,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "Business+",
          "price": 4500,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },

    {
      "name": "Google One",
      "iconUrl":
          "https://upload.wikimedia.org/wikipedia/commons/0/02/Google_One_logo.png",
      "category": "Cloud Storage",
      "website": "https://one.google.com",
      "color": "#4285F4",
      "rating": 4.7,
      "description":
          "Google One expands your storage for Drive, Gmail, and Photos with premium backup features.",
      "features": [
        "Cloud backup",
        "Automatic phone backup",
        "Extra storage for Gmail & Photos",
        "Family sharing",
        "Google support",
      ],
      "plans": [
        {
          "name": "100 GB",
          "price": 350,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "200 GB",
          "price": 550,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
        {
          "name": "2 TB",
          "price": 1800,
          "currency": "PKR",
          "billingCycle": "Monthly",
        },
      ],
    },
  ];

  // final originalSubscriptions = [
  //   {
  //     "name": "Netflix",
  //     "iconUrl":
  //         "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Netflix_2015_logo.svg/512px-Netflix_2015_logo.svg.png",
  //     "category": "Entertainment",
  //     "website": "https://www.netflix.com",
  //     "plans": [
  //       {
  //         "name": "Mobile",
  //         "price": 250,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Basic",
  //         "price": 450,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Standard",
  //         "price": 800,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Premium",
  //         "price": 1100,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //     ],
  //   },
  //   {
  //     "name": "Spotify",
  //     "iconUrl":
  //         "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Spotify_logo_without_text.svg/250px-Spotify_logo_without_text.svg.png",
  //     "category": "Music",
  //     "website": "https://www.spotify.com",
  //     "plans": [
  //       {
  //         "name": "Individual",
  //         "price": 299,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Duo",
  //         "price": 390,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Family",
  //         "price": 479,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Student",
  //         "price": 149,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //     ],
  //   },
  //   {
  //     "name": "YouTube Premium",
  //     "iconUrl":
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbp_NWLckKr9VPB180t8lPqVv0XAUR88na1g&s",
  //     "category": "Entertainment",
  //     "website": "https://www.youtube.com/premium",
  //     "plans": [
  //       {
  //         "name": "Individual",
  //         "price": 479,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Family",
  //         "price": 899,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Student",
  //         "price": 329,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //     ],
  //   },
  //   {
  //     "name": "ChatGPT Plus",
  //     "iconUrl":
  //         "https://static.vecteezy.com/system/resources/previews/021/059/827/non_2x/chatgpt-logo-chat-gpt-icon-on-white-background-free-vector.jpg",
  //     "category": "Productivity",
  //     "website": "https://chat.openai.com",
  //     "plans": [
  //       {
  //         "name": "Plus",
  //         "price": 5500,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //     ],
  //   },
  //   {
  //     "name": "Disney+",
  //     "iconUrl":
  //         "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Disney%2B_logo.svg/250px-Disney%2B_logo.svg.png",
  //     "category": "Entertainment",
  //     "website": "https://www.disneyplus.com",
  //     "plans": [
  //       {
  //         "name": "Monthly",
  //         "price": 799,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Annual",
  //         "price": 7999,
  //         "currency": "PKR",
  //         "billingCycle": "Yearly",
  //       },
  //     ],
  //   },
  //   {
  //     "name": "Amazon Prime Video",
  //     "iconUrl":
  //         "https://upload.wikimedia.org/wikipedia/commons/f/f1/Prime_Video.png",
  //     "category": "Entertainment",
  //     "website": "https://www.primevideo.com",
  //     "plans": [
  //       {
  //         "name": "Monthly",
  //         "price": 570,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Annual",
  //         "price": 5700,
  //         "currency": "PKR",
  //         "billingCycle": "Yearly",
  //       },
  //     ],
  //   },
  //   {
  //     "name": "HBO Max",
  //     "iconUrl":
  //         "https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/HBO_Max_Logo.svg/512px-HBO_Max_Logo.svg.png",
  //     "category": "Entertainment",
  //     "website": "https://www.hbomax.com",
  //     "plans": [
  //       {
  //         "name": "With Ads",
  //         "price": 699,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Ad-Free",
  //         "price": 999,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Ultimate Ad-Free",
  //         "price": 1199,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //     ],
  //   },
  //   {
  //     "name": "Apple Music",
  //     "iconUrl":
  //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-SIOh8VlhZgdD5l2irbSJKz8DPMUTfIGM8A&s",
  //     "category": "Music",
  //     "website": "https://www.music.apple.com",
  //     "plans": [
  //       {
  //         "name": "Individual",
  //         "price": 299,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Family",
  //         "price": 479,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Student",
  //         "price": 149,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //     ],
  //   },
  //   {
  //     "name": "Adobe Creative Cloud",
  //     "iconUrl":
  //         "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Adobe_Creative_Cloud_rainbow_icon.svg/250px-Adobe_Creative_Cloud_rainbow_icon.svg.png",
  //     "category": "Productivity",
  //     "website": "https://www.adobe.com/creativecloud.html",
  //     "plans": [
  //       {
  //         "name": "All Apps",
  //         "price": 9000,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Photography",
  //         "price": 1800,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Illustrator",
  //         "price": 2200,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //     ],
  //   },
  //   {
  //     "name": "Canva Pro",
  //     "iconUrl":
  //         "https://1000logos.net/wp-content/uploads/2020/03/Canva-icon.png",
  //     "category": "Productivity",
  //     "website": "https://www.canva.com",
  //     "plans": [
  //       {
  //         "name": "Pro",
  //         "price": 1799,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Teams",
  //         "price": 3499,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //     ],
  //   },
  //   {
  //     "name": "Microsoft 365",
  //     "iconUrl": "https://cdn-icons-png.flaticon.com/512/732/732222.png",
  //     "category": "Productivity",
  //     "website": "https://www.microsoft.com/microsoft-365",
  //     "plans": [
  //       {
  //         "name": "Personal",
  //         "price": 1450,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Family",
  //         "price": 1950,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //       {
  //         "name": "Business Standard",
  //         "price": 2400,
  //         "currency": "PKR",
  //         "billingCycle": "Monthly",
  //       },
  //     ],
  //   },
  // ];

  // Supporting data
  // final billingCycles = ["Monthly", "Quarterly", "Yearly"];
  final paymentModes = ["Credit Card", "Debit Card", "JazzCash", "EasyPaisa"];
  final notificationAlerts = ["1 Day Before", "3 Days Before", "1 Week Before"];

  // Upload subscriptions
  for (final sub in subscriptions) {
    final docId = sub['name'].toString().toLowerCase().replaceAll(' ', '_');
    await firestore.collection('subscriptions').doc(docId).set(sub);
  }

  // Upload other collections
  // for (final cycle in billingCycles) {
  //   await firestore.collection('billingCycles').doc(cycle.toLowerCase()).set({
  //     "label": cycle,
  //   });
  // }

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
    "Microsoft 365": "https://cdn-icons-png.flaticon.com/512/732/732222.png",
  };

  for (final entry in iconUpdates.entries) {
    final docId = entry.key.toLowerCase().replaceAll(' ', '_');

    try {
      await firestore.collection('subscriptions').doc(docId).update({
        "iconUrl": entry.value,
      });
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
