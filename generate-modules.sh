#!/bin/bash

# Define an array of module names
modules=("order" "product" "payment" "delivery")

# Loop through each module
for module in "${modules[@]}"; do
  echo "Generating module: $module"
  
  # Generate the module, controller, services, and repositories
  nest generate module modules/$module
  nest generate controller modules/$module/controllers/$module --no-spec --flat
  nest generate service modules/$module/services/$module --no-spec --flat
  nest generate service modules/$module/repositories/$module --no-spec --flat
done

echo "All modules generated!"
