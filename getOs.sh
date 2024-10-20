#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Este script le permitirá identificar el sistema operativo mediante el ttl."
	echo "Forma de uso: $0 <Ip>"
	echo "Ejemplo: $0 192.168.62.135"
	exit 1
fi

ip=$1

if [ -z "$ip" ]; then
	echo "Debe ingresar una Ip"
	echo "Ejemplo: $0 192.168.62.135"
	exit 1
fi

echo "La Ip ingresada es: $ip"

resultado=$(ping -c 1 "$ip")

if [[ $resultado == *"1 received"* ]]; then
	ttl=$(echo "$resultado" | grep -oE "ttl=[0-9]{2,3}" | sed s/"ttl="//g)
	equipo=""
	if [ "$ttl" -gt 0 ]; then
		if [ "$ttl" -le 64 ]; then
			equipo="Linux"
		elif [ "$ttl" -le 128 ]; then
			equipo="Windows"
		else
			equipo="No identificado"
		fi
	else
		echo "ttl incorrecto"
	fi
	echo "El ttl: $ttl -> SO: $equipo"
else
	echo "Ip: $ip no responde"
fi
