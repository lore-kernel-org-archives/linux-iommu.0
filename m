From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Wed, 29 Jul 2015 14:32:50 +0800
Message-ID: <1438151570.25925.121.camel@mhfsdcap03>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
	 <1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
	 <55B630CE.4050803@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B630CE.4050803-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arn>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-07-27 at 14:23 +0100, Robin Murphy wrote:
> On 16/07/15 10:04, Yong Wu wrote:
> > This patch adds support for mediatek m4u (MultiMedia Memory Management
> > Unit).
> >
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> [...]
> > +static void mtk_iommu_flush_pgtable(void *ptr, size_t size, void *cookie)
> > +{
> > +       struct mtk_iommu_domain *domain = cookie;
> > +       unsigned long offset = (unsigned long)ptr & ~PAGE_MASK;
> > +
> > +       dma_map_page(domain->data->dev, virt_to_page(ptr), offset,
> > +                    size, DMA_TO_DEVICE);
> 
> Nit: this looks like it may as well be dma_map_single.
> 
> It would probably be worth following it with a matching unmap too, just 
> to avoid any possible leakage bugs (especially if this M4U ever appears 
> in a SoC supporting RAM above the 32-bit boundary).

About the map, I will read and try to follow your patch:
iommu/io-pgtable-arm: Allow appropriate DMA API use.

> 
>  > +}
>  > +
> [...]
> > +static int mtk_iommu_parse_dt(struct platform_device *pdev,
> > +                             struct mtk_iommu_data *data)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct device_node *ofnode;
> > +       struct resource *res;
> > +       int i;
> > +
> > +       ofnode = dev->of_node;
> > +
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       data->base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(data->base))
> > +               return PTR_ERR(data->base);
> > +
> > +       data->irq = platform_get_irq(pdev, 0);
> > +       if (data->irq < 0)
> > +               return data->irq;
> > +
> > +       data->bclk = devm_clk_get(dev, "bclk");
> > +       if (IS_ERR(data->bclk))
> > +               return PTR_ERR(data->bclk);
> > +
> > +       data->larb_nr = of_count_phandle_with_args(
> > +                                       ofnode, "mediatek,larb", NULL);
> > +       if (data->larb_nr < 0)
> > +               return data->larb_nr;
> > +
> > +       for (i = 0; i < data->larb_nr; i++) {
> > +               struct device_node *larbnode;
> > +               struct platform_device *plarbdev;
> > +
> > +               larbnode = of_parse_phandle(ofnode, "mediatek,larb", i);
> > +               if (!larbnode)
> > +                       return -EINVAL;
> > +
> > +               plarbdev = of_find_device_by_node(larbnode);
> > +               of_node_put(larbnode);
> > +               if (!plarbdev)
> > +                       return -EPROBE_DEFER;
> > +               data->larbdev[i] = &plarbdev->dev;
> > +       }
> 
> At a glance this seems like a job for of_parse_phandle_with_args, but I 
> may be missing something subtle.

It seems We can not use of_parse_phandle_with_args here.

The node of larb is.
//=========
larb0: larb@14021000 {
	compatible = "mediatek,mt8173-smi-larb";
	reg = <0 0x14021000 0 0x1000>;
	mediatek,smi = <&smi_common>;	
	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
	clocks = <&mmsys CLK_MM_SMI_LARB0>,
		 <&mmsys CLK_MM_SMI_LARB0>;
	clock-names = "apb", "smi";
};
//==========
  of_parse_phandle_with_args(ofnode,"mediatek,larb", "mediatek,smi",
&larb) will be wrong due to there is no item like "mediatek,smi = <1>;"
in larb.

And this code seems to be not simple if we use
of_parse_phandle_with_args. Both need a loop.

