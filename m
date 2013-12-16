From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/6] iommu/tegra124: smmu: add support platform data
Date: Mon, 16 Dec 2013 13:36:22 -0700
Message-ID: <52AF6446.9030106@wwwdotorg.org>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com> <1386246319-17851-4-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386246319-17851-4-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/05/2013 05:25 AM, Hiroshi Doyu wrote:
> The later Tegra SoC(>= T124) has more registers for
> MC_SMMU_TRANSLATION_ENABLE_*. Now those info is provided as platfrom
> data. If those varies a lot on SoCs in the future, we can consider
> putting them into DT later.

This shouldn't be called "platform data", since that phrase already has
an existing different meaning within Linux. Instead, perhaps
"SoC-specific configuration" or "HW-specific configuration" (or
s/configuration/parameters/).

> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt

>  Required properties in the IOMMU node:
> -- compatible : "nvidia,tegra30-smmu"
> -- reg : Should contain 3 register banks(address and length) for each
> +- compatible : "nvidia,tegra124-smmu", "nvidia,tegra30-smmu"
> +- reg : Can contain multiple register banks(address and length) for each

Not all DTs should include both. I would phrase this as:

- compatible : One of the following:
  - nvidia,tegra30-smmu
  - nvidia,tegra124-smmu

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> +struct smmu_platform_data {
> +	int asids;		/* number of asids */
> +	int nr_xlats;		/* number of translation_enable registers */
> +};

Shouldn't both or neither of those fields be prefixed with "nr_" for
consistency?

> +static const struct smmu_platform_data tegra124_smmu_pdata = {
> +	.asids = 128,
> +	.nr_xlats = 4,
> +};
> +
> +static struct of_device_id tegra_smmu_of_match[] = {
> +	{ .compatible = "nvidia,tegra124-smmu", .data = &tegra124_smmu_pdata, },
> +	{ .compatible = "nvidia,tegra30-smmu", },

Where is tegra30_smmu_pdata, and why doesn't this table entry point at
it? That would avoid conditional code elsewhere.

> @@ -1250,20 +1269,29 @@ static int tegra_smmu_probe(struct platform_device *pdev)

> +	smmu->nr_xlats = nr_xlats;

Why not just:

	smmu->pdata = pdata;

That would avoid having to change this code to copy new fields every
time they get added.
