<cfcomponent>

	<cffunction access="remote" name="getAsuntos" returntype="Query" >
		<cfargument name="cvedep" type="numeric">
		<cfquery name="qAsuntos" datasource="gestion2k17">
			select * from vasuntos_ubica2 where cvedep='#cvedep#';
		</cfquery>
		<cfreturn qAsuntos>
	</cffunction>
	
	<cffunction access="remote" name="getTurnos" returntype="Query" >
		<cfargument name="cvedep" type="numeric">
		<cfargument name="num_asunto" type="string">
		<cfquery name="qTurnos" datasource="gestion2k17">
			SELECT turnos.cvedep, turnos.num_asunto, turnos.num_turno, turnos.id_doctur, 
			turnos.nom_dest,turnos.dependen, turnos_dest.cvedep_t
			FROM turnos 
			INNER JOIN turnos_dest ON (turnos.num_turno = turnos_dest.num_turno) 
			AND (turnos.num_asunto = turnos_dest.num_asunto) 
			AND (turnos.cvedep = turnos_dest.cvedep)
			WHERE turnos.cvedep='#cvedep#' and turnos.num_asunto='#num_asunto#';
		</cfquery>
		<cfreturn qTurnos>
	</cffunction>
	
	<cffunction name="ArchivaAsunto_ANT" access="remote" returntype="any">
		<cfargument name="cvedep" type="string">
		<cfargument name="num_asunto" type="string">
		<cfargument name="anaquel" type="string">
		<cfargument name="carpeta" type="string">
		<cfargument name="id_usr" type="string">
        <cfquery name="qguardaTurnoANT" datasource="gestion2k17">	
			exec sp_iubica
				'#cvedep#',
				#num_asunto#,
				'#anaquel#',
				'#carpeta#',
				'#id_usr#'
        </cfquery>
    <cfreturn 1>
</cffunction>

<cffunction name="ArchivaAsunto" access="remote" returntype="any">
	<cfargument name="cvedep" type="string">
	<cfargument name="num_asunto" type="string">
	<cfargument name="anaquel" type="string">
	<cfargument name="carpeta" type="string">
	<cfargument name="id_usr" type="string">
	<cfargument name="num_turno" type="string">
	<cfargument name="cvedep_t" type="string">
    <cfquery name="qguardaTurno" datasource="gestion2k17">	
		exec sp_iubica
			'#cvedep#',
			#num_asunto#,
			'#anaquel#',
			'#carpeta#',
			'#id_usr#',
            #num_turno#,
			'#cvedep_t#'
    </cfquery>
    <cfreturn 1>
</cffunction>

<cffunction name="ModificaArchivo" access="remote" returntype="any">
	<cfargument name="cvedep" type="string">
	<cfargument name="num_asunto" type="string">
	<cfargument name="anaquel" type="string">
	<cfargument name="carpeta" type="string">
	<cfargument name="id_usr" type="string">
	<cfargument name="num_turno" type="string">
	<cfargument name="cvedep_t" type="string">
	<cfargument name="num_turnoAnt" type="string">
	<cfargument name="cvedep_tAnt" type="string">
    <cfquery name="qguardaTurno" datasource="gestion2k17">	
		exec sp_upubica
			'#cvedep#',
			#num_asunto#,
			'#anaquel#',
			'#carpeta#',
			'#id_usr#',
            #num_turno#,
			'#cvedep_t#',
			#num_turnoAnt#,
			'#cvedep_tAnt#'
    </cfquery>
    <cfreturn 1>
</cffunction>

</cfcomponent>
