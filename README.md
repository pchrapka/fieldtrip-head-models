# fieldtrip-head-models
Scripts to create head models in fieldtrip

## Setup

Clone the repo

```bash
cd projects
git clone https://github.com/pchrapka/fieldtrip-head-models.git
```

Download the MRI data from Fieldtrip's site

	```bash
	./setup.sh
	```
	
## Usage
	
Open up Matlab and set up the environment

	```matlab
	cd projects/fieldtrip-head-models
	startup
	```
	
Create a head model

	```matlab
	script_head_model_elec256_openmeeg
	```

