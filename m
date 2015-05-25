From: Tomasz Figa <tfiga@google.com>
Subject: Re: [PATCH v2 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Mon, 25 May 2015 17:29:32 +0900
Message-ID: <CAAFQd5BCZrfq++SDs+HK66oUNnj-8pHrwKEMQzb7JM=4UUOgBg@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com> <1431683009-18158-6-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431683009-18158-6-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Daniel Kurtz <djkurtz@google.com>, Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, k.zhang@mediatek.com, youhua.li@mediatek.com
List-Id: iommu@lists.linux-foundation.org

Hi,

Please see my comments inline.

On Fri, May 15, 2015 at 6:43 PM, Yong Wu <yong.wu@mediatek.com> wrote:
[snip]
> +
> +struct mtk_iommu_info {
> +       void __iomem            *base;
> +       int                     irq;
> +       struct device           *dev;
> +       struct device           *larbdev[MTK_IOMMU_LARB_MAX_NR];
> +       struct clk              *bclk;
> +       dma_addr_t              protect_base; /* protect memory base */
> +       unsigned int            larb_nr;      /* local arbiter number */
> +       unsigned int            larb_portid_base[MTK_IOMMU_LARB_MAX_NR];
> +                               /* the port id base for each local arbiter */

It might not be a bad idea to convert this kind of comments into a
proper kerneldoc comment for the whole struct. Similarly for other
structs in the driver.

[snip]

> +static void mtk_iommu_clear_intr(void __iomem *m4u_base)

nit: Instead of pasing m4u_base here, could you pass a pointer to the
mtk_iommu_info here and use its base field? This would be more strict,
because currently a void pointer permits passing anything to this
function.

> +{
> +       u32 val;
> +
> +       val = readl(m4u_base + REG_MMU_INT_CONTROL0);
> +       val |= F_INT_L2_CLR_BIT;
> +       writel(val, m4u_base + REG_MMU_INT_CONTROL0);
> +}
> +
> +static void mtk_iommu_tlb_flush_all(void *cookie)
> +{
> +       struct mtk_iommu_domain *domain = cookie;
> +       u32 val;
> +
> +       val = F_INVLD_EN1 | F_INVLD_EN0;
> +       writel(val, domain->imuinfo->base + REG_MMU_INV_SEL);

nit: Do you need this val variable?

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

nit: Does this write need to go through this val variable?

> +
> +       writel(iova_start, m4u_base + REG_MMU_INVLD_START_A);
> +       writel(iova_end, m4u_base + REG_MMU_INVLD_END_A);
> +       writel(F_MMU_INV_RANGE, m4u_base + REG_MMU_INVALIDATE);
> +
> +       ret = readl_poll_timeout_atomic(m4u_base + REG_MMU_CPE_DONE, val,
> +                                       val != 0, 10, 1000000);
> +       if (ret) {
> +               dev_warn(domain->imuinfo->dev, "Invalid tlb don't done\n");

Maybe "Partial TLB flush timed out, falling back to full flush\n"?

> +               mtk_iommu_tlb_flush_all(cookie);
> +       }
> +       writel(0, m4u_base + REG_MMU_CPE_DONE);
> +}
> +
> +static void mtk_iommu_flush_pgtable(void *ptr, size_t size, void *cookie)
> +{
> +       /*
> +        * After delete arch_setup_dma_ops,
> +        * This will be replaced with dma_map_page
> +        */
> +        __dma_flush_range(ptr, ptr + size);
> +}
> +
> +static struct iommu_gather_ops mtk_iommu_gather_ops = {
> +       .tlb_flush_all = mtk_iommu_tlb_flush_all,
> +       .tlb_add_flush = mtk_iommu_tlb_add_flush,
> +       .tlb_sync = mtk_iommu_tlb_flush_all,
> +       .flush_pgtable = mtk_iommu_flush_pgtable,
> +};
> +
> +static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> +{
> +       struct mtk_iommu_domain *mtkdomain = dev_id;
> +       struct mtk_iommu_info *piommu = mtkdomain->imuinfo;
> +       struct device *dev = piommu->dev;
> +       void __iomem *m4u_base = piommu->base;
> +       u32 int_state, regval, fault_iova, fault_pa;
> +       unsigned int fault_larb, fault_port;
> +       bool layer, write;
> +
> +       int_state = readl(m4u_base + REG_MMU_FAULT_ST1);
> +
> +       /* read error info from registers */
> +       fault_iova = readl(m4u_base + REG_MMU_FAULT_VA);
> +       layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
> +       write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
> +       fault_iova &= F_MMU_FAULT_VA_MSK;
> +       fault_pa = readl(m4u_base + REG_MMU_INVLD_PA);
> +       regval = readl(m4u_base + REG_MMU_INT_ID);
> +       fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
> +       fault_port = F_MMU0_INT_ID_PORT_ID(regval);
> +
> +       report_iommu_fault(&mtkdomain->domain, dev, fault_iova,
> +                          write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> +
> +       if (int_state & F_INT_TRANSLATION_FAULT) {
> +               dev_err_ratelimited(
> +                       dev,
> +                       "fault:iova=0x%x pa=0x%x larb=%d port=%d layer=%d %s\n",
> +                       fault_iova, fault_pa, fault_larb, fault_port,
> +                       layer, write ? "write" : "read");
> +       }
> +
> +       if (int_state & F_INT_MAIN_MULTI_HIT_FAULT)
> +               dev_err_ratelimited(dev,
> +                                   "multi-hit!iova=0x%x larb=%d port=%d\n",
> +                                   fault_iova, fault_larb, fault_port);
> +
> +       if (int_state & F_INT_INVALID_PA_FAULT) {
> +               if (!(int_state & F_INT_TRANSLATION_FAULT))
> +                       dev_err_ratelimited(
> +                               dev,
> +                               "invalid pa!iova=0x%x larb=%d port=%d\n",
> +                               fault_iova, fault_larb, fault_port);
> +       }
> +       if (int_state & F_INT_ENTRY_REPLACEMENT_FAULT)
> +               dev_err_ratelimited(dev,
> +                                   "replace-fault!iova=0x%x larb=%d port=%d\n",
> +                                   fault_iova, fault_larb, fault_port);
> +
> +       if (int_state & F_INT_TLB_MISS_FAULT)
> +               dev_err_ratelimited(dev,
> +                                   "tlb miss-fault!iova=0x%x larb=%d port=%d\n",
> +                                   fault_iova, fault_larb, fault_port);

Hmm, do you need so many prints here? Could you just dump the full
state (including int_state) regardless of interrupt type here? Also I
wonder if this shouldn't be printed only when report_iommu_fault()
returns -ENOSYS.

> +
> +       mtk_iommu_tlb_flush_all(mtkdomain);
> +
> +       mtk_iommu_clear_intr(m4u_base);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int mtk_iommu_parse_dt(struct platform_device *pdev,
> +                             struct mtk_iommu_info *piommu)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct device_node *ofnode;
> +       struct resource *res;
> +       unsigned int i, port_nr, lastportnr = 0;
> +       int ret;
> +
> +       ofnode = dev->of_node;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       piommu->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(piommu->base)) {
> +               dev_err(dev, "Failed to get base (%lx)\n",
> +                       PTR_ERR(piommu->base));

devm_ioremap_resource() already prints a message on error.

> +               ret = PTR_ERR(piommu->base);
> +               goto err_parse_dt;

You can just return PTR_ERR(piommu->base) here directly.

> +       }
> +
> +       piommu->irq = platform_get_irq(pdev, 0);
> +       if (piommu->irq < 0) {
> +               dev_err(dev, "Failed to get IRQ (%d)\n", piommu->irq);
> +               ret = piommu->irq;
> +               goto err_parse_dt;

Again just return.

> +       }
> +
> +       piommu->bclk = devm_clk_get(dev, "bclk");
> +       if (IS_ERR(piommu->bclk)) {
> +               dev_err(dev, "Failed to get the bclk (%lx)\n",
> +                       PTR_ERR(piommu->bclk));
> +               ret = PTR_ERR(piommu->bclk);
> +               goto err_parse_dt;

Ditto.

> +       }
> +
> +       ret = of_property_count_u32_elems(ofnode, "larb-portes-nr");

According to my comments to the patch adding the binding, you should
rather count the number of phandles in "larb" property by
of_count_phandle_with_args(ofnode, "larb", NULL).

> +       if (ret < 0) {
> +               dev_err(dev, "Failed to get larb-portes-nr\n");
> +               goto err_parse_dt;

Ditto.

> +       } else {
> +               piommu->larb_nr = ret;

You can take this out of "else" block.

> +       }
> +
> +       for (i = 0; i < piommu->larb_nr; i++) {
> +               ret = of_property_read_u32_index(ofnode, "larb-portes-nr",
> +                                                i, &port_nr);

For logical correctness, you should parse port count from larb node,
as I mentioned in my comments to the patch adding the binding. However
I'm not sure if you even need to know the number of ports. I will
comment more on this below.

> +               if (ret) {
> +                       dev_err(dev, "Failed to get the port nr@larb%d\n", i);
> +                       goto err_parse_dt;

Just return here.

> +               } else {

> +                       piommu->larb_portid_base[i] = lastportnr;
> +                       lastportnr += port_nr;

This looks like creating an artificial 1-dimensional namespace from a
natural 2-dimensional space indexed by (larb, port) tuple.

Also you can take this out of the else block.

> +               }
> +       }
> +       piommu->larb_portid_base[i] = lastportnr;
> +
> +       for (i = 0; i < piommu->larb_nr; i++) {
> +               struct device_node *larbnode;
> +               struct platform_device *plarbdev;
> +
> +               larbnode = of_parse_phandle(ofnode, "larb", i);
> +               if (!larbnode) {
> +                       dev_err(dev, "Failed to get the larb property\n");
> +                       ret = -EINVAL;
> +                       goto err_parse_dt;

Just return.

> +               }
> +               plarbdev = of_find_device_by_node(larbnode);
> +               of_node_put(larbnode);
> +               if (!plarbdev) {
> +                       dev_err(dev, "Failed to get the dev@larb%d\n", i);
> +                       ret = -EINVAL;
> +                       goto err_parse_dt;

Just return.

> +               } else {
> +                       piommu->larbdev[i] = &plarbdev->dev;

Again, no need to put this into else block.

> +               }
> +       }
> +
> +       return 0;
> +
> +err_parse_dt:
> +       return ret;

Now, after addressing my comments above, this label can be removed.

> +}
> +
> +static int mtk_iommu_hw_init(const struct mtk_iommu_domain *mtkdomain)
> +{
> +       struct mtk_iommu_info *piommu = mtkdomain->imuinfo;
> +       void __iomem *m4u_base = piommu->base;
> +       u32 regval;
> +       int ret = 0;
> +
> +       ret = clk_prepare_enable(piommu->bclk);
> +       if (ret)
> +               return -ENODEV;

Why overriding the error returned in ret with -ENODEV?

> +
> +       writel(mtkdomain->cfg.arm_short_cfg.ttbr[0],
> +              m4u_base + REG_MMU_PT_BASE_ADDR);
> +
> +       regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> +               F_MMU_TF_PROTECT_SEL(2) |
> +               F_COHERENCE_EN;
> +       writel(regval, m4u_base + REG_MMU_CTRL_REG);
> +
> +       regval = F_L2_MULIT_HIT_EN |
> +               F_TABLE_WALK_FAULT_INT_EN |
> +               F_PREETCH_FIFO_OVERFLOW_INT_EN |
> +               F_MISS_FIFO_OVERFLOW_INT_EN |
> +               F_PREFETCH_FIFO_ERR_INT_EN |
> +               F_MISS_FIFO_ERR_INT_EN;
> +       writel(regval, m4u_base + REG_MMU_INT_CONTROL0);
> +
> +       regval = F_INT_TRANSLATION_FAULT |
> +               F_INT_MAIN_MULTI_HIT_FAULT |
> +               F_INT_INVALID_PA_FAULT |
> +               F_INT_ENTRY_REPLACEMENT_FAULT |
> +               F_INT_TLB_MISS_FAULT |
> +               F_INT_MISS_TRANSATION_FIFO_FAULT |
> +               F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
> +       writel(regval, m4u_base + REG_MMU_INT_MAIN_CONTROL);
> +
> +       regval = ALIGN(piommu->protect_base, MTK_PROTECT_PA_ALIGN);
> +       regval = (u32)F_MMU_IVRP_PA_SET(regval);
> +       writel(regval, m4u_base + REG_MMU_IVRP_PADDR);
> +
> +       writel(0, m4u_base + REG_MMU_DCM_DIS);
> +       writel(0, m4u_base + REG_MMU_STANDARD_AXI_MODE);
> +
> +       if (devm_request_irq(piommu->dev, piommu->irq, mtk_iommu_isr, 0,
> +                            dev_name(piommu->dev), (void *)mtkdomain)) {
> +               dev_err(piommu->dev, "Failed @ IRQ-%d Request\n", piommu->irq);
> +               return -ENODEV;

Hmm, this keeps the clock enabled. Should you add clean-up path
uninitializing the hardware and stopping the clock?

> +       }
> +
> +       return 0;
> +}
> +
> +static int mtk_iommu_config_port(struct mtk_iommu_info *piommu,
> +                                int portid, bool iommuen)
> +{
> +       bool validlarb = false;
> +       int i, larbid, larbportid;
> +       int ret;
> +
> +       if (portid >= piommu->larb_portid_base[piommu->larb_nr]) {
> +               dev_err(piommu->dev, "Invalid portid (%d)\n", portid);
> +               return -EINVAL;
> +       }
> +
> +       for (i = piommu->larb_nr - 1; i >= 0; i--) {
> +               if (portid >= piommu->larb_portid_base[i]) {
> +                       larbid = i;
> +                       larbportid = portid -
> +                                       piommu->larb_portid_base[i];
> +                       validlarb = true;
> +                       break;
> +               }
> +       }

There would be no need for this magic here if two cells was used for
port specifier in DT. By the way, this function seems to be the only
user of port count, so if you don't strictly need the check for port
specifier being in range, then such information could be simply
removed from DT, simplifying the binding.

> +
> +       if (validlarb) {
> +               ret = mtk_smi_config_port(piommu->larbdev[larbid],
> +                                         larbportid, iommuen);
> +               if (ret) {
> +                       dev_err(piommu->dev,
> +                               "Failed to config port portid-%d\n", portid);
> +               }
> +       } else {
> +               ret = -EINVAL;
> +               dev_err(piommu->dev, "Failed to find out portid-%d\n", portid);
> +       }
> +       return ret;
> +}
> +
> +static int mtk_iommu_dev_enable_iommu(struct mtk_iommu_info *imuinfo,
> +                                     struct device *dev, bool enable)
> +{
> +       struct of_phandle_args out_args = {0};
> +       struct device *imudev = imuinfo->dev;
> +       unsigned int i = 0;
> +       int ret = 0;
> +
> +       while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> +                                          "#iommu-cells", i++, &out_args)) {
> +               if (out_args.np != imudev->of_node)
> +                       continue;
> +               if (out_args.args_count != 1) {
> +                       dev_err(imudev,
> +                               "invalid #iommu-cells property for IOMMU\n");
> +               }

I don't believe you need to do this manually. I can see
of_iommu_configure() in
http://lxr.free-electrons.com/source/drivers/iommu/of_iommu.c#L136 ,
which I believe should call .of_xlate from your iommu_ops with correct
node and verified the args count. This callback should parse the args
and prepare some private data.

I don't see any example of such .of_xlate callback though. Could
someone (Joerg, Will?) advise how this could be used and in particular
how the data obtained from parsing the args should be stored for
further use?

> +
> +               dev_dbg(imudev, "%s iommu @ port:%d\n",
> +                       enable ? "enable" : "disable", out_args.args[0]);
> +
> +               ret = mtk_iommu_config_port(imuinfo, out_args.args[0], enable);
> +               if (!ret)
> +                       dev->archdata.dma_ops = (enable) ?
> +                                       imudev->archdata.dma_ops : NULL;
> +               else
> +                       break;
> +       }
> +       return ret;
> +}
> +
> +static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
> +{
> +       struct mtk_iommu_domain *priv;
> +
> +       /* We only support unmanaged domains for now */
> +       if (type != IOMMU_DOMAIN_UNMANAGED)
> +               return NULL;
> +
> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return ERR_PTR(-ENOMEM);

What's the proper return convention of this function? The first error
case returns NULL, while this an error pointer. One of them is most
likely wrong.

> +
> +       priv->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
> +       priv->cfg.pgsize_bitmap = SZ_16M | SZ_1M | SZ_64K | SZ_4K,
> +       priv->cfg.ias = 32;
> +       priv->cfg.oas = 32;
> +       priv->cfg.tlb = &mtk_iommu_gather_ops;
> +
> +       priv->iop = alloc_io_pgtable_ops(ARM_SHORT_DESC, &priv->cfg, priv);
> +       if (!priv->iop) {
> +               pr_err("Failed to alloc io pgtable@MTK iommu\n");
> +               goto err_free_priv;
> +       }
> +
> +       spin_lock_init(&priv->pgtlock);
> +
> +       priv->domain.geometry.aperture_start = 0;
> +       priv->domain.geometry.aperture_end = ~0;

Should this be UL or ULL?

> +       priv->domain.geometry.force_aperture = true;
> +
> +       return &priv->domain;
> +
> +err_free_priv:
> +       kfree(priv);
> +       return NULL;
> +}
> +
> +static void mtk_iommu_domain_free(struct iommu_domain *domain)
> +{
> +       struct mtk_iommu_domain *priv = to_mtk_domain(domain);
> +
> +       free_io_pgtable_ops(priv->iop);
> +       kfree(priv);
> +}
> +
> +static int mtk_iommu_attach_device(struct iommu_domain *domain,
> +                                  struct device *dev)
> +{
> +       struct mtk_iommu_domain *priv = to_mtk_domain(domain);
> +       int ret;
> +
> +       /* word around for arch_setup_dma_ops */

typo: s/word around/Workaround/

Anyway, could you remind me what was the issue with arch_setup_dma_ops, please?

> +       if (!priv->imuinfo)
> +               ret = 0;
> +       else
> +               ret = mtk_iommu_dev_enable_iommu(priv->imuinfo, dev, true);
> +       return ret;

Maybe you could rewrite the 5 lines above into the following:

if (!priv->imuinfo)
    return 0;
return mtk_iommu_dev_enable_iommu(priv->imuinfo, dev, true);

> +}
> +
> +static void mtk_iommu_detach_device(struct iommu_domain *domain,
> +                                   struct device *dev)
> +{
> +       struct mtk_iommu_domain *priv = to_mtk_domain(domain);
> +
> +       mtk_iommu_dev_enable_iommu(priv->imuinfo, dev, false);
> +}
> +
> +static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
> +                        phys_addr_t paddr, size_t size, int prot)
> +{
> +       struct mtk_iommu_domain *priv = to_mtk_domain(domain);
> +       unsigned long flags;
> +       int ret;
> +
> +       spin_lock_irqsave(&priv->pgtlock, flags);
> +       ret = priv->iop->map(priv->iop, iova, paddr, size, prot);
> +       spin_unlock_irqrestore(&priv->pgtlock, flags);
> +
> +       return ret;
> +}
> +
> +static size_t mtk_iommu_unmap(struct iommu_domain *domain,
> +                             unsigned long iova, size_t size)
> +{
> +       struct mtk_iommu_domain *priv = to_mtk_domain(domain);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv->pgtlock, flags);
> +       priv->iop->unmap(priv->iop, iova, size);
> +       spin_unlock_irqrestore(&priv->pgtlock, flags);
> +
> +       return size;
> +}
> +
> +static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> +                                         dma_addr_t iova)
> +{
> +       struct mtk_iommu_domain *priv = to_mtk_domain(domain);
> +       unsigned long flags;
> +       phys_addr_t pa;
> +
> +       spin_lock_irqsave(&priv->pgtlock, flags);
> +       pa = priv->iop->iova_to_phys(priv->iop, iova);
> +       spin_unlock_irqrestore(&priv->pgtlock, flags);
> +
> +       return pa;
> +}
> +
> +static struct iommu_ops mtk_iommu_ops = {
> +       .domain_alloc = mtk_iommu_domain_alloc,
> +       .domain_free = mtk_iommu_domain_free,
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
> +       { .compatible = "mediatek,mt8173-m4u",
> +       },

nit: Why is this on a separate line?

> +       {}
> +};
> +
> +static int mtk_iommu_probe(struct platform_device *pdev)
> +{
> +       struct iommu_domain     *domain;
> +       struct mtk_iommu_domain *mtk_domain;
> +       struct mtk_iommu_info   *piommu;
> +       void __iomem            *protect;
> +       int                     ret;

CodingStyle: Please no tabs in local variable declarations.

> +
> +       piommu = devm_kzalloc(&pdev->dev, sizeof(*piommu), GFP_KERNEL);
> +       if (!piommu)
> +               return -ENOMEM;
> +
> +       piommu->dev = &pdev->dev;
> +
> +       /*
> +        * Alloc for Protect memory.
> +        * HW will access here while translation fault.
> +        */
> +       protect = devm_kzalloc(piommu->dev, MTK_PROTECT_PA_ALIGN * 2,
> +                              GFP_KERNEL);
> +       if (!protect)
> +               return -ENOMEM;
> +       piommu->protect_base = dma_map_single(piommu->dev, protect,
> +                                             MTK_PROTECT_PA_ALIGN * 2,
> +                                             DMA_TO_DEVICE); /* clean cache */
> +
> +       ret = mtk_iommu_parse_dt(pdev, piommu);
> +       if (ret)
> +               return ret;

What about the potential dma mapping created by dma_map_single()? (I'm
not sure how important is to clean this up in practice, but for
consistency, it should be handled in error path to prevent leaking
memory if something changes in future in DMA API internals.)

> +
> +       /*
> +        * arch_setup_dma_ops is not proper.
> +        * It should be replaced it with iommu_dma_create_domain
> +        * in next dma patch.
> +        */
> +       arch_setup_dma_ops(piommu->dev, 0, (1ULL << 32) - 1, &mtk_iommu_ops, 0);
> +
> +       domain = iommu_dma_raw_domain(get_dma_domain(piommu->dev));
> +       if (!domain) {
> +               dev_err(piommu->dev, "Failed to get iommu domain\n");
> +               ret = -EINVAL;
> +               goto err_free_domain;
> +       }
> +
> +       mtk_domain = to_mtk_domain(domain);
> +       mtk_domain->imuinfo = piommu;
> +
> +       dev_set_drvdata(piommu->dev, piommu);
> +
> +       ret = mtk_iommu_hw_init(mtk_domain);
> +       if (ret < 0) {
> +               dev_err(piommu->dev, "Failed @ HW init\n");

nit: Maybe "Hardware initialization failed"?

> +               goto err_free_domain;
> +       }
> +
> +       return 0;
> +
> +err_free_domain:
> +       arch_teardown_dma_ops(piommu->dev);

Shouldn't the label be called err_teardown_dma_ops then?

Best regards,
Tomasz
