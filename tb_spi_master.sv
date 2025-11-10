
`timescale 1ns / 1ps

module tb_spi_master ();
    //global signals
    logic       clk;
    logic       reset;
    // masterinternal signals
    logic       start;
    logic       cpol;
    logic       cpha;
    logic [7:0] tx_data;
    logic [7:0] rx_data;
    logic       tx_ready;
    logic       done;

    // SPI external ports
    logic       sclk;
    logic       mosi;
    logic       miso;
    logic       loop_wire;
    logic       cs;

    // slave internal signals
    logic [7:0] si_data;  // rx_data // slave_in_data
    logic       si_done;  // rx_done // 다 받았다.
    logic [7:0] so_data;  // tx_data
    logic       so_start;  // tx_start
    logic       so_ready;  // tx_ready


    spi_master dut_master (
        .*
        // .mosi(loop_wire),           // mosi 로 나간 것을 miso로 direct로 들어오는 loop
        // .miso(loop_wire)
    );

    spi_slave dut_slave (.*);


    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;
        #10;
        reset = 0;
    end

    task automatic spi_mode(bit pol, bit pha);
        cpol = pol;
        cpha = pha;
        @(posedge clk);
    endtask  //automatic


    task automatic spi_write(byte data);
        @(posedge clk);
        cs = 1'b0;
        wait (tx_ready);
        start   = 1;
        tx_data = data;
        @(posedge clk);
        start = 0;
        wait (done);
        @(posedge clk);
        cs = 1'b1;

    endtask  //automatic


    task automatic spi_slave_out(byte data);
        @(posedge clk);
        wait (so_ready);
        so_data  = data;
        so_start = 1;
        @(posedge clk);
        so_start = 0;
        wait (so_ready);
    endtask  //automatic

    initial begin
        repeat (5) @(posedge clk);

        spi_mode(1'b0, 1'b0);  // mode 0

        fork
            spi_write(8'hf0);
            spi_slave_out(8'haa);
        join

        // spi_write(8'hf0);  // mode 0
        // spi_slave_out(8'haa);
        // spi_write(8'h0f);  // mode 1
        // spi_write(8'haa);  // mode 2
        // spi_write(8'h55);  // mode 3

        #20;
        $finish;
    end

    // clk이 발생 안 하고 있다 = dummy data를 안 보내고 있다? 


endmodule


// master tb 레퍼런스
// `timescale 1ns / 1ps

// module tb_spi_master ();
//     //global signals
//     logic       clk;
//     logic       reset;
//     // masterinternal signals
//     logic       start;
//     logic       cpol;
//     logic       cpha;
//     logic [7:0] tx_data;
//     logic [7:0] rx_data;
//     logic       tx_ready;
//     logic       done;

//     // SPI external ports
//     logic       sclk;
//     logic       mosi;
//     logic       miso;
//     logic       loop_wire;
//     logic       cs;

//     // slave internal signals
//     logic [7:0] si_data;  // rx_data // slave_in_data
//     logic       si_done;  // rx_done // 다 받았다.
//     logic [7:0] so_data;  // tx_data
//     logic       so_start;  // tx_start
//     logic       so_ready;  // tx_ready
//     logic       so_done;


//     spi_master dut_master (
//         .*
//         // .mosi(loop_wire),           // mosi 로 나간 것을 miso로 direct로 들어오는 loop
//         // .miso(loop_wire)
//     );

//     spi_slave dut_slave (.*);


//     always #5 clk = ~clk;

//     initial begin
//         clk   = 0;
//         reset = 1;
//         #10;
//         reset = 0;
//     end

//     task automatic spi_write(bit pol, bit pha, byte data);
//         cpol = pol;
//         cpha = pha;
//         @(posedge clk);
//         wait (tx_ready);
//         start   = 1;
//         tx_data = data;
//         @(posedge clk);
//         start = 0;
//         wait (done);
//         @(posedge clk);
//     endtask  //automatic

//     initial begin
//         repeat (5) @(posedge clk);

//         spi_write(1'b0, 1'b0, 8'hf0);  // mode 0
//         spi_write(1'b0, 1'b1, 8'h0f);  // mode 1
//         spi_write(1'b1, 1'b0, 8'haa);  // mode 2
//         spi_write(1'b1, 1'b1, 8'h55);  // mode 3

//         #20;
//         $finish;
//     end



// endmodule





















// module tb_spi_master ();


//     //global singnals
//     logic       clk;
//     logic       reset;
//     // internal signal;
//     logic       start;
//     logic [7:0] tx_data;
//     logic [7:0] rx_data;
//     logic       tx_ready;
//     logic       done;
//     // external signal;
//     logic       sclk;
//     logic       mosi;
//     logic       miso;


//     spi_master dut (.*);

//     always #5 clk = ~clk;

//     initial begin
//         clk   = 0;
//         reset = 1;
//         #10;
//         reset = 0;
//     end

//     task automatic spi_write(byte data);
//         @(posedge clk);
//         wait (tx_ready);
//         start   = 1;
//         tx_data = data;
//         @(posedge clk);
//         start = 0;
//         wait (done);
//         @(posedge clk);
//     endtask  //


//     initial begin
//         repeat (5) @(posedge clk);
//         spi_write(8'hf0);
//         spi_write(8'h0f);
//         spi_write(8'haa);
//         spi_write(8'h55);
//         #20 $finish;
//     end

// endmodule





















// module tb_spi_master ();


//     //global singnals
//     logic       clk;
//     logic       reset;
//     // internal signal;
//     logic       start;
//     logic [7:0] tx_data;
//     logic [7:0] rx_data;
//     logic       tx_ready;
//     logic       done;
//     // external signal;
//     logic       sclk;
//     logic       mosi;
//     logic       miso;


//     spi_master dut (.*);

//     always #5 clk = ~clk;

//     initial begin
//         clk   = 0;
//         reset = 1;
//         #10;
//         reset = 0;
//     end

//     task automatic spi_write(byte data);
//         @(posedge clk);
//         wait (tx_ready);
//         start   = 1;
//         tx_data = data;
//         @(posedge clk);
//         start = 0;
//         wait (done);
//         @(posedge clk);
//     endtask  //


//     initial begin
//         repeat (5) @(posedge clk);
//         spi_write(8'hf0);
//         spi_write(8'h0f);
//         spi_write(8'haa);
//         spi_write(8'h55);
//         #20 $finish;
//     end

// endmodule
