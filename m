From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 2/4] iommu/arm-smmu: Add pm_runtime/sleep ops
Date: Mon, 24 Oct 2016 10:40:57 -0600
Message-ID: <CANLsYkw8Y-5MkeM2U9fLWX951Mo7ErsMCUBjSx3-0689jWD4rQ@mail.gmail.com>
References: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org> <1477070066-15044-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1477070066-15044-3-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will.deacon@arm.com>, robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: iommu@lists.linux-foundation.org

On 21 October 2016 at 11:14, Sricharan R <sricharan@codeaurora.org> wrote:
> The smmu needs to be functional when the respective
> master/s using it are active. As there is a device_link
> between the master and smmu, the pm runtime ops for the smmu
> gets invoked in sync with the master's runtime, thus the
> smmu remains powered only when needed.
>
> There are couple of places in the driver during probe,
> master attach, where the smmu needs to be clocked without
> the context of the master. So doing a pm_runtime_get/put sync
> in those places separately.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 083489e4..45f2762 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -45,6 +45,7 @@
>  #include <linux/of_iommu.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>
> @@ -373,6 +374,8 @@ struct arm_smmu_device {
>         u32                             num_global_irqs;
>         u32                             num_context_irqs;
>         unsigned int                    *irqs;
> +       int                             num_clocks;
> +       struct clk                      **clocks;
>
>         u32                             cavium_id_base; /* Specific to Cavium */
>  };
> @@ -430,6 +433,31 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>         return container_of(dom, struct arm_smmu_domain, domain);
>  }
>
> +static int arm_smmu_enable_clocks(struct arm_smmu_device *smmu)
> +{
> +       int i, ret = 0;
> +
> +       for (i = 0; i < smmu->num_clocks; ++i) {
> +               ret = clk_prepare_enable(smmu->clocks[i]);
> +               if (ret) {
> +                       dev_err(smmu->dev, "Couldn't enable clock #%d\n", i);
> +                       while (i--)
> +                               clk_disable_unprepare(smmu->clocks[i]);
> +                       break;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static void arm_smmu_disable_clocks(struct arm_smmu_device *smmu)
> +{
> +       int i;
> +
> +       for (i = 0; i < smmu->num_clocks; ++i)
> +               clk_disable_unprepare(smmu->clocks[i]);
> +}
> +
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
>         int i = 0;
> @@ -1187,11 +1215,13 @@ static void arm_smmu_master_free_smes(struct iommu_fwspec *fwspec)
>         int i, idx;
>
>         mutex_lock(&smmu->stream_map_mutex);
> +       pm_runtime_get_sync(smmu->dev);

Since this is generic code it is probably a good idea to check the
return value, same for _put_sync() below.

>         for_each_cfg_sme(fwspec, i, idx) {
>                 if (arm_smmu_free_sme(smmu, idx))
>                         arm_smmu_write_sme(smmu, idx);
>                 cfg->smendx[i] = INVALID_SMENDX;
>         }
> +       pm_runtime_put_sync(smmu->dev);
>         mutex_unlock(&smmu->stream_map_mutex);
>  }
>
> @@ -1424,9 +1454,11 @@ static int arm_smmu_add_device(struct device *dev)
>         while (i--)
>                 cfg->smendx[i] = INVALID_SMENDX;
>
> +       pm_runtime_get_sync(smmu->dev);
>         ret = arm_smmu_master_alloc_smes(dev);
>         if (ret)
>                 goto out_free;
> +       pm_runtime_put_sync(smmu->dev);
>
>         return 0;
>
> @@ -1650,6 +1682,44 @@ static int arm_smmu_id_size_to_bits(int size)
>         }
>  }
>
> +static int arm_smmu_init_clocks(struct arm_smmu_device *smmu)
> +{
> +       const char *cname;
> +       struct property *prop;
> +       int i;
> +       struct device *dev = smmu->dev;
> +
> +       smmu->num_clocks =
> +               of_property_count_strings(dev->of_node, "clock-names");
> +
> +       if (smmu->num_clocks < 1)
> +               return 0;
> +
> +       smmu->clocks = devm_kzalloc(dev,
> +                                   sizeof(*smmu->clocks) * smmu->num_clocks,
> +                                   GFP_KERNEL);
> +
> +       if (!smmu->clocks) {
> +               dev_err(dev, "Failed to allocate memory for clocks\n");
> +               return -ENODEV;
> +       }
> +
> +       i = 0;

Please do the initialisation above when you declare the variable.

> +       of_property_for_each_string(dev->of_node, "clock-names", prop, cname) {
> +               struct clk *c = devm_clk_get(dev, cname);
> +
> +               if (IS_ERR(c)) {
> +                       dev_err(dev, "Couldn't get clock: %s", cname);
> +                       return -EPROBE_DEFER;
> +               }
> +
> +               smmu->clocks[i] = c;
> +               ++i;
> +       }
> +
> +       return 0;
> +}
> +
>  static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  {
>         unsigned long size;
> @@ -1968,6 +2038,13 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>                 smmu->irqs[i] = irq;
>         }
>
> +       err = arm_smmu_init_clocks(smmu);
> +       if (err)
> +               return err;
> +
> +       platform_set_drvdata(pdev, smmu);
> +       pm_runtime_enable(dev);
> +       pm_runtime_get_sync(dev);
>         err = arm_smmu_device_cfg_probe(smmu);
>         if (err)
>                 return err;
> @@ -1996,8 +2073,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>         }
>
>         of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
> -       platform_set_drvdata(pdev, smmu);
>         arm_smmu_device_reset(smmu);
> +       pm_runtime_put_sync(dev);
>
>         /* Oh, for a proper bus abstraction */
>         if (!iommu_present(&platform_bus_type))
> @@ -2027,13 +2104,43 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>
>         /* Turn the thing off */
>         writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
> +
> +       pm_runtime_force_suspend(smmu->dev);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int arm_smmu_resume(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
> +
> +       return arm_smmu_enable_clocks(smmu);
> +}
> +
> +static int arm_smmu_suspend(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
> +
> +       arm_smmu_disable_clocks(smmu);
> +
>         return 0;
>  }
> +#endif
> +
> +static const struct dev_pm_ops arm_smmu_pm_ops = {
> +       SET_RUNTIME_PM_OPS(arm_smmu_suspend, arm_smmu_resume, NULL)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
> +};
>
>  static struct platform_driver arm_smmu_driver = {
>         .driver = {
>                 .name           = "arm-smmu",
>                 .of_match_table = of_match_ptr(arm_smmu_of_match),
> +               .pm = &arm_smmu_pm_ops,
>         },
>         .probe  = arm_smmu_device_dt_probe,
>         .remove = arm_smmu_device_remove,
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
