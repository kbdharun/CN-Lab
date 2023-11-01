Open two command prompt and set the path & class path

1) compile all java prog- java file(Client & Server), using javac *.java, in any one prompt

2) in Server-side, run RMIRegistry using: start rmiregistry, an additional prompt will be opened and rmiregistry will be running on it. Do not close it until the demonstration is not finished. On Linux the equivalent command is `rmiregistry`.

4) Start server program using: java MyServer

5) run client from another system or prompt using server ip: java MyClient <IP  or localhost>


Note: If version error occurs, Compile following way:
        javac --release 8 *.java
