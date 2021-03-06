module FinalProject(answer, submit, clk, rst, redOut, greenOut, LCD_ON, LCD_RW, LCD_EN, LCD_RS, LCD_DATA);

//	LCD Module 16X2
output LCD_ON;	// LCD Power ON/OFF
output LCD_RW;	// LCD Read/Write Select, 0 = Write, 1 = Read
output LCD_EN;	// LCD Enable
output LCD_RS;	// LCD Command/Data Select, 0 = Command, 1 = Data
inout [7:0] LCD_DATA;	// LCD Data bus 8 bits,

input [10:0] answer;
input submit, clk, rst;
//wire submit;
output redOut, greenOut;
reg redOut, greenOut;
reg [7:0] S, NS;
reg Pulse;
reg [10:0] Answer;
reg [4:0] Display;
parameter
				Start = 8'd0,
				pulseS = 8'd13,
	
				Q0 = 8'd1,
				check0 = 8'd2,
				wrong0 = 8'd3,
				correct0 = 8'd4,
				pulseW0 = 8'd9,
				pulseC0 = 8'd10,
				
				Q1 = 8'd5,
				check1 = 8'd6,
				wrong1 = 8'd7,
				correct1 = 8'd8,
				pulseW1 = 8'd11,
				pulseC1 = 8'd12,
				
				Q2 = 8'd14,
				check2 = 8'd15,
				wrong2 = 8'd16,
				correct2 = 8'd17,
				pulseW2 = 8'd18,
				pulseC2 = 8'd19,
				
				Q3 = 8'd20,
				check3 = 8'd21,
				wrong3 = 8'd22,
				correct3 = 8'd23,
				pulseW3 = 8'd24,
				pulseC3 = 8'd25,
				
				Q4 = 8'd26,
				check4 = 8'd27,
				wrong4 = 8'd28,
				correct4 = 8'd29,
				pulseW4 = 8'd30,
				pulseC4 = 8'd31,
				
				Q5 = 8'd32,
				check5 = 8'd33,
				wrong5 = 8'd34,
				correct5 = 8'd35,
				pulseW5 = 8'd36,
				pulseC5 = 8'd37,
				
				Q6 = 8'd38,
				check6 = 8'd39,
				wrong6 = 8'd40,
				correct6 = 8'd41,
				pulseW6 = 8'd42,
				pulseC6 = 8'd43,
				
				Q7 = 8'd44,
				check7 = 8'd45,
				wrong7 = 8'd46,
				correct7 = 8'd47,
				pulseW7 = 8'd48,
				pulseC7 = 8'd49,
				
				Q8 = 8'd50,
				check8 = 8'd51,
				wrong8 = 8'd52,
				correct8 = 8'd53,
				pulseW8 = 8'd54,
				pulseC8 = 8'd55,
				
				Q9 = 8'd56,
				check9 = 8'd57,
				wrong9 = 8'd58,
				correct9 = 8'd59,
				pulseW9 = 8'd60,
				pulseC9 = 8'd61,
				
				Q10 = 8'd62,
				check10 = 8'd63,
				wrong10 = 8'd64,
				correct10 = 8'd65,
				pulseW10 = 8'd66,
				pulseC10 = 8'd67,
				
				Q11 = 8'd68,
				check11 = 8'd69,
				wrong11 = 8'd70,
				correct11 = 8'd71,
				pulseW11 = 8'd72,
				pulseC11 = 8'd73,
				
				Q12 = 8'd74,
				check12 = 8'd75,
				wrong12 = 8'd76,
				correct12 = 8'd77,
				pulseW12 = 8'd78,
				pulseC12 = 8'd79,
				
				Q13 = 8'd80,
				check13 = 8'd81,
				wrong13 = 8'd82,
				correct13 = 8'd83,
				pulseW13 = 8'd84,
				pulseC13 = 8'd85,
				
				Q14 = 8'd86,
				check14 = 8'd87,
				wrong14 = 8'd88,
				correct14 = 8'd89,
				pulseW14 = 8'd90,
				pulseC14 = 8'd91,
				
				Q15 = 8'd92,
				check15 = 8'd93,
				wrong15 = 8'd94,
				correct15 = 8'd95,
				pulseW15 = 8'd96,
				pulseC15 = 8'd97,
				
				Q20 = 8'd98,
				check20 = 8'd99,
				wrong20 = 8'd100,
				correct20 = 8'd101,
				pulseW20 = 8'd102,
				pulseC20 = 8'd103,
				
				Q30 = 8'd104,
				check30 = 8'd105,
				wrong30 = 8'd106,
				correct30 = 8'd107,
				pulseW30 = 8'd108,
				pulseC30 = 8'd109,
				
				Q40 = 8'd110,
				check40 = 8'd111,
				wrong40 = 8'd112,
				correct40 = 8'd113,
				pulseW40 = 8'd114,
				pulseC40 = 8'd115,
				
				Q50 = 8'd116,
				check50 = 8'd117,
				wrong50 = 8'd118,
				correct50 = 8'd119,
				pulseW50 = 8'd120,
				pulseC50 = 8'd121,
				
				Q60 = 8'd122,
				check60 = 8'd123,
				wrong60 = 8'd124,
				correct60 = 8'd125,
				pulseW60 = 8'd126,
				pulseC60 = 8'd127,
				
				Q70 = 8'd128,
				check70 = 8'd129,
				wrong70 = 8'd130,
				correct70 = 8'd131,
				pulseW70 = 8'd132,
				pulseC70 = 8'd133,
				
				Q80 = 8'd134,
				check80 = 8'd135,
				wrong80 = 8'd136,
				correct80 = 8'd137,
				pulseW80 = 8'd138,
				pulseC80 = 8'd139,
				
				Q90 = 8'd140,
				check90 = 8'd141,
				wrong90 = 8'd142,
				correct90 = 8'd143,
				pulseW90 = 8'd144,
				pulseC90 = 8'd145;
				
				
				
		wire [10:0]SWO;
