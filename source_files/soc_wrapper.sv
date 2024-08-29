module soc_wrapper
(
    input   wire        clk,
    input   wire        rstn,
    input   wire        dmi_reg_en,
    input   wire [6:0]  dmi_reg_addr,
    input   wire        dmi_reg_wr_en,
    input   wire [31:0] dmi_reg_wdata,
    output  wire [31:0] dmi_reg_rdata,
    input   wire        dmi_hard_reset,
    input   wire [31:0] vt_button_sw,
    output  wire [31:0] vt_led,
    input   wire [31:0] vt_gpio_output_aux_in,
    output  wire [31:0] vt_gpio_output_aux_out,
    output  wire [2:0]  rgb,
    input   wire        vt_timer_ch0_i,
    output  wire        vt_timer_ch0_o,
    input   wire [7:0]  vt_spi_spi_i,      // SPI input pin (spi_i[0] acts like MISO for single SPI configuration)
    output  wire [7:0]  vt_spi_spi_o,      // SPI output pin (spi_o[0] acts like MOSI for single SPI configuration)
    output  wire        vt_spi_scs_o,      // SPI chip select signal when SPI is configured as master
    input   wire        vt_spi_scs_i,      // SPI chip select signal when SPI is configured as slave
    output  wire        vt_spi_sclk_o,     // SPI clock generated when SPI is configured as master
    input   wire        vt_spi_sclk_i,     // SPI clock when SPI is configured as slave
    input   wire        vt_spi_xip_en_i,   // eXecute In Place enable signal
    input   wire        vt_spi_chip_sel_i, // Chip select signal when XIP is enabled
    output  wire        tri_state_en_o,    // spi_i, spi_o - tri state select
	input   wire        vt_uart_0_cts_n_i,
	input   wire        vt_uart_0_dsr_n_i,
	input   wire        vt_uart_0_dcd_n_i,
	input   wire        vt_uart_0_ri_n_i,
	output  wire        vt_uart_0_dtr_n_o,
	output  wire        vt_uart_0_rts_n_o,
	output  wire        vt_uart_0_tx_o,
	input   wire        vt_uart_0_rx_i,
	input   wire        vt_uart_1_cts_n_i,
	input   wire        vt_uart_1_dsr_n_i,
	input   wire        vt_uart_1_dcd_n_i,
	input   wire        vt_uart_1_ri_n_i,
	output  wire        vt_uart_1_dtr_n_o,
	output  wire        vt_uart_1_rts_n_o,
	output  wire        vt_uart_1_tx_o,
	input   wire        vt_uart_1_rx_i,
	input   wire        vt_uart_2_cts_n_i,
	input   wire        vt_uart_2_dsr_n_i,
	input   wire        vt_uart_2_dcd_n_i,
	input   wire        vt_uart_2_ri_n_i,
	output  wire        vt_uart_2_dtr_n_o,
	output  wire        vt_uart_2_rts_n_o,
	output  wire        vt_uart_2_tx_o,
	input   wire        vt_uart_2_rx_i,
    input   wire        vt_i2c_scl_i,
    output  wire        vt_i2c_scl_o,
    output  wire        vt_i2c_scl_oe,
    input   wire        vt_i2c_sda_i,
    output  wire        vt_i2c_sda_o,
    output  wire        vt_i2c_sda_oe
);

/*###########################################################*/
/*                   AXI Fabric interface                    */
/*                         (Vtool)                           */
/*###########################################################*/
    wire [ 2 : 0] ifu_awid, ifu_bid,  ifu_arid;
    wire [ 3 : 0] lsu_awid, lsu_bid,  lsu_arid, lsu_rid, ifu_rid, sb_bid, sb_rid;
    wire [ 0 : 0] sb_awid,  sb_arid;
    wire [ 7 : 0] axi2apb_0_awid    , axi2apb_1_awid    , bram_ctrl_0_awid  , bram_ctrl_1_awid;
    wire [31 : 0] ifu_awaddr  , lsu_awaddr      , sb_awaddr         , axi2apb_0_awaddr  , axi2apb_1_awaddr  , bram_ctrl_0_awaddr  , bram_ctrl_1_awaddr  ;
    wire [ 7 : 0] ifu_awlen   , lsu_awlen       , sb_awlen          , axi2apb_0_awlen   , axi2apb_1_awlen   , bram_ctrl_0_awlen   , bram_ctrl_1_awlen   ;
    wire [ 2 : 0] ifu_awsize  , lsu_awsize      , sb_awsize         , axi2apb_0_awsize  , axi2apb_1_awsize  , bram_ctrl_0_awsize  , bram_ctrl_1_awsize  ;
    wire [ 1 : 0] ifu_awburst , lsu_awburst     , sb_awburst        , axi2apb_0_awburst , axi2apb_1_awburst , bram_ctrl_0_awburst , bram_ctrl_1_awburst ;
    wire          ifu_awlock  , lsu_awlock      , sb_awlock         , axi2apb_0_awlock  , axi2apb_1_awlock  , bram_ctrl_0_awlock  , bram_ctrl_1_awlock  ;
    wire [ 3 : 0] ifu_awcache , lsu_awcache     , sb_awcache        , axi2apb_0_awcache , axi2apb_1_awcache , bram_ctrl_0_awcache , bram_ctrl_1_awcache ;
    wire [ 2 : 0] ifu_awprot  , lsu_awprot      , sb_awprot         , axi2apb_0_awprot  , axi2apb_1_awprot  , bram_ctrl_0_awprot  , bram_ctrl_1_awprot  ;
    wire [ 3 : 0] ifu_awregion, lsu_awregion    , sb_awregion       , axi2apb_0_awregion, axi2apb_1_awregion, bram_ctrl_0_awregion, bram_ctrl_1_awregion;
    wire [ 3 : 0] ifu_awqos   , lsu_awqos       , sb_awqos          , axi2apb_0_awqos   , axi2apb_1_awqos   , bram_ctrl_0_awqos   , bram_ctrl_1_awqos   ;
    wire [ 3 : 0] ifu_awuser  , lsu_awuser      , sb_awuser         , axi2apb_0_awuser  , axi2apb_1_awuser  , bram_ctrl_0_awuser  , bram_ctrl_1_awuser  ;
    wire          ifu_awvalid , lsu_awvalid     , sb_awvalid        , axi2apb_0_awvalid , axi2apb_1_awvalid , bram_ctrl_0_awvalid , bram_ctrl_1_awvalid ;
    wire          ifu_awready , lsu_awready     , sb_awready        , axi2apb_0_awready , axi2apb_1_awready , bram_ctrl_0_awready , bram_ctrl_1_awready ;
    wire [63 : 0] ifu_wdata   , lsu_wdata       , sb_wdata          , axi2apb_0_wdata   , axi2apb_1_wdata   , bram_ctrl_0_wdata   , bram_ctrl_1_wdata   ;
    wire [ 7 : 0] ifu_wstrb   , lsu_wstrb       , sb_wstrb          , axi2apb_0_wstrb   , axi2apb_1_wstrb   , bram_ctrl_0_wstrb   , bram_ctrl_1_wstrb   ;
    wire [ 3 : 0] ifu_wuser   , lsu_wuser       , sb_wuser          , axi2apb_0_wuser   , axi2apb_1_wuser   , bram_ctrl_0_wuser   , bram_ctrl_1_wuser   ;
    wire          ifu_wvalid  , lsu_wvalid      , sb_wvalid         , axi2apb_0_wvalid  , axi2apb_1_wvalid  , bram_ctrl_0_wvalid  , bram_ctrl_1_wvalid  ;
    wire          ifu_wready  , lsu_wready      , sb_wready         , axi2apb_0_wready  , axi2apb_1_wready  , bram_ctrl_0_wready  , bram_ctrl_1_wready  ;
    wire          ifu_wlast   , lsu_wlast       , sb_wlast          , axi2apb_0_wlast   , axi2apb_1_wlast   , bram_ctrl_0_wlast   , bram_ctrl_1_wlast   ;
    wire [ 7 : 0] axi2apb_0_bid , axi2apb_1_bid , bram_ctrl_0_bid , bram_ctrl_1_bid;
    wire [ 3 : 0] ifu_buser   , lsu_buser       , sb_buser          , axi2apb_0_buser   , axi2apb_1_buser   , bram_ctrl_0_buser   , bram_ctrl_1_buser   ;
    wire [ 1 : 0] ifu_bresp   , lsu_bresp       , sb_bresp          , axi2apb_0_bresp   , axi2apb_1_bresp   , bram_ctrl_0_bresp   , bram_ctrl_1_bresp   ;
    wire          ifu_bvalid  , lsu_bvalid      , sb_bvalid         , axi2apb_0_bvalid  , axi2apb_1_bvalid  , bram_ctrl_0_bvalid  , bram_ctrl_1_bvalid  ;
    wire          ifu_bready  , lsu_bready      , sb_bready         , axi2apb_0_bready  , axi2apb_1_bready  , bram_ctrl_0_bready  , bram_ctrl_1_bready  ;
    wire [31 : 0] ifu_araddr  , lsu_araddr      , sb_araddr         , axi2apb_0_araddr  , axi2apb_1_araddr  , bram_ctrl_0_araddr  , bram_ctrl_1_araddr  ;
    wire [ 5 : 0] axi2apb_0_arid, axi2apb_1_arid, bram_ctrl_0_arid, bram_ctrl_1_arid;
    wire [ 7 : 0] ifu_arlen   , lsu_arlen       , sb_arlen          , axi2apb_0_arlen   , axi2apb_1_arlen   , bram_ctrl_0_arlen   , bram_ctrl_1_arlen   ;
    wire [ 2 : 0] ifu_arsize  , lsu_arsize      , sb_arsize         , axi2apb_0_arsize  , axi2apb_1_arsize  , bram_ctrl_0_arsize  , bram_ctrl_1_arsize  ;
    wire [ 1 : 0] ifu_arburst , lsu_arburst     , sb_arburst        , axi2apb_0_arburst , axi2apb_1_arburst , bram_ctrl_0_arburst , bram_ctrl_1_arburst ;
    wire          ifu_arlock  , lsu_arlock      , sb_arlock         , axi2apb_0_arlock  , axi2apb_1_arlock  , bram_ctrl_0_arlock  , bram_ctrl_1_arlock  ;
    wire [ 3 : 0] ifu_arcache , lsu_arcache     , sb_arcache        , axi2apb_0_arcache , axi2apb_1_arcache , bram_ctrl_0_arcache , bram_ctrl_1_arcache ;
    wire [ 2 : 0] ifu_arprot  , lsu_arprot      , sb_arprot         , axi2apb_0_arprot  , axi2apb_1_arprot  , bram_ctrl_0_arprot  , bram_ctrl_1_arprot  ;
    wire [ 3 : 0] ifu_arregion, lsu_arregion    , sb_arregion       , axi2apb_0_arregion, axi2apb_1_arregion, bram_ctrl_0_arregion, bram_ctrl_1_arregion;
    wire [ 3 : 0] ifu_arqos   , lsu_arqos       , sb_arqos          , axi2apb_0_arqos   , axi2apb_1_arqos   , bram_ctrl_0_arqos   , bram_ctrl_1_arqos   ;
    wire [ 3 : 0] ifu_aruser  , lsu_aruser      , sb_aruser         , axi2apb_0_aruser  , axi2apb_1_aruser  , bram_ctrl_0_aruser  , bram_ctrl_1_aruser  ;
    wire          ifu_arvalid , lsu_arvalid     , sb_arvalid        , axi2apb_0_arvalid , axi2apb_1_arvalid , bram_ctrl_0_arvalid , bram_ctrl_1_arvalid ;
    wire          ifu_arready , lsu_arready     , sb_arready        , axi2apb_0_arready , axi2apb_1_arready , bram_ctrl_0_arready , bram_ctrl_1_arready ;
    wire [63 : 0] ifu_rdata   , lsu_rdata       , sb_rdata          , axi2apb_0_rdata   , axi2apb_1_rdata   , bram_ctrl_0_rdata   , bram_ctrl_1_rdata   ;
    wire [ 5 : 0] axi2apb_0_rid , axi2apb_1_rid , bram_ctrl_0_rid , bram_ctrl_1_rid;
    wire [ 1 : 0] ifu_rresp   , lsu_rresp       , sb_rresp          , axi2apb_0_rresp   , axi2apb_1_rresp   , bram_ctrl_0_rresp   , bram_ctrl_1_rresp   ;
    wire          ifu_rlast   , lsu_rlast       , sb_rlast          , axi2apb_0_rlast   , axi2apb_1_rlast   , bram_ctrl_0_rlast   , bram_ctrl_1_rlast   ;
    wire          ifu_rvalid  , lsu_rvalid      , sb_rvalid         , axi2apb_0_rvalid  , axi2apb_1_rvalid  , bram_ctrl_0_rvalid  , bram_ctrl_1_rvalid  ;
    wire [ 3 : 0] ifu_ruser   , lsu_ruser       , sb_ruser          , axi2apb_0_ruser   , axi2apb_1_ruser   , bram_ctrl_0_ruser   , bram_ctrl_1_ruser   ;
    wire          ifu_rready  , lsu_rready      , sb_rready         , axi2apb_0_rready  , axi2apb_1_rready  , bram_ctrl_0_rready  , bram_ctrl_1_rready  ;


