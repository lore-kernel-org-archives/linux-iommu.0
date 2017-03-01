From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 5/9] iommu: add qcom_iommu
Date: Wed, 1 Mar 2017 15:54:27 -0800
Message-ID: <3d0d6fc9-f8dd-933d-eda2-9a76c95bb70b@codeaurora.org>
References: <20170301174258.14618-1-robdclark@gmail.com>
	<20170301174258.14618-6-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170301174258.14618-6-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/01/2017 09:42 AM, Rob Clark wrote:
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> new file mode 100644
> index 0000000..5d3bb63
> --- /dev/null
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -0,0 +1,825 @@
> +/*
> + * IOMMU API for QCOM secure IOMMUs.  Somewhat based on arm-smmu.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + *
> + * Copyright (C) 2013 ARM Limited
> + * Copyright (C) 2017 Red Hat
> + */
> +
> +#define pr_fmt(fmt) "qcom-iommu: " fmt
> +
> +#include <linux/atomic.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dma-iommu.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/io-64-nonatomic-hi-lo.h>
> +#include <linux/iommu.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_iommu.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/qcom_scm.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>

mutex.h?

> +
> +#include "io-pgtable.h"
> +#include "arm-smmu-regs.h"
> +
> +#define SMMU_INTR_SEL_NS     0x2000
> +
> +struct qcom_iommu_dev {
> +	/* IOMMU core code handle */
> +	struct iommu_device	 iommu;
> +	struct device		*dev;
> +	struct clk		*iface_clk;
> +	struct clk		*bus_clk;
> +	void __iomem		*local_base;
> +	u32			 sec_id;
> +	struct list_head	 context_list;   /* list of qcom_iommu_context */
> +};
> +
> +struct qcom_iommu_ctx {
> +	struct device		*dev;
> +	void __iomem		*base;
> +	unsigned int		 irq;
> +	bool			 secure_init;
> +	u32			 asid;      /* asid and ctx bank # are 1:1 */
> +	struct iommu_group	*group;
> +	struct list_head	 node;      /* head in qcom_iommu_device::context_list */
> +};
> +
> +struct qcom_iommu_domain {
> +	struct io_pgtable_ops	*pgtbl_ops;
> +	spinlock_t		 pgtbl_lock;
> +	struct mutex		 init_mutex; /* Protects iommu pointer */
> +	struct iommu_domain	 domain;
> +	struct qcom_iommu_dev	*iommu;
> +};
> +
> +static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
> +{
> +	return container_of(dom, struct qcom_iommu_domain, domain);
> +}
> +
> +static const struct iommu_ops qcom_iommu_ops;
> +static struct platform_driver qcom_iommu_driver;

Why forward declared?

