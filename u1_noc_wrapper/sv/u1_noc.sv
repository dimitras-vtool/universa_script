// ########################################################################
// Module name        : u1_noc.sv
// Description        : Interconnect top module
// Author             : Nikola Radojicic (nikolar@thevtool.com)
// Created On         : 2024-10-23 10:54:34.125045
// Modified By        : ________
// Modified On        : ________
// Modification Description :
// Version            : 1.0
// -------------------------------------------
module u1_noc
(
    //----------------------- AXI global signals -------------------------
    input  wire                     AXI_fabric_0_wrapper_clk,
    input  wire                     AXI_fabric_0_wrapper_rst_n,
    //-------------------------- m00_axi signals--------------------------
    // AXI Write Channels
    input  wire [1-1:0]    m00_axi_awid,
    input  wire [32-1:0]    m00_axi_awaddr,
    input  wire [8-1:0]             m00_axi_awlen,
    input  wire [3-1:0]             m00_axi_awsize,
    input  wire [2-1:0]             m00_axi_awburst,
    input  wire                     m00_axi_awlock,
    input  wire [4-1:0]             m00_axi_awcache,
    input  wire [3-1:0]             m00_axi_awprot,
    input  wire [3:0]               m00_axi_awregion,
    input  wire [4-1:0]             m00_axi_awqos,
    input  wire [4-1:0] m00_axi_awuser,
    input  wire                     m00_axi_awvalid,
    output wire                     m00_axi_awready,

    input  wire [64-1:0]    m00_axi_wdata,
    input  wire [8-1:0]    m00_axi_wstrb,
    input  wire [4-1:0]  m00_axi_wuser,
    input  wire                     m00_axi_wvalid,
    output wire                     m00_axi_wready,
    input  wire                     m00_axi_wlast,

    output wire [1-1:0]    m00_axi_bid,
    output wire [4-1:0]  m00_axi_buser,
    output wire [2-1:0]             m00_axi_bresp,
    output wire                     m00_axi_bvalid,
    input  wire                     m00_axi_bready,

    // AXI Read Channels
    input  wire [1-1:0]    m00_axi_arid,
    input  wire [32-1:0]    m00_axi_araddr,
    input  wire [4-1:0] m00_axi_aruser,
    input  wire [8-1:0]             m00_axi_arlen,
    input  wire [3-1:0]             m00_axi_arsize,
    input  wire [2-1:0]             m00_axi_arburst,
    input  wire                     m00_axi_arlock,
    input  wire [4-1:0]             m00_axi_arcache,
    input  wire [3-1:0]             m00_axi_arprot,
    input  wire [3:0]               m00_axi_arregion,
    input  wire [4-1:0]             m00_axi_arqos,
    input  wire                     m00_axi_arvalid,
    output wire                     m00_axi_arready,

    output wire [64-1:0]    m00_axi_rdata,
    output wire [1-1:0]    m00_axi_rid,
    output wire [2-1:0]             m00_axi_rresp,
    output wire                     m00_axi_rlast,
    output wire                     m00_axi_rvalid,
    output wire [4-1:0]    m00_axi_ruser,
    input  wire                     m00_axi_rready,
    //-------------------------- m01_axi signals--------------------------
    // AXI Write Channels
    input  wire [1-1:0]    m01_axi_awid,
    input  wire [32-1:0]    m01_axi_awaddr,
    input  wire [8-1:0]             m01_axi_awlen,
    input  wire [3-1:0]             m01_axi_awsize,
    input  wire [2-1:0]             m01_axi_awburst,
    input  wire                     m01_axi_awlock,
    input  wire [4-1:0]             m01_axi_awcache,
    input  wire [3-1:0]             m01_axi_awprot,
    input  wire [3:0]               m01_axi_awregion,
    input  wire [4-1:0]             m01_axi_awqos,
    input  wire [4-1:0] m01_axi_awuser,
    input  wire                     m01_axi_awvalid,
    output wire                     m01_axi_awready,

    input  wire [64-1:0]    m01_axi_wdata,
    input  wire [8-1:0]    m01_axi_wstrb,
    input  wire [4-1:0]  m01_axi_wuser,
    input  wire                     m01_axi_wvalid,
    output wire                     m01_axi_wready,
    input  wire                     m01_axi_wlast,

    output wire [1-1:0]    m01_axi_bid,
    output wire [4-1:0]  m01_axi_buser,
    output wire [2-1:0]             m01_axi_bresp,
    output wire                     m01_axi_bvalid,
    input  wire                     m01_axi_bready,

    // AXI Read Channels
    input  wire [1-1:0]    m01_axi_arid,
    input  wire [32-1:0]    m01_axi_araddr,
    input  wire [4-1:0] m01_axi_aruser,
    input  wire [8-1:0]             m01_axi_arlen,
    input  wire [3-1:0]             m01_axi_arsize,
    input  wire [2-1:0]             m01_axi_arburst,
    input  wire                     m01_axi_arlock,
    input  wire [4-1:0]             m01_axi_arcache,
    input  wire [3-1:0]             m01_axi_arprot,
    input  wire [3:0]               m01_axi_arregion,
    input  wire [4-1:0]             m01_axi_arqos,
    input  wire                     m01_axi_arvalid,
    output wire                     m01_axi_arready,

    output wire [64-1:0]    m01_axi_rdata,
    output wire [1-1:0]    m01_axi_rid,
    output wire [2-1:0]             m01_axi_rresp,
    output wire                     m01_axi_rlast,
    output wire                     m01_axi_rvalid,
    output wire [4-1:0]    m01_axi_ruser,
    input  wire                     m01_axi_rready,
    //-------------------------- m02_axi signals--------------------------
    // AXI Write Channels
    input  wire [1-1:0]    m02_axi_awid,
    input  wire [32-1:0]    m02_axi_awaddr,
    input  wire [8-1:0]             m02_axi_awlen,
    input  wire [3-1:0]             m02_axi_awsize,
    input  wire [2-1:0]             m02_axi_awburst,
    input  wire                     m02_axi_awlock,
    input  wire [4-1:0]             m02_axi_awcache,
    input  wire [3-1:0]             m02_axi_awprot,
    input  wire [3:0]               m02_axi_awregion,
    input  wire [4-1:0]             m02_axi_awqos,
    input  wire [4-1:0] m02_axi_awuser,
    input  wire                     m02_axi_awvalid,
    output wire                     m02_axi_awready,

    input  wire [64-1:0]    m02_axi_wdata,
    input  wire [8-1:0]    m02_axi_wstrb,
    input  wire [4-1:0]  m02_axi_wuser,
    input  wire                     m02_axi_wvalid,
    output wire                     m02_axi_wready,
    input  wire                     m02_axi_wlast,

    output wire [1-1:0]    m02_axi_bid,
    output wire [4-1:0]  m02_axi_buser,
    output wire [2-1:0]             m02_axi_bresp,
    output wire                     m02_axi_bvalid,
    input  wire                     m02_axi_bready,

    // AXI Read Channels
    input  wire [1-1:0]    m02_axi_arid,
    input  wire [32-1:0]    m02_axi_araddr,
    input  wire [4-1:0] m02_axi_aruser,
    input  wire [8-1:0]             m02_axi_arlen,
    input  wire [3-1:0]             m02_axi_arsize,
    input  wire [2-1:0]             m02_axi_arburst,
    input  wire                     m02_axi_arlock,
    input  wire [4-1:0]             m02_axi_arcache,
    input  wire [3-1:0]             m02_axi_arprot,
    input  wire [3:0]               m02_axi_arregion,
    input  wire [4-1:0]             m02_axi_arqos,
    input  wire                     m02_axi_arvalid,
    output wire                     m02_axi_arready,

    output wire [64-1:0]    m02_axi_rdata,
    output wire [1-1:0]    m02_axi_rid,
    output wire [2-1:0]             m02_axi_rresp,
    output wire                     m02_axi_rlast,
    output wire                     m02_axi_rvalid,
    output wire [4-1:0]    m02_axi_ruser,
    input  wire                     m02_axi_rready,
    //------------------- APB to AXI global signals ----------------------
    input  wire                         axi2apb_0_wrapper_clk,        // AXI clock
    input  wire                         axi2apb_0_wrapper_rst_n,      // AXI reset_n
    input  wire                         axi2apb_0_wrapper_pclk,       // APB clock
    input  wire                         axi2apb_0_wrapper_preset_n,   // APB reset_n        
    //-------------------------- m03_axi signals--------------------------
    // AXI Write Channels
    input  wire [3-1:0]    m03_axi_awid,
    input  wire [32-1:0]    m03_axi_awaddr,
    input  wire [8-1:0]             m03_axi_awlen,
    input  wire [3-1:0]             m03_axi_awsize,
    input  wire [2-1:0]             m03_axi_awburst,
    input  wire                     m03_axi_awlock,
    input  wire [4-1:0]             m03_axi_awcache,
    input  wire [3-1:0]             m03_axi_awprot,
    input  wire [3:0]               m03_axi_awregion,
    input  wire [4-1:0]             m03_axi_awqos,
    input  wire [4-1:0] m03_axi_awuser,
    input  wire                     m03_axi_awvalid,
    output wire                     m03_axi_awready,

    input  wire [64-1:0]    m03_axi_wdata,
    input  wire [8-1:0]    m03_axi_wstrb,
    input  wire [4-1:0]  m03_axi_wuser,
    input  wire                     m03_axi_wvalid,
    output wire                     m03_axi_wready,
    input  wire                     m03_axi_wlast,

    output wire [3-1:0]    m03_axi_bid,
    output wire [4-1:0]  m03_axi_buser,
    output wire [2-1:0]             m03_axi_bresp,
    output wire                     m03_axi_bvalid,
    input  wire                     m03_axi_bready,

    // AXI Read Channels
    input  wire [3-1:0]    m03_axi_arid,
    input  wire [32-1:0]    m03_axi_araddr,
    input  wire [4-1:0] m03_axi_aruser,
    input  wire [8-1:0]             m03_axi_arlen,
    input  wire [3-1:0]             m03_axi_arsize,
    input  wire [2-1:0]             m03_axi_arburst,
    input  wire                     m03_axi_arlock,
    input  wire [4-1:0]             m03_axi_arcache,
    input  wire [3-1:0]             m03_axi_arprot,
    input  wire [3:0]               m03_axi_arregion,
    input  wire [4-1:0]             m03_axi_arqos,
    input  wire                     m03_axi_arvalid,
    output wire                     m03_axi_arready,

    output wire [64-1:0]    m03_axi_rdata,
    output wire [3-1:0]    m03_axi_rid,
    output wire [2-1:0]             m03_axi_rresp,
    output wire                     m03_axi_rlast,
    output wire                     m03_axi_rvalid,
    output wire [4-1:0]    m03_axi_ruser,
    input  wire                     m03_axi_rready,
    //-------------------------- m04_axi signals--------------------------
    // AXI Write Channels
    input  wire [3-1:0]    m04_axi_awid,
    input  wire [32-1:0]    m04_axi_awaddr,
    input  wire [8-1:0]             m04_axi_awlen,
    input  wire [3-1:0]             m04_axi_awsize,
    input  wire [2-1:0]             m04_axi_awburst,
    input  wire                     m04_axi_awlock,
    input  wire [4-1:0]             m04_axi_awcache,
    input  wire [3-1:0]             m04_axi_awprot,
    input  wire [3:0]               m04_axi_awregion,
    input  wire [4-1:0]             m04_axi_awqos,
    input  wire [4-1:0] m04_axi_awuser,
    input  wire                     m04_axi_awvalid,
    output wire                     m04_axi_awready,

    input  wire [64-1:0]    m04_axi_wdata,
    input  wire [8-1:0]    m04_axi_wstrb,
    input  wire [4-1:0]  m04_axi_wuser,
    input  wire                     m04_axi_wvalid,
    output wire                     m04_axi_wready,
    input  wire                     m04_axi_wlast,

    output wire [3-1:0]    m04_axi_bid,
    output wire [4-1:0]  m04_axi_buser,
    output wire [2-1:0]             m04_axi_bresp,
    output wire                     m04_axi_bvalid,
    input  wire                     m04_axi_bready,

    // AXI Read Channels
    input  wire [3-1:0]    m04_axi_arid,
    input  wire [32-1:0]    m04_axi_araddr,
    input  wire [4-1:0] m04_axi_aruser,
    input  wire [8-1:0]             m04_axi_arlen,
    input  wire [3-1:0]             m04_axi_arsize,
    input  wire [2-1:0]             m04_axi_arburst,
    input  wire                     m04_axi_arlock,
    input  wire [4-1:0]             m04_axi_arcache,
    input  wire [3-1:0]             m04_axi_arprot,
    input  wire [3:0]               m04_axi_arregion,
    input  wire [4-1:0]             m04_axi_arqos,
    input  wire                     m04_axi_arvalid,
    output wire                     m04_axi_arready,

    output wire [64-1:0]    m04_axi_rdata,
    output wire [3-1:0]    m04_axi_rid,
    output wire [2-1:0]             m04_axi_rresp,
    output wire                     m04_axi_rlast,
    output wire                     m04_axi_rvalid,
    output wire [4-1:0]    m04_axi_ruser,
    input  wire                     m04_axi_rready,
    // APB interface signals s00_apb
    output  [ 32 - 1 : 0]  s00_apb_PADDR  ,
    output  [                   2 : 0]  s00_apb_PPROT  ,
    output  [ 2 - 1 : 0]  s00_apb_PSTRB  ,
    output                              s00_apb_PSEL   ,
    output                              s00_apb_PENABLE,
    output  [ 16 - 1 : 0]  s00_apb_PWDATA ,
    output                              s00_apb_PWRITE ,
    input   [ 16 - 1 : 0]  s00_apb_PRDATA ,
    input                               s00_apb_PREADY ,
    input                               s00_apb_PSLVERR,
    // APB interface signals s01_apb
    output  [ 32 - 1 : 0]  s01_apb_PADDR  ,
    output  [                   2 : 0]  s01_apb_PPROT  ,
    output  [ 2 - 1 : 0]  s01_apb_PSTRB  ,
    output                              s01_apb_PSEL   ,
    output                              s01_apb_PENABLE,
    output  [ 16 - 1 : 0]  s01_apb_PWDATA ,
    output                              s01_apb_PWRITE ,
    input   [ 16 - 1 : 0]  s01_apb_PRDATA ,
    input                               s01_apb_PREADY ,
    input                               s01_apb_PSLVERR,
    // APB interface signals s02_apb
    output  [ 32 - 1 : 0]  s02_apb_PADDR  ,
    output  [                   2 : 0]  s02_apb_PPROT  ,
    output  [ 2 - 1 : 0]  s02_apb_PSTRB  ,
    output                              s02_apb_PSEL   ,
    output                              s02_apb_PENABLE,
    output  [ 16 - 1 : 0]  s02_apb_PWDATA ,
    output                              s02_apb_PWRITE ,
    input   [ 16 - 1 : 0]  s02_apb_PRDATA ,
    input                               s02_apb_PREADY ,
    input                               s02_apb_PSLVERR,
    // APB interface signals s03_apb
    output  [ 32 - 1 : 0]  s03_apb_PADDR  ,
    output  [                   2 : 0]  s03_apb_PPROT  ,
    output  [ 2 - 1 : 0]  s03_apb_PSTRB  ,
    output                              s03_apb_PSEL   ,
    output                              s03_apb_PENABLE,
    output  [ 16 - 1 : 0]  s03_apb_PWDATA ,
    output                              s03_apb_PWRITE ,
    input   [ 16 - 1 : 0]  s03_apb_PRDATA ,
    input                               s03_apb_PREADY ,
    input                               s03_apb_PSLVERR,
    // APB interface signals s04_apb
    output  [ 32 - 1 : 0]  s04_apb_PADDR  ,
    output  [                   2 : 0]  s04_apb_PPROT  ,
    output  [ 2 - 1 : 0]  s04_apb_PSTRB  ,
    output                              s04_apb_PSEL   ,
    output                              s04_apb_PENABLE,
    output  [ 16 - 1 : 0]  s04_apb_PWDATA ,
    output                              s04_apb_PWRITE ,
    input   [ 16 - 1 : 0]  s04_apb_PRDATA ,
    input                               s04_apb_PREADY ,
    input                               s04_apb_PSLVERR,
    //------------------- APB to AXI global signals ----------------------
    input  wire                         axi2apb_1_wrapper_clk,        // AXI clock
    input  wire                         axi2apb_1_wrapper_rst_n,      // AXI reset_n
    input  wire                         axi2apb_1_wrapper_pclk,       // APB clock
    input  wire                         axi2apb_1_wrapper_preset_n,   // APB reset_n        
    // APB interface signals s05_apb
    output  [ 32 - 1 : 0]  s05_apb_PADDR  ,
    output  [                   2 : 0]  s05_apb_PPROT  ,
    output  [ 2 - 1 : 0]  s05_apb_PSTRB  ,
    output                              s05_apb_PSEL   ,
    output                              s05_apb_PENABLE,
    output  [ 16 - 1 : 0]  s05_apb_PWDATA ,
    output                              s05_apb_PWRITE ,
    input   [ 16 - 1 : 0]  s05_apb_PRDATA ,
    input                               s05_apb_PREADY ,
    input                               s05_apb_PSLVERR,
    // APB interface signals s06_apb
    output  [ 32 - 1 : 0]  s06_apb_PADDR  ,
    output  [                   2 : 0]  s06_apb_PPROT  ,
    output  [ 2 - 1 : 0]  s06_apb_PSTRB  ,
    output                              s06_apb_PSEL   ,
    output                              s06_apb_PENABLE,
    output  [ 16 - 1 : 0]  s06_apb_PWDATA ,
    output                              s06_apb_PWRITE ,
    input   [ 16 - 1 : 0]  s06_apb_PRDATA ,
    input                               s06_apb_PREADY ,
    input                               s06_apb_PSLVERR,
    // APB interface signals s07_apb
    output  [ 32 - 1 : 0]  s07_apb_PADDR  ,
    output  [                   2 : 0]  s07_apb_PPROT  ,
    output  [ 2 - 1 : 0]  s07_apb_PSTRB  ,
    output                              s07_apb_PSEL   ,
    output                              s07_apb_PENABLE,
    output  [ 16 - 1 : 0]  s07_apb_PWDATA ,
    output                              s07_apb_PWRITE ,
    input   [ 16 - 1 : 0]  s07_apb_PRDATA ,
    input                               s07_apb_PREADY ,
    input                               s07_apb_PSLVERR,
    // APB interface signals s08_apb
    output  [ 32 - 1 : 0]  s08_apb_PADDR  ,
    output  [                   2 : 0]  s08_apb_PPROT  ,
    output  [ 2 - 1 : 0]  s08_apb_PSTRB  ,
    output                              s08_apb_PSEL   ,
    output                              s08_apb_PENABLE,
    output  [ 16 - 1 : 0]  s08_apb_PWDATA ,
    output                              s08_apb_PWRITE ,
    input   [ 16 - 1 : 0]  s08_apb_PRDATA ,
    input                               s08_apb_PREADY ,
    input                               s08_apb_PSLVERR,
    // APB interface signals s09_apb
    output  [ 32 - 1 : 0]  s09_apb_PADDR  ,
    output  [                   2 : 0]  s09_apb_PPROT  ,
    output  [ 2 - 1 : 0]  s09_apb_PSTRB  ,
    output                              s09_apb_PSEL   ,
    output                              s09_apb_PENABLE,
    output  [ 16 - 1 : 0]  s09_apb_PWDATA ,
    output                              s09_apb_PWRITE ,
    input   [ 16 - 1 : 0]  s09_apb_PRDATA ,
    input                               s09_apb_PREADY ,
    input                               s09_apb_PSLVERR
);

    //-------------------------- axi0_to_apb0 signals--------------------------
    // AXI Write Channels
    wire [3-1:0]    axi0_to_apb0_awid;
    wire [32-1:0]    axi0_to_apb0_awaddr;
    wire [8-1:0]             axi0_to_apb0_awlen;
    wire [3-1:0]             axi0_to_apb0_awsize;
    wire [2-1:0]             axi0_to_apb0_awburst;
    wire                     axi0_to_apb0_awlock;
    wire [4-1:0]             axi0_to_apb0_awcache;
    wire [3-1:0]             axi0_to_apb0_awprot;
    wire [3:0]               axi0_to_apb0_awregion;
    wire [4-1:0]             axi0_to_apb0_awqos;
    wire [4- 1 : 0] axi0_to_apb0_awuser;
    wire                     axi0_to_apb0_awvalid;
    wire                     axi0_to_apb0_awready;

    wire [64-1:0]    axi0_to_apb0_wdata;
    wire [8-1:0]    axi0_to_apb0_wstrb;
    wire [4- 1 : 0] axi0_to_apb0_wuser;
    wire                     axi0_to_apb0_wvalid;
    wire                     axi0_to_apb0_wready;
    wire                     axi0_to_apb0_wlast;

    wire [3-1:0]    axi0_to_apb0_bid;
    wire [4- 1 : 0] axi0_to_apb0_buser;
    wire [2-1:0]             axi0_to_apb0_bresp;
    wire                     axi0_to_apb0_bvalid;
    wire                     axi0_to_apb0_bready;

    // AXI Read Channels
    wire [32-1:0]    axi0_to_apb0_araddr;
    wire [3-1:0]    axi0_to_apb0_arid;
    wire [8-1:0]             axi0_to_apb0_arlen;
    wire [3-1:0]             axi0_to_apb0_arsize;
    wire [2-1:0]             axi0_to_apb0_arburst;
    wire                     axi0_to_apb0_arlock;
    wire [4-1:0]             axi0_to_apb0_arcache;
    wire [3-1:0]             axi0_to_apb0_arprot;
    wire [3:0]               axi0_to_apb0_arregion;
    wire [4-1:0]             axi0_to_apb0_arqos;
    wire [4- 1 : 0] axi0_to_apb0_aruser;
    wire                     axi0_to_apb0_arvalid;
    wire                     axi0_to_apb0_arready;

    wire [64-1:0]    axi0_to_apb0_rdata;
    wire [3-1:0]    axi0_to_apb0_rid;
    wire [2-1:0]             axi0_to_apb0_rresp;
    wire                     axi0_to_apb0_rlast;
    wire                     axi0_to_apb0_rvalid;
    wire [4- 1 : 0] axi0_to_apb0_ruser;
    wire                     axi0_to_apb0_rready;

    //-------------------------- axi0_to_apb1 signals--------------------------
    // AXI Write Channels
    wire [3-1:0]    axi0_to_apb1_awid;
    wire [32-1:0]    axi0_to_apb1_awaddr;
    wire [8-1:0]             axi0_to_apb1_awlen;
    wire [3-1:0]             axi0_to_apb1_awsize;
    wire [2-1:0]             axi0_to_apb1_awburst;
    wire                     axi0_to_apb1_awlock;
    wire [4-1:0]             axi0_to_apb1_awcache;
    wire [3-1:0]             axi0_to_apb1_awprot;
    wire [3:0]               axi0_to_apb1_awregion;
    wire [4-1:0]             axi0_to_apb1_awqos;
    wire [4- 1 : 0] axi0_to_apb1_awuser;
    wire                     axi0_to_apb1_awvalid;
    wire                     axi0_to_apb1_awready;

    wire [64-1:0]    axi0_to_apb1_wdata;
    wire [8-1:0]    axi0_to_apb1_wstrb;
    wire [4- 1 : 0] axi0_to_apb1_wuser;
    wire                     axi0_to_apb1_wvalid;
    wire                     axi0_to_apb1_wready;
    wire                     axi0_to_apb1_wlast;

    wire [3-1:0]    axi0_to_apb1_bid;
    wire [4- 1 : 0] axi0_to_apb1_buser;
    wire [2-1:0]             axi0_to_apb1_bresp;
    wire                     axi0_to_apb1_bvalid;
    wire                     axi0_to_apb1_bready;

    // AXI Read Channels
    wire [32-1:0]    axi0_to_apb1_araddr;
    wire [3-1:0]    axi0_to_apb1_arid;
    wire [8-1:0]             axi0_to_apb1_arlen;
    wire [3-1:0]             axi0_to_apb1_arsize;
    wire [2-1:0]             axi0_to_apb1_arburst;
    wire                     axi0_to_apb1_arlock;
    wire [4-1:0]             axi0_to_apb1_arcache;
    wire [3-1:0]             axi0_to_apb1_arprot;
    wire [3:0]               axi0_to_apb1_arregion;
    wire [4-1:0]             axi0_to_apb1_arqos;
    wire [4- 1 : 0] axi0_to_apb1_aruser;
    wire                     axi0_to_apb1_arvalid;
    wire                     axi0_to_apb1_arready;

    wire [64-1:0]    axi0_to_apb1_rdata;
    wire [3-1:0]    axi0_to_apb1_rid;
    wire [2-1:0]             axi0_to_apb1_rresp;
    wire                     axi0_to_apb1_rlast;
    wire                     axi0_to_apb1_rvalid;
    wire [4- 1 : 0] axi0_to_apb1_ruser;
    wire                     axi0_to_apb1_rready;

