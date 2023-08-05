                                                /** testbench code **/

module ALU_OPERATOR_DUT ();         
reg [15:0] inp1, inp2 ;
reg [2:0] opcode ;
wire [31:0]result ;
integer k,m ;

ALU_OPERATOR uut1 (
.inp1(inp1),
.inp2(inp2),
.opcode(opcode),
.result(result)
);

initial
   begin
     for(m=0;m<4;m=m+1)
       begin
         if (m==0)
           begin
            inp1 = 7511 ;
            inp2 = 1250 ;
           end 

         else if(m==1)
           begin
            inp1 = -30650 ;
            inp2 = -20864 ;
           end

         else if(m==2)
           begin
            inp1 = 2364 ;  
            inp2 = -1023 ;
           end

         else if(m==3)
           begin
            inp1 = -9458 ;
            inp2 = 11023 ;
           end

         for(k=0;k<8;k=k+1)
           begin
             opcode = k ;
             if (k==0)  begin
               $display("\t\toperation    \t opcod  \t    inp1 \t             inp2 \t                     result") ;
               $display("\t\t---------    \t -----  \t    ---- \t             ---- \t                     ------") ;
               $monitor("\t\tsummation     \t %3b\t      %6d\t            %6d\t              %12d",opcode,$signed(inp1),$signed(inp2),$signed(result)) ;  end
             else if (k==1)
               $monitor("\t\tsubtraction   \t %3b\t      %6d\t            %6d\t              %12d",opcode,$signed(inp1),$signed(inp2),$signed(result)) ;
             else if (k==2)
               $monitor("\t\tmultiplication\t %3b\t      %6d\t            %6d\t                %12d",opcode,$signed(inp1),$signed(inp2),$signed(result)) ;
             else if(k==3)
               $monitor("\t\tdivision      \t %3b\t      %6d\t            %6d\t           %6d  , %6d  (remainder)",
               opcode,$signed(inp1),$signed(inp2),$signed(result[31:16]),$signed(result[15:0])) ;
             else if(k==4)
               $monitor("\t\tbitwise OR    \t %3b\t  %16b\t  %16b\t  %32b",opcode,inp1,inp2,result) ;
             else if(k==5)
               $monitor("\t\tbitwise AND   \t %3b\t  %16b\t  %16b\t  %32b",opcode,inp1,inp2,result) ;
             else if(k==6)
               $monitor("\t\tNOT inp1      \t %3b\t  %16b\t  %16b\t  %32b",opcode,inp1,inp2,result) ;
             else if(k==7)
               $monitor("\t\tNOT inp2      \t %3b\t  %16b\t  %16b\t  %32b",opcode,inp1,inp2,result) ;
             #100 ;
           end
         #100 ;
         $display("/t**********************************************************************************************************") ;
      end
   end
endmodule
