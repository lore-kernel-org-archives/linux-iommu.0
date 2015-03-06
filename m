From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Fri, 06 Mar 2015 09:15:17 -0800
Message-ID: <vnkwwq2unj2y.fsf@mitchelh-linux.qualcomm.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425638900-24989-3-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> (yong
	wu's message of "Fri, 6 Mar 2015 18:48:17 +0800")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 06 2015 at 02:48:17 AM, <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>
> This patch adds support for mediatek m4u (MultiMedia Memory Management Unit).
> Currently this only supports m4u gen 2 with 2 levels of page table on mt8173.

[...]

> +static int mtk_iommu_invalidate_tlb(const struct mtk_iommu_info *piommu,
> +				    int isinvall, unsigned int iova_start,
> +				    unsigned int iova_end)
> +{
> +	void __iomem *m4u_base = piommu->m4u_base;
> +	u32 val;
> +	u64 start, end;
> +
> +	start = sched_clock();
> +
> +	if (!isinvall) {
> +		iova_start = round_down(iova_start, SZ_4K);
> +		iova_end = round_up(iova_end, SZ_4K);
> +	}
> +
> +	val = F_MMU_INV_EN_L2 | F_MMU_INV_EN_L1;
> +
> +	writel(val, m4u_base + REG_INVLID_SEL);
> +
> +	if (isinvall) {
> +		writel(F_MMU_INV_ALL, m4u_base + REG_MMU_INVLD);
> +	} else {
> +		writel(iova_start, m4u_base + REG_MMU_INVLD_SA);
> +		writel(iova_end, m4u_base + REG_MMU_INVLD_EA);
> +		writel(F_MMU_INV_RANGE, m4u_base + REG_MMU_INVLD);
> +
> +		while (!readl(m4u_base + REG_MMU_CPE_DONE)) {
> +			end = sched_clock();
> +			if (end - start >= 100000000ULL) {
> +				dev_warn(piommu->dev, "invalid don't done\n");
> +				writel(F_MMU_INV_ALL, m4u_base + REG_MMU_INVLD);
> +			}
> +		};

Superfluous `;'.  Also, maybe you should be using readl_poll_timeout?

> +		writel(0, m4u_base + REG_MMU_CPE_DONE);
> +	}
> +
> +	return 0;
> +}



-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
