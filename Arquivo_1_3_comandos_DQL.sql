-- ---------------------------------------------------------------------------------

    -- Comando SQL item a) 

SELECT c.CD_CATEGORIA, c.DS_CATEGORIA, p.CD_PRODUTO, p.DS_PRODUTO, p.VL_UNITARIO, p.TP_EMBALAGEM, p.VL_PERC_LUCRO
FROM MC_CATEGORIA_PROD c
LEFT JOIN MC_PRODUTO p ON c.CD_CATEGORIA = p.CD_CATEGORIA
ORDER BY c.DS_CATEGORIA ASC, p.DS_PRODUTO ASC;


-- ---------------------------------------------------------------------------------

    -- Comando SQL item b)

SELECT c.NR_CLIENTE, c.NM_CLIENTE, c.DS_EMAIL, c.NR_TELEFONE, c.NM_LOGIN, 
       f.DT_NASCIMENTO, TO_CHAR(f.DT_NASCIMENTO, 'Day') AS DIA_NASCIMENTO, 
       TRUNC(MONTHS_BETWEEN(SYSDATE, f.DT_NASCIMENTO)/12) AS ANOS_VIDA, 
       f.FL_SEXO_BIOLOGICO, f.NR_CPF 
FROM MC_CLIENTE c 
INNER JOIN MC_CLI_FISICA f ON c.NR_CLIENTE = f.NR_CLIENTE 
WHERE c.ST_CLIENTE = 'A' AND f.NR_CPF IS NOT NULL;


-- ---------------------------------------------------------------------------------

    -- Comando SQL item c)

SELECT c.NR_CLIENTE, c.NM_CLIENTE, c.DS_EMAIL, c.NR_TELEFONE, c.NM_LOGIN, 
    cj.DT_FUNDACAO, TO_CHAR(cj.DT_FUNDACAO, 'Day') AS DIA_FUNDACAO,
    TRUNC(MONTHS_BETWEEN(SYSDATE, cj.DT_FUNDACAO)/12) AS ANOS_VIDA_EMPRESA,
    cj.NR_CNPJ
FROM MC_CLIENTE c
INNER JOIN MC_CLI_JURIDICA cj ON c.NR_CLIENTE = cj.NR_CLIENTE
WHERE c.ST_CLIENTE = 'A'


-- ---------------------------------------------------------------------------------

    -- Comando SQL item d)
SELECT p.CD_PRODUTO, p.DS_PRODUTO, v.DT_VISUALIZACAO, v.NR_HORA_VISUALIZACAO, v.NR_MINUTO_VIDEO, v.NR_SEGUNDO_VIDEO
FROM MC_SGV_VISUALIZACAO_VIDEO v
INNER JOIN MC_PRODUTO p ON v.CD_PRODUTO = p.CD_PRODUTO
ORDER BY v.DT_VISUALIZACAO DESC, v.NR_HORA_VISUALIZACAO DESC;


-- ---------------------------------------------------------------------------------