From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 3/4] iommu: add qcom_iommu
Date: Thu, 11 May 2017 20:38:29 +0530
Message-ID: <dd7ca083-09fa-2c0a-b8df-d8ae6ed740ac@codeaurora.org>
References: <20170505182151.22931-1-robdclark@gmail.com>
	<20170509142310.10535-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170509142310.10535-1-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

<snip..>

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
> +			    fsr, iova, fsynr, ctx->asid);
> +
> +	iommu_writel(ctx, ARM_SMMU_CB_FSR, fsr);

Just thinking if the clocks should be enabled in the fault handler
for handling cases that would happen out of the master context.
While global faults are one case, that is anyways is handled in
secure world for this case. Something like bootloader used the iommu
and not handled the fault, and getting the fault in kernel the
moment we enable the ctx. Atleast downstream seems to enable the
clocks in the fault handler explicitly.

Regards,
 Sricharan


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
> +	domain->geometry.aperture_end = (1ULL << pgtbl_cfg.ias) - 1;
> +	domain->geometry.force_aperture = true;
> +
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		struct qcom_iommu_ctx *ctx = to_ctx(fwspec, fwspec->ids[i]);
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
> +
> +		if (IS_ENABLED(CONFIG_BIG_ENDIAN))
> +			reg |= SCTLR_E;
> +
> +		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, reg);
> +	}
> +
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
> +
> +static struct iommu_domain *qcom_iommu_domain_alloc(unsigned type)
> +{
> +	struct qcom_iommu_domain *qcom_domain;
> +
> +	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> +		return NULL;
> +	/*
> +	 * Allocate the domain and initialise some of its data structures.
> +	 * We can't really do anything meaningful until we've added a
> +	 * master.
> +	 */
> +	qcom_domain = kzalloc(sizeof(*qcom_domain), GFP_KERNEL);
> +	if (!qcom_domain)
> +		return NULL;
> +
> +	if (type == IOMMU_DOMAIN_DMA &&
> +	    iommu_get_dma_cookie(&qcom_domain->domain)) {
> +		kfree(qcom_domain);
> +		return NULL;
> +	}
> +
> +	mutex_init(&qcom_domain->init_mutex);
> +	spin_lock_init(&qcom_domain->pgtbl_lock);
> +
> +	return &qcom_domain->domain;
> +}
> +
> +static void qcom_iommu_domain_free(struct iommu_domain *domain)
> +{
> +	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
> +
> +	if (WARN_ON(qcom_domain->iommu))    /* forgot to detach? */
> +		return;
> +
> +	iommu_put_dma_cookie(domain);
> +
> +	free_io_pgtable_ops(qcom_domain->pgtbl_ops);
> +
> +	kfree(qcom_domain);
> +}
> +
> +static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev->iommu_fwspec);
> +	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
> +	int ret;
> +
> +	if (!qcom_iommu) {
> +		dev_err(dev, "cannot attach to IOMMU, is it on the same bus?\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Ensure that the domain is finalized */
> +	pm_runtime_get_sync(qcom_iommu->dev);
> +	ret = qcom_iommu_init_domain(domain, qcom_iommu, dev->iommu_fwspec);
> +	pm_runtime_put_sync(qcom_iommu->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Sanity check the domain. We don't support domains across
> +	 * different IOMMUs.
> +	 */
> +	if (qcom_domain->iommu != qcom_iommu) {
> +		dev_err(dev, "cannot attach to IOMMU %s while already "
> +			"attached to domain on IOMMU %s\n",
> +			dev_name(qcom_domain->iommu->dev),
> +			dev_name(qcom_iommu->dev));
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> +	struct qcom_iommu_dev *qcom_iommu = to_iommu(fwspec);
> +	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
> +	unsigned i;
> +
> +	if (!qcom_domain->iommu)
> +		return;
> +
> +	pm_runtime_get_sync(qcom_iommu->dev);
> +	for (i = 0; i < fwspec->num_ids; i++) {
> +		struct qcom_iommu_ctx *ctx = to_ctx(fwspec, fwspec->ids[i]);
> +
> +		/* Disable the context bank: */
> +		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
> +	}
> +	pm_runtime_put_sync(qcom_iommu->dev);
> +
> +	qcom_domain->iommu = NULL;
> +}
> +
> +static int qcom_iommu_map(struct iommu_domain *domain, unsigned long iova,
> +			  phys_addr_t paddr, size_t size, int prot)
> +{
> +	int ret;
> +	unsigned long flags;
> +	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
> +	struct io_pgtable_ops *ops = qcom_domain->pgtbl_ops;
> +
> +	if (!ops)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
> +	ret = ops->map(ops, iova, paddr, size, prot);
> +	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
> +	return ret;
> +}
> +
> +static size_t qcom_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> +			       size_t size)
> +{
> +	size_t ret;
> +	unsigned long flags;
> +	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
> +	struct io_pgtable_ops *ops = qcom_domain->pgtbl_ops;
> +
> +	if (!ops)
> +		return 0;
> +
> +	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
> +	ret = ops->unmap(ops, iova, size);
> +	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
> +	return ret;
> +}
> +
> +static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
> +					   dma_addr_t iova)
> +{
> +	phys_addr_t ret;
> +	unsigned long flags;
> +	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
> +	struct io_pgtable_ops *ops = qcom_domain->pgtbl_ops;
> +
> +	if (!ops)
> +		return 0;
> +
> +	spin_lock_irqsave(&qcom_domain->pgtbl_lock, flags);
> +	ret = ops->iova_to_phys(ops, iova);
> +	spin_unlock_irqrestore(&qcom_domain->pgtbl_lock, flags);
> +
> +	return ret;
> +}
> +
> +static bool qcom_iommu_capable(enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		/*
> +		 * Return true here as the SMMU can always send out coherent
> +		 * requests.
> +		 */
> +		return true;
> +	case IOMMU_CAP_NOEXEC:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
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
> +	/*
> +	 * Establish the link between iommu and master, so that the
> +	 * iommu gets runtime enabled/disabled as per the master's
> +	 * needs.
> +	 */
> +	link = device_link_add(dev, qcom_iommu->dev, DL_FLAG_PM_RUNTIME);
> +	if (!link) {
> +		dev_err(qcom_iommu->dev, "Unable to create device link between %s and %s\n",
> +			dev_name(qcom_iommu->dev), dev_name(dev));
> +		return -ENODEV;
> +	}
> +
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR_OR_NULL(group))
> +		return PTR_ERR_OR_ZERO(group);
> +
> +	iommu_group_put(group);
> +	iommu_device_link(&qcom_iommu->iommu, dev);
> +
> +	return 0;
> +}
> +
> +static void qcom_iommu_remove_device(struct device *dev)
> +{
> +	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev->iommu_fwspec);
> +
> +	if (!qcom_iommu)
> +		return;
> +
> +	iommu_device_unlink(&qcom_iommu->iommu, dev);
> +	iommu_group_remove_device(dev);
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
> +		struct qcom_iommu_ctx *ctx = to_ctx(fwspec, fwspec->ids[i]);
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
> +		struct qcom_iommu_ctx *ctx = to_ctx(fwspec, fwspec->ids[i]);
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
> +	if (!ctx)
> +		return -ENOMEM;
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
> +	ctx->asid = reg / 0x1000;      /* context banks are 0x1000 apart */
> +
> +	dev_dbg(dev, "found asid %u\n", ctx->asid);
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
> +	iommu_group_put(ctx->group);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	list_del(&ctx->node);
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
> +
> +static int qcom_iommu_device_probe(struct platform_device *pdev)
> +{
> +	struct qcom_iommu_dev *qcom_iommu;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	int ret;
> +
> +	qcom_iommu = devm_kzalloc(dev, sizeof(*qcom_iommu), GFP_KERNEL);
> +	if (!qcom_iommu)
> +		return -ENOMEM;
> +	qcom_iommu->dev = dev;
> +
> +	INIT_LIST_HEAD(&qcom_iommu->context_list);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res)
> +		qcom_iommu->local_base = devm_ioremap_resource(dev, res);
> +
> +	qcom_iommu->iface_clk = devm_clk_get(dev, "iface");
> +	if (IS_ERR(qcom_iommu->iface_clk)) {
> +		dev_err(dev, "failed to get iface clock\n");
> +		return PTR_ERR(qcom_iommu->iface_clk);
> +	}
> +
> +	qcom_iommu->bus_clk = devm_clk_get(dev, "bus");
> +	if (IS_ERR(qcom_iommu->bus_clk)) {
> +		dev_err(dev, "failed to get bus clock\n");
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
> +	ret = devm_of_platform_populate(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to populate iommu contexts\n");
> +		return ret;
> +	}
> +
> +	ret = iommu_device_sysfs_add(&qcom_iommu->iommu, dev, NULL,
> +				     dev_name(dev));
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
> +	struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
> +
> +	bus_set_iommu(&platform_bus_type, NULL);
> +
> +	pm_runtime_force_suspend(&pdev->dev);
> +	platform_set_drvdata(pdev, NULL);
> +	iommu_device_sysfs_remove(&qcom_iommu->iommu);
> +	iommu_device_unregister(&qcom_iommu->iommu);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int qcom_iommu_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
> +
> +	return qcom_iommu_enable_clocks(qcom_iommu);
> +}
> +
> +static int qcom_iommu_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
> +
> +	qcom_iommu_disable_clocks(qcom_iommu);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops qcom_iommu_pm_ops = {
> +	SET_RUNTIME_PM_OPS(qcom_iommu_suspend, qcom_iommu_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +};
> +
> +static const struct of_device_id qcom_iommu_of_match[] = {
> +	{ .compatible = "qcom,msm-iommu-v1" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, qcom_iommu_of_match);
> +
> +static struct platform_driver qcom_iommu_driver = {
> +	.driver	= {
> +		.name		= "qcom-iommu",
> +		.of_match_table	= of_match_ptr(qcom_iommu_of_match),
> +		.pm		= &qcom_iommu_pm_ops,
> +	},
> +	.probe	= qcom_iommu_device_probe,
> +	.remove	= qcom_iommu_device_remove,
> +};
> +
> +static int __init qcom_iommu_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&qcom_iommu_ctx_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&qcom_iommu_driver);
> +	if (ret)
> +		platform_driver_unregister(&qcom_iommu_ctx_driver);
> +
> +	return ret;
> +}
> +
> +static void __exit qcom_iommu_exit(void)
> +{
> +	platform_driver_unregister(&qcom_iommu_driver);
> +	platform_driver_unregister(&qcom_iommu_ctx_driver);
> +}
> +
> +module_init(qcom_iommu_init);
> +module_exit(qcom_iommu_exit);
> +
> +IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1", NULL);
> +
> +MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
> +MODULE_LICENSE("GPL v2");
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
