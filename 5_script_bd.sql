CREATE TABLE t_pmc_categoria_produto (
    cd_categoria INTEGER NOT NULL,
    dt_inicio    DATE NOT NULL,
    dt_fim       DATE,
    st_categoria CHAR(1) NOT NULL,
    ds_categoria VARCHAR2(200) NOT NULL
);

COMMENT ON COLUMN t_pmc_categoria_produto.cd_categoria IS
    'Código da categoria';

COMMENT ON COLUMN t_pmc_categoria_produto.dt_inicio IS
    'Data início da categoria';

COMMENT ON COLUMN t_pmc_categoria_produto.dt_fim IS
    'Data do fim da categoria';

COMMENT ON COLUMN t_pmc_categoria_produto.st_categoria IS
    'Status da categoria: A - Ativo, I - Inativo';

COMMENT ON COLUMN t_pmc_categoria_produto.ds_categoria IS
    'Descrição da categoria';

ALTER TABLE t_pmc_categoria_produto
    ADD CONSTRAINT ck_cat_prod_st_categoria CHECK ( st_categoria IN ( 'A', 'I' ) );

ALTER TABLE t_pmc_categoria_produto ADD CONSTRAINT pk_categoria_produto PRIMARY KEY ( cd_categoria );

ALTER TABLE t_pmc_categoria_produto ADD CONSTRAINT un_pmc_cat_prod_ds_categoria UNIQUE ( ds_categoria );

CREATE TABLE t_pmc_categoria_video (
    cd_categoria INTEGER NOT NULL,
    ds_categoria VARCHAR2(200) NOT NULL
);

COMMENT ON COLUMN t_pmc_categoria_video.cd_categoria IS
    'Código da categoria do vídeo';

COMMENT ON COLUMN t_pmc_categoria_video.ds_categoria IS
    'Descrição da categoria do vídeo';

ALTER TABLE t_pmc_categoria_video ADD CONSTRAINT pk_pmc_categoria_video PRIMARY KEY ( cd_categoria );

ALTER TABLE t_pmc_categoria_video ADD CONSTRAINT un_pmc_cat_video_ds_cat UNIQUE ( ds_categoria );

CREATE TABLE t_pmc_chamados (
    cd_chamado     NUMBER(10) NOT NULL,
    cd_cliente     INTEGER NOT NULL,
    cd_funcionario INTEGER NOT NULL,
    cd_produto     INTEGER NOT NULL,
    dt_abertura    DATE NOT NULL,
    dt_atendimento DATE,
    dt_conclusao   DATE,
    hr_atendimento NUMBER(6),
    st_chamado     CHAR(1) NOT NULL,
    in_satisfacao  NUMBER(2),
    tp_chamado     NUMBER(1) NOT NULL,
    tx_chamado     VARCHAR2(4000) NOT NULL
);

COMMENT ON COLUMN t_pmc_chamados.cd_chamado IS
    'Código do chamado';

COMMENT ON COLUMN t_pmc_chamados.cd_cliente IS
    'Código do cliente';

COMMENT ON COLUMN t_pmc_chamados.cd_funcionario IS
    'Código do funcionÃ¡rio';

COMMENT ON COLUMN t_pmc_chamados.cd_produto IS
    'Código do produto';

COMMENT ON COLUMN t_pmc_chamados.dt_abertura IS
    'Data e hora de abertura do chamado';

COMMENT ON COLUMN t_pmc_chamados.dt_atendimento IS
    'Data e hora do atendimento';

COMMENT ON COLUMN t_pmc_chamados.dt_conclusao IS
    'Data e hora de conclusão do chamado';

COMMENT ON COLUMN t_pmc_chamados.hr_atendimento IS
    'Tempo (em horas) de atendimento';

COMMENT ON COLUMN t_pmc_chamados.st_chamado IS
    'Status do chamado: A - Aberto, E - Em atendimento, C - Cancelado, F - Fechado com sucesso, X - Fechado com insatisfação do cliente';

COMMENT ON COLUMN t_pmc_chamados.in_satisfacao IS
    'Índice de satisfação do cliente';

COMMENT ON COLUMN t_pmc_chamados.tp_chamado IS
    'Tipo do chamado: 1 - Sugestão, 2 - Reclamação';

