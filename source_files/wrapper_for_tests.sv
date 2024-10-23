module wrapper_for_tests();

/*###########################################################*/
/*                 Clock and reset assign                    */
/*###########################################################*/

   wire clk_axi_fabric;
   wire clk_axi2apb_0;
   wire PCLK_axi2apb_0;
   wire clk_axi2apb_1;
   wire PCLK_axi2apb_1;
   wire clk_i_gpio;
   wire clk_timer;
   wire clk_i2c;
   wire pclk_i2c;
   wire pclk_i_spi;
   wire eclk_i_spi;
   wire sclk_o_spi;
   wire sclk_i_spi;
   wire pclk_i_vt_uart;
   wire sclk_i_vt_uart;
   wire clk_blink;
   wire rst_n_axi_fabric;
   wire rst_n_axi2apb_0;
   wire PRESETn_axi2apb_0;
   wire rst_n_axi2apb_1;
   wire PRESETn_axi2apb_1;
   wire rst_n_i_gpio;
   wire rst_n_timer;
   wire rstn_i2c;
   wire prstn_i2c;
   wire preset_n_i_spi;
   wire rst_n_i_spi;
   wire presetn_i_vt_uart;
   wire rst_n_i_vt_uart;
   wire rstn_blink;

   assign axi_fabric_clk = clk;
   assign axi2apb_0_clk = clk;
   assign axi2apb_1_clk = clk;
   assign gpio_clk = clk;
   assign timer_clk = clk;
   assign i2c_clk = clk;
   assign spi_clk = clk;
   assign vt_uart_clk = clk;
   assign blink_clk = clk;

   assign axi_fabric_rstn = rstn;
   assign axi2apb_0_rstn = rstn;
   assign axi2apb_1_rstn = rstn;
   assign gpio_rstn = rstn;
   assign timer_rstn = rstn;
   assign i2c_rstn = rstn;
   assign spi_rstn = rstn;
   assign vt_uart_rstn = rstn;
   assign blink_rstn = rstn;

/*######################################################*/
/*                      axi_fabric                      */
/*                       (Vtool)                        */
/*######################################################*/