AXI_fabric_0_wrapper AXI_fabric_0_wrapper_inst
(

    .s01_axi_awid        (m02_axi_awid   ),
    .s01_axi_awaddr      (m02_axi_awaddr ),
    .s01_axi_awlen       (m02_axi_awlen  ),
    .s01_axi_awsize      (m02_axi_awsize ),
    .s01_axi_awburst     (m02_axi_awburst),
    .s01_axi_awlock      (m02_axi_awlock ),
    .s01_axi_awcache     (m02_axi_awcache),
    .s01_axi_awprot      (m02_axi_awprot ),
    .s01_axi_awregion    (m02_axi_awregion),
    .s01_axi_awqos       (m02_axi_awqos  ),
    .s01_axi_awuser      (m02_axi_awuser ),
    .s01_axi_awvalid     (m02_axi_awvalid),
    .s01_axi_awready     (m02_axi_awready),
    .s01_axi_wdata       (m02_axi_wdata  ),
    .s01_axi_wstrb       (m02_axi_wstrb  ),
    .s01_axi_wuser       (m02_axi_wuser  ),
    .s01_axi_wvalid      (m02_axi_wvalid ),
    .s01_axi_wready      (m02_axi_wready ),
    .s01_axi_wlast       (m02_axi_wlast  ),
    .s01_axi_bid         (m02_axi_bid    ),
    .s01_axi_buser       (m02_axi_buser  ),
    .s01_axi_bresp       (m02_axi_bresp  ),
    .s01_axi_bvalid      (m02_axi_bvalid ),
    .s01_axi_bready      (m02_axi_bready ),
    .s01_axi_arid        (m02_axi_arid   ),
    .s01_axi_araddr      (m02_axi_araddr ),
    .s01_axi_aruser      (m02_axi_aruser ),
    .s01_axi_arlen       (m02_axi_arlen  ),
    .s01_axi_arsize      (m02_axi_arsize ),
    .s01_axi_arburst     (m02_axi_arburst),
    .s01_axi_arlock      (m02_axi_arlock ),
    .s01_axi_arcache     (m02_axi_arcache),
    .s01_axi_arprot      (m02_axi_arprot ),
    .s01_axi_arregion    (m02_axi_arregion),
    .s01_axi_arqos       (m02_axi_arqos  ),
    .s01_axi_arvalid     (m02_axi_arvalid),
    .s01_axi_arready     (m02_axi_arready),
    .s01_axi_rdata       (m02_axi_rdata  ),
    .s01_axi_rid         (m02_axi_rid    ),
    .s01_axi_rresp       (m02_axi_rresp  ),
    .s01_axi_rlast       (m02_axi_rlast  ),
    .s01_axi_rvalid      (m02_axi_rvalid ),
    .s01_axi_ruser       (m02_axi_ruser  ),
    .s01_axi_rready      (m02_axi_rready ),

    .s00_axi_awid        (m01_axi_awid   ),
    .s00_axi_awaddr      (m01_axi_awaddr ),
    .s00_axi_awlen       (m01_axi_awlen  ),
    .s00_axi_awsize      (m01_axi_awsize ),
    .s00_axi_awburst     (m01_axi_awburst),
    .s00_axi_awlock      (m01_axi_awlock ),
    .s00_axi_awcache     (m01_axi_awcache),
    .s00_axi_awprot      (m01_axi_awprot ),
    .s00_axi_awregion    (m01_axi_awregion),
    .s00_axi_awqos       (m01_axi_awqos  ),
    .s00_axi_awuser      (m01_axi_awuser ),
    .s00_axi_awvalid     (m01_axi_awvalid),
    .s00_axi_awready     (m01_axi_awready),
    .s00_axi_wdata       (m01_axi_wdata  ),
    .s00_axi_wstrb       (m01_axi_wstrb  ),
    .s00_axi_wuser       (m01_axi_wuser  ),
    .s00_axi_wvalid      (m01_axi_wvalid ),
    .s00_axi_wready      (m01_axi_wready ),
    .s00_axi_wlast       (m01_axi_wlast  ),
    .s00_axi_bid         (m01_axi_bid    ),
    .s00_axi_buser       (m01_axi_buser  ),
    .s00_axi_bresp       (m01_axi_bresp  ),
    .s00_axi_bvalid      (m01_axi_bvalid ),
    .s00_axi_bready      (m01_axi_bready ),
    .s00_axi_arid        (m01_axi_arid   ),
    .s00_axi_araddr      (m01_axi_araddr ),
    .s00_axi_aruser      (m01_axi_aruser ),
    .s00_axi_arlen       (m01_axi_arlen  ),
    .s00_axi_arsize      (m01_axi_arsize ),
    .s00_axi_arburst     (m01_axi_arburst),
    .s00_axi_arlock      (m01_axi_arlock ),
    .s00_axi_arcache     (m01_axi_arcache),
    .s00_axi_arprot      (m01_axi_arprot ),
    .s00_axi_arregion    (m01_axi_arregion),
    .s00_axi_arqos       (m01_axi_arqos  ),
    .s00_axi_arvalid     (m01_axi_arvalid),
    .s00_axi_arready     (m01_axi_arready),
    .s00_axi_rdata       (m01_axi_rdata  ),
    .s00_axi_rid         (m01_axi_rid    ),
    .s00_axi_rresp       (m01_axi_rresp  ),
    .s00_axi_rlast       (m01_axi_rlast  ),
    .s00_axi_rvalid      (m01_axi_rvalid ),
    .s00_axi_ruser       (m01_axi_ruser  ),
    .s00_axi_rready      (m01_axi_rready ),


    .m02_axi_awid        (axi0_to_apb1_awid    ),
    .m02_axi_awaddr      (axi0_to_apb1_awaddr  ),
    .m02_axi_awlen       (axi0_to_apb1_awlen   ),
    .m02_axi_awsize      (axi0_to_apb1_awsize  ),
    .m02_axi_awburst     (axi0_to_apb1_awburst ),
    .m02_axi_awlock      (axi0_to_apb1_awlock  ),
    .m02_axi_awcache     (axi0_to_apb1_awcache ),
    .m02_axi_awprot      (axi0_to_apb1_awprot  ),
    .m02_axi_awregion    (axi0_to_apb1_awregion),
    .m02_axi_awqos       (axi0_to_apb1_awqos   ),
    .m02_axi_awuser      (axi0_to_apb1_awuser  ),
    .m02_axi_awvalid     (axi0_to_apb1_awvalid ),
    .m02_axi_awready     (axi0_to_apb1_awready ),
    .m02_axi_wdata       (axi0_to_apb1_wdata   ),
    .m02_axi_wstrb       (axi0_to_apb1_wstrb   ),
    .m02_axi_wuser       (axi0_to_apb1_wuser   ),
    .m02_axi_wvalid      (axi0_to_apb1_wvalid  ),
    .m02_axi_wready      (axi0_to_apb1_wready  ),
    .m02_axi_wlast       (axi0_to_apb1_wlast   ),
    .m02_axi_bid         (axi0_to_apb1_bid     ),
    .m02_axi_buser       (axi0_to_apb1_buser   ),
    .m02_axi_bresp       (axi0_to_apb1_bresp   ),
    .m02_axi_bvalid      (axi0_to_apb1_bvalid  ),
    .m02_axi_bready      (axi0_to_apb1_bready  ),
    .m02_axi_araddr      (axi0_to_apb1_araddr  ),
    .m02_axi_arid        (axi0_to_apb1_arid    ),
    .m02_axi_arlen       (axi0_to_apb1_arlen   ),
    .m02_axi_arsize      (axi0_to_apb1_arsize  ),
    .m02_axi_arburst     (axi0_to_apb1_arburst ),
    .m02_axi_arlock      (axi0_to_apb1_arlock  ),
    .m02_axi_arcache     (axi0_to_apb1_arcache ),
    .m02_axi_arprot      (axi0_to_apb1_arprot  ),
    .m02_axi_arregion    (axi0_to_apb1_arregion),
    .m02_axi_arqos       (axi0_to_apb1_arqos   ),
    .m02_axi_aruser      (axi0_to_apb1_aruser  ),
    .m02_axi_arvalid     (axi0_to_apb1_arvalid ),
    .m02_axi_arready     (axi0_to_apb1_arready ),
    .m02_axi_rdata       (axi0_to_apb1_rdata   ),
    .m02_axi_rid         (axi0_to_apb1_rid     ),
    .m02_axi_rresp       (axi0_to_apb1_rresp   ),
    .m02_axi_rlast       (axi0_to_apb1_rlast   ),
    .m02_axi_rvalid      (axi0_to_apb1_rvalid  ),
    .m02_axi_ruser       (axi0_to_apb1_ruser   ),
    .m02_axi_rready      (axi0_to_apb1_rready  ),

    .m01_axi_awid        (axi0_to_apb0_awid    ),
    .m01_axi_awaddr      (axi0_to_apb0_awaddr  ),
    .m01_axi_awlen       (axi0_to_apb0_awlen   ),
    .m01_axi_awsize      (axi0_to_apb0_awsize  ),
    .m01_axi_awburst     (axi0_to_apb0_awburst ),
    .m01_axi_awlock      (axi0_to_apb0_awlock  ),
    .m01_axi_awcache     (axi0_to_apb0_awcache ),
    .m01_axi_awprot      (axi0_to_apb0_awprot  ),
    .m01_axi_awregion    (axi0_to_apb0_awregion),
    .m01_axi_awqos       (axi0_to_apb0_awqos   ),
    .m01_axi_awuser      (axi0_to_apb0_awuser  ),
    .m01_axi_awvalid     (axi0_to_apb0_awvalid ),
    .m01_axi_awready     (axi0_to_apb0_awready ),
    .m01_axi_wdata       (axi0_to_apb0_wdata   ),
    .m01_axi_wstrb       (axi0_to_apb0_wstrb   ),
    .m01_axi_wuser       (axi0_to_apb0_wuser   ),
    .m01_axi_wvalid      (axi0_to_apb0_wvalid  ),
    .m01_axi_wready      (axi0_to_apb0_wready  ),
    .m01_axi_wlast       (axi0_to_apb0_wlast   ),
    .m01_axi_bid         (axi0_to_apb0_bid     ),
    .m01_axi_buser       (axi0_to_apb0_buser   ),
    .m01_axi_bresp       (axi0_to_apb0_bresp   ),
    .m01_axi_bvalid      (axi0_to_apb0_bvalid  ),
    .m01_axi_bready      (axi0_to_apb0_bready  ),
    .m01_axi_araddr      (axi0_to_apb0_araddr  ),
    .m01_axi_arid        (axi0_to_apb0_arid    ),
    .m01_axi_arlen       (axi0_to_apb0_arlen   ),
    .m01_axi_arsize      (axi0_to_apb0_arsize  ),
    .m01_axi_arburst     (axi0_to_apb0_arburst ),
    .m01_axi_arlock      (axi0_to_apb0_arlock  ),
    .m01_axi_arcache     (axi0_to_apb0_arcache ),
    .m01_axi_arprot      (axi0_to_apb0_arprot  ),
    .m01_axi_arregion    (axi0_to_apb0_arregion),
    .m01_axi_arqos       (axi0_to_apb0_arqos   ),
    .m01_axi_aruser      (axi0_to_apb0_aruser  ),
    .m01_axi_arvalid     (axi0_to_apb0_arvalid ),
    .m01_axi_arready     (axi0_to_apb0_arready ),
    .m01_axi_rdata       (axi0_to_apb0_rdata   ),
    .m01_axi_rid         (axi0_to_apb0_rid     ),
    .m01_axi_rresp       (axi0_to_apb0_rresp   ),
    .m01_axi_rlast       (axi0_to_apb0_rlast   ),
    .m01_axi_rvalid      (axi0_to_apb0_rvalid  ),
    .m01_axi_ruser       (axi0_to_apb0_ruser   ),
    .m01_axi_rready      (axi0_to_apb0_rready  ),

    .clk                        (AXI_fabric_0_wrapper_clk),
    .rst_n                      (AXI_fabric_0_wrapper_rst_n)
);

