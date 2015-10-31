From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Sat, 31 Oct 2015 16:28:17 +0800
Message-ID: <1446280097.13050.88.camel@mhfsdcap03>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
	<1444357388-30257-6-git-send-email-yong.wu@mediatek.com>
	<562F7B46.1040109@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <562F7B46.1040109-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-10-27 at 13:25 +0000, Robin Murphy wrote:
> On 09/10/15 03:23, Yong Wu wrote:
> [...]
> > +#include <linux/io.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/module.h>
> > +#include <linux/iommu.h>
> > +#include <linux/dma-iommu.h>
> > +#include <linux/of_iommu.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/list.h>
> > +#include <linux/clk.h>
> > +#include <linux/iopoll.h>
> 
> Nit: ordering?

Yes. Thanks. I will order them in next time.

> 
> > +#include <soc/mediatek/smi.h>
> > +#include "io-pgtable.h"
> 
> [...]
> > +struct mtk_iommu_data {
> > +	void __iomem			*base;
> > +	int				irq;
> > +	struct device			*dev;
> > +	struct device			*larbdev[MTK_IOMMU_LARB_MAX_NR];
> > +	struct clk			*bclk;
> > +	phys_addr_t			protect_base; /* protect memory base */
> > +	int				larb_nr;/* local arbiter number */
> > +	struct mtk_iommu_suspend_reg	reg;
> > +};
> 
> I think I've finally got my head round the way this hardware works - 
> each LARB can be configured to block or allow transactions from the 
> client device behind each port, but they _don't_ otherwise pass any 
> information downstream such that the M4U itself can identify individual 
> transactions, right? If that is indeed the case, then Joerg is totally 
> correct that all clients of one M4U should be in a single group, so you 
> might as well keep a handy iommu_group pointer here. I'll refer back to 
> that idea later...

I will put them into a single group and rebase Joerg's patchset(iommu:
Make core iommu-groups code more generic) too. see later.

> 
> [...]
> > +static void mtk_iommu_clear_intr(const struct mtk_iommu_data *data)
> > +{
> > +	u32 val;
> > +
> > +	val = readl_relaxed(data->base + REG_MMU_INT_CONTROL0);
> > +	val |= F_INT_L2_CLR_BIT;
> > +	writel_relaxed(val, data->base + REG_MMU_INT_CONTROL0);
> > +}
> 
> Do you anticipate any other callers of this? AFAICS these 3 lines could 
> just be rolled into mtk_iommu_isr().

Yes. Thanks. We can put it into the isr.

