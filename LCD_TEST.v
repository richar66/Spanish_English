module    LCD_TEST (
	input rst, Pulse,
	input [4:0]Display,
// Host Side
  input iCLK,iRST_N,
// LCD Side
  output [7:0]     LCD_DATA,
  output LCD_RW,LCD_EN,LCD_RS  
);
//    Internal Wires/Registers
reg    [5:0]    LUT_INDEX;
reg    [8:0]    LUT_DATA;
reg    [5:0]    mLCD_ST;
reg    [17:0]    mDLY;
reg        mLCD_Start;
reg    [7:0]    mLCD_DATA;
reg        mLCD_RS;
wire        mLCD_Done;

parameter    LCD_INTIAL    =    0;
parameter    LCD_LINE1    =    5;
parameter    LCD_CH_LINE    =    LCD_LINE1+16;
parameter    LCD_LINE2    =    LCD_LINE1+16+1;
parameter    LUT_SIZE    =    LCD_LINE1+32+1;

parameter
				Start = 5'd0,
				
				Correct= 5'd1,
				Wrong = 5'd2,
				Q0 = 5'd3,
				Q1 = 5'd4,
				Q2 = 5'd5,
				Q3 = 5'd6,
				Q4 = 5'd7,
				Q5 = 5'd8,
				Q6 = 5'd9,
				Q7 = 5'd10,
				Q8 = 5'd11,
				Q9 = 5'd12,
				Q10 = 5'd13,
				Q11 = 5'd14,
				Q12 = 5'd15,
				Q13 = 5'd16,
				Q14 = 5'd17,
				Q15 = 5'd18,
				Q20 = 5'd19,
				Q30 = 5'd20,
				Q40 = 5'd21,
				Q50 = 5'd22,
				Q60 = 5'd23,
				Q70 = 5'd24,
				Q80 = 5'd25,
				Q90 = 5'd26;
			//	End = 5'd27;
				
