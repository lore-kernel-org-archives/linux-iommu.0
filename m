From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 19/22] iommu/tegra: smmu: Workaround PCIe IOMMU'able
Date: Thu, 18 Jul 2013 14:33:02 -0600
Message-ID: <51E850FE.4000506@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com> <1373021097-32420-20-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373021097-32420-20-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Make PCIe work as it is. IOMMU support can be implemented later. We
> need the same kind of registration framework for PCIe as platform_bus
> does currently.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  	for_each_set_bit(i, (unsigned long *)&map,
>  			 sizeof(map) * BITS_PER_BYTE) {
> +		if (i == TEGRA_SWGROUP_AFI) /* FIXME: IOMMU'able PCIe */
> +			continue;

Isn't it just a fluke that TEGRA_SWGROUP_AFI is defined identically for
the SoCs that we support upstream?

If this change is required, don't we need it before the SMMU starts
enabling itself for clients, so that git bisect is maintained?

By deferring the question of registering the IOMMU for PCIe, ar we going
to require non-backwards-compatible changes to DT for the PCIe
controller at some later point in time?
