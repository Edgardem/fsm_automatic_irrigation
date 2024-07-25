module RegaAutomatica (
	input reset, 
	input clk, 
	input B_Adb,
	input [1:0] REGA_Mode,
	output Ve, 
	output ERRO, 
	output Gotejamento,
	output Aspersao,
	output Mist_Adb,
	output [6:0] linhas_Matriz,
	output [4:0] Colunas_Matriz,
	output [7:0] Segs,
	output [3:0] D_Segs
	);

	// Declaração dos fios intermediários
	wire slow_clk, medium_clk, fast_clk, Adubou; 
	wire Parada_Rega, Vazio, Limpeza, Ctrl_clk;
	wire [2:0] nivel;
	wire start_fill;
	wire Nivel_cheio, state;


	// Modulo divisor de frequencia responsavel pelo nivel da agua.
	DivisorClock div_clk (
		.clock(clk),
		.slow_clk(slow_clk),
		.medium_clk(medium_clk),
		.fast_clk(fast_clk)
	);

	// Mef de Controle do nível da água
	FILL controle_encher (
		.Vazio(Vazio),
		.Nivel_cheio(Nivel_cheio),
		.clk(clk),
		.reset(reset),
		.state(state)
	);
	
	// Contador do nível da água
	ContadorNivelAgua contador_nivel (
		.reset(reset),
		.Ctrl_clk(Ctrl_clk),
		.state(state),
		.nivel(nivel)
	);

	// Controle de frequência
	ControleFrequencia controle_freq (
		.fast_clk(fast_clk),
		.medium_clk(medium_clk),
		.slow_clk(slow_clk),
		.start_fill(start_fill),
		.Aspersao(Aspersao),
		.Gotejamento(Gotejamento),
		.Limpeza(Limpeza),
		.ERRO(ERRO),
		.state(state),
		.Ctrl_clk(Ctrl_clk)
	);

	// Controle de rega
	ControleRega controle_rega (
		.REGA_Mode(REGA_Mode),
		.Esvaziar(!state),
		.Parada_Rega(Parada_Rega),
		.Nivel_cheio(Nivel_cheio),
		.Limpeza(Limpeza),
		.Aspersao(Aspersao),
		.Gotejamento(Gotejamento),
		.ERRO(ERRO)
	);

	// Controle de adubação
	ControleAdubacao controle_adub (
		.Adubou(Adubou),
		.nivel(nivel),
		.Parada_Rega(Parada_Rega),
		.Limpeza(Limpeza),
		.Vazio(Vazio)
	);

	// MEF de Adubacao
	FERTILIZING fertilizing (
		.Vazio((nivel == 3'b000)),
		.Aspersao(Aspersao),
		.B_Adb(B_Adb),
		.clk(clk),
		.reset(reset),
		.Mist_Adb(Mist_Adb),
		.Adubou(Adubou)
	);

	// Controlador da Matriz
	ControladorMatriz matriz_controlador (
		.nivel(nivel),
		.linhas_Matriz(linhas_Matriz)
	);

	// Controlador do display
	ControladorDisplay display_control (
		.ERRO(ERRO),
		.Aspersao(Aspersao),
		.Gotejamento(Gotejamento),
		.Limpeza(Limpeza),
		.Segs(Segs[6:0])
	);

	// Controlador de início de enchimento baseado no estado de reset e nível da água
	assign start_fill = !Nivel_cheio;
	assign Nivel_cheio = (nivel == 3'b111);
	assign Ve = start_fill && state;
	assign Colunas_Matriz = 5'b11111;
	assign D_Segs = 4'b0111;
	assign Segs[7] = 1'b0;	

endmodule