always@(posedge iCLK or negedge iRST_N)
begin
    if(!iRST_N)
    begin
        LUT_INDEX    <=    0;
        mLCD_ST        <=    0;
        mDLY        <=    0;
        mLCD_Start    <=    0;
        mLCD_DATA    <=    0;
        mLCD_RS        <=    0;
    end
	 
	else
	begin
	if(Pulse == 1'b1)
	begin
			LUT_INDEX    <=    0;
        mLCD_ST        <=    0;
        mDLY        <=    0;
        mLCD_Start    <=    0;
        mLCD_DATA    <=    0;
        mLCD_RS        <=    0;
	end
		if(LUT_INDEX<LUT_SIZE)
        begin
            case(mLCD_ST)
            0:    begin
                    mLCD_DATA    <=    LUT_DATA[7:0];
                    mLCD_RS        <=    LUT_DATA[8];
                    mLCD_Start    <=    1;
                    mLCD_ST        <=    1;
                end
            1:    begin
                    if(mLCD_Done)
                    begin
                        mLCD_Start    <=    0;
                        mLCD_ST        <=    2;                    
                    end
                end
            2:    begin
                    if(mDLY<18'h3FFFE)
                    mDLY    <=    mDLY + 1'b1;
                    else
                    begin
                        mDLY    <=    0;
                        mLCD_ST    <=    3;
                    end
                end
            3:    begin
                    LUT_INDEX    <=    LUT_INDEX + 1'b1;
                    mLCD_ST    <=    0;
                end
            endcase
        end
		end
    
end

always
begin

	case(Display)
	
	Start:
    case(LUT_INDEX)
    //    Initial
    LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
    LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
    LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
    LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
    LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
    //    Line 1
	 LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
    
    //    Change Line
    LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
    //    Line 2
		LCD_LINE2+0:    LUT_DATA    <=    9'h14E;    //    Nice To See You!
    LCD_LINE2+1:    LUT_DATA    <=    9'h169;
    LCD_LINE2+2:    LUT_DATA    <=    9'h163;
    LCD_LINE2+3:    LUT_DATA    <=    9'h165;
    LCD_LINE2+4:    LUT_DATA    <=    9'h120;
    LCD_LINE2+5:    LUT_DATA    <=    9'h154;
    LCD_LINE2+6:    LUT_DATA    <=    9'h16F;
    LCD_LINE2+7:    LUT_DATA    <=    9'h120;
    LCD_LINE2+8:    LUT_DATA    <=    9'h153;
    LCD_LINE2+9:    LUT_DATA    <=    9'h165;
    LCD_LINE2+10:    LUT_DATA    <=    9'h165;
    LCD_LINE2+11:    LUT_DATA    <=    9'h120;
    LCD_LINE2+12:    LUT_DATA    <=    9'h159;
    LCD_LINE2+13:    LUT_DATA    <=    9'h16F;
    LCD_LINE2+14:    LUT_DATA    <=    9'h175;
    LCD_LINE2+15:    LUT_DATA    <=    9'h121;
    default:        LUT_DATA    <=    9'dx ;
    endcase
	
	Q0:
    case(LUT_INDEX)
    //    Initial
    LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
    LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
    LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
    LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
    LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
    //    Line 1
	 LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
    
    //    Change Line
    LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
    //    Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+6:	LUT_DATA	<=	9'h143;	//C 
		LCD_LINE2+7:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+8:	LUT_DATA	<=	9'h172;	//r
		LCD_LINE2+9:	LUT_DATA	<=	9'h16F;	//o
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	Correct: 
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h143;	//C
		LCD_LINE2+5:	LUT_DATA	<=	9'h16F;	//o
		LCD_LINE2+6:	LUT_DATA	<=	9'h172;	//r
		LCD_LINE2+7:	LUT_DATA	<=	9'h172;	//r
		LCD_LINE2+8:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+9:	LUT_DATA	<=	9'h163;	//c
		LCD_LINE2+10:	LUT_DATA	<=	9'h174;	//t
		LCD_LINE2+11:	LUT_DATA	<=	9'h121;	//!
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	
	Wrong:
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space 
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h157;	//W
		LCD_LINE2+6:	LUT_DATA	<=	9'h172;	//r 
		LCD_LINE2+7:	LUT_DATA	<=	9'h16F;	//o
		LCD_LINE2+8:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+9:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE2+10:	LUT_DATA	<=	9'h121;	//! 
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	
	Q1:
	case(LUT_INDEX)
    //    Initial
    LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
    LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
    LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
    LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
    LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
    //    Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
    //    Change Line
		LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
    //    Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+6:	LUT_DATA	<=	9'h155;	//U 
		LCD_LINE2+7:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+8:	LUT_DATA	<=	9'h16F;	//o
		LCD_LINE2+9:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+10:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
		
		
		Q2:
	case(LUT_INDEX)
    //    Initial
    LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
    LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
    LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
    LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
    LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
    //    Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
    //    Change Line
		LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
    //    Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+6:	LUT_DATA	<=	9'h144;	//D 
		LCD_LINE2+7:	LUT_DATA	<=	9'h16F;	//o
		LCD_LINE2+8:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE2+9:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+10:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	Q3:
		case(LUT_INDEX)
		//    Initial
		LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
		LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
		LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
		LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
		LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
    //    Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
    //    Change Line
		LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
    //    Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h154;	//T
		LCD_LINE2+6:	LUT_DATA	<=	9'h172;	//r 
		LCD_LINE2+7:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+8:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE2+9:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+10:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	Q4: 
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h143;	//C
		LCD_LINE2+6:	LUT_DATA	<=	9'h175;	//u
		LCD_LINE2+7:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE2+8:	LUT_DATA	<=	9'h174;	//t
		LCD_LINE2+9:	LUT_DATA	<=	9'h172;	//r
		LCD_LINE2+10:	LUT_DATA	<=	9'h16F;	//o
		LCD_LINE2+11:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	
	Q5:
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space 
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h143;	//C
		LCD_LINE2+6:	LUT_DATA	<=	9'h169;	//i 
		LCD_LINE2+7:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+8:	LUT_DATA	<=	9'h163;	//c
		LCD_LINE2+9:	LUT_DATA	<=	9'h16F;	//o
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	Q6: 
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//sp
		LCD_LINE2+5:	LUT_DATA	<=	9'h120;	//sp
		LCD_LINE2+6:	LUT_DATA	<=	9'h153;	//S
		LCD_LINE2+7:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+8:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE2+9:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//Space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	
	Q7:
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space 
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h153;	//S
		LCD_LINE2+6:	LUT_DATA	<=	9'h169;	//i 
		LCD_LINE2+7:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+8:	LUT_DATA	<=	9'h174;	//t
		LCD_LINE2+9:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
		
		
	Q8: 
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//Spcae
		LCD_LINE2+5:	LUT_DATA	<=	9'h14F;	//O
		LCD_LINE2+6:	LUT_DATA	<=	9'h163;	//c
		LCD_LINE2+7:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE2+8:	LUT_DATA	<=	9'h16F;	//o
		LCD_LINE2+9:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+10:	LUT_DATA	<=	9'h120;	//spca
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//Space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	
	Q9:
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space 
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h14E;	//N
		LCD_LINE2+6:	LUT_DATA	<=	9'h175;	//u 
		LCD_LINE2+7:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+8:	LUT_DATA	<=	9'h176;	//v
		LCD_LINE2+9:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
		
	Q10:
		case(LUT_INDEX)
		//    Initial
		LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
		LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
		LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
		LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
		LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
    //    Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
    //    Change Line
		LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
    //    Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h144;	//D
		LCD_LINE2+6:	LUT_DATA	<=	9'h169;	//i 
		LCD_LINE2+7:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+8:	LUT_DATA	<=	9'h17A;	//z
		LCD_LINE2+9:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+10:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
		
		
		Q11:
		case(LUT_INDEX)
		//    Initial
		LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
		LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
		LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
			LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
		 LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
    //    Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
    //    Change Line
		LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
    //    Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h14F;	//O
		LCD_LINE2+6:	LUT_DATA	<=	9'h16E;	//n 
		LCD_LINE2+7:	LUT_DATA	<=	9'h163;	//c
		LCD_LINE2+8:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+9:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+10:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	Q12:
		case(LUT_INDEX)
		//    Initial
		LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
		LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
		LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
		LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
		LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
    //    Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
    //    Change Line
		LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
    //    Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h144;	//D
		LCD_LINE2+6:	LUT_DATA	<=	9'h16F;	//o 
		LCD_LINE2+7:	LUT_DATA	<=	9'h163;	//c
		LCD_LINE2+8:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+9:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+10:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	Q13: 
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h154;	//T
		LCD_LINE2+6:	LUT_DATA	<=	9'h172;	//r
		LCD_LINE2+7:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+8:	LUT_DATA	<=	9'h163;	//c
		LCD_LINE2+9:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//sp
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	
	Q14:
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space 
		LCD_LINE2+4:	LUT_DATA	<=	9'h143;	//C
		LCD_LINE2+5:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE2+6:	LUT_DATA	<=	9'h174;	//t 
		LCD_LINE2+7:	LUT_DATA	<=	9'h16F;	//o
		LCD_LINE2+8:	LUT_DATA	<=	9'h172;	//r
		LCD_LINE2+9:	LUT_DATA	<=	9'h163;	//c
		LCD_LINE2+10:	LUT_DATA	<=	9'h165;	//e 
		LCD_LINE2+11:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	Q15: 
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h151;	//Q
		LCD_LINE2+5:	LUT_DATA	<=	9'h175;	//u
		LCD_LINE2+6:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE2+7:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+8:	LUT_DATA	<=	9'h163;	//c
		LCD_LINE2+9:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//Space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	
	Q20:
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space 
		LCD_LINE2+4:	LUT_DATA	<=	9'h156;	//V
		LCD_LINE2+5:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+6:	LUT_DATA	<=	9'h169;	//i 
		LCD_LINE2+7:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+8:	LUT_DATA	<=	9'h174;	//t
		LCD_LINE2+9:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//? 
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
		
		
	Q30: 
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h154;	//T
		LCD_LINE2+4:	LUT_DATA	<=	9'h172;	//r
		LCD_LINE2+5:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+6:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE2+7:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+8:	LUT_DATA	<=	9'h174;	//t
		LCD_LINE2+9:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//Space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	
	Q40:
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space 
		LCD_LINE2+4:	LUT_DATA	<=	9'h143;	//C
		LCD_LINE2+5:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE2+6:	LUT_DATA	<=	9'h175;	//u 
		LCD_LINE2+7:	LUT_DATA	<=	9'h172;	//r
		LCD_LINE2+8:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+10:	LUT_DATA	<=	9'h174;	//t 
		LCD_LINE2+11:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE2+12:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
		
	Q50:
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h143;	//C 
		LCD_LINE2+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE2+5:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+6:	LUT_DATA	<=	9'h163;	//c 
		LCD_LINE2+7:	LUT_DATA	<=	9'h175;	//u
		LCD_LINE2+8:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+10:	LUT_DATA	<=	9'h174;	//t 
		LCD_LINE2+11:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE2+12:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase	
		
	Q60: 
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h153;	//S
		LCD_LINE2+4:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE2+6:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+7:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+8:	LUT_DATA	<=	9'h174;	//t
		LCD_LINE2+9:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//Space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	
	Q70:
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h153;	//S
		LCD_LINE2+4:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+5:	LUT_DATA	<=	9'h174;	//t
		LCD_LINE2+6:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+7:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+8:	LUT_DATA	<=	9'h174;	//t
		LCD_LINE2+9:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE2+10:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//Space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
		
		
	Q80: 
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//Spcae
		LCD_LINE2+5:	LUT_DATA	<=	9'h14F;	//O
		LCD_LINE2+6:	LUT_DATA	<=	9'h163;	//c
		LCD_LINE2+7:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE2+8:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+10:	LUT_DATA	<=	9'h174;	//t
		LCD_LINE2+11:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE2+12:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	
	Q90:
		case(LUT_INDEX)
		//	Initial
		LCD_INTIAL+0:	LUT_DATA	<=	9'h038;
		LCD_INTIAL+1:	LUT_DATA	<=	9'h00C;
		LCD_INTIAL+2:	LUT_DATA	<=	9'h001;
		LCD_INTIAL+3:	LUT_DATA	<=	9'h006;
		LCD_INTIAL+4:	LUT_DATA	<=	9'h080;
		//	Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
		//	Change Line
		LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space 
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h14E;	//N
		LCD_LINE2+6:	LUT_DATA	<=	9'h16F;	//o 
		LCD_LINE2+7:	LUT_DATA	<=	9'h176;	//v
		LCD_LINE2+8:	LUT_DATA	<=	9'h165;	//e
		LCD_LINE2+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE2+10:	LUT_DATA	<=	9'h174;	//t 
		LCD_LINE2+11:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE2+12:	LUT_DATA	<=	9'h13F;	//?
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
		
	default:
	case(LUT_INDEX)
    //    Initial
    LCD_INTIAL+0:    LUT_DATA    <=    9'h038;
    LCD_INTIAL+1:    LUT_DATA    <=    9'h00C;
    LCD_INTIAL+2:    LUT_DATA    <=    9'h001;
    LCD_INTIAL+3:    LUT_DATA    <=    9'h006;
    LCD_INTIAL+4:    LUT_DATA    <=    9'h080;
    //    Line 1
		LCD_LINE1+0:	LUT_DATA	<=	9'h153;	//	<S>
		LCD_LINE1+1:	LUT_DATA	<=	9'h170;	//p
		LCD_LINE1+2:	LUT_DATA	<=	9'h161;	//a
		LCD_LINE1+3:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+4:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+5:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+6:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+7:	LUT_DATA	<=	9'h13E;	//>
		LCD_LINE1+8:	LUT_DATA	<=	9'h145;	//E
		LCD_LINE1+9:	LUT_DATA	<=	9'h16E;	//n
		LCD_LINE1+10:	LUT_DATA	<=	9'h167;	//g
		LCD_LINE1+11:	LUT_DATA	<=	9'h16C;	//l
		LCD_LINE1+12:	LUT_DATA	<=	9'h169;	//i
		LCD_LINE1+13:	LUT_DATA	<=	9'h173;	//s
		LCD_LINE1+14:	LUT_DATA	<=	9'h168;	//h
		LCD_LINE1+15:	LUT_DATA	<=	9'h120;	//space
    //    Change Line
		LCD_CH_LINE:    LUT_DATA    <=    9'h0C0;
    //    Line 2
		LCD_LINE2+0:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+1:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+2:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+3:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+4:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+5:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+6:	LUT_DATA	<=	9'h120;	//space 
		LCD_LINE2+7:	LUT_DATA	<=	9'h120;	//spce
		LCD_LINE2+8:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+9:	LUT_DATA	<=	9'h120;	//space 
		LCD_LINE2+10:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+11:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+12:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+13:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+14:	LUT_DATA	<=	9'h120;	//space
		LCD_LINE2+15:	LUT_DATA	<=	9'h120;	//space
		default:		LUT_DATA	<=	9'dx ;
		endcase
	endcase
end

LCD_Controller u0(
.rst(rst),
//    Host Side
.iDATA(mLCD_DATA),
.iRS(mLCD_RS),
.iStart(mLCD_Start),
.oDone(mLCD_Done),
.iCLK(iCLK),
.iRST_N(iRST_N),
//    LCD Interface
.LCD_DATA(LCD_DATA),
.LCD_RW(LCD_RW),
.LCD_EN(LCD_EN),
.LCD_RS(LCD_RS)    );

endmodule