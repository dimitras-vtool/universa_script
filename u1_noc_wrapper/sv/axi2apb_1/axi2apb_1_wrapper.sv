// ########################################################################
// Module name        : axi2apb_1_wrapper.sv
// Description        : AXI_to_APB bridge wrapper
// Author             : Nikola Radojicic (nikolar@thevtool.com)
// Created On         : 2024-10-23 10:54:35.185846
// Modified By        : ________
// Modified On        : ________
// Modification Description :
// Version            : 1.0
// -------------------------------------------
module axi2apb_1_wrapper
#(
  parameter AXI_ID_length   = 3,
  parameter AXI_addr_length = 32,
  parameter AXI_data_length = 64,
  parameter AXI_strb_length = 8,
  parameter AXI_user_length = 4,
  parameter APB_addr_length = 32,
  parameter APB_data_length = 16,
  parameter APB_strb_length = 2,
  parameter num_of_slaves   = 5
)
(
  // AXI interface signals (write address channel signals)
  input   [   AXI_ID_length - 1 : 0]  AWID,
  input   [ AXI_addr_length - 1 : 0]  AWADDR,
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
  input   [ AXI_addr_length - 1 : 0]  ARADDR,
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


  // APB interface signals 4
  output  [ APB_addr_length - 1 : 0]  apb_4_PADDR  ,
  output  [                   2 : 0]  apb_4_PPROT  ,
  output  [ APB_strb_length - 1 : 0]  apb_4_PSTRB  ,
  output                              apb_4_PSEL   ,
  output                              apb_4_PENABLE,
  output  [ APB_data_length - 1 : 0]  apb_4_PWDATA ,
  output                              apb_4_PWRITE ,
  input   [ APB_data_length - 1 : 0]  apb_4_PRDATA ,
  input                               apb_4_PREADY ,
  input                               apb_4_PSLVERR,

  // APB interface signals 3
  output  [ APB_addr_length - 1 : 0]  apb_3_PADDR  ,
  output  [                   2 : 0]  apb_3_PPROT  ,
  output  [ APB_strb_length - 1 : 0]  apb_3_PSTRB  ,
  output                              apb_3_PSEL   ,
  output                              apb_3_PENABLE,
  output  [ APB_data_length - 1 : 0]  apb_3_PWDATA ,
  output                              apb_3_PWRITE ,
  input   [ APB_data_length - 1 : 0]  apb_3_PRDATA ,
  input                               apb_3_PREADY ,
  input                               apb_3_PSLVERR,

  // APB interface signals 2
  output  [ APB_addr_length - 1 : 0]  apb_2_PADDR  ,
  output  [                   2 : 0]  apb_2_PPROT  ,
  output  [ APB_strb_length - 1 : 0]  apb_2_PSTRB  ,
  output                              apb_2_PSEL   ,
  output                              apb_2_PENABLE,
  output  [ APB_data_length - 1 : 0]  apb_2_PWDATA ,
  output                              apb_2_PWRITE ,
  input   [ APB_data_length - 1 : 0]  apb_2_PRDATA ,
  input                               apb_2_PREADY ,
  input                               apb_2_PSLVERR,

  // APB interface signals 1
  output  [ APB_addr_length - 1 : 0]  apb_1_PADDR  ,
  output  [                   2 : 0]  apb_1_PPROT  ,
  output  [ APB_strb_length - 1 : 0]  apb_1_PSTRB  ,
  output                              apb_1_PSEL   ,
  output                              apb_1_PENABLE,
  output  [ APB_data_length - 1 : 0]  apb_1_PWDATA ,
  output                              apb_1_PWRITE ,
  input   [ APB_data_length - 1 : 0]  apb_1_PRDATA ,
  input                               apb_1_PREADY ,
  input                               apb_1_PSLVERR,

  // APB interface signals 0
  output  [ APB_addr_length - 1 : 0]  apb_0_PADDR  ,
  output  [                   2 : 0]  apb_0_PPROT  ,
  output  [ APB_strb_length - 1 : 0]  apb_0_PSTRB  ,
  output                              apb_0_PSEL   ,
  output                              apb_0_PENABLE,
  output  [ APB_data_length - 1 : 0]  apb_0_PWDATA ,
  output                              apb_0_PWRITE ,
  input   [ APB_data_length - 1 : 0]  apb_0_PRDATA ,
  input                               apb_0_PREADY ,
  input                               apb_0_PSLVERR,


  // AXI global signals
  input                       clk,
  input                       rst_n,
  // APB global signals
  input                       PCLK,
  input                       PRESETn
);

