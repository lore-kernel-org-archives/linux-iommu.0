From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 5/9] iommu: add qcom_iommu
Date: Mon, 20 Mar 2017 19:51:09 +0530
Message-ID: <6398dcd5-812d-f746-5bd8-2288b0cc501d@codeaurora.org>
References: <20170301174258.14618-1-robdclark@gmail.com>
	<20170301174258.14618-6-robdclark@gmail.com>
	<075356ad9df70ee2a54ea782f143522c@codeaurora.org>
	<CAF6AEGsoHwDRR02nxz_fkeSPrXBRmG_38xvkF6f0=m+Ucj_soA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAF6AEGsoHwDRR02nxz_fkeSPrXBRmG_38xvkF6f0=m+Ucj_soA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

sorry for the delayed response. Was not there mostly last week.

On 3/13/2017 11:49 PM, Rob Clark wrote:
> On Mon, Mar 13, 2017 at 9:38 AM,  <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>> Hi Rob,
>>
>> [..]
>>
>>
>>> +static int qcom_iommu_init_domain(struct iommu_domain *domain,
>>> +                                 struct qcom_iommu_dev *qcom_iommu,
>>> +                                 struct iommu_fwspec *fwspec)
>>> +{
>>> +       struct qcom_iommu_domain *qcom_domain =
>>> to_qcom_iommu_domain(domain);
>>> +       struct io_pgtable_ops *pgtbl_ops;
>>> +       struct io_pgtable_cfg pgtbl_cfg;
>>> +       int i, ret = 0;
>>> +       u32 reg;
>>> +
>>> +       mutex_lock(&qcom_domain->init_mutex);
>>> +       if (qcom_domain->iommu)
>>> +               goto out_unlock;
>>> +
>>> +       pgtbl_cfg = (struct io_pgtable_cfg) {
>>> +               .pgsize_bitmap  = qcom_iommu_ops.pgsize_bitmap,
>>> +               .ias            = 32,
>>> +               .oas            = 40,
>>> +               .tlb            = &qcom_gather_ops,
>>> +               .iommu_dev      = qcom_iommu->dev,
>>> +       };
>>> +
>>> +       qcom_domain->iommu = qcom_iommu;
>>> +       pgtbl_ops = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &pgtbl_cfg,
>>> fwspec);
>>
>>
>> So why not pass in the ctx pointer itself
>> that we get below as a cookie ? That would basically
>> avoid iterating through the list in the tlb_ops ?
>
> The issue is that one domain might be attached to a device with multiple ctx's.
>

ok, interesting, what's the usecase for this ? Dynamic domain
has 1-ctx shared with multiple domains, but this seems to be
the inverse.

