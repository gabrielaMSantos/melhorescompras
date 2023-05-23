SET SERVEROUTPUT ON
DECLARE
    reclam mc_sgv_sac%rowtype; 
    reclam1 mc_cliente%rowtype; 
    reclam2 mc_produto%rowtype; 
    ds_tp_classic_sac mc_sgv_ocorrencia_sac.ds_tipo_classificacao_sac%type;
    vl_unit_lucro_prod mc_sgv_ocorrencia_sac.vl_unitario_lucro_produto%type;
    v_sg_estado mc_sgv_ocorrencia_sac.sg_estado%type;
    v_nm_estado mc_sgv_ocorrencia_sac.nm_estado%type;
    v_nr_cliente mc_sgv_ocorrencia_sac.nr_cliente%type;
    v_vl_icms_produto mc_sgv_ocorrencia_sac.vl_icms_produto%type;
    v_perc number(3);
    v_dt_abertura mc_sgv_ocorrencia_sac.dt_abertura_sac%type;
    
    CURSOR c_sac IS
    SELECT 
        sgv.nr_sac, 
        sgv.dt_abertura_sac, 
        sgv.hr_abertura_sac, 
        sgv.tp_sac, 
        sgv.cd_produto,
        sgv.nr_cliente, 
        cli.nm_cliente , 
        prd.ds_produto, 
        prd.vl_unitario, 
        prd.vl_perc_lucro
    FROM mc_sgv_sac sgv
    INNER JOIN mc_cliente cli on sgv.nr_cliente = cli.nr_cliente
    INNER JOIN mc_produto prd ON sgv.cd_produto = prd.cd_produto;
BEGIN
    OPEN c_sac;
    LOOP
        FETCH c_sac INTO reclam.nr_sac, reclam.dt_abertura_sac, reclam.hr_abertura_sac, reclam.tp_sac, reclam.cd_produto, reclam1.nr_cliente,
         reclam1.nm_cliente, reclam2.ds_produto, reclam2.vl_unitario, reclam2.vl_perc_lucro;
    EXIT WHEN c_sac%notfound;
    ds_tp_classic_sac := reclam.tp_sac;
   
    vl_unit_lucro_prod := (reclam2.vl_perc_lucro/100)*reclam2.vl_unitario ;
    IF ds_tp_classic_sac = 'S' THEN 
    ds_tp_classic_sac  := 'SUGESTÃO';
    ELSIF ds_tp_classic_sac ='D' THEN ds_tp_classic_sac := 'DÚVIDA';
    ELSIF ds_tp_classic_sac ='E' THEN ds_tp_classic_sac := 'ELOGIO';
    ELSE ds_tp_classic_sac := 'CLASSIFICAÇÃO INVÁLIDA';
    END IF;
    v_nr_cliente := reclam1.nr_cliente;
    SELECT d.sg_estado INTO v_sg_estado
     FROM mc_end_cli e
        INNER JOIN mc_logradouro l ON e.cd_logradouro_cli = l.cd_logradouro
        INNER JOIN mc_bairro b on l.cd_bairro = b.cd_bairro
        INNER JOIN mc_cidade c ON c.cd_cidade = b.cd_cidade
        INNER JOIN mc_estado d ON d.sg_estado = c.sg_estado
        WHERE e.nr_cliente = v_nr_cliente;
     v_sg_estado := v_sg_estado;   
    SELECT nm_estado INTO v_nm_estado
     FROM mc_estado   
     WHERE sg_estado=v_sg_estado;
    v_perc := pf0110.fun_mc_gera_aliquota_media_icms_estado(v_sg_estado);
    v_vl_icms_produto :=  (v_perc/100)* reclam2.vl_unitario;
    v_dt_abertura := to_date(reclam.dt_abertura_sac,'DD-MM-YY');
    INSERT INTO mc_sgv_ocorrencia_sac( nr_ocorrencia_sac, dt_abertura_sac, hr_abertura_sac, ds_tipo_classificacao_sac, 
    cd_produto, ds_produto, vl_unitario_produto, vl_perc_lucro, vl_unitario_lucro_produto, sg_estado,
    nm_estado , nr_cliente , nm_cliente, vl_icms_produto)
    VALUES (reclam.nr_sac, reclam.dt_abertura_sac, reclam.hr_abertura_sac, ds_tp_classic_sac, reclam.cd_produto,  reclam2.ds_produto, 
    reclam2.vl_unitario, reclam2.vl_perc_lucro, vl_unit_lucro_prod, v_sg_estado, v_nm_estado, v_nr_cliente, reclam1.nm_cliente, v_vl_icms_produto);
        
    dbms_output.put_line('inserts feitos com sucesso');
    END LOOP;
    CLOSE c_sac;
    
    COMMIT;
            
END;
        