/********************************************************/
/*                        AXI2APB                       */
/********************************************************/
  wire [APB_addr_length - 1 : 0] apb_PADDR   [num_of_slaves - 1 : 0];
  wire [                  2 : 0] apb_PPROT   [num_of_slaves - 1 : 0];
  wire [APB_strb_length - 1 : 0] apb_PSTRB   [num_of_slaves - 1 : 0];
  wire                           apb_PSEL    [num_of_slaves - 1 : 0];
  wire                           apb_PENABLE [num_of_slaves - 1 : 0];
  wire [APB_data_length - 1 : 0] apb_PWDATA  [num_of_slaves - 1 : 0];
  wire                           apb_PWRITE  [num_of_slaves - 1 : 0];
  wire [APB_data_length - 1 : 0] apb_PRDATA  [num_of_slaves - 1 : 0];
  wire                           apb_PREADY  [num_of_slaves - 1 : 0];
  wire                           apb_PSLVERR [num_of_slaves - 1 : 0];


  assign apb_4_PADDR    = apb_PADDR[4]  ;
  assign apb_4_PPROT    = apb_PPROT[4]  ;
  assign apb_4_PSTRB    = apb_PSTRB[4]  ;
  assign apb_4_PSEL     = apb_PSEL[4]   ;
  assign apb_4_PENABLE  = apb_PENABLE[4];
  assign apb_4_PWDATA   = apb_PWDATA[4] ;
  assign apb_4_PWRITE   = apb_PWRITE[4] ;
  assign apb_PRDATA[4]  = apb_4_PRDATA  ;
  assign apb_PREADY[4]  = apb_4_PREADY  ;
  assign apb_PSLVERR[4] = apb_4_PSLVERR ;

  assign apb_3_PADDR    = apb_PADDR[3]  ;
  assign apb_3_PPROT    = apb_PPROT[3]  ;
  assign apb_3_PSTRB    = apb_PSTRB[3]  ;
  assign apb_3_PSEL     = apb_PSEL[3]   ;
  assign apb_3_PENABLE  = apb_PENABLE[3];
  assign apb_3_PWDATA   = apb_PWDATA[3] ;
  assign apb_3_PWRITE   = apb_PWRITE[3] ;
  assign apb_PRDATA[3]  = apb_3_PRDATA  ;
  assign apb_PREADY[3]  = apb_3_PREADY  ;
  assign apb_PSLVERR[3] = apb_3_PSLVERR ;

  assign apb_2_PADDR    = apb_PADDR[2]  ;
  assign apb_2_PPROT    = apb_PPROT[2]  ;
  assign apb_2_PSTRB    = apb_PSTRB[2]  ;
  assign apb_2_PSEL     = apb_PSEL[2]   ;
  assign apb_2_PENABLE  = apb_PENABLE[2];
  assign apb_2_PWDATA   = apb_PWDATA[2] ;
  assign apb_2_PWRITE   = apb_PWRITE[2] ;
  assign apb_PRDATA[2]  = apb_2_PRDATA  ;
  assign apb_PREADY[2]  = apb_2_PREADY  ;
  assign apb_PSLVERR[2] = apb_2_PSLVERR ;

  assign apb_1_PADDR    = apb_PADDR[1]  ;
  assign apb_1_PPROT    = apb_PPROT[1]  ;
  assign apb_1_PSTRB    = apb_PSTRB[1]  ;
  assign apb_1_PSEL     = apb_PSEL[1]   ;
  assign apb_1_PENABLE  = apb_PENABLE[1];
  assign apb_1_PWDATA   = apb_PWDATA[1] ;
  assign apb_1_PWRITE   = apb_PWRITE[1] ;
  assign apb_PRDATA[1]  = apb_1_PRDATA  ;
  assign apb_PREADY[1]  = apb_1_PREADY  ;
  assign apb_PSLVERR[1] = apb_1_PSLVERR ;

  assign apb_0_PADDR    = apb_PADDR[0]  ;
  assign apb_0_PPROT    = apb_PPROT[0]  ;
  assign apb_0_PSTRB    = apb_PSTRB[0]  ;
  assign apb_0_PSEL     = apb_PSEL[0]   ;
  assign apb_0_PENABLE  = apb_PENABLE[0];
  assign apb_0_PWDATA   = apb_PWDATA[0] ;
  assign apb_0_PWRITE   = apb_PWRITE[0] ;
  assign apb_PRDATA[0]  = apb_0_PRDATA  ;
  assign apb_PREADY[0]  = apb_0_PREADY  ;
  assign apb_PSLVERR[0] = apb_0_PSLVERR ;


