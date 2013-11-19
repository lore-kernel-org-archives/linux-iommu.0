From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCHv5 4/9] iommu/tegra: smmu: register device to iommu dynamically
Date: Tue, 19 Nov 2013 14:39:54 -0700
Message-ID: <528BDAAA.4000203@wwwdotorg.org>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com> <1384853593-32202-5-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384853593-32202-5-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/19/2013 02:33 AM, Hiroshi Doyu wrote:
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

> +static int smmu_iommu_add_device(struct device *dev)
> +{
> +	int err = -EPROBE_DEFER;
> +	u32 swgroups = dev->platform_data;
> +	struct dma_iommu_mapping *map = NULL;
> +
> +	if (test_bit(TEGRA_SWGROUP_PPCS, swgroups))
> +		map = smmu_handle->map[SYSTEM_PROTECTED];
> +	else
> +		map = smmu_handle->map[SYSTEM_DEFAULT];
> +
> +	if (map)
> +		err = arm_iommu_attach_device(dev, map);
> +	else
> +		return -EPROBE_DEFER;

Given that patch 2 exists, if this test fails, then surely the
appropriate error code is some fatal error, not -EPROBE_DEFER; any
deferrals should have happened long before this point.
