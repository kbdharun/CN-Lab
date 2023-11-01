//definition of MyServerIntf
import java.rmi.*;
import java.rmi.server.*;

// UnicastRemoteObject supports for point-to-point active object references (invocations, parameters, and // results) using TCP streams.

public class MyServerImpl extends UnicastRemoteObject implements MyServerIntf
{
	MyServerImpl() throws RemoteException
	{}

	public double add(double a, double b) throws RemoteException
	{
		return(a+b);
	}	
}
