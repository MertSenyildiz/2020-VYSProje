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
    public partial class DBViewer : Form
    {
        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost; port=5432; Database=GameDB; user Id=postgres; password=Mert.123");
        int kkodu = 0;
        string mail;
        public DBViewer(string mail)
        {
            this.mail = mail;
            string sql = "Select kullanici_id from \"Hesaplar\".\"Kullanici\" Where kmail Like '" + mail + "'";
            baglanti.Open();
            NpgsqlCommand pgcom = new NpgsqlCommand(sql, baglanti);
            NpgsqlDataReader pgreader = pgcom.ExecuteReader();
            pgreader.Read();
            kkodu = pgreader.GetInt32(0);
            pgcom.Dispose();
            baglanti.Close();
            InitializeComponent();
        }

        private void DBViewer_Load(object sender, EventArgs e)
        {
            string[] isimler = mail.Split('@');
            lbl_mail.Text =isimler[0];
            string sql = "Select hesap_id,\"bAd\" from \"Hesaplar\".\"Hesap\" LEFT Join \"Baslaticilar\".\"Baslatici\" on baslatici = \"Baslaticilar\".\"Baslatici\".baslatici_id WHERE kullanici=(Select kullanici_id FROM \"Hesaplar\".\"Kullanici\" Where kullanici_id =" + kkodu + " )";
            baglanti.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sql,baglanti);
            DataTable dt = new DataTable();
            da.Fill(dt);
            hesaplar.DisplayMember = "bAd";
            hesaplar.ValueMember = "hesap_id";
            hesaplar.DataSource = dt;
            baglanti.Close();
            baglanti.Open();
            sql = "Select oyun_id,\"oAd\" from \"Oyunlar\".\"Oyun\"";
            NpgsqlDataAdapter ad = new NpgsqlDataAdapter(sql, baglanti);
            DataTable tad = new DataTable();
            ad.Fill(tad);
            oyunlar.DisplayMember = "oAd";
            oyunlar.ValueMember = "oyun_id";
            oyunlar.DataSource = tad;
            baglanti.Close();
            baglanti.Open();
            sql = "select \"oAd\",\"bAd\" From \"Oyunlar\".\"SahipOlunan\" Left Join \"Oyunlar\".\"Oyun\" On \"Oyunlar\".\"SahipOlunan\".oyun = \"Oyunlar\".\"Oyun\".oyun_id Left Join \"Hesaplar\".\"Hesap\" on \"Oyunlar\".\"SahipOlunan\".hesap =\"Hesaplar\".\"Hesap\".hesap_id LEFT Join \"Baslaticilar\".\"Baslatici\" ON \"Hesaplar\".\"Hesap\".baslatici = \"Baslaticilar\".\"Baslatici\".baslatici_id Where hesap =ANY (SELECT hesap_id from \"Hesaplar\".\"Hesap\" WHERE kullanici = "+kkodu+") ";
            NpgsqlDataAdapter adapter = new NpgsqlDataAdapter(sql, baglanti);
            DataSet tabl = new DataSet();
            adapter.Fill(tabl);
            dataGridView1.DataSource = tabl.Tables[0];
            baglanti.Close();
            oyunSayisi.Text = guncelleLabel();
        }

        private void Oyungoruntule_Click(object sender, EventArgs e)
        {
            string sql = "select \"oAd\" From \"Oyunlar\".\"SahipOlunan\" Left Join \"Oyunlar\".\"Oyun\" On \"Oyunlar\".\"SahipOlunan\".oyun = \"Oyunlar\".\"Oyun\".oyun_id Where hesap = "+hesaplar.SelectedValue;
            baglanti.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sql, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
            baglanti.Close();
        }

        private void ekle_Click(object sender, EventArgs e)
        {
            string sql = "Select \"Oyunlar\".oyunekle(@oyun,@hesap)";
            baglanti.Open();
            NpgsqlCommand com1 = new NpgsqlCommand(sql, baglanti);
            com1.Parameters.AddWithValue("@oyun",int.Parse(oyunlar.SelectedValue.ToString()));
            com1.Parameters.AddWithValue("@hesap", int.Parse(hesaplar.SelectedValue.ToString()));
            try
            {
                com1.ExecuteNonQuery();
            }               
            catch(Exception ex)
            {
                MessageBox.Show(Convert.ToString(ex));
            }
            baglanti.Close();
            oyunSayisi.Text = guncelleLabel();
        }

        private void guncelle_Click(object sender, EventArgs e)
        {
            string sql = "  UPDATE \"Oyunlar\".\"Oyun\" SET \"oAd\"= @tmp Where oyun_id = @oyun ";
            baglanti.Open();
            NpgsqlCommand com2 = new NpgsqlCommand(sql, baglanti);
            com2.Parameters.AddWithValue("@tmp", arama.Text);
            com2.Parameters.AddWithValue("@oyun", int.Parse(oyunlar.SelectedValue.ToString()));
            try
            {
                com2.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(Convert.ToString(ex));
            }
            baglanti.Close();
        }

        private void ara_Click(object sender, EventArgs e)
        {
            string sql = "SELECT \"bAd\",\"oAd\" FROM \"Oyunlar\".\"SahipOlunan\" LEFT Join \"Oyunlar\".\"Oyun\" on oyun = \"Oyunlar\".\"Oyun\".oyun_id LEFT Join \"Hesaplar\".\"Hesap\" on hesap = \"Hesaplar\".\"Hesap\".hesap_id LEFT Join \"Baslaticilar\".\"Baslatici\" on \"Hesaplar\".\"Hesap\".baslatici = \"Baslaticilar\".\"Baslatici\".baslatici_id WHERE hesap = ANY(SELECT hesap_id from \"Hesaplar\".\"Hesap\" WHERE kullanici = " + kkodu+") AND \"oAd\" Like '" + arama.Text + "%'";
            baglanti.Open();
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sql, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
            baglanti.Close();
        }

        private void sil_Click(object sender, EventArgs e)
        {
            string sql = "Select \"Oyunlar\".oyunsil(@oyun,@hesap)";
            baglanti.Open();
            NpgsqlCommand com3 = new NpgsqlCommand(sql, baglanti);
            com3.Parameters.AddWithValue("@oyun", int.Parse(oyunlar.SelectedValue.ToString()));
            com3.Parameters.AddWithValue("@hesap", int.Parse(hesaplar.SelectedValue.ToString()));
            try
            {
                com3.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                MessageBox.Show(Convert.ToString(ex));
            }
            baglanti.Close();
            oyunSayisi.Text = guncelleLabel();
        }
        private string guncelleLabel()
        {
            string sql = "Select \"Hesaplar\".toplamoyun(@kullanici)";
            string lbl;
            baglanti.Open();
            NpgsqlCommand com4 = new NpgsqlCommand(sql, baglanti);
            com4.Parameters.AddWithValue("@kullanici",kkodu);
            NpgsqlDataReader pgreader = com4.ExecuteReader();
            pgreader.Read();
            lbl = Convert.ToString(pgreader.GetInt32(0));
            baglanti.Close();
            return lbl;
        }
    }
}
