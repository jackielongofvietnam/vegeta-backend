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
    mv src/modules/$module/repositories/$module.service.ts src/modules/$module/repositories/$module.repository.ts

    sed -i "s/${module^}Service/${module^}Repository/g" src/modules/$module/repositories/$module.repository.ts
    sed -i "s|import { ${module^}Service } from './repositories/$module.service';|import { ${module^}Repository } from './repositories/$module.repository';|" src/modules/$module/$module.module.ts
    sed -i "s|  providers: \[${module^}Service\]|  providers: \[${module^}Service, ${module^}Repository\]|g" src/modules/$module/$module.module.ts

    mkdir -p src/modules/$module/domains/{dtos,types}
done

echo "All modules generated!"
