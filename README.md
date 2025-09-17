# Kafka Workshop for Beginners

Welcome to the Kafka Workshop! This series is designed for absolute beginners and will guide you through the fundamentals of Apache Kafka using hands-on labs. You do not need to install Kafka or Zookeeper on your computer; all labs use Docker Compose for easy setup.

## What is Apache Kafka?

Apache Kafka is a distributed event streaming platform used for building real-time data pipelines and streaming applications. It is designed to handle high-throughput, fault-tolerant, and scalable messaging between producers (who send data) and consumers (who receive data).

### Key Concepts

- **Broker**: Kafka server that stores and distributes messages.
- **Topic**: A category or feed name to which records are sent.
- **Producer**: Application that sends (publishes) data to topics.
- **Consumer**: Application that reads (subscribes to) data from topics.
- **Zookeeper**: Manages and coordinates Kafka brokers (required for Kafka operation).

## Workshop Structure

- Each lab is in its own directory and contains step-by-step instructions.
- Labs use Docker Compose to run Kafka and related services.
- No prior Kafka experience required.

## Labs Overview

1. **Lab 01: Kafka Basics** – Start Kafka with Docker, send and receive messages.
2. **Lab 02: Multiple Topics** – Create and use multiple topics.
3. **Lab 03: Kafka Streams** – Simple stream processing example.
4. **Lab 04: Kafka Connect** – Connect Kafka to external systems.

Start with Lab 01 and follow the instructions in each lab’s README.