so I don't change it here, ok?
> 
> > +       return 0;
> > +}
> > +
> [...]
> > +static int mtk_iommu_init_domain_context(struct mtk_iommu_domain *dom)
> > +{
> > +       int ret;
> > +
> > +       if (dom->iop)
> > +               return 0;
> > +
> > +       spin_lock_init(&dom->pgtlock);
> > +       dom->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS |
> > +                       IO_PGTABLE_QUIRK_SHORT_SUPERSECTION |
> > +                       IO_PGTABLE_QUIRK_SHORT_MTK;
> > +       dom->cfg.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
> > +       dom->cfg.ias = 32;
> > +       dom->cfg.oas = 32;
> > +       dom->cfg.tlb = &mtk_iommu_gather_ops;
> > +
> > +       dom->iop = alloc_io_pgtable_ops(ARM_SHORT_DESC, &dom->cfg, dom);
> > +       if (!dom->iop) {
> > +               pr_err("Failed to alloc io pgtable\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Update our support page sizes bitmap */
> > +       mtk_iommu_ops.pgsize_bitmap = dom->cfg.pgsize_bitmap;
> > +
> > +       ret = mtk_iommu_hw_init(dom);
> > +       if (ret)
> > +               free_io_pgtable_ops(dom->iop);
> > +
> > +       return ret;
> > +}
> 
> I don't see that you need the above function at all - since your 
> pagetable config is fixed and doesn't have any depency on which IOMMU 
> you're attaching to, can't you just do all of that straight away in 
> domain_alloc?

Yes. We could move it into domain_alloc.

> 
> > +static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
> > +{
> > +       struct mtk_iommu_domain *priv;
> > +
> > +       /* We only support unmanaged domains for now */
> > +       if (type != IOMMU_DOMAIN_UNMANAGED)
> > +               return NULL;
> 
> Have you had a chance to play with the latest DMA mapping series now 
> that I've integrated the default domain changes? I think if you handled 
> IOMMU_DOMAIN_DMA requests here and made them always return the 
> (preallocated) private domain, you should be able to get rid of the 
> tricks in attach_device completely.

  I can change it to this:
  if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
               return NULL;
 
  If always return the (preallocated) private domain, I have to use a
global variable to restore the preallocated domain here!.

  And It also will print "Incompatible range for DMA domain" and return
fail.
Could we return 0 instead of -EFAULT in iommu_dma_init_domain if the
domain is the same. 

> > +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return NULL;
> > +
> > +       priv->domain.geometry.aperture_start = 0;
> > +       priv->domain.geometry.aperture_end = (1ULL << 32) - 1;
> 
> DMA_BIT_MASK(32) ?

Thanks.

> 
> > +       priv->domain.geometry.force_aperture = true;
> > +
> > +       return &priv->domain;
> > +}
> > +
> [...]
> > +static int mtk_iommu_add_device(struct device *dev)
> > +{
> > +       struct mtk_iommu_domain *mtkdom;
> > +       struct iommu_group *group;
> > +       struct mtk_iommu_client_priv *devhead;
> > +       int ret;
> > +
> > +       if (!dev->archdata.dma_ops)/* Not a iommu client device */
> > +               return -ENODEV;
> 
> I think archdata.dma_ops is the wrong thing to test here. It would be 
> better to use archdata.iommu, since you go on to dereference that 
> unconditionally anyway, plus then you only depend on your own of_xlate 
> behaviour, rather than some quirk of the arch code (which could quietly 
> change in future).

I will change archdata.iommu next time.
Current I used the dev->archdata.iommu of the iommu device(m4u device)
itself. then the m4u device will come here too. so I changed to
dev->archdata.dma_ops.

As before, If we use a global variable for the mtk_iommu_domain, we
could use archdata.iommu here.

> 
> > +       group = iommu_group_get(dev);
> > +       if (!group) {
> > +               group = iommu_group_alloc();
> > +               if (IS_ERR(group)) {
> > +                       dev_err(dev, "Failed to allocate IOMMU group\n");
> > +                       return PTR_ERR(group);
> > +               }
> > +       }
> > +
> > +       ret = iommu_group_add_device(group, dev);
> > +       if (ret) {
> > +               dev_err(dev, "Failed to add IOMMU group\n");
> > +               goto err_group_put;
> > +       }
> > +
> > +       /* get the mtk_iommu_domain from the iommu device */
> > +       devhead = dev->archdata.iommu;
> > +       mtkdom = devhead->imudev->archdata.iommu;
> > +       ret = iommu_attach_group(&mtkdom->domain, group);
> > +       if (ret)
> > +               dev_err(dev, "Failed to attach IOMMU group\n");
> > +
> > +err_group_put:
> > +       iommu_group_put(group);
> > +       return ret;
> > +}
> > +
> [...]
> > +static struct iommu_ops mtk_iommu_ops = {
> > +       .domain_alloc   = mtk_iommu_domain_alloc,
> > +       .domain_free    = mtk_iommu_domain_free,
> > +       .attach_dev     = mtk_iommu_attach_device,
> > +       .detach_dev     = mtk_iommu_detach_device,
> > +       .map            = mtk_iommu_map,
> > +       .unmap          = mtk_iommu_unmap,
> > +       .map_sg         = default_iommu_map_sg,
> > +       .iova_to_phys   = mtk_iommu_iova_to_phys,
> > +       .add_device     = mtk_iommu_add_device,
> > +       .of_xlate       = mtk_iommu_of_xlate,
> > +       .pgsize_bitmap  = -1UL,
> 
> As above, if you know the hardware only supports a single descriptor 
> format with a fixed set of page sizes, why not just represent that directly?

OK. I will write the fix page sizes here.
I wrote it following the arm-smmu.c:)

> 
> > +};
> > +
> [...]
> > +static int mtk_iommu_suspend(struct device *dev)
> > +{
> > +       struct mtk_iommu_domain *mtkdom = dev_get_drvdata(dev);
> > +       struct mtk_iommu_data *data = mtkdom->data;
> > +       void __iomem *base = data->base;
> > +       unsigned int i = 0;
> > +
> > +       data->reg[i++] = readl(base + REG_MMU_PT_BASE_ADDR);
> 
> Redundancy nit: any particular reason for saving this here rather than 
> simply restoring it from mtkdom->cfg.arm_short_cfg.ttbr[0] on resume?
> 
> > +       data->reg[i++] = readl(base + REG_MMU_STANDARD_AXI_MODE);
> > +       data->reg[i++] = readl(base + REG_MMU_DCM_DIS);
> > +       data->reg[i++] = readl(base + REG_MMU_CTRL_REG);
> > +       data->reg[i++] = readl(base + REG_MMU_IVRP_PADDR);
> > +       data->reg[i++] = readl(base + REG_MMU_INT_CONTROL0);
> > +       data->reg[i++] = readl(base + REG_MMU_INT_MAIN_CONTROL);
> 
> Nit: given that these are fairly arbitrary discontiguous registers so 
> you can't have a simple loop over the array, it might be clearer to 
> replace the array with an equivalent struct, e.g.:
> 
> struct mtk_iommu_suspend_regs {
> 	u32 standard_axi_mode;
> 	u32 dcm_dis;
> 	...
> }
> 
> 	...
> 	data->reg.dcm_dis = readl(base + REG_MMU_DCM_DIS);
> 	...
> 
> then since you refer to everything by name you don't have to worry about 
> the length and order of array elements if anything ever changes.

Good idea. Thanks very much.

> 
> > +       return 0;
> > +}
> > +
> > +static int mtk_iommu_resume(struct device *dev)
> > +{
> > +       struct mtk_iommu_domain *mtkdom = dev_get_drvdata(dev);
> > +       struct mtk_iommu_data *data = mtkdom->data;
> > +       void __iomem *base = data->base;
> > +       unsigned int i = 0;
> > +
> > +       writel(data->reg[i++], base + REG_MMU_PT_BASE_ADDR);
> > +       writel(data->reg[i++], base + REG_MMU_STANDARD_AXI_MODE);
> > +       writel(data->reg[i++], base + REG_MMU_DCM_DIS);
> > +       writel(data->reg[i++], base + REG_MMU_CTRL_REG);
> > +       writel(data->reg[i++], base + REG_MMU_IVRP_PADDR);
> > +       writel(data->reg[i++], base + REG_MMU_INT_CONTROL0);
> > +       writel(data->reg[i++], base + REG_MMU_INT_MAIN_CONTROL);
> > +       return 0;
> > +}
> 
> Other than that though, modulo the issues with the pagetable code I 
> think this part of the driver is shaping up quite nicely.
> 
> Robin.
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
