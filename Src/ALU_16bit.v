           			/***  ARITHMETIC LOGIC UNIT (ALU)  ***/

module ALU_OPERATOR (            
input [15:0] inp1, inp2,
input [2:0] opcode ,
output reg [31:0]result 
);
wire [15:0] inp1_minus,inp2_minus ;
assign inp1_minus = -inp1 ;
assign inp2_minus = -inp2 ;

always @(inp1,inp2,opcode)
  begin 
    result = 32'bx ;     //default value

    case(opcode)
      3'b000 :                                       //summation operation case
        begin 
          result[15:0] = inp1 + inp2  ;
          if(inp1[15] && inp2[15])
            result[31:16] = 16'b1111111111111111 ;
          else if(!inp1[15] && !inp2[15])
            result[31:16] = 16'b0000000000000000 ;
          else if(!inp1[15] && inp2[15] || inp1[15] && !inp2[15])
            case(result[15])
              1'b0 : result[31:16] = 16'b0000000000000000 ;
              1'b1 : result[31:16] = 16'b1111111111111111 ;
            endcase
          else result = 'bx ;
        end

      3'b001 :                                     //subtraction operation case 
        begin 
          result[15:0] = inp1 - inp2  ;
          if(inp1[15] && !inp2[15])
            result[31:16] = 16'b1111111111111111 ;
          else if(!inp1[15] && inp2[15])
            result[31:16] = 16'b0000000000000000 ;
          else if(!inp1[15] && !inp2[15] || inp1[15] && inp2[15])
            case(result[15])
              1'b0 : result[31:16] = 16'b0000000000000000 ;
              1'b1 : result[31:16] = 16'b1111111111111111 ;
            endcase
          else
            result = 'bx ;
        end

      3'b010 :                                     //multiplication operation case
        begin
          if(!inp1[15] && !inp2[15])
            result = inp1[14:0] * inp2[14:0] ;
          else if(inp1[15] && inp2[15])
            result = inp1_minus[14:0] * inp2_minus[14:0] ;
          else if(!inp1[15] && inp2[15])
            result = -(inp1[14:0] * inp2_minus[14:0]) ;
          else if(inp1[15] && !inp2[15])
            result = -(inp1_minus[14:0] * inp2[14:0]) ;
          else
            result = 32'bx ;   
        end

      3'b011 :                                     //division operation case 
        begin
          if(!inp1[15] && !inp2[15])
            begin
              result[31:16] = inp1[14:0] / inp2[14:0] ;
              result[15:0]  = inp1[14:0] % inp2[14:0] ;
            end
          else if(inp1[15] && inp2[15])
            begin
              result[31:16] = inp1_minus[14:0] / inp2_minus[14:0] ;
              result[15:0]  = -(inp1_minus[14:0] % inp2_minus[14:0]) ;
            end
          else if(!inp1[15] && inp2[15])
            begin
              result[31:16] = -(inp1[14:0] / inp2_minus[14:0]) ;
              result[15:0] = inp1[14:0] % inp2_minus[14:0] ;
            end
          else if(inp1[15] && !inp2[15])
            begin
              result[31:16] = -(inp1_minus[14:0] / inp2[14:0]) ;
              result[15:0] = -(inp1_minus[14:0] % inp2[14:0]) ;
            end
          else                                
            result = 32'bx ;  
        end

      3'b100 : result[15:0] = inp1 | inp2 ;         // bitwise ORING operation case
      3'b101 : result[15:0] = inp1 & inp2 ;         // bitwise ANDING operation case
      3'b110 : result[15:0] = ~ inp1 ;              // NOT inp1 operation case
      3'b111 : result[15:0] = ~ inp2 ;              // NOT inp2 operation case
      default : result = 32'bx ;              // default value of result
    endcase
  end
endmodule