axi2apb_0_wrapper axi2apb_0_wrapper_inst
(

    .AWID          (m04_axi_awid     ),
    .AWADDR        (m04_axi_awaddr   ),
    .AWLEN         (m04_axi_awlen    ),
    .AWSIZE        (m04_axi_awsize   ),
    .AWBURST       (m04_axi_awburst  ),
    .AWLOCK        (m04_axi_awlock   ),
    .AWCACHE       (m04_axi_awcache  ),
    .AWPROT        (m04_axi_awprot   ),
    .AWQOS         (m04_axi_awqos    ),
    .AWREGION      (m04_axi_awregion ),
    .AWUSER        (m04_axi_awuser   ),
    .AWVALID       (m04_axi_awvalid  ),
    .AWREADY       (m04_axi_awready  ),
    .WDATA         (m04_axi_wdata    ),
    .WSTRB         (m04_axi_wstrb    ),
    .WLAST         (m04_axi_wlast    ),
    .WUSER         (m04_axi_wuser    ),
    .WVALID        (m04_axi_wvalid   ),
    .WREADY        (m04_axi_wready   ),
    .BID           (m04_axi_bid      ),
    .BRESP         (m04_axi_bresp    ),
    .BUSER         (m04_axi_buser    ),
    .BVALID        (m04_axi_bvalid   ),
    .BREADY        (m04_axi_bready   ),
    .ARID          (m04_axi_arid     ),
    .ARADDR        (m04_axi_araddr   ),
    .ARLEN         (m04_axi_arlen    ),
    .ARSIZE        (m04_axi_arsize   ),
    .ARBURST       (m04_axi_arburst  ),
    .ARLOCK        (m04_axi_arlock   ),
    .ARCACHE       (m04_axi_arcache  ),
    .ARPROT        (m04_axi_arprot   ),
    .ARQOS         (m04_axi_arqos    ),
    .ARREGION      (m04_axi_arregion ),
    .ARUSER        (m04_axi_aruser   ),
    .ARVALID       (m04_axi_arvalid  ),
    .ARREADY       (m04_axi_arready  ),
    .RID           (m04_axi_rid      ),
    .RDATA         (m04_axi_rdata    ),
    .RRESP         (m04_axi_rresp    ),
    .RUSER         (m04_axi_ruser    ),
    .RLAST         (m04_axi_rlast    ),
    .RVALID        (m04_axi_rvalid   ),
    .RREADY        (m04_axi_rready   ),

    .AWID          (m03_axi_awid     ),
    .AWADDR        (m03_axi_awaddr   ),
    .AWLEN         (m03_axi_awlen    ),
    .AWSIZE        (m03_axi_awsize   ),
    .AWBURST       (m03_axi_awburst  ),
    .AWLOCK        (m03_axi_awlock   ),
    .AWCACHE       (m03_axi_awcache  ),
    .AWPROT        (m03_axi_awprot   ),
    .AWQOS         (m03_axi_awqos    ),
    .AWREGION      (m03_axi_awregion ),
    .AWUSER        (m03_axi_awuser   ),
    .AWVALID       (m03_axi_awvalid  ),
    .AWREADY       (m03_axi_awready  ),
    .WDATA         (m03_axi_wdata    ),
    .WSTRB         (m03_axi_wstrb    ),
    .WLAST         (m03_axi_wlast    ),
    .WUSER         (m03_axi_wuser    ),
    .WVALID        (m03_axi_wvalid   ),
    .WREADY        (m03_axi_wready   ),
    .BID           (m03_axi_bid      ),
    .BRESP         (m03_axi_bresp    ),
    .BUSER         (m03_axi_buser    ),
    .BVALID        (m03_axi_bvalid   ),
    .BREADY        (m03_axi_bready   ),
    .ARID          (m03_axi_arid     ),
    .ARADDR        (m03_axi_araddr   ),
    .ARLEN         (m03_axi_arlen    ),
    .ARSIZE        (m03_axi_arsize   ),
    .ARBURST       (m03_axi_arburst  ),
    .ARLOCK        (m03_axi_arlock   ),
    .ARCACHE       (m03_axi_arcache  ),
    .ARPROT        (m03_axi_arprot   ),
    .ARQOS         (m03_axi_arqos    ),
    .ARREGION      (m03_axi_arregion ),
    .ARUSER        (m03_axi_aruser   ),
    .ARVALID       (m03_axi_arvalid  ),
    .ARREADY       (m03_axi_arready  ),
    .RID           (m03_axi_rid      ),
    .RDATA         (m03_axi_rdata    ),
    .RRESP         (m03_axi_rresp    ),
    .RUSER         (m03_axi_ruser    ),
    .RLAST         (m03_axi_rlast    ),
    .RVALID        (m03_axi_rvalid   ),
    .RREADY        (m03_axi_rready   ),

    .AWID          (axi0_to_apb0_awid     ),
    .AWADDR        (axi0_to_apb0_awaddr   ),
    .AWLEN         (axi0_to_apb0_awlen    ),
    .AWSIZE        (axi0_to_apb0_awsize   ),
    .AWBURST       (axi0_to_apb0_awburst  ),
    .AWLOCK        (axi0_to_apb0_awlock   ),
    .AWCACHE       (axi0_to_apb0_awcache  ),
    .AWPROT        (axi0_to_apb0_awprot   ),
    .AWQOS         (axi0_to_apb0_awqos    ),
    .AWREGION      (axi0_to_apb0_awregion ),
    .AWUSER        (axi0_to_apb0_awuser   ),
    .AWVALID       (axi0_to_apb0_awvalid  ),
    .AWREADY       (axi0_to_apb0_awready  ),
    .WDATA         (axi0_to_apb0_wdata    ),
    .WSTRB         (axi0_to_apb0_wstrb    ),
    .WLAST         (axi0_to_apb0_wlast    ),
    .WUSER         (axi0_to_apb0_wuser    ),
    .WVALID        (axi0_to_apb0_wvalid   ),
    .WREADY        (axi0_to_apb0_wready   ),
    .BID           (axi0_to_apb0_bid      ),
    .BRESP         (axi0_to_apb0_bresp    ),
    .BUSER         (axi0_to_apb0_buser    ),
    .BVALID        (axi0_to_apb0_bvalid   ),
    .BREADY        (axi0_to_apb0_bready   ),
    .ARID          (axi0_to_apb0_arid     ),
    .ARADDR        (axi0_to_apb0_araddr   ),
    .ARLEN         (axi0_to_apb0_arlen    ),
    .ARSIZE        (axi0_to_apb0_arsize   ),
    .ARBURST       (axi0_to_apb0_arburst  ),
    .ARLOCK        (axi0_to_apb0_arlock   ),
    .ARCACHE       (axi0_to_apb0_arcache  ),
    .ARPROT        (axi0_to_apb0_arprot   ),
    .ARQOS         (axi0_to_apb0_arqos    ),
    .ARREGION      (axi0_to_apb0_arregion ),
    .ARUSER        (axi0_to_apb0_aruser   ),
    .ARVALID       (axi0_to_apb0_arvalid  ),
    .ARREADY       (axi0_to_apb0_arready  ),
    .RID           (axi0_to_apb0_rid      ),
    .RDATA         (axi0_to_apb0_rdata    ),
    .RRESP         (axi0_to_apb0_rresp    ),
    .RUSER         (axi0_to_apb0_ruser    ),
    .RLAST         (axi0_to_apb0_rlast    ),
    .RVALID        (axi0_to_apb0_rvalid   ),
    .RREADY        (axi0_to_apb0_rready   ),


    .apb_4_PADDR   (s04_apb_PADDR)  ,
    .apb_4_PPROT   (s04_apb_PPROT)  ,
    .apb_4_PSTRB   (s04_apb_PSTRB)  ,
    .apb_4_PSEL    (s04_apb_PSEL)   ,
    .apb_4_PENABLE (s04_apb_PENABLE),
    .apb_4_PWDATA  (s04_apb_PWDATA) ,
    .apb_4_PWRITE  (s04_apb_PWRITE) ,
    .apb_4_PRDATA  (s04_apb_PRDATA) ,
    .apb_4_PREADY  (s04_apb_PREADY) ,
    .apb_4_PSLVERR (s04_apb_PSLVERR),

    .apb_3_PADDR   (s03_apb_PADDR)  ,
    .apb_3_PPROT   (s03_apb_PPROT)  ,
    .apb_3_PSTRB   (s03_apb_PSTRB)  ,
    .apb_3_PSEL    (s03_apb_PSEL)   ,
    .apb_3_PENABLE (s03_apb_PENABLE),
    .apb_3_PWDATA  (s03_apb_PWDATA) ,
    .apb_3_PWRITE  (s03_apb_PWRITE) ,
    .apb_3_PRDATA  (s03_apb_PRDATA) ,
    .apb_3_PREADY  (s03_apb_PREADY) ,
    .apb_3_PSLVERR (s03_apb_PSLVERR),

    .apb_2_PADDR   (s02_apb_PADDR)  ,
    .apb_2_PPROT   (s02_apb_PPROT)  ,
    .apb_2_PSTRB   (s02_apb_PSTRB)  ,
    .apb_2_PSEL    (s02_apb_PSEL)   ,
    .apb_2_PENABLE (s02_apb_PENABLE),
    .apb_2_PWDATA  (s02_apb_PWDATA) ,
    .apb_2_PWRITE  (s02_apb_PWRITE) ,
    .apb_2_PRDATA  (s02_apb_PRDATA) ,
    .apb_2_PREADY  (s02_apb_PREADY) ,
    .apb_2_PSLVERR (s02_apb_PSLVERR),

    .apb_1_PADDR   (s01_apb_PADDR)  ,
    .apb_1_PPROT   (s01_apb_PPROT)  ,
    .apb_1_PSTRB   (s01_apb_PSTRB)  ,
    .apb_1_PSEL    (s01_apb_PSEL)   ,
    .apb_1_PENABLE (s01_apb_PENABLE),
    .apb_1_PWDATA  (s01_apb_PWDATA) ,
    .apb_1_PWRITE  (s01_apb_PWRITE) ,
    .apb_1_PRDATA  (s01_apb_PRDATA) ,
    .apb_1_PREADY  (s01_apb_PREADY) ,
    .apb_1_PSLVERR (s01_apb_PSLVERR),

    .apb_0_PADDR   (s00_apb_PADDR)  ,
    .apb_0_PPROT   (s00_apb_PPROT)  ,
    .apb_0_PSTRB   (s00_apb_PSTRB)  ,
    .apb_0_PSEL    (s00_apb_PSEL)   ,
    .apb_0_PENABLE (s00_apb_PENABLE),
    .apb_0_PWDATA  (s00_apb_PWDATA) ,
    .apb_0_PWRITE  (s00_apb_PWRITE) ,
    .apb_0_PRDATA  (s00_apb_PRDATA) ,
    .apb_0_PREADY  (s00_apb_PREADY) ,
    .apb_0_PSLVERR (s00_apb_PSLVERR),

    .clk          (axi2apb_0_wrapper_clk),
    .rst_n        (axi2apb_0_wrapper_rst_n),
    .PCLK         (axi2apb_0_wrapper_pclk),
    .PRESETn      (axi2apb_0_wrapper_preset_n)
);

