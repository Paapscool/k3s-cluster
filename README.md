# k3s-cluster

This repository define a minimalist and robustnest infrastructure to deploy your services. What is minimalist and robustnest ?

- Minimalist for scalabilty extension and low cost pricing
- Robustnest for resiliant and redondant environment

Here, you will find all things i was need to build my infrastructure. All installation is scripted for fast reset if need.

> :warning: **It's very important to keep in mind that scripts are configured for my current context**. Same if scripts are variabilized, you should attentive read them for validate each point and update them according from your own context.
> :warning: **Don't hesite to challenge solutions**. For example, i choise OVH to host any servers for pricing and quality reasons, but you can choose any other host.

## Setup Hardwares

-- IN PROGRESS --

Configure your hardware to install kube node (main or secondary) depends on your needs.

Go to [Hardware documentation](./hardware/README.md)

## Setup Nodes

Install and configure your nodes with k3s.

Go to [K3S documentation](./k3s/README.md)

## Contributing

&nbsp;:grey_exclamation:&nbsp; Use issues for everything

Read more informations with the [CONTRIBUTING_GUIDE](./.github/CONTRIBUTING.md)

For all changes, please update the CHANGELOG.txt file by replacing the existant content.

Thank you &nbsp;:pray:&nbsp;&nbsp;:+1:&nbsp;

## Licence

[MIT](https://github.com/Paapscool/k3s-cluster/blob/main/LICENSE)
