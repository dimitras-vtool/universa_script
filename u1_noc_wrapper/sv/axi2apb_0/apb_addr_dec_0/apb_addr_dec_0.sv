// ########################################################################
// Module name        : apb_addr_dec_0.sv
// Description        : Address Decoder
// Author             : Luka Radulovic
// Created On         : 2024-10-23 10:54:34.884354
// Modified By        : ________
// Modified On        : ________
// Modification Description :
// Version         : 0.8
// -------------------------------------------
module apb_addr_dec_0
    #
    (
        parameter PARAM_WIDTH = 32,
        parameter [PARAM_WIDTH-1:0] ADDR_WIDTH = 32,
        parameter [PARAM_WIDTH-1:0] MASTER_NUM_LOG = 1,
        parameter [PARAM_WIDTH-1:0] SLAVE_NUM = 5,
        parameter [PARAM_WIDTH-1:0] SLAVE_NUM_LOG = 3,
    
        parameter [ADDR_WIDTH-1:0] SLAVE_0_START_ADDRS [0:0] = '{32'h00000000},
        parameter [ADDR_WIDTH-1:0] SLAVE_0_END_ADDRS [0:0] = '{32'h0000AAAA},
        parameter [PARAM_WIDTH-1:0] SLAVE_0_RANGE_NUM = 1,
    
        parameter [ADDR_WIDTH-1:0] SLAVE_1_START_ADDRS [0:0] = '{32'h0000AAAB},
        parameter [ADDR_WIDTH-1:0] SLAVE_1_END_ADDRS [0:0] = '{32'h00015555},
        parameter [PARAM_WIDTH-1:0] SLAVE_1_RANGE_NUM = 1,
    
        parameter [ADDR_WIDTH-1:0] SLAVE_2_START_ADDRS [0:0] = '{32'h00015556},
        parameter [ADDR_WIDTH-1:0] SLAVE_2_END_ADDRS [0:0] = '{32'h0001FFFF},
        parameter [PARAM_WIDTH-1:0] SLAVE_2_RANGE_NUM = 1,
    
        parameter [ADDR_WIDTH-1:0] SLAVE_3_START_ADDRS [0:0] = '{32'h00020000},
        parameter [ADDR_WIDTH-1:0] SLAVE_3_END_ADDRS [0:0] = '{32'h0002FFFF},
        parameter [PARAM_WIDTH-1:0] SLAVE_3_RANGE_NUM = 1,
    
        parameter [ADDR_WIDTH-1:0] SLAVE_4_START_ADDRS [0:0] = '{32'h00030000},
        parameter [ADDR_WIDTH-1:0] SLAVE_4_END_ADDRS [0:0] = '{32'h0003FFFF},
        parameter [PARAM_WIDTH-1:0] SLAVE_4_RANGE_NUM = 1
    
    )
    (
        input [MASTER_NUM_LOG-1:0] master_id,
        input [ADDR_WIDTH-1:0] addr,
        output reg [SLAVE_NUM-1:0] ss
    );

    localparam [SLAVE_NUM_LOG-1:0] SLAVE_0 = 3'd0;
    localparam [SLAVE_NUM_LOG-1:0] SLAVE_1 = 3'd1;
    localparam [SLAVE_NUM_LOG-1:0] SLAVE_2 = 3'd2;
    localparam [SLAVE_NUM_LOG-1:0] SLAVE_3 = 3'd3;
    localparam [SLAVE_NUM_LOG-1:0] SLAVE_4 = 3'd4;
	
    localparam SLAVE_ADDR_RANGE_MAX_LOG = 1;

    reg [SLAVE_NUM_LOG-1:0] ii;
    reg [SLAVE_ADDR_RANGE_MAX_LOG-1:0] jj;

    localparam [MASTER_NUM_LOG-1:0] MASTER_0 =  1'd0;


    reg slave_0_addres_in_range; // SLAVE_0_RANGE_NUM == 1 
    reg slave_1_addres_in_range; // SLAVE_1_RANGE_NUM == 1 
    reg slave_2_addres_in_range; // SLAVE_2_RANGE_NUM == 1 
    reg slave_3_addres_in_range; // SLAVE_3_RANGE_NUM == 1 
    reg slave_4_addres_in_range; // SLAVE_4_RANGE_NUM == 1 

    always@(*)
        begin
         case(master_id)
             MASTER_0:
                begin
                    for(ii = {PARAM_WIDTH{1'b0}}; ii<SLAVE_NUM; ii=ii+1'b1) begin
                        case(ii)
                            SLAVE_0: // SLAVE_0 is visible to MASTER_0
                                begin
                                    if(addr >= SLAVE_0_START_ADDRS[0] && addr <= SLAVE_0_END_ADDRS[0])
                                        begin
                                            slave_0_addres_in_range = 1'b1;
                                        end
                                    else
                                        begin
                                            slave_0_addres_in_range = 1'b0;
                                        end
                                end
                            SLAVE_1: // SLAVE_1 is visible to MASTER_0
                                begin
                                    if(addr >= SLAVE_1_START_ADDRS[0] && addr <= SLAVE_1_END_ADDRS[0])
                                        begin
                                            slave_1_addres_in_range = 1'b1;
                                        end
                                    else
                                        begin
                                            slave_1_addres_in_range = 1'b0;
                                        end
                                end
                            SLAVE_2: // SLAVE_2 is visible to MASTER_0
                                begin
                                    if(addr >= SLAVE_2_START_ADDRS[0] && addr <= SLAVE_2_END_ADDRS[0])
                                        begin
                                            slave_2_addres_in_range = 1'b1;
                                        end
                                    else
                                        begin
                                            slave_2_addres_in_range = 1'b0;
                                        end
                                end
                            SLAVE_3: // SLAVE_3 is visible to MASTER_0
                                begin
                                    if(addr >= SLAVE_3_START_ADDRS[0] && addr <= SLAVE_3_END_ADDRS[0])
                                        begin
                                            slave_3_addres_in_range = 1'b1;
                                        end
                                    else
                                        begin
                                            slave_3_addres_in_range = 1'b0;
                                        end
                                end
                            SLAVE_4: // SLAVE_4 is visible to MASTER_0
                                begin
                                    if(addr >= SLAVE_4_START_ADDRS[0] && addr <= SLAVE_4_END_ADDRS[0])
                                        begin
                                            slave_4_addres_in_range = 1'b1;
                                        end
                                    else
                                        begin
                                            slave_4_addres_in_range = 1'b0;
                                        end
                                end
                            default:
                                begin // no more slaves
                                    slave_0_addres_in_range = 1'd0;
                                    slave_1_addres_in_range = 1'd0;
                                    slave_2_addres_in_range = 1'd0;
                                    slave_3_addres_in_range = 1'd0;
                                    slave_4_addres_in_range = 1'd0;
                                end
                        endcase
                    end
                end
            default: //unknown master
                begin
                  slave_0_addres_in_range = 1'd0;
                  slave_1_addres_in_range = 1'd0;
                  slave_2_addres_in_range = 1'd0;
                  slave_3_addres_in_range = 1'd0;
                  slave_4_addres_in_range = 1'd0;
                end
         endcase
        end

    always@(*)
        begin
            for(ii={PARAM_WIDTH{1'b0}}; ii<SLAVE_NUM; ii=ii+1'b1) begin
                case(ii)
                    SLAVE_0:
                        begin
                            ss[0] = |slave_0_addres_in_range;
                        end
                    SLAVE_1:
                        begin
                            ss[1] = |slave_1_addres_in_range;
                        end
                    SLAVE_2:
                        begin
                            ss[2] = |slave_2_addres_in_range;
                        end
                    SLAVE_3:
                        begin
                            ss[3] = |slave_3_addres_in_range;
                        end
                    SLAVE_4:
                        begin
                            ss[4] = |slave_4_addres_in_range;
                        end
                    default:
                        begin // no more ss bits
                            ss = {SLAVE_NUM{1'b0}};
                        end
                endcase
            end
        end

endmodule

