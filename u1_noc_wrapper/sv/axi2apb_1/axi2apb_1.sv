// ########################################################################
// Module name     : axi2apb_1
// Description     : AXI to APB top level module
// Author          : Mladen Sokic
// Created On      : 05.01.2023.
// Modified By:________
// Modified On:________
// Modification Description : 
// Version         : 0.1
// ------------------------------------------
module axi2apb_1 #(
  parameter   AXI_ID_length = 4,
  parameter   AXI_data_length = 128,
  parameter   AXI_strb_length = AXI_data_length / 8,
  parameter   APB_data_length = 16,
  parameter   APB_strb_length = APB_data_length / 8,
  parameter   AXI_user_length = 3,
  parameter   num_of_slaves = 3
)
(
  // global signals
  
  input                       ACLK,
  input                       ARESETn,
  
  // AXI interface signals (write address channel signals)
  
  input   [   AXI_ID_length - 1 : 0]  AWID,
  input   [                  31 : 0]  AWADDR,
  input   [                   7 : 0]  AWLEN,
  input   [                   2 : 0]  AWSIZE,
  input   [                   1 : 0]  AWBURST,
  input   [                   1 : 0]  AWLOCK,
  input   [                   3 : 0]  AWCACHE,
  input   [                   2 : 0]  AWPROT,
  input   [                   3 : 0]  AWQOS,
  input   [                   3 : 0]  AWREGION,
  input   [ AXI_user_length - 1 : 0]  AWUSER,
  input                               AWVALID,
  output                              AWREADY,
  
  // AXI interface signals (write interface signals)
  
  input   [ AXI_data_length - 1 : 0]  WDATA,
  input   [ AXI_strb_length - 1 : 0]  WSTRB,
  input                               WLAST,
  input   [ AXI_user_length - 1 : 0]  WUSER,
  input                               WVALID,
  output                              WREADY,
  
  // AXI interface signals (write response channel signals)
  
  output  [   AXI_ID_length - 1 : 0]  BID,
  output  [                   1 : 0]  BRESP,
  output  [ AXI_user_length - 1 : 0]  BUSER,
  output                              BVALID,
  input                               BREADY,
  
  // AXI interface signals (read address channel signals)
  
  input   [   AXI_ID_length - 1 : 0]  ARID,
  input   [                  31 : 0]  ARADDR,
  input   [                   7 : 0]  ARLEN,
  input   [                   2 : 0]  ARSIZE,
  input   [                   1 : 0]  ARBURST,
  input   [                   1 : 0]  ARLOCK,
  input   [                   3 : 0]  ARCACHE,
  input   [                   2 : 0]  ARPROT,
  input   [                   3 : 0]  ARQOS,
  input   [                   3 : 0]  ARREGION,
  input   [ AXI_user_length - 1 : 0]  ARUSER,
  input                               ARVALID,
  output                              ARREADY,
  
  // AXI interface signals (read data channel signals)
  
  output  [   AXI_ID_length - 1 : 0]  RID,
  output  [ AXI_data_length - 1 : 0]  RDATA,
  output  [                   1 : 0]  RRESP,
  output                              RLAST,
  output  [ AXI_user_length - 1 : 0]  RUSER,
  output                              RVALID,
  input                               RREADY,
  
  // APB global signals
  
  input                               PCLK,
  input                               PRESETn,
  
  // APB interface signals
  
  output  [                  31 : 0]  PADDR    [num_of_slaves - 1 : 0],
  output  [                   2 : 0]  PPROT    [num_of_slaves - 1 : 0],
  output  [ APB_strb_length - 1 : 0]  PSTRB    [num_of_slaves - 1 : 0],
  output                              PSEL     [num_of_slaves - 1 : 0],
  output                              PENABLE  [num_of_slaves - 1 : 0],
  output  [ APB_data_length - 1 : 0]  PWDATA   [num_of_slaves - 1 : 0],
  output                              PWRITE   [num_of_slaves - 1 : 0],
  input   [ APB_data_length - 1 : 0]  PRDATA   [num_of_slaves - 1 : 0],
  input                               PREADY   [num_of_slaves - 1 : 0],
  input                               PSLVERR  [num_of_slaves - 1 : 0]
);

  localparam  write_data_width = APB_data_length + APB_strb_length + 33;

  genvar  i;

