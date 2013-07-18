From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 21/22] iommu/tegra: smmu: Support Multiple ASID
Date: Thu, 18 Jul 2013 14:43:06 -0600
Message-ID: <51E8535A.30605@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com> <1373021097-32420-22-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373021097-32420-22-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Support Multiple Address Space(AS). Tegra SMMU can have multiple
> ASes. We reserve 2 of them for static assignment, AS[0] for system
> default, AS[1] for AHB clusters as protected domain from others, where
> there are many traditional pheripheral devices like USB, SD/MMC. They
> should be isolated from some smart devices like host1x for system
> robustness. Even if smart devices behaves wrongly, the traditional
> devices(SD/MMC, USB) wouldn't be affected, and the system could
> continue most likely.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  static int smmu_iommu_add_device(struct device *dev)
>  {
>  	int err;
> -	struct dma_iommu_mapping *map = smmu_handle->map[SYSTEM_DEFAULT];
> +	u64 swgroup;
> +	struct dma_iommu_mapping *map = NULL;
> +
> +	swgroup = smmu_of_get_memory_client(dev);
> +	switch (swgroup) {
> +	case TEGRA_SWGROUP_BIT(PPCS):
> +		map = smmu_handle->map[SYSTEM_PROTECTED];
> +		break;
> +	default:
> +		map = smmu_handle->map[SYSTEM_DEFAULT];

I already mentioned this, but just for completeness: What is
smmu->num_as <= SYSTEM_DEFAULT?
