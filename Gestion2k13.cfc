<cfcomponent>
	
<!--- usuario --->	
	<cffunction name="usuario" access="remote" returntype="query">
		<cfargument name="usr" type="string" required="yes">
		<cfargument name="psw" type="string" required="yes">
		 <cfquery name="qusuario" datasource="gestion2k17">
        	SELECT id_usr, cvedep, dependen, cvedep_p, nombre, pwd, Expr1, nivel, nivel_dep, nivel_sspace FROM Vusuarios where id_usr = '#usr#' and pwd = '#psw#'
        </cfquery>
		<cfreturn qusuario>
	</cffunction>
	
	
	<!--- llena grid_consulta FAsuntosSspace --->	
	<cffunction name="getasunrecibidos" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
		 <cfquery name="qgetasunrecibidos" datasource="gestion2k17">
         
        select cvedep,dependen_t,sin_avance,en_tramite,solventado,improcedente,para_conocimiento, sum(sin_avance + en_tramite + solventado + improcedente + para_conocimiento ) as total   from FAsuntos_numj('#cvedep#') group by cvedep,dependen_t, sin_avance, en_tramite, solventado, improcedente, para_conocimiento

        	
        </cfquery>
		<cfreturn qgetasunrecibidos>
	</cffunction>
	
	<!--- llena grid_consulta FAsuntosSspace=TOTAL --->	
	<cffunction name="getasuntot" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
		 <cfquery name="qgetasuntot" datasource="gestion2k17">
        	select num_asunto, id_sspace, dependen_turnado, asunto, desc_status as status, avance, favan
			from VAsuntos_Turnados_cvedep_cvedep_t_j
			where cvedep='#cvedep#'
			order by cvedep_t, cvestat
        </cfquery>
		<cfreturn qgetasuntot>
	</cffunction>
	
	<!--- llena grid_consulta FAsuntosSspace<>TOTAL --->	
	<cffunction name="getasundiftot" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
	<cfargument name="cvedep_t" type="string" required="yes">
		 <cfquery name="qgetasundiftot" datasource="gestion2k17">
        	select num_asunto, id_sspace, dependen_turnado, asunto, desc_status as status, avance, favan
			from VAsuntos_Turnados_cvedep_cvedep_t_j
			where cvedep='#cvedep#'
			and cvedep_t='#cvedep_t#'
			order by cvedep_t, cvestat
        </cfquery>
		<cfreturn qgetasundiftot>
	</cffunction>
	
	
	<!--- llena grid_consulta FAsuntos --->	
	<cffunction name="getasunrecibidos1" access="remote" returntype="query">
		 <cfquery name="qgetasunrecibidos1" datasource="gestion2k17">
        	select cvedep_t, dependen_turnado, cvestat, desc_status, COUNT (*) as asuntos_turnados 
			from FAsuntos_Recibidos('7013')
			group by cvedep_t, dependen_turnado, cvestat, desc_status
			order by cvedep_t, dependen_turnado, cvestat, desc_status  
        </cfquery>
		<cfreturn qgetasunrecibidos1>
	</cffunction>
	
	<!--- llena grid_consulta FAsuntosSspaceEntradas --->	
	<cffunction name="getasunrecibidosent" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
		 <cfquery name="qgetasunrecibidosent" datasource="gestion2k17">
        	SELECT * FROM VSspace_Union_SUMA_total_RESUMEN_Entradas where CVEDEP_T='#cvedep#'
        </cfquery>
		<cfreturn qgetasunrecibidosent>
	</cffunction>
	
	<!--- llena grid_consulta FAsuntosSspace=TOTAL ENTRADAS --->	
	<cffunction name="getasuntotent" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
		 <cfquery name="qgetasuntotent" datasource="gestion2k17">
        	SELECT num_asunto, id_sspace, dependen_turnado, asunto, desc_status as status, avance, favan
			FROM VAsuntos_Turnados_cvedep_cvedep_t_Entradas
			WHERE cvedep_t='#cvedep#'
			order by cvedep_t, cvestat
        </cfquery>
		<cfreturn qgetasuntotent>
	</cffunction>
	
	<!--- llena grid_consulta FAsuntosSspace<>TOTAL entradas --->	
	<cffunction name="getasundiftotent" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
	<cfargument name="cvedep_t" type="string" required="yes">
		 <cfquery name="qgetasundiftotent" datasource="gestion2k17">
        	SELECT num_asunto, id_sspace, dependen_turnado, asunto, desc_status as status, avance, favan
			FROM VAsuntos_Turnados_cvedep_cvedep_t_ENTRADAS 
			WHERE cvedep='#cvedep#'
			and cvedep_t='#cvedep_t#'
			order by cvedep_t, cvestat
        </cfquery>
		<cfreturn qgetasundiftotent>
	</cffunction>
	
	<!--- llena grid_consulta Asun enviados resumen --->	
	<cffunction name="getasunres" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
		 <cfquery name="qgetasunres" datasource="gestion2k17">
         
         select * from FAsuntos_Resumen_numj('#cvedep#')
               	
        </cfquery>
		<cfreturn qgetasunres>
	</cffunction>
	
	<!--- llena grid_combo status --->	
	<cffunction name="getstatus" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
		 <cfquery name="qgetstatus" datasource="gestion2k17">
        	select distinct cvestat_turno, status from VHistorico_Turnos where cvedep='#cvedep#'
        </cfquery>
		<cfreturn qgetstatus>
	</cffunction>
	
	<!--- llena grid_asuntos status reasigna--->	
	<cffunction name="getasureasigna" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
	<cfargument name="cvestat" type="string" required="yes">
		 <cfquery name="qgetasureasigna" datasource="gestion2k17">
        	select distinct cvedep, num_asunto, num_turno, num_volante, cvetipo, id_doctur, id_sspace, asunto from VTurnos_Reasignar 
			where cvedep='#cvedep#' and cvestat ='#cvestat#' order by num_asunto 
        </cfquery>
		<cfreturn qgetasureasigna>
	</cffunction>
	
	<!--- llena ejecuta procedimiento SP_IHTurnos_Avances--->	
	<cffunction name="getspturavan" access="remote" returntype="any">
	<cfargument name="cvedep" type="string" required="yes">
	<cfargument name="num_asunto" type="string" required="yes">
	<cfargument name="num_turno" type="string" required="yes">
	<cfargument name="num_volante" type="string" required="yes">
		 <cfquery name="qgetspturavan" datasource="gestion2k17">
        	execute SP_IHTurnos_Avances '#cvedep#',#num_asunto#,#num_turno#,#num_volante# 
        </cfquery>
		<cfreturn 1>
	</cffunction>
	
	<!--- llena combo dependencia a reasignar--->	
	<cffunction name="getdepreasigna" access="remote" returntype="query">
	<cfargument name="cvedep_p" type="string" required="yes">
	<cfargument name="cvedep" type="string" required="yes">
	<cfargument name="num_asunto" type="string" required="yes">
		 <cfquery name="qgetdepreasigna" datasource="gestion2k17">
        	select dbo.usuarios.cvedep, dbo.catdep.dependen
			from dbo.usuarios inner join dbo.catdep on dbo.usuarios.cvedep=dbo.catdep.cvedep 
			where (dbo.usuarios.cvedep_p=#cvedep_p#) and (dbo.usuarios.cvedep not in
			(select cvedep_t 
			from dbo.VAsuntos_Turnados_cvedep_cvedep_t_j
			where(cvedep=#cvedep#) and (num_asunto=#num_asunto#))) 
        </cfquery>
		<cfreturn qgetdepreasigna>
	</cffunction>
	
	<!--- llena spIreasigna_turno--->	
	<cffunction name="getspreasigna" access="remote" returntype="any">
	<cfargument name="cvedep" type="string" required="yes">
	<cfargument name="num_asunto" type="string" required="yes">
	<cfargument name="cvetipo" type="string" required="yes">
	<cfargument name="id_doctur" type="string" required="yes">
	<cfargument name="fentrega" type="string" required="yes">
	<cfargument name="id_usr" type="string" required="yes">
	<cfargument name="cvedep_d" type="string" required="yes">
		 <cfquery name="qgetspreasigna" datasource="gestion2k17">
        	execute SP_IReasigna_Turno '#cvedep#', #num_asunto#, '#cvetipo#', '#id_doctur#', '#fentrega#', '#id_usr#', '#cvedep_d#' 
        </cfquery>
		<cfreturn 1>
	</cffunction>
	
	<!--- llena combo tipodoc --->	
	<cffunction name="gettipodoc" access="remote" returntype="query">
		 <cfquery name="qgettipodoc" datasource="gestion2k17">
        	SELECT cvetipo,tipo_doc FROM cattipodoc
        </cfquery>
		<cfreturn qgettipodoc>
	</cffunction>
	
	<!--- llena combo estados --->	
	<cffunction name="getestados" access="remote" returntype="query">
		 <cfquery name="qgetestados" datasource="gestion2k17">
        	SELECT cveest,estado FROM catedos
        </cfquery>
		<cfreturn qgetestados>
	</cffunction>
	
	<!--- llena combo municipios --->	
	<cffunction name="getmun" access="remote" returntype="query">
		 <cfquery name="qgetmun" datasource="gestion2k17">
        	SELECT cvemun,municipio FROM catmun
        </cfquery>
		<cfreturn qgetmun>
	</cffunction>
	
	<!--- llena combo prioridad --->	
	<cffunction name="getpriori" access="remote" returntype="query">
		 <cfquery name="qgetpriori" datasource="gestion2k17">
        	SELECT CVE_PRI,prioridad FROM catprior
        </cfquery>
		<cfreturn qgetpriori>
	</cffunction>
	
	<!--- llena combo clasificacion --->	
	<cffunction name="getclas" access="remote" returntype="query">
		 <cfquery name="qgetclas" datasource="gestion2k17">
        	SELECT idclas,clasificacion FROM catclasif
        </cfquery>
		<cfreturn qgetclas>
	</cffunction>
	
	<!--- llena grid_asuntos --->	
	<cffunction name="getgasuntos" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
		 <cfquery name="qgetgasuntos" datasource="gestion2k17">
        	select distinct num_asunto from vasunto01 where cvedep = '#cvedep#'
        </cfquery>
		<cfreturn qgetgasuntos>
	</cffunction>
	
	
	<!--- Ip del server para menú --->
	<cffunction name="get_ip" access="remote" returntype="string">

		<cfreturn #cgi.SERVER_NAME#>

	</cffunction>
	
	 <!--- llena grid sin avaqnce --->	
	<cffunction name="getsinavance" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
    <cfargument name="cveestat" type="string" required="yes">
    <cfargument name="cvedept" type="string" required="yes">
		 <cfquery name="qgetsinavance" datasource="gestion2k17">
        	select num_asunto,id_doc,nom_ori,cargo_ori,frecepcion,id_sspace,num_turno,
titulo_asunto,asunto,prioridad,fentrega_turno,instruc,fmaxcumplimiento,
cvestat,desc_status,avance,favan,dependen_turnado,cvedep_t,cvedep,inum,comenta
from VAsuntos_Turnados_cvedep_cvedep_t_j
where cvedep='#cvedep#' and cvestat='#cveestat#' and cvedep_t='#cvedept#'
        </cfquery>
		<cfreturn qgetsinavance>
	</cffunction>
    
    
     <!--- llena grid todo--->	
	<cffunction name="getasudet" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
    <cfargument name="cvedept" type="string" required="yes">
    <cfargument name="cveestat" type="string" required="yes">
     <cfquery name="qgetasudet" datasource="gestion2k17">
         
          select * from FAsuntos_numj_detalle('#cvedep#','#cvedept#','#cveestat#')
        	
        </cfquery>
		<cfreturn qgetasudet>
	</cffunction>
    
     <!--- llena grid todo--->	
	<cffunction name="getasudettot" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
    <cfargument name="cvedept" type="string" required="yes">
  	 <cfquery name="qgetasudettot" datasource="gestion2k17">
     
       select * from FAsuntos_numj_detallet('#cvedep#','#cvedept#')
        	
        </cfquery>
		<cfreturn qgetasudettot>
	</cffunction>
    
      <!--- llena grid suma status--->	
	<cffunction name="getasudetstatus" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
    <cfargument name="status" type="string" required="yes">
  	 <cfquery name="qgetasudetstatus" datasource="gestion2k17">
          
          select * from FAsuntos_numj_detalle_status('#cvedep#','#status#') 
        	
        </cfquery>
		<cfreturn qgetasudetstatus>
	</cffunction>
    
     <!--- llena grid sin avaqnce --->	
	<cffunction name="getsinavancetotlin" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
    <cfargument name="cvedept" type="string" required="yes">
		 <cfquery name="qgetsinavancetotlin" datasource="gestion2k17">
        	select num_asunto,id_doc,nom_ori,cargo_ori,frecepcion,id_sspace,num_turno,
titulo_asunto,asunto,prioridad,fentrega_turno,instruc,fmaxcumplimiento,
cvestat,desc_status,avance,favan,dependen_turnado,cvedep_t,cvedep,inum,comenta
from VAsuntos_Turnados_cvedep_cvedep_t_j
where cvedep='#cvedep#' and cvedep_t='#cvedept#'
        </cfquery>
		<cfreturn qgetsinavancetotlin>
	</cffunction>
    
    <!--- llena grid sin avaqnce todo --->	
	<cffunction name="getsinavanceall" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
    <cfargument name="cveestat" type="string" required="yes">
    <cfquery name="qgetsinavanceall" datasource="gestion2k17">
        	select num_asunto,id_doc,nom_ori,cargo_ori,frecepcion,id_sspace,num_turno,
titulo_asunto,asunto,prioridad,fentrega_turno,instruc,fmaxcumplimiento,
cvestat,desc_status,avance,favan,dependen_turnado
from VAsuntos_Turnados_cvedep_cvedep_t_j
where cvedep='#cvedep#' and cvestat='#cveestat#'
        </cfquery>
		<cfreturn qgetsinavanceall>
	</cffunction>
    
    <!--- SUMA grid  todo --->	
	<cffunction name="getsumavanceall" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
    <cfquery name="qgetsumavanceall" datasource="gestion2k17">
 
        				
select sum(sin_avance) as sinavance, sum(en_tramite) as entramite, sum(solventado) as solventa, sum(improcedente) as improcedent, sum(para_conocimiento) as conocimiento, sum(sin_turnar) as sinturnar,  sum(sin_avance + en_tramite + solventado + improcedente + para_conocimiento + sin_turnar) as total   from FAsuntos_numj('#cvedep#')

        </cfquery>
		<cfreturn qgetsumavanceall>
	</cffunction>
	
    
     <cffunction access="remote" name="getcoment" returntype="Query" >
		<cfargument name="cvedep" type="string">
        <cfargument name="noasunto" type="string">
		<cfquery name="qgetcoment" datasource="gestion2k17">
        
       
       select * from Fcomentarios('#cvedep#','#noasunto#');
                  
		</cfquery>
		<cfreturn qgetcoment>
	</cffunction>
    
     <cffunction access="remote" name="getcomenttot" returntype="Query" >
		<cfargument name="cvedep" type="string">
        <cfargument name="noasunto" type="string">
		<cfquery name="qgetcomenttot" datasource="gestion2k17">
        
       select  dbo.fcomentarios_num('#cvedep#','#noasunto#') as inum; 
       
      
                  
		</cfquery>
		<cfreturn qgetcomenttot>
	</cffunction>
    
    
    <cffunction access="remote" name="getagrecom" returntype="any">
    <cfargument name="cvedep" required="true" type="string">
     <cfargument name="noasunto" required="true" type="string">
     <cfargument name="idcoment" required="true" type="string">
     <cfargument name="fechcom" required="true" type="date">
     <cfargument name="idusr" required="true" type="string"> 
		<cfquery name="qgetagrecom" datasource="gestion2k17">
			
           execute sp_itcomentarios
			'#cvedep#',
			'#noasunto#',
			'#idcoment#',
            '#fechcom#',
			'#idusr#'
           
      </cfquery>
		<cfreturn 1>
	</cffunction>
    
    <cffunction access="remote" name="llenagridcom" returntype="Query" >
		<cfargument name="cvedep" type="string">
        <cfargument name="no_asunto" type="string">
		<cfquery name="qllenagridcom" datasource="gestion2k17">
        
        select * from  tcomentarios where cvedep= '#cvedep#' and num_asunto = '#no_asunto#';
        
                    
		</cfquery>
		<cfreturn qllenagridcom>
	</cffunction>
    
    <!---llena grid Asuntos --->	
    
    <cffunction access="remote" name="llenaGridAsuntos" returntype="Query" >
		<cfargument name="cvedep" type="string">
        <cfargument name="cvetipo" type="string">
		<cfquery name="qllenaGridAsuntos" datasource="gestion2k17">
           
           select * from  FAsuntos_numj_detalle_tt('#cvedep#','#cvetipo#');
		
                        
		</cfquery>
		<cfreturn qllenaGridAsuntos>
	</cffunction>
    
      <!---llena grid Asuntos sin turnar --->	
    
    <cffunction access="remote" name="llenaGridAsunSinTurna" returntype="Query" >
		<cfargument name="cvedep" type="string">
		<cfquery name="qllenaGridAsunSinTurna" datasource="gestion2k17">
               
		SELECT * FROM vresumen_Asuntos_sin_turnar_j_det WHERE cvedep='#cvedep#';
                        
		</cfquery>
		<cfreturn qllenaGridAsunSinTurna>
	</cffunction>
    
    <!---llena grid Asuntos turnar --->	
    
    <cffunction access="remote" name="llenaGridAsunTurna" returntype="Query" >
		<cfargument name="cvedep" type="string">
		<cfquery name="qllenaGridAsunTurna" datasource="gestion2k17">
               
		SELECT * FROM vresumen_Asuntos_turnar_j_det WHERE cvedep='#cvedep#';
                        
		</cfquery>
		<cfreturn qllenaGridAsunTurna>
	</cffunction>
    
    
    <!---llena grid Asuntos turnar mas de una vez --->	
    
    <cffunction access="remote" name="llenaGridTurna1vez" returntype="Query" >
		<cfargument name="cvedep" type="string">
		<cfquery name="qllenaGridTurna1vez" datasource="gestion2k17">
               
		SELECT * FROM vasuntos_turnados_mas_1Vez_j WHERE cvedep='#cvedep#';
                        
		</cfquery>
		<cfreturn qllenaGridTurna1vez>
	</cffunction>
    
    <!--- llena grid_PRIORIDAD--->	
	<cffunction name="getresprioridad" access="remote" returntype="query">
	<cfargument name="cvedep" type="string" required="yes">
		 <cfquery name="qgetresprioridad" datasource="gestion2k17">
         
         select * from FAsuntos_Resumen_prioridad('#cvedep#')	
      

        	
        </cfquery>
		<cfreturn qgetresprioridad>
	</cffunction>
    
</cfcomponent>