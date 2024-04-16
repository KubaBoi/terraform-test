/*
 data source is some kind of package which contains
 read-only data

 in this case it contains default data from aws
 about VPC (Virtual Private Cloud)
 */
data "aws_vpc" "default" {
  default = true
}

/*
  this is data source containing data about subnets
  from bigger data source VPC defined above
 */
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}