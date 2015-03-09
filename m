From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Mon, 9 Mar 2015 20:11:40 +0900
Message-ID: <CAAFQd5AhTe=d9tXN8kaRah_GiZYYxG0cD0up=cbHkSfbBnXmvQ@mail.gmail.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	<1425638900-24989-3-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425638900-24989-3-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

You can find part 2 of my comments inline.

On Fri, Mar 6, 2015 at 7:48 PM,  <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:

[snip]

> +static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
> +{
> +       struct iommu_domain *domain = dev_id;
> +       struct mtk_iommu_domain *mtkdomain = domain->priv;
> +       struct mtk_iommu_info *piommu = mtkdomain->piommuinfo;
> +
> +       if (irq == piommu->irq)
> +               report_iommu_fault(domain, piommu->dev, 0, 0);

In addition to my previous comment about how this gets called from
this handler, you need to keep in mind that the function called by
report_iommu_fault() might actually be a different function than
mtk_iommu_fault_handler(), because upper layers can provide their own
handlers. This means that you need to perform any operations on
hardware from this handler and only use the iommu fault handler as a
way to tell an upper layer about the fault (including notifying the
user through kernel log if there is no special handler installed and
the generic fallback is used).

> +       else
> +               dev_err(piommu->dev, "irq number:%d\n", irq);
> +
> +       return IRQ_HANDLED;
> +}

[snip]

