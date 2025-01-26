module ps2(input clk,
           input rst_n,
           input clk_key,
           input data_key,
           output [10:0] data0,
           output [10:0] data1);
    
    reg [10:0] data_tek,data_next,data0_tek,data0_next,data1_tek,data1_next;
    integer index_tek,index_next;
    assign data0 = data0_tek;
    assign data1 = data1_tek;
    
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            index_tek <= 0;
            data_tek  <= 0;
            data0_tek <= 0;
            data1_tek <= 0;
        end
        else begin
            index_tek <= index_next;
            data_tek  <= data_next;
            data0_tek <= data0_next;
            data1_tek <= data1_next;
        end
    end
    
    always @(negedge clk_key) begin
        index_next = index_tek;
        data0_next = data0_tek;
        data1_next = data1_tek;
        data_next  = data_tek;
        
        if (index_next == 0) begin
            if (data_key == 0) begin
                data_next[index_next] = data_key;
                index_next            = index_tek+1;
            end
        end
        else begin
            data_next[index_next] = data_key;
            index_next            = index_tek+1;
            if (index_next == 11) begin
                index_next = 0;
                if (data_next[10] == 1'b1 && ^data_next[9:1]) begin
                    data1_next = data0_next;
                    data0_next = data_next;
                end
            end
        end
    end
    
    
endmodule
