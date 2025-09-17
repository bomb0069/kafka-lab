# Lab 01: Kafka Basics

In this lab, you will start Kafka and Zookeeper using Docker Compose, create a topic, and send/receive messages using command-line tools.

## Prerequisites

- Docker and Docker Compose installed (no Kafka installation needed)

## Steps

### 1. Start Kafka and Zookeeper

Run the following command in this directory:

```sh
docker compose up -d
```

### 2. Create a Kafka Topic

```sh
docker exec lab-01-kafka-basics-kafka-1 kafka-topics.sh --create --topic test-topic --bootstrap-server localhost:9092
```

### 3. Send Messages (Producer)

```sh
docker exec -it lab-01-kafka-basics-kafka-1 kafka-console-producer.sh --topic test-topic --bootstrap-server localhost:9092
```

Type a few messages and press Enter after each. Press Ctrl+C to exit.

**Alternative: Send a message from a file:**

```sh
echo "Hello Kafka!" | docker exec -i lab-01-kafka-basics-kafka-1 kafka-console-producer.sh --topic test-topic --bootstrap-server localhost:9092
```

### 4. Receive Messages (Consumer)

Open a new terminal and run:

```sh
docker exec -it lab-01-kafka-basics-kafka-1 kafka-console-consumer.sh --topic test-topic --bootstrap-server localhost:9092 --from-beginning
```

**Alternative: Read a limited number of messages:**

```sh
docker exec lab-01-kafka-basics-kafka-1 kafka-console-consumer.sh --topic test-topic --bootstrap-server localhost:9092 --from-beginning --max-messages 5
```

You should see the messages you sent in step 3.

---

## Clean Up

To stop and remove containers:

```sh
docker compose down
```