//write

  wire  [AXI_ID_length + APB_data_length + APB_strb_length + 33 : 0]  fsm_data_wr;
  wire                                               fsm_valid_wr;
  wire                                               fsm_ready_wr;
  
  wire  [AXI_ID_length + APB_data_length + APB_strb_length + 33 : 0]  mux_data_wr   [num_of_slaves : 0];
  wire  [                                     0 : 0]  mux_valid_wr  [num_of_slaves : 0];
  wire  [                                     0 : 0]  mux_ready_wr  [num_of_slaves : 0];
  
  wire  [AXI_ID_length + APB_data_length + APB_strb_length + 33 : 0]  fifo_data_wr  [num_of_slaves : 0];
  wire  [                     num_of_slaves : 0]  fifo_valid_wr;
  wire  [                     num_of_slaves : 0]  fifo_ready_wr;
  
  wire  [      AXI_ID_length : 0]  b_data_out [num_of_slaves : 0];

  
//read

  wire   [   AXI_ID_length + 41 : 0]  fsm_data_rd;
  wire                                fsm_valid_rd;
  wire                                fsm_ready_rd;
  
  wire   [   AXI_ID_length + 41 : 0]  mux_data_rd    [num_of_slaves : 0];
  wire   [                    0 : 0]  mux_valid_rd   [num_of_slaves : 0];
  wire   [                    0 : 0]  mux_ready_rd   [num_of_slaves : 0];
  wire   [                    0 : 0]  mux_ready_rd_n [num_of_slaves : 0];
  
  wire   [   AXI_ID_length + 41 : 0]  fifo_data_rd  [num_of_slaves : 0];
  wire   [    num_of_slaves : 0]  fifo_valid_rd;
  wire   [    num_of_slaves : 0]  fifo_ready_rd;
  
  wire   [    num_of_slaves : 0]  fifo_valid_rd_n;
  