> 
> > +static void mtk_iommu_tlb_flush_all(void *cookie)
> > +{
> > +	struct mtk_iommu_domain *domain = cookie;
> > +	void __iomem *base;
> > +
> > +	base = domain->data->base;
> > +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
> > +	writel_relaxed(F_ALL_INVLD, base + REG_MMU_INVALIDATE);
> > +	mb();/* Make sure flush all done */
> 
> If it's purely to make sure the write has completed, would wmb() be 
> sufficient here?

YES.

> 
> > +}
> > +
> > +static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
> > +				    bool leaf, void *cookie)
> > +{
> > +	struct mtk_iommu_domain *domain = cookie;
> > +	void __iomem *base = domain->data->base;
> > +	unsigned int iova_start = iova, iova_end = iova + size - 1;
> 
> Nit: why not simply name the argument iova_start in the first place, or 
> just use iova below?

I will delete them and just use "iova" below.

> 
> > +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
> > +
> > +	writel_relaxed(iova_start, base + REG_MMU_INVLD_START_A);
> > +	writel_relaxed(iova_end, base + REG_MMU_INVLD_END_A);
> > +	writel_relaxed(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);
> > +}
> > +
> > +static void mtk_iommu_tlb_sync(void *cookie)
> > +{
> > +	struct mtk_iommu_domain *domain = cookie;
> > +	void __iomem *base = domain->data->base;
> > +	int ret;
> > +	u32 tmp;
> > +
> > +	ret = readl_poll_timeout_atomic(base + REG_MMU_CPE_DONE, tmp,
> > +					tmp != 0, 10, 1000000);
> > +	if (ret) {
> > +		dev_warn(domain->data->dev,
> > +			 "Partial TLB flush timed out, falling back to full flush\n");
> > +		mtk_iommu_tlb_flush_all(cookie);
> > +	}
> > +	writel_relaxed(0, base + REG_MMU_CPE_DONE);
> 
> Do you still need this writeback in the ret==0 case when you've already 
> read CPE_DONE as 0, or should this be inside the condition? (in which 
> case you could also use an early return to lose the indent)

Yes. I still need this writeback in the ret==0 case.

REG_MMU_CPE_DONE is the state of CPE. It's 1 while the non-secure range
invalidation is done. Write 1'b0 is for the purpose of clearing the
current status, then we could check the next status again. So "write 1"
is also needed in ret==0 case.

so I will keep it and add a comment for more readable here.

writel_relaxed(0, base + REG_MMU_CPE_DONE);/* Clear the CPE state */

> 
> > +}
> [...]
> > +static int mtk_iommu_hw_init(const struct mtk_iommu_domain *mtkdom)
> > +{
> > +	struct mtk_iommu_data *data = mtkdom->data;
> > +	void __iomem *base = data->base;
> > +	u32 regval;
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(data->bclk);
> > +	if (ret) {
> > +		dev_err(data->dev, "Failed to enable iommu clk(%d)\n", ret);
> > +		return ret;
> > +	}
> 
> I'm not sure about the asymmetry here; the clock gets enabled when 
> attaching clients to a domain, but not disabled until the IOMMU itself 
> is torn down in mtk_iommu_remove() (i.e. never). It seems like either 
> the clock should be enabled in mtk_iommu_probe(), or disabled in domain 
> detach.

>From your comment, I realize that some places here is not asymmetry.
I will move this mtk_iommu_hw_init into mtk_iommu_probe.

> 
> > +	writel_relaxed(mtkdom->cfg.arm_short_cfg.ttbr[0],
> > +		       base + REG_MMU_PT_BASE_ADDR);
> > +
> > +	regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
> > +		F_MMU_TF_PROTECT_SEL(2) |
> > +		F_COHERENCE_EN;
> > +	writel_relaxed(regval, base + REG_MMU_CTRL_REG);
> > +
> > +	regval = F_L2_MULIT_HIT_EN |
> > +		F_TABLE_WALK_FAULT_INT_EN |
> > +		F_PREETCH_FIFO_OVERFLOW_INT_EN |
> > +		F_MISS_FIFO_OVERFLOW_INT_EN |
> > +		F_PREFETCH_FIFO_ERR_INT_EN |
> > +		F_MISS_FIFO_ERR_INT_EN;
> > +	writel_relaxed(regval, base + REG_MMU_INT_CONTROL0);
> > +
> > +	regval = F_INT_TRANSLATION_FAULT |
> > +		F_INT_MAIN_MULTI_HIT_FAULT |
> > +		F_INT_INVALID_PA_FAULT |
> > +		F_INT_ENTRY_REPLACEMENT_FAULT |
> > +		F_INT_TLB_MISS_FAULT |
> > +		F_INT_MISS_TRANSATION_FIFO_FAULT |
> > +		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
> > +	writel_relaxed(regval, base + REG_MMU_INT_MAIN_CONTROL);
> > +
> > +	regval = ALIGN(data->protect_base, MTK_PROTECT_PA_ALIGN);
> > +	regval = F_MMU_IVRP_PA_SET(regval);
> 
>  From the look of it, it might not hurt to just fold the ALIGN() into 
> the F_MMU_IVRP_PA_SET() macro itself.

      If the ALIGN is moved into the macro, that line will be over 80
chars. so I seperate them.
      In the next version I will align data->protect_base in probe,
then the code here will be more simply. and it also could be used in
mtk_iommu_resume.
      
> 
> > +	writel_relaxed(regval, base + REG_MMU_IVRP_PADDR);
> > +
> > +	writel_relaxed(0, base + REG_MMU_DCM_DIS);
> > +	writel_relaxed(0, base + REG_MMU_STANDARD_AXI_MODE);
> > +
> > +	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
> > +			     dev_name(data->dev), (void *)mtkdom)) {
> > +		writel_relaxed(0, base + REG_MMU_PT_BASE_ADDR);
> > +		clk_disable_unprepare(data->bclk);
> > +		dev_err(data->dev, "Failed @ IRQ-%d Request\n", data->irq);
> > +		return -ENODEV;
> > +	}
> 
> Maybe balance this with a devm_free_irq() in mtk_iommu_domain_free()? 
> (otherwise it's hanging around forever since the platform bus never 
> seems to get destroyed)

