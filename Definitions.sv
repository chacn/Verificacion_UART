package Definitions;
/*Log Function*/
    function integer CeilLog2;
      input integer data;
      integer i,result;
      begin
         for(i=0; 2**i < data; i=i+1)
            result = i + 1;
         CeilLog2 = result;
      end
   endfunction

 endpackage
