From: Tomasz Figa <tfiga@google.com>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Wed, 11 Mar 2015 19:53:02 +0900
Message-ID: <CAAFQd5ASywTX7P9L8cogBbBTra0W1=oVxeWfK5=K7L+SR2xaFA@mail.gmail.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com> <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <yong.wu@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Hi,

Please find next part of my comments inline.

On Fri, Mar 6, 2015 at 7:48 PM,  <yong.wu@mediatek.com> wrote:

[snip]

> +/*
> + * pimudev is a global var for dma_alloc_coherent.
> + * It is not accepatable, we will delete it if "domain_alloc" is enabled

It looks like we indeed need to use dma_alloc_coherent() and we don't
have a good way to pass the device pointer to domain_init callback.

If you don't expect SoCs in the nearest future to have multiple M4U
blocks, then I guess this global variable could stay, after changing
the comment into an explanation why it's correct. Also it should be
moved to the top of the file, below #include directives, as this is
where usually global variables are located.

> + */
> +static struct device *pimudev;
> +
> +static int mtk_iommu_domain_init(struct iommu_domain *domain)
> +{
> +       struct mtk_iommu_domain *priv;
> +
> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->pgd = dma_alloc_coherent(pimudev, M4U_PGD_SIZE, &priv->pgd_pa,
> +                                      GFP_KERNEL);
> +       if (!priv->pgd) {
> +               pr_err("dma_alloc_coherent pagetable fail\n");
> +               goto err_pgtable;

ret = -ENOMEM;
goto err_free_priv;

> +       }
> +
> +       if (!IS_ALIGNED(priv->pgd_pa, M4U_PGD_SIZE)) {
> +               pr_err("pagetable not aligned pa 0x%pad-0x%p align 0x%x\n",
> +                      &priv->pgd_pa, priv->pgd, M4U_PGD_SIZE);
> +               goto err_pgtable;

ret = -ENOMEM;
goto err_dmafree;

> +       }
> +
> +       memset(priv->pgd, 0, M4U_PGD_SIZE);
> +
> +       spin_lock_init(&priv->pgtlock);
> +       spin_lock_init(&priv->portlock);
> +       domain->priv = priv;
> +
> +       domain->geometry.aperture_start = 0;
> +       domain->geometry.aperture_end   = (unsigned int)~0;

Please replace the cast with ~0U and fix multiple spaces between =.

> +       domain->geometry.force_aperture = true;
> +
> +       return 0;
> +
> +err_pgtable:

err_dma_free:

> +       if (priv->pgd)

Remove this check.

> +               dma_free_coherent(pimudev, M4U_PGD_SIZE, priv->pgd,
> +                                 priv->pgd_pa);

err_free_priv:

> +       kfree(priv);
> +       return -ENOMEM;

return ret;

> +}
> +
> +static void mtk_iommu_domain_destroy(struct iommu_domain *domain)
> +{
> +       struct mtk_iommu_domain *priv = domain->priv;
> +
> +       dma_free_coherent(priv->piommuinfo->dev, M4U_PGD_SIZE,
> +                         priv->pgd, priv->pgd_pa);
> +       kfree(domain->priv);
> +       domain->priv = NULL;
> +}
> +
> +static int mtk_iommu_attach_device(struct iommu_domain *domain,
> +                                  struct device *dev)
> +{
> +       unsigned long flags;
> +       struct mtk_iommu_domain *priv = domain->priv;
> +       struct mtk_iommu_info *piommu = priv->piommuinfo;
> +       struct of_phandle_args out_args = {0};
> +       struct device *imudev;
> +       unsigned int i = 0;
> +
> +       if (!piommu)

Could you explain when this can happen?

> +               goto imudev;

return 0;

> +       else

No else needed.

> +               imudev = piommu->dev;
> +
> +       spin_lock_irqsave(&priv->portlock, flags);

What is protected by this spinlock?

> +
> +       while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> +                                          "#iommu-cells", i, &out_args)) {
> +               if (1 == out_args.args_count) {

Can we be sure that this is actually referring to our IOMMU?

Maybe this should be rewritten to

if (out_args.np != imudev->of_node)
        continue;
if (out_args.args_count != 1) {
        dev_err(imudev, "invalid #iommu-cells property for IOMMU %s\n",

}

> +                       unsigned int portid = out_args.args[0];
> +
> +                       dev_dbg(dev, "iommu add port:%d\n", portid);

imudev should be used here instead of dev.

> +
> +                       mtk_iommu_config_port(piommu, portid);
> +
> +                       if (i == 0)
> +                               dev->archdata.dma_ops =
> +                                       piommu->dev->archdata.dma_ops;

Shouldn't this be set automatically by IOMMU or DMA mapping core?

> +               }
> +               i++;
> +       }
> +
> +       spin_unlock_irqrestore(&priv->portlock, flags);
> +
> +imudev:
> +       return 0;
> +}
> +
> +static void mtk_iommu_detach_device(struct iommu_domain *domain,
> +                                   struct device *dev)
> +{

No hardware (de)configuration or clean-up necessary?

> +}
> +
> +static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
> +                        phys_addr_t paddr, size_t size, int prot)
> +{
> +       struct mtk_iommu_domain *priv = domain->priv;
> +       unsigned long flags;
> +       int ret;
> +
> +       spin_lock_irqsave(&priv->pgtlock, flags);
> +       ret = m4u_map(priv, (unsigned int)iova, paddr, size, prot);
> +       mtk_iommu_invalidate_tlb(priv->piommuinfo, 0,
> +                                iova, iova + size - 1);
> +       spin_unlock_irqrestore(&priv->pgtlock, flags);
> +
> +       return ret;
> +}
> +
> +static size_t mtk_iommu_unmap(struct iommu_domain *domain,
> +                             unsigned long iova, size_t size)
> +{
> +       struct mtk_iommu_domain *priv = domain->priv;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv->pgtlock, flags);
> +       m4u_unmap(priv, (unsigned int)iova, size);
> +       mtk_iommu_invalidate_tlb(priv->piommuinfo, 0,
> +                                iova, iova + size - 1);
> +       spin_unlock_irqrestore(&priv->pgtlock, flags);
> +
> +       return size;
> +}
> +
> +static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> +                                         dma_addr_t iova)
> +{
> +       struct mtk_iommu_domain *priv = domain->priv;
> +       unsigned long flags;
> +       struct m4u_pte_info_t pte;
> +
> +       spin_lock_irqsave(&priv->pgtlock, flags);
> +       m4u_get_pte_info(priv, (unsigned int)iova, &pte);
> +       spin_unlock_irqrestore(&priv->pgtlock, flags);
> +
> +       return pte.pa;
> +}
> +
> +static struct iommu_ops mtk_iommu_ops = {
> +       .domain_init = mtk_iommu_domain_init,
> +       .domain_destroy = mtk_iommu_domain_destroy,
> +       .attach_dev = mtk_iommu_attach_device,
> +       .detach_dev = mtk_iommu_detach_device,
> +       .map = mtk_iommu_map,
> +       .unmap = mtk_iommu_unmap,
> +       .map_sg = default_iommu_map_sg,
> +       .iova_to_phys = mtk_iommu_iova_to_phys,
> +       .pgsize_bitmap = SZ_4K | SZ_64K | SZ_1M | SZ_16M,
> +};
> +
> +static const struct of_device_id mtk_iommu_of_ids[] = {
> +       { .compatible = "mediatek,mt8173-iommu",
> +         .data = &mtk_iommu_mt8173_cfg,
> +       },
> +       {}
> +};
> +
> +static int mtk_iommu_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct iommu_domain *domain;
> +       struct mtk_iommu_domain *mtk_domain;
> +       struct mtk_iommu_info *piommu;
> +       struct iommu_dma_domain  *dom;
> +       const struct of_device_id *of_id;
> +
> +       piommu = devm_kzalloc(&pdev->dev, sizeof(struct mtk_iommu_info),

sizeof(*piommu)

> +                             GFP_KERNEL);
> +       if (!piommu)
> +               return -ENOMEM;
> +
> +       pimudev = &pdev->dev;
> +       piommu->dev = &pdev->dev;
> +
> +       of_id = of_match_node(mtk_iommu_of_ids, pdev->dev.of_node);
> +       if (!of_id)
> +               return -ENODEV;

