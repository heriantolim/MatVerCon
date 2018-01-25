# MatlabVerCon
A simple version control system for MATLAB development.

## Licensing
This software is licensed under the GNU General Public License (version 3).

## Setting Up
1. Put the `.m` files in the default working directory of your MATLAB.
2. Edit [librarypath.m](/librarypath.m). Change the username and the library path as instructed in the comments.
3. Structure your package library as follows:

```
Packages             -> The folder pointed by librarypath
|
├───PackageA         -> A folder with name corresponding to the name of the package
│   ├───v1.0.0
│   │   └───Files    -> The files and folders belonging to version 1.0.0 of PackageA
│   ├───v1.2.3
│   │   └───Files    -> The files and folders belonging to version 1.2.3 of PackageA
│   └───v3.1.6
│       └───Files    -> The files and folders belonging to version 3.1.6 of PackageA
|
├───PackageB         -> A folder with name corresponding to the name of the package
│   ├───v2.11.1
│   │   └───Files    -> The files and folders belonging to version 2.11.1 of PackageB
│   └───v4.7.13
│       └───Files    -> The files and folders belonging to version 4.7.13 of PackageB
...
```

4. Ensure that the version numbering follows the [semantic format](https://semver.org/): `major`.`minor`.`patch`.

## Usage
The term *add* in the following means adding the directories and sub-directories of the specified packages into the MATLAB's search path. The term *remove* means removing the directories and sub-directories from the search path.

### Adding Packages
To add the latest version of a package named `PackageA`, call:
```
addpackage('PackageA')
```

To add the version 1.2.3 of `PackageA`, call:
```
addpackage('PackageA_v1.2.3')
```

To add many packages together, call, for example:
```
addpackage('PackageA','PackageB_v2.11.1','PackageC_v12.8.2')
```

Adding a package will always remove all other versions of the same package, if it has been previously added.

### Removing Packages
To remove all added packages, call:
```
rmpackage()
```

To remove any version of `PackageA`, call:
```
rmpackage('PackageA')
```

To remove the version 1.2.3 of `PackageA`, call:
```
rmpackage('PackageA_v1.2.3')
```

To remove multiple packages together, call, for example:
```
rmpackage('PackageA','PackageB_v2.11.1','PackageC_v12.8.2')
```
