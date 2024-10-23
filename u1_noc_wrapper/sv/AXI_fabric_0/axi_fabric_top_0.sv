module axi_fabric_top_0 #
(
    // Number of masters
    parameter MASTER_N          = 3,
    //
    parameter MASTER_N_LOG      = $clog2(MASTER_N),
    // Number of slaves
    parameter SLAVE_N           = 3,
    //
    parameter SLAVE_N_LOG       = $clog2(SLAVE_N),
    // Address width
    parameter ADDR_WIDTH        = 32,
    // Data width
    parameter DATA_WIDTH        = 32,
    // STRB width
    parameter STRB_WIDTH        = 4,
    // S_ID width
    parameter S_ID_WIDTH        = 8,
    // M_ID width
    parameter M_ID_WIDTH        = S_ID_WIDTH+$clog2(SLAVE_N),
    // User signals width
    parameter AW_USER_WIDTH     = 4,
    // User signals width
    parameter W_USER_WIDTH      = 4,
    // User signals width
    parameter B_USER_WIDTH      = 4,
    // User signals width
    parameter AR_USER_WIDTH     = 4,
    // User signals width
    parameter R_USER_WIDTH      = 4,
    // combinatorial or sequential(default) (PHASE_2)
    parameter ARBITER_TYPE      = 0,
    // exist or not                         (PHASE_2)
    parameter QoS_ENABLE        = 0,
    // on or off                            (PHASE_2)
    parameter LOCK_SUPPORT      = 0,
    // on or off                            (PHASE_2)
    parameter REGIONS_SUPPORT   = 0,
    //
    parameter MAX_TRANS         = 16,
    // Adds a register to the read address channel, slave side
    // 0 - bypass (no reg), 1 - simple reg (1FF), 2 - double register (2FF)
    parameter S_AR_CHANNEL_REG  = 0,
    // Adds a register to the read address channel, master side
    // 0 - bypass (no reg), 1 - simple reg (1FF), 2 - double register (2FF)
    parameter M_AR_CHANNEL_REG  = 0,
    // Adds a register to the read channel, slave side
    // 0 - bypass (no reg), 1 - simple reg (1FF), 2 - double register (2FF)
    parameter S_R_CHANNEL_REG   = 0,
    // Adds a register to the read channel, master side
    // 0 - bypass (no reg), 1 - simple reg (1FF), 2 - double register (2FF)
    parameter M_R_CHANNEL_REG   = 0,
    // Adds a register to the write adddress channel, slave side
    // 0 - bypass (no reg), 1 - simple reg (1FF), 2 - double register (2FF)
    parameter S_AW_CHANNEL_REG  = 0,
    // Adds a register to the write adddress channel, master side
    // 0 - bypass (no reg), 1 - simple reg (1FF), 2 - double register (2FF)
    parameter M_AW_CHANNEL_REG  = 0,
    // Adds a register to the write channel, slave side
    // 0 - bypass (no reg), 1 - simple reg (1FF), 2 - double register (2FF)
    parameter S_W_CHANNEL_REG   = 0,
    // Adds a register to the write channel, master side
    // 0 - bypass (no reg), 1 - simple reg (1FF), 2 - double register (2FF)
    parameter M_W_CHANNEL_REG   = 0,
    // Adds a register to the write response channel, slave side
    // 0 - bypass (no reg), 1 - simple reg (1FF), 2 - double register (2FF)
    parameter S_WR_CHANNEL_REG  = 0,
    // Adds a register to the write response channel, master side
    // 0 - bypass (no reg), 1 - simple reg (1FF), 2 - double register (2FF)
    parameter M_WR_CHANNEL_REG  = 0
)
(
    // --------------- Global ---------------
    input wire                                  clk,
    input wire                                  reset_n,

    // -------------- AXI slave -------------
    input  wire[SLAVE_N              - 1 : 0] s_axi_awvalid,
    output wire[SLAVE_N              - 1 : 0] s_axi_awready,
    input  wire[SLAVE_N * ADDR_WIDTH - 1 : 0] s_axi_awaddr,
    input  wire[SLAVE_N *          3 - 1 : 0] s_axi_awsize,
    input  wire[SLAVE_N *          2 - 1 : 0] s_axi_awburst,
    input  wire[SLAVE_N *          4 - 1 : 0] s_axi_awcache,
    input  wire[SLAVE_N *          3 - 1 : 0] s_axi_awprot,
    input  wire[SLAVE_N * S_ID_WIDTH - 1 : 0] s_axi_awid,
    input  wire[SLAVE_N *          8 - 1 : 0] s_axi_awlen,  //AXI3[3:0]
    input  wire[SLAVE_N              - 1 : 0] s_axi_awlock, //AXI3[1:0]
    input  wire[SLAVE_N *          4 - 1 : 0] s_axi_awqos,
    input  wire[SLAVE_N *          4 - 1 : 0] s_axi_awregion,
    input  wire[SLAVE_N * AW_USER_WIDTH - 1 : 0] s_axi_awuser,
    input  wire[SLAVE_N              - 1 : 0] s_axi_wvalid,
    input  wire[SLAVE_N              - 1 : 0] s_axi_wlast,
    output wire[SLAVE_N              - 1 : 0] s_axi_wready,
    input  wire[SLAVE_N * DATA_WIDTH - 1 : 0] s_axi_wdata,
    input  wire[SLAVE_N * STRB_WIDTH - 1 : 0] s_axi_wstrb,
    //input[  ID_WIDTH-1:0] s_axi_wid,                 //AXI3 ONLY
    input  wire[SLAVE_N * W_USER_WIDTH - 1 : 0] s_axi_wuser,
    output wire[SLAVE_N              - 1 : 0] s_axi_bvalid,
    input  wire[SLAVE_N              - 1 : 0] s_axi_bready,
    output wire[SLAVE_N *          2 - 1 : 0] s_axi_bresp,
    output wire[SLAVE_N * S_ID_WIDTH - 1 : 0] s_axi_bid,
    output wire[SLAVE_N * B_USER_WIDTH - 1 : 0] s_axi_buser,
    input  wire[SLAVE_N              - 1 : 0] s_axi_arvalid,
    output wire[SLAVE_N              - 1 : 0] s_axi_arready,
    input  wire[SLAVE_N * ADDR_WIDTH - 1 : 0] s_axi_araddr,
    input  wire[SLAVE_N *          3 - 1 : 0] s_axi_arsize,
    input  wire[SLAVE_N *          2 - 1 : 0] s_axi_arburst,
    input  wire[SLAVE_N *          4 - 1 : 0] s_axi_arcache,
    input  wire[SLAVE_N *          3 - 1 : 0] s_axi_arprot,
    input  wire[SLAVE_N * S_ID_WIDTH - 1 : 0] s_axi_arid,
    input  wire[SLAVE_N *          8 - 1 : 0] s_axi_arlen,  //AXI3[3:0]
    input  wire[SLAVE_N              - 1 : 0] s_axi_arlock, //AXI3[1:0]
    input  wire[SLAVE_N *          4 - 1 : 0] s_axi_arqos,
    input  wire[SLAVE_N *          4 - 1 : 0] s_axi_arregion,
    input  wire[SLAVE_N * AR_USER_WIDTH - 1 : 0] s_axi_aruser,
    output wire[SLAVE_N              - 1 : 0] s_axi_rvalid,
    input  wire[SLAVE_N              - 1 : 0] s_axi_rready,
    output wire[SLAVE_N              - 1 : 0] s_axi_rlast,
    output wire[SLAVE_N * DATA_WIDTH - 1 : 0] s_axi_rdata,
    output wire[SLAVE_N *          2 - 1 : 0] s_axi_rresp,
    output wire[SLAVE_N * S_ID_WIDTH - 1 : 0] s_axi_rid,
    output wire[SLAVE_N * R_USER_WIDTH - 1 : 0] s_axi_ruser,

    // ------------- AXI master -------------
    output reg[MASTER_N              - 1 : 0] m_axi_awvalid,
    input  wire[MASTER_N              - 1 : 0] m_axi_awready,
    output reg[MASTER_N * ADDR_WIDTH - 1 : 0] m_axi_awaddr,
    output reg[MASTER_N *          3 - 1 : 0] m_axi_awsize,
    output reg[MASTER_N *          2 - 1 : 0] m_axi_awburst,
    output reg[MASTER_N *          4 - 1 : 0] m_axi_awcache,
    output reg[MASTER_N *          3 - 1 : 0] m_axi_awprot,
    output reg[MASTER_N * M_ID_WIDTH - 1 : 0] m_axi_awid,
    output reg[MASTER_N *          8 - 1 : 0] m_axi_awlen,        //AXI3[3:0]
    output reg[MASTER_N              - 1 : 0] m_axi_awlock,       //AXI3[1:0]
    output reg[MASTER_N *          4 - 1 : 0] m_axi_awqos,
    output reg[MASTER_N *          4 - 1 : 0] m_axi_awregion,
    output reg[MASTER_N * AW_USER_WIDTH - 1 : 0] m_axi_awuser,
    output reg[MASTER_N              - 1 : 0] m_axi_wvalid,
    input  wire[MASTER_N              - 1 : 0] m_axi_wready,
    output reg[MASTER_N              - 1 : 0] m_axi_wlast,
    output reg[MASTER_N * DATA_WIDTH - 1 : 0] m_axi_wdata,
    output wire[MASTER_N * STRB_WIDTH - 1 : 0] m_axi_wstrb,
    //input[  ID_WIDTH-1:0]m_axi_wid,              //AXI3 ONLY
    output wire[MASTER_N * W_USER_WIDTH - 1 : 0] m_axi_wuser,
    input  wire[MASTER_N              - 1 : 0] m_axi_bvalid,
    output wire[MASTER_N              - 1 : 0] m_axi_bready,
    input  wire[MASTER_N *          2 - 1 : 0] m_axi_bresp,
    input  wire[MASTER_N * M_ID_WIDTH - 1 : 0] m_axi_bid,
    input  wire[MASTER_N * B_USER_WIDTH - 1 : 0] m_axi_buser,
    output wire[MASTER_N              - 1 : 0] m_axi_arvalid,
    input  wire[MASTER_N              - 1 : 0] m_axi_arready,
    output wire[MASTER_N * ADDR_WIDTH - 1 : 0] m_axi_araddr,
    output wire[MASTER_N *          3 - 1 : 0] m_axi_arsize,
    output wire[MASTER_N *          2 - 1 : 0] m_axi_arburst,
    output wire[MASTER_N *          4 - 1 : 0] m_axi_arcache,
    output wire[MASTER_N *          3 - 1 : 0] m_axi_arprot,
    output wire[MASTER_N * M_ID_WIDTH - 1 : 0] m_axi_arid,
    output wire[MASTER_N *          8 - 1 : 0] m_axi_arlen,  //AXI3[3:0]
    output wire[MASTER_N              - 1 : 0] m_axi_arlock, //AXI3[1:0]
    output wire[MASTER_N *          4 - 1 : 0] m_axi_arqos,
    output wire[MASTER_N *          4 - 1 : 0] m_axi_arregion,
    output wire[MASTER_N * AR_USER_WIDTH - 1 : 0] m_axi_aruser,
    input  wire[MASTER_N              - 1 : 0] m_axi_rvalid,
    output wire[MASTER_N              - 1 : 0] m_axi_rready,
    input  wire[MASTER_N              - 1 : 0] m_axi_rlast,
    input  wire[MASTER_N * DATA_WIDTH - 1 : 0] m_axi_rdata,
    input  wire[MASTER_N *          2 - 1 : 0] m_axi_rresp,
    input  wire[MASTER_N * M_ID_WIDTH - 1 : 0] m_axi_rid,
    input  wire[MASTER_N * R_USER_WIDTH - 1 : 0] m_axi_ruser
);

    genvar d, wr, b, rb, rd, rr, sw, sr, mw, mr;

    wire                                  grant_valid;
    wire[           SLAVE_N_LOG - 1 : 0] grant_index;
    wire[               SLAVE_N - 1 : 0] grants;
    wire[              MASTER_N - 1 : 0] mst_sel;
    wire[          MASTER_N_LOG - 1 : 0] mst_sel_index;
    wire                                  rd_grant_valid;
    wire[           SLAVE_N_LOG - 1 : 0] rd_grant_index;
    wire[               SLAVE_N - 1 : 0] rd_grants;
    wire[              MASTER_N - 1 : 0] rd_mst_sel;
    wire[          MASTER_N_LOG - 1 : 0] rd_mst_sel_index;

    wire[ SLAVE_N              - 1 : 0] int_s_axi_awvalid;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_awready;
    wire[ SLAVE_N * ADDR_WIDTH - 1 : 0] int_s_axi_awaddr;
    wire[ SLAVE_N *          3 - 1 : 0] int_s_axi_awsize;
    wire[ SLAVE_N *          2 - 1 : 0] int_s_axi_awburst;
    wire[ SLAVE_N *          4 - 1 : 0] int_s_axi_awcache;
    wire[ SLAVE_N *          3 - 1 : 0] int_s_axi_awprot;
    wire[ SLAVE_N * S_ID_WIDTH - 1 : 0] int_s_axi_awid;
    wire[ SLAVE_N *          8 - 1 : 0] int_s_axi_awlen;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_awlock;
    wire[ SLAVE_N *          4 - 1 : 0] int_s_axi_awqos;
    wire[ SLAVE_N * AW_USER_WIDTH - 1 : 0] int_s_axi_awuser;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_wvalid;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_wlast;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_wready;
    wire[ SLAVE_N * DATA_WIDTH - 1 : 0] int_s_axi_wdata;
    wire[ SLAVE_N * STRB_WIDTH - 1 : 0] int_s_axi_wstrb;
    wire[ SLAVE_N * W_USER_WIDTH - 1 : 0] int_s_axi_wuser;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_bvalid;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_bready;
    wire[ SLAVE_N *          2 - 1 : 0] int_s_axi_bresp;
    wire[ SLAVE_N * S_ID_WIDTH - 1 : 0] int_s_axi_bid;
    wire[ SLAVE_N * B_USER_WIDTH - 1 : 0] int_s_axi_buser;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_arvalid;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_arready;
    wire[ SLAVE_N * ADDR_WIDTH - 1 : 0] int_s_axi_araddr;
    wire[ SLAVE_N *          3 - 1 : 0] int_s_axi_arsize;
    wire[ SLAVE_N *          2 - 1 : 0] int_s_axi_arburst;
    wire[ SLAVE_N *          4 - 1 : 0] int_s_axi_arcache;
    wire[ SLAVE_N *          3 - 1 : 0] int_s_axi_arprot;
    wire[ SLAVE_N * S_ID_WIDTH - 1 : 0] int_s_axi_arid;
    wire[ SLAVE_N *          8 - 1 : 0] int_s_axi_arlen;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_arlock;
    wire[ SLAVE_N *          4 - 1 : 0] int_s_axi_arqos;
    wire[ SLAVE_N * AR_USER_WIDTH - 1 : 0] int_s_axi_aruser;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_rvalid;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_rready;
    wire[ SLAVE_N              - 1 : 0] int_s_axi_rlast;
    wire[ SLAVE_N * DATA_WIDTH - 1 : 0] int_s_axi_rdata;
    wire[ SLAVE_N *          2 - 1 : 0] int_s_axi_rresp;
    wire[ SLAVE_N * S_ID_WIDTH - 1 : 0] int_s_axi_rid;
    wire[ SLAVE_N * R_USER_WIDTH - 1 : 0] int_s_axi_ruser;
    wire[MASTER_N              - 1 : 0] int_m_axi_awvalid;
    wire[MASTER_N              - 1 : 0] int_m_axi_awready;
    wire[MASTER_N * ADDR_WIDTH - 1 : 0] int_m_axi_awaddr;
    wire[MASTER_N *          3 - 1 : 0] int_m_axi_awsize;
    wire[MASTER_N *          2 - 1 : 0] int_m_axi_awburst;
    wire[MASTER_N *          4 - 1 : 0] int_m_axi_awcache;
    wire[MASTER_N *          3 - 1 : 0] int_m_axi_awprot;
    wire[MASTER_N * M_ID_WIDTH - 1 : 0] int_m_axi_awid;
    wire[MASTER_N *          8 - 1 : 0] int_m_axi_awlen;
    wire[MASTER_N              - 1 : 0] int_m_axi_awlock;
    wire[MASTER_N *          4 - 1 : 0] int_m_axi_awqos;
    wire[MASTER_N *          4 - 1 : 0] int_m_axi_awregion;
    wire[MASTER_N * AW_USER_WIDTH - 1 : 0] int_m_axi_awuser;
    wire[MASTER_N              - 1 : 0] int_m_axi_wvalid;
    wire[MASTER_N              - 1 : 0] int_m_axi_wready;
    wire[MASTER_N              - 1 : 0] int_m_axi_wlast;
    wire[MASTER_N * DATA_WIDTH - 1 : 0] int_m_axi_wdata;
    wire[MASTER_N * STRB_WIDTH - 1 : 0] int_m_axi_wstrb;
    wire[MASTER_N * W_USER_WIDTH - 1 : 0] int_m_axi_wuser;
    wire[MASTER_N              - 1 : 0] int_m_axi_bvalid;
    wire[MASTER_N              - 1 : 0] int_m_axi_bready;
    wire[MASTER_N *          2 - 1 : 0] int_m_axi_bresp;
    wire[MASTER_N * M_ID_WIDTH - 1 : 0] int_m_axi_bid;
    wire[MASTER_N * B_USER_WIDTH - 1 : 0] int_m_axi_buser;
    wire[MASTER_N              - 1 : 0] int_m_axi_arvalid;
    wire[MASTER_N              - 1 : 0] int_m_axi_arready;
    wire[MASTER_N * ADDR_WIDTH - 1 : 0] int_m_axi_araddr;
    wire[MASTER_N *          3 - 1 : 0] int_m_axi_arsize;
    wire[MASTER_N *          2 - 1 : 0] int_m_axi_arburst;
    wire[MASTER_N *          4 - 1 : 0] int_m_axi_arcache;
    wire[MASTER_N *          3 - 1 : 0] int_m_axi_arprot;
    wire[MASTER_N * M_ID_WIDTH - 1 : 0] int_m_axi_arid;
    wire[MASTER_N *          8 - 1 : 0] int_m_axi_arlen;
    wire[MASTER_N              - 1 : 0] int_m_axi_arlock;
    wire[MASTER_N *          4 - 1 : 0] int_m_axi_arqos;
    wire[MASTER_N *          4 - 1 : 0] int_m_axi_arregion;
    wire[MASTER_N * AR_USER_WIDTH - 1 : 0] int_m_axi_aruser;
    wire[MASTER_N              - 1 : 0] int_m_axi_rvalid;
    wire[MASTER_N              - 1 : 0] int_m_axi_rready;
    wire[MASTER_N              - 1 : 0] int_m_axi_rlast;
    wire[MASTER_N * DATA_WIDTH - 1 : 0] int_m_axi_rdata;
    wire[MASTER_N *          2 - 1 : 0] int_m_axi_rresp;
    wire[MASTER_N * M_ID_WIDTH - 1 : 0] int_m_axi_rid;
    wire[MASTER_N * R_USER_WIDTH - 1 : 0] int_m_axi_ruser;

