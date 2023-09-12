import java.io.*;
import java.net.*;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import javax.swing.*;

class GUI_Sender implements ActionListener {
    JLabel label;
    JButton button1, button2, button3;
    JTextArea textArea;
    JTextField textField;
    Socket socket;

    GUI_Sender() {
        JFrame f = new JFrame("Sender :))");
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
            try{
                String msg = textField.getText();
                DataOutputStream outputStream = new DataOutputStream(socket.getOutputStream());
                outputStream.writeUTF(msg);

                outputStream.flush();
            }
            catch (Exception aaaa) {

            }
        }
        else if (e.getSource() == button2) {
            textField.setText("");
        } else if (e.getSource() == button3) {
            textArea.setText("");
        }
    }
    public void PutText(String msg){
        textArea.append(msg + "\n");
    }
}

public class Sender{
    public static void main(String[] args) {
        GUI_Sender g = new GUI_Sender();
        try{
            g.socket = new Socket("localhost",6666);
            DataInputStream inputStream = new DataInputStream(g.socket.getInputStream());
            while(true) {
                String str = (String) inputStream.readUTF();
                System.out.println(str);
                g.PutText(str);
            }
        }
        catch (Exception exception) {
            
        }
    }
}