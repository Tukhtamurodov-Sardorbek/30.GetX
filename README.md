# GetX Patterns

> Plugin: [get: ^4.6.1](https://pub.dev/packages/get)
> 
> main: change MaterialApp to GetMaterialApp
> 
> control: create separate class for each ui page for their controllers and     extend each of them GetxController: ``` class ControllerName extends GetxController {} ```
> 
> Material: [The ultimate guide to GetX state management in Flutter](https://blog.logrocket.com/ultimate-guide-getx-state-management-flutter/)


## Use Cases

| № | SM | Control |  UI | Service | main |
| ------ | ------ | ------ | ------ | ------ | ------ |
| 1 | Obx | 1) All variables are observed through ```.obs```: ``` var varName = varValue.obs``` 2) Variables are addressed through ```.value```:  ``` varName.value = newValue``` | 1) Create a controller as follows: ```final varControllerName = Get.put(ContollerName())``` 2) Wrap with Obx(): ```Obx((){return ...})``` 3) Use ```varControllerName``` to call the neccessary functions and variables: ```varControllerName.varName.value;```  ```varControllerName.functionName();```| - | Use GetMaterialApp instead of MaterialApp |
| 2 | Obx | 1) All variables are observed through ```.obs```: ``` var varName = varValue.obs;``` 2) Variables are addressed through ```.value```:  ``` varName.value = newValue;``` | 1) Wrap with Obx(): ```Obx((){return ...})``` 2) Use ```Get.find<ControllerName>()``` to call the neccessary functions and variables: ```Get.find<ControllerName>().varName.value;```  ```Get.find<ControllerName>().functionName();``` | Binding Service is needed to use ```Get.find<ControllerName>()``` | Need to initialize binding in GetMaterialApp: ```initialBinding: ControllersBinding(),``` |
| 3 | GetBuilder | Use ```update()``` to update the state: ```varName = newvalue; update()``` (Updates all the changes above itself) | 1) Wrap with ```GetBuilder<ContollerName>(init: ContollerName(), builder: (varControllerName){return ...})``` 2) Use ```varControllerName``` to call the neccessary functions and variables: ```varControllerName.varName;```  ```varControllerName.functionName();``` | Binding Service is needed to use ```GetBuilder<ContollerName>(init: ContollerName(), builder: (varControllerName){return ...})``` | Need to initialize binding in GetMaterialApp: ```initialBinding: ControllersBinding(),``` |
| 4 | GetBuilder | Use ```update()``` to update the state: ```varName = newvalue; update()``` (Updates all the changes above itself) | 1) Wrap with ```GetBuilder<ContollerName>(init: ContollerName(), builder: (varControllerName){return ...})``` 2) Use ```varControllerName``` to call the neccessary functions and variables: ```varControllerName.varName;```  ```varControllerName.functionName();``` | Use Dependency Injection Service instead of Binding Service to use ```GetBuilder<ContollerName>(init: ContollerName(), builder: (varControllerName){return ...})``` | Need to initialize dependency injection service in void main() : ```await DependencyInjectionService.init();``` |
| 5 | GetX |  1) All variables are observed through ```.obs```: ``` var varName = varValue.obs``` 2) Variables are addressed through ```.value```:  ``` varName.value = newValue``` | 1) Wrap with ```GetX<ContollerName>(init: ContollerName(), builder: (varControllerName){return ...})``` 2)  Use ```varControllerName``` to call the neccessary functions and variables: ```varControllerName.varName.value;```  ```varControllerName.functionName();``` | - | Use GetMaterialApp instead of MaterialApp |
