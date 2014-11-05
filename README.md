TrainingThreading
=================

Tenemos una aplicación que de fondo tiene una animación de un cuadrado que va y viene.
Además hay un proceso que va agregando números a un array y cuando termina muestra un log.

¿Cuál es la problemática?
Al terminar el ejercicio nos dimos que cuenta que era muy pesadas las operaciones de agregar valores y mostrar el listado de números y nos bloquea la animación.
El tema es que la clase ValueLogger no la podemos tocar ya que se utiliza en otros proyectos por lo que lo único que podemos manipular realmente es la clase OperationManager.
Por suerte la aplicación es lo suficientemente inteligente como para avisarnos si no estamos logrando el objetivo!


¿Cuál es el objetivo?
Las tareas tienen que ejecutarse de manera tal que no hagan un lock a la aplicación y se puedan ejecutar las animaciones correctamente manteniendo la consistencia del listado que debe mostrar los 10 números sin importar el orden.

Además hay que lograr la más optima utilización de los recursos para que las operaciones terminen en la menor cantidad de tiempo.

Suerte!!