axi_fabric_top_wrapper
#(
       .SLAVE_N(),
       .MASTER_N(),
       .ADDR_WIDTH(),
       .DATA_WIDTH(),
       .S_ID_WIDTH(),
       .M_ID_WIDTH(),
       .STRB_WIDTH(),
       .AW_USER_WIDTH(),
       .W_USER_WIDTH(),
       .B_USER_WIDTH(),
       .AR_USER_WIDTH(),
       .R_USER_WIDTH(),
       .ARBITER_TYPE(),
       .MAX_TRANS(),
       .S_AR_CHANNEL_REG(),
       .M_AR_CHANNEL_REG(),
       .S_R_CHANNEL_REG(),
       .M_R_CHANNEL_REG(),
       .S_AW_CHANNEL_REG(),
       .M_AW_CHANNEL_REG(),
       .S_W_CHANNEL_REG(),
       .M_W_CHANNEL_REG(),
       .S_WR_CHANNEL_REG(),
       .M_WR_CHANNEL_REG()
)
axi_fabric_top_wrapper_inst (
   .clk(clk),
   .rst_n(rst_n),
   .s00_axi_awid(s00_axi_awid),
   .s00_axi_awaddr(s00_axi_awaddr),
   .s00_axi_awlen(s00_axi_awlen),
   .s00_axi_awsize(s00_axi_awsize),
   .s00_axi_awburst(s00_axi_awburst),
   .s00_axi_awlock(s00_axi_awlock),
   .s00_axi_awcache(s00_axi_awcache),
   .s00_axi_awprot(s00_axi_awprot),
   .s00_axi_awqos(s00_axi_awqos),
   .s00_axi_awuser(s00_axi_awuser),
   .s00_axi_awvalid(s00_axi_awvalid),
   .s00_axi_awready(s00_axi_awready),
   .s00_axi_wdata(s00_axi_wdata),
   .s00_axi_wstrb(s00_axi_wstrb),
   .s00_axi_wuser(s00_axi_wuser),
   .s00_axi_wvalid(s00_axi_wvalid),
   .s00_axi_wready(s00_axi_wready),
   .s00_axi_wlast(s00_axi_wlast),
   .s00_axi_bid(s00_axi_bid),
   .s00_axi_buser(s00_axi_buser),
   .s00_axi_bresp(s00_axi_bresp),
   .s00_axi_bvalid(s00_axi_bvalid),
   .s00_axi_bready(s00_axi_bready),
   .s00_axi_arid(s00_axi_arid),
   .s00_axi_araddr(s00_axi_araddr),
   .s00_axi_aruser(s00_axi_aruser),
   .s00_axi_arlen(s00_axi_arlen),
   .s00_axi_arsize(s00_axi_arsize),
   .s00_axi_arburst(s00_axi_arburst),
   .s00_axi_arlock(s00_axi_arlock),
   .s00_axi_arcache(s00_axi_arcache),
   .s00_axi_arprot(s00_axi_arprot),
   .s00_axi_arqos(s00_axi_arqos),
   .s00_axi_arvalid(s00_axi_arvalid),
   .s00_axi_arready(s00_axi_arready),
   .s00_axi_rdata(s00_axi_rdata),
   .s00_axi_rid(s00_axi_rid),
   .s00_axi_rresp(s00_axi_rresp),
   .s00_axi_rlast(s00_axi_rlast),
   .s00_axi_rvalid(s00_axi_rvalid),
   .s00_axi_ruser(s00_axi_ruser),
   .s00_axi_rready(s00_axi_rready),
   .s01_axi_awid(s01_axi_awid),
   .s01_axi_awaddr(s01_axi_awaddr),
   .s01_axi_awuser(s01_axi_awuser),
   .s01_axi_awlen(s01_axi_awlen),
   .s01_axi_awsize(s01_axi_awsize),
   .s01_axi_awburst(s01_axi_awburst),
   .s01_axi_awlock(s01_axi_awlock),
   .s01_axi_awcache(s01_axi_awcache),
   .s01_axi_awprot(s01_axi_awprot),
   .s01_axi_awqos(s01_axi_awqos),
   .s01_axi_awvalid(s01_axi_awvalid),
   .s01_axi_awready(s01_axi_awready),
   .s01_axi_wdata(s01_axi_wdata),
   .s01_axi_wuser(s01_axi_wuser),
   .s01_axi_wstrb(s01_axi_wstrb),
   .s01_axi_wvalid(s01_axi_wvalid),
   .s01_axi_wready(s01_axi_wready),
   .s01_axi_wlast(s01_axi_wlast),
   .s01_axi_bid(s01_axi_bid),
   .s01_axi_buser(s01_axi_buser),
   .s01_axi_bresp(s01_axi_bresp),
   .s01_axi_bvalid(s01_axi_bvalid),
   .s01_axi_bready(s01_axi_bready),
   .s01_axi_arid(s01_axi_arid),
   .s01_axi_araddr(s01_axi_araddr),
   .s01_axi_aruser(s01_axi_aruser),
   .s01_axi_arlen(s01_axi_arlen),
   .s01_axi_arsize(s01_axi_arsize),
   .s01_axi_arburst(s01_axi_arburst),
   .s01_axi_arlock(s01_axi_arlock),
   .s01_axi_arcache(s01_axi_arcache),
   .s01_axi_arprot(s01_axi_arprot),
   .s01_axi_arqos(s01_axi_arqos),
   .s01_axi_arvalid(s01_axi_arvalid),
   .s01_axi_arready(s01_axi_arready),
   .s01_axi_rdata(s01_axi_rdata),
   .s01_axi_rid(s01_axi_rid),
   .s01_axi_rresp(s01_axi_rresp),
   .s01_axi_rlast(s01_axi_rlast),
   .s01_axi_rvalid(s01_axi_rvalid),
   .s01_axi_ruser(s01_axi_ruser),
   .s01_axi_rready(s01_axi_rready),
   .s02_axi_awid(s02_axi_awid),
   .s02_axi_awaddr(s02_axi_awaddr),
   .s02_axi_awuser(s02_axi_awuser),
   .s02_axi_awlen(s02_axi_awlen),
   .s02_axi_awsize(s02_axi_awsize),
   .s02_axi_awburst(s02_axi_awburst),
   .s02_axi_awlock(s02_axi_awlock),
   .s02_axi_awcache(s02_axi_awcache),
   .s02_axi_awprot(s02_axi_awprot),
   .s02_axi_awqos(s02_axi_awqos),
   .s02_axi_awvalid(s02_axi_awvalid),
   .s02_axi_awready(s02_axi_awready),
   .s02_axi_wdata(s02_axi_wdata),
   .s02_axi_wuser(s02_axi_wuser),
   .s02_axi_wstrb(s02_axi_wstrb),
   .s02_axi_wvalid(s02_axi_wvalid),
   .s02_axi_wready(s02_axi_wready),
   .s02_axi_wlast(s02_axi_wlast),
   .s02_axi_bid(s02_axi_bid),
   .s02_axi_buser(s02_axi_buser),
   .s02_axi_bresp(s02_axi_bresp),
   .s02_axi_bvalid(s02_axi_bvalid),
   .s02_axi_bready(s02_axi_bready),
   .s02_axi_arid(s02_axi_arid),
   .s02_axi_araddr(s02_axi_araddr),
   .s02_axi_aruser(s02_axi_aruser),
   .s02_axi_arlen(s02_axi_arlen),
   .s02_axi_arsize(s02_axi_arsize),
   .s02_axi_arburst(s02_axi_arburst),
   .s02_axi_arlock(s02_axi_arlock),
   .s02_axi_arcache(s02_axi_arcache),
   .s02_axi_arprot(s02_axi_arprot),
   .s02_axi_arqos(s02_axi_arqos),
   .s02_axi_arvalid(s02_axi_arvalid),
   .s02_axi_arready(s02_axi_arready),
   .s02_axi_rdata(s02_axi_rdata),
   .s02_axi_rid(s02_axi_rid),
   .s02_axi_rresp(s02_axi_rresp),
   .s02_axi_rlast(s02_axi_rlast),
   .s02_axi_rvalid(s02_axi_rvalid),
   .s02_axi_ruser(s02_axi_ruser),
   .s02_axi_rready(s02_axi_rready),
   .m00_axi_awid(m00_axi_awid),
   .m00_axi_awaddr(m00_axi_awaddr),
   .m00_axi_awlen(m00_axi_awlen),
   .m00_axi_awsize(m00_axi_awsize),
   .m00_axi_awburst(m00_axi_awburst),
   .m00_axi_awlock(m00_axi_awlock),
   .m00_axi_awcache(m00_axi_awcache),
   .m00_axi_awprot(m00_axi_awprot),
   .m00_axi_awregion(m00_axi_awregion),
   .m00_axi_awqos(m00_axi_awqos),
   .m00_axi_awuser(m00_axi_awuser),
   .m00_axi_awvalid(m00_axi_awvalid),
   .m00_axi_awready(m00_axi_awready),
   .m00_axi_wdata(m00_axi_wdata),
   .m00_axi_wstrb(m00_axi_wstrb),
   .m00_axi_wuser(m00_axi_wuser),
   .m00_axi_wvalid(m00_axi_wvalid),
   .m00_axi_wready(m00_axi_wready),
   .m00_axi_wlast(m00_axi_wlast),
   .m00_axi_bid(m00_axi_bid),
   .m00_axi_buser(m00_axi_buser),
   .m00_axi_bresp(m00_axi_bresp),
   .m00_axi_bvalid(m00_axi_bvalid),
   .m00_axi_bready(m00_axi_bready),
   .m00_axi_araddr(m00_axi_araddr),
   .m00_axi_arid(m00_axi_arid),
   .m00_axi_arlen(m00_axi_arlen),
   .m00_axi_arsize(m00_axi_arsize),
   .m00_axi_arburst(m00_axi_arburst),
   .m00_axi_arlock(m00_axi_arlock),
   .m00_axi_arcache(m00_axi_arcache),
   .m00_axi_arprot(m00_axi_arprot),
   .m00_axi_arregion(m00_axi_arregion),
   .m00_axi_arqos(m00_axi_arqos),
   .m00_axi_aruser(m00_axi_aruser),
   .m00_axi_arvalid(m00_axi_arvalid),
   .m00_axi_arready(m00_axi_arready),
   .m00_axi_rdata(m00_axi_rdata),
   .m00_axi_rid(m00_axi_rid),
   .m00_axi_rresp(m00_axi_rresp),
   .m00_axi_rlast(m00_axi_rlast),
   .m00_axi_rvalid(m00_axi_rvalid),
   .m00_axi_ruser(m00_axi_ruser),
   .m00_axi_rready(m00_axi_rready),
   .m01_axi_awid(m01_axi_awid),
   .m01_axi_awaddr(m01_axi_awaddr),
   .m01_axi_awlen(m01_axi_awlen),
   .m01_axi_awsize(m01_axi_awsize),
   .m01_axi_awburst(m01_axi_awburst),
   .m01_axi_awlock(m01_axi_awlock),
   .m01_axi_awcache(m01_axi_awcache),
   .m01_axi_awprot(m01_axi_awprot),
   .m01_axi_awregion(m01_axi_awregion),
   .m01_axi_awqos(m01_axi_awqos),
   .m01_axi_awuser(m01_axi_awuser),
   .m01_axi_awvalid(m01_axi_awvalid),
   .m01_axi_awready(m01_axi_awready),
   .m01_axi_wdata(m01_axi_wdata),
   .m01_axi_wstrb(m01_axi_wstrb),
   .m01_axi_wuser(m01_axi_wuser),
   .m01_axi_wvalid(m01_axi_wvalid),
   .m01_axi_wready(m01_axi_wready),
   .m01_axi_wlast(m01_axi_wlast),
   .m01_axi_bid(m01_axi_bid),
   .m01_axi_buser(m01_axi_buser),
   .m01_axi_bresp(m01_axi_bresp),
   .m01_axi_bvalid(m01_axi_bvalid),
   .m01_axi_bready(m01_axi_bready),
   .m01_axi_araddr(m01_axi_araddr),
   .m01_axi_arid(m01_axi_arid),
   .m01_axi_arlen(m01_axi_arlen),
   .m01_axi_arsize(m01_axi_arsize),
   .m01_axi_arburst(m01_axi_arburst),
   .m01_axi_arlock(m01_axi_arlock),
   .m01_axi_arcache(m01_axi_arcache),
   .m01_axi_arprot(m01_axi_arprot),
   .m01_axi_arregion(m01_axi_arregion),
   .m01_axi_arqos(m01_axi_arqos),
   .m01_axi_aruser(m01_axi_aruser),
   .m01_axi_arvalid(m01_axi_arvalid),
   .m01_axi_arready(m01_axi_arready),
   .m01_axi_rdata(m01_axi_rdata),
   .m01_axi_rid(m01_axi_rid),
   .m01_axi_rresp(m01_axi_rresp),
   .m01_axi_rlast(m01_axi_rlast),
   .m01_axi_rvalid(m01_axi_rvalid),
   .m01_axi_ruser(m01_axi_ruser),
   .m01_axi_rready(m01_axi_rready),
   .m02_axi_awid(m02_axi_awid),
   .m02_axi_awaddr(m02_axi_awaddr),
   .m02_axi_awlen(m02_axi_awlen),
   .m02_axi_awsize(m02_axi_awsize),
   .m02_axi_awburst(m02_axi_awburst),
   .m02_axi_awlock(m02_axi_awlock),
   .m02_axi_awcache(m02_axi_awcache),
   .m02_axi_awprot(m02_axi_awprot),
   .m02_axi_awregion(m02_axi_awregion),
   .m02_axi_awqos(m02_axi_awqos),
   .m02_axi_awuser(m02_axi_awuser),
   .m02_axi_awvalid(m02_axi_awvalid),
   .m02_axi_awready(m02_axi_awready),
   .m02_axi_wdata(m02_axi_wdata),
   .m02_axi_wstrb(m02_axi_wstrb),
   .m02_axi_wuser(m02_axi_wuser),
   .m02_axi_wvalid(m02_axi_wvalid),
   .m02_axi_wready(m02_axi_wready),
   .m02_axi_wlast(m02_axi_wlast),
   .m02_axi_bid(m02_axi_bid),
   .m02_axi_buser(m02_axi_buser),
   .m02_axi_bresp(m02_axi_bresp),
   .m02_axi_bvalid(m02_axi_bvalid),
   .m02_axi_bready(m02_axi_bready),
   .m02_axi_araddr(m02_axi_araddr),
   .m02_axi_arid(m02_axi_arid),
   .m02_axi_arlen(m02_axi_arlen),
   .m02_axi_arsize(m02_axi_arsize),
   .m02_axi_arburst(m02_axi_arburst),
   .m02_axi_arlock(m02_axi_arlock),
   .m02_axi_arcache(m02_axi_arcache),
   .m02_axi_arprot(m02_axi_arprot),
   .m02_axi_arregion(m02_axi_arregion),
   .m02_axi_arqos(m02_axi_arqos),
   .m02_axi_aruser(m02_axi_aruser),
   .m02_axi_arvalid(m02_axi_arvalid),
   .m02_axi_arready(m02_axi_arready),
   .m02_axi_rdata(m02_axi_rdata),
   .m02_axi_rid(m02_axi_rid),
   .m02_axi_rresp(m02_axi_rresp),
   .m02_axi_rlast(m02_axi_rlast),
   .m02_axi_rvalid(m02_axi_rvalid),
   .m02_axi_ruser(m02_axi_ruser),
   .m02_axi_rready(m02_axi_rready),
   .m03_axi_awid(m03_axi_awid),
   .m03_axi_awaddr(m03_axi_awaddr),
   .m03_axi_awlen(m03_axi_awlen),
   .m03_axi_awsize(m03_axi_awsize),
   .m03_axi_awburst(m03_axi_awburst),
   .m03_axi_awlock(m03_axi_awlock),
   .m03_axi_awcache(m03_axi_awcache),
   .m03_axi_awprot(m03_axi_awprot),
   .m03_axi_awregion(m03_axi_awregion),
   .m03_axi_awqos(m03_axi_awqos),
   .m03_axi_awuser(m03_axi_awuser),
   .m03_axi_awvalid(m03_axi_awvalid),
   .m03_axi_awready(m03_axi_awready),
   .m03_axi_wdata(m03_axi_wdata),
   .m03_axi_wstrb(m03_axi_wstrb),
   .m03_axi_wuser(m03_axi_wuser),
   .m03_axi_wvalid(m03_axi_wvalid),
   .m03_axi_wready(m03_axi_wready),
   .m03_axi_wlast(m03_axi_wlast),
   .m03_axi_bid(m03_axi_bid),
   .m03_axi_buser(m03_axi_buser),
   .m03_axi_bresp(m03_axi_bresp),
   .m03_axi_bvalid(m03_axi_bvalid),
   .m03_axi_bready(m03_axi_bready),
   .m03_axi_araddr(m03_axi_araddr),
   .m03_axi_arid(m03_axi_arid),
   .m03_axi_arlen(m03_axi_arlen),
   .m03_axi_arsize(m03_axi_arsize),
   .m03_axi_arburst(m03_axi_arburst),
   .m03_axi_arlock(m03_axi_arlock),
   .m03_axi_arcache(m03_axi_arcache),
   .m03_axi_arprot(m03_axi_arprot),
   .m03_axi_arregion(m03_axi_arregion),
   .m03_axi_arqos(m03_axi_arqos),
   .m03_axi_aruser(m03_axi_aruser),
   .m03_axi_arvalid(m03_axi_arvalid),
   .m03_axi_arready(m03_axi_arready),
   .m03_axi_rdata(m03_axi_rdata),
   .m03_axi_rid(m03_axi_rid),
   .m03_axi_rresp(m03_axi_rresp),
   .m03_axi_rlast(m03_axi_rlast),
   .m03_axi_rvalid(m03_axi_rvalid),
   .m03_axi_ruser(m03_axi_ruser),
   .m03_axi_rready(m03_axi_rready)
);

