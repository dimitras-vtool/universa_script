module axi_fabric_top_wrapper
#(
    parameter SLAVE_N           = 3,
    parameter MASTER_N          = 4,
    parameter ADDR_WIDTH        = 32,
    parameter DATA_WIDTH        = 64,
    parameter S_ID_WIDTH        = 4,
    parameter M_ID_WIDTH        = 6,
    parameter STRB_WIDTH        = 8,
    parameter AW_USER_WIDTH     = 4,
    parameter W_USER_WIDTH      = 4,
    parameter B_USER_WIDTH      = 4,
    parameter AR_USER_WIDTH     = 4,
    parameter R_USER_WIDTH      = 4,
    parameter ARBITER_TYPE      = 0,
    parameter MAX_TRANS         = 16,
    parameter S_AR_CHANNEL_REG  = 0,
    parameter M_AR_CHANNEL_REG  = 0,
    parameter S_R_CHANNEL_REG   = 0,
    parameter M_R_CHANNEL_REG   = 0,
    parameter S_AW_CHANNEL_REG  = 0,
    parameter M_AW_CHANNEL_REG  = 0,
    parameter S_W_CHANNEL_REG   = 0,
    parameter M_W_CHANNEL_REG   = 0,
    parameter S_WR_CHANNEL_REG  = 0,
    parameter M_WR_CHANNEL_REG  = 0
)
(
    input  wire                     clk,
    input  wire                     rst_n,

    //-------------------------- s00 AXI signals--------------------------
    // AXI Write Channels
    input  wire [S_ID_WIDTH-1:0]      s00_axi_awid,
    input  wire [ADDR_WIDTH-1:0]    s00_axi_awaddr,
    input  wire [8-1:0]             s00_axi_awlen,
    input  wire [3-1:0]             s00_axi_awsize,
    input  wire [2-1:0]             s00_axi_awburst,
    input  wire                     s00_axi_awlock,
    input  wire [4-1:0]             s00_axi_awcache,
    input  wire [3-1:0]             s00_axi_awprot,
    //input  wire [3:0]               s00_axi_awregion,
    input  wire [4-1:0]             s00_axi_awqos,
    input  wire [AW_USER_WIDTH-1:0]    s00_axi_awuser,
    input  wire                     s00_axi_awvalid,
    output wire                     s00_axi_awready,

    input  wire [DATA_WIDTH-1:0]    s00_axi_wdata,
    input  wire [STRB_WIDTH-1:0]    s00_axi_wstrb,
    input  wire [W_USER_WIDTH-1:0]    s00_axi_wuser,
    input  wire                     s00_axi_wvalid,
    output wire                     s00_axi_wready,
    input  wire                     s00_axi_wlast,

    output wire [S_ID_WIDTH-1:0]      s00_axi_bid,
    output wire [B_USER_WIDTH-1:0]    s00_axi_buser,
    output wire [2-1:0]             s00_axi_bresp,
    output wire                     s00_axi_bvalid,
    input  wire                     s00_axi_bready,

    // AXI Read Channels
    input  wire [S_ID_WIDTH-1:0]      s00_axi_arid,
    input  wire [ADDR_WIDTH-1:0]    s00_axi_araddr,
    input  wire [AR_USER_WIDTH-1:0]    s00_axi_aruser,
    input  wire [8-1:0]             s00_axi_arlen,
    input  wire [3-1:0]             s00_axi_arsize,
    input  wire [2-1:0]             s00_axi_arburst,
    input  wire                     s00_axi_arlock,
    input  wire [4-1:0]             s00_axi_arcache,
    input  wire [3-1:0]             s00_axi_arprot,
    //input  wire [3:0]               s00_axi_arregion,
    input  wire [4-1:0]             s00_axi_arqos,
    input  wire                     s00_axi_arvalid,
    output wire                     s00_axi_arready,

    output wire [DATA_WIDTH-1:0]    s00_axi_rdata,
    output wire [S_ID_WIDTH-1:0]      s00_axi_rid,
    output wire [2-1:0]             s00_axi_rresp,
    output wire                     s00_axi_rlast,
    output wire                     s00_axi_rvalid,
    output wire [R_USER_WIDTH-1:0]    s00_axi_ruser,
    input  wire                     s00_axi_rready,

    //-------------------------- s01 AXI signals--------------------------
    // AXI Write Channels
    input  wire [S_ID_WIDTH-1:0]      s01_axi_awid,
    input  wire [ADDR_WIDTH-1:0]    s01_axi_awaddr,
    input  wire [AW_USER_WIDTH-1:0]    s01_axi_awuser,
    input  wire [8-1:0]             s01_axi_awlen,
    input  wire [3-1:0]             s01_axi_awsize,
    input  wire [2-1:0]             s01_axi_awburst,
    input  wire                     s01_axi_awlock,
    input  wire [4-1:0]             s01_axi_awcache,
    input  wire [3-1:0]             s01_axi_awprot,
    //input  wire [3:0]               s01_axi_awregion,
    input  wire [4-1:0]             s01_axi_awqos,
    input  wire                     s01_axi_awvalid,
    output wire                     s01_axi_awready,

    input  wire [DATA_WIDTH-1:0]    s01_axi_wdata,
    input  wire [W_USER_WIDTH-1:0]    s01_axi_wuser,
    input  wire [STRB_WIDTH-1:0]    s01_axi_wstrb,
    input  wire                     s01_axi_wvalid,
    output wire                     s01_axi_wready,
    input  wire                     s01_axi_wlast,

    output wire [S_ID_WIDTH-1:0]      s01_axi_bid,
    output wire [B_USER_WIDTH-1:0]    s01_axi_buser,
    output wire [2-1:0]             s01_axi_bresp,
    output wire                     s01_axi_bvalid,
    input  wire                     s01_axi_bready,

    // AXI Read Channels
    input  wire [S_ID_WIDTH-1:0]      s01_axi_arid,
    input  wire [ADDR_WIDTH-1:0]    s01_axi_araddr,
    input  wire [AR_USER_WIDTH-1:0]    s01_axi_aruser,
    input  wire [8-1:0]             s01_axi_arlen,
    input  wire [3-1:0]             s01_axi_arsize,
    input  wire [2-1:0]             s01_axi_arburst,
    input  wire                     s01_axi_arlock,
    input  wire [4-1:0]             s01_axi_arcache,
    input  wire [3-1:0]             s01_axi_arprot,
    //input  wire [3:0]               s01_axi_arregion,
    input  wire [4-1:0]             s01_axi_arqos,
    input  wire                     s01_axi_arvalid,
    output wire                     s01_axi_arready,

    output wire [DATA_WIDTH-1:0]    s01_axi_rdata,
    output wire [S_ID_WIDTH-1:0]      s01_axi_rid,
    output wire [2-1:0]             s01_axi_rresp,
    output wire                     s01_axi_rlast,
    output wire                     s01_axi_rvalid,
    output wire [R_USER_WIDTH-1:0]    s01_axi_ruser,
    input  wire                     s01_axi_rready,

    //-------------------------- s02 AXI signals--------------------------
    // AXI Write Channels
    input  wire [S_ID_WIDTH-1:0]      s02_axi_awid,
    input  wire [ADDR_WIDTH-1:0]    s02_axi_awaddr,
    input  wire [AW_USER_WIDTH-1:0]    s02_axi_awuser,
    input  wire [8-1:0]             s02_axi_awlen,
    input  wire [3-1:0]             s02_axi_awsize,
    input  wire [2-1:0]             s02_axi_awburst,
    input  wire                     s02_axi_awlock,
    input  wire [4-1:0]             s02_axi_awcache,
    input  wire [3-1:0]             s02_axi_awprot,
    //input  wire [3:0]               s02_axi_awregion,
    input  wire [4-1:0]             s02_axi_awqos,
    input  wire                     s02_axi_awvalid,
    output wire                     s02_axi_awready,

    input  wire [DATA_WIDTH-1:0]    s02_axi_wdata,
    input  wire [W_USER_WIDTH-1:0]    s02_axi_wuser,
    input  wire [STRB_WIDTH-1:0]    s02_axi_wstrb,
    input  wire                     s02_axi_wvalid,
    output wire                     s02_axi_wready,
    input  wire                     s02_axi_wlast,

    output wire [S_ID_WIDTH-1:0]      s02_axi_bid,
    output wire [B_USER_WIDTH-1:0]    s02_axi_buser,
    output wire [2-1:0]             s02_axi_bresp,
    output wire                     s02_axi_bvalid,
    input  wire                     s02_axi_bready,

    // AXI Read Channels
    input  wire [S_ID_WIDTH-1:0]      s02_axi_arid,
    input  wire [ADDR_WIDTH-1:0]    s02_axi_araddr,
    input  wire [AR_USER_WIDTH-1:0]    s02_axi_aruser,
    input  wire [8-1:0]             s02_axi_arlen,
    input  wire [3-1:0]             s02_axi_arsize,
    input  wire [2-1:0]             s02_axi_arburst,
    input  wire                     s02_axi_arlock,
    input  wire [4-1:0]             s02_axi_arcache,
    input  wire [3-1:0]             s02_axi_arprot,
    //input  wire [3:0]               s02_axi_arregion,
    input  wire [4-1:0]             s02_axi_arqos,
    input  wire                     s02_axi_arvalid,
    output wire                     s02_axi_arready,

    output wire [DATA_WIDTH-1:0]    s02_axi_rdata,
    output wire [S_ID_WIDTH-1:0]      s02_axi_rid,
    output wire [2-1:0]             s02_axi_rresp,
    output wire                     s02_axi_rlast,
    output wire                     s02_axi_rvalid,
    output wire [R_USER_WIDTH-1:0]    s02_axi_ruser,
    input  wire                     s02_axi_rready,

    //-------------------------- m00 AXI signals--------------------------
    // AXI Write Channels
    output wire [M_ID_WIDTH-1:0]      m00_axi_awid,
    output wire [ADDR_WIDTH-1:0]    m00_axi_awaddr,
    output wire [8-1:0]             m00_axi_awlen,
    output wire [3-1:0]             m00_axi_awsize,
    output wire [2-1:0]             m00_axi_awburst,
    output wire                     m00_axi_awlock,
    output wire [4-1:0]             m00_axi_awcache,
    output wire [3-1:0]             m00_axi_awprot,
    output wire [3:0]               m00_axi_awregion,
    output wire [4-1:0]             m00_axi_awqos,
    output wire [AW_USER_WIDTH- 1 : 0] m00_axi_awuser,
    output wire                     m00_axi_awvalid,
    input  wire                     m00_axi_awready,

    output wire [DATA_WIDTH-1:0]    m00_axi_wdata,
    output wire [STRB_WIDTH-1:0]    m00_axi_wstrb,
    output wire [W_USER_WIDTH- 1 : 0] m00_axi_wuser,
    output wire                     m00_axi_wvalid,
    input  wire                     m00_axi_wready,
    output wire                     m00_axi_wlast,

    input  wire [M_ID_WIDTH-1:0]      m00_axi_bid,
    input  wire [B_USER_WIDTH- 1 : 0] m00_axi_buser,
    input  wire [2-1:0]             m00_axi_bresp,
    input  wire                     m00_axi_bvalid,
    output wire                     m00_axi_bready,

    // AXI Read Channels
    output wire [ADDR_WIDTH-1:0]    m00_axi_araddr,
    output wire [M_ID_WIDTH-1:0]      m00_axi_arid,
    output wire [8-1:0]             m00_axi_arlen,
    output wire [3-1:0]             m00_axi_arsize,
    output wire [2-1:0]             m00_axi_arburst,
    output wire                     m00_axi_arlock,
    output wire [4-1:0]             m00_axi_arcache,
    output wire [3-1:0]             m00_axi_arprot,
    output wire [3:0]               m00_axi_arregion,
    output wire [4-1:0]             m00_axi_arqos,
    output wire [AR_USER_WIDTH- 1 : 0] m00_axi_aruser,
    output wire                     m00_axi_arvalid,
    input  wire                     m00_axi_arready,

    input  wire [DATA_WIDTH-1:0]    m00_axi_rdata,
    input  wire [M_ID_WIDTH-1:0]      m00_axi_rid,
    input  wire [2-1:0]             m00_axi_rresp,
    input  wire                     m00_axi_rlast,
    input  wire                     m00_axi_rvalid,
    input  wire [R_USER_WIDTH- 1 : 0] m00_axi_ruser,
    output wire                     m00_axi_rready,

    //-------------------------- m01 AXI signals--------------------------
    // AXI Write Channels
    output wire [M_ID_WIDTH-1:0]      m01_axi_awid,
    output wire [ADDR_WIDTH-1:0]    m01_axi_awaddr,
    output wire [8-1:0]             m01_axi_awlen,
    output wire [3-1:0]             m01_axi_awsize,
    output wire [2-1:0]             m01_axi_awburst,
    output wire                     m01_axi_awlock,
    output wire [4-1:0]             m01_axi_awcache,
    output wire [3-1:0]             m01_axi_awprot,
    output wire [3:0]               m01_axi_awregion,
    output wire [4-1:0]             m01_axi_awqos,
    output wire [AW_USER_WIDTH- 1 : 0] m01_axi_awuser,
    output wire                     m01_axi_awvalid,
    input  wire                     m01_axi_awready,

    output wire [DATA_WIDTH-1:0]    m01_axi_wdata,
    output wire [STRB_WIDTH-1:0]    m01_axi_wstrb,
    output wire [W_USER_WIDTH- 1 : 0] m01_axi_wuser,
    output wire                     m01_axi_wvalid,
    input  wire                     m01_axi_wready,
    output wire                     m01_axi_wlast,

    input  wire [M_ID_WIDTH-1:0]      m01_axi_bid,
    input  wire [B_USER_WIDTH- 1 : 0] m01_axi_buser,
    input  wire [2-1:0]             m01_axi_bresp,
    input  wire                     m01_axi_bvalid,
    output wire                     m01_axi_bready,

    // AXI Read Channels
    output wire [ADDR_WIDTH-1:0]    m01_axi_araddr,
    output wire [M_ID_WIDTH-1:0]      m01_axi_arid,
    output wire [8-1:0]             m01_axi_arlen,
    output wire [3-1:0]             m01_axi_arsize,
    output wire [2-1:0]             m01_axi_arburst,
    output wire                     m01_axi_arlock,
    output wire [4-1:0]             m01_axi_arcache,
    output wire [3-1:0]             m01_axi_arprot,
    output wire [3:0]               m01_axi_arregion,
    output wire [4-1:0]             m01_axi_arqos,
    output wire [AR_USER_WIDTH- 1 : 0] m01_axi_aruser,
    output wire                     m01_axi_arvalid,
    input  wire                     m01_axi_arready,

    input  wire [DATA_WIDTH-1:0]    m01_axi_rdata,
    input  wire [M_ID_WIDTH-1:0]      m01_axi_rid,
    input  wire [2-1:0]             m01_axi_rresp,
    input  wire                     m01_axi_rlast,
    input  wire                     m01_axi_rvalid,
    input  wire [R_USER_WIDTH- 1 : 0] m01_axi_ruser,
    output wire                     m01_axi_rready,

    //-------------------------- m02 AXI signals--------------------------
    // AXI Write Channels
    output wire [M_ID_WIDTH-1:0]      m02_axi_awid,
    output wire [ADDR_WIDTH-1:0]    m02_axi_awaddr,
    output wire [8-1:0]             m02_axi_awlen,
    output wire [3-1:0]             m02_axi_awsize,
    output wire [2-1:0]             m02_axi_awburst,
    output wire                     m02_axi_awlock,
    output wire [4-1:0]             m02_axi_awcache,
    output wire [3-1:0]             m02_axi_awprot,
    output wire [3:0]               m02_axi_awregion,
    output wire [4-1:0]             m02_axi_awqos,
    output wire [AW_USER_WIDTH- 1 : 0] m02_axi_awuser,
    output wire                     m02_axi_awvalid,
    input  wire                     m02_axi_awready,

    output wire [DATA_WIDTH-1:0]    m02_axi_wdata,
    output wire [STRB_WIDTH-1:0]    m02_axi_wstrb,
    output wire [W_USER_WIDTH- 1 : 0] m02_axi_wuser,
    output wire                     m02_axi_wvalid,
    input  wire                     m02_axi_wready,
    output wire                     m02_axi_wlast,

    input  wire [M_ID_WIDTH-1:0]      m02_axi_bid,
    input  wire [B_USER_WIDTH- 1 : 0] m02_axi_buser,
    input  wire [2-1:0]             m02_axi_bresp,
    input  wire                     m02_axi_bvalid,
    output wire                     m02_axi_bready,

    // AXI Read Channels
    output wire [ADDR_WIDTH-1:0]    m02_axi_araddr,
    output wire [M_ID_WIDTH-1:0]      m02_axi_arid,
    output wire [8-1:0]             m02_axi_arlen,
    output wire [3-1:0]             m02_axi_arsize,
    output wire [2-1:0]             m02_axi_arburst,
    output wire                     m02_axi_arlock,
    output wire [4-1:0]             m02_axi_arcache,
    output wire [3-1:0]             m02_axi_arprot,
    output wire [3:0]               m02_axi_arregion,
    output wire [4-1:0]             m02_axi_arqos,
    output wire [AR_USER_WIDTH- 1 : 0] m02_axi_aruser,
    output wire                     m02_axi_arvalid,
    input  wire                     m02_axi_arready,

    input  wire [DATA_WIDTH-1:0]    m02_axi_rdata,
    input  wire [M_ID_WIDTH-1:0]      m02_axi_rid,
    input  wire [2-1:0]             m02_axi_rresp,
    input  wire                     m02_axi_rlast,
    input  wire                     m02_axi_rvalid,
    input  wire [R_USER_WIDTH- 1 : 0] m02_axi_ruser,
    output wire                     m02_axi_rready,

    //-------------------------- m03 AXI signals--------------------------
    // AXI Write Channels
    output wire [M_ID_WIDTH-1:0]      m03_axi_awid,
    output wire [ADDR_WIDTH-1:0]    m03_axi_awaddr,
    output wire [8-1:0]             m03_axi_awlen,
    output wire [3-1:0]             m03_axi_awsize,
    output wire [2-1:0]             m03_axi_awburst,
    output wire                     m03_axi_awlock,
    output wire [4-1:0]             m03_axi_awcache,
    output wire [3-1:0]             m03_axi_awprot,
    output wire [3:0]               m03_axi_awregion,
    output wire [4-1:0]             m03_axi_awqos,
    output wire [AW_USER_WIDTH- 1 : 0] m03_axi_awuser,
    output wire                     m03_axi_awvalid,
    input  wire                     m03_axi_awready,

    output wire [DATA_WIDTH-1:0]    m03_axi_wdata,
    output wire [STRB_WIDTH-1:0]    m03_axi_wstrb,
    output wire [W_USER_WIDTH- 1 : 0] m03_axi_wuser,
    output wire                     m03_axi_wvalid,
    input  wire                     m03_axi_wready,
    output wire                     m03_axi_wlast,

    input  wire [M_ID_WIDTH-1:0]      m03_axi_bid,
    input  wire [B_USER_WIDTH- 1 : 0] m03_axi_buser,
    input  wire [2-1:0]             m03_axi_bresp,
    input  wire                     m03_axi_bvalid,
    output wire                     m03_axi_bready,

    // AXI Read Channels
    output wire [ADDR_WIDTH-1:0]    m03_axi_araddr,
    output wire [M_ID_WIDTH-1:0]      m03_axi_arid,
    output wire [8-1:0]             m03_axi_arlen,
    output wire [3-1:0]             m03_axi_arsize,
    output wire [2-1:0]             m03_axi_arburst,
    output wire                     m03_axi_arlock,
    output wire [4-1:0]             m03_axi_arcache,
    output wire [3-1:0]             m03_axi_arprot,
    output wire [3:0]               m03_axi_arregion,
    output wire [4-1:0]             m03_axi_arqos,
    output wire [AR_USER_WIDTH- 1 : 0] m03_axi_aruser,
    output wire                     m03_axi_arvalid,
    input  wire                     m03_axi_arready,

    input  wire [DATA_WIDTH-1:0]    m03_axi_rdata,
    input  wire [M_ID_WIDTH-1:0]      m03_axi_rid,
    input  wire [2-1:0]             m03_axi_rresp,
    input  wire                     m03_axi_rlast,
    input  wire                     m03_axi_rvalid,
    input  wire [R_USER_WIDTH- 1 : 0] m03_axi_ruser,
    output wire                     m03_axi_rready
);

