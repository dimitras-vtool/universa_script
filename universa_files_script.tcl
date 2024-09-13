
add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/Top_Level_Wrapper/rv_core.v} {C:/GitHub/RISCV-SoC/rtl/Top_Level_Wrapper/soc_wrapper.sv} {C:/GitHub/RISCV-SoC/rtl/Top_Level_Wrapper/rvfpganexys.sv}}

set_property top rvfpganexys [current_fileset]

update_compile_order -fileset sources_1


add_files -norecurse {C:/GitHub/RISCV-SoC/rtl/Bscan_Tap/bscan_tap.sv}

add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/Bridges/AXI_to_Wishbone/axi2wb.v} {C:/GitHub/RISCV-SoC/rtl/CLK_Gen_50MHz/clk_gen_nexys.v}}

update_compile_order -fileset sources_1

add_files -norecurse {C:/GitHub/RISCV-SoC/rtl/Blink/blink.v}

add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/Bridges/axi2apb/axi2apb_1_wrapper.sv} {C:/GitHub/RISCV-SoC/rtl/Bridges/axi2apb/axi2apb_0_wrapper.sv} {C:/GitHub/RISCV-SoC/rtl/Bridges/axi2apb/axi2apb_1.sv} {C:/GitHub/RISCV-SoC/rtl/Bridges/axi2apb/axi2apb_0.sv}}



add_files -norecurse {C:/GitHub/RISCV-SoC/rtl/Interconnect/axi_fabric_top/axi_fabric_top_wrapper.sv}

add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/Interconnect/Wishbone/wb_intercon.v} {C:/GitHub/RISCV-SoC/rtl/Interconnect/Wishbone/wb_mux.v}}

update_compile_order -fileset sources_1


#GPIO
add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/Peripherals/gpio/sv/interrupt_logic.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/gpio/sv/synchronizer.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/gpio/sv/gpio_logic.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/gpio/sv/gpio_top.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/gpio/sv/debouncer.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/gpio/sv/edge_detector.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/gpio/sv/level_sensitive.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/gpio/sv/rdb_gpio.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/gpio/sv/vtool_reg.sv}}

#Interrupt
add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/Peripherals/interrupt_controller/sv/interrupt_ctrl_vtool_reg.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/interrupt_controller/sv/interrupt_handle_block.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/interrupt_controller/sv/interrupt_ctrl_apb_slave.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/interrupt_controller/sv/interrupt_controller_top.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/interrupt_controller/sv/interrupt_priority_block.sv}}

update_compile_order -fileset sources_1

#SPI
add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_s_ctrl_fsm.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_m_shift_ctrl.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/clk_div_2n.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/cdc_block.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/counter.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/clock_gate.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_start_detect.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/hs_pulse_sync.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/vtool_reg.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/reset_sync.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_top.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_master_logic.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_transfer_fsm.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/data_synchronizer.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_async_fifo.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_shift_reg.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/sync_2ff.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_regs.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/piso.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_load_conf_fsm.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/sipo.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_s_ctrl.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/clk_div_2.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_m_shift_ctrl_fsm.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_vtool_reg.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/spi_slave_logic.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/spi/sv/prescale_clk.sv}}

update_compile_order -fileset sources_1

#Timer
add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/Peripherals/timer/sv/output_ctrl.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/timer/sv/prescaler.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/timer/sv/t_apb_slave.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/timer/sv/timer_input_detector.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/timer/sv/t_vtool_reg.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/timer/sv/timer_top.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/timer/sv/clk_en_fsm.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/timer/sv/direction_fsm.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/timer/sv/t_counter.sv}}

update_compile_order -fileset sources_1

#UART
add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_tx_fifo.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_transceiver_top.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_transceive_buffer.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_async_fifo.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_rx_fifo.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/vt_uart_receiver.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/vtool_reg.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_receiver_top.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_async_counter.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_receive_buffer.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_regs_db.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_transceiver.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/uart_baud_generator.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/uart/sv/vt_uart_top.sv}}

update_compile_order -fileset sources_1

#I2C
add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/Peripherals/vt_i2c/sv/i2c_top.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/vt_i2c/sv/i2c_irq_ctrl.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/vt_i2c/sv/clk_divider.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/vt_i2c/sv/i2c_ctrl_fsm.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/vt_i2c/sv/i2c_scl_gen.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/vt_i2c/sv/i2c_regs.sv} {C:/GitHub/RISCV-SoC/rtl/Peripherals/vt_i2c/sv/i2c_cdc.sv}}

#Core
add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/pic_ctrl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dma_ctrl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/veer.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/veer_wrapper.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/mem.sv}}

