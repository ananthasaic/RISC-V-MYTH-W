\m5_TLV_version 1d: tl-x.org
\SV
   `include "sqrt32.v";
   m4_include_lib(https://raw.githubusercontent.com/stevehoover/makerchip_examples/refs/heads/master/pythagoras_viz.tlv)
   
   m5_makerchip_module
\TLV
      
  
   |calc
      @0
         $reset = *reset;
      @1
         $valid = $reset ? 0 : (>>1$valid + 1);
         $valid_or_reset = $valid || $reset;

      ?$valid_or_reset   
         @1
            //$cnt = $reset ? 0 : (1 + >>1$cnt);
            $val1[31:0] = >>2$out;
            $op[2:0] = $rand[2:0];
            $val2[31:0] = $rand2[2:0];
            
            $sum[31:0] = $val1 + $val2;
            $difff[31:0] = $val2 - $val1;
            $prod[31:0] = $val1 * $val2;
            $quot[31:0] = $val1 / $val2;



         @2
            //$out[31:0] = $valid_or_reset ? 1'b0 : ($op[0] ? ($op[1] ? $quot[31:0] :    $difff[31:0]) : ($op[1] ? $prod[31:0] :    $sum[31:0]));
            $out[31:0] = ($op[2:0] == 3'd3) ? $quot[31:0] : ($op[2:0] == 3'd1)  ?  $difff[31:0] : ($op[2:0] == 3'd2) ? $prod[31:0] :  ($op[2:0] == 3'd1) ?  $sum[31:0] : ($op[2:0] == 3'd4) ? >>2$mem[31:0] : 32'b0;
            $mem[31:0] = $op == 3'b101 ? >>2$out[31:0] : $op == 3'd4 ?  >>2$mem[31:0] : >>2$mem[31:0];

   


   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
            // VIZ and LOG output.
            // Note that this can affect the logic in the DIAGRAM. You may comment this out.
            //m5+pythagorean_viz_and_log(1)
\SV
   endmodule