> +
> +static struct qcom_iommu_dev * __to_iommu(struct iommu_fwspec *fwspec)
> +{
> +	if (WARN_ON(!fwspec || fwspec->ops != &qcom_iommu_ops))
> +		return NULL;
> +	return fwspec->iommu_priv;
> +}
> +
> +static struct qcom_iommu_ctx * __to_ctx(struct iommu_fwspec *fwspec, unsigned asid)
> +{
> +	struct qcom_iommu_dev *qcom_iommu = __to_iommu(fwspec);
> +	struct qcom_iommu_ctx *ctx;
> +
> +	if (!qcom_iommu)
> +		return NULL;
> +
> +	list_for_each_entry(ctx, &qcom_iommu->context_list, node)
> +		if (ctx->asid == asid)
> +			return ctx;
> +
> +	WARN(1, "no ctx for asid %u\n", asid);
> +	return NULL;
> +}
> +
> +static inline void
> +iommu_writel(struct qcom_iommu_ctx *ctx, unsigned reg, u32 val)
> +{
> +	writel_relaxed(val, ctx->base + reg);
> +}
> +
> +static inline void
> +iommu_writeq(struct qcom_iommu_ctx *ctx, unsigned reg, u64 val)
> +{
> +	writeq_relaxed(val, ctx->base + reg);
> +}
> +
> +static inline u32
> +iommu_readl(struct qcom_iommu_ctx *ctx, unsigned reg)
> +{
> +	return readl_relaxed(ctx->base + reg);
> +}
> +
> +static inline u32
> +iommu_readq(struct qcom_iommu_ctx *ctx, unsigned reg)
> +{
> +	return readq_relaxed(ctx->base + reg);
> +}
> +
> +static void __sync_tlb(struct qcom_iommu_ctx *ctx)
> +{
> +	unsigned int val;
> +	unsigned int ret;
> +
> +	iommu_writel(ctx, ARM_SMMU_CB_TLBSYNC, 0);
> +
> +	ret = readl_poll_timeout(ctx->base + ARM_SMMU_CB_TLBSTATUS, val,
> +				 (val & 0x1) == 0, 0, 5000000);
> +	if (ret)
> +		dev_err(ctx->dev, "timeout waiting for TLB SYNC\n");
> +}
> +
> +static void qcom_iommu_tlb_sync(void *cookie)
> +{
> +	struct iommu_fwspec *fwspec = cookie;
> +	unsigned i;
> +
> +	for (i = 0; i < fwspec->num_ids; i++)
> +		__sync_tlb(__to_ctx(fwspec, fwspec->ids[i]));
> +}
> +
> +static void qcom_iommu_tlb_inv_context(void *cookie)
> +{
> +	struct iommu_fwspec *fwspec = cookie;
> +	unsigned i;
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		struct qcom_iommu_ctx *ctx = __to_ctx(fwspec, fwspec->ids[i]);
> +
> +		iommu_writel(ctx, ARM_SMMU_CB_S1_TLBIASID, ctx->asid);
> +		__sync_tlb(ctx);
> +	}
> +}
> +
> +static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
> +					    size_t granule, bool leaf, void *cookie)
> +{
> +	struct iommu_fwspec *fwspec = cookie;
> +	unsigned i, reg;
> +
> +	reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		struct qcom_iommu_ctx *ctx = __to_ctx(fwspec, fwspec->ids[i]);
> +		size_t s = size;
> +
> +		iova &= ~12UL;
> +		iova |= ctx->asid;
> +		do {
> +			iommu_writel(ctx, reg, iova);
> +			iova += granule;
> +		} while (s -= granule);
> +	}
> +}
> +
> +static const struct iommu_gather_ops qcom_gather_ops = {
> +	.tlb_flush_all	= qcom_iommu_tlb_inv_context,
> +	.tlb_add_flush	= qcom_iommu_tlb_inv_range_nosync,
> +	.tlb_sync	= qcom_iommu_tlb_sync,
> +};
> +
> +static irqreturn_t qcom_iommu_fault(int irq, void *dev)
> +{
> +	struct qcom_iommu_ctx *ctx = dev;
> +	u32 fsr, fsynr;
> +	unsigned long iova;
> +
> +	fsr = iommu_readl(ctx, ARM_SMMU_CB_FSR);
> +
> +	if (!(fsr & FSR_FAULT))
> +		return IRQ_NONE;
> +
> +	fsynr = iommu_readl(ctx, ARM_SMMU_CB_FSYNR0);
> +	iova = iommu_readq(ctx, ARM_SMMU_CB_FAR);
> +
> +	dev_err_ratelimited(ctx->dev,
> +			    "Unhandled context fault: fsr=0x%x, "
> +			    "iova=0x%08lx, fsynr=0x%x, cb=%d\n",

Please don't split printk strings across 80 characters. It makes grep hard.

> +			    fsr, iova, fsynr, ctx->asid);
> +
> +	iommu_writel(ctx, ARM_SMMU_CB_FSR, fsr);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int qcom_iommu_init_domain(struct iommu_domain *domain,
> +				  struct qcom_iommu_dev *qcom_iommu,
> +				  struct iommu_fwspec *fwspec)
> +{
> +	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
> +	struct io_pgtable_ops *pgtbl_ops;
> +	struct io_pgtable_cfg pgtbl_cfg;
> +	int i, ret = 0;
> +	u32 reg;
> +
> +	mutex_lock(&qcom_domain->init_mutex);
> +	if (qcom_domain->iommu)
> +		goto out_unlock;
> +
> +	pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.pgsize_bitmap	= qcom_iommu_ops.pgsize_bitmap,
> +		.ias		= 32,
> +		.oas		= 40,
> +		.tlb		= &qcom_gather_ops,
> +		.iommu_dev	= qcom_iommu->dev,
> +	};
> +
> +	qcom_domain->iommu = qcom_iommu;
> +	pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg, fwspec);
> +	if (!pgtbl_ops) {
> +		dev_err(qcom_iommu->dev, "failed to allocate pagetable ops\n");
> +		ret = -ENOMEM;
> +		goto out_clear_iommu;
> +	}
> +
> +	/* Update the domain's page sizes to reflect the page table format */
> +	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> +	domain->geometry.aperture_end = (1ULL << 48) - 1;

