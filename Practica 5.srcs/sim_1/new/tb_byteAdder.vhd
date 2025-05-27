library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_byteAdder is 
end tb_byteAdder;

architecture Testbench of tb_byteAdder is
	--Inputs
	signal A 	: std_logic_vector (7 downto 0) := (others => '0'); 
	signal B 	: std_logic_vector (7 downto 0) := (others => '0');
	--Outputs
	signal S 	: std_logic_vector (7 downto 0) ;
	signal C_out: std_logic ;
	--Constants
	constant delay : time := 10 ns; 
	component byteAdder is
		port( 	A		: in 	std_logic_vector (7 downto 0);
				B		: in 	std_logic_vector (7 downto 0);
				S		: out 	std_logic_vector (7 downto 0);
				C_out	: out 	std_logic
	);
	end component;
begin
	UUT: component byteAdder
	port map(
		A		=> A,		
	    B		=> B,
	    S	    => S,
	    C_out   => C_out
	);
	
	stimulus: process
begin
    
    wait for delay;
    A <= std_logic_vector(to_unsigned(0, A'length));
    B <= std_logic_vector(to_unsigned(0, B'length));
    assert (S = std_logic_vector(to_unsigned(0, S'length))) 
      report "Sum not 0 for A = 0 B = 0" 
      severity error;
    assert(C_out  = '0')
      report "Carry Out not 0 for A = 0 B = 0" 
      severity error;

    wait for delay;
    A <= std_logic_vector(to_unsigned(10, A'length));
    B <= std_logic_vector(to_unsigned(12, B'length));
    assert (S = std_logic_vector(to_unsigned(22, S'length))) 
      report "Sum not 22 for A = 10 B = 12" 
      severity error;
    assert(C_out = '0')
      report "Carry Out not 0 for A = 10 B = 12"
      severity error;

    wait for delay;
    A <= std_logic_vector(to_unsigned(244, A'length));
    B <= std_logic_vector(to_unsigned(180, B'length));
    assert (S = std_logic_vector(to_unsigned(168, S'length))) 
      report "Sum not 168 for A = 244 B = 180" 
      severity error;
    assert(C_out = '1')
      report "Carry Out not 1 for A = 244 B = 180"
      severity error;

    wait for delay;
    A <= std_logic_vector(to_unsigned(1, A'length));
    B <= std_logic_vector(to_unsigned(1, B'length));
    assert (S = std_logic_vector(to_unsigned(2, S'length))) 
      report "Sum not 2 for A = 1 B = 1" 
      severity error;
    assert(C_out = '0')
      report "Carry Out not 0 for A = 1 B = 1"
      severity error;
      
    wait for delay;
    A <= std_logic_vector(to_unsigned(0, A'length));
    B <= std_logic_vector(to_unsigned(0, B'length));
    assert (S = std_logic_vector(to_unsigned(0, S'length))) 
      report "Sum not 0 for A = 0 B = 0" 
      severity error;
    assert(C_out  = '0')
      report "Carry Out not 0 for A = 0 B = 0" 
      severity error;
      
    wait for delay;
    assert false
      report "Simulation finished"
      severity failure;
end process;
end Testbench;