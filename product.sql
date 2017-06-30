select distinct p.description as Produto ,F_PARENT.DESCRIPTION AS FAMILIA,
	   F.DESCRIPTION  AS SUBFAMILIA, p.saleprice as PRECO_VENDA,
                (SELECT EFS.FIELD_VALUE
                   FROM EXTENDED_FIELD_STRING EFS,
                        SYS_FIELD
                  WHERE P.ID = EFS.KEY1_ID
                    AND EFS.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'NCM') AS NCM,
                (SELECT EFS.FIELD_VALUE
                   FROM EXTENDED_FIELD_STRING EFS,
                        SYS_FIELD
                  WHERE P.ID = EFS.KEY1_ID
                    AND EFS.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'ICMS_N_ST') AS ICMS_N_ST,
                (SELECT EFS.FIELD_VALUE
                   FROM EXTENDED_FIELD_STRING EFS,
                        SYS_FIELD
                  WHERE P.ID = EFS.KEY1_ID
                    AND EFS.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'SERVICE_TYPE') AS SERVICE_TYPE,
                (SELECT EFI.FIELD_VALUE
                   FROM EXTENDED_FIELD_INTEGER EFI,
                        SYS_FIELD
                  WHERE P.ID = EFI.KEY1_ID
                    AND EFI.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'INCENTIVO_FISCAL') AS INCENTIVO_FISCAL,
                (SELECT EFS.FIELD_VALUE
                   FROM EXTENDED_FIELD_STRING EFS,
                        SYS_FIELD
                  WHERE P.ID = EFS.KEY1_ID
                    AND EFS.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'TIPI') AS TIPI,
                (SELECT EFS.FIELD_VALUE
                   FROM EXTENDED_FIELD_STRING EFS,
                        SYS_FIELD
                  WHERE P.ID = EFS.KEY1_ID
                    AND EFS.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'GENERO_ITEM') AS GENERO_ITEM,
                (SELECT EFS.FIELD_VALUE
                   FROM EXTENDED_FIELD_STRING EFS,
                        SYS_FIELD
                  WHERE P.ID = EFS.KEY1_ID
                    AND EFS.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'SERVICE_CODE') AS SERVICE_CODE,
                (SELECT EFS.FIELD_VALUE
                   FROM EXTENDED_FIELD_STRING EFS,
                        SYS_FIELD
                  WHERE P.ID = EFS.KEY1_ID
                    AND EFS.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'ST_CODE') AS ST_CODE,
                (SELECT DESCRIPTION
                   FROM TAXGROUP TG
                  WHERE P.TAXGROUP_ID = TG.ID) AS TAXA_ICMS,
                (SELECT EFS.FIELD_VALUE
                   FROM EXTENDED_FIELD_STRING EFS,
                        SYS_FIELD
                  WHERE P.ID = EFS.KEY1_ID
                    AND EFS.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'CEST') AS CEST,
                (SELECT EFI.FIELD_VALUE
                   FROM EXTENDED_FIELD_INTEGER EFI,
                        SYS_FIELD
                  WHERE P.ID = EFI.KEY1_ID
                    AND EFI.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'CFOP') AS CFOP,
                (SELECT EFI.FIELD_VALUE
                   FROM EXTENDED_FIELD_INTEGER EFI,
                        SYS_FIELD
                  WHERE P.ID = EFI.KEY1_ID
                    AND EFI.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'CSOSN') AS CSOSN,
                
		

		CASE (SELECT EFI.FIELD_VALUE
                   FROM EXTENDED_FIELD_INTEGER EFI,
                        SYS_FIELD
                  WHERE P.ID = EFI.KEY1_ID
                    AND EFI.SYS_FIELD_ID = SYS_FIELD.ID
                    AND SYS_FIELD.DESCRIPTION = 'EXIGIBILITY_ISS')  
					when 1 then "Exigível" when 2 then "Não incidente" when 3 then "Isenção" when 4 then "Exportação" when 5 then "Imunidade" when 6 then "Exig. Susp. Judicial" when 7 then "Exig.Susp. ADM" end AS EXIG_ISS

		
		 FROM PRODUCT P
   LEFT JOIN FAMILY F
    ON F.ID = P.FAMILY_ID
  LEFT JOIN FAMILY F_PARENT
    ON F_PARENT.ID = F.PARENT_ID

       ,extended_field_string  as efs, sys_field sf
       where p.family_id != 19000 and p.family_id = f.id and p.id = efs.key1_id and efs.sys_field_id = sf.id
order by Familia,Produto