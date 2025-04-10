\m5_TLV_version 1d: tl-x.org
\SV
   `include "sqrt32.v";
   m4_include_lib(https://raw.githubusercontent.com/stevehoover/makerchip_examples/refs/heads/master/pythagoras_viz.tlv)
   
   m5_makerchip_module
\TLV
      
  
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

   



            // VIZ and LOG output.
            // Note that this can affect the logic in the DIAGRAM. You may comment this out.
            //m5+pythagorean_viz_and_log(1)
