## Reference: https://dev.to/mariehposa/managing-aws-eks-with-terraform-4ma8

# This will create a node group that will scale between 1 to 3 nodes.
# Define an EKS node group, which is a set of EC2 instances (worker nodes) that run the Kubernetes workloads.
#The node group can scale between 1 and 3 nodes, depending on your workload's demand.

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.eks_role.arn
  subnet_ids      = aws_subnet.eks_subnet[*].id


  scaling_config {
    desired_size = 2  # Initial number of nodes
    max_size     = 3  # Maximum number of nodes
    min_size     = 1  # Minimum number of nodes
  }

  instance_types = ["t3.medium"] # Type of EC2 instances for worker nodes
}
