From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 5/9] iommu: add qcom_iommu
Date: Thu, 30 Mar 2017 09:46:14 -0400
Message-ID: <CAF6AEGtwkSgKNjbe==BK-mMTu-gJOYSUE0tMuTK3-PVOxQm2HA@mail.gmail.com>
References: <20170314151811.17234-1-robdclark@gmail.com> <20170314151811.17234-6-robdclark@gmail.com>
 <01bfb9f2-22a6-4008-da21-a968b0153bc2@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <01bfb9f2-22a6-4008-da21-a968b0153bc2@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Archit Taneja <architt@codeaurora.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 30, 2017 at 2:19 AM, Archit Taneja <architt@codeaurora.org> wrote:
> Hi,
>
> On 03/14/2017 08:48 PM, Rob Clark wrote:
>>
>> An iommu driver for Qualcomm "B" family devices which do not completely
>> implement the ARM SMMU spec.  These devices have context-bank register
>> layout that is similar to ARM SMMU, but no global register space (or at
>> least not one that is accessible).
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/iommu/Kconfig         |  10 +
>>  drivers/iommu/Makefile        |   1 +
>>  drivers/iommu/arm-smmu-regs.h |   2 +
>>  drivers/iommu/qcom_iommu.c    | 818
>> ++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 831 insertions(+)
>>  create mode 100644 drivers/iommu/qcom_iommu.c
>
>
> <snip>
>
>> +
>> +static int qcom_iommu_add_device(struct device *dev)
>> +{
>> +       struct qcom_iommu_dev *qcom_iommu = __to_iommu(dev->iommu_fwspec);
>
>
> __to_iommu() has a WARN_ON() that gets triggered here for all devices on
> the platform bus that aren't backed by our iommu. We should return -ENODEV
> for all of them without throwing a warning.
>
>> +       struct iommu_group *group;
>> +       struct device_link *link;
>> +
>
>
> We could do something like:
>
> if (fwspec && fwspec->ops == &qcom_iommu_ops)
>         qcom_iommu = __to_iommu(fwspec);
> else
>         qcom_iommu = NULL;

thanks.. I wonder how I wasn't hitting that?

I'll incorporate this (plus small dt bindings doc update) into next
version.. probably won't have time to send until the weekend or next
week

BR,
-R


> Thanks,
> Archit
>
>
>> +       if (!qcom_iommu)
>> +               return -ENODEV;
>> +
>> +       /*
>> +        * Establish the link between iommu and master, so that the
>> +        * iommu gets runtime enabled/disabled as per the master's
>> +        * needs.
>> +        */
>> +       link = device_link_add(dev, qcom_iommu->dev, DL_FLAG_PM_RUNTIME);
>> +       if (!link) {
>> +               dev_err(qcom_iommu->dev, "Unable to create device link
>> between %s and %s\n",
>> +                       dev_name(qcom_iommu->dev), dev_name(dev));
>> +               return -ENODEV;
>> +       }
>> +
>> +       group = iommu_group_get_for_dev(dev);
>> +       if (IS_ERR_OR_NULL(group))
>> +               return PTR_ERR_OR_ZERO(group);
>> +
>> +       iommu_group_put(group);
>> +       iommu_device_link(&qcom_iommu->iommu, dev);
>> +
>> +       return 0;
>> +}
>> +
>> +static void qcom_iommu_remove_device(struct device *dev)
>> +{
>> +       struct qcom_iommu_dev *qcom_iommu = __to_iommu(dev->iommu_fwspec);
>> +
>> +       if (!qcom_iommu)
>> +               return;
>> +
>> +       iommu_group_remove_device(dev);
>> +       iommu_device_unlink(&qcom_iommu->iommu, dev);
>> +       iommu_fwspec_free(dev);
>> +}
>> +
>> +static struct iommu_group *qcom_iommu_device_group(struct device *dev)
>> +{
>> +       struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>> +       struct iommu_group *group = NULL;
>> +       unsigned i;
>> +
>> +       for (i = 0; i < fwspec->num_ids; i++) {
>> +               struct qcom_iommu_ctx *ctx = __to_ctx(fwspec,
>> fwspec->ids[i]);
>> +
>> +               if (group && ctx->group && group != ctx->group)
>> +                       return ERR_PTR(-EINVAL);
>> +
>> +               group = ctx->group;
>> +       }
>> +
>> +       if (group)
>> +               return iommu_group_ref_get(group);
>> +
>> +       group = generic_device_group(dev);
>> +
>> +       for (i = 0; i < fwspec->num_ids; i++) {
>> +               struct qcom_iommu_ctx *ctx = __to_ctx(fwspec,
>> fwspec->ids[i]);
>> +               ctx->group = iommu_group_ref_get(group);
>> +       }
>> +
>> +       return group;
>> +}
>> +
>> +static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args
>> *args)
>> +{
>> +       struct platform_device *iommu_pdev;
>> +
>> +       if (args->args_count != 1) {
>> +               dev_err(dev, "incorrect number of iommu params found for
>> %s "
>> +                       "(found %d, expected 1)\n",
>> +                       args->np->full_name, args->args_count);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (!dev->iommu_fwspec->iommu_priv) {
>> +               iommu_pdev = of_find_device_by_node(args->np);
>> +               if (WARN_ON(!iommu_pdev))
>> +                       return -EINVAL;
>> +
>> +               dev->iommu_fwspec->iommu_priv =
>> platform_get_drvdata(iommu_pdev);
>> +       }
>> +
>> +       return iommu_fwspec_add_ids(dev, &args->args[0], 1);
>> +}
>> +
>> +static const struct iommu_ops qcom_iommu_ops = {
>> +       .capable        = qcom_iommu_capable,
>> +       .domain_alloc   = qcom_iommu_domain_alloc,
>> +       .domain_free    = qcom_iommu_domain_free,
>> +       .attach_dev     = qcom_iommu_attach_dev,
>> +       .detach_dev     = qcom_iommu_detach_dev,
>> +       .map            = qcom_iommu_map,
>> +       .unmap          = qcom_iommu_unmap,
>> +       .map_sg         = default_iommu_map_sg,
>> +       .iova_to_phys   = qcom_iommu_iova_to_phys,
>> +       .add_device     = qcom_iommu_add_device,
>> +       .remove_device  = qcom_iommu_remove_device,
>> +       .device_group   = qcom_iommu_device_group,
>> +       .of_xlate       = qcom_iommu_of_xlate,
>> +       .pgsize_bitmap  = SZ_4K | SZ_64K | SZ_1M | SZ_16M,
>> +};
>> +
>> +static int qcom_iommu_enable_clocks(struct qcom_iommu_dev *qcom_iommu)
>> +{
>> +       int ret;
>> +
>> +       ret = clk_prepare_enable(qcom_iommu->iface_clk);
>> +       if (ret) {
>> +               dev_err(qcom_iommu->dev, "Couldn't enable iface_clk\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = clk_prepare_enable(qcom_iommu->bus_clk);
>> +       if (ret) {
>> +               dev_err(qcom_iommu->dev, "Couldn't enable bus_clk\n");
>> +               clk_disable_unprepare(qcom_iommu->iface_clk);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
>> +{
>> +       clk_disable_unprepare(qcom_iommu->bus_clk);
>> +       clk_disable_unprepare(qcom_iommu->iface_clk);
>> +}
>> +
>> +static int qcom_iommu_ctx_probe(struct platform_device *pdev)
>> +{
>> +       struct qcom_iommu_ctx *ctx;
>> +       struct device *dev = &pdev->dev;
>> +       struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev->parent);
>> +       struct resource *res;
>> +       int ret;
>> +       u32 reg;
>> +
>> +       ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>> +       if (!ctx)
>> +               return -ENOMEM;
>> +
>> +       ctx->dev = dev;
>> +       platform_set_drvdata(pdev, ctx);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       ctx->base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(ctx->base))
>> +               return PTR_ERR(ctx->base);
>> +
>> +       ctx->irq = platform_get_irq(pdev, 0);
>> +       if (ctx->irq < 0) {
>> +               dev_err(dev, "failed to get irq\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       ret = devm_request_irq(dev, ctx->irq,
>> +                              qcom_iommu_fault,
>> +                              IRQF_SHARED,
>> +                              "qcom-iommu-fault",
>> +                              ctx);
>> +       if (ret) {
>> +               dev_err(dev, "failed to request IRQ %u\n", ctx->irq);
>> +               return ret;
>> +       }
>> +
>> +       /* read the "reg" property directly to get the relative address
>> +        * of the context bank, and calculate the asid from that:
>> +        */
>> +       if (of_property_read_u32_index(dev->of_node, "reg", 0, &reg)) {
>> +               dev_err(dev, "missing reg property\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       ctx->asid = reg / 0x1000;      /* context banks are 0x1000 apart
>> */
>> +
>> +       dev_dbg(dev, "found asid %u\n", ctx->asid);
>> +
>> +       list_add_tail(&ctx->node, &qcom_iommu->context_list);
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_iommu_ctx_remove(struct platform_device *pdev)
>> +{
>> +       struct qcom_iommu_ctx *ctx = platform_get_drvdata(pdev);
>> +
>> +       iommu_group_put(ctx->group);
>> +       platform_set_drvdata(pdev, NULL);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id ctx_of_match[] = {
>> +       { .compatible = "qcom,msm-iommu-v1-ns" },
>> +       { .compatible = "qcom,msm-iommu-v1-sec" },
>> +       { /* sentinel */ }
>> +};
>> +
>> +static struct platform_driver qcom_iommu_ctx_driver = {
>> +       .driver = {
>> +               .name           = "qcom-iommu-ctx",
>> +               .of_match_table = of_match_ptr(ctx_of_match),
>> +       },
>> +       .probe  = qcom_iommu_ctx_probe,
>> +       .remove = qcom_iommu_ctx_remove,
>> +};
>> +module_platform_driver(qcom_iommu_ctx_driver);
>> +
>> +static int qcom_iommu_device_probe(struct platform_device *pdev)
>> +{
>> +       struct qcom_iommu_dev *qcom_iommu;
>> +       struct device *dev = &pdev->dev;
>> +       struct resource *res;
>> +       int ret;
>> +
>> +       qcom_iommu = devm_kzalloc(dev, sizeof(*qcom_iommu), GFP_KERNEL);
>> +       if (!qcom_iommu)
>> +               return -ENOMEM;
>> +       qcom_iommu->dev = dev;
>> +
>> +       INIT_LIST_HEAD(&qcom_iommu->context_list);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (res)
>> +               qcom_iommu->local_base = devm_ioremap_resource(dev, res);
>> +
>> +       qcom_iommu->iface_clk = devm_clk_get(dev, "iface");
>> +       if (IS_ERR(qcom_iommu->iface_clk)) {
>> +               dev_err(dev, "failed to get iface clock\n");
>> +               return PTR_ERR(qcom_iommu->iface_clk);
>> +       }
>> +
>> +       qcom_iommu->bus_clk = devm_clk_get(dev, "bus");
>> +       if (IS_ERR(qcom_iommu->bus_clk)) {
>> +               dev_err(dev, "failed to get bus clock\n");
>> +               return PTR_ERR(qcom_iommu->bus_clk);
>> +       }
>> +
>> +       if (of_property_read_u32(dev->of_node, "qcom,iommu-secure-id",
>> +                                &qcom_iommu->sec_id)) {
>> +               dev_err(dev, "missing qcom,iommu-secure-id property\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       platform_set_drvdata(pdev, qcom_iommu);
>> +
>> +       /* register context bank devices, which are child nodes: */
>> +       ret = of_platform_populate(dev->of_node, ctx_of_match, NULL, dev);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to populate iommu contexts\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = iommu_device_sysfs_add(&qcom_iommu->iommu, dev, NULL,
>> +                                    "smmu.%pa", &res->start);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to register iommu in sysfs\n");
>> +               return ret;
>> +       }
>> +
>> +       iommu_device_set_ops(&qcom_iommu->iommu, &qcom_iommu_ops);
>> +       iommu_device_set_fwnode(&qcom_iommu->iommu, dev->fwnode);
>> +
>> +       ret = iommu_device_register(&qcom_iommu->iommu);
>> +       if (ret) {
>> +               dev_err(dev, "Failed to register iommu\n");
>> +               return ret;
>> +       }
>> +
>> +       pm_runtime_enable(dev);
>> +       bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
>> +
>> +       if (qcom_iommu->local_base) {
>> +               pm_runtime_get_sync(dev);
>> +               writel_relaxed(0xffffffff, qcom_iommu->local_base +
>> SMMU_INTR_SEL_NS);
>> +               pm_runtime_put_sync(dev);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int qcom_iommu_device_remove(struct platform_device *pdev)
>> +{
>> +       pm_runtime_force_suspend(&pdev->dev);
>> +       platform_set_drvdata(pdev, NULL);
>> +
>> +       return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int qcom_iommu_resume(struct device *dev)
>> +{
>> +       struct platform_device *pdev = to_platform_device(dev);
>> +       struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
>> +
>> +       return qcom_iommu_enable_clocks(qcom_iommu);
>> +}
>> +
>> +static int qcom_iommu_suspend(struct device *dev)
>> +{
>> +       struct platform_device *pdev = to_platform_device(dev);
>> +       struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
>> +
>> +       qcom_iommu_disable_clocks(qcom_iommu);
>> +
>> +       return 0;
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops qcom_iommu_pm_ops = {
>> +       SET_RUNTIME_PM_OPS(qcom_iommu_suspend, qcom_iommu_resume, NULL)
>> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +                               pm_runtime_force_resume)
>> +};
>> +
>> +static const struct of_device_id qcom_iommu_of_match[] = {
>> +       { .compatible = "qcom,msm-iommu-v1" },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, qcom_iommu_of_match);
>> +
>> +static struct platform_driver qcom_iommu_driver = {
>> +       .driver = {
>> +               .name           = "qcom-iommu",
>> +               .of_match_table = of_match_ptr(qcom_iommu_of_match),
>> +               .pm             = &qcom_iommu_pm_ops,
>> +       },
>> +       .probe  = qcom_iommu_device_probe,
>> +       .remove = qcom_iommu_device_remove,
>> +};
>> +module_platform_driver(qcom_iommu_driver);
>> +
>> +IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1", NULL);
>> +
>> +MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
>> +MODULE_LICENSE("GPL v2");
>>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
