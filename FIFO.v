module FIFO(clk,rst, buf_in, buf_out, wr_en, rd_en, buf_empty, buf_full, fifo_counter);

input rst, clk, wr_en, rd_en;
input [7:0] buf_in; // data that will be written in the buffer
output [7:0]buf_out; // data that will be read out from FIFO
output buf_empty, buf_full; // Flag to indicate if the FIFO is empty or full
output [7:0] fifo_counter; // counting the location in buffer

reg[7:0] buf_out;
reg buf_empty, buf_full;
reg[6:0] fifo_counter;
reg[3:0] rd_ptr, wr_ptr; // pointer that will move back and forth within the FIFO
reg[7:0] buf_mem[63:0]; // total memory location

always@(fifo_counter) 
begin
  buf_empty=(fifo_counter==0); //when fifo_counter is 0 flag goes up
  buf_full = (fifo_counter == 64); //when fifo_counter is 64 flag goes up
end

always@(posedge clk or posedge rst) 
begin
    if(rst)
        fifo_counter <= 0;
    else if((!buf_full && wr_en) && (!buf_empty && rd_en)) 
        fifo_counter <= fifo_counter;
    else if(!buf_full && wr_en) // when FIFO is not full and wr_en is HIGH increment the counter
        fifo_counter <= fifo_counter+1;
    else if(!buf_empty && rd_en) // when FIFO is not empty and rd_en is HIGH decrement the counter
        fifo_counter <= fifo_counter-1;
    else 
        fifo_counter <= fifo_counter;
end

always@(posedge clk or posedge rst)
begin 
    if(rst)
        buf_out <= 0;
    else 
    begin
        if(rd_en && !buf_empty)
            buf_out <= buf_mem[rd_ptr]; //reading from the FIFO
        else 
            buf_out <= buf_out;
    end
end

always@(posedge clk)
begin
      if(wr_en && !buf_full)
        buf_mem[wr_ptr] <= buf_in; // writing into the FIFO
      else 
        buf_mem[wr_ptr] <= buf_mem[wr_ptr];
end

always@(posedge clk or posedge rst) // manipulating pointers when read and write flags are up concurrently
begin
    if(rst)
    begin
        wr_ptr <= 0;
        rd_ptr <= 0;
    end
    else
    begin
        if(!buf_full && wr_en)
            wr_ptr <= wr_ptr+1;
        else 
            wr_ptr <= wr_ptr;
        if( !buf_empty && rd_en)
            rd_ptr <= rd_ptr+1;
        else 
            rd_ptr <= rd_ptr;
    end 
end
endmodule