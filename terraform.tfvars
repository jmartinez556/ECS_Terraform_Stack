region             = "us-east-1"
ami                = "ami-0f06fc190dd71269e"
instance_type      = "t2.micro"
key_name           = "Justin-us-east-1"
availability_zone1 = "us-east-1c"
availability_zone2 = "us-east-1b"
desired_capacity   = 2
max_size           = 4
min_size           = 1
load_balancer_name = "load_balance_21"
domain             = "justin.kiastests.com"
container_name     = "sample-app"
container_port     = 3000
//container_image    = "054642084504.dkr.ecr.us-east-1.amazonaws.com/justin_node_app:latest"
hosted_zone_id     = "Z00325031522O9P8IPI0"
subdomain          = "test2"