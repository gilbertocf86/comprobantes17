<cfcomponent>

	<cffunction access="remote" name="getNumAsuntos" returntype="Query">
		<cfargument name="cvedep" required="true" type="numeric">
		<cfquery name="qNumAsuntos" datasource="gestion2k17">
			select * from vasunto01_n where cvedep='#cvedep#';
		</cfquery>
		<cfreturn qNumAsuntos>
	</cffunction>
	
    <cffunction access="remote" name="getNumAsuntosEnt" returntype="Query">
		<cfargument name="cvedep" required="true" type="numeric">
		<cfquery name="qgetNumAsuntosEnt" datasource="gestion2k17">
			select *  from vasunto01_n2 where cvedep = '#cvedep#' order by (CAST(num_asunto AS INT)) asc 
		</cfquery>
		<cfreturn qgetNumAsuntosEnt>
	</cffunction>
    
	<cffunction access="remote" name="getAsuntoUltimo" returntype="Query">
		<cfargument name="cvedep" required="true" type="numeric">
		<cfquery name="qAsuntoUltimo" datasource="gestion2k17">
			select * from vasunto01_n2 where cvedep='#cvedep#' and num_asunto=[dbo].[FAsunto_ultimo]('#cvedep#');
		</cfquery>
		<cfreturn qAsuntoUltimo>
	</cffunction>
	
	<cffunction access="remote" name="getCatTipoDoc" returntype="Query">
		<cfquery name="qCatTipoDoc" datasource="gestion2k17">
			select * from cattipodoc;
		</cfquery>
		<cfreturn qCatTipoDoc>
	</cffunction>
	
	<cffunction access="remote" name="getCatDep" returntype="Query">
		<cfquery name="qCatDep" datasource="gestion2k17">
			select cvedep,dependen from catdep where activo='S' order by dependen;
		</cfquery>
		<cfreturn qCatDep>
	</cffunction>
	
	<cffunction access="remote" name="getCargoTitular" returntype="Query">
	<cfargument name="cvedep" type="string">
		<cfquery name="qgetTitular" datasource="gestion2k17">
			select * from catdep where cvedep='#cvedep#';
		</cfquery>
		<cfreturn qgetTitular>
	</cffunction>
	
	<cffunction access="remote" name="getCatEdos" returntype="Query">
		<cfquery name="qCatEdos" datasource="gestion2k17">
		select * from catedos;
		</cfquery>
		<cfreturn qCatEdos>
	</cffunction>
	
	<cffunction access="remote" name="getCatMpios" returntype="Query">
		<cfargument name="cveest" required="true" type="numeric">
		<cfquery name="qCatMpios" datasource="gestion2k17">
		select * from catmun where cveest=#cveest#
		</cfquery>
		<cfreturn qCatMpios>
	</cffunction>
	
	<cffunction access="remote" name="getCatPrior" returntype="Query">
		<cfquery name="qCatPrior" datasource="gestion2k17">
			select * from catprior;
		</cfquery>
		<cfreturn qCatPrior>
	</cffunction>
	
	<cffunction access="remote" name="getCatPrior2" returntype="Query">
		<cfquery name="qCatPrior" datasource="gestion2k17">
			select * from catprior;
		</cfquery>
		<cfreturn qCatPrior>
	</cffunction>
	
	<cffunction access="remote" name="getCatCasif" returntype="Query">
		<cfquery name="qCatCasif" datasource="gestion2k17">
			select * from catclasif;
		</cfquery>
		<cfreturn qCatCasif>
	</cffunction>
	
	<cffunction access="remote" name="getNuevoAsunto" returntype="Query" >
		<cfargument name="cvedep" required="true" type="numeric">
		<cfquery name="qNuevoAsunto" datasource="gestion2k17">
			select [dbo].[FAsunto_ultimo]('#cvedep#')+1 as nuevo;
		</cfquery>
		<cfreturn qNuevoAsunto>
	</cffunction>
	
	<cffunction access="remote" name="getLeeAsunto" returntype="Query" >
		<cfargument name="cvedep" type="string">
		<cfargument name="numAsunto" type="numeric">
		<cfquery name="qLeeAsunto" datasource="gestion2k17">
			select * from vasunto01_n where cvedep='#cvedep#' and num_asunto=#numAsunto#;
		</cfquery>
		<cfreturn qLeeAsunto>
	</cffunction>
	
	<cffunction name="getGuardaAsunto" access="remote" returntype="Query">
		<cfargument name="cvedep" type="string">
		<cfargument name="num_asunto" type="string">
		<cfargument name="cvetipo" type="string">
		<cfargument name="id_doc" type="string">
		<cfargument name="nom_ori" type="string">
		<cfargument name="cargo_ori" type="string">
		<cfargument name="dependen" type="string">
		<cfargument name="fdoc" type="date" default="yyyy-mm-dd">
		<cfargument name="frecep" type="date" default="yyyy-mm-dd">
		<cfargument name="fahora" type="date" default="yyyy-mm-dd">
		<cfargument name="dirigidoa" type="string">
		<cfargument name="asunto" type="string">
		<cfargument name="num_hojas" type="string">
		<cfargument name="cve_pri" type="string">
		<cfargument name="cveest" type="string">
		<cfargument name="municipio" type="string">
		<cfargument name="localidad" type="string">
		<cfargument name="titulo_asunto" type="string">
		<cfargument name="sspace" type="string">
		<cfargument name="cct" type="string">
		<cfargument name="id_usr" type="string">
		<cfargument name="app_ori" type="string">
		<cfargument name="apm_ori" type="string">
		<cfargument name="id_sspace" type="string">
		<cfargument name="idclas" type="string">
        <cfquery name="qGuardaAsunto" datasource="gestion2k17">	
       	SET DATEFORMAT ymd
			exec SP_IAsuntos
				'#cvedep#',
				#num_asunto#,
				'#cvetipo#',
				'#id_doc#',
				'#nom_ori#',
				'#cargo_ori#',
				'#dependen#',
				'#fdoc#',
				'#frecep#',
				'#fahora#',
				'#dirigidoa#',
				'#asunto#',
				'#num_hojas#',
				'#cve_pri#',
				'#cveest#',
				'#municipio#',
				'#localidad#',
				'#titulo_asunto#',
				'#sspace#',
				'#cct#',
				'#id_usr#',
				'#app_ori#',
				'#apm_ori#',
				'#id_sspace#',
				'#idclas#'
        </cfquery>
    <cfreturn qGuardaAsunto>
