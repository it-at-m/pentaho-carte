<!-- PROJECT SHIELDS -->

[![Contributors][contributors-shield]][contributors-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![GitHub Workflow Status][github-workflow-status]][github-workflow-status-url]
[![GitHub release (latest SemVer)][release-shield]][release-url]

# pentaho-carte

**pentaho-carte** provides a Pentaho Data Integration installation and starts the Pentaho Carte Server.

We create our own PDI Carte Server image because [Hitachi Vantara doesn’t provide an out of the box container image.](https://community.hitachivantara.com/blogs/archive-user/2021/09/09/pentaho-data-integration-on-kubernetes)

Current supported Pentaho Version: 9.3.0.0-428

## Documentation

For a detailed documentation auf Pentaho Data Integration see [Pentaho Community Wiki](https://pentaho-public.atlassian.net/wiki/spaces/EAI/overview).

### Running as a container (standalone)

You can use the provided official Docker image [itatm/pentaho-carte](https://github.com/it-at-m/pentaho-carte/pkgs/container/pentaho-carte) to run **pentaho-carte** as a standalone application.

```sh
docker run -d -p 8080:8080 --env=PENTAHO_USER=cluster --env=PENTAHO_PASSWORD=cluster --name pentaho-carte ghcr.io/it-at-m/pentaho-carte:0.0.2
```

Use Pentaho Carte Server's  [default user and password](https://pentaho-public.atlassian.net/wiki/spaces/EAI/pages/372704158/Carte+User+Documentation#CarteUserDocumentation-Security) to gain control. 

### Deploying on Kubernetes using a Helm chart

If you want to deploy pentaho-carte on a Kubernetes cluster, you can use the [provided Helm chart][helm-chart-github].

### Configuration

pentaho-carte doesn't use any environment variables.

#### Change Pentaho Carte Server's username and password

To change the Pentaho Carte Server's username and password follow these steps:

1. Create a file named `kettle.pwd` which contains Pentaho Carte Server's username and password. Please consult [Carte User Documentation](https://pentaho-public.atlassian.net/wiki/spaces/EAI/pages/372704158/Carte+User+Documentation#CarteUserDocumentation-Security) how to configure `kettle.pwd`.
2. Copy (see [docker cp](https://docs.docker.com/reference/cli/docker/container/cp/) command) `kettle.pwd` to location
   `/home/default/pentaho/data-integration/.kettle/kettle.pwd`, e.g.: <br/><br/>
```docker cp kettle.pwd pentaho-carte:/home/default/pentaho/data-integration/.kettle/kettle.pwd```<br/><br/>
3. Restart pentaho-carte

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please open an issue with the tag "enhancement", fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Open an issue with the tag "enhancement"
2. Fork the Project
3. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
4. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
5. Push to the Branch (`git push origin feature/AmazingFeature`)
6. Open a Pull Request

We use [itm-java-codeformat](https://github.com/it-at-m/itm-java-codeformat), so please make sure to apply the correct code format for your contributions.

## License

Distributed under the MIT License. See [LICENSE](LICENSE) file for more information.

## Contact

it@M - opensource@muenchen.de

[contributors-shield]: https://img.shields.io/github/contributors/it-at-m/pentaho-carte.svg?style=for-the-badge
[contributors-url]: https://github.com/it-at-m/pentaho-carte/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/it-at-m/pentaho-carte.svg?style=for-the-badge
[forks-url]: https://github.com/it-at-m/pentaho-carte/network/members
[stars-shield]: https://img.shields.io/github/stars/it-at-m/pentaho-carte.svg?style=for-the-badge
[stars-url]: https://github.com/it-at-m/pentaho-carte/stargazers
[issues-shield]: https://img.shields.io/github/issues/it-at-m/pentaho-carte.svg?style=for-the-badge
[issues-url]: https://github.com/it-at-m/pentaho-carte/issues
[license-shield]: https://img.shields.io/github/license/it-at-m/pentaho-carte.svg?style=for-the-badge
[license-url]: https://github.com/it-at-m/pentaho-carte/blob/main/LICENSE
[github-workflow-status]: https://img.shields.io/github/actions/workflow/status/it-at-m/pentaho-carte/build.yaml?style=for-the-badge
[github-workflow-status-url]: https://github.com/it-at-m/pentaho-carte/actions/workflows/build.yaml
[release-shield]: https://img.shields.io/github/v/release/it-at-m/pentaho-carte?sort=semver&style=for-the-badge
[release-url]: https://github.com/it-at-m/pentaho-carte/releases
[helm-chart-github]: https://artifacthub.io/packages/helm/it-at-m/pentaho-carte