/*######################################################*/
/*                      axi2apb_0                       */
/*                       (Vtool)                        */
/*######################################################*/

axi2apb_0_wrapper
#(
       .AXI_ID_length(),
       .AXI_addr_length(),
       .AXI_data_length(),
       .AXI_strb_length(),
       .APB_addr_length(),
       .APB_data_length(),
       .APB_strb_length(),
       .num_of_slaves()
)
axi2apb_0_wrapper_inst (
   .AWID(AWID),
   .AWADDR(AWADDR),
   .AWLEN(AWLEN),
   .AWSIZE(AWSIZE),
   .AWBURST(AWBURST),
   .AWVALID(AWVALID),
   .AWREADY(AWREADY),
   .WDATA(WDATA),
   .WSTRB(WSTRB),
   .WLAST(WLAST),
   .WVALID(WVALID),
   .WREADY(WREADY),
   .BID(BID),
   .BRESP(BRESP),
   .BVALID(BVALID),
   .BREADY(BREADY),
   .ARID(ARID),
   .ARADDR(ARADDR),
   .ARLEN(ARLEN),
   .ARSIZE(ARSIZE),
   .ARBURST(ARBURST),
   .ARVALID(ARVALID),
   .ARREADY(ARREADY),
   .RID(RID),
   .RDATA(RDATA),
   .RRESP(RRESP),
   .RLAST(RLAST),
   .RVALID(RVALID),
   .RREADY(RREADY),
   .s03_apb_PADDR(s03_apb_PADDR),
   .s03_apb_PSEL(s03_apb_PSEL),
   .s03_apb_PENABLE(s03_apb_PENABLE),
   .s03_apb_PWRITE(s03_apb_PWRITE),
   .s03_apb_PWDATA(s03_apb_PWDATA),
   .s03_apb_PREADY(s03_apb_PREADY),
   .s03_apb_PRDATA(s03_apb_PRDATA),
   .s03_apb_PSLVERR(s03_apb_PSLVERR),
   .s03_apb_PPROT(s03_apb_PPROT),
   .s03_apb_PSTRB(s03_apb_PSTRB),
   .s02_apb_PADDR(s02_apb_PADDR),
   .s02_apb_PSEL(s02_apb_PSEL),
   .s02_apb_PENABLE(s02_apb_PENABLE),
   .s02_apb_PWRITE(s02_apb_PWRITE),
   .s02_apb_PWDATA(s02_apb_PWDATA),
   .s02_apb_PREADY(s02_apb_PREADY),
   .s02_apb_PRDATA(s02_apb_PRDATA),
   .s02_apb_PSLVERR(s02_apb_PSLVERR),
   .s02_apb_PPROT(s02_apb_PPROT),
   .s02_apb_PSTRB(s02_apb_PSTRB),
   .s01_apb_PADDR(s01_apb_PADDR),
   .s01_apb_PPROT(s01_apb_PPROT),
   .s01_apb_PSTRB(s01_apb_PSTRB),
   .s01_apb_PSEL(s01_apb_PSEL),
   .s01_apb_PENABLE(s01_apb_PENABLE),
   .s01_apb_PWDATA(s01_apb_PWDATA),
   .s01_apb_PWRITE(s01_apb_PWRITE),
   .s01_apb_PRDATA(s01_apb_PRDATA),
   .s01_apb_PREADY(s01_apb_PREADY),
   .s01_apb_PSLVERR(s01_apb_PSLVERR),
   .s00_apb_PADDR(s00_apb_PADDR),
   .s00_apb_PPROT(s00_apb_PPROT),
   .s00_apb_PSTRB(s00_apb_PSTRB),
   .s00_apb_PSEL(s00_apb_PSEL),
   .s00_apb_PENABLE(s00_apb_PENABLE),
   .s00_apb_PWDATA(s00_apb_PWDATA),
   .s00_apb_PWRITE(s00_apb_PWRITE),
   .s00_apb_PRDATA(s00_apb_PRDATA),
   .s00_apb_PREADY(s00_apb_PREADY),
   .s00_apb_PSLVERR(s00_apb_PSLVERR),
   .clk(clk),
   .rst_n(rst_n),
   .PCLK(PCLK),
   .PRESETn(PRESETn)
);