//resp

  wire  [ AXI_ID_length + AXI_data_length + 1 : 0]  fsm_data_resp [    num_of_slaves : 0];
  wire  [    num_of_slaves : 0]   fsm_valid_resp;
  wire  [    num_of_slaves : 0]   fsm_ready_resp;
  wire  [    num_of_slaves : 0]   mux_valid_resp_n;
  
  wire  [ AXI_ID_length + APB_data_length + 41 : 0]  mux_data_resp [    num_of_slaves : 0];
  wire  [    num_of_slaves : 0]   mux_valid_resp;
  wire  [    num_of_slaves : 0]   mux_ready_resp;
  wire  [    num_of_slaves : 0]   arb_ready_resp_n;
  
  wire  [    num_of_slaves : 0]   arb_ready_resp_n_sel;
  
  wire  [AXI_ID_length + APB_data_length + 41 : 0]  arb_data_resp   [num_of_slaves : 0];
  wire  [     num_of_slaves : 0]  arb_valid_resp;
  wire  [     num_of_slaves : 0]  arb_ready_resp;
  
  wire  [         AXI_ID_length : 0]  arb_data_resp_wr   [num_of_slaves : 0];
  wire  [     num_of_slaves : 0]  arb_valid_resp_wr;
  wire  [     num_of_slaves : 0]  arb_ready_resp_wr;
  wire  [     num_of_slaves : 0]  arb_ready_resp_wr_n;
  
  wire  [     num_of_slaves : 0]  arb_ready_resp_wr_n_sel;
  
  wire  [         AXI_ID_length : 0]  arb_data_resp_wr_0   [num_of_slaves : 0];
  wire  [     num_of_slaves : 0]  arb_valid_resp_wr_0;
  wire  [     num_of_slaves : 0]  arb_ready_resp_wr_0;
  wire  [     num_of_slaves : 0]  arb_valid_resp_wr_0_n;

  wire                            we_write_addr;
  wire  [AXI_ID_length + 44 : 0]  data_in_write_addr;
  wire                            full_write_addr;


  wire                            re_write_addr;
  wire  [AXI_ID_length + 44 : 0]  data_out_write_addr;
  wire                            empty_write_addr;

  wire                            empty_write_addr_n;

  wire                            we_read_addr;
  wire  [AXI_ID_length + 44 : 0]  data_in_read_addr;
  wire                            full_read_addr;

  wire                            re_read_addr;
  wire  [AXI_ID_length + 44 : 0]  data_out_read_addr;
  wire                            empty_read_addr;

  wire                            empty_read_addr_n;

  wire  [     AXI_ID_length - 1 : 0]  arb_ID          [num_of_slaves : 0];
  wire  [                     0 : 0]  arb_LAST        [num_of_slaves : 0];
  
  wire  [     num_of_slaves - 1 : 0]  slave_select_wr;
  wire  [     num_of_slaves - 1 : 0]  slave_select_rd;
  
  wire  [AXI_ID_length + APB_data_length + APB_strb_length + 33 : 0] W_DATA_w  [num_of_slaves : 0];
  wire  [                    AXI_ID_length + 41 : 0] R_DATA_w  [num_of_slaves : 0];
  wire                                               W_VALID_w [num_of_slaves : 0];
  wire                                               R_VALID_w [num_of_slaves : 0];
  wire                                               W_READY_w [num_of_slaves : 0];
  wire                                               R_READY_w [num_of_slaves : 0];
  
  wire  [  AXI_ID_length + AXI_data_length + 1 : 0] RDATA_w;
  
  wire  [ APB_strb_length - 1 : 0]  PSTRB_w  [num_of_slaves : 0];
  
  wire  [   num_of_slaves : 0]  fifo_valid_wr_n;
  
  wire    [                0 : 0]  mux_ready_wr_n  [num_of_slaves : 0];
  
  wire    [num_of_slaves : 0]  err_wire; 
  
  wire    [num_of_slaves : 0]  PSEL_w; 
  
  wire    [num_of_slaves : 0]  PENABLE_w;
  
  wire    [num_of_slaves : 0]  PREADY_w;
  
  wire    [    AXI_ID_length : 0]  BDATA_w;
  
  wire    [                7 : 0]  transfer_size  [num_of_slaves : 0];
  
  wire    [                7 : 0]   transfer_size_we [num_of_slaves : 0];  
  
  wire    [                7 : 0]   transfer_size_we_out [num_of_slaves : 0]; 

  wire  [                  31 : 0]  PADDR_wire    [num_of_slaves : 0];
  wire  [                   2 : 0]  PPROT_wire    [num_of_slaves : 0];
  wire  [ APB_strb_length - 1 : 0]  PSTRB_wire    [num_of_slaves : 0];
  wire                              PSEL_wire     [num_of_slaves : 0];
  wire                              PENABLE_wire  [num_of_slaves : 0];
  wire  [ APB_data_length - 1 : 0]  PWDATA_wire   [num_of_slaves : 0];
  wire                              PWRITE_wire   [num_of_slaves : 0];
  wire  [ APB_data_length - 1 : 0]  PRDATA_wire   [num_of_slaves : 0];
  wire                              PREADY_wire   [num_of_slaves : 0];
  wire                              PSLVERR_wire  [num_of_slaves : 0];

  wire  [                  31 : 0]  PADDR_out     [num_of_slaves : 0];
  wire  [                   2 : 0]  PPROT_out     [num_of_slaves : 0];
  wire  [ APB_strb_length - 1 : 0]  PSTRB_out     [num_of_slaves : 0];
  wire                              PSEL_out      [num_of_slaves : 0];
  wire                              PENABLE_out   [num_of_slaves : 0];
  wire  [ APB_data_length - 1 : 0]  PWDATA_out    [num_of_slaves : 0];
  wire                              PWRITE_out    [num_of_slaves : 0];
  wire  [ APB_data_length - 1 : 0]  PRDATA_out    [num_of_slaves : 0];
  wire                              PREADY_out    [num_of_slaves : 0];
  wire                              PSLVERR_out   [num_of_slaves : 0];

  wire  [       num_of_slaves : 0]  PSLVERR_out_for_use;

  wire  [                  31 : 0]  alligned_addr_wr;
  wire  [                  31 : 0]  alligned_addr_rd;

  assign  we_write_addr = AWVALID;
  assign  AWREADY = ~full_write_addr;
  assign  data_in_write_addr = {AWID, AWADDR, AWLEN, AWSIZE, AWBURST};
  
  assign  we_read_addr = ARVALID;
  assign  ARREADY = ~full_read_addr;
  assign  data_in_read_addr  = {ARID, ARADDR, ARLEN, ARSIZE, ARBURST};

  assign  empty_write_addr_n = ~empty_write_addr;
  assign  empty_read_addr_n = ~empty_read_addr;

