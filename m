From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv4 3/7] iommu/tegra: smmu: Register IOMMU'able devices
 dynamically
Date: Tue, 12 Nov 2013 16:53:17 -0700
Message-ID: <5282BF6D.8070801@wwwdotorg.org>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com> <1384158718-4756-4-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384158718-4756-4-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/11/2013 01:31 AM, Hiroshi Doyu wrote:
> platform_devices are registered as IOMMU'able dynamically via
> add_device() and remove_device().
> 
> Tegra SMMU can have multiple address spaces(AS). IOMMU'able devices
> can belong to one of them. Multiple IOVA maps are created at boot-up,
> which can be attached to devices later. We reserve 2 of them for
> static assignment, AS[0] for system default, AS[1] for AHB clusters as
> protected domain from others, where there are many traditional
> pheripheral devices like USB, SD/MMC. They should be isolated from
> some smart devices like host1x for system robustness. Even if smart
> devices behaves wrongly, the traditional devices(SD/MMC, USB) wouldn't
> be affected, and the system could continue most likely. DMA API(ARM)
> needs ARM_DMA_USE_IOMMU to be enabled.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> +enum {
> +	SYSTEM_DEFAULT,
> +	SYSTEM_PROTECTED,
> +};
> +
...
> +static int smmu_iommu_add_device(struct device *dev)
...
> +	switch (swgroups) {
> +	case TEGRA_SWGROUP_BIT(PPCS):
> +		map = smmu_handle->map[SYSTEM_PROTECTED];
> +		break;
> +	default:
> +		map = smmu_handle->map[SYSTEM_DEFAULT];
> +		break;
> +	}

As I think I mentioned before, this hard-codes some valid ASIDs.
However, the number of valid ASIDs is configured dynamically from DT, in
tegra_smmu_probe(), via:

static int tegra_smmu_probe(struct platform_device *pdev)
...
        int i, asids, err = 0;
...
        if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
                return -ENODEV;
...
        smmu->num_as = asids;

Shouldn't tegra_smmu_probe() validate that asids >= SYSTEM_PROTECTED, or
similar?
