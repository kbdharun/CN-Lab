import java.io.*;
import java.net.*;
import java.awt.*;
import java.awt.event.*;
import java.io.FileReader;
import java.io.FileWriter;
import javax.swing.*;

class receiverGui implements ActionListener {
    JButton b1, b2, b3;
    // JTextField t1;
    // JTextArea a1;
    // JLabel l1;
    Socket socket;
    ServerSocket serversocket;

    receiverGui() {
        JFrame f = new JFrame("Server");
        b1 = new JButton("Upload");
        b2 = new JButton("Download");
        // l1 = new JLabel("Enter message");
        // t1 = new JTextField(50);
        // a1 = new JTextArea(10, 15);
        f.setLayout(new FlowLayout());
        f.setVisible(true);
        f.setSize(500, 500);
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        // f.add(l1);
        // f.add(t1);
        // f.add(a1);
        f.add(b1);
        f.add(b2);
        b1.addActionListener(this);
        b2.addActionListener(this);
    }

    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == b1) {
            try {
                File f1 = new File("to_client.txt");
                FileReader fr = new FileReader(f1);
                PrintWriter put = new PrintWriter(socket.getOutputStream(), true);
                int c = 0;
                while ((c = fr.read()) != -1) {
                    int k = ((c + 6) % 256);
                    put.println(k);
                    // System.out.println((char) k);
                }
                System.out.println("File content are TRansferred.....from server to client");
                fr.close();
                socket.close();

            } catch (Exception aase) {

            }

        } else if (e.getSource() == b2) {
            try {
                File f = new File("Server_Encrypted.txt");
                FileReader fr = new FileReader(f);
                File fw = new File("Serverside_decrypt.txt");
                FileWriter fwr = new FileWriter(fw);
                int c;
                while ((c = fr.read()) != -1) {
                    int decrypt = ((c - 6) % 256);
                    fwr.write(decrypt);
                }
                fr.close();
                fwr.close();
                socket.close();
                System.out.println("File content are decrypted.....that is sent from client");

            } catch (Exception ae) {

            }
        }

    }

    // public void put_Text(String s) {
    //     a1.append(s + "\n");
    // }

}

public class server {
    public static void main(String[] args) {
        receiverGui g = new receiverGui();
        try {
            g.serversocket = new ServerSocket(6666);
            System.out.println("Waiting for client");
            g.socket = g.serversocket.accept();
            System.out.println("Client connected");
            BufferedReader get = new BufferedReader(new InputStreamReader(g.socket.getInputStream()));
            File f = new File("Server_Encrypted.txt");
            FileWriter fw = new FileWriter(f);
            String c;
            while ((c = get.readLine()) != null) {
                int k = Integer.parseInt(c);
                int decrypt = ((k - 6) % 256);
                fw.write(k);
            }
            fw.close();
            g.socket.close();
        } catch (Exception e) {
        }

    }
}