Please print an error message.

> +
> +       piommu->protect_va = devm_kmalloc(piommu->dev, MTK_PROTECT_PA_ALIGN*2,

style: Operators like * should have space on both sides.

> +                                         GFP_KERNEL);

Shouldn't dma_alloc_coherent() be used for this?

> +       if (!piommu->protect_va)
> +               goto protect_err;

Please return -ENOMEM here directly, as there is nothing to clean up
in this case.

> +       memset(piommu->protect_va, 0x55, MTK_PROTECT_PA_ALIGN*2);
> +
> +       piommu->imucfg = (const struct mtk_iommu_cfg *)of_id->data;

Why this cast is needed? Since of_id->data is const void * it should
be fine without a cast.

> +
> +       ret = mtk_iommu_parse_dt(pdev, piommu);
> +       if (ret) {
> +               dev_err(piommu->dev, "iommu dt parse fail\n");
> +               goto protect_err;

Still nothing to clean-up, so you can safely just return ret;

> +       }
> +
> +       /* alloc memcache for level-2 pgt */
> +       piommu->m4u_pte_kmem = kmem_cache_create("m4u_pte", IMU_BYTES_PER_PTE,
> +                                                IMU_BYTES_PER_PTE, 0, NULL);
> +
> +       if (IS_ERR_OR_NULL(piommu->m4u_pte_kmem)) {

Looks like the convention used by kmem_cache_create() is valid ptr or
NULL, no ERR_PTR()s.

> +               dev_err(piommu->dev, "pte cached create fail %p\n",
> +                       piommu->m4u_pte_kmem);
> +               goto protect_err;

Still nothing to clean-up.

> +       }
> +
> +       arch_setup_dma_ops(piommu->dev, 0, (1ULL<<32) - 1, &mtk_iommu_ops, 0);

