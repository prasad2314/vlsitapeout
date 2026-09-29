`default_nettype none

module tt_um_prasa_droop_monitor (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    /*
     * Supply-droop timing monitor
     *
     * ui_in[0] launches a transition.
     * The transition propagates through 32 CMOS inverters.
     * Reduced VDD increases propagation delay.
     * uo_out[0] exposes the delayed transition for measurement.
     *
     * This intentionally has no feedback loop and no internal clock.
     */

    (* keep = "true" *) wire [32:0] delay;

    assign delay[0] = ui_in[0] & ena;

    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin : DELAY_CHAIN
            (* keep = "true" *)
            sky130_fd_sc_hd__inv_1 u_inv (
                .A(delay[i]),
                .Y(delay[i+1])
            );
        end
    endgenerate

    assign uo_out[0] = delay[32];

    assign uo_out[7:1] = 7'b0;
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule

`default_nettype wire
