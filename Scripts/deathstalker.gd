extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const TILE_SIZE = 96
const CENA_DANO_TF = preload("res://Cenas/areadanotailfrenzy.tscn")

@export var colisao_ds :CollisionShape2D
var player_ref :CharacterBody2D
var acertou_player = false

func _ready() -> void:
	atk_tail_frenzy()

#func _physics_process(delta: float) -> void:
#	pass

func atk_tail_frenzy():
	#var max_tail_count = 21
	var tail_count = 0
	var contorno = Line2D.new()
	var distancia_origem_atk = 1 * TILE_SIZE
	var direcoes_atk = [
		Vector2(0,-1),
		Vector2(0,1),
		Vector2(1,0),
		Vector2(-1,0)
	]

	if player_ref == null:
		print("Erro, referência do player não encontrada")
		return
	
	print("Começou")


	#region contorno quadrado
	# 2. configuraçãp da aparência do contorno
	contorno.width = 2.0 # Espessura da borda
	contorno.default_color = Color(1.0, 1.0, 1.0) # Cor amarela (Aviso)
	contorno.joint_mode = Line2D.LINE_JOINT_SHARP # Deixa as quinas pontiagudas (quadradas)
	contorno.closed = true # Fecha a linha automaticamente do último ponto para o primeiro

	# 3. Define os pontos do quadrado em relação ao centro (0, 0)
	var tamanho = 3 * TILE_SIZE # O tamanho total do quadrado 
	var metade = tamanho / 2.0

	# Adicionando os 4 cantos do quadrado
	contorno.add_point(Vector2(-metade, -metade)) # Canto Superior Esquerdo
	contorno.add_point(Vector2(metade, -metade))  # Canto Superior Direito
	contorno.add_point(Vector2(metade, metade))   # Canto Inferior Direito
	contorno.add_point(Vector2(-metade, metade))  # Canto Inferior Esquerdo

	# 4. Posiciona o centro do quadrado exatamente onde o alvo está
	contorno.position = Vector2(48,-48) 

	# 5. Adiciona o contorno à cena principal
	player_ref.add_child(contorno)
	#endregion

	#region timer 5 segundos
	var tempo_restante = 5
	var tweenopacidade = get_tree().create_tween()
	
	# Anima a propriedade "modulate:a" até chegar em 0.0 ao longo de 2 segundos
	tweenopacidade.tween_property(self, "modulate:a", 0.0, 5.0)
	# O loop vai rodar enquanto o tempo for maior que 0
	while tempo_restante > 0:
		
		get_tree().call_group("hud_timer", "atualizar_texto_contador", str(tempo_restante))
		# 2. Chama a função que precisa acontecer a cada segundo
		#afundar()
		# 3. Pausa esse bloco de código por exatamente 1 segundo
		await get_tree().create_timer(1.0).timeout
		# 4. Diminui o tempo restante para a próxima volta do loop
		tempo_restante -= 1
		
	# ==========================================
	# QUANDO O LOOP TERMINA, OS 5 SEGUNDOS PASSARAM
	# ==========================================

	# Atualiza a tela (pode colocar "0", um texto, ou esconder o Label)
	get_tree().call_group("hud_timer", "sumir")
	#endregion
	
	set_collision_layer_value(1,false)
	while tail_count != 21:
		tail_count += 1

		#region area de alerta do ataque
		# cria a area de alerta
		var pos_origem_sorteada = direcoes_atk.pick_random()
		var capsula = ProgressBar.new()
		
		capsula.show_percentage = false # Esconde o texto "0%"
		capsula.fill_mode = ProgressBar.FILL_BOTTOM_TO_TOP # Faz encher de baixo para cima

		# define o tamanho da cápsula
		var largura = 0.5 * TILE_SIZE
		var altura = 2 * TILE_SIZE
		capsula.size = Vector2(largura, altura)

		# o arredondamento (corner_radius) deve ser sempre metade da largura
		var raio = largura / 2.0 

		# cria o estilo do CONTORNO (Fundo)
		var estilo_contorno = StyleBoxFlat.new()
		estilo_contorno.bg_color = Color(0.4, 0, 0.4, 0.5) # Fundo transparente
		estilo_contorno.border_color = Color(0.4, 0, 0.4,0.8) # Cor do contorno (Branco)
		estilo_contorno.border_width_left = 4
		estilo_contorno.border_width_right = 4
		estilo_contorno.border_width_top = 4
		estilo_contorno.border_width_bottom = 4
		# arredonda as 4 pontas para formar a cápsula
		estilo_contorno.corner_radius_top_left = raio
		estilo_contorno.corner_radius_top_right = raio
		estilo_contorno.corner_radius_bottom_left = raio
		estilo_contorno.corner_radius_bottom_right = raio

		# aplica o estilo de contorno
		capsula.add_theme_stylebox_override("background", estilo_contorno)

		# cria o estilo do PREENCHIMENTO
		var estilo_preenchimento = StyleBoxFlat.new()
		estilo_preenchimento.bg_color = Color(0.8, 0, 0.8, 0.8) # Cor de preenchimento (Vermelho)
		# copia o arredondamento para o preenchimento encaixar perfeitamente no formato
		estilo_preenchimento.corner_radius_top_left = raio
		estilo_preenchimento.corner_radius_top_right = raio
		estilo_preenchimento.corner_radius_bottom_left = raio
		estilo_preenchimento.corner_radius_bottom_right = raio

		# aplica o estilo do preenchimento
		capsula.add_theme_stylebox_override("fill", estilo_preenchimento)

		# adiciona e centraliza no alvo (seguindo o personagem)
		get_tree().current_scene.add_child(capsula)
		var posicao_alvo_deslocada = player_ref.global_position + (pos_origem_sorteada * distancia_origem_atk)
		
		
		#region rotação capsula
		# 1. Define o centro da cápsula como o eixo de rotação
		capsula.pivot_offset = Vector2(largura / 2.0, altura / 2.0)
		# 2. Rotaciona dependendo da direção.
		# Os ângulos abaixo garantem não só que ela fique deitada ou em pé,
		# mas que o "preenchimento" vá sempre em direção ao personagem.
		if pos_origem_sorteada == Vector2(0, -1): # Norte
			capsula.global_position = posicao_alvo_deslocada - Vector2(largura / 2.0 - 48, altura / 2.0)
			capsula.rotation_degrees = 180
		elif pos_origem_sorteada == Vector2(0, 1):  # Sul
			capsula.global_position = posicao_alvo_deslocada - Vector2(largura / 2.0 - 48, altura / 2.0 + 96)
			capsula.rotation_degrees = 0
		elif pos_origem_sorteada == Vector2(1, 0):  # Leste
			capsula.global_position = posicao_alvo_deslocada - Vector2(largura / 2.0, altura / 2.0 + 48)
			capsula.rotation_degrees = -90 # Deita e enche para a esquerda
		elif pos_origem_sorteada == Vector2(-1, 0): # Oeste
			capsula.global_position = posicao_alvo_deslocada - Vector2(largura / 2.0 - 96, altura / 2.0 + 48)
			capsula.rotation_degrees = 90  # Deita e enche para a direita
		#endregion

		# 6. Anima o preenchimento usando um Tween
		capsula.min_value = 0
		capsula.max_value = 100
		capsula.value = 0

		# Cria uma animação suave que vai de 0 a 100 em 1 segundos
		var tween = get_tree().create_tween()
		tween.tween_property(capsula, "value", 100.0, 0.6)

		# Assim que a animação terminar (cápsula cheia), deleta ela da cena
		
		tween.tween_callback(capsula.queue_free)
		#endregion

		await tween.finished

		#region aplicação do hit
		# 1. Instancia a cena do Area2D
		var area_dano = CENA_DANO_TF.instantiate()

		# 2. Define a posição
		# Usamos direto a posição central calculada antes.
		if pos_origem_sorteada.y == -1: # norte cima
			area_dano.global_position = posicao_alvo_deslocada + Vector2(48,0)
		elif pos_origem_sorteada.y == 1: # sul baixo
			area_dano.global_position = posicao_alvo_deslocada + Vector2(48,-96)
		elif pos_origem_sorteada.x == 1: #leste direita
			area_dano.global_position = posicao_alvo_deslocada + Vector2(0,-48)
		elif pos_origem_sorteada.x == -1: #oeste esquerda
			area_dano.global_position = posicao_alvo_deslocada + Vector2(96,-48)
		else:
			area_dano.global_position = posicao_alvo_deslocada 

		# 3. Copia a rotação exata da cápsula visual antes dela ser deletada
		area_dano.rotation = capsula.rotation

		# 4. Adiciona o Area2D à cena
		get_tree().current_scene.add_child(area_dano)
		
		area_dano.body_entered.connect(acertou_jogador)

		# 5. Faz a área de dano após 0.2 segundos
		get_tree().create_timer(0.2).timeout.connect(func():
			if acertou_player == false:
				errou_jogador(player_ref)
			area_dano.queue_free())
		
		acertou_player = false
		#endregion

		print("Avisos: ", tail_count)

	# limpa o contorno da tela quando acabam os ataques
	player_ref.remove_child(contorno)


func afundar():
	self.scale -= Vector2(0.2,0.2)

func errou_jogador(body:Node2D):
	if body.has_method("esquiva"):
		body.esquiva()

func acertou_jogador(body :Node2D):
	acertou_player = true
	if body.has_method("tomar_hit"):
		body.tomar_hit()
		print("hits tomados: ",player_ref.hits_tomados)