debounce_DE2_SW deb(clk, rst, answer, SWO);		
			//	End = 10'd100;


always @ (posedge clk or negedge rst)
begin
	if (rst == 1'b0)
	begin
		S <= Start;
		//S <= Q0;
	end
	
	else
	begin
		S<= NS;
	end
end

always @ (*)
begin
	case(S) 
	Start: 
	begin
		if(submit == 1'b0)
		begin
			NS = Start;
		end
		else
		begin
		NS = pulseS;
		end
	end
	pulseS: 
		if( submit == 1'b1) 
		begin	
			NS = pulseS;
		end
		else
		begin
			NS = Q0;
		end
	
	Q0:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q0;
		end
		else
		begin	
			NS = check0;
		end
	end
	
	check0:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b00000000001 )
			begin
				NS = correct0;
			end
			else 
			begin
			
				NS = wrong0;
			end
		end
		
		else 
		begin
			NS = Q0;
		end
	end
	
	wrong0:
	begin
		if (submit == 0)
		begin
			NS = pulseW0;
		end
		else
		begin
			NS = wrong0;
		end
	
	end
	correct0:
	begin
		if (submit == 0)
		begin
			NS = pulseC0;
		end
		else
		begin
			NS = correct0;
		end
	end
	pulseC0:NS =Q1;
	pulseW0:	NS= Q0;

	
	Q1:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q1;
		end
		else
		begin	
			NS = check1;
		end
	end
	
	check1:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b00000000010 )
			begin

				NS = correct1;
			end
			else 
			begin

				NS = wrong1;
			end
		end
		
		else 
		begin
			NS = Q1;
		end
	end
		
	wrong1:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW1;
		end
		else
		begin
			NS = wrong1;
		end
	
	end
	correct1:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC1;
		end
		else
		begin
			NS = correct1;
		end
	end
	pulseC1:NS = Q2;
	
	pulseW1:	NS= Q1;
	
	Q2:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q2;
		end
		else
		begin	
			NS = check2;
		end
	end
	
	check2:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b00000000100 )
			begin
				NS = correct2;
			end
			else 
			begin
			
				NS = wrong2;
			end
		end
		
		else 
		begin
			NS = Q2;
		end
	end
	
	wrong2:
	begin
		if (submit == 0)
		begin
			NS = pulseW2;
		end
		else
		begin
			NS = wrong2;
		end
	
	end
	correct2:
	begin
		if (submit == 0)
		begin
			NS = pulseC2;
		end
		else
		begin
			NS = correct2;
		end
	end
	pulseC2:NS =Q3;
	pulseW2:	NS= Q2;
	Q4:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q4;
		end
		else
		begin	
			NS = check4;
		end
	end
	
	check4:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b00000010000 )
			begin
				NS = correct4;
			end
			else 
			begin
			
				NS = wrong4;
			end
		end
		
		else 
		begin
			NS = Q4;
		end
	end
	
	wrong4:
	begin
		if (submit == 0)
		begin
			NS = pulseW4;
		end
		else
		begin
			NS = wrong4;
		end
	
	end
	correct4:
	begin
		if (submit == 0)
		begin
			NS = pulseC4;
		end
		else
		begin
			NS = correct4;
		end
	end
	pulseC4:NS =Q5;
	pulseW4:	NS= Q4;
	//*
	Q3:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q3;
		end
		else
		begin	
			NS = check3;
		end
	end
	
	check3:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b00000001000 )
			begin

				NS = correct3;
			end
			else 
			begin

				NS = wrong3;
			end
		end
		
		else 
		begin
			NS = Q3;
		end
	end
		
	wrong3:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW3;
		end
		else
		begin
			NS = wrong3;
		end
	
	end
	correct3:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC3;
		end
		else
		begin
			NS = correct3;
		end
	end
	pulseC3:NS = Q4;
	
	pulseW3:	NS= Q3;
	
		Q5:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q5;
		end
		else
		begin	
			NS = check5;
		end
	end
	
	check5:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b00000100000 )
			begin

				NS = correct5;
			end
			else 
			begin

				NS = wrong5;
			end
		end
		
		else 
		begin
			NS = Q5;
		end
	end
		
	wrong5:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW5;
		end
		else
		begin
			NS = wrong5;
		end
	
	end
	correct5:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC5;
		end
		else
		begin
			NS = correct5;
		end
	end
	pulseC5:NS = Q6;
	
	pulseW5:	NS= Q5;
	
	Q6:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q6;
		end
		else
		begin	
			NS = check6;
		end
	end
	
	check6:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b00001000000 )
			begin
				NS = correct6;
			end
			else 
			begin
			
				NS = wrong6;
			end
		end
		
		else 
		begin
			NS = Q6;
		end
	end
	
	wrong6:
	begin
		if (submit == 0)
		begin
			NS = pulseW6;
		end
		else
		begin
			NS = wrong6;
		end
	
	end
	correct6:
	begin
		if (submit == 0)
		begin
			NS = pulseC6;
		end
		else
		begin
			NS = correct6;
		end
	end
	pulseC6:NS =Q7;
	pulseW6:	NS= Q6;
	
	Q7:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q7;
		end
		else
		begin	
			NS = check7;
		end
	end
	
	check7:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b00010000000 )
			begin

				NS = correct7;
			end
			else 
			begin

				NS = wrong7;
			end
		end
		
		else 
		begin
			NS = Q7;
		end
	end
		
	wrong7:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW7;
		end
		else
		begin
			NS = wrong7;
		end
	
	end
	correct7:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC7;
		end
		else
		begin
			NS = correct7;
		end
	end
	pulseC7:NS = Q8;
	
	pulseW7:	NS= Q7;
	
	Q8:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q8;
		end
		else
		begin	
			NS = check8;
		end
	end
	
	check8:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b00100000000 )
			begin

				NS = correct8;
			end
			else 
			begin

				NS = wrong8;
			end
		end
		
		else 
		begin
			NS = Q8;
		end
	end
		
	wrong8:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW8;
		end
		else
		begin
			NS = wrong8;
		end
	
	end
	correct8:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC8;
		end
		else
		begin
			NS = correct8;
		end
	end
	pulseC8:NS = Q9;
	
	pulseW8:	NS= Q8;
	
	Q9:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q9;
		end
		else
		begin	
			NS = check9;
		end
	end
	
	check9:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b01000000000 )
			begin
				NS = correct9;
			end
			else 
			begin
			
				NS = wrong9;
			end
		end
		
		else 
		begin
			NS = Q9;
		end
	end
	
	wrong9:
	begin
		if (submit == 1'b0)
		begin
			NS = pulseW9;
		end
		else
		begin
			NS = wrong9;
		end
	
	end
	correct9:
	begin
		if (submit == 0)
		begin
			NS = pulseC9;
		end
		else
		begin
			NS = correct9;
		end
	end
	pulseC9:NS =Q10;
	pulseW9:	NS= Q9;
	
	Q10:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q10;
		end
		else
		begin	
			NS = check10;
		end
	end
	
	check10:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b10000000000 )
			begin

				NS = correct10;
			end
			else 
			begin

				NS = wrong10;
			end
		end
		
		else 
		begin
			NS = Q10;
		end
	end
		
	wrong10:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW10;
		end
		else
		begin
			NS = wrong10;
		end
	
	end
	correct10:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC10;
		end
		else
		begin
			NS = correct10;
		end
	end
	pulseC10:NS = Q11;
	
	pulseW10:	NS= Q10;
	
	Q11:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q11;
		end
		else
		begin	
			NS = check11;
		end
	end
	
	check11:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b10000000010 )
			begin

				NS = correct11;
			end
			else 
			begin

				NS = wrong11;
			end
		end
		
		else 
		begin
			NS = Q11;
		end
	end
		
	wrong11:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW11;
		end
		else
		begin
			NS = wrong11;
		end
	
	end
	correct11:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC11;
		end
		else
		begin
			NS = correct11;
		end
	end
	pulseC11:NS = Q12;
	
	pulseW11:	NS= Q11;
	
	Q12:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q12;
		end
		else
		begin	
			NS = check12;
		end
	end
	
	check12:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b10000000100 )
			begin
				NS = correct12;
			end
			else 
			begin
			
				NS = wrong12;
			end
		end
		
		else 
		begin
			NS = Q12;
		end
	end
	
	wrong12:
	begin
		if (submit == 0)
		begin
			NS = pulseW12;
		end
		else
		begin
			NS = wrong12;
		end
	
	end
	correct12:
	begin
		if (submit == 0)
		begin
			NS = pulseC12;
		end
		else
		begin
			NS = correct12;
		end
	end
	pulseC12:NS =Q13;
	pulseW12:	NS= Q12;
	Q14:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q14;
		end
		else
		begin	
			NS = check14;
		end
	end
	
	check14:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b10000010000 )
			begin
				NS = correct14;
			end
			else 
			begin
			
				NS = wrong14;
			end
		end
		
		else 
		begin
			NS = Q14;
		end
	end
	
	wrong14:
	begin
		if (submit == 0)
		begin
			NS = pulseW14;
		end
		else
		begin
			NS = wrong14;
		end
	
	end
	correct14:
	begin
		if (submit == 0)
		begin
			NS = pulseC14;
		end
		else
		begin
			NS = correct14;
		end
	end
	pulseC14:NS =Q15;
	pulseW14:	NS= Q14;
	//*
	Q13:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q13;
		end
		else
		begin	
			NS = check13;
		end
	end
	
	check13:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b10000001000 )
			begin

				NS = correct13;
			end
			else 
			begin

				NS = wrong13;
			end
		end
		
		else 
		begin
			NS = Q13;
		end
	end
		
	wrong13:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW13;
		end
		else
		begin
			NS = wrong13;
		end
	
	end
	correct13:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC13;
		end
		else
		begin
			NS = correct13;
		end
	end
	pulseC13:NS = Q14;
	
	pulseW13:	NS= Q13;
	
		Q15:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q15;
		end
		else
		begin	
			NS = check15;
		end
	end
	
	check15:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b10000100000 )
			begin

				NS = correct15;
			end
			else 
			begin

				NS = wrong15;
			end
		end
		
		else 
		begin
			NS = Q15;
		end
	end
		
	wrong15:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW15;
		end
		else
		begin
			NS = wrong15;
		end
	
	end
	correct15:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC15;
		end
		else
		begin
			NS = correct15;
		end
	end
	pulseC15:NS = Q20;
	
	pulseW15:	NS= Q15;
	
	Q20:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q20;
		end
		else
		begin	
			NS = check20;
		end
	end
	
	check20:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b00000000101 )
			begin
				NS = correct20;
			end
			else 
			begin
			
				NS = wrong20;
			end
		end
		
		else 
		begin
			NS = Q20;
		end
	end
	
	wrong20:
	begin
		if (submit == 0)
		begin
			NS = pulseW20;
		end
		else
		begin
			NS = wrong20;
		end
	
	end
	correct20:
	begin
		if (submit == 0)
		begin
			NS = pulseC20;
		end
		else
		begin
			NS = correct20;
		end
	end
	pulseC20:NS = Q30;
	pulseW20:	NS= Q20;
	Q40:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q40;
		end
		else
		begin	
			NS = check40;
		end
	end
	
	check40:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b00000010001 )
			begin
				NS = correct40;
			end
			else 
			begin
			
				NS = wrong40;
			end
		end
		
		else 
		begin
			NS = Q40;
		end
	end
	
	wrong40:
	begin
		if (submit == 0)
		begin
			NS = pulseW40;
		end
		else
		begin
			NS = wrong40;
		end
	
	end
	correct40:
	begin
		if (submit == 0)
		begin
			NS = pulseC40;
		end
		else
		begin
			NS = correct40;
		end
	end
	pulseC40:NS =Q50;
	pulseW40:	NS= Q40;
	//*
	Q30:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q30;
		end
		else
		begin	
			NS = check30;
		end
	end
	
	check30:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b00000001001 )
			begin

				NS = correct30;
			end
			else 
			begin

				NS = wrong30;
			end
		end
		
		else 
		begin
			NS = Q30;
		end
	end
		
	wrong30:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW30;
		end
		else
		begin
			NS = wrong30;
		end
	
	end
	correct30:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC30;
		end
		else
		begin
			NS = correct30;
		end
	end
	pulseC30:NS = Q40;
	
	pulseW30:	NS= Q30;
	
		Q50:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q50;
		end
		else
		begin	
			NS = check50;
		end
	end
	
	check50:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b00000100001 )
			begin

				NS = correct50;
			end
			else 
			begin

				NS = wrong50;
			end
		end
		
		else 
		begin
			NS = Q50;
		end
	end
		
	wrong50:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW50;
		end
		else
		begin
			NS = wrong50;
		end
	
	end
	correct50:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC50;
		end
		else
		begin
			NS = correct50;
		end
	end
	pulseC50:NS = Q60;
	
	pulseW50:	NS= Q50;
	
	Q60:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q60;
		end
		else
		begin	
			NS = check60;
		end
	end
	
	check60:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b00001000001 )
			begin
				NS = correct60;
			end
			else 
			begin
			
				NS = wrong60;
			end
		end
		
		else 
		begin
			NS = Q60;
		end
	end
	
	wrong60:
	begin
		if (submit == 0)
		begin
			NS = pulseW60;
		end
		else
		begin
			NS = wrong60;
		end
	
	end
	correct60:
	begin
		if (submit == 0)
		begin
			NS = pulseC60;
		end
		else
		begin
			NS = correct60;
		end
	end
	pulseC60:NS =Q70;
	pulseW60:	NS= Q60;
	
	Q70:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q70;
		end
		else
		begin	
			NS = check70;
		end
	end
	
	check70:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b00010000001 )
			begin

				NS = correct70;
			end
			else 
			begin

				NS = wrong70;
			end
		end
		
		else 
		begin
			NS = Q70;
		end
	end
		
	wrong70:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW70;
		end
		else
		begin
			NS = wrong70;
		end
	
	end
	correct70:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC70;
		end
		else
		begin
			NS = correct70;
		end
	end
	pulseC70:NS = Q80;
	
	pulseW70:	NS= Q70;
	
	Q80:
	begin
		if (submit == 1'b0)
		begin	
			NS = Q80;
		end
		else
		begin	
			NS = check80;
		end
	end
	
	check80:
	begin
		if(submit == 1'b1)
		begin
			if (Answer == 11'b00100000001 )
			begin

				NS = correct80;
			end
			else 
			begin

				NS = wrong80;
			end
		end
		
		else 
		begin
			NS = Q80;
		end
	end
		
	wrong80:
	begin
		if (submit == 0)
		begin
		
			NS = pulseW80;
		end
		else
		begin
			NS = wrong80;
		end
	
	end
	correct80:
	begin
		if (submit == 0)
		begin
		
			NS = pulseC80;
		end
		else
		begin
			NS = correct80;
		end
	end
	pulseC80:NS = Q90;
	
	pulseW80:	NS= Q80;
	
	Q90:
	begin
		
		if (submit == 1'b0)
		begin	
			NS = Q90;
		end
		else
		begin	
			NS = check90;
		end
	end
	
	check90:
	begin
		if(submit == 1'b1)
		begin 
			if (Answer == 11'b01000000001 )
			begin
				NS = correct90;
			end
			else 
			begin
			
				NS = wrong90;
			end
		end
		
		else 
		begin
			NS = Q90;
		end
	end
	
	wrong90:
	begin
		if (submit == 0)
		begin
			NS = pulseW90;
		end
		else
		begin
			NS = wrong90;
		end
	
	end
	correct90:
	begin
		if (submit == 0)
		begin
			NS = pulseC90;
		end
		else
		begin
			NS = correct90;
		end
	end
	pulseC90:NS =Start;
	pulseW90:	NS= Q90;
	
	endcase
end	
always @ (posedge clk or negedge rst)
begin
	if(rst == 1'b0)
	begin
	Pulse <= 1'b1;
	greenOut <= 1'b0;
	redOut <= 1'b0;
	Answer <= 10'b0;
	Display <= 5'd0;
	end
	else
	begin
		case(S)
		Start:
		begin
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd0;
		Pulse <= 1'b0;
		end
		
		pulseS: Pulse <= 1'b1; 
		
		Q0: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd3;
		
		end	
	check0: Pulse <= 1'b1;
		
	correct0: 
		begin
						greenOut <= 1'b1;
						Display <= 5'd1;
						Pulse <= 1'b0;
						Answer <= 11'b0;
		end
	wrong0: 
		begin
		Display <= 5'd2;
			redOut <= 1'b1;
			Pulse <= 1'b0;

		end

		pulseW0: Pulse <= 1'b1;
		pulseC0: Pulse <= 1'b1;
	
	Q1: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd4;
		
		end
	check1: Pulse <= 1'b1;
		
	correct1: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong1: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW1: Pulse <= 1'b1;
	pulseC1: Pulse <= 1'b1;
		
		
	Q2: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd5;
		
		end	
	check2: Pulse <= 1'b1;
		
	correct2: 
		begin
						greenOut <= 1'b1;
						Display <= 5'd1;
						Pulse <= 1'b0;
						Answer <= 11'b0;
		end
	wrong2: 
		begin
			Display <= 5'd2;
			redOut <= 1'b1;
			Pulse <= 1'b0;
		end

	pulseW2: Pulse <= 1'b1;
	pulseC2: Pulse <= 1'b1;
	
	Q3: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd6;
		
		end
	check3: Pulse <= 1'b1;
		
	correct3: 
		begin
						Answer <= 11'b0;
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
		end
	wrong3: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW3: Pulse <= 1'b1;
	pulseC3: Pulse <= 1'b1;
		
		Q4: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd7;
		
		end
		check4: Pulse <= 1'b1;
		
		correct4: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 10'b0;
		end
		wrong4: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
		pulseW4: Pulse <= 1'b1;
		pulseC4: Pulse <= 1'b1;
		
	Q5: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd8;
		
		end
	check5: Pulse <= 1'b1;
		
	correct5: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong5: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW5: Pulse <= 1'b1;
	pulseC5: Pulse <= 1'b1;
	
	Q6: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd9;
		
		end
	check6: Pulse <= 1'b1;
		
	correct6: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong6: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW6: Pulse <= 1'b1;
	pulseC6: Pulse <= 1'b1;
	
	//*
	Q7: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd10;
		
		end
		check7: Pulse <= 1'b1;
		
		correct7: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
		wrong7: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
		pulseW7: Pulse <= 1'b1;
		pulseC7: Pulse <= 1'b1;
		
	Q8: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd11;
		
		end
	check8: Pulse <= 1'b1;
		
	correct8: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong8: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW8: Pulse <= 1'b1;
	pulseC8: Pulse <= 1'b1;
	
	Q9: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd12;
		
		end
	check9: Pulse <= 1'b1;
		
	correct9: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong9: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW9: Pulse <= 1'b1;
	pulseC9: Pulse <= 1'b1;
	
	
	Q10: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd13;
		
		end
	check10: Pulse <= 1'b1;
		
	correct10: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong10: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW10: Pulse <= 1'b1;
	pulseC10: Pulse <= 1'b1;
		
		
	Q11: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd14;
		
		end
	check11: Pulse <= 1'b1;
		
	correct11: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong11: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW11: Pulse <= 1'b1;
	pulseC11: Pulse <= 1'b1;
		
		
	Q12: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd15;
		
		end	
	check12: Pulse <= 1'b1;
		
	correct12: 
		begin
						greenOut <= 1'b1;
						Display <= 5'd1;
						Pulse <= 1'b0;
						Answer <= 11'b0;
		end
	wrong12: 
		begin
			Display <= 5'd2;
			redOut <= 1'b1;
			Pulse <= 1'b0;
		end

	pulseW12: Pulse <= 1'b1;
	pulseC12: Pulse <= 1'b1;
	
	Q13: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd16;
		
		end
	check13: Pulse <= 1'b1;
		
	correct13: 
		begin
						Answer <= 11'b0;
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
		end
	wrong13: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW13: Pulse <= 1'b1;
	pulseC13: Pulse <= 1'b1;
		
		Q14: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd17;
		
		end
		check14: Pulse <= 1'b1;
		
		correct14: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
		wrong14: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
		pulseW14: Pulse <= 1'b1;
		pulseC14: Pulse <= 1'b1;
		
	Q15: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd18;
		
		end
	check15: Pulse <= 1'b1;
		
	correct15: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong15: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW15: Pulse <= 1'b1;
	pulseC15: Pulse <= 1'b1;
		
	Q20: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd19;
		
		end	
	check20: Pulse <= 1'b1;
		
	correct20: 
		begin
						greenOut <= 1'b1;
						Display <= 5'd1;
						Pulse <= 1'b0;
						Answer <= 11'b0;
		end
	wrong20: 
		begin
			Display <= 5'd2;
			redOut <= 1'b1;
			Pulse <= 1'b0;
		end

	pulseW20: Pulse <= 1'b1;
	pulseC20: Pulse <= 1'b1;
	
	Q30: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd20;
		
		end
		check30: Pulse <= 1'b1;
		
		correct30: 
		begin
						Answer <= 11'b0;
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
		end
		wrong30: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
		pulseW30: Pulse <= 1'b1;
		pulseC30: Pulse <= 1'b1;
		
		Q40: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd21;
		
		end
		check40: Pulse <= 1'b1;
		
		correct40: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
		wrong40: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
		pulseW40: Pulse <= 1'b1;
		pulseC40: Pulse <= 1'b1;
		
	Q50: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd22;
		
		end
	check50: Pulse <= 1'b1;
		
	correct50: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong50: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW50: Pulse <= 1'b1;
	pulseC50: Pulse <= 1'b1;
	
	Q60: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd23;
		
		end
	check60: Pulse <= 1'b1;
		
	correct60: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong60: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW60: Pulse <= 1'b1;
	pulseC60: Pulse <= 1'b1;
	
	//*
	Q70: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd24;
		
		end
		check70: Pulse <= 1'b1;
		
		correct70: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
		wrong70: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
		pulseW70: Pulse <= 1'b1;
		pulseC70: Pulse <= 1'b1;
		
	Q80: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd25;
		
		end
	check80: Pulse <= 1'b1;
		
	correct80: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong80: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW80: Pulse <= 1'b1;
	pulseC80: Pulse <= 1'b1;
	
	Q90: 
		begin
		Pulse <= 1'b0;
		Answer <= SWO;
		greenOut <= 1'b0;
		redOut <= 1'b0;
		Display <= 5'd26;
		
		end
	check90: Pulse <= 1'b1;
		
	correct90: 
		begin
						greenOut <= 1'b1;
						Pulse <= 1'b0;
						Display <= 5'd1;
						Answer <= 11'b0;
		end
	wrong90: 
		begin
			redOut <= 1'b1;
			Display <= 5'd2;
			Pulse <= 1'b0;
		end
	pulseW90: Pulse <= 1'b1;
	pulseC90: Pulse <= 1'b1;
		endcase
	end
	
end

lcdlab1 info(
	.rst(rst),
  .CLOCK_50(clk),	//	50 MHz clock
//	LCD Module 16X2
  .LCD_ON(LCD_ON),	// LCD Power ON/OFF
  .LCD_RW(LCD_RW),	// LCD Read/Write Select, 0 = Write, 1 = Read
  .LCD_EN(LCD_EN),	// LCD Enable
  .LCD_RS(LCD_RS),	// LCD Command/Data Select, 0 = Command, 1 = Data
  .LCD_DATA(LCD_DATA),	// LCD Data bus 8 bits,
  .Display(Display),
  .Pulse(Pulse)
);


endmodule

module debounce_DE2_SW (clk, rst_n, answer, SWO);
input rst_n, clk;
input [10:0]answer;
output [10:0]SWO;
wire [10:0]SWO;

debouncer sw0(clk, rst_n, answer[0], SWO[0]);
debouncer sw1(clk, rst_n, answer[1], SWO[1]);
debouncer sw2(clk, rst_n, answer[2], SWO[2]);
debouncer sw3(clk, rst_n, answer[3], SWO[3]);
debouncer sw4(clk, rst_n, answer[4], SWO[4]);
debouncer sw5(clk, rst_n, answer[5], SWO[5]);
debouncer sw6(clk, rst_n, answer[6], SWO[6]);
debouncer sw7(clk, rst_n, answer[7], SWO[7]);
debouncer sw8(clk, rst_n, answer[8], SWO[8]);
debouncer sw9(clk, rst_n, answer[9], SWO[9]);
debouncer sw10(clk, rst_n, answer[10], SWO[10]);


endmodule

module debouncer (clk, rst_n, noisy, clean);
input rst_n, clk, noisy;
output clean;
   
reg xnew, clean;

reg [1:0] b_state;
reg [19:0] b_counter;

parameter 	ON=		2'd0, 
		ON_2_OFF=	2'd1, 
		OFF=		2'd2, 
		OFF_2_ON=	2'd3;

always @ (posedge clk or negedge rst_n) 
begin
	if (rst_n == 1'b0) 
	begin
		b_state <= OFF;
		b_counter <= 20'b0;
		clean <= 1'b0;
	end
	else 
	begin
		case (b_state)
			ON:
			begin
				b_state <= (noisy == 1'b0) ? ON_2_OFF : ON; 
				b_counter <= 20'b0;
				clean <= 1'b1;
			end
			OFF:
			begin
				b_state <= (noisy == 1'b1) ? OFF_2_ON : OFF; 
				b_counter <= 20'b0;
				clean <= 1'b0;
			end
			ON_2_OFF:
			begin
				b_state <= (b_counter >= 20'd5000) ? OFF : ON_2_OFF; 
				b_counter <= b_counter + 1'b1;
				clean <= 1'b1;
			end
			OFF_2_ON:
			begin
				b_state <= (b_counter >= 20'd5000) ? ON : OFF_2_ON; 
				b_counter <= b_counter + 1'b1;
				clean <= 1'b0;
			end
		endcase
	end
end
	
endmodule