/*###########################################################*/
/*                     AXI to APB interface                  */
/*                          (Vtool)                          */
/*###########################################################*/
    wire [31 : 0] vt_uart_0_paddr;
    wire [ 2 : 0] vt_uart_0_pprot;
    wire [ 3 : 0] vt_uart_0_pstrb;
    wire          vt_uart_0_psel;
    wire          vt_uart_0_penable;
    wire [31 : 0] vt_uart_0_pwdata;
    wire          vt_uart_0_pwrite;
    wire [31 : 0] vt_uart_0_prdata;
    wire          vt_uart_0_pready;
    wire          vt_uart_0_pslverr;
    wire [31 : 0] vt_uart_1_paddr;
    wire [ 2 : 0] vt_uart_1_pprot;
    wire [ 3 : 0] vt_uart_1_pstrb;
    wire          vt_uart_1_psel;
    wire          vt_uart_1_penable;
    wire [31 : 0] vt_uart_1_pwdata;
    wire          vt_uart_1_pwrite;
    wire [31 : 0] vt_uart_1_prdata;
    wire          vt_uart_1_pready;
    wire          vt_uart_1_pslverr;
    wire [31 : 0] vt_uart_2_paddr;
    wire [ 2 : 0] vt_uart_2_pprot;
    wire [ 3 : 0] vt_uart_2_pstrb;
    wire          vt_uart_2_psel;
    wire          vt_uart_2_penable;
    wire [31 : 0] vt_uart_2_pwdata;
    wire          vt_uart_2_pwrite;
    wire [31 : 0] vt_uart_2_prdata;
    wire          vt_uart_2_pready;
    wire          vt_uart_2_pslverr;
    wire [31 : 0] vt_spi_paddr;
    wire [ 2 : 0] vt_spi_pprot;
    wire [ 3 : 0] vt_spi_pstrb;
    wire          vt_spi_psel;
    wire          vt_spi_penable;
    wire [31 : 0] vt_spi_pwdata;
    wire          vt_spi_pwrite;
    wire [31 : 0] vt_spi_prdata;
    wire          vt_spi_pready;
    wire          vt_spi_pslverr;
    wire [31 : 0] vt_timer_paddr;
    wire [ 2 : 0] vt_timer_pprot;
    wire [ 3 : 0] vt_timer_pstrb;
    wire          vt_timer_psel;
    wire          vt_timer_penable;
    wire [31 : 0] vt_timer_pwdata;
    wire          vt_timer_pwrite;
    wire [31 : 0] vt_timer_prdata;
    wire          vt_timer_pready;
    wire          vt_timer_pslverr;
    wire [31 : 0] vt_i2c_paddr;
    wire [ 2 : 0] vt_i2c_pprot;
    wire [ 3 : 0] vt_i2c_pstrb;
    wire          vt_i2c_psel;
    wire          vt_i2c_penable;
    wire [31 : 0] vt_i2c_pwdata;
    wire          vt_i2c_pwrite;
    wire [31 : 0] vt_i2c_prdata;
    wire          vt_i2c_pready;
    wire          vt_i2c_pslverr;
    wire [31 : 0] vt_gpio_output_paddr;
    wire [ 2 : 0] vt_gpio_output_pprot;
    wire [ 3 : 0] vt_gpio_output_pstrb;
    wire          vt_gpio_output_psel;
    wire          vt_gpio_output_penable;
    wire [31 : 0] vt_gpio_output_pwdata;
    wire          vt_gpio_output_pwrite;
    wire [31 : 0] vt_gpio_output_prdata;
    wire          vt_gpio_output_pready;
    wire          vt_gpio_output_pslverr;
    wire [31 : 0] vt_gpio_input_paddr;
    wire [ 2 : 0] vt_gpio_input_pprot;
    wire [ 3 : 0] vt_gpio_input_pstrb;
    wire          vt_gpio_input_psel;
    wire          vt_gpio_input_penable;
    wire [31 : 0] vt_gpio_input_pwdata;
    wire          vt_gpio_input_pwrite;
    wire [31 : 0] vt_gpio_input_prdata;
    wire          vt_gpio_input_pready;
    wire          vt_gpio_input_pslverr;

    wire vt_gpio_input_irq, vt_gpio_output_irq, vt_timer_irq, vt_spi_irq, vt_uart_0_intr, vt_uart_1_intr, vt_uart_2_intr, vt_i2c_intr;

/*###########################################################*/
/*                     BRAM CTRL interface                   */
/*                          (Xilinx)                         */
/*###########################################################*/
    wire [17:0] bram_0_addr_a  ;
    wire [17:0] bram_0_addr_b  ;
    wire        bram_0_clk_a   ;
    wire        bram_0_clk_b   ;
    wire [63:0] bram_0_wrdata_a;
    wire [63:0] bram_0_wrdata_b;
    wire [63:0] bram_0_rddata_a;
    wire [63:0] bram_0_rddata_b;
    wire        bram_0_en_a    ;
    wire        bram_0_en_b    ;
    wire        bram_0_rst_a   ;
    wire        bram_0_rst_b   ;
    wire [ 7:0] bram_0_we_a    ;
    wire [ 7:0] bram_0_we_b    ;

    wire [16:0] bram_1_addr_a;
    wire [16:0] bram_1_addr_b;
    wire        bram_1_clk_a;
    wire        bram_1_clk_b;
    wire [63:0] bram_1_wrdata_a;
    wire [63:0] bram_1_wrdata_b;
    wire [63:0] bram_1_rddata_a;
    wire [63:0] bram_1_rddata_b;
    wire        bram_1_en_a;
    wire        bram_1_en_b;
    wire        bram_1_rst_a;
    wire        bram_1_rst_b;
    wire [ 7:0] bram_1_we_a;
    wire [ 7:0] bram_1_we_b;

/*###########################################################*/
/*                 Clock and reset assign                    */
/*                                                           */
/*###########################################################*/
    wire clk_rv_core, clk_axi_fabric, axi_clk_axi2apb_0, axi_clk_axi2apb_1, pclk_axi2apb_0, pclk_axi2apb_1, axi_clk_bram_ctrl_0, axi_clk_bram_ctrl_1;
    wire pclk_gpio_input_vt, pclk_gpio_output_vt, pclk_timer_vt, clk_blink, pclk_spi_vt, clk_spi_vt, pclk_i2c_vt, pclk_uart_0_vt, sclk_uart_0_vt;
    wire pclk_uart_1_vt, sclk_uart_1_vt, pclk_uart_2_vt, sclk_uart_2_vt;
    wire rst, rst_rv_core, rstn_axi_fabric, axi_rstn_axi2apb_0, axi_rstn_axi2apb_1, prstn_axi2apb_0, prstn_axi2apb_1, axi_rstn_bram_ctrl_0, axi_rstn_bram_ctrl_1;
    wire prstn_gpio_input_vt, prstn_gpio_output_vt, prstn_timer_vt, prstn_spi_vt, rstn_spi_vt, prstn_i2c_vt, prstn_uart_0_vt, rstn_uart_0_vt, prstn_uart_1_vt, rstn_uart_1_vt;
    wire prstn_uart_2_vt, rstn_uart_2_vt, rstn_blink;

    assign clk_rv_core              = clk;
    assign clk_axi_fabric           = clk;
    assign axi_clk_axi2apb_0        = clk;
    assign axi_clk_axi2apb_1        = clk;
    assign pclk_axi2apb_0           = clk;
    assign pclk_axi2apb_1           = clk;
    assign axi_clk_bram_ctrl_0      = clk;
    assign axi_clk_bram_ctrl_1      = clk;
    assign pclk_gpio_input_vt       = clk;
    assign pclk_gpio_output_vt      = clk;
    assign pclk_timer_vt            = clk;
    assign clk_blink                = clk;
    assign pclk_spi_vt              = clk;
    assign clk_spi_vt               = clk;
    assign pclk_i2c_vt              = clk;
    assign pclk_uart_0_vt           = clk;
    assign sclk_uart_0_vt           = clk;
    assign pclk_uart_1_vt           = clk;
    assign sclk_uart_1_vt           = clk;
    assign pclk_uart_2_vt           = clk;
    assign sclk_uart_2_vt           = clk;

    assign rst                      = ~rstn;
    assign rst_rv_core              = rstn; // RV Core          (OpenCore)
    assign rstn_axi_fabric          = rstn; // AXI fabric       (Vtool)
    assign axi_rstn_axi2apb_0       = rstn; // AXI2APB AXI side (Vtool)
    assign axi_rstn_axi2apb_1       = rstn; // AXI2APB AXI side (Vtool)
    assign prstn_axi2apb_0          = rstn; // AXI2APB APB side (Vtool)
    assign prstn_axi2apb_1          = rstn; // AXI2APB APB side (Vtool)
    assign axi_rstn_bram_ctrl_0     = rstn; // BRAM CTRL 0      (Xilinx)
    assign axi_rstn_bram_ctrl_1     = rstn; // BRAM CTRL 1      (Xilinx)
    assign prstn_gpio_input_vt      = rstn; // GPIO             (Vtool)
    assign prstn_gpio_output_vt     = rstn; // GPIO             (Vtool)
    assign prstn_timer_vt           = rstn; // TIMER            (Vtool)
    assign prstn_spi_vt             = rstn; // SPI              (Vtool)
    assign rstn_spi_vt              = rstn; // SPI              (Vtool)
    assign prstn_i2c_vt             = rstn; // I2C              (Vtool)
    assign prstn_uart_0_vt          = rstn; // UART             (Vtool)
    assign rstn_uart_0_vt           = rstn; // UART             (Vtool)
    assign prstn_uart_1_vt          = rstn; // UART             (Vtool)
    assign rstn_uart_1_vt           = rstn; // UART             (Vtool)
    assign prstn_uart_2_vt          = rstn; // UART             (Vtool)
    assign rstn_uart_2_vt           = rstn; // UART             (Vtool)
    assign rstn_blink               = rstn; // Test led         (Vtool)



