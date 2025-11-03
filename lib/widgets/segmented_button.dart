import 'package:flutter/material.dart';
import 'package:subtrack/utils/utils.dart';
import 'package:subtrack/widgets/text.dart';

class CustomSegmentedButton extends StatefulWidget {
  const CustomSegmentedButton({super.key});

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  //****************************************CONVERT TO PROVIDER ****************************
  Set<String> selected = {"yourSubscriptions"};

  void updatedSelected(Set<String> newSelection) {
    setState(() {
      selected = newSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SegmentedButton(
              emptySelectionAllowed: true,
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: "yourSubscriptions",
                  label: BuildText(text: "Your Subscriptions", textSize: 14),
                ),
              ],
              selected:
                  selected.contains("yourSubscriptions")
                      ? {"yourSubscriptions"}
                      : {},
              onSelectionChanged: (_) => updatedSelected({"yourSubscriptions"}),
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor:
                    selected.contains("yourSubscriptions")
                        ? colorScheme.surfaceContainerHigh
                        : colorScheme.surfaceContainerLowest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: BorderSide(color: transparentClr),
              ),
            ),
          ),
          const SizedBox(width: 10), // 👈 creates visual separation
          Expanded(
            child: SegmentedButton(
              emptySelectionAllowed: true,
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                  value: "upcomingDues",
                  label: BuildText(text: "Upcoming Dues", textSize: 14),
                ),
              ],
              selected:
                  selected.contains("upcomingDues") ? {"upcomingDues"} : {},
              onSelectionChanged: (_) => updatedSelected({"upcomingDues"}),
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor:
                    selected.contains("upcomingDues")
                        ? colorScheme.surfaceContainerHigh
                        : colorScheme.surfaceContainerLowest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: BorderSide(color: transparentClr),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.red,
                  //     borderRadius: BorderRadius.circular(40),
                  //   ),
                  //   padding: EdgeInsets.all(10),
                  //   child: SegmentedButton(
                  //     showSelectedIcon: false,
                  //     style: SegmentedButton.styleFrom(
                  //       backgroundColor: colorScheme.surface,
                  //       foregroundColor: colorScheme.onSurface,
                  //       selectedBackgroundColor: colorScheme.surfaceContainer,
                  //       selectedForegroundColor: colorScheme.onSurface,
                  //       side: BorderSide(color: Colors.blue),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //     ),
                  //     segments: [
                  //       ButtonSegment(
                  //         value: "yourSubscriptions",
                  //         label: Text("Your Subscriptions"),
                  //       ),
                  //       ButtonSegment(
                  //         value: "upcomingDues",
                  //         label: Text("Upcoming Dues"),
                  //       ),
                  //     ],
                  //     selected: selected,
                  //     onSelectionChanged: updatedSelected,
                  //   ),
                  // ),