From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v7 4/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Tue, 22 Dec 2015 13:57:34 +0800
Message-ID: <1450763854.9235.19.camel@mhfsdcap03>
References: <1450426183-1571-1-git-send-email-yong.wu@mediatek.com>
	 <1450426183-1571-5-git-send-email-yong.wu@mediatek.com>
	 <56744611.3070604@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56744611.3070604-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2015-12-18 at 17:44 +0000, Robin Murphy wrote:
> On 18/12/15 08:09, Yong Wu wrote:
> > This patch adds support for mediatek m4u (MultiMedia Memory Management
> > Unit).
> >
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >   drivers/iommu/Kconfig     |  14 +
> >   drivers/iommu/Makefile    |   1 +
> >   drivers/iommu/mtk_iommu.c | 734 ++++++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 749 insertions(+)
> >   create mode 100644 drivers/iommu/mtk_iommu.c
> >
> 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > new file mode 100644
> > index 0000000..d000d31
> > --- /dev/null
> > +++ b/drivers/iommu/mtk_iommu.c
> 
> [...]
> 
> > +#define REG_MMU_CTRL_REG			0x110
> > +#define F_MMU_PREFETCH_RT_REPLACE_MOD		BIT(4)
> > +#define F_MMU_TF_PROTECT_SEL(prot)		(((prot) & 0x3) << 5)
> > +#define F_COHERENCE_EN				BIT(8)
> 
> [...]
> 
> > +static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
> > +{
> > +	u32 regval;
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(data->bclk);
> > +	if (ret) {
> > +		dev_err(data->dev, "Failed to enable iommu bclk(%d)\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> > +		F_MMU_TF_PROTECT_SEL(2) |
> > +		F_COHERENCE_EN;
> 
> I meant to ask this last time - does setting F_COHERENCE_EN here imply 
> that the M4U is capable of cache-coherent page table walks, or something 
> else? If it's the former, and assuming the MT8173 is actually wired up 
> to support that, then you should add a dma-coherent property to its DT 
> node in patch 5 (which will also save you all the cache flushes on page 
> table updates).

No. F_COHERENCE_EN is not for m4u's cache-coherent page table walking.

More about it: There are two iommu cells in the HW. one is
perisys-iommu, the other is mm-iommu. The perisys-iommu currently is not
contained in this upstream version. it will support this F_COHERENCE_EN
bit which will enable coherence access for the master port if the
sharable(S) bit is set in the pagetable descriptor.
    And in the mm-iommu, the iommu HW will work regardless of this bit.
So I will delete this bit for readable as this is m4u(mm-iommu) in next
time.

> 
> > +	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
> > +
> > +	regval = F_L2_MULIT_HIT_EN |
> > +		F_TABLE_WALK_FAULT_INT_EN |
> > +		F_PREETCH_FIFO_OVERFLOW_INT_EN |
> > +		F_MISS_FIFO_OVERFLOW_INT_EN |
> > +		F_PREFETCH_FIFO_ERR_INT_EN |
> > +		F_MISS_FIFO_ERR_INT_EN;
> > +	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
> > +
> > +	regval = F_INT_TRANSLATION_FAULT |
> > +		F_INT_MAIN_MULTI_HIT_FAULT |
> > +		F_INT_INVALID_PA_FAULT |
> > +		F_INT_ENTRY_REPLACEMENT_FAULT |
> > +		F_INT_TLB_MISS_FAULT |
> > +		F_INT_MISS_TRANSATION_FIFO_FAULT |
> > +		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
> > +	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
> > +
> > +	regval = F_MMU_IVRP_PA_SET(data->protect_base);
> > +	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
> > +
> > +	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
> > +	writel_relaxed(0, data->base + REG_MMU_STANDARD_AXI_MODE);
> > +
> > +	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> > +			     dev_name(data->dev), (void *)data)) {
> > +		writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
> > +		clk_disable_unprepare(data->bclk);
> > +		dev_err(data->dev, "Failed @ IRQ-%d Request\n", data->irq);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Otherwise, I've not had the chance to go through this thoroughly but at 
> a glance it seems in pretty good shape now - nothing immediately jumps 
> out as looking wrong or worth making a fuss over.
> 
> Thanks,
> Robin.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