COMMENT ON COLUMN t_pmc_chamados.tx_chamado IS
    'Texto de descrição do chamado feito pelo cliente';

ALTER TABLE t_pmc_chamados
    ADD CONSTRAINT ck_pmc_chamados_st_chamado CHECK ( st_chamado IN ( 'A', 'E', 'C', 'F', 'X' ) );

ALTER TABLE t_pmc_chamados
    ADD CONSTRAINT ck_pmc_chamados_tp_chamado CHECK ( tp_chamado IN ( 1, 2 ) );

ALTER TABLE t_pmc_chamados ADD CONSTRAINT pk_pmc_chamados PRIMARY KEY ( cd_chamado );

CREATE TABLE t_pmc_cliente (
    cd_cliente  INTEGER NOT NULL,
    dt_cadastro DATE NOT NULL,
    nm_cliente  VARCHAR2(200) NOT NULL,
    qt_estrelas INTEGER,
    st_cliente  CHAR(1) NOT NULL,
    nr_tel      VARCHAR2(11) NOT NULL,
    nm_login    VARCHAR2(50) NOT NULL,
    vl_senha    VARCHAR2(50) NOT NULL,
    tp_cliente  CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_pmc_cliente.cd_cliente IS
    'Código do cliente';

COMMENT ON COLUMN t_pmc_cliente.dt_cadastro IS
    'Data de cadastro';

COMMENT ON COLUMN t_pmc_cliente.nm_cliente IS
    'Nome do cliente';

COMMENT ON COLUMN t_pmc_cliente.qt_estrelas IS
    'Quantidade de estrelas: Entre 1 e 5';

COMMENT ON COLUMN t_pmc_cliente.st_cliente IS
    'Status do cliente: A - Ativo, I - Inativo';

COMMENT ON COLUMN t_pmc_cliente.nr_tel IS
    'Número do telefone';

COMMENT ON COLUMN t_pmc_cliente.nm_login IS
    'Login do cliente';

COMMENT ON COLUMN t_pmc_cliente.vl_senha IS
    'Senha do usuário';

COMMENT ON COLUMN t_pmc_cliente.tp_cliente IS
    'Tipo de cliente: F - Pessoa física, J - Pessoa jurídica';

ALTER TABLE t_pmc_cliente
    ADD CONSTRAINT ck_pmc_cliente_st_cliente CHECK ( st_cliente IN ( 'A', 'I' ) );

ALTER TABLE t_pmc_cliente
    ADD CONSTRAINT ck_pmc_cliente_tp_cliente CHECK ( tp_cliente IN ( 'F', 'J' ) );

ALTER TABLE t_pmc_cliente ADD CONSTRAINT pk_pmc_cliente PRIMARY KEY ( cd_cliente );

CREATE TABLE t_pmc_cliente_fisico (
    cd_cliente    INTEGER NOT NULL,
    nr_cpf        VARCHAR2(11) NOT NULL,
    dt_nascimento DATE NOT NULL,
    sx_biologico  VARCHAR2(10) NOT NULL,
    gn_nascimento VARCHAR2(10)
);

COMMENT ON COLUMN t_pmc_cliente_fisico.cd_cliente IS
    'Código do cliente';

COMMENT ON COLUMN t_pmc_cliente_fisico.nr_cpf IS
    'Número do CPF do cliente';

COMMENT ON COLUMN t_pmc_cliente_fisico.dt_nascimento IS
    'Data de nascimento do cliente';

COMMENT ON COLUMN t_pmc_cliente_fisico.sx_biologico IS
    'Sexo biológico';

COMMENT ON COLUMN t_pmc_cliente_fisico.gn_nascimento IS
    'Gênero nascimento';

ALTER TABLE t_pmc_cliente_fisico ADD CONSTRAINT pk_pmc_cliente_fisico PRIMARY KEY ( cd_cliente );

ALTER TABLE t_pmc_cliente_fisico ADD CONSTRAINT un_pmc_pf_nr_cpf UNIQUE ( nr_cpf );

CREATE TABLE t_pmc_cliente_juridico (
    cd_cliente   INTEGER NOT NULL,
    dt_fundacao  DATE,
    nr_cnpj      VARCHAR2(14),
    nr_inscricao VARCHAR2(9)
);

COMMENT ON COLUMN t_pmc_cliente_juridico.cd_cliente IS
    'Código do cliente';

COMMENT ON COLUMN t_pmc_cliente_juridico.dt_fundacao IS
    'Data de fundação da empresa';

COMMENT ON COLUMN t_pmc_cliente_juridico.nr_cnpj IS
    'Número do CNPJ da empresa';

COMMENT ON COLUMN t_pmc_cliente_juridico.nr_inscricao IS
    'Número de inscrição estadual';

ALTER TABLE t_pmc_cliente_juridico ADD CONSTRAINT pk_pmc_cliente_juridico PRIMARY KEY ( cd_cliente );

ALTER TABLE t_pmc_cliente_juridico ADD CONSTRAINT un_pmc_pj_nr_cnpj UNIQUE ( nr_cnpj );

ALTER TABLE t_pmc_cliente_juridico ADD CONSTRAINT un_pmc_pj_nr_inscricao UNIQUE ( nr_inscricao );

CREATE TABLE t_pmc_departamento (
    cd_departamento INTEGER NOT NULL,
    nm_departamento VARCHAR2(200) NOT NULL
);

COMMENT ON COLUMN t_pmc_departamento.cd_departamento IS
    'Código do departamento';

COMMENT ON COLUMN t_pmc_departamento.nm_departamento IS
    'Nome do departamento';

ALTER TABLE t_pmc_departamento ADD CONSTRAINT pk_pmc_departamento PRIMARY KEY ( cd_departamento );

CREATE TABLE t_pmc_funcionario (
    cd_funcionario  INTEGER NOT NULL,
    cd_departamento INTEGER NOT NULL,
    nm_funcionario  VARCHAR2(200) NOT NULL,
    nr_cpf          VARCHAR2(11) NOT NULL,
    dt_nascimento   DATE NOT NULL,
    nr_telefone     VARCHAR2(11) NOT NULL,
    vl_email        VARCHAR2(200) NOT NULL,
    nm_cargo        VARCHAR2(200) NOT NULL
);

COMMENT ON COLUMN t_pmc_funcionario.cd_funcionario IS
    'Código do funcionário';

COMMENT ON COLUMN t_pmc_funcionario.nm_funcionario IS
    'Nome do funcionário';

COMMENT ON COLUMN t_pmc_funcionario.nr_cpf IS
    'Número de CPF do funcionário';

COMMENT ON COLUMN t_pmc_funcionario.dt_nascimento IS
    'Data de nascimento do funcionário';

COMMENT ON COLUMN t_pmc_funcionario.nr_telefone IS
    'Número de telefone do funcionário';

COMMENT ON COLUMN t_pmc_funcionario.vl_email IS
    'E-mail do funcionário';

COMMENT ON COLUMN t_pmc_funcionario.nm_cargo IS
    'Nome do cargo do funcionário';

ALTER TABLE t_pmc_funcionario ADD CONSTRAINT pk_pmc_funcionario PRIMARY KEY ( cd_funcionario );

ALTER TABLE t_pmc_funcionario ADD CONSTRAINT un_pmc_funcionario_nr_cpf UNIQUE ( nr_cpf );

CREATE TABLE t_pmc_pedido_compra (
    cd_pedido  INTEGER NOT NULL,
    cd_cliente INTEGER NOT NULL,
    dt_pedido  DATE,
    vl_total   NUMBER(10, 2),
    st_pedido  CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_pmc_pedido_compra.cd_pedido IS
    'Código do pedido';

COMMENT ON COLUMN t_pmc_pedido_compra.cd_cliente IS
    'Código do cliente';

COMMENT ON COLUMN t_pmc_pedido_compra.dt_pedido IS
    'Data e hora do pedido';

COMMENT ON COLUMN t_pmc_pedido_compra.vl_total IS
    'Valor total do pedido';

COMMENT ON COLUMN t_pmc_pedido_compra.st_pedido IS
    'Status do pedido: A - Aberto, P - Processando, F - Finalizado, C - Cancelado';

ALTER TABLE t_pmc_pedido_compra
    ADD CONSTRAINT ck_pmc_pedido_compra_st_pedido CHECK ( st_pedido IN ( 'A', 'P', 'F', 'C' ) );

ALTER TABLE t_pmc_pedido_compra ADD CONSTRAINT pk_pmc_pedido_compra PRIMARY KEY ( cd_pedido );

CREATE TABLE t_pmc_produto (
    cd_produto   INTEGER NOT NULL,
    cd_categoria INTEGER NOT NULL,
    nm_produto   VARCHAR2(200) NOT NULL,
    ds_produto   VARCHAR2(200) NOT NULL,
    cd_barra     VARCHAR2(13),
    vl_unitario  NUMBER(5, 2) NOT NULL,
    st_produto   CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_pmc_produto.cd_produto IS
    'Código do produto';

COMMENT ON COLUMN t_pmc_produto.cd_categoria IS
    'Código da categoria';

COMMENT ON COLUMN t_pmc_produto.nm_produto IS
    'Nome do produto';

COMMENT ON COLUMN t_pmc_produto.ds_produto IS
    'Descrição do produto';

COMMENT ON COLUMN t_pmc_produto.cd_barra IS
    'Número do código de barra';

COMMENT ON COLUMN t_pmc_produto.vl_unitario IS
    'Valor do preço por unidade';

COMMENT ON COLUMN t_pmc_produto.st_produto IS
    'Status do produto: A - Ativo, I - Inativo, P - Prospecção';

ALTER TABLE t_pmc_produto
    ADD CONSTRAINT ck_t_pmc_produto_st_produto CHECK ( st_produto IN ( 'A', 'I', 'P' ) );

ALTER TABLE t_pmc_produto ADD CONSTRAINT pk_pmc_produto PRIMARY KEY ( cd_produto );

ALTER TABLE t_pmc_produto ADD CONSTRAINT un_pmc_produto_nm_produto UNIQUE ( nm_produto );

CREATE TABLE t_pmc_produtos_pedido_compra (
    cd_produto INTEGER NOT NULL,
    cd_pedido  INTEGER NOT NULL,
    qt_produto NUMBER(6) NOT NULL
);

COMMENT ON COLUMN t_pmc_produtos_pedido_compra.cd_produto IS
    'Código do produto';

COMMENT ON COLUMN t_pmc_produtos_pedido_compra.qt_produto IS
    'Quantidade do produto no pedido';

ALTER TABLE t_pmc_produtos_pedido_compra ADD CONSTRAINT pk_pmc_produtos_pedido_compra PRIMARY KEY ( cd_produto,
                                                                                                    cd_pedido );

CREATE TABLE t_pmc_video_produto (
    cd_video     INTEGER NOT NULL,
    cd_produto   INTEGER NOT NULL,
    cd_categoria INTEGER NOT NULL,
    dt_cadastro  DATE NOT NULL,
    st_video     CHAR(1) NOT NULL
);

COMMENT ON COLUMN t_pmc_video_produto.cd_video IS
    'Código do vídeo do produto';

COMMENT ON COLUMN t_pmc_video_produto.cd_produto IS
    'Código do produto';

COMMENT ON COLUMN t_pmc_video_produto.cd_categoria IS
    'Código da classificação';

COMMENT ON COLUMN t_pmc_video_produto.dt_cadastro IS
    'Data de cadastro do produto';

COMMENT ON COLUMN t_pmc_video_produto.st_video IS
    'Status de vídeo do produto: A - Ativo, I - Inativo';

ALTER TABLE t_pmc_video_produto
    ADD CONSTRAINT ck_pmc_video_prod_st_video CHECK ( st_video IN ( 'A', 'I' ) );

ALTER TABLE t_pmc_video_produto ADD CONSTRAINT pk_pmc_video_produto PRIMARY KEY ( cd_video );

CREATE TABLE t_pmc_visualizacao_video (
    cd_visualizacao INTEGER NOT NULL,
    cd_video        INTEGER NOT NULL,
    cd_cliente      INTEGER,
    dt_visualizacao DATE NOT NULL
);

COMMENT ON COLUMN t_pmc_visualizacao_video.cd_visualizacao IS
    'Código da visualização do vídeo';

COMMENT ON COLUMN t_pmc_visualizacao_video.dt_visualizacao IS
    'Data e hora da visualização';

ALTER TABLE t_pmc_visualizacao_video ADD CONSTRAINT pk_pmc_visualizacao_video PRIMARY KEY ( cd_visualizacao );

ALTER TABLE t_pmc_produto
    ADD CONSTRAINT fk_pmc_categoria_produto FOREIGN KEY ( cd_categoria )
        REFERENCES t_pmc_categoria_produto ( cd_categoria );

ALTER TABLE t_pmc_video_produto
    ADD CONSTRAINT fk_pmc_categoria_video FOREIGN KEY ( cd_categoria )
        REFERENCES t_pmc_categoria_video ( cd_categoria );

ALTER TABLE t_pmc_chamados
    ADD CONSTRAINT fk_pmc_cliente FOREIGN KEY ( cd_cliente )
        REFERENCES t_pmc_cliente ( cd_cliente );

ALTER TABLE t_pmc_cliente_fisico
    ADD CONSTRAINT fk_pmc_clte_fisico_cliente FOREIGN KEY ( cd_cliente )
        REFERENCES t_pmc_cliente ( cd_cliente );

ALTER TABLE t_pmc_cliente_juridico
    ADD CONSTRAINT fk_pmc_clte_juridico_cliente FOREIGN KEY ( cd_cliente )
        REFERENCES t_pmc_cliente ( cd_cliente );

ALTER TABLE t_pmc_funcionario
    ADD CONSTRAINT fk_pmc_departamento FOREIGN KEY ( cd_departamento )
        REFERENCES t_pmc_departamento ( cd_departamento );

ALTER TABLE t_pmc_chamados
    ADD CONSTRAINT fk_pmc_funcionario FOREIGN KEY ( cd_funcionario )
        REFERENCES t_pmc_funcionario ( cd_funcionario );

ALTER TABLE t_pmc_produtos_pedido_compra
    ADD CONSTRAINT fk_pmc_pedido_compra FOREIGN KEY ( cd_pedido )
        REFERENCES t_pmc_pedido_compra ( cd_pedido );

ALTER TABLE t_pmc_pedido_compra
    ADD CONSTRAINT fk_pmc_pedido_compra_cliente FOREIGN KEY ( cd_cliente )
        REFERENCES t_pmc_cliente ( cd_cliente );

ALTER TABLE t_pmc_chamados
    ADD CONSTRAINT fk_pmc_produto FOREIGN KEY ( cd_produto )
        REFERENCES t_pmc_produto ( cd_produto );

ALTER TABLE t_pmc_produtos_pedido_compra
    ADD CONSTRAINT fk_pmc_produto_pedido_compra FOREIGN KEY ( cd_produto )
        REFERENCES t_pmc_produto ( cd_produto );

ALTER TABLE t_pmc_video_produto
    ADD CONSTRAINT fk_pmc_video_produto FOREIGN KEY ( cd_produto )
        REFERENCES t_pmc_produto ( cd_produto );

ALTER TABLE t_pmc_visualizacao_video
    ADD CONSTRAINT fk_pmc_vis_video_cliente FOREIGN KEY ( cd_cliente )
        REFERENCES t_pmc_cliente ( cd_cliente );

ALTER TABLE t_pmc_visualizacao_video
    ADD CONSTRAINT fk_pmc_vis_video_video_produto FOREIGN KEY ( cd_video )
        REFERENCES t_pmc_video_produto ( cd_video );

CREATE OR REPLACE TRIGGER arc_arc_p_t_pmc_cliente_fisico BEFORE
    INSERT OR UPDATE OF cd_cliente ON t_pmc_cliente_fisico
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.tp_cliente
    INTO d
    FROM
        t_pmc_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> 'F' ) THEN
        raise_application_error(
                               -20223,
                               'FK FK_PMC_CLTE_FISICO_CLIENTE in Table T_PMC_CLIENTE_FISICO violates Arc constraint on Table T_PMC_CLIENTE - discriminator column tp_cliente doesn''t have value ''F'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_t_pmc_cliente_juridico BEFORE
    INSERT OR UPDATE OF cd_cliente ON t_pmc_cliente_juridico
    FOR EACH ROW
DECLARE
    d CHAR(1);
BEGIN
    SELECT
        a.tp_cliente
    INTO d
    FROM
        t_pmc_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> 'J' ) THEN
        raise_application_error(
                               -20223,
                               'FK FK_PMC_CLTE_JURIDICO_CLIENTE in Table T_PMC_CLIENTE_JURIDICO violates Arc constraint on Table T_PMC_CLIENTE - discriminator column tp_cliente doesn''t have value ''J'''
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE SEQUENCE SQ_PMC_CATEGORIA_PRODUTO_cd_cat
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_PMC_CATEGORIA_PRODUTO_cd_cat 
BEFORE INSERT ON T_PMC_CATEGORIA_PRODUTO 
FOR EACH ROW 
WHEN (NEW.cd_categoria IS NULL) 
BEGIN
:new.cd_categoria := SQ_PMC_CATEGORIA_PRODUTO_cd_cat.nextval;

end;
/

CREATE SEQUENCE SQ_PMC_CATEGORIA_VIDEO_cd_categ 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_PMC_CATEGORIA_VIDEO_cd_categ 
BEFORE INSERT ON T_PMC_CATEGORIA_VIDEO 
FOR EACH ROW 
BEGIN
:new.cd_categoria := SQ_PMC_CATEGORIA_VIDEO_cd_categ.nextval;

end;
/

CREATE SEQUENCE SQ_PMC_CHAMADOS_cd_chamado
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_PMC_CHAMADOS_cd_chamado
BEFORE INSERT ON T_PMC_CHAMADOS 
FOR EACH ROW 
BEGIN
:new.cd_chamado := SQ_PMC_CHAMADOS_cd_chamado.nextval;

end;
/

CREATE SEQUENCE SQ_PMC_PRODUTO_cd_produto
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE OR REPLACE TRIGGER TR_PMC_PRODUTO_cd_produto
BEFORE INSERT ON T_PMC_PRODUTO 
FOR EACH ROW 
BEGIN
:new.cd_produto := SQ_PMC_PRODUTO_cd_produto.nextval;

end;
/

-- Comandos DROP para eliminar fisicamente o projeto de banco de dados
DROP SEQUENCE SQ_PMC_CATEGORIA_PRODUTO_cd_cat;
DROP SEQUENCE SQ_PMC_CHAMADOS_cd_chamado;
DROP SEQUENCE SQ_PMC_CATEGORIA_VIDEO_cd_categ;
DROP SEQUENCE SQ_PMC_PRODUTO_cd_produto;
DROP TRIGGER ARC_ARC_P_T_PMC_CLIENTE_FISICO;
DROP TRIGGER ARC_ARC_P_T_PMC_CLIENTE_JURIDICO;
DROP TRIGGER TR_PMC_CATEGORIA_PRODUTO_cd_cat;
DROP TRIGGER TR_PMC_CATEGORIA_VIDEO_cd_categ;
DROP TRIGGER TR_PMC_CHAMADOS_cd_chamado;
DROP TRIGGER TR_PMC_PRODUTO_cd_produto;
DROP TABLE T_PMC_CATEGORIA_PRODUTO CASCADE CONSTRAINTS;
DROP TABLE T_PMC_CATEGORIA_VIDEO CASCADE CONSTRAINTS;
DROP TABLE T_PMC_CHAMADOS CASCADE CONSTRAINTS;
DROP TABLE T_PMC_CLIENTE CASCADE CONSTRAINTS;
DROP TABLE T_PMC_CLIENTE_FISICO CASCADE CONSTRAINTS;
DROP TABLE T_PMC_CLIENTE_JURIDICO CASCADE CONSTRAINTS;
DROP TABLE T_PMC_DEPARTAMENTO CASCADE CONSTRAINTS;
DROP TABLE T_PMC_FUNCIONARIO CASCADE CONSTRAINTS;
DROP TABLE T_PMC_PEDIDO_COMPRA CASCADE CONSTRAINTS;
DROP TABLE T_PMC_PRODUTO CASCADE CONSTRAINTS;
DROP TABLE T_PMC_PRODUTOS_PEDIDO_COMPRA CASCADE CONSTRAINTS;
DROP TABLE T_PMC_VIDEO_PRODUTO CASCADE CONSTRAINTS;
DROP TABLE T_PMC_VISUALIZACAO_VIDEO CASCADE CONSTRAINTS;