axi_fabric_top
#(
    .SLAVE_N           (SLAVE_N),
    .MASTER_N          (MASTER_N),
    .ADDR_WIDTH        (ADDR_WIDTH),
    .DATA_WIDTH        (DATA_WIDTH),
    .S_ID_WIDTH        (S_ID_WIDTH),
    .M_ID_WIDTH        (M_ID_WIDTH),
    .STRB_WIDTH        (STRB_WIDTH),
    .AW_USER_WIDTH     (AW_USER_WIDTH),
    .W_USER_WIDTH      (W_USER_WIDTH),
    .B_USER_WIDTH      (B_USER_WIDTH),
    .AR_USER_WIDTH     (AR_USER_WIDTH),
    .R_USER_WIDTH      (R_USER_WIDTH),
    .ARBITER_TYPE      (ARBITER_TYPE),
    .MAX_TRANS         (MAX_TRANS),
    .S_AR_CHANNEL_REG  (S_AR_CHANNEL_REG),
    .M_AR_CHANNEL_REG  (M_AR_CHANNEL_REG),
    .S_R_CHANNEL_REG   (S_R_CHANNEL_REG),
    .M_R_CHANNEL_REG   (M_R_CHANNEL_REG),
    .S_AW_CHANNEL_REG  (S_AW_CHANNEL_REG),
    .M_AW_CHANNEL_REG  (M_AW_CHANNEL_REG),
    .S_W_CHANNEL_REG   (S_W_CHANNEL_REG),
    .M_W_CHANNEL_REG   (M_W_CHANNEL_REG),
    .S_WR_CHANNEL_REG  (S_WR_CHANNEL_REG),
    .M_WR_CHANNEL_REG  (M_WR_CHANNEL_REG)
)
axi_fabric_top_inst
(
    .clk              (clk),
    .reset_n          (rst_n),
    .s_axi_awvalid    ({s02_axi_awvalid,        s01_axi_awvalid,    s00_axi_awvalid    }),
    .s_axi_awready    ({s02_axi_awready,        s01_axi_awready,    s00_axi_awready    }),
    .s_axi_awaddr     ({s02_axi_awaddr,         s01_axi_awaddr,     s00_axi_awaddr     }),
    .s_axi_awsize     ({s02_axi_awsize,         s01_axi_awsize,     s00_axi_awsize     }),
    .s_axi_awburst    ({s02_axi_awburst,        s01_axi_awburst,    s00_axi_awburst    }),
    .s_axi_awcache    ({s02_axi_awcache,        s01_axi_awcache,    s00_axi_awcache    }),
    .s_axi_awprot     ({s02_axi_awprot,         s01_axi_awprot,     s00_axi_awprot     }),
    .s_axi_awid       ({s02_axi_awid,           s01_axi_awid,       s00_axi_awid       }),
    .s_axi_awlen      ({s02_axi_awlen,          s01_axi_awlen,      s00_axi_awlen      }),
    .s_axi_awlock     ({s02_axi_awlock,         s01_axi_awlock,     s00_axi_awlock     }),
    .s_axi_awqos      ({s02_axi_awqos,          s01_axi_awqos,      s00_axi_awqos      }),
    .s_axi_awuser     ({s02_axi_awuser,         s01_axi_awuser,     s00_axi_awuser     }),
    .s_axi_wvalid     ({s02_axi_wvalid,         s01_axi_wvalid,     s00_axi_wvalid     }),
    .s_axi_wlast      ({s02_axi_wlast,          s01_axi_wlast,      s00_axi_wlast      }),
    .s_axi_wready     ({s02_axi_wready,         s01_axi_wready,     s00_axi_wready     }),
    .s_axi_wdata      ({s02_axi_wdata,          s01_axi_wdata,      s00_axi_wdata      }),
    .s_axi_wstrb      ({s02_axi_wstrb,          s01_axi_wstrb,      s00_axi_wstrb      }),
    .s_axi_wuser      ({s02_axi_wuser,          s01_axi_wuser,      s00_axi_wuser      }),
    .s_axi_bvalid     ({s02_axi_bvalid,         s01_axi_bvalid,     s00_axi_bvalid     }),
    .s_axi_bready     ({s02_axi_bready,         s01_axi_bready,     s00_axi_bready     }),
    .s_axi_bresp      ({s02_axi_bresp,          s01_axi_bresp,      s00_axi_bresp      }),
    .s_axi_bid        ({s02_axi_bid,            s01_axi_bid,        s00_axi_bid        }),
    .s_axi_buser      ({s02_axi_buser,          s01_axi_buser,      s00_axi_buser      }),
    .s_axi_arvalid    ({s02_axi_arvalid,        s01_axi_arvalid,    s00_axi_arvalid    }),
    .s_axi_arready    ({s02_axi_arready,        s01_axi_arready,    s00_axi_arready    }),
    .s_axi_araddr     ({s02_axi_araddr,         s01_axi_araddr,     s00_axi_araddr     }),
    .s_axi_arsize     ({s02_axi_arsize,         s01_axi_arsize,     s00_axi_arsize     }),
    .s_axi_arburst    ({s02_axi_arburst,        s01_axi_arburst,    s00_axi_arburst    }),
    .s_axi_arcache    ({s02_axi_arcache,        s01_axi_arcache,    s00_axi_arcache    }),
    .s_axi_arprot     ({s02_axi_arprot,         s01_axi_arprot,     s00_axi_arprot     }),
    .s_axi_arid       ({s02_axi_arid,           s01_axi_arid,       s00_axi_arid       }),
    .s_axi_arlen      ({s02_axi_arlen,          s01_axi_arlen,      s00_axi_arlen      }),
    .s_axi_arlock     ({s02_axi_arlock,         s01_axi_arlock,     s00_axi_arlock     }),
    .s_axi_arqos      ({s02_axi_arqos,          s01_axi_arqos,      s00_axi_arqos      }),
    .s_axi_aruser     ({s02_axi_aruser,         s01_axi_aruser,     s00_axi_aruser     }),
    .s_axi_rvalid     ({s02_axi_rvalid,         s01_axi_rvalid,     s00_axi_rvalid     }),
    .s_axi_rready     ({s02_axi_rready,         s01_axi_rready,     s00_axi_rready     }),
    .s_axi_rlast      ({s02_axi_rlast,          s01_axi_rlast,      s00_axi_rlast      }),
    .s_axi_rdata      ({s02_axi_rdata,          s01_axi_rdata,      s00_axi_rdata      }),
    .s_axi_rresp      ({s02_axi_rresp,          s01_axi_rresp,      s00_axi_rresp      }),
    .s_axi_rid        ({s02_axi_rid,            s01_axi_rid,        s00_axi_rid        }),
    .s_axi_ruser      ({s02_axi_ruser,          s01_axi_ruser,      s00_axi_ruser      }),

    .m_axi_awvalid    ({m03_axi_awvalid,        m02_axi_awvalid,        m01_axi_awvalid,    m00_axi_awvalid    }),
    .m_axi_awready    ({m03_axi_awready,        m02_axi_awready,        m01_axi_awready,    m00_axi_awready    }),
    .m_axi_awaddr     ({m03_axi_awaddr,         m02_axi_awaddr,         m01_axi_awaddr,     m00_axi_awaddr     }),
    .m_axi_awsize     ({m03_axi_awsize,         m02_axi_awsize,         m01_axi_awsize,     m00_axi_awsize     }),
    .m_axi_awburst    ({m03_axi_awburst,        m02_axi_awburst,        m01_axi_awburst,    m00_axi_awburst    }),
    .m_axi_awcache    ({m03_axi_awcache,        m02_axi_awcache,        m01_axi_awcache,    m00_axi_awcache    }),
    .m_axi_awprot     ({m03_axi_awprot,         m02_axi_awprot,         m01_axi_awprot,     m00_axi_awprot     }),
    .m_axi_awid       ({m03_axi_awid,           m02_axi_awid,           m01_axi_awid,       m00_axi_awid       }),
    .m_axi_awlen      ({m03_axi_awlen,          m02_axi_awlen,          m01_axi_awlen,      m00_axi_awlen      }),
    .m_axi_awlock     ({m03_axi_awlock,         m02_axi_awlock,         m01_axi_awlock,     m00_axi_awlock     }),
    .m_axi_awqos      ({m03_axi_awqos,          m02_axi_awqos,          m01_axi_awqos,      m00_axi_awqos      }),
    .m_axi_awregion   ({m03_axi_awregion,       m02_axi_awregion,       m01_axi_awregion,   m00_axi_awregion   }),
    .m_axi_awuser     ({m03_axi_awuser,         m02_axi_awuser,         m01_axi_awuser,     m00_axi_awuser     }),
    .m_axi_wvalid     ({m03_axi_wvalid,         m02_axi_wvalid,         m01_axi_wvalid,     m00_axi_wvalid     }),
    .m_axi_wready     ({m03_axi_wready,         m02_axi_wready,         m01_axi_wready,     m00_axi_wready     }),
    .m_axi_wlast      ({m03_axi_wlast,          m02_axi_wlast,          m01_axi_wlast,      m00_axi_wlast      }),
    .m_axi_wdata      ({m03_axi_wdata,          m02_axi_wdata,          m01_axi_wdata,      m00_axi_wdata      }),
    .m_axi_wstrb      ({m03_axi_wstrb,          m02_axi_wstrb,          m01_axi_wstrb,      m00_axi_wstrb      }),
    .m_axi_wuser      ({m03_axi_wuser,          m02_axi_wuser,          m01_axi_wuser,      m00_axi_wuser      }),
    .m_axi_bvalid     ({m03_axi_bvalid,         m02_axi_bvalid,         m01_axi_bvalid,     m00_axi_bvalid     }),
    .m_axi_bready     ({m03_axi_bready,         m02_axi_bready,         m01_axi_bready,     m00_axi_bready     }),
    .m_axi_bresp      ({m03_axi_bresp,          m02_axi_bresp,          m01_axi_bresp,      m00_axi_bresp      }),
    .m_axi_bid        ({m03_axi_bid,            m02_axi_bid,            m01_axi_bid,        m00_axi_bid        }),
    .m_axi_buser      ({m03_axi_buser,          m02_axi_buser,          m01_axi_buser,      m00_axi_buser      }),
    .m_axi_arvalid    ({m03_axi_arvalid,        m02_axi_arvalid,        m01_axi_arvalid,    m00_axi_arvalid    }),
    .m_axi_arready    ({m03_axi_arready,        m02_axi_arready,        m01_axi_arready,    m00_axi_arready    }),
    .m_axi_araddr     ({m03_axi_araddr,         m02_axi_araddr,         m01_axi_araddr,     m00_axi_araddr     }),
    .m_axi_arsize     ({m03_axi_arsize,         m02_axi_arsize,         m01_axi_arsize,     m00_axi_arsize     }),
    .m_axi_arburst    ({m03_axi_arburst,        m02_axi_arburst,        m01_axi_arburst,    m00_axi_arburst    }),
    .m_axi_arcache    ({m03_axi_arcache,        m02_axi_arcache,        m01_axi_arcache,    m00_axi_arcache    }),
    .m_axi_arprot     ({m03_axi_arprot,         m02_axi_arprot,         m01_axi_arprot,     m00_axi_arprot     }),
    .m_axi_arid       ({m03_axi_arid,           m02_axi_arid,           m01_axi_arid,       m00_axi_arid       }),
    .m_axi_arlen      ({m03_axi_arlen,          m02_axi_arlen,          m01_axi_arlen,      m00_axi_arlen      }),
    .m_axi_arlock     ({m03_axi_arlock,         m02_axi_arlock,         m01_axi_arlock,     m00_axi_arlock     }),
    .m_axi_arqos      ({m03_axi_arqos,          m02_axi_arqos,          m01_axi_arqos,      m00_axi_arqos      }),
    .m_axi_arregion   ({m03_axi_arregion,       m02_axi_arregion,       m01_axi_arregion,   m00_axi_arregion   }),
    .m_axi_aruser     ({m03_axi_aruser,         m02_axi_aruser,         m01_axi_aruser,     m00_axi_aruser     }),
    .m_axi_rvalid     ({m03_axi_rvalid,         m02_axi_rvalid,         m01_axi_rvalid,     m00_axi_rvalid     }),
    .m_axi_rlast      ({m03_axi_rlast,          m02_axi_rlast,          m01_axi_rlast,      m00_axi_rlast      }),
    .m_axi_rready     ({m03_axi_rready,         m02_axi_rready,         m01_axi_rready,     m00_axi_rready     }),
    .m_axi_rdata      ({m03_axi_rdata,          m02_axi_rdata,          m01_axi_rdata,      m00_axi_rdata      }),
    .m_axi_rresp      ({m03_axi_rresp,          m02_axi_rresp,          m01_axi_rresp,      m00_axi_rresp      }),
    .m_axi_rid        ({m03_axi_rid,            m02_axi_rid,            m01_axi_rid,        m00_axi_rid        }),
    .m_axi_ruser      ({m03_axi_ruser,          m02_axi_ruser,          m01_axi_ruser,      m00_axi_ruser      })
);

endmodule