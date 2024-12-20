// Copyright (c) 2019 Nineva Studios

#include "MqttClientImpl.h"
#include "MqttRunnable.h"
#include "IMqttUtilitiesModule.h"

MqttClientImpl::MqttClientImpl(const char * id) : mosqpp::mosquittopp(id)
{
}

MqttClientImpl::~MqttClientImpl()
{
}

void MqttClientImpl::on_connect(int rc)
{
	if (rc != 0)
	{
		return;
	}

	UE_LOG(LogMQTT, Log, TEXT("Impl: Connected"));

	Task->OnConnect();
}

void MqttClientImpl::on_disconnect(int rc)
{
	if (rc != 0)
	{
		return;
	}

	UE_LOG(LogMQTT, Log, TEXT("Impl: Disconnected"));
	
	Task->OnDisconnect();
}

void MqttClientImpl::on_publish(int mid)
{
	//UE_LOG(LogMQTT, Log, TEXT("Impl: Mesage published"));

	Task->OnPublished(mid);
}

void MqttClientImpl::on_message(const mosquitto_message * src)
{
	//UE_LOG(LogMQTT, Log, TEXT("Impl: Message received"));

	FMqttMessage msg;

	msg.Topic = FString(src->topic);
	msg.Qos = src->qos;
	msg.Retain = src->retain;
	int PayloadLength = src->payloadlen;

	void* buffer = malloc(PayloadLength + 1);
	((char*)buffer)[PayloadLength] = 0;

	if (buffer != NULL) 
	{
		memcpy(buffer, src->payload, PayloadLength);
	}

	msg.Message = FString(UTF8_TO_TCHAR(buffer));

	free(buffer);

	Task->OnMessage(msg);
}

void MqttClientImpl::on_subscribe(int mid, int qos_count, const int * granted_qos)
{
	UE_LOG(LogMQTT, Log, TEXT("Impl: Subscribed"));

	TArray<int> qos;

	for (auto p = granted_qos; p < granted_qos + qos_count; ++p)
	{
		qos.Add(*p);
	}

	Task->OnSubscribe(mid, qos);
}

void MqttClientImpl::on_unsubscribe(int mid)
{
	UE_LOG(LogMQTT, Log, TEXT("Impl: Unsubscribed"));

	Task->OnUnsubscribe(mid);
}