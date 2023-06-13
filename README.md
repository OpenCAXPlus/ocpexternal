# OpenCAX+ External Template

This is a template repository for external dependencies of the OpenCAX+ projects.

External dependencies are used for both toolkits or starters of the OpenCAX+ SDK.

## Learn how to create the external project for OpenCAX+

Read our tutorial or watch the tutorial video (both coming soon).

## Things that you need to modify

- [ ] This README.md file, also remember to add the workflow badge
- [ ] The workflow yml files, change the name of workflow
- [ ] The ocp.toml file
- [ ] scripts/prepare.sh
- [ ] scripts/install.sh
- [ ] Create any new configurations build and install script in the config folder

## Things you need to check before publish the external project

- [ ] run the prepare.sh script locally, is the external project's source code resides in ocp/external/external_id/version/source?
- [ ] does the ocp/external/external_id/version folder also contains a ocp.toml file and any build configuration folders that you want?
- [ ] run the ocp/external/external_id/version/config/$config.sh script locally, is the build cache files put into ocp/external/external_id/version/build/$config folder, and the install files put into ocp/external/external_id/version/install/$config folder?
- [ ] run the External Build workflow

## Some rules
1. Structure of the compressed source code must be like ocp/external/external_id/version/source, where the source code resides. The ocp.toml file should be copied to ocp/external/external_id/version folder.
2. Must use tar.xz to compress the ocp folder
3. The install script must install compiled software to configuration subdirectory under ocp/external/external_id/version/install folder.

## Folder structure explained
- scripts, useful scripts but won't be included into the distributed compress file.
    - prepare.sh, to prepare the folder structure for external source. It must located in ocp/external/external_id/version/source
    - publish.sh, to xz compress the external source code and publish to OSS bucket. This should only to be used by the OpenCAX+ runner.
    - install.sh, 
- config, contains specific build configuration scripts to install different build configuration of the source code. You must put any build files into a build subfolder, and all install files into the install subfolder.