update_compile_order -fileset sources_1

add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/include/common_defines.vh} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/include/pic_map_auto.h} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/include/build.h} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/include/global.h}}

update_compile_order -fileset sources_1



#/////////////////////


set_property is_global_include true [get_files  {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/include/common_defines.vh}]

update_compile_order -fileset sources_1

add_files -norecurse {{C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/ifu/ifu_ifc_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dbg/dbg.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/ifu/ifu_mem_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu_dccm_mem.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu_addrcheck.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dmi/dmi_wrapper.v} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/exu/exu_mul_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dec/dec_trigger.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dec/dec_tlu_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu_bus_buffer.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/ifu/ifu_compress_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lib/svci_to_axi4.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dec/dec_gpr_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/ifu/ifu.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/exu/exu_alu_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lib/mem_lib.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu_clkdomain.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dec/dec.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lib/beh_lib.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/ifu/ifu_ic_mem.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dmi/rvjtag_tap.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/exu/exu.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/exu/exu_div_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu_ecc.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu_stbuf.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/ifu/ifu_bp_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lib/ahb_to_axi4.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/ifu/ifu_iccm_mem.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu_trigger.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dec/dec_decode_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/include/veer_types.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu_lsc_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dec/dec_ib_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu_dccm_ctl.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lib/axi4_to_ahb.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/dmi/dmi_jtag_to_core_sync.v} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/lsu/lsu_bus_intf.sv} {C:/GitHub/RISCV-SoC/rtl/VeeR_EH1_Core/ifu/ifu_aln_ctl.sv}}

update_compile_order -fileset sources_1


#Add also files rom RISCV-SoC>InterconnectIP

add_files -norecurse {{C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/b_response.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/rd_register.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/addr_dec_mst_sel.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/reg_gen.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/rd_data_mux.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/wr_register.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/axi_fabric_top.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/b_data_mux.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/wr_reg_gen.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/addr_soc.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/dff_2.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/fifo.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/wr_data_mux.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/dff.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/rd_response.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/onehot.sv}}


update_compile_order -fileset sources_1

#(priority_arbiter) 
add_files -norecurse {{C:/GitHub/RISCV-SoC/InterconnectIP/rtl/priority_arbiter/sv/priority_arbiter_top.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/priority_arbiter/sv/round_robin_arbiter_with_enable.sv}} 

add_files -norecurse {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/round_robin_arbiter/sv/round_robin_arbiter_top.sv}

#(async_fifo) 
add_files -norecurse {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/async_fifo/sv/async_fifo.sv}

#(set_reset_write_err and read_response_fsm) 
add_files -norecurse {{C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/set_reset_write_err.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/read_response_fsm.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/demux.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/round_robin_arbiter_wrapper.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/sync_fifo.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/addr_dec.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/write_fsm.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/we_reg.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux_demux_write_request_path.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/async_fifo_wrapper.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/parametrized_round_robin_arbiter_wrapper.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/read_fsm.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux_demux_response_path.sv}  {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux_0.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux_demux_read_request_path.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux_demux_write_resp.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/negedge_detector.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/posedge_detector.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/arb2apb.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/sr_reg.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/apb_error_slave.sv} {C:/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/axi2apb.sv}} 

update_compile_order -fileset sources_1

# ################################    From C:/GitHub/RISCV-SoC/InterconnectIP/rtl/design_filelist.f   ##############################3

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/ahb_byte_swapping.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/data_reg.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/hrdata_reg.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/fifo_memory.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/ahb_internal_logic.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/write_transfer_ready.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/ahb.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/hwdata_mux.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/ahb_hwdata_alignment.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/positive_edge_detector.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/interrupt_info.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/ahb_apb.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/ahb_ff_sync.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/ahb_to_apb_bridge.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/ahb_demux.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb2apb/sv/ahb_hrdata_alignment.v}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2ahb/sv/positive_edge_detector_delayed.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2ahb/sv/hrdata_alignment.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2ahb/sv/internal_logic.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2ahb/sv/apb_positive_edge_detector.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2ahb/sv/ff_sync.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2ahb/sv/byte_swapping.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2ahb/sv/apb_ahb.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2ahb/sv/apb_to_ahb_bridge.v} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2ahb/sv/hwdata_alignment.v}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2axi/sv/apb2axi_kernel.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2axi/sv/apb2axi_sync.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb2axi/sv/apb2axi_top.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb_arbiter/sv/address_decoder.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb_arbiter/sv/apb_arbiter_slv_mux.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb_arbiter/sv/apb_arbiter.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb_arbiter/sv/apb_arbiter_top.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb_arbiter/sv/apb_arbiter_mst_mux.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb_arbiter/sv/apb_arbiter_roundrobin.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb_default_slave/sv/fsm.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb_default_slave/sv/apb_default_slave.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/apb_splitter/sv/apb_splitter_top.sv}}

