#!/bin/bash
#
# versao 1.0
#
# INFORMAÇÕES
#   recupera_quarentena.sh
#
# DESCRICAO
#    Reenvia e-mails de quarentena como anexo
#
# NOTA
#   Testado e desenvolvido em Fedora 27 e CentOS 7
#
#  DESENVOLVIDO_POR
#  Valdenir Luíz Mezadri Junior			- valdenirmezadri@live.com
#
#  MODIFICADO_POR		(DD/MM/YYYY)
#  Valdenir Luíz Mezadri Junior	23/11/2018	- Criado script
#  Valdenir Luíz Mezadri Junior 23/11/2018      - Finalizado testes
#
#########################################################################################################################################
######################## Variaveis que podem ser alteradas ##############################################################################
quarentena='/var/spool/MailScanner/quarantine/'
anexo='/tmp/mensagem_recuperada.eml'

######################## Não alterar a partir daqui ################################################
function ajuda {
	echo -e "\tINFORMAÇÕES:\n\trecupera_quarentena.sh\t\tReenvia e-mails de quarentena como anexo"
	echo -e "\n\tMODO DE USAR:\t\trecupera_quarentena.sh + caminho da mensagem + endereço para envio"
	echo -e "\n\tExemplos:"
	echo -e "\t./recupera_quarentena.sh A8100360F3C.A867A  junior@hardtec.srv.br"
}

function sair {
	exit 1
}

function check {
	if [[ $caminho == '-h' ]] ; then
		ajuda
		sair
	fi

	if [ $qtdArgumentos -lt 2 ]; then
		echo " "
		echo "Faltam argumentos. -h para ajuda"
		echo " "
		sair
	fi
}

function encontraMensagem {
	msg=$(find $quarentena -name $mensagem)
	if [[ $msg ]] ; then
		preparaAnexo
	else
		echo -e "\nMensagem não encontrada\n"
		sair
	fi
}

function preparaAnexo {
	cp $msg $anexo
}

function reenvia {
	encontraMensagem
	echo '' |mutt -s 'Recuperado' -a $anexo  -- $email
	echo 'Mensagem Reenviada, acompanhe os logs de e-mail!'
}

qtdArgumentos=$#
mensagem=$1
email=$2
####################### Final do código    #########################################################
####################### Execução do script #########################################################
check
reenvia
