import java.io.*;
import java.net.*;
import java.awt.*;
import java.awt.event.*;
import java.io.FileReader;
import java.io.FileWriter;
import javax.swing.*;

class senderGui implements ActionListener {
    JButton b1, b2, b3;
    // JTextField t1;
    // JTextArea a1;
    // JLabel l1;
    Socket s;

    senderGui() {

        JFrame frame = new JFrame("Client");
        b1 = new JButton("Upload");
        b2 = new JButton("Download");
        // l1 = new JLabel("Enter message");
        // t1 = new JTextField(50);
        // a1 = new JTextArea(10, 15);
        frame.setLayout(new FlowLayout());
        frame.setVisible(true);
        frame.setSize(500, 500);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        // f.add(l1);
        // f.add(t1);
        // f.add(a1);
        frame.add(b1);
        frame.add(b2);

        b1.addActionListener(this);
        b2.addActionListener(this);

    }

    public void actionPerformed(ActionEvent e) {

        if (e.getSource() == b1) {
            try {
                // Enter the text in "Client_Input.txt" file for encrypted transmission of file
                File file1 = new File("Client_Input.txt");
                FileReader fr = new FileReader(file1);
                PrintWriter put = new PrintWriter(s.getOutputStream(), true);
                int c = 0;
                while ((c = fr.read()) != -1) {
                    int k = ((c + 6) % 256);
                    put.println(k);
                    // System.out.println((char) k);
                }
                System.out.println("File content are TRansferred..... from client to server");
                fr.close();
                s.close();

            } catch (Exception aase) {

            }

        } else if (e.getSource() == b2) {
            try {
                File f = new File("fromserver.txt");
                FileReader fr = new FileReader(f);
                File fw = new File("decrypt_fromserver.txt");
                FileWriter fwr = new FileWriter(fw);
                int c;
                while ((c = fr.read()) != -1) {
                    int decrypt = ((c - 6) % 256);
                    fwr.write(decrypt);
                }
                System.out.println("File content are decrypted..... that is sent by server");
                fr.close();
                fwr.close();
                s.close();

            } catch (Exception ae) {

            }
        }

    }

    // public void put_Text(String msg) {
    // a1.append(msg + "\n"); // append the text
    // }

}

public class client {
    public static void main(String[] args) {
        senderGui g = new senderGui();
        try {
            g.s = new Socket("localhost", 6666);
            BufferedReader get = new BufferedReader(new InputStreamReader(g.s.getInputStream()));
            File f = new File("fromserver.txt");
            FileWriter fw = new FileWriter(f);
            String c;
            while ((c = get.readLine()) != null) {
                int k = Integer.parseInt(c);
                // int decrypt = ((k - 3) % 256);
                fw.write(k);
            }
            fw.close();
            g.s.close();
        } catch (Exception e) {

        }

    }
}