> +static int mtk_iommu_fault_handler(struct iommu_domain *imudomain,
> +                                  struct device *dev, unsigned long iova,
> +                                  int m4uindex, void *pimu)
> +{
> +       void __iomem *m4u_base;
> +       u32 int_state, regval;
> +       int m4u_slave_id = 0;
> +       unsigned int layer, write, m4u_port;
> +       unsigned int fault_mva, fault_pa;
> +       struct mtk_iommu_info *piommu = pimu;
> +       struct mtk_iommu_domain *mtkdomain = imudomain->priv;
> +
> +       m4u_base = piommu->m4u_base;
> +       int_state = readl(m4u_base + REG_MMU_MAIN_FAULT_ST);
> +
> +       /* read error info from registers */
> +       fault_mva = readl(m4u_base + REG_MMU_FAULT_VA(m4u_slave_id));
> +       layer = !!(fault_mva & F_MMU_FAULT_VA_LAYER_BIT);
> +       write = !!(fault_mva & F_MMU_FAULT_VA_WRITE_BIT);
> +       fault_mva &= F_MMU_FAULT_VA_MSK;
> +       fault_pa = readl(m4u_base + REG_MMU_INVLD_PA(m4u_slave_id));
> +       regval = readl(m4u_base + REG_MMU_INT_ID(m4u_slave_id));
> +       regval &= F_MMU0_INT_ID_TF_MSK;
> +       m4u_port = mtk_iommu_get_port_by_tfid(piommu, regval);
> +
> +       if (int_state & F_INT_TRANSLATION_FAULT(m4u_slave_id)) {
> +               struct m4u_pte_info_t pte;
> +               unsigned long flags;
> +
> +               spin_lock_irqsave(&mtkdomain->pgtlock, flags);
> +               m4u_get_pte_info(mtkdomain, fault_mva, &pte);
> +               spin_unlock_irqrestore(&mtkdomain->pgtlock, flags);
> +
> +               if (pte.size == MMU_SMALL_PAGE_SIZE ||
> +                   pte.size == MMU_LARGE_PAGE_SIZE) {
> +                       dev_err_ratelimited(
> +                               dev,
> +                               "fault:port=%s iova=0x%x pa=0x%x layer=%d %s;"
> +                               "pgd(0x%x)->pte(0x%x)->pa(%pad)sz(0x%x)Valid(%d)\n",
> +                               mtk_iommu_get_port_name(piommu, m4u_port),
> +                               fault_mva, fault_pa, layer,
> +                               write ? "write" : "read",
> +                               imu_pgd_val(*pte.pgd), imu_pte_val(*pte.pte),
> +                               &pte.pa, pte.size, pte.valid);
> +               } else {
> +                       dev_err_ratelimited(
> +                               dev,
> +                               "fault:port=%s iova=0x%x pa=0x%x layer=%d %s;"
> +                               "pgd(0x%x)->pa(%pad)sz(0x%x)Valid(%d)\n",
> +                               mtk_iommu_get_port_name(piommu, m4u_port),
> +                               fault_mva, fault_pa, layer,
> +                               write ? "write" : "read",
> +                               imu_pgd_val(*pte.pgd),
> +                               &pte.pa, pte.size, pte.valid);
> +               }
> +       }
> +
> +       if (int_state & F_INT_MAIN_MULTI_HIT_FAULT(m4u_slave_id))
> +               dev_err_ratelimited(dev, "multi-hit!port=%s iova=0x%x\n",
> +                                   mtk_iommu_get_port_name(piommu, m4u_port),
> +                                   fault_mva);
> +
> +       if (int_state & F_INT_INVALID_PA_FAULT(m4u_slave_id)) {
> +               if (!(int_state & F_INT_TRANSLATION_FAULT(m4u_slave_id)))
> +                       dev_err_ratelimited(dev, "invalid pa!port=%s iova=0x%x\n",
> +                                           mtk_iommu_get_port_name(piommu,
> +                                                                   m4u_port),
> +                                           fault_mva);
> +       }
> +       if (int_state & F_INT_ENTRY_REPLACEMENT_FAULT(m4u_slave_id))
> +               dev_err_ratelimited(dev, "replace-fault!port=%s iova=0x%x\n",
> +                                   mtk_iommu_get_port_name(piommu, m4u_port),
> +                                   fault_mva);
> +
> +       if (int_state & F_INT_TLB_MISS_FAULT(m4u_slave_id))
> +               dev_err_ratelimited(dev, "tlb miss-fault!port=%s iova=0x%x\n",
> +                                   mtk_iommu_get_port_name(piommu, m4u_port),
> +                                   fault_mva);
> +
> +       mtk_iommu_invalidate_tlb(piommu, 1, 0, 0);
> +
> +       mtk_iommu_clear_intr(m4u_base);

As per my comment above, most of what is happening in this function
should be actually done in interrupt handler, excluding printing of
course.

> +
> +       return 0;
> +}
> +
> +static int mtk_iommu_parse_dt(struct platform_device *pdev,
> +                             struct mtk_iommu_info *piommu)
> +{
> +       struct device *piommudev = &pdev->dev;
> +       struct device_node *ofnode;
> +       struct resource *res;
> +       unsigned int mtk_iommu_cell = 0;
> +       unsigned int i;
> +
> +       ofnode = piommudev->of_node;

You could do this assignment on the same line as declaration.

nit: The usual naming convention for such variables are "dev" for
struct device * and "np" for struct device_node *.

> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       piommu->m4u_base = devm_ioremap_resource(&pdev->dev, res);

nit: There doesn't seem to be any other "bases" involved in this
driver. Could you simply name the field "base", without the obvious
prefix "m4u_"?

> +       if (IS_ERR(piommu->m4u_base)) {
> +               dev_err(piommudev, "m4u_base %p err\n", piommu->m4u_base);
> +               goto iommu_dts_err;
> +       }
> +
> +       piommu->irq = platform_get_irq(pdev, 0);
> +       if (piommu->irq < 0) {
> +               dev_err(piommudev, "irq err %d\n", piommu->irq);

Please keep the messages human readable, e.g. "Failed to get IRQ (%d)\n"

> +               goto iommu_dts_err;
> +       }
> +
> +       piommu->m4u_infra_clk = devm_clk_get(piommudev, "infra_m4u");
> +       if (IS_ERR(piommu->m4u_infra_clk)) {
> +               dev_err(piommudev, "clk err %p\n", piommu->m4u_infra_clk);

"Failed to get clock 'infra_m4u' (%d)\n" (and extract the error code
using PTR_ERR() helper.

> +               goto iommu_dts_err;
> +       }
> +
> +       of_property_read_u32(ofnode, "#iommu-cells", &mtk_iommu_cell);
> +       if (mtk_iommu_cell != 1) {
> +               dev_err(piommudev, "iommu-cell fail:%d\n", mtk_iommu_cell);
> +               goto iommu_dts_err;
> +       }

I don't think you should be checking this here. The function
performing translation from phandle and specifier should check whether
the correct cell count was provided.

> +
> +       for (i = 0; i < piommu->imucfg->larb_nr; i++) {
> +               struct device_node *larbnode;
> +
> +               larbnode = of_parse_phandle(ofnode, "larb", i);
> +               piommu->larbpdev[i] = of_find_device_by_node(larbnode);
> +               of_node_put(larbnode);

I need to take a look at further changes, but this looks like syscon
should be used here instead of using the device directly.

> +               if (!piommu->larbpdev[i]) {
> +                       dev_err(piommudev, "larb pdev fail@larb%d\n", i);
> +                       goto iommu_dts_err;
> +               }
> +       }
> +
> +       return 0;
> +
> +iommu_dts_err:
> +       return -EINVAL;

Please return the return value that actually brought us here.

> +}
> +
> +static int mtk_iommu_hw_init(const struct mtk_iommu_domain *mtkdomain)
> +{
> +       struct mtk_iommu_info *piommu = mtkdomain->piommuinfo;
> +       void __iomem *gm4ubaseaddr = piommu->m4u_base;

Hmm, gm4ubaseaddr is exactly as long as piommu->base (if you follow my
comment to rename this field). In general,

> +       phys_addr_t protectpa;
> +       u32 regval, protectreg;
> +       int ret = 0;
> +
> +       ret = clk_prepare_enable(piommu->m4u_infra_clk);
> +       if (ret) {
> +               dev_err(piommu->dev, "m4u clk enable error\n");
> +               return -ENODEV;
> +       }
> +
> +       writel((u32)mtkdomain->pgd_pa, gm4ubaseaddr + REG_MMUG_PT_BASE);

Why this has to be casted? Is the type of pgd_pa field correct?

> +
> +       regval = F_MMU_CTRL_REROUTE_PFQ_TO_MQ_EN |
> +               F_MMU_CTRL_TF_PROT_VAL(2) |
> +               F_MMU_CTRL_COHERE_EN;
> +       writel(regval, gm4ubaseaddr + REG_MMU_CTRL_REG);
> +
> +       writel(0x6f, gm4ubaseaddr + REG_MMU_INT_L2_CONTROL);
> +       writel(0xffffffff, gm4ubaseaddr + REG_MMU_INT_MAIN_CONTROL);

Please define all the bitfields and use the definitions here instead
of magic numbers.

> +
> +       /* protect memory,HW will write here while translation fault */
> +       protectpa = __virt_to_phys(piommu->protect_va);

Why the underscore variant? virt_to_phys() should be just fine.

> +       protectpa = ALIGN(protectpa, MTK_PROTECT_PA_ALIGN);

Shouldn't protect_va be already aligned?

> +       protectreg = (u32)F_MMU_IVRP_PA_SET(protectpa);

Again, why is this cast needed?

> +       writel(protectreg, gm4ubaseaddr + REG_MMU_IVRP_PADDR);
> +
> +       writel(0, gm4ubaseaddr + REG_MMU_DCM_DIS);
> +       writel(0, gm4ubaseaddr + REG_MMU_STANDARD_AXI_MODE);
> +
> +       return 0;
> +}
> +
> +static inline void mtk_iommu_config_port(struct mtk_iommu_info *piommu,
> +                                        int portid)

Please let the compiler decide whether to inline this function or not.

> +{
> +       int larb, larb_port;
> +
> +       larb = piommu->imucfg->pport[portid].larb_id;
> +       larb_port = piommu->imucfg->pport[portid].port_id;
> +
> +       mtk_smi_config_port(piommu->larbpdev[larb], larb_port);
> +}
> +
> +/*
> + * pimudev is a global var for dma_alloc_coherent.
> + * It is not accepatable, we will delete it if "domain_alloc" is enabled
> + */
> +static struct device *pimudev;

This is indeed not acceptable. Could you replace dma_alloc_coherent()
with something that doesn't require device pointer, e.g.
alloc_pages()? (Although that would require you to handle cache
maintenance in the driver, due to cached memory allocated.) I need to
think about a better solution for this.

OK. Enough for part 2. Stay tuned for part 3.

Best regards,
Tomasz
