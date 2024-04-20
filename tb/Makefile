VLOG=/home/hackathon_fpga/tools/Questa/questasim/linux_x86_64/vlog
VCOM=/home/hackathon_fpga/tools/Questa/questasim/linux_x86_64/vcom
VSIM=/home/hackathon_fpga/tools/Questa/questasim/linux_x86_64/vsim
QRUN=/home/hackathon_fpga/tools/Questa/questasim/linux_x86_64/qrun
SWITCHES= -modelsimini ./modelsim.ini -suppress 10016 -incr -mfcu -sv -L axi_vip_v1_1_15 -L smartconnect_v1_0 -L zynq_ultra_ps_e_vip_v1_0_15 -L xilinx_vip -work xil_defaultlib
LIBS=- -L xil_defaultlib -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_15 -L zynq_ultra_ps_e_vip_v1_0_15 -L axi_bram_ctrl_v4_1_9 -L blk_mem_gen_v8_4_7 -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_14 -L xlconstant_v1_1_8 -L smartconnect_v1_0 -L axi_register_slice_v2_1_29 -L xbip_utils_v3_0_11 -L c_reg_fd_v12_0_7 -L xbip_dsp48_wrapper_v3_0_5 -L xbip_pipe_v3_0_7 -L xbip_dsp48_addsub_v3_0_7 -L xbip_addsub_v3_0_7 -L c_addsub_v12_0_16 -L c_gate_bit_v12_0_7 -L xbip_counter_v3_0_7 -L c_counter_binary_v12_0_17 -L util_reduced_logic_v2_0_5 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -L xpm
COMPILATION_BASE=+incdir+../../../../../../src +incdir+../../../../hackhaton.gen/sources_1/bd/design_1/ipshared/ec67/hdl +incdir+../../../../hackhaton.gen/sources_1/bd/design_1/ipshared/2fcd/hdl +incdir+../../../../hackhaton.gen/sources_1/bd/design_1/ipshared/c2c6 +incdir+../../../../../bd/design_1/ipshared/f0b6/hdl/verilog +incdir+../../../../../bd/design_1/ipshared/35de/hdl/verilog +incdir+../../../../hackhaton.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog +incdir+../../../../hackhaton.gen/sources_1/bd/design_1/ipshared/35de/hdl/verilog +incdir+/home/hackathon_fpga/tools/Xilinx/Vivado/2023.2/data/xilinx_vip/include \
../../../../../../src/axi_mm_master.v \
../../../../../../src/sync_fifo.v \
../../../../../../src/sync_fifo_asymm.v \
../../../../../../src/control.sv \
../../../../../../src/task_1/*.sv \
../../../../../../src/task_3/*.sv \
../../../../../../src/task_2/*.sv \
../../../../../../src/task_9/*.sv \
../../../../../../src/task_8/*.sv \
../../../../../../src/task_10/*.sv \
../../../../../../src/task_11/*.sv \
../../../../../../src/task_12/*.sv \
../../../../../../src/task_13/*.sv \
../../../../../../src/task_14/*.sv \
../../../../../../src/task_15/*.sv \
../../../../../../src/task_4/*.sv \
../../../../../../src/task_5/*.sv \
../../../../../../src/task_6/*.sv \
../../../../../../src/task_7/*.sv \
../../../../../../src/task_manager.sv \
../../../../../../src/controll_wrapper.v \
../../../../../../src/control_regs_S_AXI.v \
../../../../../../src/control_regs.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_zynq_ultra_ps_e_0_0/sim/design_1_zynq_ultra_ps_e_0_0_vip_wrapper.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_clk_wiz.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_axi_bram_ctrl_0_0/sim/design_1_axi_bram_ctrl_0_0.vhd \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_pl_controller_0_0/sim/design_1_pl_controller_0_0.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_control_wrapper_0_0/sim/design_1_control_wrapper_0_0.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_xlconstant_0_0/sim/design_1_xlconstant_0_0.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_control_regs_0_0/sim/design_1_control_regs_0_0.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_0/sim/bd_88fd_one_0.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_1/sim/bd_88fd_psr_aclk_0.vhd \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_2/sim/bd_88fd_arinsw_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_3/sim/bd_88fd_rinsw_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_4/sim/bd_88fd_awinsw_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_5/sim/bd_88fd_winsw_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_6/sim/bd_88fd_binsw_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_7/sim/bd_88fd_aroutsw_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_8/sim/bd_88fd_routsw_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_9/sim/bd_88fd_awoutsw_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_10/sim/bd_88fd_woutsw_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_11/sim/bd_88fd_boutsw_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_12/sim/bd_88fd_arni_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_13/sim/bd_88fd_rni_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_14/sim/bd_88fd_awni_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_15/sim/bd_88fd_wni_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_16/sim/bd_88fd_bni_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_17/sim/bd_88fd_s00mmu_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_18/sim/bd_88fd_s00tr_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_19/sim/bd_88fd_s00sic_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_20/sim/bd_88fd_s00a2s_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_21/sim/bd_88fd_sarn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_22/sim/bd_88fd_srn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_23/sim/bd_88fd_sawn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_24/sim/bd_88fd_swn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_25/sim/bd_88fd_sbn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_26/sim/bd_88fd_s01mmu_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_27/sim/bd_88fd_s01tr_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_28/sim/bd_88fd_s01sic_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_29/sim/bd_88fd_s01a2s_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_30/sim/bd_88fd_sarn_1.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_31/sim/bd_88fd_srn_1.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_32/sim/bd_88fd_sawn_1.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_33/sim/bd_88fd_swn_1.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_34/sim/bd_88fd_sbn_1.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_35/sim/bd_88fd_m00s2a_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_36/sim/bd_88fd_m00arn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_37/sim/bd_88fd_m00rn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_38/sim/bd_88fd_m00awn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_39/sim/bd_88fd_m00wn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_40/sim/bd_88fd_m00bn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_41/sim/bd_88fd_m00e_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_42/sim/bd_88fd_m01s2a_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_43/sim/bd_88fd_m01arn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_44/sim/bd_88fd_m01rn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_45/sim/bd_88fd_m01awn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_46/sim/bd_88fd_m01wn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_47/sim/bd_88fd_m01bn_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/ip/ip_48/sim/bd_88fd_m01e_0.sv \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/bd_0/sim/bd_88fd.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_smartconnect_1_0/sim/design_1_smartconnect_1_0.v \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_c_counter_binary_0_0/sim/design_1_c_counter_binary_0_0.vhd \
../../../../hackhaton.gen/sources_1/bd/design_1/ip/design_1_util_reduced_logic_0_0/sim/design_1_util_reduced_logic_0_0.v \
../../../../hackhaton.gen/sources_1/bd/design_1/sim/design_1.v \
../../../../../../src/design_1_wrapper.v \
../../../../../../tb/tb_top.sv \
glbl.v

###
batch: compile optimize simulate
gui: simulate_gui

compile:
	$(QRUN) -compile -top tb_top -top glbl $(SWITCHES) $(LIBS) $(COMPILATION_BASE)
optimize:
	$(QRUN) -optimize -top tb_top -top glbl $(SWITCHES) $(LIBS) $(COMPILATION_BASE) 
simulate:
	$(QRUN) -simulate -top tb_top -top glbl $(SWITCHES) $(LIBS) $(COMPILATION_BASE)

### THIS TARGET HERE WILL RUN GUI MODE FOR SIMULATION
simulate_gui:
	$(QRUN) -visualizer -gui=interactive -debug,livesim -top tb_top -top glbl $(SWITCHES) $(LIBS) $(COMPILATION_BASE)
