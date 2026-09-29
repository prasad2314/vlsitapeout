/* Behavioral model used only by the RTL simulation.
 * The real SKY130 standard-cell implementation is used during hardening.
 */
module sky130_fd_sc_hd__inv_1 (
    input  A,
    output Y
);
    assign Y = ~A;
endmodule
