module c459(v,w,x,y,z,f);
  input v,w,x,y,z;
  output f;
  assign f=	({v,w,x,y,z}==0)|
			({v,w,x,y,z}==1)|
			({v,w,x,y,z}==2)|
			({v,w,x,y,z}==3)|
			({v,w,x,y,z}==4)|
			({v,w,x,y,z}==5)|
			({v,w,x,y,z}==10)|
			({v,w,x,y,z}==11)|
			({v,w,x,y,z}==14)|
			({v,w,x,y,z}==20)|
			({v,w,x,y,z}==21)|
			({v,w,x,y,z}==24)|
			({v,w,x,y,z}==25)|
			({v,w,x,y,z}==26)|
			({v,w,x,y,z}==27)|
			({v,w,x,y,z}==28)|
			({v,w,x,y,z}==29)|
			({v,w,x,y,z}==30);
endmodule