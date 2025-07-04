module clock(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss); 
    
    always @ (posedge clk)
        begin
            if(reset)
                begin
                    hh <= 8'h12;
                    mm <= 8'h00;
                    ss <= 8'h00;
                end
            else 
                begin 
                if (ena)
                    begin
                        if(ss < 8'h59) 
                            begin
                                if (ss[3:0]<4'h9)
                                    begin
                                        ss[3:0]<=ss[3:0]+4'h1;
                                    end
                                else
                                    begin
                                        ss[3:0]<=4'h0;
                                        ss[7:4]<=ss[7:4]+4'h1;
                                    end
                            end
                        else
                            begin
                                ss<=8'h0;
                                if (mm<8'h59)
                                    begin
                                        if(mm[3:0]<4'h9)
                                            begin
                                                mm[3:0]<=mm[3:0]+4'h1;
                                            end
                                        else
                                            begin
                                                mm[3:0]<=0;
                                                mm[7:4]<=mm[7:4]+4'h1;
                                            end
                                    end
                                else
                                    begin
                                        mm<=8'h0;
                                        if(hh==8'h11)
                                            pm=~pm;
                                        if(hh<8'h12)
                                            begin                    
                                                if(hh[3:0]<8'h9)
                                                    begin
                                                        hh[3:0]<=hh[3:0]+4'h1;
                                                    end
                                                else
                                                    begin
                                                        hh[3:0]<=0;
                                                        hh[7:4]<=hh[7:4]+4'h1;
                                                    end
                                            end
                                        else
                                            begin
                                                hh<=8'h1;
                                            end
                                    end
                            end
                    end
                    end
        end
    
    

endmodule
