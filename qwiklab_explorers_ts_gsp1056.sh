gcloud bigtable clusters update sandiego-traffic-sensors-c1 \
--instance=sandiego \
--autoscaling-min-nodes=1 \
--autoscaling-max-nodes=3 \
--autoscaling-cpu-target=60

gcloud bigtable clusters create sandiego-traffic-sensors-c2 --instance=sandiego --zone=$ZONE

gcloud bigtable clusters update sandiego-traffic-sensors-c2 \
--instance=sandiego \
--autoscaling-min-nodes=1 \
--autoscaling-max-nodes=3 \
--autoscaling-cpu-target=60

gcloud bigtable backups create current_conditions_30 --instance=sandiego \
  --cluster=sandiego-traffic-sensors-c1 \
  --table=current_conditions \
  --retention-period=30d 


gcloud bigtable instances tables restore \
--source=projects/$DEVSHELL_PROJECT_ID/instances/sandiego/clusters/sandiego-traffic-sensors-c1/backups/current_conditions_30 \
--async \
--destination=current_conditions_30_restored \
--destination-instance=sandiego \
--project=$DEVSHELL_PROJECT_ID
