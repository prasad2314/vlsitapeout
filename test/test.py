import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_supply_droop_delay_line(dut):

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.rst_n.value = 1

    await Timer(10, unit="ns")

    # Launch rising transition
    dut.ui_in.value = 1

    # 32 unit-delay cells -> allow ample propagation time
    await Timer(50, unit="ns")

    assert int(dut.uo_out.value) & 1 == 1

    # Launch falling transition
    dut.ui_in.value = 0

    await Timer(50, unit="ns")

    assert int(dut.uo_out.value) & 1 == 0

    dut._log.info("32-stage supply-droop delay-line test PASSED")
