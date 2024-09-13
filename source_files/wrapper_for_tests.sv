/*###########################################################*/
/*                 Clock and reset assign                    */
/*                                                           */
/*###########################################################*/

//Clocks

 wire clk_axi_fabric;
 wire clk_rv_core;  
 
 wire lsu_bus_clk_en_rv_core;  //wrong   -> don't support rv with the script
 wire ifu_bus_clk_en_rv_core;  //wrong
 wire dbg_bus_clk_en_rv_core;  //wrong
 wire dma_bus_clk_en_rv_core;  //wrong
 
 wire clk_axi2apb_0;
 wire PCLK_axi2apb_0;
 wire clk_axi2apb_1;
 wire PCLK_axi2apb_1;
 wire clk_i_gpio;
 wire clk_timer;
 
 wire clk_i2c;     //They are connected to pclk_timer_vt (it is also assign to clk in the current soc_wrapper though)  ???
 wire pclk_i2c;    //
 
 wire pclk_i_spi;
 wire eclk_i_spi;
 
 wire sclk_o_spi;   //wrong
 wire sclk_i_spi;   //wrong
 
 wire pclk_i_vt_uart;
 wire sclk_i_vt_uart;
 wire clk_blink;
 
 
 //Resets
 
 wire rst_n_axi_fabric;
 wire dmi_hard_reset_rv_core;
 wire mpc_reset_run_req_rv_core;
 wire rst_n_axi2apb_0;
 wire PRESETn_axi2apb_0;
 wire rst_n_axi2apb_1;
 wire PRESETn_axi2apb_1;
 wire rst_n_i_gpio;
 wire rst_n_timer;
 wire preset_n_i_spi;
 wire rst_n_i_spi;
 wire presetn_i_vt_uart;
 wire rst_n_i_vt_uart;

 assign axi_fabric_clk = clk;
 assign rv_core_clk = clk;
 assign axi2apb_0_clk = clk;
 assign axi2apb_1_clk = clk;
 assign gpio_clk = clk;
 assign timer_clk = clk;
 assign i2c_clk = clk;
 assign spi_clk = clk;
 assign vt_uart_clk = clk;
 assign blink_clk = clk;

//###########################################################################################


