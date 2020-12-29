
namespace GameDB
{
    partial class DBViewer
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.Oyungoruntule = new System.Windows.Forms.Button();
            this.guncelle = new System.Windows.Forms.Button();
            this.sil = new System.Windows.Forms.Button();
            this.ekle = new System.Windows.Forms.Button();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.lbl_mail = new System.Windows.Forms.Label();
            this.hesaplar = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.oyunlar = new System.Windows.Forms.ComboBox();
            this.ara = new System.Windows.Forms.Button();
            this.arama = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.oyunSayisi = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // Oyungoruntule
            // 
            this.Oyungoruntule.Location = new System.Drawing.Point(613, 59);
            this.Oyungoruntule.Name = "Oyungoruntule";
            this.Oyungoruntule.Size = new System.Drawing.Size(158, 44);
            this.Oyungoruntule.TabIndex = 0;
            this.Oyungoruntule.Text = "Goruntule";
            this.Oyungoruntule.UseVisualStyleBackColor = true;
            this.Oyungoruntule.Click += new System.EventHandler(this.Oyungoruntule_Click);
            // 
            // guncelle
            // 
            this.guncelle.Location = new System.Drawing.Point(613, 210);
            this.guncelle.Name = "guncelle";
            this.guncelle.Size = new System.Drawing.Size(158, 44);
            this.guncelle.TabIndex = 1;
            this.guncelle.Text = "Guncelle";
            this.guncelle.UseVisualStyleBackColor = true;
            this.guncelle.Click += new System.EventHandler(this.guncelle_Click);
            // 
            // sil
            // 
            this.sil.Location = new System.Drawing.Point(613, 283);
            this.sil.Name = "sil";
            this.sil.Size = new System.Drawing.Size(158, 44);
            this.sil.TabIndex = 2;
            this.sil.Text = "Sil";
            this.sil.UseVisualStyleBackColor = true;
            this.sil.Click += new System.EventHandler(this.sil_Click);
            // 
            // ekle
            // 
            this.ekle.Location = new System.Drawing.Point(613, 135);
            this.ekle.Name = "ekle";
            this.ekle.Size = new System.Drawing.Size(158, 44);
            this.ekle.TabIndex = 3;
            this.ekle.Text = "Ekle";
            this.ekle.UseVisualStyleBackColor = true;
            this.ekle.Click += new System.EventHandler(this.ekle_Click);
            // 
            // dataGridView1
            // 
            this.dataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(13, 13);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 51;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.Size = new System.Drawing.Size(421, 314);
            this.dataGridView1.TabIndex = 4;
            // 
            // lbl_mail
            // 
            this.lbl_mail.AutoSize = true;
            this.lbl_mail.Font = new System.Drawing.Font("Adobe Fan Heiti Std B", 10.8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(128)));
            this.lbl_mail.Location = new System.Drawing.Point(609, 13);
            this.lbl_mail.Name = "lbl_mail";
            this.lbl_mail.Size = new System.Drawing.Size(63, 24);
            this.lbl_mail.TabIndex = 5;
            this.lbl_mail.Text = "label1";
            // 
            // hesaplar
            // 
            this.hesaplar.FormattingEnabled = true;
            this.hesaplar.Location = new System.Drawing.Point(454, 59);
            this.hesaplar.Name = "hesaplar";
            this.hesaplar.Size = new System.Drawing.Size(153, 24);
            this.hesaplar.TabIndex = 6;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(457, 39);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(65, 17);
            this.label1.TabIndex = 7;
            this.label1.Text = "Hesaplar";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(457, 113);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(58, 17);
            this.label2.TabIndex = 8;
            this.label2.Text = "Oyunlar";
            // 
            // oyunlar
            // 
            this.oyunlar.FormattingEnabled = true;
            this.oyunlar.Location = new System.Drawing.Point(454, 135);
            this.oyunlar.Name = "oyunlar";
            this.oyunlar.Size = new System.Drawing.Size(153, 24);
            this.oyunlar.TabIndex = 9;
            // 
            // ara
            // 
            this.ara.Location = new System.Drawing.Point(449, 283);
            this.ara.Name = "ara";
            this.ara.Size = new System.Drawing.Size(158, 44);
            this.ara.TabIndex = 10;
            this.ara.Text = "Ara";
            this.ara.UseVisualStyleBackColor = true;
            this.ara.Click += new System.EventHandler(this.ara_Click);
            // 
            // arama
            // 
            this.arama.Location = new System.Drawing.Point(449, 210);
            this.arama.Name = "arama";
            this.arama.Size = new System.Drawing.Size(158, 22);
            this.arama.TabIndex = 11;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(457, 190);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(82, 17);
            this.label3.TabIndex = 12;
            this.label3.Text = "Ara/Değiştir";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(13, 347);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(146, 17);
            this.label4.TabIndex = 13;
            this.label4.Text = "Toplam Oyun Sayiniz:";
            // 
            // oyunSayisi
            // 
            this.oyunSayisi.AutoSize = true;
            this.oyunSayisi.Location = new System.Drawing.Point(166, 347);
            this.oyunSayisi.Name = "oyunSayisi";
            this.oyunSayisi.Size = new System.Drawing.Size(46, 17);
            this.oyunSayisi.TabIndex = 14;
            this.oyunSayisi.Text = "label5";
            // 
            // DBViewer
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(803, 404);
            this.ControlBox = false;
            this.Controls.Add(this.oyunSayisi);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.arama);
            this.Controls.Add(this.ara);
            this.Controls.Add(this.oyunlar);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.hesaplar);
            this.Controls.Add(this.lbl_mail);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.ekle);
            this.Controls.Add(this.sil);
            this.Controls.Add(this.guncelle);
            this.Controls.Add(this.Oyungoruntule);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "DBViewer";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "DBViewer";
            this.Load += new System.EventHandler(this.DBViewer_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button Oyungoruntule;
        private System.Windows.Forms.Button guncelle;
        private System.Windows.Forms.Button sil;
        private System.Windows.Forms.Button ekle;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Label lbl_mail;
        private System.Windows.Forms.ComboBox hesaplar;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox oyunlar;
        private System.Windows.Forms.Button ara;
        private System.Windows.Forms.TextBox arama;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label oyunSayisi;
    }
}