axi2apb_1_wrapper axi2apb_1_wrapper_inst
(

    .AWID          (axi0_to_apb1_awid     ),
    .AWADDR        (axi0_to_apb1_awaddr   ),
    .AWLEN         (axi0_to_apb1_awlen    ),
    .AWSIZE        (axi0_to_apb1_awsize   ),
    .AWBURST       (axi0_to_apb1_awburst  ),
    .AWLOCK        (axi0_to_apb1_awlock   ),
    .AWCACHE       (axi0_to_apb1_awcache  ),
    .AWPROT        (axi0_to_apb1_awprot   ),
    .AWQOS         (axi0_to_apb1_awqos    ),
    .AWREGION      (axi0_to_apb1_awregion ),
    .AWUSER        (axi0_to_apb1_awuser   ),
    .AWVALID       (axi0_to_apb1_awvalid  ),
    .AWREADY       (axi0_to_apb1_awready  ),
    .WDATA         (axi0_to_apb1_wdata    ),
    .WSTRB         (axi0_to_apb1_wstrb    ),
    .WLAST         (axi0_to_apb1_wlast    ),
    .WUSER         (axi0_to_apb1_wuser    ),
    .WVALID        (axi0_to_apb1_wvalid   ),
    .WREADY        (axi0_to_apb1_wready   ),
    .BID           (axi0_to_apb1_bid      ),
    .BRESP         (axi0_to_apb1_bresp    ),
    .BUSER         (axi0_to_apb1_buser    ),
    .BVALID        (axi0_to_apb1_bvalid   ),
    .BREADY        (axi0_to_apb1_bready   ),
    .ARID          (axi0_to_apb1_arid     ),
    .ARADDR        (axi0_to_apb1_araddr   ),
    .ARLEN         (axi0_to_apb1_arlen    ),
    .ARSIZE        (axi0_to_apb1_arsize   ),
    .ARBURST       (axi0_to_apb1_arburst  ),
    .ARLOCK        (axi0_to_apb1_arlock   ),
    .ARCACHE       (axi0_to_apb1_arcache  ),
    .ARPROT        (axi0_to_apb1_arprot   ),
    .ARQOS         (axi0_to_apb1_arqos    ),
    .ARREGION      (axi0_to_apb1_arregion ),
    .ARUSER        (axi0_to_apb1_aruser   ),
    .ARVALID       (axi0_to_apb1_arvalid  ),
    .ARREADY       (axi0_to_apb1_arready  ),
    .RID           (axi0_to_apb1_rid      ),
    .RDATA         (axi0_to_apb1_rdata    ),
    .RRESP         (axi0_to_apb1_rresp    ),
    .RUSER         (axi0_to_apb1_ruser    ),
    .RLAST         (axi0_to_apb1_rlast    ),
    .RVALID        (axi0_to_apb1_rvalid   ),
    .RREADY        (axi0_to_apb1_rready   ),


    .apb_4_PADDR   (s09_apb_PADDR)  ,
    .apb_4_PPROT   (s09_apb_PPROT)  ,
    .apb_4_PSTRB   (s09_apb_PSTRB)  ,
    .apb_4_PSEL    (s09_apb_PSEL)   ,
    .apb_4_PENABLE (s09_apb_PENABLE),
    .apb_4_PWDATA  (s09_apb_PWDATA) ,
    .apb_4_PWRITE  (s09_apb_PWRITE) ,
    .apb_4_PRDATA  (s09_apb_PRDATA) ,
    .apb_4_PREADY  (s09_apb_PREADY) ,
    .apb_4_PSLVERR (s09_apb_PSLVERR),

    .apb_3_PADDR   (s08_apb_PADDR)  ,
    .apb_3_PPROT   (s08_apb_PPROT)  ,
    .apb_3_PSTRB   (s08_apb_PSTRB)  ,
    .apb_3_PSEL    (s08_apb_PSEL)   ,
    .apb_3_PENABLE (s08_apb_PENABLE),
    .apb_3_PWDATA  (s08_apb_PWDATA) ,
    .apb_3_PWRITE  (s08_apb_PWRITE) ,
    .apb_3_PRDATA  (s08_apb_PRDATA) ,
    .apb_3_PREADY  (s08_apb_PREADY) ,
    .apb_3_PSLVERR (s08_apb_PSLVERR),

    .apb_2_PADDR   (s07_apb_PADDR)  ,
    .apb_2_PPROT   (s07_apb_PPROT)  ,
    .apb_2_PSTRB   (s07_apb_PSTRB)  ,
    .apb_2_PSEL    (s07_apb_PSEL)   ,
    .apb_2_PENABLE (s07_apb_PENABLE),
    .apb_2_PWDATA  (s07_apb_PWDATA) ,
    .apb_2_PWRITE  (s07_apb_PWRITE) ,
    .apb_2_PRDATA  (s07_apb_PRDATA) ,
    .apb_2_PREADY  (s07_apb_PREADY) ,
    .apb_2_PSLVERR (s07_apb_PSLVERR),

    .apb_1_PADDR   (s06_apb_PADDR)  ,
    .apb_1_PPROT   (s06_apb_PPROT)  ,
    .apb_1_PSTRB   (s06_apb_PSTRB)  ,
    .apb_1_PSEL    (s06_apb_PSEL)   ,
    .apb_1_PENABLE (s06_apb_PENABLE),
    .apb_1_PWDATA  (s06_apb_PWDATA) ,
    .apb_1_PWRITE  (s06_apb_PWRITE) ,
    .apb_1_PRDATA  (s06_apb_PRDATA) ,
    .apb_1_PREADY  (s06_apb_PREADY) ,
    .apb_1_PSLVERR (s06_apb_PSLVERR),

    .apb_0_PADDR   (s05_apb_PADDR)  ,
    .apb_0_PPROT   (s05_apb_PPROT)  ,
    .apb_0_PSTRB   (s05_apb_PSTRB)  ,
    .apb_0_PSEL    (s05_apb_PSEL)   ,
    .apb_0_PENABLE (s05_apb_PENABLE),
    .apb_0_PWDATA  (s05_apb_PWDATA) ,
    .apb_0_PWRITE  (s05_apb_PWRITE) ,
    .apb_0_PRDATA  (s05_apb_PRDATA) ,
    .apb_0_PREADY  (s05_apb_PREADY) ,
    .apb_0_PSLVERR (s05_apb_PSLVERR),

    .clk          (axi2apb_1_wrapper_clk),
    .rst_n        (axi2apb_1_wrapper_rst_n),
    .PCLK         (axi2apb_1_wrapper_pclk),
    .PRESETn      (axi2apb_1_wrapper_preset_n)
);
endmodule