sync_fifo 
#(
    .DEPTH(16),
    .DATA_WIDTH(AXI_ID_length + 45)
)
sync_fifo_0 
(
    .clk(ACLK),
    .reset_n(ARESETn),
    .wr_enable(we_write_addr & ~full_write_addr),        
    .rd_enable(re_write_addr & ~empty_write_addr),
    .data_in(data_in_write_addr),
    
    .data_out(data_out_write_addr),
    .full(full_write_addr),
    .empty(empty_write_addr)
);

sync_fifo 
#(
    .DEPTH(16),
    .DATA_WIDTH(AXI_ID_length + 45)
)
sync_fifo_1 
(
    .clk(ACLK),
    .reset_n(ARESETn),
    .wr_enable(we_read_addr & ~full_read_addr),        
    .rd_enable(re_read_addr & ~empty_read_addr),
    .data_in(data_in_read_addr),
    
    .data_out(data_out_read_addr),
    .full(full_read_addr),
    .empty(empty_read_addr)
);
  
  assign  alligned_addr_wr = data_out_write_addr[44 : 13] & {32{1'b1}} << data_out_write_addr[4 : 2];
  
write_fsm #(

  .AXI_ID_length(AXI_ID_length),
  .AXI_data_length(AXI_data_length),
  .AXI_strb_length(AXI_strb_length),
  .APB_data_length(APB_data_length),
  .APB_byte_width(APB_strb_length)

)
write_fsm_0
(
  // global signals
  
  .ACLK(ACLK),
  .ARESETn(ARESETn),
  
  // AXI interface signals (write address channel signals)
  
  .AWID(data_out_write_addr[44 + AXI_ID_length : 45]),
  //.AWADDR(data_out_write_addr[44 : 13]),
  .AWADDR(alligned_addr_wr),
  .AWLEN(data_out_write_addr[12 : 5]),
  .AWSIZE(data_out_write_addr[4 : 2]),
  .AWBURST(data_out_write_addr[1 : 0]),
  .AWVALID(empty_write_addr_n),
  .AWREADY(re_write_addr),
  
  // AXI interface signals (write interface signals)
  
  .WDATA(WDATA),
  .WSTRB(WSTRB),
  .WLAST(WLAST),
  .WVALID(WVALID),
  .WREADY(WREADY),
  
  // AXI interface signals (write response channel signals)
  
  .DATA_OUT(fsm_data_wr),
  .VALID(fsm_valid_wr),
  .READY(fsm_ready_wr)
  
);

  assign  alligned_addr_rd = data_out_read_addr[44 : 13] & {32{1'b1}} << data_out_read_addr[4 : 2];

read_fsm #(

  .AXI_ID_length(AXI_ID_length),
  .AXI_data_length(AXI_data_length),
  .APB_data_length(APB_data_length),
  .APB_byte_width(APB_strb_length)

)
read_fsm_0
(
  // global signals
  
  .ACLK(ACLK),
  .ARESETn(ARESETn),
  
  // AXI interface signals (read address channel signals)

  .ARID(data_out_read_addr[AXI_ID_length + 44 : 45]),
  //.ARADDR(data_out_read_addr[44 : 13]),
  .ARADDR(alligned_addr_rd),
  .ARLEN(data_out_read_addr[12 : 5]),
  .ARSIZE(data_out_read_addr[4 : 2]),
  .ARBURST(data_out_read_addr[1 : 0]),
  .ARVALID(empty_read_addr_n),
  .ARREADY(re_read_addr),
  
  .DATA_OUT(fsm_data_rd),
  .VALID(fsm_valid_rd),
  .READY(fsm_ready_rd)
  
);

mux_demux_read_request_path #(
  .datawidth(AXI_ID_length + 42),
  .num_of_slaves(num_of_slaves)
)
mux_demux_read_request_path_0
(
  .select(slave_select_rd),
  .f_data_in(fsm_data_rd),
  .valid_in(fsm_valid_rd),
  .ready_in(fsm_ready_rd),
  .f_data_out(mux_data_rd),
  .valid_out(mux_valid_rd),
  .ready_out(mux_ready_rd)
);

apb_addr_dec_1 apb_addr_dec_1_wr
    (
        .master_id(1'b0),
        .addr(fsm_data_wr[APB_data_length + APB_strb_length + 33 -: 32]),
        .ss(slave_select_wr)
    );
    
apb_addr_dec_1 apb_addr_dec_1_rd
    (
        .master_id(1'b0),
        .addr(fsm_data_rd[33 : 2]),
        .ss(slave_select_rd)
    );
    
mux_demux_write_request_path #(
  .datawidth(AXI_ID_length + APB_data_length + APB_strb_length + 34),
  .num_of_slaves(num_of_slaves)
)
mux_demux_write_request_path_0
(
  .select(slave_select_wr),
  .f_data_in(fsm_data_wr),
  .valid_in(fsm_valid_wr),
  .ready_in(fsm_ready_wr),
  .f_data_out(mux_data_wr),
  .valid_out(mux_valid_wr),
  .ready_out(mux_ready_wr)
);

generate
  for (i = 0; i < num_of_slaves + 1; i = i + 1)
  begin : gen_0

//sync_fifo 
//#(
    //.DEPTH(32),
    //.DATA_WIDTH(AXI_ID_length + APB_data_length + APB_strb_length + 34)
//) 
//sync_fifo_0_i
//
     //.clk(ACLK),
    //.reset_n(ARESETn),
    //.wr_enable(mux_valid_wr[i][0]),        
    //.rd_enable(fifo_ready_wr[i]),
    //.data_in(mux_data_wr[i]),
    
    //.data_out(fifo_data_wr[i]),
    //.full(mux_ready_wr_n[i][0]),
    //.empty(fifo_valid_wr_n[i])
//);

async_fifo #
(
    .DATA_WIDTH(AXI_ID_length + APB_data_length + APB_strb_length + 34),
    .DEPTH(32)
)
async_fifo_0
(
    .wr_clk(ACLK),
    .wr_rst_n(ARESETn),
    .wr_en(mux_valid_wr[i][0] & ~mux_ready_wr_n[i][0]),
    .wr_data(mux_data_wr[i]),
    .a_full(mux_ready_wr_n[i][0]),
    //.full(full_1_wr[i]),

    .rd_clk(PCLK),
    .rd_rst_n(PRESETn),
    .rd_en(fifo_ready_wr[i] & ~fifo_valid_wr_n[i]),
    .rd_data(fifo_data_wr[i]),
    .empty(fifo_valid_wr_n[i])
);
    
    set_reset_write_err
    #(
      .AXI_ID_length(AXI_ID_length)
    )
    set_rst_i
    (
      .clk(PCLK),
      .rst_n(PRESETn),
      .set(PWRITE_wire[i] & PSLVERR_wire[i] & PREADY_wire[i]),
      .reset(arb_valid_resp_wr[i] & arb_ready_resp_wr[i]),
      .out(err_wire[i])
    );
    
read_response_fsm #(
    .AXI_ID_length(AXI_ID_length),
    .AXI_data_length(AXI_data_length),
    .APB_data_length(APB_data_length)
    )