/*######################################################*/
/*                      axi2apb_1                       */
/*                       (Vtool)                        */
/*######################################################*/

axi2apb_1_wrapper
#(
       .AXI_ID_length(),
       .AXI_addr_length(),
       .AXI_data_length(),
       .AXI_strb_length(),
       .APB_addr_length(),
       .APB_data_length(),
       .APB_strb_length(),
       .num_of_slaves()
)
axi2apb_1_wrapper_inst (
   .AWID(AWID),
   .AWADDR(AWADDR),
   .AWLEN(AWLEN),
   .AWSIZE(AWSIZE),
   .AWBURST(AWBURST),
   .AWVALID(AWVALID),
   .AWREADY(AWREADY),
   .WDATA(WDATA),
   .WSTRB(WSTRB),
   .WLAST(WLAST),
   .WVALID(WVALID),
   .WREADY(WREADY),
   .BID(BID),
   .BRESP(BRESP),
   .BVALID(BVALID),
   .BREADY(BREADY),
   .ARID(ARID),
   .ARADDR(ARADDR),
   .ARLEN(ARLEN),
   .ARSIZE(ARSIZE),
   .ARBURST(ARBURST),
   .ARVALID(ARVALID),
   .ARREADY(ARREADY),
   .RID(RID),
   .RDATA(RDATA),
   .RRESP(RRESP),
   .RLAST(RLAST),
   .RVALID(RVALID),
   .RREADY(RREADY),
   .s03_apb_PADDR(s03_apb_PADDR),
   .s03_apb_PSEL(s03_apb_PSEL),
   .s03_apb_PENABLE(s03_apb_PENABLE),
   .s03_apb_PWRITE(s03_apb_PWRITE),
   .s03_apb_PWDATA(s03_apb_PWDATA),
   .s03_apb_PREADY(s03_apb_PREADY),
   .s03_apb_PRDATA(s03_apb_PRDATA),
   .s03_apb_PSLVERR(s03_apb_PSLVERR),
   .s03_apb_PPROT(s03_apb_PPROT),
   .s03_apb_PSTRB(s03_apb_PSTRB),
   .s02_apb_PADDR(s02_apb_PADDR),
   .s02_apb_PSEL(s02_apb_PSEL),
   .s02_apb_PENABLE(s02_apb_PENABLE),
   .s02_apb_PWRITE(s02_apb_PWRITE),
   .s02_apb_PWDATA(s02_apb_PWDATA),
   .s02_apb_PREADY(s02_apb_PREADY),
   .s02_apb_PRDATA(s02_apb_PRDATA),
   .s02_apb_PSLVERR(s02_apb_PSLVERR),
   .s02_apb_PPROT(s02_apb_PPROT),
   .s02_apb_PSTRB(s02_apb_PSTRB),
   .s01_apb_PADDR(s01_apb_PADDR),
   .s01_apb_PPROT(s01_apb_PPROT),
   .s01_apb_PSTRB(s01_apb_PSTRB),
   .s01_apb_PSEL(s01_apb_PSEL),
   .s01_apb_PENABLE(s01_apb_PENABLE),
   .s01_apb_PWDATA(s01_apb_PWDATA),
   .s01_apb_PWRITE(s01_apb_PWRITE),
   .s01_apb_PRDATA(s01_apb_PRDATA),
   .s01_apb_PREADY(s01_apb_PREADY),
   .s01_apb_PSLVERR(s01_apb_PSLVERR),
   .s00_apb_PADDR(s00_apb_PADDR),
   .s00_apb_PPROT(s00_apb_PPROT),
   .s00_apb_PSTRB(s00_apb_PSTRB),
   .s00_apb_PSEL(s00_apb_PSEL),
   .s00_apb_PENABLE(s00_apb_PENABLE),
   .s00_apb_PWDATA(s00_apb_PWDATA),
   .s00_apb_PWRITE(s00_apb_PWRITE),
   .s00_apb_PRDATA(s00_apb_PRDATA),
   .s00_apb_PREADY(s00_apb_PREADY),
   .s00_apb_PSLVERR(s00_apb_PSLVERR),
   .clk(clk),
   .rst_n(rst_n),
   .PCLK(PCLK),
   .PRESETn(PRESETn)
);

