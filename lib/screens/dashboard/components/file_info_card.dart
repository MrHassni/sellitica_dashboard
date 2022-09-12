import 'package:erp_aspire/Routes/Router.dart' as Router;
import 'package:erp_aspire/models/MyFiles.dart';
import 'package:erp_aspire/provider/homeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final CloudStorageInfo info;

  @override
  Widget build(BuildContext context) {
    return Consumer<homepage_provider>(
        builder: (context, provider, _child) => Padding(
              padding: const EdgeInsets.all(3.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Router.pendingorders,
                    arguments: info.numOfFiles,
                  );
                },
                color: secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding:
                                  const EdgeInsets.all(defaultPadding * 0.75),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: info.color!.withOpacity(0.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: info.color,
                                  size: 17,
                                ),
                              )
                              // SvgPicture.asset(
                              //   info.svgSrc!,
                              //   color: info.color,
                              // ),
                              ),
                          const Icon(Icons.more_vert, color: txtColor)
                        ],
                      ),
                      Text(
                        info.subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        info.numOfFiles == 0
                            ? provider.pendingOrdermodel.length.toString()
                            : info.numOfFiles == 1
                                ? provider.inprocessOrdermodel.length.toString()
                                : info.numOfFiles == 2
                                    ? provider.completedOrdermodel.length
                                        .toString()
                                    : info.numOfFiles == 3
                                        ? provider.othersOrdermodel.length
                                            .toString()
                                        : "0",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      ProgressLine(
                        color: info.color,
                        percentage: info.percentage,
                      ),
                      Text(
                        info.tagline!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: txtColor,
                            ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   child: Text(
                      //     info.totalStorage!,
                      //     maxLines: 1,
                      //     textAlign: TextAlign.end,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .bodyText2!
                      //         .copyWith(
                      //             color: txtColor, fontWeight: FontWeight.bold),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ));
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