I will move the mtk_iommu_hw_init into mtk_iommu_probe, and add
devm_free_irq into mtk_iommu_remove.
(I cann't add devm_free_irq in mtk_iommu_domain_free and detach_device)

> 
> > +	return 0;
> > +}
> > +
> > +static int mtk_iommu_config(struct mtk_iommu_domain *mtkdom
> > +			    struct device *dev, bool enable)
> > +{
> > +	struct mtk_iommu_data *data = mtkdom->data;
> > +	struct mtk_iommu_client_priv *head, *cur, *next;
> > +
> > +	head = dev->archdata.iommu;
> > +	list_for_each_entry_safe(cur, next, &head->client, client) {
> > +		if (cur->larbid >= data->larb_nr) {
> > +			dev_err(data->dev, "Invalid larb:%d\n", cur->larbid);
> > +			return -EINVAL;
> > +		}
> > +
> > +		mtk_smi_config_port(data->larbdev[cur->larbid],
> > +				    cur->portid, enable);
> > +		if (!enable) {
> > +			list_del(&cur->client);
> > +			kfree(cur);
> > +		}
> 
> This list wasn't created by attach_device(), so it doesn't look right 
> that detach_device() should cause it to be freed - I think this teardown 
> belongs in mtk_iommu_remove_device(), as the counterpoint to the 
> of_xlate/add_device operation.

It is also asymmetry here. I will move kfree into
mtk_iommu_remove_device.

> 
> > +	}
> > +
> > +	if (!enable) {
> > +		kfree(head);
> > +		dev->archdata.iommu = NULL;
> 
> Ditto.
> 
> > +	}
> > +	return 0;
> > +}
> [...]
> > +static int mtk_iommu_attach_device(struct iommu_domain *domain,
> > +				   struct device *dev)
> > +{
> > +	struct mtk_iommu_domain *priv = to_mtk_domain(domain), *m4udom;
> > +	struct iommu_group *group;
> > +	struct mtk_iommu_client_priv *clientpriv;
> > +	struct device *m4udev;
> > +	int ret;
> > +
> > +	clientpriv = dev->archdata.iommu;
> > +	if (!clientpriv)
> > +		return -ENODEV;
> > +	m4udev = clientpriv->m4udev;
> > +
> > +	/*
> > +	 * There is a domain for each a iommu device in normal case.
> > +	 * But MTK only has one iommu domain called the m4u domain which all
> > +	 * the multimedia HW share. Here we reserve one as the m4u domain and
> > +	 * free the others.
> > +	 *
> > +	 * And the attach_device that from __iommu_setup_dma_ops
> > +	 * will be called earlier than probe.
> > +	 */
> > +	m4udom = dev_get_drvdata(m4udev);
> > +	if (!m4udom)
> > +		dev_set_drvdata(m4udev, priv);
> > +	else if (m4udom != priv)
> > +		iommu_domain_free(domain);
> 
> With the client devices in a single group, then I realise we shouldn't 
> actually need any special handling of domains at all - we can freely 
> create multiple domains, and since the group can only be attached to one 
> at a time, all we do is point the hardware at the relevant page table on 
> attach, and reset it on detach. That should make life somewhat easier, 
> and means we no longer have to subvert the IOMMU API like this.

"we can freely create multiple domains", 
Do we need to free the unnecessary domain here?

This function also is a little complex after changed to a single group.
see below.

> 
> > +	group = iommu_group_get(dev);
> > +	if (!group)
> 
> Either way you shouldn't need this - you've already bailed out if this 
> isn't one of your client devices (via the dev->archdata.iommu check), 
> and if it is, then it already has a group by virtue of 
> mtk_iommu_add_device()...

I think I can not use "dev->archdata.iommu" to break here.
Like the comment "the attach_device that from __iommu_setup_dma_ops
will be called earlier than probe."

If I use dev->archdata.iommu, the code will also go down. But at that
time some data has not been initialization(dev_get_drvdata is null).

So I use iommu_group_get to guarantee the sequence: The code could go
down only after the mtk_iommu_probe.


> 
> > +		return 0;
> 
> ...and regardless, indicating success without attaching anything to 
> anything looks very off.

I have to return "0" here.
I need the DMA help update dev->archdata.dma_ops into iommu_dma_ops.
(If I don't return 0 here, the do_iommu_attach will never update
archdata->dma_ops for the client device.)

If I am wrong, please tell me. Thanks.

> 
> > +	iommu_group_put(group);
> > +
> > +	/* Initial the m4u domain context which is from the add_device */
> > +	ret = mtk_iommu_init_domain_context(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return mtk_iommu_config(priv, dev, true);
> > +}
> [...]
> > +static int mtk_iommu_add_device(struct device *dev)
> > +{
> > +	struct iommu_group *group;
> > +	struct mtk_iommu_client_priv *priv;
> > +	struct mtk_iommu_domain *m4udom;
> > +	struct iommu_domain *domain;
> > +	int ret;
> > +
> > +	if (!dev->archdata.iommu) /* Not a iommu client device */
> > +		return -ENODEV;
> > +
> > +	group = iommu_group_get(dev);
> 
> If this became just a case of looking up mtk_iommu_data->group in 
> archdata.iommu and adding this device to it, then everything else here 
> should be able to go away - the arch code will create a default domain 
> for the first device in the group, then sees each subsequent device 
> appear in that domain as you add them, so just sets their dma_ops 
> without any further interference (I have tested multi-device groups!)

Do you mean this function "iommu_group_get_for_dev" which will create a
default domain?
I also notice that Joerg's "iommu: Make core iommu-groups code more
generic" patchset has a device_group callback, then I could return the
same iommu group easily.
So I add this patchset and test, then the code flow is changed greatly.
see below.

> 
> > +	if (!group) {
> > +		group = iommu_group_alloc();
> > +		if (IS_ERR(group)) {
> > +			dev_err(dev, "Failed to allocate IOMMU group\n");
> > +			return PTR_ERR(group);
> > +		}
> > +	}
> 
> (although you might still need the lazy group allocation here if 
> mtk_iommu_probe() turns out to run too early to do it).
> 
> > +	ret = iommu_group_add_device(group, dev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to add IOMMU group\n");
> > +		goto err_group_put;
> > +	}
> > +
> > +	domain = iommu_get_domain_for_dev(dev);
> > +	if (!domain) {
> > +		/*
> > +		 * Get the m4u iommu domain from the m4u device.
> > +		 * Attach all the client devices into the m4u domain.
> > +		 */
> > +		priv = dev->archdata.iommu;
> > +		m4udom = dev_get_drvdata(priv->m4udev);
> > +		ret = iommu_attach_group(&m4udom->domain, group);
> > +		if (ret)
> > +			dev_err(dev, "Failed to attach IOMMU group\n");
> > +	}
> > +
> > +err_group_put:
> > +	iommu_group_put(group);
> > +	return ret;
> > +}
> [...]
> > +static int mtk_iommu_init_fn(struct device_node *np)
> > +{
> > +	struct platform_device *pdev;
> > +
> > +	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
> 
> Hmm, is it OK that the driver isn't yet registered at this point? If you 
> can guarantee that none of the client devices will also be registering 
> their drivers at subsys_initcall level, then I guess it works out 
> reasonably safe in practice, but it still smells a bit racy.

Do you means that we could delete of_platform_device_create here if I
can guarantee none of the client devices is registered at
subsys_initcall level?

I think all the iommu client devices should be called after our iommu
device, but it will be more safe if there is of_platform_device_create
here.

sorry, I may misunderstand here.

> 
> > +	if (IS_ERR(pdev))
> > +		return PTR_ERR(pdev);
> > +
> > +	of_iommu_set_ops(np, &mtk_iommu_ops);
> > +
> > +	return 0;
> > +}
> > +
> > +IOMMU_OF_DECLARE(mtkm4u, "mediatek,mt8173-m4u", mtk_iommu_init_fn);
> > +
> > +static int mtk_iommu_probe(struct platform_device *pdev)
> > +{
> > +	struct mtk_iommu_data   *data;
> > +	struct device           *dev = &pdev->dev;
> > +	struct mtk_iommu_domain *m4udom;
> > +	void __iomem	        *protect;
> > +	int                     ret;
> > +
> > +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +	data->dev = dev;
> > +
> > +	/* Protect memory. HW will access here while translation fault.*/
> > +	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
> > +	if (!protect)
> > +		return -ENOMEM;
> > +	data->protect_base = virt_to_phys(protect);
> > +
> > +	ret = mtk_iommu_parse_dt(pdev, data);
> > +	if (ret)
> > +		return ret;
> 
> Hopefully you could allocate your group here and avoid the extra 
> complication in add_device, but it might be problematic if the early 
> device creation means this gets called before sysfs is fully up and running.

If I use Joerg's patch, then we don't need allocate the group here.

> 
> > +	m4udom = dev_get_drvdata(dev);
> > +	if (m4udom)
> > +		m4udom->data = data;
> > +
> > +	return 0;
> > +}
> [...]
> > +static int mtk_iommu_resume(struct device *dev)
> > +{
> > +	struct mtk_iommu_domain *mtkdom = dev_get_drvdata(dev);
> > +	struct mtk_iommu_suspend_reg *reg;
> > +	void __iomem *base;
> > +
> > +	if (!mtkdom)
> > +		return 0;
> > +
> > +	reg = &mtkdom->data->reg;
> > +	base = mtkdom->data->base;
> > +	writel_relaxed(mtkdom->cfg.arm_short_cfg.ttbr[0],
> > +		       base + REG_MMU_PT_BASE_ADDR);
> > +	writel_relaxed(reg->standard_axi_mode,
> > +		       base + REG_MMU_STANDARD_AXI_MODE);
> > +	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
> > +	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
> > +	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
> 
> On closer inspection, it looks pretty cheap to recalculate this one from 
> data->protect_base, so perhaps that could be one less thing to save.

Yes, It's OK.

> 
> > +	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
> > +	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
> > +	return 0;
> > +}
> 
> Robin.
> 

After add Joerg's patchset[1], I test locally and it looks ok.

I copy most of the code here for your confirm.
If there is some place I don't understand your comment exactly, please
help tell me.
(I will sent it as the next version after the Short-desc is reviewed.)

[1]:
http://lists.linuxfoundation.org/pipermail/iommu/2015-October/014764.html

//===========================

struct mtk_iommu_domain {
	struct imu_pgd_t		*pgd;
	spinlock_t			pgtlock; /* lock for page table */

	struct io_pgtable_cfg		cfg;
	struct io_pgtable_ops		*iop;

	struct iommu_domain		domain;
};

struct mtk_iommu_data {
	void __iomem			*base;
	int				irq;
	struct device			*dev;
	struct device			*larbdev[MTK_IOMMU_LARB_MAX_NR];
	struct clk			*bclk;
	phys_addr_t			protect_base; /* protect memory base */
	int				larb_nr;/* local arbiter number */
	struct mtk_iommu_suspend_reg	reg;
	struct mtk_iommu_domain		*m4udom;
	struct iommu_group		*m4ugroup;
};

static void mtk_iommu_tlb_flush_all(void *cookie)
{
	struct mtk_iommu_data *data = cookie;
	void __iomem *base = data->base;

	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
	writel_relaxed(F_ALL_INVLD, base + REG_MMU_INVALIDATE);
	wmb();/* Make sure tlb flush all done */
}

static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
				    bool leaf, void *cookie)
{
	struct mtk_iommu_data *data = cookie;
	void __iomem *base = data->base;

	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);

	writel_relaxed(iova, base + REG_MMU_INVLD_START_A);
	writel_relaxed(iova + size - 1, base + REG_MMU_INVLD_END_A);
	writel_relaxed(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);
}

