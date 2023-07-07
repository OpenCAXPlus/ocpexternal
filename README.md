# OpenCAX+ External Template

This is a template repository for external dependencies of the OpenCAX+ projects.

External dependencies are used for both toolkits or starters of the OpenCAX+ SDK.

## Learn how to create the external project for OpenCAX+

Read our tutorial or watch the tutorial video (both coming soon).

## Things that you need to modify

- [ ] This README.md file, also remember to add the workflow badge
- [ ] The workflow yml files, change the name of workflow
- [ ] The ocp.yml file
- [ ] scripts/prepare.sh
- [ ] scripts/install.sh
- [ ] Create any new configurations build and install script in the config folder

## Things you need to check before publish the external project

- [ ] run the prepare.sh script locally, is the external project's source code resides in ocp/external/external_id/version/source?
- [ ] does the ocp/external/external_id/version folder also contains a ocp.yml file and any build configuration folders that you want?
- [ ] run the ocp/external/external_id/version/config/$config.sh script locally, is the build cache files put into ocp/external/external_id/version/build/$config folder, and the install files put into ocp/external/external_id/version/install/$config folder?
- [ ] run the External Build workflow

## Some rules
### For external projects
1. Structure of the compressed source code must be resides in ocp/external/external_id/version/source. The ocp.yml file should be copied to ocp/external/external_id/version folder.
2. Must use tar.xz to compress the ocp folder
3. The install script must install compiled software to configuration subdirectory under ocp/external/external_id/version/install folder.

### For developers
1. You should create a release and tag once a new version or configuration of the external project is added.
2. You should be aware that scripts maybe used by multiple versions and configurations, so be careful when you modify any existing scripts. 

## Folder structure explained
- scripts, useful scripts but won't be included into the distributed compress file.
    - prepare.sh, to prepare the folder structure for external source. It must located in ocp/external/external_id/version/source
    - publish.sh, to xz compress the external source code and publish to OSS bucket. This should only to be used by the OpenCAX+ runner.
    - install.sh, 
- configurations, contains specific build configuration scripts to install different build configuration of the source code. You must put any build files into a build subfolder, and all install files into the install subfolder.

## The ocp.yml file

Here we will try to demystify the following ocp.yml file so that you can start to modify it yourself.

```yml
name: external_name # name for the external library, to help human recognize the external project
uid: external_id # the unique identifier for the program the find the external project, you must make sure its value is different from any existing ids in the packages.yml file in OCP repo
type: external # the current project type, could be external or toolkit, or starter
licenses: ["MIT","GPL"] # the external project's licenses
default: # set some default values
  version: "1.0.0" # the default version to be installed if not specified in the command
  configuration: "build" # the default config if not specified 
  scripts: {prepare: prepare, publish: publish, check: check} # some scripts that you can run 
  dependencies: ["dep1"]
versions: # list of all versions, to make this easier for human to read there should be no hidden parts for each item
  - id: "1.0.0" # the version number this will be used in the tar.xz file's name
    default: "build" # override the default configurations
    scripts: {prepare: prepare, publish: publish, check: check} # override the default scripts
    configurations: ["build","new_build"]
  - id: "2.0.0" # if nothing is specified, then the scripts, and configurations value will be taken from default part
scripts: # some scripts that developers may run
  - id: prepare # id is used as a reference for others to find this script
    run: scripts/prepare # run gives you the script to run (without extension)
  - id: publish
    run : scripts/publish
  - id: check
    run: scripts/check
dependencies: # some dependencies that will be later referred by the configurations
  - id: dep1 # id is how the dependencies can be later referred
    uid: dep # uid is the unique identifier that we use to locate the tar.xz file 
    type: external #
    versions: # multiple version may be allowed
      - id : "1.0.0" # this id is the same as the id in the dependency's ocp.yml file versions part
        default: "build1" # set a default config, if it is not specified
        configurations: ["build1","build2"] # these are the configuration id of the external uid
      - id : "2.0.0" # with no default and configurations, the value from dep's ocp.yml file will be used
configurations: # list of configs that is referred in by the versions
  - id: "build1" # if no dependencies are listed, then use the default value
    run: configurations/build1 # must have a run to specify which script to run
  - id: "build2" # this is the config id that is referred in the versions section
    run: configurations/build2
    dependencies: ["dep1","dep2"] # override the default dependencies
```