
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.ServerSocket;
import java.net.Socket;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextArea;
import javax.swing.JTextField;

class Gui_Receiver implements ActionListener {
    JLabel label;
    JButton button1, button2, button3;
    JTextArea textArea;
    JTextField textField;
    Socket socket;
    ServerSocket serverSocket;

    Gui_Receiver() {
        JFrame f = new JFrame("Receiver :)");
        button1 = new JButton("Send >");
        button2 = new JButton("Clear Text Field");
        button3 = new JButton("Clear Chat Box");
        label = new JLabel("Enter the message");
        textField = new JTextField(50);
        textArea = new JTextArea(10, 15);
        f.setVisible(true);
        f.setLayout(new FlowLayout());
        f.setSize(600, 600);
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.add(label);
        f.add(button1);
        f.add(button2);
        f.add(button3);
        f.add(textArea);
        f.add(textField);
        button1.addActionListener(this);
        button2.addActionListener(this);
        button3.addActionListener(this);
    }

    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == button1) {
            try {
                String s1 = textField.getText();
                DataOutputStream outputStream = new DataOutputStream(socket.getOutputStream());
                outputStream.writeUTF(s1);
            } catch (Exception aae) {

            }
        } else if (e.getSource() == button2) {
            textField.setText("");
        } else if (e.getSource() == button3) {
            textArea.setText("");
        }
    }

    public void PutText(String s) {
        textArea.append(s + "\n");
    }

}

public class Receiver {
    public static void main(String[] args) {
        Gui_Receiver g = new Gui_Receiver();
        try {
            g.serverSocket = new ServerSocket(6666);
            System.out.println("Waiting for the Client .....");
            g.socket = g.serverSocket.accept();
            System.out.println("Connected to the Client Successfully :)");
            DataInputStream inputStream = new DataInputStream(g.socket.getInputStream());
            while (true) {
                String string = (String) inputStream.readUTF();
                System.out.println(string);
                g.PutText(string);
            }
            
            
        } catch (Exception ae) {
            
        }
    }
}
