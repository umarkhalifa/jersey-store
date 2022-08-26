import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../contsants/colors.dart';
import '../model/league.dart';
import '../repositories/providers.dart';

class LeaguesList extends ConsumerWidget {
  const LeaguesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // !LEAGUE INDEX PROVIDER
    final leagueIndex = ref.watch(leagueIndexProvider);

    return ListView.separated(
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                // !CHANGE THE LEAGUE INDEX PROVIDER TO SELECTED INDEX
                ref.read(leagueIndexProvider.notifier).state = index;

                // !CHANGE LEAGUE PAGE CONTROLLER TO INITIAL VALUE
                controller.jumpToPage(0);

                // !CHANGE LEAGUE PAGE CURRENT PAGE BACK TO INITIAL INDEX
                ref.refresh(currentPage);
              },
              child: ShowUpAnimation(
                direction: Direction.horizontal,
                child: Column(
                  children: [
                    Material(
                      elevation: 5,
                      shadowColor: kBlue.withOpacity(0.1),
                      color: Colors.white54,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: CircleAvatar(
                        backgroundColor: Colors.white54,
                        radius: 25,
                        child: Image.asset(
                          leagues[index].image,
                          height: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            CircleAvatar(
              radius: 3,
              backgroundColor:
                  leagueIndex == index ? kRed : Colors.transparent,
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 30,
        );
      },
      itemCount: leagues.length,
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
    );
  }
}
