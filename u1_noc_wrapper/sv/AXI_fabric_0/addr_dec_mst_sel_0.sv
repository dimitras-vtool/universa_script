module addr_dec_mst_sel_0
#(
    //
    parameter SLAVE_N           = 4,
    //
    parameter MASTER_N          = 4,
    //
    parameter ADDR_WIDTH        = 32,
    //
    parameter S_ID_WIDTH        = 8,
    //
    parameter M_ID_WIDTH = S_ID_WIDTH+$clog2(SLAVE_N),
    //
    parameter USER_WIDTH        = 8,
    //
    parameter MASTER_N_LOG      = $clog2(MASTER_N),
    //
    parameter SLAVE_N_LOG       = $clog2(SLAVE_N),
    //
    parameter MAX_TRANS         = 16
)
(
    input  wire                                    clk,
    input  wire                                    reset_n,

    // -------------- AXI slave -------------
    input  wire [  SLAVE_N                - 1 : 0] s_axi_avalid,
    output wire [  SLAVE_N                - 1 : 0] s_axi_aready,
    input  wire [  SLAVE_N *   ADDR_WIDTH - 1 : 0] s_axi_aaddr,
    input  wire [  SLAVE_N *            3 - 1 : 0] s_axi_asize,
    input  wire [  SLAVE_N *            2 - 1 : 0] s_axi_aburst,
    input  wire [  SLAVE_N *            4 - 1 : 0] s_axi_acache,
    input  wire [  SLAVE_N *            3 - 1 : 0] s_axi_aprot,
    input  wire [  SLAVE_N *   S_ID_WIDTH - 1 : 0] s_axi_aid,
    input  wire [  SLAVE_N *            8 - 1 : 0] s_axi_alen,  //AXI3 [3:0]
    input  wire [  SLAVE_N                - 1 : 0] s_axi_alock, //AXI3 [1:0]
    input  wire [  SLAVE_N *            4 - 1 : 0] s_axi_aqos,
    input  wire [  SLAVE_N *   USER_WIDTH - 1 : 0] s_axi_auser,

    // ------------- AXI master -------------
    output reg  [MASTER_N                 - 1 : 0] m_axi_avalid,
    input  wire [MASTER_N                 - 1 : 0] m_axi_aready,
    output reg  [MASTER_N *    ADDR_WIDTH - 1 : 0] m_axi_aaddr,
    output reg  [MASTER_N *             3 - 1 : 0] m_axi_asize,
    output reg  [MASTER_N *             2 - 1 : 0] m_axi_aburst,
    output reg  [MASTER_N *             4 - 1 : 0] m_axi_acache,
    output reg  [MASTER_N *             3 - 1 : 0] m_axi_aprot,
    output reg  [MASTER_N *   M_ID_WIDTH  - 1 : 0] m_axi_aid,
    output reg  [MASTER_N *             8 - 1 : 0] m_axi_alen,  //AXI3 [3:0]
    output reg  [MASTER_N                 - 1 : 0] m_axi_alock, //AXI3 [1:0]
    output reg  [MASTER_N *             4 - 1 : 0] m_axi_aqos,
    output reg  [MASTER_N *    USER_WIDTH - 1 : 0] m_axi_auser,
    output wire [MASTER_N *             4 - 1 : 0] m_axi_aregion,

    output wire                                    grant_valid,
    output wire [                 SLAVE_N - 1 : 0] grants_out,
    output wire [             SLAVE_N_LOG - 1 : 0] grant_index_out,
    output wire [                MASTER_N - 1 : 0] master_sel_out,
    output wire [            MASTER_N_LOG - 1 : 0] master_sel_index_out
);

    localparam INPUT_FIFO_DATA_WIDTH = 1'b1 + S_ID_WIDTH + ADDR_WIDTH;
    genvar r, rr, m;

    /***********************************************/
    wire [     SLAVE_N - 1 : 0] grant_request;
    wire [     SLAVE_N - 1 : 0] grant_release;
    wire [     SLAVE_N - 1 : 0] grants;
    wire [ SLAVE_N_LOG - 1 : 0] grant_index;
    reg  [     SLAVE_N - 1 : 0] grants_reg;

    /***********************************************/
    wire [    MASTER_N - 1 : 0] master_sel;
    wire [MASTER_N_LOG - 1 : 0] master_sel_index;
    reg  [MASTER_N_LOG - 1 : 0] master_sel_index_reg;

    /***********************************************/
    wire                        s_axi_avalid_mux;
    wire [  ADDR_WIDTH - 1 : 0] s_axi_aaddr_mux;
    wire [           3 - 1 : 0] s_axi_asize_mux;
    wire [           2 - 1 : 0] s_axi_aburst_mux;
    wire [           4 - 1 : 0] s_axi_acache_mux;
    wire [           3 - 1 : 0] s_axi_aprot_mux;
    wire [  M_ID_WIDTH - 1 : 0] s_axi_aid_mux;
    wire [           8 - 1 : 0] s_axi_alen_mux;
    wire [               1 : 0] s_axi_alock_mux;
    wire [           4 - 1 : 0] s_axi_aqos_mux;
    wire [  USER_WIDTH - 1 : 0] s_axi_auser_mux;

    /***********************************************/
    reg [MASTER_N - 1 : 0] m_axi_aready_reg;

    wire [SLAVE_N              - 1 : 0] s_axi_avalid_int;
    wire [SLAVE_N * ADDR_WIDTH - 1 : 0] s_axi_aaddr_int;
    wire [SLAVE_N * S_ID_WIDTH - 1 : 0] s_axi_aid_int;

    wire [SLAVE_N              - 1 : 0] int_s_axi_aready;
    wire [SLAVE_N              - 1 : 0] ff_empty;



    assign m_axi_aregion        = 0;
    assign s_axi_aready = ~int_s_axi_aready;

    generate
    for (r = 1'b0; r < SLAVE_N; r = r + 1'b1) begin : Grant
      assign grant_request[r]   = s_axi_avalid_int[r] && !grants_reg[r];
      assign grant_release[r]   = s_axi_avalid_int[r] && grants_reg[r] && m_axi_aready_reg[master_sel_index_reg];
    end
    endgenerate

    generate
    for (rr = 1'b0; rr < SLAVE_N; rr = rr + 1'b1) begin : INPUT_ADDR_FIFO
      fifo
      #(
        .DEPTH                  (MAX_TRANS),
        .DATA_WIDTH             (INPUT_FIFO_DATA_WIDTH),
        .ONE_CLK_DATA           (1)
      )
      addr_fifo_inst
      (
        .clk                    (clk),
        .reset_n                (reset_n),
        .wr_enable              (s_axi_avalid[rr] && ~int_s_axi_aready[rr] ),
        .rd_enable              (grant_release[rr] && ~ff_empty[rr]),
        .data_in                ({s_axi_avalid[rr], s_axi_aid[rr * S_ID_WIDTH +: S_ID_WIDTH], s_axi_aaddr[rr * ADDR_WIDTH +: ADDR_WIDTH]}),
        .data_out               ({s_axi_avalid_int[rr], s_axi_aid_int[rr * S_ID_WIDTH +: S_ID_WIDTH], s_axi_aaddr_int[rr * ADDR_WIDTH +: ADDR_WIDTH]}),
        .full                   (int_s_axi_aready[rr]),
        .empty                  (ff_empty[rr])
      );
          end
    endgenerate

    /**********************************************/
    /*             Address arbitration            */
    /**********************************************/
    priority_arbiter_top
    #(
      .REQUEST_NUMBER   (SLAVE_N),
      .PRIORITY_WIDTH   (2)            // TODO update
    )
    priority_arbiter_top_inst
    (
      .clk              (clk),
      .reset            (reset_n),
      .requests         (grant_request),
      .grant_release    (grant_release),
      .priorities       ('{default:'0}),   // TODO update
      .grants           (grants)
    );

    onehot
    #(
      .WIDTH    (SLAVE_N)
    )
    grant_onehot_inst
    (
      .in       (grants),
      .out      (grant_index)
    );

    assign grants_out           = grants;
    assign grant_index_out      = grant_index;
    assign grant_valid          = ~grants_reg[grant_index] && grants[grant_index];


    onehot
    #(
      .WIDTH    (MASTER_N)
    )
    master_sel_onehot_inst
    (
      .in       (master_sel),
      .out      (master_sel_index)
    );


    /**********************************************/
    /*                Address MUX                 */
    /**********************************************/
    assign s_axi_avalid_mux     = s_axi_avalid_int [grant_index] && grants[grant_index];
    assign s_axi_aaddr_mux      = s_axi_aaddr_int  [grant_index * ADDR_WIDTH +: ADDR_WIDTH];
    assign s_axi_asize_mux      = s_axi_asize  [grant_index * 3 +: 3];
    assign s_axi_aburst_mux     = s_axi_aburst [grant_index * 2 +: 2];
    assign s_axi_acache_mux     = s_axi_acache [grant_index * 4 +: 4];
    assign s_axi_aprot_mux      = s_axi_aprot  [grant_index * 3 +: 3];    // TODO check prot
    assign s_axi_aid_mux        = s_axi_aid_int[grant_index * S_ID_WIDTH +: S_ID_WIDTH] | (grant_index << S_ID_WIDTH);
    //assign s_axi_aid_mux        = s_axi_aid_int    [grant_index * ID_WIDTH +: ID_WIDTH];
    assign s_axi_alen_mux       = s_axi_alen   [grant_index * 8 +: 8];
    assign s_axi_alock_mux      = s_axi_alock  [grant_index];             // TODO check lock
    assign s_axi_aqos_mux       = s_axi_aqos   [grant_index * 4 +: 4];    // TODO check qos
    assign s_axi_auser_mux      = s_axi_auser  [grant_index * USER_WIDTH +: USER_WIDTH];


    /**********************************************/
    /*              Master select                 */
    /**********************************************/
    axi_addr_dec_0 addr_dec_inst
    (
      .master_id    (grant_index),
      .addr         (s_axi_aaddr_mux),
      .ss           (master_sel)
    );

    assign master_sel_out       = master_sel;
    assign master_sel_index_out = master_sel_index;

    /**********************************************/
    /*              Address Output                */
    /**********************************************/
    generate
    for (m = 1'b0; m < MASTER_N; m = m + 1'b1) begin : Addr_output
      always @(*) begin
        if (master_sel[m]) begin
          m_axi_aaddr   [m * ADDR_WIDTH +: ADDR_WIDTH] = s_axi_aaddr_mux;
          m_axi_aid     [m * M_ID_WIDTH +: M_ID_WIDTH] = s_axi_aid_mux;
          m_axi_alen    [m *          8 +:          8] = s_axi_alen_mux;
          m_axi_alock   [m                           ] = s_axi_alock_mux;
          m_axi_aqos    [m *          4 +:          4] = s_axi_aqos_mux;
          m_axi_auser   [m * USER_WIDTH +: USER_WIDTH] = s_axi_auser_mux;
          m_axi_asize   [m *          3 +:          3] = s_axi_asize_mux;
          m_axi_aburst  [m *          2 +:          2] = s_axi_aburst_mux;
          m_axi_acache  [m *          4 +:          4] = s_axi_acache_mux;
          m_axi_aprot   [m *          3 +:          3] = s_axi_aprot_mux;
          m_axi_avalid  [m                           ] = s_axi_avalid_mux;
        end
        else begin
          m_axi_aaddr   [m * ADDR_WIDTH +: ADDR_WIDTH] = 1'b0;
          m_axi_aid     [m * M_ID_WIDTH +: M_ID_WIDTH] = 1'b0;
          m_axi_alen    [m *          8 +:          8] = 1'b0;
          m_axi_alock   [m                           ] = 1'b0;
          m_axi_aqos    [m *          4 +:          4] = 1'b0;
          m_axi_auser   [m * USER_WIDTH +: USER_WIDTH] = 1'b0;
          m_axi_asize   [m *          3 +:          3] = 1'b0;
          m_axi_aburst  [m *          2 +:          2] = 1'b0;
          m_axi_acache  [m *          4 +:          4] = 1'b0;
          m_axi_aprot   [m *          3 +:          3] = 1'b0;
          m_axi_avalid  [m                           ] = 1'b0;
        end
      end
    end
    endgenerate


    /**********************************************/
    /*                    Reg                     */
    /**********************************************/
    always@(posedge clk, negedge reset_n) begin
      if(!reset_n) begin
        grants_reg              <= 1'b0;
        master_sel_index_reg    <= 1'b0;
        m_axi_aready_reg        <= 1'b0;
      end
      else begin
        grants_reg              <= grants;
        master_sel_index_reg    <= master_sel_index;
        m_axi_aready_reg        <= m_axi_aready;
      end
    end

endmodule