static void mtk_iommu_tlb_sync(void *cookie)
{
	struct mtk_iommu_data *data = cookie;
	void __iomem *base = data->base;
	int ret;
	u32 tmp;

	ret = readl_poll_timeout_atomic(base + REG_MMU_CPE_DONE, tmp,
					tmp != 0, 10, 1000000);
	if (ret) {
		dev_warn(data->dev,
			 "Partial TLB flush timed out, falling back to full flush\n");
		mtk_iommu_tlb_flush_all(cookie);
	}
	writel_relaxed(0, base + REG_MMU_CPE_DONE); /* Clear the CPE status */
}

static struct iommu_gather_ops mtk_iommu_gather_ops = {
	.tlb_flush_all = mtk_iommu_tlb_flush_all,
	.tlb_add_flush = mtk_iommu_tlb_add_flush,
	.tlb_sync = mtk_iommu_tlb_sync,
};

static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
{
	struct mtk_iommu_data *data = dev_id;
	struct mtk_iommu_domain *mtkdom = data->m4udom;
	u32 int_state, regval, fault_iova, fault_pa;
	unsigned int fault_larb, fault_port;
	bool layer, write;

	/* Read error info from registers */
	int_state = readl_relaxed(data->base + REG_MMU_FAULT_ST1);
	fault_iova = readl_relaxed(data->base + REG_MMU_FAULT_VA);
	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
	fault_iova &= F_MMU_FAULT_VA_MSK;
	fault_pa = readl_relaxed(data->base + REG_MMU_INVLD_PA);
	regval = readl_relaxed(data->base + REG_MMU_INT_ID);
	fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
	fault_port = F_MMU0_INT_ID_PORT_ID(regval);

	if (report_iommu_fault(&mtkdom->domain, data->dev, fault_iova,
			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
		dev_err_ratelimited(
			data->dev,
			"fault type=0x%x iova=0x%x pa=0x%x larb=%d port=%d layer=%d %s\n",
			int_state, fault_iova, fault_pa, fault_larb, fault_port,
			layer, write ? "write" : "read");
	}

	/* Interrupt clear */
	regval = readl_relaxed(data->base + REG_MMU_INT_CONTROL0);
	regval |= F_INT_CLR_BIT;
	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);

	mtk_iommu_tlb_flush_all(data);

	return IRQ_HANDLED;
}