Where is 48 coming from? And 32 and 40 for that matter.

> +	domain->geometry.force_aperture = true;
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		struct qcom_iommu_ctx *ctx = __to_ctx(fwspec, fwspec->ids[i]);
> +
> +		if (!ctx->secure_init) {
> +			ret = qcom_scm_restore_sec_cfg(qcom_iommu->sec_id, ctx->asid);
> +			if (ret) {
> +				dev_err(qcom_iommu->dev, "secure init failed: %d\n", ret);
> +				goto out_clear_iommu;
> +			}
> +			ctx->secure_init = true;
> +		}
> +
> +		/* TTBRs */
> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
> +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr[0] |
> +				((u64)ctx->asid << TTBRn_ASID_SHIFT));
> +		iommu_writeq(ctx, ARM_SMMU_CB_TTBR1,
> +				pgtbl_cfg.arm_lpae_s1_cfg.ttbr[1] |
> +				((u64)ctx->asid << TTBRn_ASID_SHIFT));
> +
> +		/* TTBCR */
> +		iommu_writel(ctx, ARM_SMMU_CB_TTBCR2,
> +				(pgtbl_cfg.arm_lpae_s1_cfg.tcr >> 32) |
> +				TTBCR2_SEP_UPSTREAM);
> +		iommu_writel(ctx, ARM_SMMU_CB_TTBCR,
> +				pgtbl_cfg.arm_lpae_s1_cfg.tcr);
> +
> +		/* MAIRs (stage-1 only) */
> +		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0,
> +				pgtbl_cfg.arm_lpae_s1_cfg.mair[0]);
> +		iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR1,
> +				pgtbl_cfg.arm_lpae_s1_cfg.mair[1]);
> +
> +		/* SCTLR */
> +		reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE |
> +			SCTLR_M | SCTLR_S1_ASIDPNE;
> +#ifdef __BIG_ENDIAN
> +		reg |= SCTLR_E;
> +#endif
> +		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, reg);
> +	}
> +

Too bad we can't reuse the code in arm-smmu.

