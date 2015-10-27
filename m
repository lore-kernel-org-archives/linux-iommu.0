From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Tue, 27 Oct 2015 13:25:26 +0000
Message-ID: <562F7B46.1040109@arm.com>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
	<1444357388-30257-6-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1444357388-30257-6-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/10/15 03:23, Yong Wu wrote:
[...]
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/iommu.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/of_iommu.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/list.h>
> +#include <linux/clk.h>
> +#include <linux/iopoll.h>

Nit: ordering?

> +#include <soc/mediatek/smi.h>
> +#include "io-pgtable.h"

[...]
> +struct mtk_iommu_data {
> +	void __iomem			*base;
> +	int				irq;
> +	struct device			*dev;
> +	struct device			*larbdev[MTK_IOMMU_LARB_MAX_NR];
> +	struct clk			*bclk;
> +	phys_addr_t			protect_base; /* protect memory base */
> +	int				larb_nr;/* local arbiter number */
> +	struct mtk_iommu_suspend_reg	reg;
> +};

I think I've finally got my head round the way this hardware works - 
each LARB can be configured to block or allow transactions from the 
client device behind each port, but they _don't_ otherwise pass any 
information downstream such that the M4U itself can identify individual 
transactions, right? If that is indeed the case, then Joerg is totally 
correct that all clients of one M4U should be in a single group, so you 
might as well keep a handy iommu_group pointer here. I'll refer back to 
that idea later...

[...]
> +static void mtk_iommu_clear_intr(const struct mtk_iommu_data *data)
> +{
> +	u32 val;
> +
> +	val = readl_relaxed(data->base + REG_MMU_INT_CONTROL0);
> +	val |= F_INT_L2_CLR_BIT;
> +	writel_relaxed(val, data->base + REG_MMU_INT_CONTROL0);
> +}

Do you anticipate any other callers of this? AFAICS these 3 lines could 
just be rolled into mtk_iommu_isr().

> +static void mtk_iommu_tlb_flush_all(void *cookie)
> +{
> +	struct mtk_iommu_domain *domain = cookie;
> +	void __iomem *base;
> +
> +	base = domain->data->base;
> +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
> +	writel_relaxed(F_ALL_INVLD, base + REG_MMU_INVALIDATE);
> +	mb();/* Make sure flush all done */

If it's purely to make sure the write has completed, would wmb() be 
sufficient here?

> +}
> +
> +static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
> +				    bool leaf, void *cookie)
> +{
> +	struct mtk_iommu_domain *domain = cookie;
> +	void __iomem *base = domain->data->base;
> +	unsigned int iova_start = iova, iova_end = iova + size - 1;

Nit: why not simply name the argument iova_start in the first place, or 
just use iova below?

> +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
> +
> +	writel_relaxed(iova_start, base + REG_MMU_INVLD_START_A);
> +	writel_relaxed(iova_end, base + REG_MMU_INVLD_END_A);
> +	writel_relaxed(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);
> +}
> +
> +static void mtk_iommu_tlb_sync(void *cookie)
> +{
> +	struct mtk_iommu_domain *domain = cookie;
> +	void __iomem *base = domain->data->base;
> +	int ret;
> +	u32 tmp;
> +
> +	ret = readl_poll_timeout_atomic(base + REG_MMU_CPE_DONE, tmp,
> +					tmp != 0, 10, 1000000);
> +	if (ret) {
> +		dev_warn(domain->data->dev,
> +			 "Partial TLB flush timed out, falling back to full flush\n");
> +		mtk_iommu_tlb_flush_all(cookie);
> +	}
> +	writel_relaxed(0, base + REG_MMU_CPE_DONE);

Do you still need this writeback in the ret==0 case when you've already 
read CPE_DONE as 0, or should this be inside the condition? (in which 
case you could also use an early return to lose the indent)

> +}
[...]
> +static int mtk_iommu_hw_init(const struct mtk_iommu_domain *mtkdom)
> +{
> +	struct mtk_iommu_data *data = mtkdom->data;
> +	void __iomem *base = data->base;
> +	u32 regval;
> +	int ret;
> +
> +	ret = clk_prepare_enable(data->bclk);
> +	if (ret) {
> +		dev_err(data->dev, "Failed to enable iommu clk(%d)\n", ret);
> +		return ret;
> +	}

I'm not sure about the asymmetry here; the clock gets enabled when 
attaching clients to a domain, but not disabled until the IOMMU itself 
is torn down in mtk_iommu_remove() (i.e. never). It seems like either 
the clock should be enabled in mtk_iommu_probe(), or disabled in domain 
detach.

> +	writel_relaxed(mtkdom->cfg.arm_short_cfg.ttbr[0],
> +		       base + REG_MMU_PT_BASE_ADDR);
> +
> +	regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> +		F_MMU_TF_PROTECT_SEL(2) |
> +		F_COHERENCE_EN;
> +	writel_relaxed(regval, base + REG_MMU_CTRL_REG);
> +
> +	regval = F_L2_MULIT_HIT_EN |
> +		F_TABLE_WALK_FAULT_INT_EN |
> +		F_PREETCH_FIFO_OVERFLOW_INT_EN |
> +		F_MISS_FIFO_OVERFLOW_INT_EN |
> +		F_PREFETCH_FIFO_ERR_INT_EN |
> +		F_MISS_FIFO_ERR_INT_EN;
> +	writel_relaxed(regval, base + REG_MMU_INT_CONTROL0);
> +
> +	regval = F_INT_TRANSLATION_FAULT |
> +		F_INT_MAIN_MULTI_HIT_FAULT |
> +		F_INT_INVALID_PA_FAULT |
> +		F_INT_ENTRY_REPLACEMENT_FAULT |
> +		F_INT_TLB_MISS_FAULT |
> +		F_INT_MISS_TRANSATION_FIFO_FAULT |
> +		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
> +	writel_relaxed(regval, base + REG_MMU_INT_MAIN_CONTROL);
> +
> +	regval = ALIGN(data->protect_base, MTK_PROTECT_PA_ALIGN);
> +	regval = F_MMU_IVRP_PA_SET(regval);

 From the look of it, it might not hurt to just fold the ALIGN() into 
the F_MMU_IVRP_PA_SET() macro itself.

> +	writel_relaxed(regval, base + REG_MMU_IVRP_PADDR);
> +
> +	writel_relaxed(0, base + REG_MMU_DCM_DIS);
> +	writel_relaxed(0, base + REG_MMU_STANDARD_AXI_MODE);
> +
> +	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> +			     dev_name(data->dev), (void *)mtkdom)) {
> +		writel_relaxed(0, base + REG_MMU_PT_BASE_ADDR);
> +		clk_disable_unprepare(data->bclk);
> +		dev_err(data->dev, "Failed @ IRQ-%d Request\n", data->irq);
> +		return -ENODEV;
> +	}