static int mtk_iommu_parse_dt(struct platform_device *pdev,
			      struct mtk_iommu_data *data)
{
	[...]
}

static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
{
	void __iomem *base = data->base;
	u32 regval;
	int ret;

	ret = clk_prepare_enable(data->bclk);
	if (ret) {
		dev_err(data->dev, "Failed to enable iommu bclk(%d)\n", ret);
		return ret;
	}

	regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
		F_MMU_TF_PROTECT_SEL(2) |
		F_COHERENCE_EN;
	writel_relaxed(regval, base + REG_MMU_CTRL_REG);

	regval = F_L2_MULIT_HIT_EN |
		F_TABLE_WALK_FAULT_INT_EN |
		F_PREETCH_FIFO_OVERFLOW_INT_EN |
		F_MISS_FIFO_OVERFLOW_INT_EN |
		F_PREFETCH_FIFO_ERR_INT_EN |
		F_MISS_FIFO_ERR_INT_EN;
	writel_relaxed(regval, base + REG_MMU_INT_CONTROL0);

	regval = F_INT_TRANSLATION_FAULT |
		F_INT_MAIN_MULTI_HIT_FAULT |
		F_INT_INVALID_PA_FAULT |
		F_INT_ENTRY_REPLACEMENT_FAULT |
		F_INT_TLB_MISS_FAULT |
		F_INT_MISS_TRANSATION_FIFO_FAULT |
		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
	writel_relaxed(regval, base + REG_MMU_INT_MAIN_CONTROL);

	regval = F_MMU_IVRP_PA_SET(data->protect_base);
	writel_relaxed(regval, base + REG_MMU_IVRP_PADDR);

	writel_relaxed(0, base + REG_MMU_DCM_DIS);
	writel_relaxed(0, base + REG_MMU_STANDARD_AXI_MODE);

	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
			     dev_name(data->dev), (void *)data)) {
		writel_relaxed(0, base + REG_MMU_PT_BASE_ADDR);
		clk_disable_unprepare(data->bclk);
		dev_err(data->dev, "Failed @ IRQ-%d Request\n", data->irq);
		return -ENODEV;
	}

	return 0;
}