> +	mutex_unlock(&qcom_domain->init_mutex);
> +
> +	/* Publish page table ops for map/unmap */
> +	qcom_domain->pgtbl_ops = pgtbl_ops;
> +
> +	return 0;
> +
> +out_clear_iommu:
> +	qcom_domain->iommu = NULL;
> +out_unlock:
> +	mutex_unlock(&qcom_domain->init_mutex);
> +	return ret;
> +}
[...]
> +
> +static int qcom_iommu_add_device(struct device *dev)
> +{
> +	struct qcom_iommu_dev *qcom_iommu = __to_iommu(dev->iommu_fwspec);
> +	struct iommu_group *group;
> +	struct device_link *link;
> +
> +	if (!qcom_iommu)
> +		return -ENODEV;
> +
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR_OR_NULL(group))
> +		return PTR_ERR_OR_ZERO(group);
> +
> +	iommu_group_put(group);
> +	iommu_device_link(&qcom_iommu->iommu, dev);
> +
> +	/*
> +	 * Establish the link between iommu and master, so that the
> +	 * iommu gets runtime enabled/disabled as per the master's
> +	 * needs.
> +	 */
> +	link = device_link_add(dev, qcom_iommu->dev, DL_FLAG_PM_RUNTIME);
> +	if (!link) {
> +		dev_warn(qcom_iommu->dev, "Unable to create device link between %s and %s\n",
> +			 dev_name(qcom_iommu->dev), dev_name(dev));
> +		/* TODO fatal or ignore? */

Fatal?

> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_iommu_remove_device(struct device *dev)
> +{
> +	struct qcom_iommu_dev *qcom_iommu = __to_iommu(dev->iommu_fwspec);
> +
> +	if (!qcom_iommu)
> +		return;
> +
> +	iommu_group_remove_device(dev);
> +	iommu_device_unlink(&qcom_iommu->iommu, dev);
> +	iommu_fwspec_free(dev);
> +}
> +
> +static struct iommu_group *qcom_iommu_device_group(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> +	struct iommu_group *group = NULL;
> +	unsigned i;
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		struct qcom_iommu_ctx *ctx = __to_ctx(fwspec, fwspec->ids[i]);
> +
> +		if (group && ctx->group && group != ctx->group)
> +			return ERR_PTR(-EINVAL);
> +
> +		group = ctx->group;
> +	}
> +
> +	if (group)
> +		return iommu_group_ref_get(group);
> +
> +	group = generic_device_group(dev);
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		struct qcom_iommu_ctx *ctx = __to_ctx(fwspec, fwspec->ids[i]);
> +		ctx->group = iommu_group_ref_get(group);
> +	}
> +
> +	return group;
> +}
> +
> +static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	struct platform_device *iommu_pdev;
> +
> +	if (args->args_count != 1) {
> +		dev_err(dev, "incorrect number of iommu params found for %s "
> +			"(found %d, expected 1)\n",
> +			args->np->full_name, args->args_count);
> +		return -EINVAL;
> +	}
> +
> +	if (!dev->iommu_fwspec->iommu_priv) {
> +		iommu_pdev = of_find_device_by_node(args->np);
> +		if (WARN_ON(!iommu_pdev))
> +			return -EINVAL;
> +
> +		dev->iommu_fwspec->iommu_priv = platform_get_drvdata(iommu_pdev);

Could we associate the context bank number/offset with the iommu_fwspec
instead? And then find the context bank during .add_device() based on
that number?

> +	}
> +
> +	return iommu_fwspec_add_ids(dev, &args->args[0], 1);
> +}
> +
> +static const struct iommu_ops qcom_iommu_ops = {
> +	.capable	= qcom_iommu_capable,
> +	.domain_alloc	= qcom_iommu_domain_alloc,
> +	.domain_free	= qcom_iommu_domain_free,
> +	.attach_dev	= qcom_iommu_attach_dev,
> +	.detach_dev	= qcom_iommu_detach_dev,
> +	.map		= qcom_iommu_map,
> +	.unmap		= qcom_iommu_unmap,
> +	.map_sg		= default_iommu_map_sg,
> +	.iova_to_phys	= qcom_iommu_iova_to_phys,
> +	.add_device	= qcom_iommu_add_device,
> +	.remove_device	= qcom_iommu_remove_device,
> +	.device_group	= qcom_iommu_device_group,
> +	.of_xlate	= qcom_iommu_of_xlate,
> +	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
> +};
> +
> +static int qcom_iommu_enable_clocks(struct qcom_iommu_dev *qcom_iommu)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(qcom_iommu->iface_clk);
> +	if (ret) {
> +		dev_err(qcom_iommu->dev, "Couldn't enable iface_clk\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(qcom_iommu->bus_clk);
> +	if (ret) {
> +		dev_err(qcom_iommu->dev, "Couldn't enable bus_clk\n");
> +		clk_disable_unprepare(qcom_iommu->iface_clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
> +{
> +	clk_disable_unprepare(qcom_iommu->bus_clk);
> +	clk_disable_unprepare(qcom_iommu->iface_clk);
> +}
> +
> +static int qcom_iommu_ctx_probe(struct platform_device *pdev)
> +{
> +	struct qcom_iommu_ctx *ctx;
> +	struct device *dev = &pdev->dev;
> +	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev->parent);
> +	struct resource *res;
> +	int ret;
> +	u32 reg;
> +
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx) {
> +		dev_err(dev, "failed to allocate qcom_iommu_context\n");

No allocation error messages please.

> +		return -ENOMEM;
> +	}
> +
> +	ctx->dev = dev;
> +	platform_set_drvdata(pdev, ctx);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctx->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ctx->base))
> +		return PTR_ERR(ctx->base);
> +
> +	ctx->irq = platform_get_irq(pdev, 0);
> +	if (ctx->irq < 0) {
> +		dev_err(dev, "failed to get irq\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = devm_request_irq(dev, ctx->irq,
> +			       qcom_iommu_fault,
> +			       IRQF_SHARED,

Is the IRQ actually shared? This design is sort of confusing. The
context banks could be subnodes that aren't populated as platform
devices. Then we wouldn't need to do any IRQ sharing. There would only
be one device. Is there any reason to make multiple devices here?

Also, I seem to recall that module_platform_driver() can only exist once
in a file, or modular builds don't work?

> +			       "qcom-iommu-fault",
> +			       ctx);
> +	if (ret) {
> +		dev_err(dev, "failed to request IRQ %u\n", ctx->irq);
> +		return ret;
> +	}
> +
> +	/* read the "reg" property directly to get the relative address
> +	 * of the context bank, and calculate the asid from that:
> +	 */
> +	if (of_property_read_u32_index(dev->of_node, "reg", 0, &reg)) {
> +		dev_err(dev, "missing reg property\n");
> +		return -ENODEV;
> +	}
> +
> +	ctx->asid = reg / 0x1000;

Where does 0x1000 come from? Please add a comment for us who aren't in
the know.

> +
> +	dev_info(dev, "found asid %u\n", ctx->asid);

debug?

> +
> +	list_add_tail(&ctx->node, &qcom_iommu->context_list);
> +
> +	return 0;
> +}
> +
> +static int qcom_iommu_ctx_remove(struct platform_device *pdev)
> +{
> +	struct qcom_iommu_ctx *ctx = platform_get_drvdata(pdev);
> +
> +	if (!ctx)
> +		return 0;

This can happen?

> +
> +	iommu_group_put(ctx->group);
> +	platform_set_drvdata(pdev, NULL);

Is this really needed?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ctx_of_match[] = {
> +	{ .compatible = "qcom,msm-iommu-v1-ns" },
> +	{ .compatible = "qcom,msm-iommu-v1-sec" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver qcom_iommu_ctx_driver = {
> +	.driver	= {
> +		.name		= "qcom-iommu-ctx",
> +		.of_match_table	= of_match_ptr(ctx_of_match),
> +	},
> +	.probe	= qcom_iommu_ctx_probe,
> +	.remove = qcom_iommu_ctx_remove,
> +};
> +module_platform_driver(qcom_iommu_ctx_driver);
> +
> +static int qcom_iommu_device_probe(struct platform_device *pdev)
> +{
> +	struct qcom_iommu_dev *qcom_iommu;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	int ret;
> +
> +	qcom_iommu = devm_kzalloc(dev, sizeof(*qcom_iommu), GFP_KERNEL);
> +	if (!qcom_iommu) {
> +		dev_err(dev, "failed to allocate qcom_iommu_device\n");

We don't need allocation errors.

> +		return -ENOMEM;
> +	}
> +	qcom_iommu->dev = dev;
> +
> +	INIT_LIST_HEAD(&qcom_iommu->context_list);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res)
> +		qcom_iommu->local_base = devm_ioremap_resource(dev, res);

And if that fails? Is it an optional resource?

> +
> +	qcom_iommu->iface_clk = devm_clk_get(dev, "iface_clk");
> +	if (IS_ERR(qcom_iommu->iface_clk)) {
> +		dev_err(dev, "failed to get iface_clk\n");
> +		return PTR_ERR(qcom_iommu->iface_clk);
> +	}
> +
> +	qcom_iommu->bus_clk = devm_clk_get(dev, "bus_clk");
> +	if (IS_ERR(qcom_iommu->bus_clk)) {
> +		dev_err(dev, "failed to get bus_clk\n");
> +		return PTR_ERR(qcom_iommu->bus_clk);
> +	}
> +
> +	if (of_property_read_u32(dev->of_node, "qcom,iommu-secure-id",
> +				 &qcom_iommu->sec_id)) {
> +		dev_err(dev, "missing qcom,iommu-secure-id property\n");
> +		return -ENODEV;
> +	}
> +
> +	platform_set_drvdata(pdev, qcom_iommu);
> +
> +	/* register context bank devices, which are child nodes: */
> +	ret = of_platform_populate(dev->of_node, ctx_of_match, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to populate iommu contexts\n");
> +		return ret;
> +	}
> +
> +	ret = iommu_device_sysfs_add(&qcom_iommu->iommu, dev, NULL,
> +				     "smmu.%pa", &res->start);
> +	if (ret) {
> +		dev_err(dev, "Failed to register iommu in sysfs\n");
> +		return ret;
> +	}
> +
> +	iommu_device_set_ops(&qcom_iommu->iommu, &qcom_iommu_ops);
> +	iommu_device_set_fwnode(&qcom_iommu->iommu, dev->fwnode);
> +
> +	ret = iommu_device_register(&qcom_iommu->iommu);
> +	if (ret) {
> +		dev_err(dev, "Failed to register iommu\n");
> +		return ret;
> +	}
> +
> +	pm_runtime_enable(dev);
> +	bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
> +
> +	if (qcom_iommu->local_base) {
> +		pm_runtime_get_sync(dev);
> +		writel_relaxed(0xffffffff, qcom_iommu->local_base + SMMU_INTR_SEL_NS);
> +		pm_runtime_put_sync(dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_iommu_device_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_force_suspend(&pdev->dev);
> +	platform_set_drvdata(pdev, NULL);

Do we really need to do that?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
