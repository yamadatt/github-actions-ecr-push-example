locals {
  container_name = "apache-helloworld"
}

resource "aws_ecs_cluster" "main" {
  name = "h4b-ecs-cluster"
}

resource "aws_ecs_task_definition" "main" {
  family                   = "h4b-ecs-task-definition"
  cpu                      = 512
  memory                   = 1024
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  container_definitions    = <<-EOS
  [
    {
        "name": "${local.container_name}",
        "image": "${aws_ecr_repository.main.repository_url}:latest",
        "cpu": 0,
        "portMappings": [
            {
                "name": "${local.container_name}",
                "containerPort": 80,
                "hostPort": 80,
                "protocol": "tcp",
                "appProtocol": "http"
            }
        ],
        "essential": true,
        "environment": [],
        "environmentFiles": [],
        "mountPoints": [],
        "volumesFrom": [],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-create-group": "true",
                "awslogs-group": "/ecs/h4b-ecs-task-definition",
                "awslogs-region": "ap-northeast-1",
                "awslogs-stream-prefix": "ecs"
            }
        }
    }
  ]
  EOS
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
}

resource "aws_ecs_service" "main" {
  name            = "h4b-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  launch_type     = "FARGATE"
  desired_count   = 2
  network_configuration {
    subnets = [
      aws_subnet.public1.id,
      aws_subnet.public2.id
    ]
    security_groups = [
      aws_default_security_group.default.id
    ]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = local.container_name
    container_port   = 80
  }
}