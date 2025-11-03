import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/widgets/segmented_button.dart';
import 'package:subtrack/widgets/text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surfaceContainer,
        title: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage("assets/images/faces18.png"),
            ),
            SizedBox(width: 10),
            BuildText(
              text: "Welcome Back,\nXain Ahmad!",
              textSize: 18,
              textWeight: FontWeight.w700,
            ),
            /* 
            BuildText(
              text: "SubTrack .",
              textSize: 32,
              textWeight: FontWeight.w900,textFont: primaryFont,
            ),
            */
          ],
        ),
        actionsPadding: EdgeInsets.only(right: 6),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/history.svg",
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/notification.svg",
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/settings.svg",
              colorFilter: ColorFilter.mode(
                colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          BgContainer(
            screenW: screenW,
            screenH: screenH,
            color: colorScheme.surfaceContainer,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SizedBox(
              width: screenW,
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Card(
                    color: colorScheme.surfaceContainerHigh,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: colorScheme.surfaceContainerLowest,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              BuildText(text: "Monthly Bills", textSize: 16),
                              Spacer(),
                              BuildText(text: "Daily", textSize: 12),
                              SizedBox(width: 20),
                              BuildText(text: "Weekly", textSize: 12),
                              SizedBox(width: 20),
                              BuildText(text: "Monthly", textSize: 12),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BuildText(
                                text: "\$1,532",
                                textSize: 32,
                                textWeight: FontWeight.w700,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: colorScheme.surface,
                                  side: BorderSide(
                                    color: colorScheme.surfaceContainerLowest,
                                    width: 1,
                                  ),
                                ),
                                onPressed: () {},
                                child: BuildText(
                                  text: "View your stats",
                                  textSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Card(
                          color: colorScheme.surfaceContainerHigh,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: colorScheme.surfaceContainerLowest,
                            ),
                          ),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
                              child: Column(
                                children: [
                                  BuildText(
                                    text: "Maximum Subs",
                                    textSize: 14,
                                    textWeight: FontWeight.w500,
                                  ),
                                  BuildText(
                                    text: "\$80",
                                    textSize: 26,
                                    textWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: colorScheme.surfaceContainerHigh,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: colorScheme.surfaceContainerLowest,
                            ),
                          ),
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 14,
                              ),
                              child: Column(
                                children: [
                                  BuildText(
                                    text: "Active Subs",
                                    textSize: 14,
                                    textWeight: FontWeight.w500,
                                  ),
                                  BuildText(
                                    text: "10",
                                    textSize: 26,
                                    textWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomSegmentedButton(),
                  SizedBox(height: 15),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 40,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: colorScheme.surfaceContainerHigh,
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(
                              "assets/images/faces18.png",
                            ),
                          ),
                          title: BuildText(
                            text: "Spotify Premium",
                            textSize: 14,
                          ),
                          subtitle: BuildText(
                            text: "Expires in 3 days",
                            textSize: 12,
                            textClr: Colors.red,
                          ),
                          trailing: BuildText(
                            text: "\$9.99 / MO",
                            textSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
 Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: colorScheme.surface, // outer container
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _selectedIndex = 0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color:
                                    _selectedIndex == 0
                                        ? colorScheme.surfaceContainerHighest
                                        : colorScheme.surface,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Your Subscriptions",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      _selectedIndex == 0
                                          ? colorScheme.onSurface
                                          : colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() => _selectedIndex = 1),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color:
                                    _selectedIndex == 1
                                        ? colorScheme.surfaceContainerHighest
                                        : colorScheme.surface,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Upcoming Dues",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      _selectedIndex == 1
                                          ? colorScheme.onSurface
                                          : colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
 */


/*
Card(
  color: Theme.of(context).colorScheme.surfaceContainer,
  elevation: 2,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon or logo
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/images/netflix.png'),
        ),
        const SizedBox(width: 16),

        // Text info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Netflix Premium",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Monthly Subscription • ₹1,100",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Renews on 5 Nov 2025",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
        ),

        // Optional trailing action
        Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurface),
      ],
    ),
  ),
)

 */