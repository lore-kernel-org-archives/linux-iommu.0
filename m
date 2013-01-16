From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 4/6] iommu/tegra: smmu: Support variable MMIO range
Date: Wed, 16 Jan 2013 14:12:24 -0700
Message-ID: <50F717B8.6050800@wwwdotorg.org>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com> <1358237848-968-4-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358237848-968-4-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 01/15/2013 01:17 AM, Hiroshi Doyu wrote:
> There are 3 SMMU MMIO register blocks. They may get bigger as new
> Tegra SoC comes. This patch enables to support variable size of those
> register blocks.

Why would the register blocks move around? In the HW, there's one single
chunk of memory containing all the SMMU registers, and we simply carve
out a few holes since some unrelated registers are stuck in the middle,
thus leaving us with 3 register ranges. If the size of those carved out
chunks changes, then doesn't that mean all the registers moved around
within the single chunk, and hence all the register offsets in the
driver become invalid?

It may help if you provide an explicit example of what the register
layout change is...

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  static inline u32 smmu_read(struct smmu_device *smmu, size_t offs)
>  {
>  	BUG_ON(offs < 0x10);
> -	if (offs < 0x3c)
> +	if (offs < 0x10 + smmu->regsz[0])
>  		return readl(smmu->regs[0] + offs - 0x10);
>  	BUG_ON(offs < 0x1f0);
> -	if (offs < 0x200)
> +	if (offs < 0x1f0 + smmu->regsz[1])

Wouldn't you need to adjust that BUG_ON() in a similar way to how the if
condition was adjusted?