rd_fsm_i
    (
    .PCLK(ACLK),
    .PRESETn(ARESETn),
  
    .data_in(mux_data_resp[i]),
    .valid_in(mux_valid_resp[i]),
    .ready_in(mux_ready_resp[i]),
    .data_out(fsm_data_resp[i]),
    .valid_out(fsm_valid_resp[i]),
    .ready_out(fsm_ready_resp[i]),
  
    .transfer_ref(transfer_size_we_out[i])
);

//sync_fifo 
//#(
    //.DEPTH(32),
    //.DATA_WIDTH(AXI_ID_length + APB_data_length + 10)
//) 
//sync_fifo_1_i
//(
    //.clk(ACLK),
    //.reset_n(ARESETn),
    //.wr_enable(arb_valid_resp[i]),        
    //.rd_enable(mux_ready_resp[i]),
    //.data_in(arb_data_resp[i]),
    
    //.data_out(mux_data_resp[i]),
    //.full(arb_ready_resp_n[i]),
    //.empty(mux_valid_resp_n[i])
//);

async_fifo_wrapper #
(
    .DATA_WIDTH(AXI_ID_length + APB_data_length + 42),
    .DEPTH(32)
)
async_fifo_wrapper_1_i
(
    .wr_clk(PCLK),
    .wr_rst_n(PRESETn),
    .wr_en(arb_valid_resp[i] & ~arb_ready_resp_n[i]),
    .wr_data(arb_data_resp[i]),
    .full(arb_ready_resp_n[i]),
    .full_sel(arb_ready_resp_n_sel[i]),

    .rd_clk(ACLK),
    .rd_rst_n(ARESETn),
    .rd_en(mux_ready_resp[i] & ~mux_valid_resp_n[i]),
    .rd_data(mux_data_resp[i]),
    .empty(mux_valid_resp_n[i])
);