static int mtk_iommu_config(struct mtk_iommu_data *data,
			    struct device *dev, bool enable)
{
	struct mtk_iommu_client_priv *head, *cur, *next;
	int ret;

	head = dev->archdata.iommu;
	list_for_each_entry_safe(cur, next, &head->client, client) {
		if (cur->larbid >= data->larb_nr) {
			dev_err(data->dev, "Invalid larb: %d\n", cur->larbid);
			return -EINVAL;
		}

		ret = mtk_smi_config_port(data->larbdev[cur->larbid],
					  cur->portid, enable);
		if (ret)
			return ret;
	}

	return 0;
}

static int mtk_iommu_init_domain_context(struct mtk_iommu_data *data)
{
	struct mtk_iommu_domain *dom = data->m4udom;

	if (dom->iop)
		return 0;

	spin_lock_init(&dom->pgtlock);
	dom->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS |
			IO_PGTABLE_QUIRK_NO_PERMS |
			IO_PGTABLE_QUIRK_TLBI_ON_MAP |
			IO_PGTABLE_QUIRK_SHORT_SUPERSECTION;
	dom->cfg.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
	dom->cfg.ias = 32;
	dom->cfg.oas = 32;
	dom->cfg.tlb = &mtk_iommu_gather_ops;
	dom->cfg.iommu_dev = data->dev;

	dom->iop = alloc_io_pgtable_ops(ARM_SHORT_DESC, &dom->cfg, data);
	if (!dom->iop) {
		dev_err(data->dev, "Failed to alloc io pgtable\n");
		return -EINVAL;
	}

	/* Update our support page sizes bitmap */
	mtk_iommu_ops.pgsize_bitmap = dom->cfg.pgsize_bitmap;

        /* Update the pagetable base address */
	writel_relaxed(data->m4udom->cfg.arm_short_cfg.ttbr[0],
		       data->base + REG_MMU_PT_BASE_ADDR);
	return 0;
}

