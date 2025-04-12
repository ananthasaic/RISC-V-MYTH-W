# RISC-V-MYTH-W

"Started with Implementing a TL Verilog in Makerchip"

1) Non-pipelined calculator


TL-verilog code:-
    $op[1:0] = $rand1[1:0];
    $val1[31:0] = >>2$out;
    $val2[31:0] = $rand2[2:0];
    $sum[31:0] = $val1 + $val2;
    $difff[31:0] = $val1 - $val2;
    $prod[31:0] = $val1 * $val2;
    $quot[31:0] = $val1 / $val2;
    $out[31:0] = $valid_or_reset ? 1'b0 : ($op[0] ? ($op[1] ? $quot[31:0] :    $difff[31:0]) : ($op[1] ? $prod[31:0] :    $sum[31:0]));

<img width="409" alt="image" src="https://github.com/user-attachments/assets/c3e27bc6-e506-449b-8f8e-f5f012e80fdf" />

2) Pipelined calculator with a valid signal
TL-verilog code:-


   |calc
      @0
         $reset = *reset;

      ?$valid   
         @1
            $cnt = $reset ? 0 : (1 + >>1$cnt);
            $op[1:0] = $rand1[1:0];
            $val1[31:0] = >>2$out;
            $val2[31:0] = $rand2[2:0];
            $sum[31:0] = $val1 + $val2;
            $difff[31:0] = $val1 - $val2;
            $prod[31:0] = $val1 * $val2;
            $quot[31:0] = $val1 / $val2;
            $valid_or_reset = $valid || $reset;
         @2
            $out[31:0] = $valid_or_reset ? 1'b0 : ($op[0] ? ($op[1] ? $quot[31:0] :    $difff[31:0]) : ($op[1] ? $prod[31:0] :    $sum[31:0]));
<img width="702" alt="image" src="https://github.com/user-attachments/assets/2fbb85d1-e552-435f-97ca-e0b101525ddc" />
