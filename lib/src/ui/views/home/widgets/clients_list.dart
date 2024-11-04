import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tots_test/src/ui/common/util/app_color.dart';
import 'package:tots_test/src/ui/common/util/spaces.dart';
import 'package:tots_test/src/ui/views/home/contact_controller.dart';
import 'package:tots_test/src/ui/views/home/models/client.dart';
import 'package:tots_test/src/ui/views/home/widgets/new_edit_client.dart';

class ClientsList extends StatelessWidget {
  const ClientsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ClientController, List<Client>>(
      selector: (p0, c) => c.list,
      builder: (context, list, child) => Expanded(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _Item(list[index]);
          },
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.client);
  final Client client;
  @override
  Widget build(BuildContext context) {
    final url = validateUrl(client.photo);
   
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15).copyWith(
          right: 5
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage:
                  url != null ? NetworkImage(url) : null,
              child: url== null
                  ? Text(
                      '${client.firstname[0].toUpperCase()}${client.lastname[0].toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gray,
                      ),
                    )
                  : null,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${client.firstname} ${client.lastname}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.black2,
                      ),
                    ),
                    Text(
                      client.email,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                final controller =
                    Provider.of<ClientController>(context, listen: false);
                switch (value) {
                  case '1':
                    showDialog(
                      context: context,
                      builder: (context) => NewEditClient(
                        controller: controller,
                        client: client,
                      ),
                    );
                    break;
                  default:
                }
                switch (value) {
                  case '2':
                    controller.delete(client);
                    break;
                  default:
                }
              },
              offset: const Offset(-20, 20),
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: '1',
                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit,
                        color: AppColors.white,
                        size: 20,
                      ),
                      Spaces.horizontal4,
                      const Text(
                        'Edit',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: '2',
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        color: AppColors.white,
                        size: 20,
                      ),
                      Spaces.horizontal4,
                      const Text(
                        'Delete',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? validateUrl(String? text) {
    if (text == null) return null;

    final uri = Uri.tryParse(text);
    return (uri != null && uri.hasScheme && uri.hasAuthority) ? text : null;
  }
}