/************************ TEST ************************/
    wire [ SLAVE_N  * MASTER_N_LOG - 1 : 0] out_next_mst;
    wire [  MASTER_N * SLAVE_N_LOG - 1 : 0] out_data_select;


/*###########################################################*/
/*                   Write channel                           */
/*###########################################################*/

    /**********************************************/
    /*               Registered data              */
    /* 0-bypass; 1-simple register; 2-skid buffer */
    /**********************************************/
    generate
    for (sw = 0; sw < SLAVE_N; sw = sw + 1) begin : SW_REG
    // Slave side
     wr_register
     #(
         .ADDR_WIDTH            (ADDR_WIDTH),
         .DATA_WIDTH            (DATA_WIDTH),
         .STRB_WIDTH            (STRB_WIDTH),
         .ID_WIDTH              (S_ID_WIDTH),
         .AW_USER_WIDTH         (AW_USER_WIDTH),
         .W_USER_WIDTH          (W_USER_WIDTH),
         .B_USER_WIDTH          (B_USER_WIDTH),
         .AW_CHANNEL_REG        (S_AW_CHANNEL_REG),
         .W_CHANNEL_REG         (S_W_CHANNEL_REG),
         .WR_CHANNEL_REG        (S_WR_CHANNEL_REG)
     )
     slv_wr_register_inst
     (
       .clk                   (clk),
       .rst_n                 (reset_n),
       .i_axi_awvalid         (s_axi_awvalid[sw]),
       .i_axi_awready         (s_axi_awready[sw]),
       .i_axi_awaddr          (s_axi_awaddr[sw*ADDR_WIDTH +: ADDR_WIDTH]),
       .i_axi_awsize          (s_axi_awsize[sw*3 +: 3]),
       .i_axi_awburst         (s_axi_awburst[sw*2 +: 2]),
       .i_axi_awcache         (s_axi_awcache[sw*4 +: 4]),
       .i_axi_awprot          (s_axi_awprot[sw*3 +: 3]),
       .i_axi_awid            (s_axi_awid[sw*S_ID_WIDTH +: S_ID_WIDTH]),
       .i_axi_awlen           (s_axi_awlen[sw*8 +: 8]),
       .i_axi_awlock          (s_axi_awlock[sw]),
       .i_axi_awqos           (s_axi_awqos[sw*4 +: 4]),
       .i_axi_awregion        (4'b0),
       .i_axi_awuser          (s_axi_awuser[sw*AW_USER_WIDTH +: AW_USER_WIDTH]),
       .i_axi_wvalid          (s_axi_wvalid[sw]),
       .i_axi_wlast           (s_axi_wlast[sw]),
       .i_axi_wready          (s_axi_wready[sw]),
       .i_axi_wdata           (s_axi_wdata[sw*DATA_WIDTH +: DATA_WIDTH]),
       .i_axi_wstrb           (s_axi_wstrb[sw*STRB_WIDTH +: STRB_WIDTH]),
       .i_axi_wuser           (s_axi_wuser[sw*W_USER_WIDTH +: W_USER_WIDTH]),
       .i_axi_bvalid          (s_axi_bvalid[sw]),
       .i_axi_bready          (s_axi_bready[sw]),
       .i_axi_bresp           (s_axi_bresp[sw*2 +: 2]),
       .i_axi_bid             (s_axi_bid[sw*S_ID_WIDTH +: S_ID_WIDTH]),
       .i_axi_buser           (s_axi_buser[sw*B_USER_WIDTH +: B_USER_WIDTH]),
       .o_axi_awvalid         (int_s_axi_awvalid[sw]),
       .o_axi_awready         (int_s_axi_awready[sw]),
       .o_axi_awaddr          (int_s_axi_awaddr[sw*ADDR_WIDTH +: ADDR_WIDTH]),
       .o_axi_awsize          (int_s_axi_awsize[sw*3 +: 3]),
       .o_axi_awburst         (int_s_axi_awburst[sw*2 +: 2]),
       .o_axi_awcache         (int_s_axi_awcache[sw*4 +: 4]),
       .o_axi_awprot          (int_s_axi_awprot[sw*3 +: 3]),
       .o_axi_awid            (int_s_axi_awid[sw*S_ID_WIDTH +: S_ID_WIDTH]),
       .o_axi_awlen           (int_s_axi_awlen[sw*8 +: 8]),
       .o_axi_awlock          (int_s_axi_awlock[sw]),
       .o_axi_awqos           (int_s_axi_awqos[sw*4 +: 4]),
       .o_axi_awregion        (),
       .o_axi_awuser          (int_s_axi_awuser[sw*AW_USER_WIDTH +: AW_USER_WIDTH]),
       .o_axi_wvalid          (int_s_axi_wvalid[sw]),
       .o_axi_wready          (int_s_axi_wready[sw]),
       .o_axi_wlast           (int_s_axi_wlast[sw]),
       .o_axi_wdata           (int_s_axi_wdata[sw*DATA_WIDTH +: DATA_WIDTH]),
       .o_axi_wstrb           (int_s_axi_wstrb[sw*STRB_WIDTH +: STRB_WIDTH]),
       .o_axi_wuser           (int_s_axi_wuser[sw*W_USER_WIDTH +: W_USER_WIDTH]),
       .o_axi_bvalid          (int_s_axi_bvalid[sw]),
       .o_axi_bready          (int_s_axi_bready[sw]),
       .o_axi_bresp           (int_s_axi_bresp[sw*2 +: 2]),
       .o_axi_bid             (int_s_axi_bid[sw*S_ID_WIDTH +: S_ID_WIDTH]),
       .o_axi_buser           (int_s_axi_buser[sw*B_USER_WIDTH +: B_USER_WIDTH])
     );
    end
    endgenerate

    generate
    for (mw = 0; mw < MASTER_N; mw = mw + 1) begin : MW_REG
     // Master side
     wr_register
     #(
         .ADDR_WIDTH            (ADDR_WIDTH),
         .DATA_WIDTH            (DATA_WIDTH),
         .STRB_WIDTH            (STRB_WIDTH),
         .ID_WIDTH              (M_ID_WIDTH),
         .AW_USER_WIDTH         (AW_USER_WIDTH),
         .W_USER_WIDTH          (W_USER_WIDTH),
         .B_USER_WIDTH          (B_USER_WIDTH),
         .AW_CHANNEL_REG        (M_AW_CHANNEL_REG),
         .W_CHANNEL_REG         (M_W_CHANNEL_REG),
         .WR_CHANNEL_REG        (M_WR_CHANNEL_REG)
     )
     mst_wr_register_inst
     (
       .clk                   (clk),
       .rst_n                 (reset_n),
       .i_axi_awvalid         (int_m_axi_awvalid[mw]),
       .i_axi_awready         (int_m_axi_awready[mw]),
       .i_axi_awaddr          (int_m_axi_awaddr[mw*ADDR_WIDTH +: ADDR_WIDTH]),
       .i_axi_awsize          (int_m_axi_awsize[mw*3 +: 3]),
       .i_axi_awburst         (int_m_axi_awburst[mw*2 +: 2]),
       .i_axi_awcache         (int_m_axi_awcache[mw*4 +: 4]),
       .i_axi_awprot          (int_m_axi_awprot[mw*3 +: 3]),
       .i_axi_awid            (int_m_axi_awid[mw*M_ID_WIDTH +: M_ID_WIDTH]),
       .i_axi_awlen           (int_m_axi_awlen[mw*8 +: 8]),
       .i_axi_awlock          (int_m_axi_awlock[mw]),
       .i_axi_awqos           (int_m_axi_awqos[mw*4 +: 4]),
       .i_axi_awregion        (int_m_axi_awregion[mw*4 +: 4]),
       .i_axi_awuser          (int_m_axi_awuser[mw*AW_USER_WIDTH +: AW_USER_WIDTH]),
       .i_axi_wvalid          (int_m_axi_wvalid[mw]),
       .i_axi_wlast           (int_m_axi_wlast[mw]),
       .i_axi_wready          (int_m_axi_wready[mw]),
       .i_axi_wdata           (int_m_axi_wdata[mw*DATA_WIDTH +: DATA_WIDTH]),
       .i_axi_wstrb           (int_m_axi_wstrb[mw*STRB_WIDTH +: STRB_WIDTH]),
       .i_axi_wuser           (int_m_axi_wuser[mw*W_USER_WIDTH +: W_USER_WIDTH]),
       .i_axi_bvalid          (int_m_axi_bvalid[mw]),
       .i_axi_bready          (int_m_axi_bready[mw]),
       .i_axi_bresp           (int_m_axi_bresp[mw*2 +: 2]),
       .i_axi_bid             (int_m_axi_bid[mw*M_ID_WIDTH +: M_ID_WIDTH]),
       .i_axi_buser           (int_m_axi_buser[mw*B_USER_WIDTH +: B_USER_WIDTH]),
       .o_axi_awvalid         (m_axi_awvalid[mw]),
       .o_axi_awready         (m_axi_awready[mw]),
       .o_axi_awaddr          (m_axi_awaddr[mw*ADDR_WIDTH +: ADDR_WIDTH]),
       .o_axi_awsize          (m_axi_awsize[mw*3 +: 3]),
       .o_axi_awburst         (m_axi_awburst[mw*2 +: 2]),
       .o_axi_awcache         (m_axi_awcache[mw*4 +: 4]),
       .o_axi_awprot          (m_axi_awprot[mw*3 +: 3]),
       .o_axi_awid            (m_axi_awid[mw*M_ID_WIDTH +: M_ID_WIDTH]),
       .o_axi_awlen           (m_axi_awlen[mw*8 +: 8]),
       .o_axi_awlock          (m_axi_awlock[mw]),
       .o_axi_awqos           (m_axi_awqos[mw*4 +: 4]),
       .o_axi_awregion        (m_axi_awregion[mw*4 +: 4]),
       .o_axi_awuser          (m_axi_awuser[mw*AW_USER_WIDTH +: AW_USER_WIDTH]),
       .o_axi_wvalid          (m_axi_wvalid[mw]),
       .o_axi_wready          (m_axi_wready[mw]),
       .o_axi_wlast           (m_axi_wlast[mw]),
       .o_axi_wdata           (m_axi_wdata[mw*DATA_WIDTH +: DATA_WIDTH]),
       .o_axi_wstrb           (m_axi_wstrb[mw*STRB_WIDTH +: STRB_WIDTH]),
       .o_axi_wuser           (m_axi_wuser[mw*W_USER_WIDTH +: W_USER_WIDTH]),
       .o_axi_bvalid          (m_axi_bvalid[mw]),
       .o_axi_bready          (m_axi_bready[mw]),
       .o_axi_bresp           (m_axi_bresp[mw*2 +: 2]),
       .o_axi_bid             (m_axi_bid[mw*M_ID_WIDTH +: M_ID_WIDTH]),
       .o_axi_buser           (m_axi_buser[mw*B_USER_WIDTH +: B_USER_WIDTH])
     );
   end
   endgenerate


    /**********************************************/
    /*             Write Address calc             */
    /*               Master select                */
    /**********************************************/
     addr_dec_mst_sel_0
     #(
       .SLAVE_N                (SLAVE_N),
       .MASTER_N               (MASTER_N),
       .ADDR_WIDTH             (ADDR_WIDTH),
       .USER_WIDTH             (AW_USER_WIDTH),
       .S_ID_WIDTH             (S_ID_WIDTH)
     )
     wr_addr_dec_mst_sel_0_inst
     (
        .clk                    (clk),
        .reset_n                (reset_n),
        .s_axi_avalid           (int_s_axi_awvalid),
        .s_axi_aready           (int_s_axi_awready),
        .s_axi_aaddr            (int_s_axi_awaddr),
        .s_axi_asize            (int_s_axi_awsize),
        .s_axi_aburst           (int_s_axi_awburst),
        .s_axi_acache           (int_s_axi_awcache),
        .s_axi_aprot            (int_s_axi_awprot),
        .s_axi_aid              (int_s_axi_awid),
        .s_axi_alen             (int_s_axi_awlen),
        .s_axi_alock            (int_s_axi_awlock),
        .s_axi_aqos             (int_s_axi_awqos),
        .s_axi_auser            (int_s_axi_awuser),
        .m_axi_avalid           (int_m_axi_awvalid),
        .m_axi_aready           (int_m_axi_awready),
        .m_axi_aaddr            (int_m_axi_awaddr),
        .m_axi_asize            (int_m_axi_awsize),
        .m_axi_aburst           (int_m_axi_awburst),
        .m_axi_acache           (int_m_axi_awcache),
        .m_axi_aprot            (int_m_axi_awprot),
        .m_axi_aid              (int_m_axi_awid),
        .m_axi_alen             (int_m_axi_awlen),
        .m_axi_alock            (int_m_axi_awlock),
        .m_axi_aqos             (int_m_axi_awqos),
        .m_axi_auser            (int_m_axi_awuser),
        .m_axi_aregion          (int_m_axi_awregion),
        .grant_valid            (grant_valid),
        .grants_out             (grants),
        .grant_index_out        (grant_index),
        .master_sel_out         (mst_sel),
        .master_sel_index_out   (mst_sel_index)
     );

    /**********************************************/
    /*      Write data mux for each master        */
    /*      Save next slave for each master       */
    /**********************************************/
    generate
    for (d = 0; d < MASTER_N; d = d + 1) begin : WR_DATA_MUX
      wr_data_mux
      #(
        .A                      (d),
        .SLAVE_N                (SLAVE_N),
        .MASTER_N               (MASTER_N),
        .DATA_WIDTH             (DATA_WIDTH),
        .STRB_WIDTH             (STRB_WIDTH),
        .USER_WIDTH             (W_USER_WIDTH),
        .MAX_TRANS              (MAX_TRANS)
      )
      wr_data_mux_inst
      (
        .clk                    (clk),
        .reset_n                (reset_n),
        .grant_valid            (grant_valid),
        .grant_index            (grant_index),
        .fifo_enable            (mst_sel[d]),
        .next_mst               (out_next_mst),
        .out_data_select        (out_data_select[d*SLAVE_N_LOG +: SLAVE_N_LOG]),
        .in_wvalid              (int_s_axi_wvalid),
        .in_wlast               (int_s_axi_wlast),
        .in_wdata               (int_s_axi_wdata),
        .in_wstrb               (int_s_axi_wstrb),
        .in_wuser               (int_s_axi_wuser),
        .in_wready              (int_m_axi_wready[d]),
        .out_wdata              (int_m_axi_wdata[d*DATA_WIDTH +: DATA_WIDTH]),
        .out_wstrb              (int_m_axi_wstrb[d*STRB_WIDTH +: STRB_WIDTH]),
        .out_wuser              (int_m_axi_wuser[d*W_USER_WIDTH +: W_USER_WIDTH]),
        .out_wvalid             (int_m_axi_wvalid[d]),
        .out_wlast              (int_m_axi_wlast[d])
      );
    end
    endgenerate

    /**********************************************/
    /*         Wready gen for each slave          */
    /**********************************************/
    generate
    for (wr = 0; wr < SLAVE_N; wr = wr + 1) begin : WREADY_GEN
      wr_reg_gen
      #(
        .A                      (wr),
        .SLAVE_N                (SLAVE_N),
        .MASTER_N               (MASTER_N),
        .MAX_TRANS              (MAX_TRANS)
      )
      w_reg_gen_inst
      (
        .clk                    (clk),
        .reset_n                (reset_n),
        .wr_en                  (grant_valid && grants[wr]),
        .rd_en                  (int_s_axi_wvalid[wr] && int_s_axi_wready[wr] && int_s_axi_wlast[wr]),
        .data_in                (mst_sel_index),
        .out_next_mst           (out_next_mst[wr*MASTER_N_LOG +: MASTER_N_LOG]),   // TODO update
        .data_select            (out_data_select),   // TODO update
        .in_ready               (int_m_axi_wready),
        .out_ready              (int_s_axi_wready[wr])
      );
    end
    endgenerate