</cffunction>

	<cffunction access="remote" name="getPresupuesto" returntype="Query" >
		<cfargument name="cvedep" type="string">
		<cfargument name="num_asunto" type="string">
		<cfquery name="qPresupuesto" datasource="gestion2k17">
			select * from Tasunto_pres where cvedep='#cvedep#' and num_asunto='#num_asunto#'
		</cfquery>
		<cfreturn qPresupuesto>
	</cffunction>

	<cffunction name="getGuardaPre" access="remote" returntype="any">
		<cfargument name="cvedep" type="string">
		<cfargument name="num_asunto" type="string">
		<cfargument name="federal" type="string">
		<cfargument name="estatal" type="string">
		<cfargument name="municipal" type="string">
		<cfargument name="id_usr" type="string">
        <cfquery name="qGuardaAsunto" datasource="gestion2k17">	
			exec sp_Itasunto_pres
   				'#cvedep#',
				#num_asunto#,
  				'#federal#',
				'#estatal#',
				'#municipal#',
 				'#id_usr#'
        </cfquery>
    <cfreturn 1>
</cffunction>

	<cffunction access="remote" name="getFechaHora" returntype="Query">
		<cfquery name="qFechaHora" datasource="gestion2k17">
			select h=getdate();
		</cfquery>
		<cfreturn qFechaHora>
	</cffunction>
	
	<cffunction access="remote" name="getTitular" returntype="Query">
	<cfargument name="cvedep" type="string">
		<cfquery name="qgetTitular" datasource="gestion2k17">
			select titular from catdep where cvedep='#cvedep#';
		</cfquery>
		<cfreturn qgetTitular>
	</cffunction>
	
	<cffunction name="getEliminaA" access="remote" returntype="any">
		<cfargument name="cvedep" type="string">
		<cfargument name="num_asunto" type="string">
        <cfquery name="qGetEliminaA" datasource="gestion2k17">	
			exec sp_eliminaasunto
   				'#cvedep#',
				#num_asunto#
        </cfquery>
    <cfreturn 1>
</cffunction>

<cffunction access="remote" name="getasunsinate" returntype="Query">
	<cfargument name="cvedep" type="string">
		<cfquery name="qgetasunsinate" datasource="gestion2k17">
        
        select * from vasuntos_noTerminados where cvedep = '#cvedep#';
			
		</cfquery>
		<cfreturn qgetasunsinate>
	</cffunction>
    
    <cffunction access="remote" name="gettursinate" returntype="Query">
	<cfargument name="cvedep" type="string">
		<cfquery name="qgettursinate" datasource="gestion2k17">
        
        select * from vasuntos_noTerminados where cvedep = '#cvedep#';
			
		</cfquery>
		<cfreturn qgettursinate>
	</cffunction>


</cfcomponent>