Maybe balance this with a devm_free_irq() in mtk_iommu_domain_free()? 
(otherwise it's hanging around forever since the platform bus never 
seems to get destroyed)

> +	return 0;
> +}
> +
> +static int mtk_iommu_config(struct mtk_iommu_domain *mtkdom
> +			    struct device *dev, bool enable)
> +{
> +	struct mtk_iommu_data *data = mtkdom->data;
> +	struct mtk_iommu_client_priv *head, *cur, *next;
> +
> +	head = dev->archdata.iommu;
> +	list_for_each_entry_safe(cur, next, &head->client, client) {
> +		if (cur->larbid >= data->larb_nr) {
> +			dev_err(data->dev, "Invalid larb:%d\n", cur->larbid);
> +			return -EINVAL;
> +		}
> +
> +		mtk_smi_config_port(data->larbdev[cur->larbid],
> +				    cur->portid, enable);
> +		if (!enable) {
> +			list_del(&cur->client);
> +			kfree(cur);
> +		}

This list wasn't created by attach_device(), so it doesn't look right 
that detach_device() should cause it to be freed - I think this teardown 
belongs in mtk_iommu_remove_device(), as the counterpoint to the 
of_xlate/add_device operation.

> +	}
> +
> +	if (!enable) {
> +		kfree(head);
> +		dev->archdata.iommu = NULL;

Ditto.

> +	}
> +	return 0;
> +}
[...]
> +static int mtk_iommu_attach_device(struct iommu_domain *domain,
> +				   struct device *dev)
> +{
> +	struct mtk_iommu_domain *priv = to_mtk_domain(domain), *m4udom;
> +	struct iommu_group *group;
> +	struct mtk_iommu_client_priv *clientpriv;
> +	struct device *m4udev;
> +	int ret;
> +
> +	clientpriv = dev->archdata.iommu;
> +	if (!clientpriv)
> +		return -ENODEV;
> +	m4udev = clientpriv->m4udev;
> +
> +	/*
> +	 * There is a domain for each a iommu device in normal case.
> +	 * But MTK only has one iommu domain called the m4u domain which all
> +	 * the multimedia HW share. Here we reserve one as the m4u domain and
> +	 * free the others.
> +	 *
> +	 * And the attach_device that from __iommu_setup_dma_ops
> +	 * will be called earlier than probe.
> +	 */
> +	m4udom = dev_get_drvdata(m4udev);
> +	if (!m4udom)
> +		dev_set_drvdata(m4udev, priv);
> +	else if (m4udom != priv)
> +		iommu_domain_free(domain);

With the client devices in a single group, then I realise we shouldn't 
actually need any special handling of domains at all - we can freely 
create multiple domains, and since the group can only be attached to one 
at a time, all we do is point the hardware at the relevant page table on 
attach, and reset it on detach. That should make life somewhat easier, 
and means we no longer have to subvert the IOMMU API like this.

> +	group = iommu_group_get(dev);
> +	if (!group)

Either way you shouldn't need this - you've already bailed out if this 
isn't one of your client devices (via the dev->archdata.iommu check), 
and if it is, then it already has a group by virtue of 
mtk_iommu_add_device()...

> +		return 0;

...and regardless, indicating success without attaching anything to 
anything looks very off.

> +	iommu_group_put(group);
> +
> +	/* Initial the m4u domain context which is from the add_device */
> +	ret = mtk_iommu_init_domain_context(priv);
> +	if (ret)
> +		return ret;
> +
> +	return mtk_iommu_config(priv, dev, true);
> +}
[...]
> +static int mtk_iommu_add_device(struct device *dev)
> +{
> +	struct iommu_group *group;
> +	struct mtk_iommu_client_priv *priv;
> +	struct mtk_iommu_domain *m4udom;
> +	struct iommu_domain *domain;
> +	int ret;
> +
> +	if (!dev->archdata.iommu) /* Not a iommu client device */
> +		return -ENODEV;
> +
> +	group = iommu_group_get(dev);

If this became just a case of looking up mtk_iommu_data->group in 
archdata.iommu and adding this device to it, then everything else here 
should be able to go away - the arch code will create a default domain 
for the first device in the group, then sees each subsequent device 
appear in that domain as you add them, so just sets their dma_ops 
without any further interference (I have tested multi-device groups!)

> +	if (!group) {
> +		group = iommu_group_alloc();
> +		if (IS_ERR(group)) {
> +			dev_err(dev, "Failed to allocate IOMMU group\n");
> +			return PTR_ERR(group);
> +		}
> +	}

(although you might still need the lazy group allocation here if 
mtk_iommu_probe() turns out to run too early to do it).

> +	ret = iommu_group_add_device(group, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to add IOMMU group\n");
> +		goto err_group_put;
> +	}
> +
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (!domain) {
> +		/*
> +		 * Get the m4u iommu domain from the m4u device.
> +		 * Attach all the client devices into the m4u domain.
> +		 */
> +		priv = dev->archdata.iommu;
> +		m4udom = dev_get_drvdata(priv->m4udev);
> +		ret = iommu_attach_group(&m4udom->domain, group);
> +		if (ret)
> +			dev_err(dev, "Failed to attach IOMMU group\n");
> +	}
> +
> +err_group_put:
> +	iommu_group_put(group);
> +	return ret;
> +}
[...]
> +static int mtk_iommu_init_fn(struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);