> Although perhaps __to_ctx() could be made a bit more clever.  I was
> mostly in "make it work, optimize later" mode ;-)
>
> Note also, I'm thinking (both for qcom_iommu and arm-smmu) that we
> want to move pgtbl alloc into _domain_alloc().. or at least that would
> allow the driver to iommu_map/unmap() before attaching the domain.
> (Partly this depends on how the iommu task and/or dynamic domain stuff
> works out.. but one way or another we want to be able to map things to
> pagetables that aren't the currently attached pagetables)

ok, the dynamic domain patches i remember was tweaking the attach path
to make this work. So are you trying to avoid that and simple do only
a dynamic_domain_alloc instead ?

>
>> [..]
>>
>>
>>> +static int qcom_iommu_add_device(struct device *dev)
>>> +{
>>> +       struct qcom_iommu_dev *qcom_iommu = __to_iommu(dev->iommu_fwspec);
>>> +       struct iommu_group *group;
>>> +       struct device_link *link;
>>> +
>>> +       if (!qcom_iommu)
>>> +               return -ENODEV;
>>> +
>>> +       group = iommu_group_get_for_dev(dev);
>>> +       if (IS_ERR_OR_NULL(group))
>>> +               return PTR_ERR_OR_ZERO(group);
>>> +
>>> +       iommu_group_put(group);
>>> +       iommu_device_link(&qcom_iommu->iommu, dev);
>>> +
>>> +       /*
>>> +        * Establish the link between iommu and master, so that the
>>> +        * iommu gets runtime enabled/disabled as per the master's
>>> +        * needs.
>>> +        */
>>> +       link = device_link_add(dev, qcom_iommu->dev, DL_FLAG_PM_RUNTIME);
>>> +       if (!link) {
>>> +               dev_warn(qcom_iommu->dev, "Unable to create device link
>>> between %s and %s\n",
>>> +                        dev_name(qcom_iommu->dev), dev_name(dev));
>>> +               /* TODO fatal or ignore? */
>>> +       }
>>
>>
>> Yes, should be fatal when depend on master's pm_runtime to call
>> the iommu's runtime. The iommu may remain unclocked if the link
>> is not there. Might have to fixed in my patch as well.
>
> ok, I've made it -ENODEV
>
>>
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static void qcom_iommu_remove_device(struct device *dev)
>>> +{
>>> +       struct qcom_iommu_dev *qcom_iommu = __to_iommu(dev->iommu_fwspec);
>>> +
>>> +       if (!qcom_iommu)
>>> +               return;
>>> +
>>> +       iommu_group_remove_device(dev);
>>> +       iommu_device_unlink(&qcom_iommu->iommu, dev);
>>> +       iommu_fwspec_free(dev);
>>> +}
>>> +
>>> +static struct iommu_group *qcom_iommu_device_group(struct device *dev)
>>> +{
>>> +       struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>>> +       struct iommu_group *group = NULL;
>>> +       unsigned i;
>>> +
>>> +       for (i = 0; i < fwspec->num_ids; i++) {
>>> +               struct qcom_iommu_ctx *ctx = __to_ctx(fwspec,
>>> fwspec->ids[i]);
>>> +
>>> +               if (group && ctx->group && group != ctx->group)
>>> +                       return ERR_PTR(-EINVAL);
>>> +
>>> +               group = ctx->group;
>>> +       }
>>
>>
>> I think in this case, the master may devices may not populate the
>> same asid/ctx bank more than once intentionally or is this to
>> catch accidental wrong DT entry. Just thinking
>> if we ever need this logic to get an already existing group in
>> our case, simply create a new group always ?
>
> mostly just to catch wrong DT entry.. I don't think we'd need it
> anyways.  Perhaps it justifies a WARN_ON()?

Ya, when not needed, then probably a ERR_PTR return to catch the
wrong entry, because in that case there is no point in proceeding
further anyways.

>
>>> +
>>> +       if (group)
>>> +               return iommu_group_ref_get(group);
>>> +
>>> +       group = generic_device_group(dev);
>>> +
>>> +       for (i = 0; i < fwspec->num_ids; i++) {
>>> +               struct qcom_iommu_ctx *ctx = __to_ctx(fwspec,
>>> fwspec->ids[i]);
>>> +               ctx->group = iommu_group_ref_get(group);
>>> +       }
>>> +
>>> +       return group;
>>> +}
>>> +
>>> +static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args
>>> *args)
>>> +{
>>> +       struct platform_device *iommu_pdev;
>>> +
>>> +       if (args->args_count != 1) {
>>> +               dev_err(dev, "incorrect number of iommu params found for
>>> %s "
>>> +                       "(found %d, expected 1)\n",
>>> +                       args->np->full_name, args->args_count);
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       if (!dev->iommu_fwspec->iommu_priv) {
>>> +               iommu_pdev = of_find_device_by_node(args->np);
>>> +               if (WARN_ON(!iommu_pdev))
>>> +                       return -EINVAL;
>>> +
>>> +               dev->iommu_fwspec->iommu_priv =
>>> platform_get_drvdata(iommu_pdev);
>>> +       }
>>> +
>>> +       return iommu_fwspec_add_ids(dev, &args->args[0], 1);
>>> +}
>>> +
<snip..>

>>> +static int qcom_iommu_ctx_probe(struct platform_device *pdev)
>>> +{
>>> +       struct qcom_iommu_ctx *ctx;
>>> +       struct device *dev = &pdev->dev;
>>> +       struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev->parent);
>>> +       struct resource *res;
>>> +       int ret;
>>> +       u32 reg;
>>> +
>>> +       ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>>> +       if (!ctx) {
>>> +               dev_err(dev, "failed to allocate qcom_iommu_context\n");
>>> +               return -ENOMEM;
>>> +       }
>>> +
>>> +       ctx->dev = dev;
>>> +       platform_set_drvdata(pdev, ctx);
>>> +
>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +       ctx->base = devm_ioremap_resource(dev, res);
>>> +       if (IS_ERR(ctx->base))
>>> +               return PTR_ERR(ctx->base);
>>> +
>>> +       ctx->irq = platform_get_irq(pdev, 0);
>>> +       if (ctx->irq < 0) {
>>> +               dev_err(dev, "failed to get irq\n");
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       ret = devm_request_irq(dev, ctx->irq,
>>> +                              qcom_iommu_fault,
>>> +                              IRQF_SHARED,
>>> +                              "qcom-iommu-fault",
>>> +                              ctx);
>>> +       if (ret) {
>>> +               dev_err(dev, "failed to request IRQ %u\n", ctx->irq);
>>> +               return ret;
>>> +       }
>>> +
>>> +       /* read the "reg" property directly to get the relative address
>>> +        * of the context bank, and calculate the asid from that:
>>> +        */
>>> +       if (of_property_read_u32_index(dev->of_node, "reg", 0, &reg)) {
>>> +               dev_err(dev, "missing reg property\n");
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       ctx->asid = reg / 0x1000;
>>
>>
>> hmm, are doing new set of bindings only because of the local_base issue ?
>
> not *just* because of local_base.. actually the bigger reason right
> now is so we know which context banks are secure vs not.  I was
> thinking that we would later add secure cb support to qcom_iommu.
> (But I have really no idea how we'll handle that on arm-smmu for later
> devices)

ok, atleast for supporting secure cb in arm-smmu, looks like little
bit more easier, because those socs have abstracted the secure vs
non-secure under the stage2. But never know until it is tried :-)

Regards,
  Sricharan


>
> BR,
> -R
>
>> Regards,
>>  Sricharan
>>
>>
>>
>>> +
>>> +       dev_info(dev, "found asid %u\n", ctx->asid);
>>> +
>>> +       list_add_tail(&ctx->node, &qcom_iommu->context_list);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int qcom_iommu_ctx_remove(struct platform_device *pdev)
>>> +{
>>> +       struct qcom_iommu_ctx *ctx = platform_get_drvdata(pdev);
>>> +
>>> +       if (!ctx)
>>> +               return 0;
>>> +
>>> +       iommu_group_put(ctx->group);
>>> +       platform_set_drvdata(pdev, NULL);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static const struct of_device_id ctx_of_match[] = {
>>> +       { .compatible = "qcom,msm-iommu-v1-ns" },
>>> +       { .compatible = "qcom,msm-iommu-v1-sec" },
>>> +       { /* sentinel */ }
>>> +};
>>> +
>>> +static struct platform_driver qcom_iommu_ctx_driver = {
>>> +       .driver = {
>>> +               .name           = "qcom-iommu-ctx",
>>> +               .of_match_table = of_match_ptr(ctx_of_match),
>>> +       },
>>> +       .probe  = qcom_iommu_ctx_probe,
>>> +       .remove = qcom_iommu_ctx_remove,
>>> +};
>>> +module_platform_driver(qcom_iommu_ctx_driver);
>>> +
>>> +static int qcom_iommu_device_probe(struct platform_device *pdev)
>>> +{
>>> +       struct qcom_iommu_dev *qcom_iommu;
>>> +       struct device *dev = &pdev->dev;
>>> +       struct resource *res;
>>> +       int ret;
>>> +
>>> +       qcom_iommu = devm_kzalloc(dev, sizeof(*qcom_iommu), GFP_KERNEL);
>>> +       if (!qcom_iommu) {
>>> +               dev_err(dev, "failed to allocate qcom_iommu_device\n");
>>> +               return -ENOMEM;
>>> +       }
>>> +       qcom_iommu->dev = dev;
>>> +
>>> +       INIT_LIST_HEAD(&qcom_iommu->context_list);
>>> +
>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +       if (res)
>>> +               qcom_iommu->local_base = devm_ioremap_resource(dev, res);
>>> +
>>> +       qcom_iommu->iface_clk = devm_clk_get(dev, "iface_clk");
>>> +       if (IS_ERR(qcom_iommu->iface_clk)) {
>>> +               dev_err(dev, "failed to get iface_clk\n");
>>> +               return PTR_ERR(qcom_iommu->iface_clk);
>>> +       }
>>> +
>>> +       qcom_iommu->bus_clk = devm_clk_get(dev, "bus_clk");
>>> +       if (IS_ERR(qcom_iommu->bus_clk)) {
>>> +               dev_err(dev, "failed to get bus_clk\n");
>>> +               return PTR_ERR(qcom_iommu->bus_clk);
>>> +       }
>>> +
>>> +       if (of_property_read_u32(dev->of_node, "qcom,iommu-secure-id",
>>> +                                &qcom_iommu->sec_id)) {
>>> +               dev_err(dev, "missing qcom,iommu-secure-id property\n");
>>> +               return -ENODEV;
>>> +       }
>>> +
>>> +       platform_set_drvdata(pdev, qcom_iommu);
>>> +
>>> +       /* register context bank devices, which are child nodes: */
>>> +       ret = of_platform_populate(dev->of_node, ctx_of_match, NULL, dev);
>>> +       if (ret) {
>>> +               dev_err(dev, "Failed to populate iommu contexts\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       ret = iommu_device_sysfs_add(&qcom_iommu->iommu, dev, NULL,
>>> +                                    "smmu.%pa", &res->start);
>>> +       if (ret) {
>>> +               dev_err(dev, "Failed to register iommu in sysfs\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       iommu_device_set_ops(&qcom_iommu->iommu, &qcom_iommu_ops);
>>> +       iommu_device_set_fwnode(&qcom_iommu->iommu, dev->fwnode);
>>> +
>>> +       ret = iommu_device_register(&qcom_iommu->iommu);
>>> +       if (ret) {
>>> +               dev_err(dev, "Failed to register iommu\n");
>>> +               return ret;
>>> +       }
>>> +
>>> +       pm_runtime_enable(dev);
>>> +       bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
>>> +
>>> +       if (qcom_iommu->local_base) {
>>> +               pm_runtime_get_sync(dev);
>>> +               writel_relaxed(0xffffffff, qcom_iommu->local_base +
>>> SMMU_INTR_SEL_NS);
>>> +               pm_runtime_put_sync(dev);
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static int qcom_iommu_device_remove(struct platform_device *pdev)
>>> +{
>>> +       pm_runtime_force_suspend(&pdev->dev);
>>> +       platform_set_drvdata(pdev, NULL);
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_PM
>>> +static int qcom_iommu_resume(struct device *dev)
>>> +{
>>> +       struct platform_device *pdev = to_platform_device(dev);
>>> +       struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
>>> +
>>> +       return qcom_iommu_enable_clocks(qcom_iommu);
>>> +}
>>> +
>>> +static int qcom_iommu_suspend(struct device *dev)
>>> +{
>>> +       struct platform_device *pdev = to_platform_device(dev);
>>> +       struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
>>> +
>>> +       qcom_iommu_disable_clocks(qcom_iommu);
>>> +
>>> +       return 0;
>>> +}
>>> +#endif
>>> +
>>> +static const struct dev_pm_ops qcom_iommu_pm_ops = {
>>> +       SET_RUNTIME_PM_OPS(qcom_iommu_suspend, qcom_iommu_resume, NULL)
>>> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>>> +                               pm_runtime_force_resume)
>>> +};
>>> +
>>> +static const struct of_device_id qcom_iommu_of_match[] = {
>>> +       { .compatible = "qcom,msm-iommu-v1" },
>>> +       { /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, qcom_iommu_of_match);
>>> +
>>> +static struct platform_driver qcom_iommu_driver = {
>>> +       .driver = {
>>> +               .name           = "qcom-iommu",
>>> +               .of_match_table = of_match_ptr(qcom_iommu_of_match),
>>> +               .pm             = &qcom_iommu_pm_ops,
>>> +       },
>>> +       .probe  = qcom_iommu_device_probe,
>>> +       .remove = qcom_iommu_device_remove,
>>> +};
>>> +module_platform_driver(qcom_iommu_driver);
>>> +
>>> +IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1", NULL);
>>> +
>>> +MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
>>> +MODULE_LICENSE("GPL v2");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
