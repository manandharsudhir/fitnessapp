import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitnessapp/app/services/exercise_services/exercise_service.dart';
import 'package:fitnessapp/ui/exercise_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ExerciseService _exerciseService = Get.put(ExerciseService());
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness App'),
        backgroundColor: Color(0xff182a56),
      ),
      body: RefreshIndicator(
        onRefresh: _exerciseService.findAll,
        child: SafeArea(
          child: Obx(() => _exerciseService.isLoading == true
              ? Center(child: CircularProgressIndicator())
              : _exerciseService.hasError == true
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('An Error has occured'),
                          RaisedButton(
                            child: Text('Refresh'),
                            onPressed: _exerciseService.findAll,
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, itemCount) => InkWell(
                        onTap: () => Get.to(ExerciseItemView(
                          exercise: _exerciseService.exercises[itemCount],
                        )),
                        child: Stack(
                          children: [
                            Hero(
                              tag: _exerciseService.exercises[itemCount].id,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl: _exerciseService
                                          .exercises[itemCount].thumbnail,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress)),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      height: 250,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            Container(
                                alignment: Alignment.bottomCenter,
                                height: 250,
                                child: Text(
                                  _exerciseService.exercises[itemCount].title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      itemCount: _exerciseService.exercises.length,
                    )),
        ),
      ),
    );
  }
}
