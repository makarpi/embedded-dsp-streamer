	component INC_CTRL is
		port (
			probe : in std_logic_vector(31 downto 0) := (others => 'X')  -- probe
		);
	end component INC_CTRL;

	u0 : component INC_CTRL
		port map (
			probe => CONNECTED_TO_probe  -- probes.probe
		);

