import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtrack/methods/helper_methods.dart';
import 'package:subtrack/providers/explore_provider.dart';
import 'package:subtrack/widgets/text.dart';
import 'package:subtrack/widgets/bg_container.dart';
import 'package:subtrack/screens/explore_subscription_screen.dart';
import 'package:subtrack/utils/utils.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (_) => ExploreProvider(),
      child: Consumer<ExploreProvider>(
        builder: (context, provider, _) {
          return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              searchController.clear();
              provider.clearSearch();
            },
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: colorScheme.surfaceContainer,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: BuildText(
                      text: "Explore",
                      textSize: 20,
                      textWeight: FontWeight.w700,
                    ),
                  ),
                ),
                body: Stack(
                  children: [
                    BgContainer(screenW: screenW, screenH: screenH),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          TextField(
                            controller: searchController,
                            style: TextStyle(fontSize: 14),
                            textAlignVertical: TextAlignVertical.center,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  provider.clearSearch();
                                  searchController.clear();
                                },
                                child:
                                    searchController.text.isEmpty
                                        ? SizedBox.shrink()
                                        : Icon(Icons.close),
                              ),
                              fillColor: colorScheme.surfaceContainerHigh,
                              filled: true,
                              hintText: "Search subscriptions",
                              hintStyle: TextStyle(fontSize: 14),
                              prefixIcon: Icon(Icons.search),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: colorScheme.surfaceContainerLowest,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: colorScheme.surfaceContainerLowest,
                                ),
                              ),
                            ),
                            onChanged: provider.filterSearch,
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child:
                                provider.isLoading
                                    ? Center(
                                      child: CircularProgressIndicator(
                                        color: colorScheme.onSurface,
                                        strokeWidth: 1.5,
                                      ),
                                    )
                                    : provider.filteredSubs.isEmpty
                                    ? Center(
                                      child: BuildText(
                                        text: "No subscriptions found",
                                        textSize: 14,
                                        textClr: Colors.grey,
                                      ),
                                    )
                                    : ListView.builder(
                                      itemCount: provider.filteredSubs.length,
                                      itemBuilder: (context, index) {
                                        final sub =
                                            provider.filteredSubs[index];
                                        Color tileClr = hexToColor(
                                          sub["color"],
                                        );
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            ExploreSubscriptionScreen(
                                                              sub: sub,
                                                            ),
                                                  ),
                                                );
                                              },
                                              child: ListTile(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  side: BorderSide(
                                                    color:
                                                        colorScheme
                                                            .surfaceContainerHigh,
                                                  ),
                                                ),
                                                tileColor: tileClr,
                                                leading: CircleAvatar(
                                                  radius: 24,
                                                  backgroundColor: Colors.white,
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      sub["iconUrl"],
                                                      width: 64,
                                                      height: 64,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                title: BuildText(
                                                  text: sub["name"],
                                                  textSize: 14,
                                                  textClr: Colors.white,
                                                  textWeight: FontWeight.w700,
                                                ),
                                                subtitle: BuildText(
                                                  text: sub["description"],
                                                  textSize: 12,
                                                  textClr: Colors.white,
                                                ),
                                                trailing: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    BuildText(
                                                      text:
                                                          sub["rating"]
                                                              .toString(),
                                                      textSize: 13,
                                                      textClr: Colors.white,
                                                    ),
                                                    SizedBox(width: 2),
                                                    customSvg(
                                                      path: "star",
                                                      colorScheme: colorScheme,
                                                      width: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
