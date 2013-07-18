From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 15/22] iommu/tegra: smmu: Calculate ASID register offset
 by ID
Date: Thu, 18 Jul 2013 14:18:34 -0600
Message-ID: <51E84D9A.2080507@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com> <1373021097-32420-16-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373021097-32420-16-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Calculate ASID register offset by ID so that we can get rid of SoC
> specific MACROs. This is needed for the unified SMMU driver over Tegra
> SoCs.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

> -#define HWGRP_ASID_REG(x) (smmu_hwgrp_asid_reg[x])
> +#define HWGRP_ASID_REG(x) ((x) * sizeof(u32) + SMMU_AFI_ASID)

I think this removes the last use of smmu_hwgrp_asid_reg[]. Don't you
want to delete that in this patch?