/*######################################################*/
/*                         gpio                         */
/*                       (Vtool)                        */
/*######################################################*/

gpio_top
#(
       .NUM_OF_PINS(),
       .PDW(),
       .PAW()
)
gpio_top_inst (
   .clk_i(clk_i),
   .rst_n_i(rst_n_i),
   .paddr_i(paddr_i),
   .psel_i(psel_i),
   .penable_i(penable_i),
   .pwrite_i(pwrite_i),
   .pwdata_i(pwdata_i),
   .pstrb_i(pstrb_i),
   .pready_o(pready_o),
   .prdata_o(prdata_o),
   .pslverr_o(pslverr_o),
   .gpio_input_i(gpio_input_i),
   .gpio_output_o(gpio_output_o),
   .gpio_output_en_o(gpio_output_en_o),
   .irq_o(irq_o),
   .aux_out_i(aux_out_i),
   .GPIO(GPIO)
);

/*######################################################*/
/*                        timer                         */
/*                       (Vtool)                        */
/*######################################################*/

timer_top
timer_top_inst (
   .clk(clk),
   .rst_n(rst_n),
   .apb_paddr(apb_paddr),
   .apb_pstrb(apb_pstrb),
   .apb_psel(apb_psel),
   .apb_penable(apb_penable),
   .apb_pwdata(apb_pwdata),
   .apb_pwrite(apb_pwrite),
   .apb_prdata(apb_prdata),
   .apb_pready(apb_pready),
   .apb_pslverr(apb_pslverr),
   .ch0_timer_i(ch0_timer_i),
   .ch0_timer_o(ch0_timer_o),
   .ch1_timer_i(ch1_timer_i),
   .ch1_timer_o(ch1_timer_o),
   .timer_irq(timer_irq),
   .output_ctrl_u0((output_ctrl_u0(),
   .output_ctrl_u1((output_ctrl_u1()
);

/*######################################################*/
/*                         i2c                          */
/*                       (Vtool)                        */
/*######################################################*/

i2c_top
#(
       .I2C_EMPTY_FIFO_MODE(),
       .TX_FIFO_DEPTH(),
       .RX_FIFO_DEPTH()
)
i2c_top_inst (
   .clk(clk),
   .rstn(rstn),
   .pclk(pclk),
   .prstn(prstn),
   .paddr(paddr),
   .psel(psel),
   .penable(penable),
   .pwrite(pwrite),
   .pwdata(pwdata),
   .pstrb(pstrb),
   .pprot(pprot),
   .pready(pready),
   .prdata(prdata),
   .pslverr(pslverr),
   .scl_i(scl_i),
   .scl_o(scl_o),
   .scl_oe(scl_oe),
   .sda_i(sda_i),
   .sda_o(sda_o),
   .sda_oe(sda_oe),
   .irq(irq)
);

/*######################################################*/
/*                         spi                          */
/*                       (Vtool)                        */
/*######################################################*/

spi_top
#(
       .NR_OF_SLAVES(),
       .PAW(),
       .PDW(),
       .TXFIFOWIDTH(),
       .TXFIFOD(),
       .RXFIFOWIDTH(),
       .RXFIFOD(),
       .SPI_MASTER(),
       .SDW(),
       .XIPE(),
       .ID(),
       .declaration()
)
spi_top_inst (
   .pclk_i(pclk_i),
   .preset_n_i(preset_n_i),
   .paddr_i(paddr_i),
   .pprot_i(pprot_i),
   .psel_i(psel_i),
   .penable_i(penable_i),
   .pwrite_i(pwrite_i),
   .pwdata_i(pwdata_i),
   .pstrb_i(pstrb_i),
   .pready_o(pready_o),
   .prdata_o(prdata_o),
   .pslverr_o(pslverr_o),
   .spi_i(spi_i),
   .spi_o(spi_o),
   .eclk_i(eclk_i),
   .rst_n_i(rst_n_i),
   .scs_o(scs_o),
   .scs_i(scs_i),
   .sclk_o(sclk_o),
   .sclk_i(sclk_i),
   .xip_en_i(xip_en_i),
   .chip_sel_i(chip_sel_i),
   .tri_state_en_o(tri_state_en_o),
   .request(request)
);

/*######################################################*/
/*                       vt_uart                        */
/*                       (Vtool)                        */
/*######################################################*/

vt_uart_top
#(
       .FIFO_DEPTH(),
       .PAW(),
       .PDW(),
       .TWO_CLKS()
)
vt_uart_top_inst (
   .pclk_i(pclk_i),
   .sclk_i(sclk_i),
   .presetn_i(presetn_i),
   .rst_n_i(rst_n_i),
   .paddr_i(paddr_i),
   .pprot_i(pprot_i),
   .psel_i(psel_i),
   .penable_i(penable_i),
   .pwrite_i(pwrite_i),
   .pwdata_i(pwdata_i),
   .pstrb_i(pstrb_i),
   .pready_o(pready_o),
   .prdata_o(prdata_o),
   .pslverr_o(pslverr_o),
   .cts_n_i(cts_n_i),
   .dsr_n_i(dsr_n_i),
   .dcd_n_i(dcd_n_i),
   .ri_n_i(ri_n_i),
   .dtr_n_o(dtr_n_o),
   .rts_n_o(rts_n_o),
   .tx_o(tx_o),
   .rx_i(rx_i),
   .intr_o(intr_o)
);

/*######################################################*/
/*                        blink                         */
/*                       (Vtool)                        */
/*######################################################*/

blink
blink_inst (
   .clk(clk),
   .rstn(rstn),
   .led(led)
);


