// vedio link : https://youtu.be/Bc0qB1jtHBk?si=_ytls4zJr7jePIar
import 'package:flutter/material.dart';

class DragDropPage extends StatefulWidget {
  const DragDropPage({super.key});

  @override
  State<DragDropPage> createState() => _DragDropPageState();
}

class _DragDropPageState extends State<DragDropPage> {
  List<Color> dragableItemsColor = [
    Colors.red,
    Colors.blue,
    Colors.green,
  ];

  List<TargetItem> targetItems = [
    TargetItem(
      itemColor: Colors.red,
      isIconVisible: false,
      isTargetColorWithOpacity: true,
      isDownArrowShowInTheTarget: false,
    ),
    TargetItem(
      itemColor: Colors.blue,
      isIconVisible: false,
      isTargetColorWithOpacity: true,
      isDownArrowShowInTheTarget: false,
    ),
    TargetItem(
      itemColor: Colors.green,
      isIconVisible: false,
      isTargetColorWithOpacity: true,
      isDownArrowShowInTheTarget: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Physics Playgruond'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              dragableItemsColor.length,
              (index) {
                return Draggable<Color>(
                  data: dragableItemsColor[
                      index], // this parameter will pass to the DragTarget callbacks (onAcceptWithDetails, onWillAcceptWithDetails, etc..)
                  feedback: CircleAvatar(
                    radius: 24,
                    backgroundColor: dragableItemsColor[index],
                  ),
                  childWhenDragging: CircleAvatar(
                    radius: 20,
                    backgroundColor: dragableItemsColor[index].withOpacity(.5),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: dragableItemsColor[index],
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              targetItems.length,
              (index) {
                return DragTarget<Color>(
                  // onAccept: (data) {}, deprecated
                  // onWillAccept: (data) {}, deprecated
                  builder: (context, candidateData, rejectedData) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: BoxDecoration(
                            color: targetItems[index].isTargetColorWithOpacity
                                ? targetItems[index].itemColor.withOpacity(.5)
                                : targetItems[index].itemColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: dragableItemsColor[index],
                              width: 2,
                            ),
                          ),
                        ),
                        targetItems[index].isIconVisible
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 36,
                              )
                            : const SizedBox.shrink(),
                        targetItems[index].isDownArrowShowInTheTarget
                            ? const Icon(
                                Icons.arrow_circle_down,
                                color: Colors.white,
                                size: 36,
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
                  },
                  onAcceptWithDetails: (details) {
                    if (details.data == targetItems[index].itemColor) {
                      setState(() {
                        targetItems[index].isTargetColorWithOpacity = false;
                        targetItems[index].isIconVisible = true;
                        targetItems[index].isDownArrowShowInTheTarget = false;
                      });
                    } else {
                      setState(() {
                        targetItems[index].isDownArrowShowInTheTarget = false;
                      });
                    }
                  }, // called when dragable widget drop in the target
                  onWillAcceptWithDetails: (details) {
                    setState(() {
                      targetItems[index].isDownArrowShowInTheTarget = true;
                    });
                    return true; // allow drop
                    // return false;// not allow to drop, you can not drop in the target
                  }, // Called when a draggable hovers over the target,You decide whether to accept or reject.
                );
              },
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

class TargetItem {
  Color itemColor;
  bool isIconVisible;
  bool isTargetColorWithOpacity;
  bool isDownArrowShowInTheTarget;
  TargetItem({
    required this.itemColor,
    required this.isIconVisible,
    required this.isTargetColorWithOpacity,
    required this.isDownArrowShowInTheTarget,
  });
}