static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
{
	struct mtk_iommu_domain *priv;

	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
		return NULL;

	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
	if (!priv)
		return NULL;

	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(&priv->domain)) {
		kfree(priv);
		return NULL;
	}

	priv->domain.geometry.aperture_start = 0;
	priv->domain.geometry.aperture_end = DMA_BIT_MASK(32);
	priv->domain.geometry.force_aperture = true;

	return &priv->domain;
}

static void mtk_iommu_domain_free(struct iommu_domain *domain)
{
	if (domain->type == IOMMU_DOMAIN_DMA)
		iommu_put_dma_cookie(domain);
	kfree(to_mtk_domain(domain));
}

static int mtk_iommu_attach_device(struct iommu_domain *domain,
				   struct device *dev)
{
	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
	struct iommu_group *group;
	struct mtk_iommu_client_priv *priv = dev->archdata.iommu;
	struct mtk_iommu_data *m4udata;
	int ret;

	if (!priv)
		return -ENODEV;

	group = iommu_group_get(dev);
	if (!group) {
		/* __iommu_setup_dma_ops will create a domain for each a device
		 * defaultly, But MTK only has only one iommu domain called the
		 * m4u domain which all the multimedia HW share.
		 * We don't need its default domain here.
		 */
		iommu_domain_free(domain);
		return 0;
	}
	iommu_group_put(group);

	/*
	 * The iommu core will create a default domain for each a iommu group.
	 * This default domain is used for the m4u domain here.
	 */
	m4udata = dev_get_drvdata(priv->m4udev);
	if (!m4udata->m4udom) {
		m4udata->m4udom = dom;
		ret = iommu_dma_init_domain(domain, 0, DMA_BIT_MASK(32));

       <<<=== iommu_group_get_for_dev don't help initialize the domain,
I have to initialize it here.

		if (ret)
			return ret;
	}

	/*
	 * All the client devices are in the same group, they also are in the
	 * same domain. confirm it here.
	 */
	WARN_ON(dom != m4udata->m4udom);

	ret = mtk_iommu_init_domain_context(m4udata);
	if (ret)
		return ret;

	return mtk_iommu_config(m4udata, dev, true);
}

static void mtk_iommu_detach_device(struct iommu_domain *domain,
				    struct device *dev)
{
	struct mtk_iommu_client_priv *priv = dev->archdata.iommu;
	struct mtk_iommu_data *m4udata;
	struct iommu_group *group;

	if (!priv)
		return;

	group = iommu_group_get(dev);
	if (!group)
		return;
	iommu_group_put(group);

	m4udata = dev_get_drvdata(priv->m4udev);
	mtk_iommu_config(m4udata, dev, false);
}

static int mtk_iommu_map(struct iommu_domain *domain, unsigned long
iova,
			 phys_addr_t paddr, size_t size, int prot)
{
	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
	unsigned long flags;
	int ret;

	spin_lock_irqsave(&dom->pgtlock, flags);
	ret = dom->iop->map(dom->iop, iova, paddr, size, prot);
	spin_unlock_irqrestore(&dom->pgtlock, flags);

	return ret;
}

static size_t mtk_iommu_unmap(struct iommu_domain *domain,
			      unsigned long iova, size_t size)
{
	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
	unsigned long flags;
	size_t unmapsize;

	spin_lock_irqsave(&dom->pgtlock, flags);
	unmapsize = dom->iop->unmap(dom->iop, iova, size);
	spin_unlock_irqrestore(&dom->pgtlock, flags);

	return unmapsize;
}

