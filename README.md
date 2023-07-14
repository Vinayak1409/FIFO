A Single clock FIFO is being designed using Verilog and simulated on the AMD Vivado tool.
# FIFO
A FIFO is commonly known as a buffer and gets its name from the scheme of First In, First Out, which typically means that as the data is written serially into the buffer, the data written first will be read out from the buffer first.

1. `rd_en` is read enable signal, which enables the buffer to read the stored data.
2. `wr_en` is the write enable signal, which enables the buffer to get some data written in it.
3. `buf_in` is the data that will be written into the buffer.
4. `buf_out` is the data that is stored in the buffer and will be read out from it.
5. `buf_full` is a flag that indicates when the buffer gets full, and no more data can be written.
6. `buf_empty` is a flag that indicates when the buffer is empty and there is no more data to read.
7. `fifo_counter` counts the number of data in the buffer. It increments as something is written and decrements when something is read.
8. `rd_ptr` is the read pointer, which increments as something is read from the buffer.
9. `wr_ptr` is the write pointer, which increments as some data is written into the buffer.


The final waveform obtained is:
![Waveform](image.png)
