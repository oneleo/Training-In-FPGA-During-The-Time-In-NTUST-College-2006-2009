#include<reg51.h>               /*STARFINE DESIGN*/
sbit led_dot=P1^7;
unsigned short act[4]={0xfe,0xfd,0xfb,0xf7};  /*�|�ӤC�q��ܾ��P��L���y�覡*/
unsigned short seg_num[17]={0xc0,0xf9,0xa4,0xb0,0x99,0x92,0x82,0xf8,0x80,0x90,0x88,0x83,0xc6,0xa1,0x86,0x8e,0xff};  /*�C�q��ܾ���ܤ覡*/
unsigned short key,key15open=0,switch_sel=3,int_delay=0,title_segreg,title_count=0;  /*key��J�ƭȡAkey15open�Ұʮ����]�w�Aswitch_sel�]�w�Ҧ���|�q�Aint_delay���_������G�]�w�����p�Ʈɶ��Atitle_segreg�{�{�ɤC�q�Ȧs�Atitle_count�{�{�ɶ�����*/
unsigned short seg[4]={0},scan_num=0,scan=0;  /*seg�Ψ��x�s�U�ӤC�q��ܾ����ƭȡAscan�O���y���w�ΡAscan_num�O���wscan���B�ӫG�A��seg���Ʀr�~�G*/
void delay(int delay)           /*������*/
{
  int d;
  for(d=0;d<(delay*100);d++)
  {
    ;
  }
}
void scan_7seg(void)             /*���y�C�q��ܾ����*/
{
  P0=act[scan];                  /*�]�wAT89S51��P0.0�BP0.1�BP0.2�BP0.3����n�����ӤC�q��ܾ��o���A�]���|�ӤC�q��ܾ���abcdefgh���}�P���@�ݡA�ҥH�n�Υt�|������u�M�w��ӧO�C�q��ܾ����ݪ��T���L�ӮɡA�n���ӤC�q��ܾ��o���C*/
  P1=seg_num[seg[scan]];         /*�]�wAT89S51��P1.0�BP1.1�BP1.2�BP1.3�BP1.4�BP1.5�BP1.6�BP1.7���O���J�C�q��ܾ���abcdefgh�A�]���|�ӤC�q��ܾ�����ƽu���ۦP�A�ҥH�ȤC���N�i�����A�A�y�ѧֳt���y�A�ײ��L�k��O�����p�U�A�F����ت��C*/
  if(scan==2)                    /*���ĤT�ӤC�q�p����ܡA���j�ɻP��*/
  {
    led_dot=0;
  }
  if(key15open==1)               /*�Y�]�w�Ҧ��ҰʡA�|�ӤC�q�����y*/
  {
    scan_num=3;
  }
  else if(key15open!=1)          /*�Y�]�w�Ҧ����ҰʡA�ɰw�Τ��w���䬰�s�h�����*/
  {
    if(seg[0]!=0)                /*�Y���w�Ӧ�Ƥ�����A�h����ܲĤ@�ӤC�q��ܾ�*/
    {
      scan_num=0;
    }
    if(seg[1]!=0)                /*�Y���w�Q��Ƥ����s�A�h��ܲĤ@��ĤG�ӤC�q��ܾ�*/
    { 
      scan_num=1;
    }
    if(seg[2]!=0)                /*�Y�ɰw�Ӧ�Ƥ����s�A�h��ܲĤ@��ĤT�ӤC�q��ܾ�*/
    {
      scan_num=2;
    }
    if(seg[3]!=0)                /*�Y�ɰw�Q��Ƥ����s�A�h��ܲĤ@��ĥ|�ӤC�q��ܾ�*/
    {
      scan_num=3;
    }
    if((seg[3]==0)&&(seg[2]!=0)&&(seg[1]==0))  /*�Y�ɰw�Ӧ�Ƥ����s�B�Q��Ƭ��s�A���w�Q��Ƭ��s�A�h����ܲĤ@�ӻP�ĤT�ӤC�q��ܾ�*/
    {
      scan_num=2;
      scan++;
    }
  }
    scan++;                       /*���y�֥[*/
    if(scan>scan_num)             /*�Y�S�F��H�W�n�D�N�k�s*/
    { 
      scan=0;
    } 
}
void T0_int(void)interrupt 1      /*���_�{�ǡA�Ҧ���1*/
{
  TH0=(65536-2000)/256;           /*�]�w�U�����_����ɶ��A�ɶ��@��A�A�׶i�J�����_�{��*/
  TL0=(65536-2000)%256;           /*�p���~�i���_���C�q�֥[�ʧ@�C*/
  scan_7seg();                    /*�C�q��ܾ����y�{��*/
  if(key15open==1)                /*�]�w�Ҧ��Ұ�*/
  {
    if(seg[switch_sel]!=16)       /*16���C�q��������ܡA���F���ܰ{�{�A�����b���]�ɥ���ƭ��x�s*/
    {
      title_segreg=seg[switch_sel];  /*�x�s��title_segreg*/
    }
    title_count++;                /*�{�{�p��*/
    if(title_count<250)           /*�t250���ɶ�*/
    {
      seg[switch_sel]=16;
    }
    else if((title_count>=250)&&(title_count<500))  /*�^�s�ƭȨëG250���ɶ�*/
    {
      seg[switch_sel]=title_segreg;
    }
    else if(title_count>=500)      /*���^�{�{�ʧ@�A����]�w�Ҧ�����*/
    {
      title_count=0;
    }
  }
  else if(key15open!=1)            /*�p�G�]�w�Ҧ������A�~������p��*/
  {
    int_delay++;                   /*����p��*/
    while(int_delay==500)          /*�C���p��500*���_2000u��*/
    {
      int_delay=0;                 /*���]����p��*/
      seg[0]++;                    /*���w�Ӧ�Ʋ֥[1�C*/
      if(seg[0]>=10)               /*�p�G���w�Ӧ�Ƭ�9+1�������A���ƭ��k0�A���Q��Ʋ֥[1�A*/
      {
        seg[0]=0;
        seg[1]++;                  /*���w�Q��Ʋ֥[1*/
        if(seg[1]>=6)              /*�p�G���w�Q��Ƭ�5+1�������A���ƭ��k0�A���ɰw�֥[1�C*/
        {
          seg[1]=0;
          seg[2]++;                /*�ɰw�Ӧ�Ʋ֥[1*/
          if(seg[2]>=10)           /*�p�G�ɰw�Ӧ�Ƭ�9+1�������A���ƭ��k0�A���Q��Ʋ֥[1�C*/
          {
            seg[2]=0;
            seg[3]++;
            if(seg[3]>=6)          /*�p�G�ɰw�Q��Ƭ�5+1�������A���ƭ��k0�C*/
            { 
              seg[3]=0;
            }
          }
        }
      }
    }
  }
}
unsigned short scan_key(void)      /*��L���y���*/
{
  unsigned short i,j,find=0,ini,inj,in;  /*i�Bj�����������y�j��Afind�O�_������Aini�Binj�O����U����������ȡAin�������y�O��*/
  for(i=0;i<4;i++)                 /*�������y�j��*/
  {
    P2=act[i];                     /*�e�J�������y�H��*/
    delay(3);                      /*����3���*/
    in=P2;
    in=in>>4;                      /*�O�������H���]���|�줸�������H���A�C�|�줸�������H��*/
    in=in|0xf0;                    /*�����H���M��*/
    for(j=0;j<4;j++)               /*���������H���j��*/
    {
      if(act[j]==in)               /*�p�G�����P�������y�H���ۦP�]��ܤv����^*/
      {
        find=1;                    /*���F*/
        ini=i;                     /*�O����U�����������*/
        inj=j;
      }
    }
  }
  if(find==0)                      /*�S���Ǧ^0*/
  {
    return 0;
  }
    key=ini*4+inj;                 /*�����ھ�ij�ഫkey�ȡA�öǦ^1*/
    return 1;
}
void give_key(void)                /*����key�Ȩ�ơA�]�w�����}��~���}�����*/
{
  unsigned short getnum_witesc;    /*���U�P�_*/
  getnum_witesc=scan_key();        /*�P�_�O�_�����U*/
  while(getnum_witesc==1)        /*�i�J�L�a�^�骽���}�~���}*/
  {
    getnum_witesc=scan_key();
  }
}
void key_15open(void)              /*�]�w�Ҧ��Ұʮɪ��ʧ@*/
{
  if(key==11)                      /*�p�G���U��B����A�]�w�����C�q��ܾ�������*/
  {
    seg[switch_sel]=title_segreg;
    switch_sel++;
    if(switch_sel>3)               /*�p�G�F�쥪��ɡA�h������k���*/
    {
      switch_sel=0;
    }
    key=16;
  }
  if(key==10)                      /*�p�G���U��A����A�]�w�����C�q��ܾ����k��*/
  {
    seg[switch_sel]=title_segreg;
    if(switch_sel<=0)              /*�p�G�F��k��ɡA�h�����쥪���*/
    {
      switch_sel=3;
    }
    else
    {
      switch_sel--;      
    }
    key=16;
  }
    switch(switch_sel)             /*�]�w�����C�q��ܾ��ʧ@*/
    {
      case 3:                      /*�ĥ|�ӤC�q��ܾ�*/
      {
        if(key<6)                  /*�ɰw�Q��ƶȯ��J0��5*/
        {
          seg[3]=key;              /*�]�w�i*/
          switch_sel=2;            /*�]�w�����C�q��ܾ����k��*/
          key=16;                  /*��ȲM��*/
        }
        break;
      }
      case 2:                      /*�ĤT�ӤC�q��ܾ�*/
      {
        if(key<=9)                 /*�ɰw�Ӧ�ƶȯ��J0��9*/
        {
          seg[2]=key;              /*�]�w�i*/
          switch_sel=1;            /*�]�w�����C�q��ܾ����k��*/
          key=16;                  /*��ȲM��*/
        }
        break;
      }
      case 1:                      /*�ĤG�ӤC�q��ܾ�*/
      {
        if(key<6)                  /*���w�Q��ƶȯ��J0��5*/
        {
          seg[1]=key;              /*�]�w�i*/
          switch_sel=0;            /*�]�w�����C�q��ܾ����k��*/
          key=16;                  /*��ȲM��*/
        }
        break;
      }
      case 0:                      /*�Ĥ@�ӤC�q��ܾ�*/
      {
        if(key<=9)                 /*���w�Q��ƶȯ��J0��9*/
        {
          seg[0]=key;              /*�]�w�i*/
          switch_sel=3;            /*�]�w�����C�q��ܾ����V�����*/
          key=16;                  /*��ȲM��*/
        }
        break;
      }
      default:                     /*��L*/
      {
        switch_sel=3;              /*���w�ĥ|�ӤC�q��ܾ�*/
        key=16;                    /*��ȲM��*/
      }
    }
    if(key==14)                    /*�p�G���U��E����A�]�w�Ҧ�����*/
    {
      key15open=0;
      seg[switch_sel]=title_segreg;/*���x�s���ƭ�Ū�^*/
      switch_sel=3;                /*���w�ĥ|�ӤC�q��ܾ��A�H�K�U���ϥ�*/
      key=16;                      /*��ȲM��*/
    }
}
int main(void)
{
  IE=0x82;                         /*�]�w�p�ɤ��_*/
  TMOD=0x01;                       /*�]�w���_�Ҧ�*/
  TH0=(65536-2000)/256;            /*�]�w���_����ɶ��A�]�w������A�Y�q���ɲִ�A���0�ɶi�J���_�{��*/
  TL0=(65536-2000)%256;            /*�]�w���_����ɶ��A�����G�]65536��x�^�At��x(us)*/
  TR0=1;                           /*�Ұʭp�ɾ��A��AT89S51�p�ɾ��Ұ�*/
  P1=0;
  while(1)                         /*�i�J��L���y�{��*/
  {
    give_key();                    /*�i�J��L���y��ƨ���L��*/
    if(key==15)                    /*�P�O�O�_���U��F����*/
    {
      key15open=1;                 /*�Ұʳ]�w�Ҧ�*/
    }
    if(key15open==1)               /*�Y�]�w�Ҧ��ҰʡA�h�}�l���ݰʧ@*/
    {
      key_15open();
    }
  }
}