/*###########################################################*/
/*                Write response channel                     */
/*###########################################################*/
    b_response
    #(
        .MASTER_N      (MASTER_N),
        .SLAVE_N       (SLAVE_N),
        .S_ID_WIDTH    (S_ID_WIDTH),
        .USER_WIDTH    (B_USER_WIDTH)
    )
    b_response_inst
    (
        .clk           (clk),
        .reset_n       (reset_n),
        .m_axi_bvalid  (int_m_axi_bvalid),
        .m_axi_bready  (int_m_axi_bready),
        .m_axi_bresp   (int_m_axi_bresp),
        .m_axi_bid     (int_m_axi_bid),
        .m_axi_buser   (int_m_axi_buser),
        .s_axi_bvalid  (int_s_axi_bvalid),
        .s_axi_bready  (int_s_axi_bready),
        .s_axi_bresp   (int_s_axi_bresp),
        .s_axi_bid     (int_s_axi_bid),
        .s_axi_buser   (int_s_axi_buser)
    );

/*###########################################################*/
/*                    Read channel                           */
/*###########################################################*/

    /**********************************************/
    /*               Registered data              */
    /* 0-bypass; 1-simple register; 2-skid buffer */
    /**********************************************/

    generate
    for (sr = 0; sr < SLAVE_N; sr = sr + 1) begin : SR_REG
     rd_register
     #(
         .ADDR_WIDTH             (ADDR_WIDTH),
         .DATA_WIDTH             (DATA_WIDTH),
         .ID_WIDTH               (S_ID_WIDTH),
         .AR_USER_WIDTH          (AR_USER_WIDTH),
         .R_USER_WIDTH           (R_USER_WIDTH),
         .AR_CHANNEL_REG         (S_AR_CHANNEL_REG),
         .R_CHANNEL_REG          (S_R_CHANNEL_REG)
     )
     slv_rd_register_inst
     (
         .clk                    (clk),
         .rst_n                  (reset_n),
         .i_axi_arvalid          (s_axi_arvalid[sr]),
         .i_axi_arready          (s_axi_arready[sr]),
         .i_axi_araddr           (s_axi_araddr[sr*ADDR_WIDTH +: ADDR_WIDTH]),
         .i_axi_arsize           (s_axi_arsize[sr*3 +: 3]),
         .i_axi_arburst          (s_axi_arburst[sr*2 +: 2]),
         .i_axi_arcache          (s_axi_arcache[sr*4 +: 4]),
         .i_axi_arprot           (s_axi_arprot[sr*3 +: 3]),
         .i_axi_arid             (s_axi_arid[sr*S_ID_WIDTH +: S_ID_WIDTH]),
         .i_axi_arlen            (s_axi_arlen[sr*8 +: 8]),
         .i_axi_arlock           (s_axi_arlock[sr]),
         .i_axi_arqos            (s_axi_arqos[sr*4 +: 4]),
         .i_axi_arregion         (4'b0),
         .i_axi_aruser           (s_axi_aruser[sr*AR_USER_WIDTH +: AR_USER_WIDTH]),
         .i_axi_rvalid           (s_axi_rvalid[sr]),
         .i_axi_rready           (s_axi_rready[sr]),
         .i_axi_rlast            (s_axi_rlast[sr]),
         .i_axi_rdata            (s_axi_rdata[sr*DATA_WIDTH +: DATA_WIDTH]),
         .i_axi_rresp            (s_axi_rresp[sr*2 +: 2]),
         .i_axi_rid              (s_axi_rid[sr*S_ID_WIDTH +: S_ID_WIDTH]),
         .i_axi_ruser            (s_axi_ruser[sr*R_USER_WIDTH +: R_USER_WIDTH]),
         .o_axi_arvalid          (int_s_axi_arvalid[sr]),
         .o_axi_arready          (int_s_axi_arready[sr]),
         .o_axi_araddr           (int_s_axi_araddr[sr*ADDR_WIDTH +: ADDR_WIDTH]),
         .o_axi_arsize           (int_s_axi_arsize[sr*3 +: 3]),
         .o_axi_arburst          (int_s_axi_arburst[sr*2 +: 2]),
         .o_axi_arcache          (int_s_axi_arcache[sr*4 +: 4]),
         .o_axi_arprot           (int_s_axi_arprot[sr*3 +: 3]),
         .o_axi_arid             (int_s_axi_arid[sr*S_ID_WIDTH +: S_ID_WIDTH]),
         .o_axi_arlen            (int_s_axi_arlen[sr*8 +: 8]),
         .o_axi_arlock           (int_s_axi_arlock[sr]),
         .o_axi_arqos            (int_s_axi_arqos[sr*4 +: 4]),
         .o_axi_arregion         (),
         .o_axi_aruser           (int_s_axi_aruser[sr*AR_USER_WIDTH +: AR_USER_WIDTH]),
         .o_axi_rvalid           (int_s_axi_rvalid[sr]),
         .o_axi_rready           (int_s_axi_rready[sr]),
         .o_axi_rlast            (int_s_axi_rlast[sr]),
         .o_axi_rdata            (int_s_axi_rdata[sr*DATA_WIDTH +: DATA_WIDTH]),
         .o_axi_rresp            (int_s_axi_rresp[sr*2 +: 2]),
         .o_axi_rid              (int_s_axi_rid[sr*S_ID_WIDTH +: S_ID_WIDTH]),
         .o_axi_ruser            (int_s_axi_ruser[sr*R_USER_WIDTH +: R_USER_WIDTH])
     );
    end
    endgenerate

    generate
    for (mr = 0; mr < MASTER_N; mr = mr + 1) begin : MR_REG
     rd_register
     #(
         .ADDR_WIDTH             (ADDR_WIDTH),
         .DATA_WIDTH             (DATA_WIDTH),
         .ID_WIDTH               (M_ID_WIDTH),
         .AR_USER_WIDTH          (AR_USER_WIDTH),
         .R_USER_WIDTH           (R_USER_WIDTH),
         .AR_CHANNEL_REG         (M_AR_CHANNEL_REG),
         .R_CHANNEL_REG          (M_R_CHANNEL_REG)
     )
     mst_rd_register_inst
     (
         .clk                    (clk),
         .rst_n                  (reset_n),
         .i_axi_arvalid          (int_m_axi_arvalid[mr]),
         .i_axi_arready          (int_m_axi_arready[mr]),
         .i_axi_araddr           (int_m_axi_araddr[mr*ADDR_WIDTH +: ADDR_WIDTH]),
         .i_axi_arsize           (int_m_axi_arsize[mr*3 +: 3]),
         .i_axi_arburst          (int_m_axi_arburst[mr*2 +: 2]),
         .i_axi_arcache          (int_m_axi_arcache[mr*4 +: 4]),
         .i_axi_arprot           (int_m_axi_arprot[mr*3 +: 3]),
         .i_axi_arid             (int_m_axi_arid[mr*M_ID_WIDTH +: M_ID_WIDTH]),
         .i_axi_arlen            (int_m_axi_arlen[mr*8 +: 8]),
         .i_axi_arlock           (int_m_axi_arlock[mr]),
         .i_axi_arqos            (int_m_axi_arqos[mr*4 +: 4]),
         .i_axi_arregion         (int_m_axi_arregion[mr*4 +: 4]),
         .i_axi_aruser           (int_m_axi_aruser[mr*AR_USER_WIDTH +: AR_USER_WIDTH]),
         .i_axi_rvalid           (int_m_axi_rvalid[mr]),
         .i_axi_rready           (int_m_axi_rready[mr]),
         .i_axi_rlast            (int_m_axi_rlast[mr]),
         .i_axi_rdata            (int_m_axi_rdata[mr*DATA_WIDTH +: DATA_WIDTH]),
         .i_axi_rresp            (int_m_axi_rresp[mr*2 +: 2]),
         .i_axi_rid              (int_m_axi_rid[mr*M_ID_WIDTH +: M_ID_WIDTH]),
         .i_axi_ruser            (int_m_axi_ruser[mr*R_USER_WIDTH +: R_USER_WIDTH]),
         .o_axi_arvalid          (m_axi_arvalid[mr]),
         .o_axi_arready          (m_axi_arready[mr]),
         .o_axi_araddr           (m_axi_araddr[mr*ADDR_WIDTH +: ADDR_WIDTH]),
         .o_axi_arsize           (m_axi_arsize[mr*3 +: 3]),
         .o_axi_arburst          (m_axi_arburst[mr*2 +: 2]),
         .o_axi_arcache          (m_axi_arcache[mr*4 +: 4]),
         .o_axi_arprot           (m_axi_arprot[mr*3 +: 3]),
         .o_axi_arid             (m_axi_arid[mr*M_ID_WIDTH +: M_ID_WIDTH]),
         .o_axi_arlen            (m_axi_arlen[mr*8 +: 8]),
         .o_axi_arlock           (m_axi_arlock[mr]),
         .o_axi_arqos            (m_axi_arqos[mr*4 +: 4]),
         .o_axi_arregion         (m_axi_arregion[mr*4 +: 4]),
         .o_axi_aruser           (m_axi_aruser[mr*AR_USER_WIDTH +: AR_USER_WIDTH]),
         .o_axi_rvalid           (m_axi_rvalid[mr]),
         .o_axi_rready           (m_axi_rready[mr]),
         .o_axi_rlast            (m_axi_rlast[mr]),
         .o_axi_rdata            (m_axi_rdata[mr*DATA_WIDTH +: DATA_WIDTH]),
         .o_axi_rresp            (m_axi_rresp[mr*2 +: 2]),
         .o_axi_rid              (m_axi_rid[mr*M_ID_WIDTH +: M_ID_WIDTH]),
         .o_axi_ruser            (m_axi_ruser[mr*R_USER_WIDTH +: R_USER_WIDTH])
     );
    end
    endgenerate
    /**********************************************/
    /*             Read Address calc              */
    /*               Master select                */
    /**********************************************/
      addr_dec_mst_sel_0
      #(
        .SLAVE_N                (SLAVE_N),
        .MASTER_N               (MASTER_N),
        .ADDR_WIDTH             (ADDR_WIDTH),
        .USER_WIDTH             (AR_USER_WIDTH),
        .S_ID_WIDTH             (S_ID_WIDTH)
      )
      rd_addr_dec_mst_sel_0_inst
      (
        .clk                    (clk),
        .reset_n                (reset_n),
        .s_axi_avalid           (int_s_axi_arvalid),
        .s_axi_aready           (int_s_axi_arready),
        .s_axi_aaddr            (int_s_axi_araddr),
        .s_axi_asize            (int_s_axi_arsize),
        .s_axi_aburst           (int_s_axi_arburst),
        .s_axi_acache           (int_s_axi_arcache),
        .s_axi_aprot            (int_s_axi_arprot),
        .s_axi_aid              (int_s_axi_arid),
        .s_axi_alen             (int_s_axi_arlen),
        .s_axi_alock            (int_s_axi_arlock),
        .s_axi_aqos             (int_s_axi_arqos),
        .s_axi_auser            (int_s_axi_aruser),
        .m_axi_avalid           (int_m_axi_arvalid),
        .m_axi_aready           (int_m_axi_arready),
        .m_axi_aaddr            (int_m_axi_araddr),
        .m_axi_asize            (int_m_axi_arsize),
        .m_axi_aburst           (int_m_axi_arburst),
        .m_axi_acache           (int_m_axi_arcache),
        .m_axi_aprot            (int_m_axi_arprot),
        .m_axi_aid              (int_m_axi_arid),
        .m_axi_alen             (int_m_axi_arlen),
        .m_axi_alock            (int_m_axi_arlock),
        .m_axi_aqos             (int_m_axi_arqos),
        .m_axi_auser            (int_m_axi_aruser),
        .m_axi_aregion          (int_m_axi_arregion),
        .grant_valid            (rd_grant_valid),
        .grants_out             (rd_grants),
        .grant_index_out        (rd_grant_index),
        .master_sel_out         (rd_mst_sel),
        .master_sel_index_out   (rd_mst_sel_index)
     );

    /**********************************************/
    /*        Read data mux for each slave        */
    /**********************************************/
    rd_response
    #(
        .MASTER_N       (MASTER_N),
        .SLAVE_N        (SLAVE_N),
        .S_ID_WIDTH     (S_ID_WIDTH),
        .USER_WIDTH     (R_USER_WIDTH),
        .DATA_WIDTH     (DATA_WIDTH)
    )
    rd_response_inst
    (
        .clk            (clk),
        .reset_n        (reset_n),
        .m_axi_rvalid   (int_m_axi_rvalid),
        .m_axi_rready   (int_m_axi_rready),
        .m_axi_rlast    (int_m_axi_rlast),
        .m_axi_rdata    (int_m_axi_rdata),
        .m_axi_rresp    (int_m_axi_rresp),
        .m_axi_rid      (int_m_axi_rid),
        .m_axi_ruser    (int_m_axi_ruser),
        .s_axi_rvalid   (int_s_axi_rvalid),
        .s_axi_rready   (int_s_axi_rready),
        .s_axi_rlast    (int_s_axi_rlast),
        .s_axi_rdata    (int_s_axi_rdata),
        .s_axi_rresp    (int_s_axi_rresp),
        .s_axi_rid      (int_s_axi_rid),
        .s_axi_ruser    (int_s_axi_ruser)
    );

endmodule