import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
Note:
🔄 How confirmDismiss and onDismissed work together

1. Swipe begins → Flutter calls confirmDismiss.

      _This is an async function (Future<bool?>) where you decide whether to allow the dismiss or not.
      
      _You usually show a dialog or confirmation UI here.

2. If confirmDismiss returns true

      _Flutter animates the widget out of the list.
      
      _Then it calls onDismissed.
      
      _This is where you should actually remove the item from your data list.

3. If confirmDismiss returns false or null

      _Flutter cancels the dismiss (item snaps back into place).

      _onDismissed is not called.
 */
class DismissibleListPage extends StatefulWidget {
  const DismissibleListPage({super.key});

  @override
  State<DismissibleListPage> createState() => _DismissibleListPageState();
}

class _DismissibleListPageState extends State<DismissibleListPage> {
  List<String> items = List.generate(5, (index) => 'Item $index');
  String? deletedItem;
  int? deletedItemIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dismissible List'),
        centerTitle: true,
      ),
      body: ReorderableListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: items.length,
        onReorder: (int oldIndex, int newIndex) {
          // oldIndex: the index of the item that i hold it
          // newIndex: the index of the item that i drop it
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;
            final item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
        },
        itemBuilder: (context, index) {
          return Padding(
            key: ValueKey(items[index]),
            padding: const EdgeInsets.only(bottom: 10),
            child: Dismissible(
              key: ValueKey(
                items[index],
              ), // very important and must be the item of the list
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Confirm Deleting'),
                      content: Text('Delete "Item $index"'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context,
                                false); //and onDismiss will not called and item will not deleted
                          },
                        ),
                        TextButton(
                          child: Text('Delete'),
                          onPressed: () {
                            Navigator.pop(context,
                                true); //onDismiss will called and item will deleted
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (direction) {
                deletedItem = items[index];
                deletedItemIndex = index;
                items.removeAt(index);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Item $index deleted'),
                        InkWell(
                          onTap: () {
                            if (deletedItem != null &&
                                deletedItemIndex != null) {
                              items.insert(deletedItemIndex!, deletedItem!);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              setState(() {});
                            }
                          },
                          child: Text('Undo'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                padding: EdgeInsets.all(20),
                color: Colors.red,
                child: Icon(CupertinoIcons.trash, color: Colors.white),
              ),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(items[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
