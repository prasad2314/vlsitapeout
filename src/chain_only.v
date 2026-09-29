`default_nettype none
module tt_um_prasa_droop_monitor (
    input wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input wire clk,
    input wire rst_n,
    input wire ena
);
wire [255:0] delay;
assign delay[0] = ~ui_in[0];

genvar i;
generate
    for (i=1; i<256; i=i+1) begin : D
        sky130_fd_sc_hd__inv_1 u (
            .A(delay[i-1]),
            .Y(delay[i])
        );
    end
endgenerate

reg alert;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        alert <= 1'b0;
    else
        alert <= ~delay[255];
end

assign uo_out = {7'b0, alert};
assign uio_out = 8'b0;
assign uio_oe = 8'b0;
endmodule
`default_nettype wire
