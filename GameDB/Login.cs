using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GameDB
{
    
    public partial class Login : Form
    {
        NpgsqlConnection baglanti = new NpgsqlConnection("");
        public Login()
        {
            InitializeComponent();
        }

        private void giris_Click(object sender, EventArgs e)
        {
            int giris = 0;
            string sql = "select \"Hesaplar\".giris(:mail,:sifre)";
            baglanti.Open();
            NpgsqlCommand pgcom = new NpgsqlCommand(sql,baglanti);
            pgcom.CommandType = CommandType.Text;
            pgcom.Parameters.AddWithValue("mail",mail.Text);
            pgcom.Parameters.AddWithValue("sifre",password.Text);
            NpgsqlDataReader pgreader = pgcom.ExecuteReader();
            pgreader.Read();
            giris = pgreader.GetInt32(0);
            if (giris == 1)
            {
                this.Hide();
                DBViewer ui = new DBViewer(mail.Text);
                ui.Show();
            }
            else
                MessageBox.Show("Incorrect mail or password");
            baglanti.Close();
        }

        private void exit_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
