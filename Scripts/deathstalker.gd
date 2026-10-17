extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const TILE_SIZE = 96

var player_ref :CharacterBody2D


func _ready() -> void:
	atk_tail_frenzy()

func _physics_process(delta: float) -> void:
	pass

func atk_tail_frenzy():
	# 1. Cria o nó Line2D para desenhar o contorno
	var contorno = Line2D.new()
	
	if player_ref == null:
		print("Erro, referência do player não encontrada")
		return
	#print(player_ref.global_position)

	# 2. Configura a aparência da linha
	contorno.width = 2.0 # Espessura da borda
	contorno.default_color = Color(1.0, 1.0, 1.0) # Cor amarela (Aviso)
	contorno.joint_mode = Line2D.LINE_JOINT_SHARP # Deixa as quinas pontiagudas (quadradas)
	contorno.closed = true # Fecha a linha automaticamente do último ponto para o primeiro

	# 3. Define os pontos do quadrado em relação ao centro (0, 0)
	var tamanho = 3 * TILE_SIZE # O tamanho total do quadrado (120x120 pixels)
	var metade = tamanho / 2.0

	# Adicionando os 4 cantos do quadrado
	contorno.add_point(Vector2(-metade, -metade)) # Canto Superior Esquerdo
	contorno.add_point(Vector2(metade, -metade))  # Canto Superior Direito
	contorno.add_point(Vector2(metade, metade))   # Canto Inferior Direito
	contorno.add_point(Vector2(-metade, metade))  # Canto Inferior Esquerdo

	# 4. Posiciona o centro do quadrado exatamente onde o alvo (personagem) está
	contorno.position = Vector2(48,-48) 

	# 5. Adiciona o contorno à cena principal
	player_ref.add_child(contorno)
	# 6. (Opcional) Limpa da tela após um tempo