Hmm, is it OK that the driver isn't yet registered at this point? If you 
can guarantee that none of the client devices will also be registering 
their drivers at subsys_initcall level, then I guess it works out 
reasonably safe in practice, but it still smells a bit racy.

> +	if (IS_ERR(pdev))
> +		return PTR_ERR(pdev);
> +
> +	of_iommu_set_ops(np, &mtk_iommu_ops);
> +
> +	return 0;
> +}
> +
> +IOMMU_OF_DECLARE(mtkm4u, "mediatek,mt8173-m4u", mtk_iommu_init_fn);
> +
> +static int mtk_iommu_probe(struct platform_device *pdev)
> +{
> +	struct mtk_iommu_data   *data;
> +	struct device           *dev = &pdev->dev;
> +	struct mtk_iommu_domain *m4udom;
> +	void __iomem	        *protect;
> +	int                     ret;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	data->dev = dev;
> +
> +	/* Protect memory. HW will access here while translation fault.*/
> +	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
> +	if (!protect)
> +		return -ENOMEM;
> +	data->protect_base = virt_to_phys(protect);
> +
> +	ret = mtk_iommu_parse_dt(pdev, data);
> +	if (ret)
> +		return ret;

Hopefully you could allocate your group here and avoid the extra 
complication in add_device, but it might be problematic if the early 
device creation means this gets called before sysfs is fully up and running.

> +	m4udom = dev_get_drvdata(dev);
> +	if (m4udom)
> +		m4udom->data = data;
> +
> +	return 0;
> +}
[...]
> +static int mtk_iommu_resume(struct device *dev)
> +{
> +	struct mtk_iommu_domain *mtkdom = dev_get_drvdata(dev);
> +	struct mtk_iommu_suspend_reg *reg;
> +	void __iomem *base;
> +
> +	if (!mtkdom)
> +		return 0;
> +
> +	reg = &mtkdom->data->reg;
> +	base = mtkdom->data->base;
> +	writel_relaxed(mtkdom->cfg.arm_short_cfg.ttbr[0],
> +		       base + REG_MMU_PT_BASE_ADDR);
> +	writel_relaxed(reg->standard_axi_mode,
> +		       base + REG_MMU_STANDARD_AXI_MODE);
> +	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
> +	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
> +	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);

On closer inspection, it looks pretty cheap to recalculate this one from 
data->protect_base, so perhaps that could be one less thing to save.

> +	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
> +	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
> +	return 0;
> +}

Robin.