static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
					  dma_addr_t iova)
{
	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
	unsigned long flags;
	phys_addr_t pa;

	spin_lock_irqsave(&dom->pgtlock, flags);
	pa = dom->iop->iova_to_phys(dom->iop, iova);
	spin_unlock_irqrestore(&dom->pgtlock, flags);

	return pa;
}

static int mtk_iommu_add_device(struct device *dev)
{
	struct iommu_group *group;

	if (!dev->archdata.iommu) /* Not a iommu client device */
		return -ENODEV;

	group = iommu_group_get_for_dev(dev);
	if (IS_ERR(group))
		return PTR_ERR(group);

	iommu_group_put(group);
	return 0;
}

static void mtk_iommu_remove_device(struct device *dev)
{
	struct mtk_iommu_client_priv *head, *cur, *next;

	head = dev->archdata.iommu;
	if (!head)
		return;

	list_for_each_entry_safe(cur, next, &head->client, client) {
		list_del(&cur->client);
		kfree(cur);
	}
	kfree(head);
	dev->archdata.iommu = NULL;

	iommu_group_remove_device(dev);
}

static struct iommu_group *mtk_iommu_device_group(struct device *dev)
{
	struct mtk_iommu_data *m4udata;
	struct mtk_iommu_client_priv *priv;

	priv = dev->archdata.iommu;
	if (!priv)
		return ERR_PTR(-ENODEV);
	m4udata = dev_get_drvdata(priv->m4udev);

	/* All the client devices are in the same m4u iommu-group */
	if (!m4udata->m4ugroup) {
		m4udata->m4ugroup = iommu_group_alloc();
		if (IS_ERR(m4udata->m4ugroup))
			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
	}
	return m4udata->m4ugroup;
}

static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args
*args)
{
[...]
}

static struct iommu_ops mtk_iommu_ops = {
	.domain_alloc	= mtk_iommu_domain_alloc,
	.domain_free	= mtk_iommu_domain_free,
	.attach_dev	= mtk_iommu_attach_device,
	.detach_dev	= mtk_iommu_detach_device,
	.map		= mtk_iommu_map,
	.unmap		= mtk_iommu_unmap,
	.map_sg		= default_iommu_map_sg,
	.iova_to_phys	= mtk_iommu_iova_to_phys,
	.add_device	= mtk_iommu_add_device,
	.remove_device	= mtk_iommu_remove_device,
	.device_group	= mtk_iommu_device_group,
	.of_xlate	= mtk_iommu_of_xlate,
	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
};

static const struct of_device_id mtk_iommu_of_ids[] = {
	{ .compatible = "mediatek,mt8173-m4u", },
	{}
};

static int mtk_iommu_init_fn(struct device_node *np)
{
	struct platform_device *pdev;

	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
	if (IS_ERR(pdev))
		return PTR_ERR(pdev);

	of_iommu_set_ops(np, &mtk_iommu_ops);

	return 0;
}

IOMMU_OF_DECLARE(mtkm4u, "mediatek,mt8173-m4u", mtk_iommu_init_fn);

static int mtk_iommu_probe(struct platform_device *pdev)
{
	struct mtk_iommu_data   *data;
	struct device           *dev = &pdev->dev;
	void __iomem	        *protect;
	int                     ret;

	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
	if (!data)
		return -ENOMEM;
	data->dev = dev;

	/* Protect memory. HW will access here while translation fault.*/
	protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
	if (!protect)
		return -ENOMEM;
	data->protect_base = ALIGN(virt_to_phys(protect),
MTK_PROTECT_PA_ALIGN);

	ret = mtk_iommu_parse_dt(pdev, data);
	if (ret)
		return ret;

	ret = mtk_iommu_hw_init(data);
	if (ret)
		return ret;

	dev_set_drvdata(dev, data);

	return 0;
}

static int mtk_iommu_remove(struct platform_device *pdev)
{
	struct mtk_iommu_data *data = dev_get_drvdata(&pdev->dev);

	free_io_pgtable_ops(data->m4udom->iop); /* Destroy domain context */
       <<<===== the free domain-context is also asymmetric too, but I
can not move it into detach_device, the detach_device may be called the
client device. the domain cann't be freed by a client device.

	clk_disable_unprepare(data->bclk);
	devm_free_irq(&pdev->dev, data->irq, data);
	return 0;
}

//===========================