#???
add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/async_fifo/sv/async_fifo.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/demux.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/round_robin_arbiter_wrapper.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/sync_fifo.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/addr_dec.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/write_fsm.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/we_reg.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux_demux_write_request_path.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/set_reset_write_err.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/async_fifo_wrapper.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/parametrized_round_robin_arbiter_wrapper.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/read_fsm.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux_demux_response_path.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/read_response_fsm.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux_0.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux_demux_read_request_path.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/mux_demux_write_resp.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/negedge_detector.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/posedge_detector.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/arb2apb.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/sr_reg.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/apb_error_slave.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2apb/sv/axi2apb.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_bresp_req_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_write_req_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_write_s_data_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/cnt_control.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/s_id_table_compare.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_read_req_handler_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_bresp_req_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_read_req_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/set_reset_flag.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_write_m_data_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_write_req_handler_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_write_req_handler_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi2axi_top.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_read_s_data_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_read_req_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/param_control.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_read_s_data_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_priority_encoder.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_bresp_handler_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_read_m_data_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_read_req_handler_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_write_req_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_write_s_data_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_read_m_data_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_bresp_handler_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_write_m_data_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_width_adapter_rd.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_width_adapter_wr.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axi/sv/axi_sync_fifo.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_read_req_handler_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_read_s_data_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_write_m_data_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_read_req_handler_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_bresp_handler_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_read_req_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_width_adapter_rd.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/num_zeros.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_bresp_req_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_read_m_data_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_bresp_req_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_write_req_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_write_s_data_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_write_req_handler_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_write_req_handler_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_bresp_handler_downsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/priority_encoder.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/flag_control.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_read_s_data_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_read_m_data_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_write_s_data_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_read_m_data_pass.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_read_req_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_width_adapter_wr.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_write_req_upsizer.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_write_m_data_pass.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi2axilite_top.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2axilite/sv/axi_axil_write_m_data_upsizer.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2wb/sv/cdc_s2f.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2wb/sv/axi2wb_top.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2wb/sv/axi2wb_fsm.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2wb/sv/cdc_f2s.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi2wb/sv/axi2wb_func_pack.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_crossbar/sv/axi_crossbar_top.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/b_response.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/rd_register.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/addr_dec_mst_sel.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/reg_gen.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/rd_data_mux.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/wr_register.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/axi_fabric_top.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/b_data_mux.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/wr_reg_gen.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/addr_soc.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/dff_2.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/fifo.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/wr_data_mux.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/dff.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/rd_response.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_fabric/sv/onehot.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_to_sram/sv/hs_fsm.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_to_sram/sv/axi_to_sram_top.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/axi_to_sram/sv/flow_control.sv}}

#???
add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/priority_arbiter/sv/round_robin_arbiter_with_enable.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/priority_arbiter/sv/priority_arbiter_top.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/round_robin_arbiter/sv/round_robin_arbiter_top.sv}}

add_files -norecurse {{C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb_arbiter/sv/ahb_arbiter_roundrobin.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb_arbiter/sv/ahb_arbiter_slv_mux.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb_arbiter/sv/ahb_arbiter_mst_mux.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb_arbiter/sv/ahb_sample_fsm.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb_arbiter/sv/ahb_arbiter.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb_arbiter/sv/ahb_arbiter_fsm.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb_arbiter/sv/ahb_arbiter_top.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb_arbiter/sv/address_decoder_mix.sv} {C:/Users/Dimitra Skinezou/Documents/GitHub/RISCV-SoC/InterconnectIP/rtl/ahb_arbiter/sv/ahb_arbiter_mst_sample.sv}}


add_files -norecurse {C:/GitHub/RISCV-SoC/InterconnectIP/scripts/addr_dec_gen/apb_addr_dec_0/apb_addr_dec_0.sv}


add_files -norecurse {C:/GitHub/RISCV-SoC/InterconnectIP/scripts/addr_dec_gen/apb_addr_dec_1/apb_addr_dec_1.sv}


#(only way to add clk after)
#Open elaborated desing 

#ADD PROJECT NAME
#synth_design -rtl -name <project_name>

#Add clock_gate

#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}];


#synth_design -top rvfpganexys -part xc7a100tcsg324-1 -lint 