axi2apb_1
#(
  .AXI_ID_length    (AXI_ID_length),
  .AXI_data_length  (AXI_data_length),
  .AXI_strb_length  (AXI_strb_length),
  .AXI_user_length  (AXI_user_length),
  .APB_data_length  (APB_data_length),
  .APB_strb_length  (APB_strb_length),
  .num_of_slaves    (num_of_slaves)
)
axi2apb_1_wrapper_inst
(
  .ACLK         (clk),
  .ARESETn      (rst_n),
  .AWID         (AWID),
  .AWADDR       (AWADDR ),
  .AWLEN        (AWLEN  ),
  .AWSIZE       (AWSIZE ),
  .AWBURST      (AWBURST),
  .AWLOCK       (AWLOCK),
  .AWCACHE      (AWCACHE),
  .AWPROT       (AWPROT),
  .AWQOS        (AWQOS),
  .AWREGION     (AWREGION),
  .AWUSER       (AWUSER),
  .AWVALID      (AWVALID),
  .AWREADY      (AWREADY),
  .WDATA        (WDATA  ),
  .WSTRB        (WSTRB  ),
  .WLAST        (WLAST  ),
  .WUSER        (WUSER  ),
  .WVALID       (WVALID ),
  .WREADY       (WREADY ),
  .BID          (BID    ),
  .BRESP        (BRESP  ),
  .BUSER        (BUSER  ),
  .BVALID       (BVALID ),
  .BREADY       (BREADY ),
  .ARID         (ARID   ),
  .ARADDR       (ARADDR ),
  .ARLEN        (ARLEN  ),
  .ARSIZE       (ARSIZE ),
  .ARBURST      (ARBURST),
  .ARLOCK       (ARLOCK),
  .ARCACHE      (ARCACHE),
  .ARPROT       (ARPROT),
  .ARQOS        (ARQOS),
  .ARREGION     (ARREGION),
  .ARUSER       (ARUSER),
  .ARVALID      (ARVALID),
  .ARREADY      (ARREADY),
  .RID          (RID    ),
  .RDATA        (RDATA  ),
  .RRESP        (RRESP  ),
  .RLAST        (RLAST  ),
  .RUSER        (RUSER  ),
  .RVALID       (RVALID ),
  .RREADY       (RREADY ),
  .PCLK         (PCLK   ),
  .PRESETn      (PRESETn),
  .PADDR        (apb_PADDR  ),
  .PPROT        (apb_PPROT  ),
  .PSTRB        (apb_PSTRB  ),
  .PSEL         (apb_PSEL   ),
  .PENABLE      (apb_PENABLE),
  .PWDATA       (apb_PWDATA ),
  .PWRITE       (apb_PWRITE ),
  .PRDATA       (apb_PRDATA ),
  .PREADY       (apb_PREADY ),
  .PSLVERR      (apb_PSLVERR)
);

endmodule