style: Missing spaces around << operator.

> +
> +       dom = get_dma_domain(piommu->dev);
> +       domain = iommu_dma_raw_domain(dom);
> +
> +       mtk_domain = domain->priv;

domain is already dereferenced here, but NULL pointer check is two lines below.

> +       mtk_domain->piommuinfo = piommu;
> +
> +       if (!domain)
> +               goto pte_err;

Please print error message.

> +
> +       ret = mtk_iommu_hw_init(mtk_domain);
> +       if (ret < 0)
> +               goto hw_err;

Please print error message.

> +
> +       if (devm_request_irq(piommu->dev, piommu->irq,
> +                            mtk_iommu_isr, IRQF_TRIGGER_NONE,
> +                            "mtkiommu", (void *)domain)) {

Please align wrapped lines using tabs only.

Also, what do you mean by IRQF_TRIGGER_NONE? If you don't need any
special flags then 0 is enough.

Also, usually dev_name() is used for interrupt name.

Also, unnecessary cast of domain to void *.

> +               dev_err(piommu->dev, "IRQ request %d failed\n",
> +                       piommu->irq);
> +               goto hw_err;
> +       }
> +
> +       iommu_set_fault_handler(domain, mtk_iommu_fault_handler, piommu);

I don't see any other drivers doing this. Isn't this for upper layers,
so that they can set their own generic fault handlers?

> +
> +       dev_set_drvdata(piommu->dev, piommu);

This should be set before allowing the interrupt to fire. In other
words, the driver should be fully set up at the time of enabling the
IRQ.

> +
> +       return 0;

style: Missing blank line.

> +hw_err:
> +       arch_teardown_dma_ops(piommu->dev);
> +pte_err:
> +       kmem_cache_destroy(piommu->m4u_pte_kmem);
> +protect_err:
> +       dev_err(piommu->dev, "probe error\n");

Please replace this with specific messages for all errors (in case the
called function doesn't already print one like kmalloc and friends).

> +       return 0;

Returning 0, which means success, doesn't look like a good idea for
signalling a failure. Please return the correct error code as received
from function that errors out if possible.

End of part 3.

Best regards,
Tomasz
