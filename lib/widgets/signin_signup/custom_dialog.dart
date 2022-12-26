import 'package:expense_tracker_v2/res/colors.dart';
import 'package:flutter/material.dart';
// import 'package:stich_and_sew/constants/colors.dart';

class CustomDialog extends StatelessWidget {
  final String dialogHeading;
  final String dialogBody;
  final String actionButtonText;
  final void Function() actionFunction;

  const CustomDialog({
    Key? key,
    required this.dialogHeading,
    required this.dialogBody,
    required this.actionFunction,
    required this.actionButtonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment
          .center, //so that the alert is shown at the center of the screen.
      mainAxisSize: MainAxisSize
          .min, //so that the card only takes the required space and not more than that
      children: [
        AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          alignment: Alignment.center,
          // insetPadding: const EdgeInsets.all(8),
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.fromLTRB(32, 16, 32, 24),

          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Text(
                dialogHeading,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15.0),
              Text(
                dialogBody,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: Material(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      side: BorderSide(color: AppColors.darkPurple, width: 2),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(11)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Cancel',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.darkPurple),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Material(
                    color: AppColors.darkPurple,
                    borderRadius: const BorderRadius.all(Radius.circular(11)),
                    child: InkWell(
                      onTap: actionFunction,
                      borderRadius: const BorderRadius.all(Radius.circular(11)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          actionButtonText,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