we_reg we_reg_i
(
  .clk(ACLK),
  .rst_n(ARESETn),
  
  .clear(fsm_data_resp[i][0] & fsm_valid_resp[i] & fsm_ready_resp[i]),
  .we(mux_valid_resp[i] & mux_ready_resp[i]),
  .data_in(transfer_size_we[i]),
  .data_out(transfer_size_we_out[i])
);
    assign transfer_size_we[i] = mux_data_resp[i][AXI_ID_length + APB_data_length + 8 : AXI_ID_length + APB_data_length + 1];

    assign arb_ready_resp[i] = ~arb_ready_resp_n[i];
    assign mux_valid_resp[i] = ~mux_valid_resp_n[i];

    assign mux_ready_wr[i][0] = ~mux_ready_wr_n[i][0];
    assign fifo_valid_wr[i] = ~fifo_valid_wr_n[i];

    assign BUSER = {AXI_user_length{1'b0}};
    assign RUSER = {AXI_user_length{1'b0}};


round_robin_arbiter_wrapper
#
(
  .AXI_ID_length(AXI_ID_length),
  .AXI_data_length(AXI_data_length),
  .AXI_strb_length(AXI_strb_length),
  .APB_data_length(APB_data_length),
  .APB_byte_width(APB_strb_length)
)
round_robin_arbiter_wrapper_i
(
  .clk(PCLK),
  .rst_n(PRESETn),
  .data_wr_in(fifo_data_wr[i]),
  .data_rd_in(fifo_data_rd[i]),
  .valid_wr_in(fifo_valid_wr[i]),
  .ready_wr_in(fifo_ready_wr[i]),
  .valid_rd_in(fifo_valid_rd[i]),
  .ready_rd_in(fifo_ready_rd[i]),

  .data_wr_out(W_DATA_w[i]),
  .data_rd_out(R_DATA_w[i]),
  .valid_wr_out(W_VALID_w[i]),
  .ready_wr_out(W_READY_w[i]),
  .valid_rd_out(R_VALID_w[i]),
  .ready_rd_out(R_READY_w[i])
);

arb2apb
#
(
  .AXI_ID_length(AXI_ID_length),
  .AXI_data_length(AXI_data_length),
  .AXI_strb_length(AXI_strb_length),
  .APB_data_length(APB_data_length),
  .APB_byte_width(APB_strb_length)
)
arb2apb_i
(
  .clk(PCLK),
  .rst_n(PRESETn),
  .data_wr_in(W_DATA_w[i]),
  .data_rd_in(R_DATA_w[i]),
  .valid_wr(W_VALID_w[i]),
  .ready_wr(W_READY_w[i]),
  .valid_rd(R_VALID_w[i]),
  .ready_rd(R_READY_w[i]),

  .ID(arb_ID[i]),
  .LAST(arb_LAST[i][0]),

  .PADDR(PADDR_wire[i]),
  .PPROT(PPROT_wire[i]),
  .PSTRB(PSTRB_wire[i]),
  .PSEL(PSEL_wire[i]),
  .PENABLE(PENABLE_wire[i]),
  .PWDATA(PWDATA_wire[i]),
  .PWRITE(PWRITE_wire[i]),
  .PRDATA(PRDATA_wire[i]),
  .PREADY(PREADY_wire[i]),
  .PSLVERR(PSLVERR_wire[i]),
  .transfer_size(transfer_size[i])
);

//sync_fifo 
//#(
    //.DEPTH(32),
    //.DATA_WIDTH(AXI_ID_length + 42)
//) 
//sync_fifo_143_i
//(
    //.clk(ACLK),
    //.reset_n(ARESETn),
    //.wr_enable(mux_valid_rd[i][0]),        
    //.rd_enable(fifo_ready_rd[i]),
    //.data_in(mux_data_rd[i]),
    
    //.data_out(fifo_data_rd[i]),
    //.full(mux_ready_rd_n[i][0]),
    //.empty(fifo_valid_rd_n[i])
//);

async_fifo #
(
    .DATA_WIDTH(AXI_ID_length + 42),
    .DEPTH(32)
)
async_fifo_1
(
    .wr_clk(ACLK),
    .wr_rst_n(ARESETn),
    .wr_en(mux_valid_rd[i][0] & ~mux_ready_rd_n[i][0]),
    .wr_data(mux_data_rd[i]),
    .a_full(mux_ready_rd_n[i][0]),
    //.full(full_1_rd[i]),

    .rd_clk(PCLK),
    .rd_rst_n(PRESETn),
    .rd_en(fifo_ready_rd[i] & ~fifo_valid_rd_n[i]),
    .rd_data(fifo_data_rd[i]),
    .empty(fifo_valid_rd_n[i])
);

//assign mux_ready_rd_n[i][0] = full_0_rd[i] | full_1_rd[i];

//sync_fifo 
//#(
    //.DEPTH(32),
    //.DATA_WIDTH(AXI_ID_length+1)
//) 
//sync_fifo_2_i
//(
    //.clk(PCLK),
    //.reset_n(ARESETn),
    //.wr_enable(arb_valid_resp_wr[i]),        
    //.rd_enable(arb_ready_resp_wr_0[i]),
    //.data_in(arb_data_resp_wr[i]),
    
    //.data_out(arb_data_resp_wr_0[i]),
    //.full(arb_ready_resp_wr_n[i]),
    //.empty(arb_valid_resp_wr_0_n[i])
//);

async_fifo_wrapper #
(
    .DATA_WIDTH(AXI_ID_length + 1),
    .DEPTH(32)
)
async_fifo_wrapper_2_i
(
    .wr_clk(PCLK),
    .wr_rst_n(PRESETn),
    .wr_en(arb_valid_resp_wr[i] & ~arb_ready_resp_wr_n[i]),
    .wr_data(arb_data_resp_wr[i]),
    .full(arb_ready_resp_wr_n[i]),
    .full_sel(arb_ready_resp_wr_n_sel[i]),

    .rd_clk(ACLK),
    .rd_rst_n(ARESETn),
    .rd_en(arb_ready_resp_wr_0[i] & ~arb_valid_resp_wr_0_n[i]),
    .rd_data(arb_data_resp_wr_0[i]),
    .empty(arb_valid_resp_wr_0_n[i])
);


assign arb_valid_resp_wr_0[i] = ~arb_valid_resp_wr_0_n[i];

assign arb_ready_resp_wr[i] = ~arb_ready_resp_wr_n[i];

assign b_data_out[i] = {arb_ID[i],err_wire[i]};

assign fifo_valid_rd[i] = ~fifo_valid_rd_n[i];
assign mux_ready_rd[i][0] = ~mux_ready_rd_n[i][0];

assign arb_valid_resp[i] = PWRITE_out[i] ? 1'b0 : (PENABLE_w[i] & PREADY_out[i]);
assign arb_valid_resp_wr[i] = PWRITE_out[i] ? (PENABLE_w[i] & arb_LAST[i][0] & PREADY_out[i]) : 1'b0;

assign PSTRB_out[i] = PWRITE_out[i] ? PSTRB_w[i] : {APB_strb_length{1'b0}};

assign PREADY_w[i] = PWRITE_out[i] ? (arb_LAST[i][0] ? (PREADY_out[i] & arb_ready_resp_wr[i]) : PREADY_out[i]) : (PREADY_out[i] & arb_ready_resp[i]);

assign PENABLE_out[i] = PWRITE_out[i] ?  (arb_LAST[i][0] ? (PENABLE_w[i] & arb_ready_resp_wr[i]) : PENABLE_w[i]) : (PENABLE_w[i] & arb_ready_resp[i]);

assign PSEL_out[i] = PWRITE_out[i] ?  (arb_LAST[i][0] ? (PSEL_w[i] & ~arb_ready_resp_wr_n_sel[i]) : PSEL_w[i]) : (PSEL_w[i] & ~arb_ready_resp_n_sel[i]);

assign PSLVERR_out_for_use[i] = PSLVERR_out[i];

assign arb_data_resp[i] = {PADDR_out[i], PSLVERR_out[i], transfer_size[i], arb_ID[i], PRDATA_out[i], arb_LAST[i][0]};
assign arb_data_resp_wr[i] = {arb_ID[i],(err_wire[i] | PSLVERR_out_for_use[i])};
//assign arb_data_resp_wr[i] = {arb_ID[i],err_wire[i]} | {arb_ID[i],PSLVERR_out[i]};


assign PADDR_out[i]  = PADDR_wire[i] - PADDR_wire[i] % APB_strb_length;
assign PPROT_out[i]  = PPROT_wire[i];
assign PSTRB_w[i]  = PSTRB_wire[i];
assign PSEL_w[i]  = PSEL_wire[i];
assign PENABLE_w[i]  = PENABLE_wire[i];
assign PWDATA_out[i]  = PWDATA_wire[i];
assign PWRITE_out[i]  = PWRITE_wire[i];
assign PRDATA_wire[i]  = PRDATA_out[i];
assign PREADY_wire[i]  = PREADY_w[i];
assign PSLVERR_wire[i]  = PSLVERR_out[i];


//assign arb_ready_resp_wr[i] = 1'b1;
end
endgenerate

genvar j;
generate
for (j = 0; j < num_of_slaves; j = j + 1)
begin : hddhdxthtdz

assign PADDR[j]  = PADDR_out[j + 1];
assign PPROT[j]  = PPROT_out[j + 1];
assign PSTRB[j]  = PSTRB_out[j + 1];
assign PSEL[j]  = PSEL_out[j + 1];
assign PENABLE[j]  = PENABLE_out[j + 1];
assign PWDATA[j]  = PWDATA_out[j + 1];
assign PWRITE[j]  = PWRITE_out[j + 1];
assign PRDATA_out[j + 1]  = PRDATA[j];
assign PREADY_out[j + 1]  = PREADY[j];
assign PSLVERR_out[j + 1]  = PSLVERR[j];

end
endgenerate

parametrized_round_robin_arbiter_wrapper
#
(
  .datawidth(AXI_ID_length + AXI_data_length + 2),
  .num_of_slaves(num_of_slaves + 1)
)
parametrized_rr_1
(
  .clk(ACLK),
  .rst_n(ARESETn),
  .data_in(fsm_data_resp),
  .valid_in(fsm_valid_resp),
  .ready_in(fsm_ready_resp),

  .data_out(RDATA_w),
  .valid_out(RVALID),
  .ready_out(RREADY)
);

parametrized_round_robin_arbiter_wrapper
#
(
  .datawidth(AXI_ID_length + 1),
  .num_of_slaves(num_of_slaves + 1)
)
parametrized_rr_1543
(
  .clk(ACLK),
  .rst_n(ARESETn),
  .data_in(arb_data_resp_wr_0),
  .valid_in(arb_valid_resp_wr_0),
  .ready_in(arb_ready_resp_wr_0),

  .data_out(BDATA_w),
  .valid_out(BVALID),
  .ready_out(BREADY)
);

apb_error_slave err_sl (
  // global signals
  
  .clk(PCLK),
  .rst_n(PRESETn),
  
  // AXI interface signals (read address channel signals)

  .PREADY(PREADY_out[0]),
  .PSLVERR(PSLVERR_out[0]),
  .PENABLE(PENABLE_out[0])
  
);

//assign b_ready_in = ~b_ready_in_n;
assign BID = BDATA_w[AXI_ID_length : 1];
assign BRESP = BDATA_w[0] == 1'b1 ? 2'b10 : 2'b00;

//assign arb_ready_in = ~arb_ready_in_n;
//assign BVALID = ~BVALID_n;

//assign BVALID = 1'b0;

assign RDATA = RDATA_w[AXI_data_length : 1];
assign RLAST = RDATA_w[0];
assign RID = RDATA_w[AXI_ID_length + AXI_data_length : AXI_data_length + 1];
assign RRESP = RDATA_w[AXI_ID_length + AXI_data_length + 1] == 1'b1 ? 2'b10 : 2'b00;

endmodule
