From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Fri, 5 Jun 2015 14:30:41 +0100
Message-ID: <20150605133040.GH1198@arm.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
 <1431683009-18158-6-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431683009-18158-6-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, mitchelh-sgV2jX0FEOJiIJoWrK/4GQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, May 15, 2015 at 10:43:28AM +0100, Yong Wu wrote:
> This patch adds support for mediatek m4u (MultiMedia Memory Management Unit).

After looking at the page table code, I thought I'd come and check your
TLB invalidate code here.

> +static void mtk_iommu_tlb_flush_all(void *cookie)
> +{
> +       struct mtk_iommu_domain *domain = cookie;
> +       u32 val;
> +
> +       val = F_INVLD_EN1 | F_INVLD_EN0;
> +       writel(val, domain->imuinfo->base + REG_MMU_INV_SEL);
> +       writel(F_ALL_INVLD, domain->imuinfo->base + REG_MMU_INVALIDATE);
> +}
> +
> +static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
> +                                   bool leaf, void *cookie)
> +{
> +       struct mtk_iommu_domain *domain = cookie;
> +       void __iomem *m4u_base = domain->imuinfo->base;
> +       unsigned int iova_start = iova, iova_end = iova + size - 1;
> +       int ret;
> +       u32 val;
> +
> +       val = F_INVLD_EN1 | F_INVLD_EN0;
> +       writel(val, m4u_base + REG_MMU_INV_SEL);
> +
> +       writel(iova_start, m4u_base + REG_MMU_INVLD_START_A);
> +       writel(iova_end, m4u_base + REG_MMU_INVLD_END_A);
> +       writel(F_MMU_INV_RANGE, m4u_base + REG_MMU_INVALIDATE);
> +
> +       ret = readl_poll_timeout_atomic(m4u_base + REG_MMU_CPE_DONE, val,
> +                                       val != 0, 10, 1000000);
> +       if (ret) {
> +               dev_warn(domain->imuinfo->dev, "Invalid tlb don't done\n");
> +               mtk_iommu_tlb_flush_all(cookie);
> +       }
> +       writel(0, m4u_base + REG_MMU_CPE_DONE);
> +}

You don't need to wait for completion here if you can implement a proper
->tlb_sync callback.

> +static void mtk_iommu_flush_pgtable(void *ptr, size_t size, void *cookie)
> +{
> +       /*
> +        * After delete arch_setup_dma_ops,
> +        * This will be replaced with dma_map_page
> +        */
> +        __dma_flush_range(ptr, ptr + size);
> +}

This should give you the necessary barriers to ensure visibility of the
updated page tables, so you can use the _relaxed io accessors for the
other TLB functions.

> +static struct iommu_gather_ops mtk_iommu_gather_ops = {
> +       .tlb_flush_all = mtk_iommu_tlb_flush_all,
> +       .tlb_add_flush = mtk_iommu_tlb_add_flush,
> +       .tlb_sync = mtk_iommu_tlb_flush_all,

sync isn't required to flush anything; it's just supposed to wait for
any outstanding invalidation (i.e. from tlb_add_flush) to complete.

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