/*###########################################################*/
/*                        RISC-V Core                        */
/*                  // TODO verzija, lokacija....            */
/*###########################################################*/
    rv_core rv_core_inst
    (
        .clk                     (clk_rv_core),
        .rst_l                   (rst_rv_core),
        .dbg_rst_l               (rst_rv_core),
        .rst_vec                 (31'h00000000),
        .nmi_int                 (1'b0),
        .nmi_vec                 (32'h00000000),
        .trace_rv_i_insn_ip      (),
        .trace_rv_i_address_ip   (),
        .trace_rv_i_valid_ip     (),
        .trace_rv_i_exception_ip (),
        .trace_rv_i_ecause_ip    (),
        .trace_rv_i_interrupt_ip (),
        .trace_rv_i_tval_ip      (),
        .lsu_axi_awvalid         (lsu_awvalid ),
        .lsu_axi_awready         (lsu_awready ),
        .lsu_axi_awid            (lsu_awid    ),
        .lsu_axi_awaddr          (lsu_awaddr  ),
        .lsu_axi_awregion        (lsu_awregion),
        .lsu_axi_awlen           (lsu_awlen   ),
        .lsu_axi_awsize          (lsu_awsize  ),
        .lsu_axi_awburst         (lsu_awburst ),
        .lsu_axi_awlock          (lsu_awlock  ),
        .lsu_axi_awcache         (lsu_awcache ),
        .lsu_axi_awprot          (lsu_awprot  ),
        .lsu_axi_awqos           (lsu_awqos   ),
        .lsu_axi_wvalid          (lsu_wvalid  ),
        .lsu_axi_wready          (lsu_wready  ),
        .lsu_axi_wdata           (lsu_wdata   ),
        .lsu_axi_wstrb           (lsu_wstrb   ),
        .lsu_axi_wlast           (lsu_wlast   ),
        .lsu_axi_bvalid          (lsu_bvalid  ),
        .lsu_axi_bready          (lsu_bready  ),
        .lsu_axi_bresp           (lsu_bresp   ),
        .lsu_axi_bid             (lsu_bid     ),
        .lsu_axi_arvalid         (lsu_arvalid ),
        .lsu_axi_arready         (lsu_arready ),
        .lsu_axi_arid            (lsu_arid    ),
        .lsu_axi_araddr          (lsu_araddr  ),
        .lsu_axi_arregion        (lsu_arregion),
        .lsu_axi_arlen           (lsu_arlen   ),
        .lsu_axi_arsize          (lsu_arsize  ),
        .lsu_axi_arburst         (lsu_arburst ),
        .lsu_axi_arlock          (lsu_arlock  ),
        .lsu_axi_arcache         (lsu_arcache ),
        .lsu_axi_arprot          (lsu_arprot  ),
        .lsu_axi_arqos           (lsu_arqos   ),
        .lsu_axi_rvalid          (lsu_rvalid  ),
        .lsu_axi_rready          (lsu_rready  ),
        .lsu_axi_rid             (lsu_rid     ),
        .lsu_axi_rdata           (lsu_rdata   ),
        .lsu_axi_rresp           (lsu_rresp   ),
        .lsu_axi_rlast           (lsu_rlast   ),
        .ifu_axi_arvalid         (ifu_arvalid ),
        .ifu_axi_arready         (ifu_arready ),
        .ifu_axi_arid            (ifu_arid    ),
        .ifu_axi_araddr          (ifu_araddr  ),
        .ifu_axi_arregion        (ifu_arregion),
        .ifu_axi_arlen           (ifu_arlen   ),
        .ifu_axi_arsize          (ifu_arsize  ),
        .ifu_axi_arburst         (ifu_arburst ),
        .ifu_axi_arlock          (ifu_arlock  ),
        .ifu_axi_arcache         (ifu_arcache ),
        .ifu_axi_arprot          (ifu_arprot  ),
        .ifu_axi_arqos           (ifu_arqos   ),
        .ifu_axi_rvalid          (ifu_rvalid  ),
        .ifu_axi_rready          (ifu_rready  ),
        .ifu_axi_rid             (ifu_rid[3:0]     ),
        .ifu_axi_rdata           (ifu_rdata   ),
        .ifu_axi_rresp           (ifu_rresp   ),
        .ifu_axi_rlast           (ifu_rlast   ),
        .sb_axi_awvalid          (sb_awvalid ),
        .sb_axi_awready          (sb_awready ),
        .sb_axi_awid             (sb_awid    ),
        .sb_axi_awaddr           (sb_awaddr  ),
        .sb_axi_awregion         (sb_awregion),
        .sb_axi_awlen            (sb_awlen   ),
        .sb_axi_awsize           (sb_awsize  ),
        .sb_axi_awburst          (sb_awburst ),
        .sb_axi_awlock           (sb_awlock  ),
        .sb_axi_awcache          (sb_awcache ),
        .sb_axi_awprot           (sb_awprot  ),
        .sb_axi_awqos            (sb_awqos   ),
        .sb_axi_wvalid           (sb_wvalid  ),
        .sb_axi_wready           (sb_wready  ),
        .sb_axi_wdata            (sb_wdata   ),
        .sb_axi_wstrb            (sb_wstrb   ),
        .sb_axi_wlast            (sb_wlast   ),
        .sb_axi_bvalid           (sb_bvalid  ),
        .sb_axi_bready           (sb_bready  ),
        .sb_axi_bresp            (sb_bresp   ),
        .sb_axi_bid              (sb_bid[0]     ),
        .sb_axi_arvalid          (sb_arvalid ),
        .sb_axi_arready          (sb_arready ),
        .sb_axi_arid             (sb_arid    ),
        .sb_axi_araddr           (sb_araddr  ),
        .sb_axi_arregion         (sb_arregion),
        .sb_axi_arlen            (sb_arlen   ),
        .sb_axi_arsize           (sb_arsize  ),
        .sb_axi_arburst          (sb_arburst ),
        .sb_axi_arlock           (sb_arlock  ),
        .sb_axi_arcache          (sb_arcache ),
        .sb_axi_arprot           (sb_arprot  ),
        .sb_axi_arqos            (sb_arqos   ),
        .sb_axi_rvalid           (sb_rvalid  ),
        .sb_axi_rready           (sb_rready  ),
        .sb_axi_rid              (sb_rid[0]     ),
        .sb_axi_rdata            (sb_rdata   ),
        .sb_axi_rresp            (sb_rresp   ),
        .sb_axi_rlast            (sb_rlast   ),
        .dma_axi_awvalid         (1'b0),
        .dma_axi_awready         (),
        .dma_axi_awid            (`RV_DMA_BUS_TAG'd0),
        .dma_axi_awaddr          (32'b0),
        .dma_axi_awsize          (3'b0),
        .dma_axi_awprot          (3'b0),
        .dma_axi_awlen           (8'b0),
        .dma_axi_awburst         (2'b0),
        .dma_axi_wvalid          (1'b0),
        .dma_axi_wready          (),
        .dma_axi_wdata           (64'b0),
        .dma_axi_wstrb           (8'b0),
        .dma_axi_wlast           (1'b0),
        .dma_axi_bvalid          (),
        .dma_axi_bready          (1'b0),
        .dma_axi_bresp           (),
        .dma_axi_bid             (),
        .dma_axi_arvalid         (1'b0),
        .dma_axi_arready         (),
        .dma_axi_arid            (`RV_DMA_BUS_TAG'd0),
        .dma_axi_araddr          (32'd0),
        .dma_axi_arsize          (3'b0),
        .dma_axi_arprot          (3'b0),
        .dma_axi_arlen           (8'b0),
        .dma_axi_arburst         (2'd0),
        .dma_axi_rvalid          (),
        .dma_axi_rready          (),
        .dma_axi_rid             (),
        .dma_axi_rdata           (),
        .dma_axi_rresp           (),
        .dma_axi_rlast           (),
        .lsu_bus_clk_en          (1'b1),
        .ifu_bus_clk_en          (1'b1),
        .dbg_bus_clk_en          (1'b1),
        .dma_bus_clk_en          (1'b1),
        .timer_int               (1'b1),
        .extintsrc_req           ({vt_gpio_input_irq, vt_gpio_output_irq, vt_timer_irq, vt_spi_irq, vt_i2c_intr, vt_uart_2_intr, vt_uart_1_intr, vt_uart_0_intr}),
        .dec_tlu_perfcnt0        (),
        .dec_tlu_perfcnt1        (),
        .dec_tlu_perfcnt2        (),
        .dec_tlu_perfcnt3        (),
        .dmi_reg_en              (dmi_reg_en),
        .dmi_reg_addr            (dmi_reg_addr),
        .dmi_reg_wr_en           (dmi_reg_wr_en),
        .dmi_reg_wdata           (dmi_reg_wdata),
        .dmi_reg_rdata           (dmi_reg_rdata),
        .dmi_hard_reset          (dmi_hard_reset),
        .mpc_debug_halt_req      (1'b0),
        .mpc_debug_run_req       (1'b0),
        .mpc_reset_run_req       (1'b1),
        .mpc_debug_halt_ack      (),
        .mpc_debug_run_ack       (),
        .debug_brkpt_status      (),
        .i_cpu_halt_req          (1'b0),
        .o_cpu_halt_ack          (),
        .o_cpu_halt_status       (),
        .o_debug_mode_status     (),
        .i_cpu_run_req           (1'b0),
        .o_cpu_run_ack           (),
        .scan_mode               (1'b0),
        .mbist_mode              (1'b0)
    );

/*###########################################################*/
/*           AXI FABRIC (AXI interconnect)                   */
/*                  3 input, 4 output                        */
/*###########################################################*/
    axi_fabric_top_wrapper
    #(
    .SLAVE_N                (3),
    .MASTER_N               (4),
    .ADDR_WIDTH             (32),
    .DATA_WIDTH             (64),
    .S_ID_WIDTH             (4),
    .M_ID_WIDTH             (6),
    .STRB_WIDTH             (8),
    .AW_USER_WIDTH          (4),
    .W_USER_WIDTH           (4),
    .B_USER_WIDTH           (4),
    .AR_USER_WIDTH          (4),
    .R_USER_WIDTH           (4),
    .ARBITER_TYPE           (0),
    .MAX_TRANS              (16),
    .S_AR_CHANNEL_REG       (0),
    .M_AR_CHANNEL_REG       (0),
    .S_R_CHANNEL_REG        (0),
    .M_R_CHANNEL_REG        (0),
    .S_AW_CHANNEL_REG       (0),
    .M_AW_CHANNEL_REG       (0),
    .S_W_CHANNEL_REG        (0),
    .M_W_CHANNEL_REG        (0),
    .S_WR_CHANNEL_REG       (0),
    .M_WR_CHANNEL_REG       (0)
    )
    axi_fabric_top_wrapper_inst
    (
        .clk                (clk_axi_fabric),
        .rst_n              (rstn_axi_fabric),
        .s00_axi_awid       ('0),
        .s00_axi_awaddr     ('0),
        .s00_axi_awlen      ('0),
        .s00_axi_awsize     ('0),
        .s00_axi_awburst    ('0),
        .s00_axi_awlock     ('0),
        .s00_axi_awcache    ('0),
        .s00_axi_awprot     ('0),
        .s00_axi_awqos      ('0),
        .s00_axi_awuser     ('0),
        .s00_axi_awvalid    ('0),
        .s00_axi_awready    (),
        .s00_axi_wdata      ('0),
        .s00_axi_wstrb      ('0),
        .s00_axi_wuser      ('0),
        .s00_axi_wvalid     ('0),
        .s00_axi_wready     (),
        .s00_axi_wlast      ('0),
        .s00_axi_bid        (),
        .s00_axi_buser      (),
        .s00_axi_bresp      (),
        .s00_axi_bvalid     (),
        .s00_axi_bready     ('0),
        .s00_axi_arid       ({1'b0, ifu_arid}),
        .s00_axi_araddr     (ifu_araddr),
        .s00_axi_aruser     (ifu_aruser),
        .s00_axi_arlen      (ifu_arlen),
        .s00_axi_arsize     (ifu_arsize),
        .s00_axi_arburst    (ifu_arburst),
        .s00_axi_arlock     (ifu_arlock),
        .s00_axi_arcache    (ifu_arcache),
        .s00_axi_arprot     (ifu_arprot),
        .s00_axi_arqos      (ifu_arqos),
        .s00_axi_arvalid    (ifu_arvalid),
        .s00_axi_arready    (ifu_arready),
        .s00_axi_rdata      (ifu_rdata),
        .s00_axi_rid        (ifu_rid),
        .s00_axi_rresp      (ifu_rresp),
        .s00_axi_rlast      (ifu_rlast),
        .s00_axi_rvalid     (ifu_rvalid),
        .s00_axi_ruser      (ifu_ruser),
        .s00_axi_rready     (ifu_rready),
        .s01_axi_awid       (lsu_awid),
        .s01_axi_awaddr     (lsu_awaddr),
        .s01_axi_awuser     (lsu_awuser),
        .s01_axi_awlen      (lsu_awlen),
        .s01_axi_awsize     (lsu_awsize),
        .s01_axi_awburst    (lsu_awburst),
        .s01_axi_awlock     (lsu_awlock),
        .s01_axi_awcache    (lsu_awcache),
        .s01_axi_awprot     (lsu_awprot),
        .s01_axi_awqos      (lsu_awqos),
        .s01_axi_awvalid    (lsu_awvalid),
        .s01_axi_awready    (lsu_awready),
        .s01_axi_wdata      (lsu_wdata),
        .s01_axi_wuser      (lsu_wuser),
        .s01_axi_wstrb      (lsu_wstrb),
        .s01_axi_wvalid     (lsu_wvalid),
        .s01_axi_wready     (lsu_wready),
        .s01_axi_wlast      (lsu_wlast),
        .s01_axi_bid        (lsu_bid),
        .s01_axi_buser      (lsu_buser),
        .s01_axi_bresp      (lsu_bresp),
        .s01_axi_bvalid     (lsu_bvalid),
        .s01_axi_bready     (lsu_bready),
        .s01_axi_arid       (lsu_arid),
        .s01_axi_araddr     (lsu_araddr),
        .s01_axi_aruser     (lsu_aruser),
        .s01_axi_arlen      (lsu_arlen),
        .s01_axi_arsize     (lsu_arsize),
        .s01_axi_arburst    (lsu_arburst),
        .s01_axi_arlock     (lsu_arlock),
        .s01_axi_arcache    (lsu_arcache),
        .s01_axi_arprot     (lsu_arprot),
        .s01_axi_arqos      (lsu_arqos),
        .s01_axi_arvalid    (lsu_arvalid),
        .s01_axi_arready    (lsu_arready),
        .s01_axi_rdata      (lsu_rdata),
        .s01_axi_rid        (lsu_rid),
        .s01_axi_rresp      (lsu_rresp),
        .s01_axi_rlast      (lsu_rlast),
        .s01_axi_rvalid     (lsu_rvalid),
        .s01_axi_ruser      (lsu_ruser),
        .s01_axi_rready     (lsu_rready),
        .s02_axi_awid       ({3'b0,sb_awid}),
        .s02_axi_awaddr     (sb_awaddr),
        .s02_axi_awuser     (sb_awuser),
        .s02_axi_awlen      (sb_awlen),
        .s02_axi_awsize     (sb_awsize),
        .s02_axi_awburst    (sb_awburst),
        .s02_axi_awlock     (sb_awlock),
        .s02_axi_awcache    (sb_awcache),
        .s02_axi_awprot     (sb_awprot),
        .s02_axi_awqos      (sb_awqos),
        .s02_axi_awvalid    (sb_awvalid),
        .s02_axi_awready    (sb_awready),
        .s02_axi_wdata      (sb_wdata),
        .s02_axi_wuser      (sb_wuser),
        .s02_axi_wstrb      (sb_wstrb),
        .s02_axi_wvalid     (sb_wvalid),
        .s02_axi_wready     (sb_wready),
        .s02_axi_wlast      (sb_wlast),
        .s02_axi_bid        (sb_bid),
        .s02_axi_buser      (sb_buser),
        .s02_axi_bresp      (sb_bresp),
        .s02_axi_bvalid     (sb_bvalid),
        .s02_axi_bready     (sb_bready),
        .s02_axi_arid       ({3'b0,sb_arid}),
        .s02_axi_araddr     (sb_araddr),
        .s02_axi_aruser     (sb_aruser),
        .s02_axi_arlen      (sb_arlen),
        .s02_axi_arsize     (sb_arsize),
        .s02_axi_arburst    (sb_arburst),
        .s02_axi_arlock     (sb_arlock),
        .s02_axi_arcache    (sb_arcache),
        .s02_axi_arprot     (sb_arprot),
        .s02_axi_arqos      (sb_arqos),
        .s02_axi_arvalid    (sb_arvalid),
        .s02_axi_arready    (sb_arready),
        .s02_axi_rdata      (sb_rdata),
        .s02_axi_rid        (sb_rid),
        .s02_axi_rresp      (sb_rresp),
        .s02_axi_rlast      (sb_rlast),
        .s02_axi_rvalid     (sb_rvalid),
        .s02_axi_ruser      (sb_ruser),
        .s02_axi_rready     (sb_rready),
        .m00_axi_awid       (axi2apb_0_awid),
        .m00_axi_awaddr     (axi2apb_0_awaddr),
        .m00_axi_awlen      (axi2apb_0_awlen),
        .m00_axi_awsize     (axi2apb_0_awsize),
        .m00_axi_awburst    (axi2apb_0_awburst),
        .m00_axi_awlock     (axi2apb_0_awlock),
        .m00_axi_awcache    (axi2apb_0_awcache),
        .m00_axi_awprot     (axi2apb_0_awprot),
        .m00_axi_awregion   (axi2apb_0_awregion),
        .m00_axi_awqos      (axi2apb_0_awqos),
        .m00_axi_awuser     (axi2apb_0_awuser),
        .m00_axi_awvalid    (axi2apb_0_awvalid),
        .m00_axi_awready    (axi2apb_0_awready),
        .m00_axi_wdata      (axi2apb_0_wdata),
        .m00_axi_wstrb      (axi2apb_0_wstrb),
        .m00_axi_wuser      (axi2apb_0_wuser),
        .m00_axi_wvalid     (axi2apb_0_wvalid),
        .m00_axi_wready     (axi2apb_0_wready),
        .m00_axi_wlast      (axi2apb_0_wlast),
        .m00_axi_bid        (axi2apb_0_bid),
        .m00_axi_buser      (axi2apb_0_buser),
        .m00_axi_bresp      (axi2apb_0_bresp),
        .m00_axi_bvalid     (axi2apb_0_bvalid),
        .m00_axi_bready     (axi2apb_0_bready),
        .m00_axi_araddr     (axi2apb_0_araddr),
        .m00_axi_arid       (axi2apb_0_arid),
        .m00_axi_arlen      (axi2apb_0_arlen),
        .m00_axi_arsize     (axi2apb_0_arsize),
        .m00_axi_arburst    (axi2apb_0_arburst),
        .m00_axi_arlock     (axi2apb_0_arlock),
        .m00_axi_arcache    (axi2apb_0_arcache),
        .m00_axi_arprot     (axi2apb_0_arprot),
        .m00_axi_arregion   (axi2apb_0_arregion),
        .m00_axi_arqos      (axi2apb_0_arqos),
        .m00_axi_aruser     (axi2apb_0_aruser),
        .m00_axi_arvalid    (axi2apb_0_arvalid),
        .m00_axi_arready    (axi2apb_0_arready),
        .m00_axi_rdata      (axi2apb_0_rdata),
        .m00_axi_rid        (axi2apb_0_rid),
        .m00_axi_rresp      (axi2apb_0_rresp),
        .m00_axi_rlast      (axi2apb_0_rlast),
        .m00_axi_rvalid     (axi2apb_0_rvalid),
        .m00_axi_ruser      (axi2apb_0_ruser),
        .m00_axi_rready     (axi2apb_0_rready),
        .m01_axi_awid       (bram_ctrl_0_awid),
        .m01_axi_awaddr     (bram_ctrl_0_awaddr),
        .m01_axi_awlen      (bram_ctrl_0_awlen),
        .m01_axi_awsize     (bram_ctrl_0_awsize),
        .m01_axi_awburst    (bram_ctrl_0_awburst),
        .m01_axi_awlock     (bram_ctrl_0_awlock),
        .m01_axi_awcache    (bram_ctrl_0_awcache),
        .m01_axi_awprot     (bram_ctrl_0_awprot),
        .m01_axi_awregion   (bram_ctrl_0_awregion),
        .m01_axi_awqos      (bram_ctrl_0_awqos),
        .m01_axi_awuser     (bram_ctrl_0_awuser),
        .m01_axi_awvalid    (bram_ctrl_0_awvalid),
        .m01_axi_awready    (bram_ctrl_0_awready),
        .m01_axi_wdata      (bram_ctrl_0_wdata),
        .m01_axi_wstrb      (bram_ctrl_0_wstrb),
        .m01_axi_wuser      (bram_ctrl_0_wuser),
        .m01_axi_wvalid     (bram_ctrl_0_wvalid),
        .m01_axi_wready     (bram_ctrl_0_wready),
        .m01_axi_wlast      (bram_ctrl_0_wlast),
        .m01_axi_bid        (bram_ctrl_0_bid),
        .m01_axi_buser      (bram_ctrl_0_buser),
        .m01_axi_bresp      (bram_ctrl_0_bresp),
        .m01_axi_bvalid     (bram_ctrl_0_bvalid),
        .m01_axi_bready     (bram_ctrl_0_bready),
        .m01_axi_araddr     (bram_ctrl_0_araddr),
        .m01_axi_arid       (bram_ctrl_0_arid),
        .m01_axi_arlen      (bram_ctrl_0_arlen),
        .m01_axi_arsize     (bram_ctrl_0_arsize),
        .m01_axi_arburst    (bram_ctrl_0_arburst),
        .m01_axi_arlock     (bram_ctrl_0_arlock),
        .m01_axi_arcache    (bram_ctrl_0_arcache),
        .m01_axi_arprot     (bram_ctrl_0_arprot),
        .m01_axi_arregion   (bram_ctrl_0_arregion),
        .m01_axi_arqos      (bram_ctrl_0_arqos),
        .m01_axi_aruser     (bram_ctrl_0_aruser),
        .m01_axi_arvalid    (bram_ctrl_0_arvalid),
        .m01_axi_arready    (bram_ctrl_0_arready),
        .m01_axi_rdata      (bram_ctrl_0_rdata),
        .m01_axi_rid        (bram_ctrl_0_rid),
        .m01_axi_rresp      (bram_ctrl_0_rresp),
        .m01_axi_rlast      (bram_ctrl_0_rlast),
        .m01_axi_rvalid     (bram_ctrl_0_rvalid),
        .m01_axi_ruser      (bram_ctrl_0_ruser),
        .m01_axi_rready     (bram_ctrl_0_rready),
        .m02_axi_awid       (bram_ctrl_1_awid),
        .m02_axi_awaddr     (bram_ctrl_1_awaddr),
        .m02_axi_awlen      (bram_ctrl_1_awlen),
        .m02_axi_awsize     (bram_ctrl_1_awsize),
        .m02_axi_awburst    (bram_ctrl_1_awburst),
        .m02_axi_awlock     (bram_ctrl_1_awlock),
        .m02_axi_awcache    (bram_ctrl_1_awcache),
        .m02_axi_awprot     (bram_ctrl_1_awprot),
        .m02_axi_awregion   (bram_ctrl_1_awregion),
        .m02_axi_awqos      (bram_ctrl_1_awqos),
        .m02_axi_awuser     (bram_ctrl_1_awuser),
        .m02_axi_awvalid    (bram_ctrl_1_awvalid),
        .m02_axi_awready    (bram_ctrl_1_awready),
        .m02_axi_wdata      (bram_ctrl_1_wdata),
        .m02_axi_wstrb      (bram_ctrl_1_wstrb),
        .m02_axi_wuser      (bram_ctrl_1_wuser),
        .m02_axi_wvalid     (bram_ctrl_1_wvalid),
        .m02_axi_wready     (bram_ctrl_1_wready),
        .m02_axi_wlast      (bram_ctrl_1_wlast),
        .m02_axi_bid        (bram_ctrl_1_bid),
        .m02_axi_buser      (bram_ctrl_1_buser),
        .m02_axi_bresp      (bram_ctrl_1_bresp),
        .m02_axi_bvalid     (bram_ctrl_1_bvalid),
        .m02_axi_bready     (bram_ctrl_1_bready),
        .m02_axi_araddr     (bram_ctrl_1_araddr),
        .m02_axi_arid       (bram_ctrl_1_arid),
        .m02_axi_arlen      (bram_ctrl_1_arlen),
        .m02_axi_arsize     (bram_ctrl_1_arsize),
        .m02_axi_arburst    (bram_ctrl_1_arburst),
        .m02_axi_arlock     (bram_ctrl_1_arlock),
        .m02_axi_arcache    (bram_ctrl_1_arcache),
        .m02_axi_arprot     (bram_ctrl_1_arprot),
        .m02_axi_arregion   (bram_ctrl_1_arregion),
        .m02_axi_arqos      (bram_ctrl_1_arqos),
        .m02_axi_aruser     (bram_ctrl_1_aruser),
        .m02_axi_arvalid    (bram_ctrl_1_arvalid),
        .m02_axi_arready    (bram_ctrl_1_arready),
        .m02_axi_rdata      (bram_ctrl_1_rdata),
        .m02_axi_rid        (bram_ctrl_1_rid),
        .m02_axi_rresp      (bram_ctrl_1_rresp),
        .m02_axi_rlast      (bram_ctrl_1_rlast),
        .m02_axi_rvalid     (bram_ctrl_1_rvalid),
        .m02_axi_ruser      (bram_ctrl_1_ruser),
        .m02_axi_rready     (bram_ctrl_1_rready),
        .m03_axi_awid       (axi2apb_1_awid),
        .m03_axi_awaddr     (axi2apb_1_awaddr),
        .m03_axi_awlen      (axi2apb_1_awlen),
        .m03_axi_awsize     (axi2apb_1_awsize),
        .m03_axi_awburst    (axi2apb_1_awburst),
        .m03_axi_awlock     (axi2apb_1_awlock),
        .m03_axi_awcache    (axi2apb_1_awcache),
        .m03_axi_awprot     (axi2apb_1_awprot),
        .m03_axi_awregion   (axi2apb_1_awregion),
        .m03_axi_awqos      (axi2apb_1_awqos),
        .m03_axi_awuser     (axi2apb_1_awuser),
        .m03_axi_awvalid    (axi2apb_1_awvalid),
        .m03_axi_awready    (axi2apb_1_awready),
        .m03_axi_wdata      (axi2apb_1_wdata),
        .m03_axi_wstrb      (axi2apb_1_wstrb),
        .m03_axi_wuser      (axi2apb_1_wuser),
        .m03_axi_wvalid     (axi2apb_1_wvalid),
        .m03_axi_wready     (axi2apb_1_wready),
        .m03_axi_wlast      (axi2apb_1_wlast),
        .m03_axi_bid        (axi2apb_1_bid),
        .m03_axi_buser      (axi2apb_1_buser),
        .m03_axi_bresp      (axi2apb_1_bresp),
        .m03_axi_bvalid     (axi2apb_1_bvalid),
        .m03_axi_bready     (axi2apb_1_bready),
        .m03_axi_araddr     (axi2apb_1_araddr),
        .m03_axi_arid       (axi2apb_1_arid),
        .m03_axi_arlen      (axi2apb_1_arlen),
        .m03_axi_arsize     (axi2apb_1_arsize),
        .m03_axi_arburst    (axi2apb_1_arburst),
        .m03_axi_arlock     (axi2apb_1_arlock),
        .m03_axi_arcache    (axi2apb_1_arcache),
        .m03_axi_arprot     (axi2apb_1_arprot),
        .m03_axi_arregion   (axi2apb_1_arregion),
        .m03_axi_arqos      (axi2apb_1_arqos),
        .m03_axi_aruser     (axi2apb_1_aruser),
        .m03_axi_arvalid    (axi2apb_1_arvalid),
        .m03_axi_arready    (axi2apb_1_arready),
        .m03_axi_rdata      (axi2apb_1_rdata),
        .m03_axi_rid        (axi2apb_1_rid),
        .m03_axi_rresp      (axi2apb_1_rresp),
        .m03_axi_rlast      (axi2apb_1_rlast),
        .m03_axi_rvalid     (axi2apb_1_rvalid),
        .m03_axi_ruser      (axi2apb_1_ruser),
        .m03_axi_rready     (axi2apb_1_rready)
    );

/*###########################################################*/
/*                  AXI to APB Bridge                        */
/*             1 AXI input, 4 APB output                     */
/*###########################################################*/
    axi2apb_0_wrapper
    #(
        .AXI_ID_length      (6),
        .AXI_addr_length    (32),
        .AXI_data_length    (64),
        .AXI_strb_length    (8),
        .APB_addr_length    (32),
        .APB_data_length    (32),
        .APB_strb_length    (4),
        .num_of_slaves      (4)
    )
    axi2apb_0_wrapper_inst
    (
        .AWID               (axi2apb_0_awid),
        .AWADDR             (axi2apb_0_awaddr),
        .AWLEN              (axi2apb_0_awlen),
        .AWSIZE             (axi2apb_0_awsize),
        .AWBURST            (axi2apb_0_awburst),
        //.AWLOCK             (axi2apb_0_awlock),
        //.AWCACHE            (axi2apb_0_awcache),
        //.AWPROT             (axi2apb_0_awprot),
        //.AWQOS              (axi2apb_0_awqos),
        //.AWUSER             (axi2apb_0_awuser),
        .AWVALID            (axi2apb_0_awvalid),
        .AWREADY            (axi2apb_0_awready),
        .WDATA              (axi2apb_0_wdata),
        .WSTRB              (axi2apb_0_wstrb),
        .WLAST              (axi2apb_0_wlast),
        .WVALID             (axi2apb_0_wvalid),
        .WREADY             (axi2apb_0_wready),
        //.WUSER              (axi2apb_0_wuser),
        .BID                (axi2apb_0_bid),
        .BRESP              (axi2apb_0_bresp),
        .BVALID             (axi2apb_0_bvalid),
        .BREADY             (axi2apb_0_bready),
        //.BUSER              (axi2apb_0_buser),
        .ARID               (axi2apb_0_arid),
        .ARADDR             (axi2apb_0_araddr),
        .ARLEN              (axi2apb_0_arlen),
        .ARSIZE             (axi2apb_0_arsize),
        .ARBURST            (axi2apb_0_arburst),
        //.ARLOCK             (axi2apb_0_arlock),
        //.ARCACHE            (axi2apb_0_arcache),
        //.ARPROT             (axi2apb_0_arprot),
        //.ARQOS              (axi2apb_0_arqos),
        //.ARUSER             (axi2apb_0_aruser),
        .ARVALID            (axi2apb_0_arvalid),
        .ARREADY            (axi2apb_0_arready),
        .RID                (axi2apb_0_rid),
        .RDATA              (axi2apb_0_rdata),
        .RRESP              (axi2apb_0_rresp),
        .RLAST              (axi2apb_0_rlast),
        .RVALID             (axi2apb_0_rvalid),
        .RREADY             (axi2apb_0_rready),
        //.RUSER              (axi2apb_0_ruser),
        .s03_apb_PADDR      (vt_gpio_output_paddr),
        .s03_apb_PPROT      (vt_gpio_output_pprot),
        .s03_apb_PSTRB      (vt_gpio_output_pstrb),
        .s03_apb_PSEL       (vt_gpio_output_psel),
        .s03_apb_PENABLE    (vt_gpio_output_penable),
        .s03_apb_PWDATA     (vt_gpio_output_pwdata),
        .s03_apb_PWRITE     (vt_gpio_output_pwrite),
        .s03_apb_PRDATA     (vt_gpio_output_prdata),
        .s03_apb_PREADY     (vt_gpio_output_pready),
        .s03_apb_PSLVERR    (vt_gpio_output_pslverr),
        .s02_apb_PADDR      (vt_gpio_input_paddr),
        .s02_apb_PPROT      (vt_gpio_input_pprot),
        .s02_apb_PSTRB      (vt_gpio_input_pstrb),
        .s02_apb_PSEL       (vt_gpio_input_psel),
        .s02_apb_PENABLE    (vt_gpio_input_penable),
        .s02_apb_PWDATA     (vt_gpio_input_pwdata),
        .s02_apb_PWRITE     (vt_gpio_input_pwrite),
        .s02_apb_PRDATA     (vt_gpio_input_prdata),
        .s02_apb_PREADY     (vt_gpio_input_pready),
        .s02_apb_PSLVERR    (vt_gpio_input_pslverr),
        .s01_apb_PADDR      (vt_timer_paddr),
        .s01_apb_PPROT      (vt_timer_pprot),
        .s01_apb_PSTRB      (vt_timer_pstrb),
        .s01_apb_PSEL       (vt_timer_psel),
        .s01_apb_PENABLE    (vt_timer_penable),
        .s01_apb_PWDATA     (vt_timer_pwdata),
        .s01_apb_PWRITE     (vt_timer_pwrite),
        .s01_apb_PRDATA     (vt_timer_prdata),
        .s01_apb_PREADY     (vt_timer_pready),
        .s01_apb_PSLVERR    (vt_timer_pslverr),
        .s00_apb_PADDR      (vt_spi_paddr),
        .s00_apb_PPROT      (vt_spi_pprot),
        .s00_apb_PSTRB      (vt_spi_pstrb),
        .s00_apb_PSEL       (vt_spi_psel),
        .s00_apb_PENABLE    (vt_spi_penable),
        .s00_apb_PWDATA     (vt_spi_pwdata),
        .s00_apb_PWRITE     (vt_spi_pwrite),
        .s00_apb_PRDATA     (vt_spi_prdata),
        .s00_apb_PREADY     (vt_spi_pready),
        .s00_apb_PSLVERR    (vt_spi_pslverr),
        .clk                (axi_clk_axi2apb_0),
        .rst_n              (axi_rstn_axi2apb_0),
        .PCLK               (pclk_axi2apb_0),
        .PRESETn            (prstn_axi2apb_0)
    );

/*###########################################################*/
/*                  AXI to APB Bridge                        */
/*             1 AXI input, 4 APB output                     */
/*###########################################################*/
    axi2apb_1_wrapper
    #(
        .AXI_ID_length      (6),
        .AXI_addr_length    (32),
        .AXI_data_length    (64),
        .AXI_strb_length    (8),
        .APB_addr_length    (32),
        .APB_data_length    (32),
        .APB_strb_length    (4),
        .num_of_slaves      (4)
    )
    axi2apb_1_wrapper_inst
    (
        .AWID               (axi2apb_1_awid),
        .AWADDR             (axi2apb_1_awaddr),
        .AWLEN              (axi2apb_1_awlen),
        .AWSIZE             (axi2apb_1_awsize),
        .AWBURST            (axi2apb_1_awburst),
        //.AWLOCK             (axi2apb_1_awlock),
        //.AWCACHE            (axi2apb_1_awcache),
        //.AWPROT             (axi2apb_1_awprot),
        //.AWQOS              (axi2apb_1_awqos),
        //.AWUSER             (axi2apb_1_awuser),
        .AWVALID            (axi2apb_1_awvalid),
        .AWREADY            (axi2apb_1_awready),
        .WDATA              (axi2apb_1_wdata),
        .WSTRB              (axi2apb_1_wstrb),
        .WLAST              (axi2apb_1_wlast),
        .WVALID             (axi2apb_1_wvalid),
        .WREADY             (axi2apb_1_wready),
        //.WUSER              (axi2apb_1_wuser),
        .BID                (axi2apb_1_bid),
        .BRESP              (axi2apb_1_bresp),
        .BVALID             (axi2apb_1_bvalid),
        .BREADY             (axi2apb_1_bready),
        //.BUSER              (axi2apb_1_buser),
        .ARID               (axi2apb_1_arid),
        .ARADDR             (axi2apb_1_araddr),
        .ARLEN              (axi2apb_1_arlen),
        .ARSIZE             (axi2apb_1_arsize),
        .ARBURST            (axi2apb_1_arburst),
        //.ARLOCK             (axi2apb_1_arlock),
        //.ARCACHE            (axi2apb_1_arcache),
        //.ARPROT             (axi2apb_1_arprot),
        //.ARQOS              (axi2apb_1_arqos),
        //.ARUSER             (axi2apb_1_aruser),
        .ARVALID            (axi2apb_1_arvalid),
        .ARREADY            (axi2apb_1_arready),
        .RID                (axi2apb_1_rid),
        .RDATA              (axi2apb_1_rdata),
        .RRESP              (axi2apb_1_rresp),
        .RLAST              (axi2apb_1_rlast),
        .RVALID             (axi2apb_1_rvalid),
        .RREADY             (axi2apb_1_rready),
        //.RUSER              (axi2apb_1_ruser),
        .s03_apb_PADDR      (vt_i2c_paddr),
        .s03_apb_PPROT      (vt_i2c_pprot),
        .s03_apb_PSTRB      (vt_i2c_pstrb),
        .s03_apb_PSEL       (vt_i2c_psel),
        .s03_apb_PENABLE    (vt_i2c_penable),
        .s03_apb_PWDATA     (vt_i2c_pwdata),
        .s03_apb_PWRITE     (vt_i2c_pwrite),
        .s03_apb_PRDATA     (vt_i2c_prdata),
        .s03_apb_PREADY     (vt_i2c_pready),
        .s03_apb_PSLVERR    (vt_i2c_pslverr),
        .s02_apb_PADDR      (vt_uart_2_paddr),
        .s02_apb_PPROT      (vt_uart_2_pprot),
        .s02_apb_PSTRB      (vt_uart_2_pstrb),
        .s02_apb_PSEL       (vt_uart_2_psel),
        .s02_apb_PENABLE    (vt_uart_2_penable),
        .s02_apb_PWDATA     (vt_uart_2_pwdata),
        .s02_apb_PWRITE     (vt_uart_2_pwrite),
        .s02_apb_PRDATA     (vt_uart_2_prdata),
        .s02_apb_PREADY     (vt_uart_2_pready),
        .s02_apb_PSLVERR    (vt_uart_2_pslverr),
        .s01_apb_PADDR      (vt_uart_1_paddr),
        .s01_apb_PPROT      (vt_uart_1_pprot),
        .s01_apb_PSTRB      (vt_uart_1_pstrb),
        .s01_apb_PSEL       (vt_uart_1_psel),
        .s01_apb_PENABLE    (vt_uart_1_penable),
        .s01_apb_PWDATA     (vt_uart_1_pwdata),
        .s01_apb_PWRITE     (vt_uart_1_pwrite),
        .s01_apb_PRDATA     (vt_uart_1_prdata),
        .s01_apb_PREADY     (vt_uart_1_pready),
        .s01_apb_PSLVERR    (vt_uart_1_pslverr),
        .s00_apb_PADDR      (vt_uart_0_paddr),
        .s00_apb_PPROT      (vt_uart_0_pprot),
        .s00_apb_PSTRB      (vt_uart_0_pstrb),
        .s00_apb_PSEL       (vt_uart_0_psel),
        .s00_apb_PENABLE    (vt_uart_0_penable),
        .s00_apb_PWDATA     (vt_uart_0_pwdata),
        .s00_apb_PWRITE     (vt_uart_0_pwrite),
        .s00_apb_PRDATA     (vt_uart_0_prdata),
        .s00_apb_PREADY     (vt_uart_0_pready),
        .s00_apb_PSLVERR    (vt_uart_0_pslverr),
        .clk                (axi_clk_axi2apb_1),
        .rst_n              (axi_rstn_axi2apb_1),
        .PCLK               (pclk_axi2apb_1),
        .PRESETn            (prstn_axi2apb_1)
    );

/*###########################################################*/
/*                  BRAM Controller                          */
/*             //TODO opis, kolicina, adresa....             */
/*###########################################################*/
    axi_bram_ctrl_0 BRAM_0_CTRL
    (
        .bram_addr_a        (bram_0_addr_a  ),
        .bram_addr_b        (bram_0_addr_b  ),
        .bram_clk_a         (bram_0_clk_a   ),
        .bram_clk_b         (bram_0_clk_b   ),
        .bram_en_a          (bram_0_en_a    ),
        .bram_en_b          (bram_0_en_b    ),
        .bram_rddata_a      (bram_0_rddata_a),
        .bram_rddata_b      (bram_0_rddata_b),
        .bram_rst_a         (bram_0_rst_a   ),
        .bram_rst_b         (bram_0_rst_b   ),
        .bram_we_a          (bram_0_we_a    ),
        .bram_we_b          (bram_0_we_b    ),
        .bram_wrdata_a      (bram_0_wrdata_a),
        .bram_wrdata_b      (bram_0_wrdata_b),
        .s_axi_aclk         (axi_clk_bram_ctrl_0),
        .s_axi_araddr       (bram_ctrl_0_araddr[17:0] ),
        .s_axi_arburst      (bram_ctrl_0_arburst),
        .s_axi_arcache      (bram_ctrl_0_arcache),
        .s_axi_aresetn      (axi_rstn_bram_ctrl_0),
        .s_axi_arid         (bram_ctrl_0_arid   ),
        .s_axi_arlen        (bram_ctrl_0_arlen  ),
        .s_axi_arlock       (bram_ctrl_0_arlock ),
        .s_axi_arprot       (bram_ctrl_0_arprot ),
        .s_axi_arready      (bram_ctrl_0_arready),
        .s_axi_arsize       (bram_ctrl_0_arsize ),
        .s_axi_arvalid      (bram_ctrl_0_arvalid),
        .s_axi_awaddr       (bram_ctrl_0_awaddr[17:0] ),
        .s_axi_awburst      (bram_ctrl_0_awburst),
        .s_axi_awcache      (bram_ctrl_0_awcache),
        .s_axi_awid         (bram_ctrl_0_awid   ),
        .s_axi_awlen        (bram_ctrl_0_awlen  ),
        .s_axi_awlock       (bram_ctrl_0_awlock ),
        .s_axi_awprot       (bram_ctrl_0_awprot ),
        .s_axi_awready      (bram_ctrl_0_awready),
        .s_axi_awsize       (bram_ctrl_0_awsize ),
        .s_axi_awvalid      (bram_ctrl_0_awvalid),
        .s_axi_bid          (bram_ctrl_0_bid    ),
        .s_axi_bready       (bram_ctrl_0_bready ),
        .s_axi_bresp        (bram_ctrl_0_bresp  ),
        .s_axi_bvalid       (bram_ctrl_0_bvalid ),
        .s_axi_rdata        (bram_ctrl_0_rdata  ),
        .s_axi_rid          (bram_ctrl_0_rid    ),
        .s_axi_rlast        (bram_ctrl_0_rlast  ),
        .s_axi_rready       (bram_ctrl_0_rready ),
        .s_axi_rresp        (bram_ctrl_0_rresp  ),
        .s_axi_rvalid       (bram_ctrl_0_rvalid ),
        .s_axi_wdata        (bram_ctrl_0_wdata  ),
        .s_axi_wlast        (bram_ctrl_0_wlast  ),
        .s_axi_wready       (bram_ctrl_0_wready ),
        .s_axi_wstrb        (bram_ctrl_0_wstrb  ),
        .s_axi_wvalid       (bram_ctrl_0_wvalid )
    );

///*###########################################################*/
///*                     Block Memory                          */
///*             //TODO opis, kolicina, adresa....             */
///*###########################################################*/
    blk_mem_gen_0 BLK_MEM_0
    (
        .addra              ({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,bram_0_addr_a}),
        .addrb              ({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,bram_0_addr_b}),
        .clka               (bram_0_clk_a),
        .clkb               (bram_0_clk_b),
        .dina               (bram_0_wrdata_a),
        .dinb               (bram_0_wrdata_b),
        .douta              (bram_0_rddata_a),
        .doutb              (bram_0_rddata_b),
        .ena                (bram_0_en_a),
        .enb                (bram_0_en_b),
        .rsta               (bram_0_rst_a),
        .rstb               (bram_0_rst_b),
        .wea                (bram_0_we_a),
        .web                (bram_0_we_b)
    );

///*###########################################################*/
///*                  BRAM Controller                          */
///*             //TODO opis, kolicina, adresa....             */
///*###########################################################*/
    axi_bram_ctrl_1 BRAM_1_CTRL
    (
        .bram_addr_a        (bram_1_addr_a  ),
        .bram_addr_b        (bram_1_addr_b  ),
        .bram_clk_a         (bram_1_clk_a   ),
        .bram_clk_b         (bram_1_clk_b   ),
        .bram_en_a          (bram_1_en_a    ),
        .bram_en_b          (bram_1_en_b    ),
        .bram_rddata_a      (bram_1_rddata_a),
        .bram_rddata_b      (bram_1_rddata_b),
        .bram_rst_a         (bram_1_rst_a   ),
        .bram_rst_b         (bram_1_rst_b   ),
        .bram_we_a          (bram_1_we_a    ),
        .bram_we_b          (bram_1_we_b    ),
        .bram_wrdata_a      (bram_1_wrdata_a),
        .bram_wrdata_b      (bram_1_wrdata_b),
        .s_axi_aclk         (axi_clk_bram_ctrl_1),
        .s_axi_araddr       (bram_ctrl_1_araddr[16:0]  ),
        .s_axi_arburst      (bram_ctrl_1_arburst ),
        .s_axi_arcache      (bram_ctrl_1_arcache ),
        .s_axi_aresetn      (axi_rstn_bram_ctrl_1 ),
        .s_axi_arid         (bram_ctrl_1_arid    ),
        .s_axi_arlen        (bram_ctrl_1_arlen   ),
        .s_axi_arlock       (bram_ctrl_1_arlock  ),
        .s_axi_arprot       (bram_ctrl_1_arprot  ),
        .s_axi_arready      (bram_ctrl_1_arready ),
        .s_axi_arsize       (bram_ctrl_1_arsize  ),
        .s_axi_arvalid      (bram_ctrl_1_arvalid ),
        .s_axi_awaddr       (bram_ctrl_1_awaddr[16:0]  ),
        .s_axi_awburst      (bram_ctrl_1_awburst ),
        .s_axi_awcache      (bram_ctrl_1_awcache ),
        .s_axi_awid         (bram_ctrl_1_awid    ),
        .s_axi_awlen        (bram_ctrl_1_awlen   ),
        .s_axi_awlock       (bram_ctrl_1_awlock  ),
        .s_axi_awprot       (bram_ctrl_1_awprot  ),
        .s_axi_awready      (bram_ctrl_1_awready ),
        .s_axi_awsize       (bram_ctrl_1_awsize  ),
        .s_axi_awvalid      (bram_ctrl_1_awvalid ),
        .s_axi_bid          (bram_ctrl_1_bid     ),
        .s_axi_bready       (bram_ctrl_1_bready  ),
        .s_axi_bresp        (bram_ctrl_1_bresp   ),
        .s_axi_bvalid       (bram_ctrl_1_bvalid  ),
        .s_axi_rdata        (bram_ctrl_1_rdata   ),
        .s_axi_rid          (bram_ctrl_1_rid     ),
        .s_axi_rlast        (bram_ctrl_1_rlast   ),
        .s_axi_rready       (bram_ctrl_1_rready  ),
        .s_axi_rresp        (bram_ctrl_1_rresp   ),
        .s_axi_rvalid       (bram_ctrl_1_rvalid  ),
        .s_axi_wdata        (bram_ctrl_1_wdata   ),
        .s_axi_wlast        (bram_ctrl_1_wlast   ),
        .s_axi_wready       (bram_ctrl_1_wready  ),
        .s_axi_wstrb        (bram_ctrl_1_wstrb   ),
        .s_axi_wvalid       (bram_ctrl_1_wvalid  )
    );

///*###########################################################*/
///*                     Block Memory                          */
///*             //TODO opis, kolicina, adresa....             */
///*###########################################################*/
    blk_mem_gen_1 BLK_MEM_1
    (
        .addra              ({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,bram_1_addr_a}),
        .addrb              ({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,bram_1_addr_b}),
        .clka               (bram_1_clk_a),
        .clkb               (bram_1_clk_b),
        .dina               (bram_1_wrdata_a),
        .dinb               (bram_1_wrdata_b),
        .douta              (bram_1_rddata_a),
        .doutb              (bram_1_rddata_b),
        .ena                (bram_1_en_a),
        .enb                (bram_1_en_b),
        .rsta               (bram_1_rst_a),
        .rstb               (bram_1_rst_b),
        .wea                (bram_1_we_a),
        .web                (bram_1_we_b)
    );

/*###########################################################*/
/*                VTooL GPIO  (APB interface)                */
/*                   // TODO desc                            */
/*###########################################################*/
    gpio_top
    #(
        .NUM_OF_PINS    (32),
        .PDW            (32),
        .PAW            (8)
    )
    gpio_top_inst_input
    (
        .clk_i          (pclk_gpio_input_vt),
        .rst_n_i        (prstn_gpio_input_vt),
        .paddr_i        (vt_gpio_input_paddr[7:0]),
        .psel_i         (vt_gpio_input_psel),
        .penable_i      (vt_gpio_input_penable),
        .pwrite_i       (vt_gpio_input_pwrite),
        .pwdata_i       (vt_gpio_input_pwdata),
        .pstrb_i        (vt_gpio_input_pstrb),
        .pready_o       (vt_gpio_input_pready),
        .prdata_o       (vt_gpio_input_prdata),
        .pslverr_o      (vt_gpio_input_pslverr),
        .gpio_input_i   (vt_button_sw),
        .gpio_output_o  (),
        .gpio_output_en_o(),
        .irq_o          (vt_gpio_input_irq),
        .aux_out_i      (32'b0),
        .aux_in_o       ()
    );

/*###########################################################*/
/*                VTooL GPIO  (APB interface)                */
/*                   // TODO desc                            */
/*###########################################################*/
    gpio_top
    #(
        .NUM_OF_PINS    (32),
        .PDW            (32),
        .PAW            (8)
    )
    gpio_top_inst_output
    (
        .clk_i          (pclk_gpio_output_vt),
        .rst_n_i        (prstn_gpio_output_vt),
        .paddr_i        (vt_gpio_output_paddr[7:0]),
        .psel_i         (vt_gpio_output_psel),
        .penable_i      (vt_gpio_output_penable),
        .pwrite_i       (vt_gpio_output_pwrite),
        .pwdata_i       (vt_gpio_output_pwdata),
        .pstrb_i        (vt_gpio_output_pstrb),
        .pready_o       (vt_gpio_output_pready),
        .prdata_o       (vt_gpio_output_prdata),
        .pslverr_o      (vt_gpio_output_pslverr),
        .gpio_input_i   (32'b0),
        .gpio_output_o  (vt_led),
        .gpio_output_en_o(),
        .irq_o          (vt_gpio_output_irq),
        .aux_out_i      (vt_gpio_output_aux_in),
        .aux_in_o       (vt_gpio_output_aux_out)
    );

/*###########################################################*/
/*                VTooL TIMER (APB interface)                */
/*                   // TODO desc                            */
/*###########################################################*/
    timer_top timer_top_inst
    (
        .clk            (pclk_timer_vt),
        .rst_n          (prstn_timer_vt),
        .apb_paddr      (vt_timer_paddr[7:0]),
        .apb_pstrb      (vt_timer_pstrb),
        .apb_psel       (vt_timer_psel),
        .apb_penable    (vt_timer_penable),
        .apb_pwdata     (vt_timer_pwdata),
        .apb_pwrite     (vt_timer_pwrite),
        .apb_prdata     (vt_timer_prdata),
        .apb_pready     (vt_timer_pready),
        .apb_pslverr    (vt_timer_pslverr),
        .ch0_timer_i    (vt_timer_ch0_i),
        .ch0_timer_o    (vt_timer_ch0_o),
        .ch1_timer_i    (1'b0),
        .ch1_timer_o    (),
        .timer_irq      (vt_timer_irq)
    );

/*###########################################################*/
/*                  VTooL I2C (APB interface)                */
/*                   // TODO opis                            */
/*###########################################################*/
i2c_top
#(
  .I2C_EMPTY_FIFO_MODE  (0),
  .TX_FIFO_DEPTH        (32),
  .RX_FIFO_DEPTH        (32)
)
i2c_top_inst
(
    .clk                (pclk_timer_vt),   // TODO update
    .rstn               (prstn_timer_vt),  // TODO update
    .pclk               (pclk_timer_vt),   // TODO update
    .prstn              (prstn_timer_vt),  // TODO update
    .paddr              (vt_i2c_paddr[7:0] ),
    .psel               (vt_i2c_psel   ),
    .penable            (vt_i2c_penable),
    .pwrite             (vt_i2c_pwrite ),
    .pwdata             (vt_i2c_pwdata ),
    .pstrb              (vt_i2c_pstrb  ),
    .pprot              (vt_i2c_pprot  ),
    .pready             (vt_i2c_pready ),
    .prdata             (vt_i2c_prdata ),
    .pslverr            (vt_i2c_pslverr),
    .scl_i              (vt_i2c_scl_i),
    .scl_o              (vt_i2c_scl_o),
    .scl_oe             (vt_i2c_scl_oe),
    .sda_i              (vt_i2c_sda_i),
    .sda_o              (vt_i2c_sda_o),
    .sda_oe             (vt_i2c_sda_oe),
    .irq                (vt_i2c_intr)
);

/*###########################################################*/
/*                 VTooL SPI (APB interface)                 */
/*                   // TODO desc                            */
/*###########################################################*/
  spi_top
  #(
    .NR_OF_SLAVES  (1 ),
    .PAW           (8),
    .PDW           (32),
    .TXFIFOWIDTH   (32),
    .TXFIFOD       (32),
    .RXFIFOWIDTH   (32),
    .RXFIFOD       (32),
    .SPI_MASTER    (1 ),
    .SDW           (8 ),
    .XIPE          (0 ),
    .ID            (0 )
  )
  vt_spi_inst
  (
    .pclk_i        (pclk_spi_vt),
    .preset_n_i    (prstn_spi_vt),
    .paddr_i       (vt_spi_paddr[7:0]),
    .pprot_i       (vt_spi_pprot),
    .psel_i        (vt_spi_psel),
    .penable_i     (vt_spi_penable),
    .pwrite_i      (vt_spi_pwrite),
    .pwdata_i      (vt_spi_pwdata),
    .pstrb_i       (vt_spi_pstrb),
    .pready_o      (vt_spi_pready),
    .prdata_o      (vt_spi_prdata),
    .pslverr_o     (vt_spi_pslverr),
    .spi_i         (vt_spi_spi_i),
    .spi_o         (vt_spi_spi_o),
    .eclk_i        (clk_spi_vt),
    .rst_n_i       (rstn_spi_vt),
    .scs_o         (vt_spi_scs_o),
    .scs_i         (vt_spi_scs_i),
    .sclk_o        (vt_spi_sclk_o),
    .sclk_i        (vt_spi_sclk_i),
    .xip_en_i      (vt_spi_xip_en_i),
    .chip_sel_i    (vt_spi_chip_sel_i),
    .tri_state_en_o(tri_state_en_o),
    .irq_o         (vt_spi_irq)
  );

/*###########################################################*/
/*                VTooL UART (APB interface)                 */
/*                   // TODO desc                            */
/*###########################################################*/
  vt_uart_top
	#(
    .FIFO_DEPTH   (32),
    .PAW          (8 ),
    .PDW          (32),
    .TWO_CLKS     (0 )
	)
  vt_uart_0_inst
	(
	.pclk_i         (pclk_uart_0_vt),
	.sclk_i         (sclk_uart_0_vt),
	.presetn_i      (prstn_uart_0_vt),
	.rst_n_i        (rstn_uart_0_vt),
	.paddr_i        (vt_uart_0_paddr[7:0]),
	.pprot_i        (vt_uart_0_pprot),
	.psel_i         (vt_uart_0_psel),
	.penable_i      (vt_uart_0_penable),
	.pwrite_i       (vt_uart_0_pwrite),
	.pwdata_i       (vt_uart_0_pwdata),
	.pstrb_i        (vt_uart_0_pstrb),
	.pready_o       (vt_uart_0_pready),
	.prdata_o       (vt_uart_0_prdata),
	.pslverr_o      (vt_uart_0_pslverr),
	.cts_n_i        (vt_uart_0_cts_n_i),
	.dsr_n_i        (vt_uart_0_dsr_n_i),
	.dcd_n_i        (vt_uart_0_dcd_n_i),
	.ri_n_i         (vt_uart_0_ri_n_i),
	.dtr_n_o        (vt_uart_0_dtr_n_o),
	.rts_n_o        (vt_uart_0_rts_n_o),
	.tx_o           (vt_uart_0_tx_o),
	.rx_i           (vt_uart_0_rx_i),
	.intr_o         (vt_uart_0_intr)
	);

/*###########################################################*/
/*                VTooL UART (APB interface)                 */
/*                   // TODO desc                            */
/*###########################################################*/
  vt_uart_top
	#(
    .FIFO_DEPTH   (32),
    .PAW          (8 ),
    .PDW          (32),
    .TWO_CLKS     (0 )
	)
  vt_uart_1_inst
	(
	.pclk_i         (pclk_uart_1_vt),
	.sclk_i         (sclk_uart_1_vt),
	.presetn_i      (prstn_uart_1_vt),
	.rst_n_i        (rstn_uart_1_vt),
	.paddr_i        (vt_uart_1_paddr[7:0]),
	.pprot_i        (vt_uart_1_pprot),
	.psel_i         (vt_uart_1_psel),
	.penable_i      (vt_uart_1_penable),
	.pwrite_i       (vt_uart_1_pwrite),
	.pwdata_i       (vt_uart_1_pwdata),
	.pstrb_i        (vt_uart_1_pstrb),
	.pready_o       (vt_uart_1_pready),
	.prdata_o       (vt_uart_1_prdata),
	.pslverr_o      (vt_uart_1_pslverr),
	.cts_n_i        (vt_uart_1_cts_n_i),
	.dsr_n_i        (vt_uart_1_dsr_n_i),
	.dcd_n_i        (vt_uart_1_dcd_n_i),
	.ri_n_i         (vt_uart_1_ri_n_i),
	.dtr_n_o        (vt_uart_1_dtr_n_o),
	.rts_n_o        (vt_uart_1_rts_n_o),
	.tx_o           (vt_uart_1_tx_o),
	.rx_i           (vt_uart_1_rx_i),
	.intr_o         (vt_uart_1_intr)
	);

/*###########################################################*/
/*                VTooL UART (APB interface)                 */
/*                   // TODO desc                            */
/*###########################################################*/
  vt_uart_top
	#(
    .FIFO_DEPTH   (32),
    .PAW          (8 ),
    .PDW          (32),
    .TWO_CLKS     (0 )
	)
  vt_uart_2_inst
	(
	.pclk_i         (pclk_uart_2_vt),
	.sclk_i         (sclk_uart_2_vt),
	.presetn_i      (prstn_uart_2_vt),
	.rst_n_i        (rstn_uart_2_vt),
	.paddr_i        (vt_uart_2_paddr[7:0]),
	.pprot_i        (vt_uart_2_pprot),
	.psel_i         (vt_uart_2_psel),
	.penable_i      (vt_uart_2_penable),
	.pwrite_i       (vt_uart_2_pwrite),
	.pwdata_i       (vt_uart_2_pwdata),
	.pstrb_i        (vt_uart_2_pstrb),
	.pready_o       (vt_uart_2_pready),
	.prdata_o       (vt_uart_2_prdata),
	.pslverr_o      (vt_uart_2_pslverr),
	.cts_n_i        (vt_uart_2_cts_n_i),
	.dsr_n_i        (vt_uart_2_dsr_n_i),
	.dcd_n_i        (vt_uart_2_dcd_n_i),
	.ri_n_i         (vt_uart_2_ri_n_i),
	.dtr_n_o        (vt_uart_2_dtr_n_o),
	.rts_n_o        (vt_uart_2_rts_n_o),
	.tx_o           (vt_uart_2_tx_o),
	.rx_i           (vt_uart_2_rx_i),
	.intr_o         (vt_uart_2_intr)
	);

/*###########################################################*/
/*                    Test module                            */
/*                   // TODO desc                            */
/*###########################################################*/
    blink blink_inst
    (
        .clk            (clk_blink),
        .rstn           (rstn_blink),
        .led            (rgb)
    );

endmodule  
