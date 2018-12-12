From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v6 13/21] iommu/tegra: gart: Integrate with Memory
 Controller driver
Date: Wed, 12 Dec 2018 16:52:12 +0300
Message-ID: <ee3cc3cc-e046-62b8-0f55-243e9a3ef9d0@gmail.com>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-14-digetx@gmail.com> <20181212101407.GJ15092@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212101407.GJ15092@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 12.12.2018 13:14, Thierry Reding wrote:
> On Sun, Dec 09, 2018 at 11:29:42PM +0300, Dmitry Osipenko wrote:
>> The device-tree binding has been changed. There is no separate GART device
>> anymore, it is squashed into the Memory Controller. Integrate GART module
>> with the MC in a way it is done for the SMMU of Tegra30+.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/Kconfig      |  1 +
>>  drivers/iommu/tegra-gart.c | 77 ++++++++++++--------------------------
>>  drivers/memory/tegra/mc.c  | 41 ++++++++++++++++++++
>>  include/soc/tegra/mc.h     | 27 +++++++++++++
>>  4 files changed, 93 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index d9a25715650e..83c099bb7288 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -282,6 +282,7 @@ config ROCKCHIP_IOMMU
>>  config TEGRA_IOMMU_GART
>>  	bool "Tegra GART IOMMU Support"
>>  	depends on ARCH_TEGRA_2x_SOC
>> +	depends on TEGRA_MC
>>  	select IOMMU_API
>>  	help
>>  	  Enables support for remapping discontiguous physical memory
>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>> index 835fea461c59..0a72b6afa842 100644
>> --- a/drivers/iommu/tegra-gart.c
>> +++ b/drivers/iommu/tegra-gart.c
>> @@ -19,16 +19,17 @@
>>   * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>>   */
>>  
>> -#include <linux/init.h>
>>  #include <linux/io.h>
>>  #include <linux/iommu.h>
>>  #include <linux/list.h>
>>  #include <linux/moduleparam.h>
>> -#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/vmalloc.h>
>>  
>> +#include <soc/tegra/mc.h>
>> +
>>  /* bitmap of the page sizes currently supported */
>>  #define GART_IOMMU_PGSIZES	(SZ_4K)
>>  
>> @@ -397,9 +398,8 @@ static const struct iommu_ops gart_iommu_ops = {
>>  	.iotlb_sync	= gart_iommu_sync,
>>  };
>>  
>> -static int tegra_gart_suspend(struct device *dev)
>> +int tegra_gart_suspend(struct gart_device *gart)
>>  {
>> -	struct gart_device *gart = dev_get_drvdata(dev);
>>  	unsigned long iova;
>>  	u32 *data = gart->savedata;
>>  	unsigned long flags;
>> @@ -411,9 +411,8 @@ static int tegra_gart_suspend(struct device *dev)
>>  	return 0;
>>  }
>>  
>> -static int tegra_gart_resume(struct device *dev)
>> +int tegra_gart_resume(struct gart_device *gart)
>>  {
>> -	struct gart_device *gart = dev_get_drvdata(dev);
>>  	unsigned long flags;
>>  
>>  	spin_lock_irqsave(&gart->pte_lock, flags);
>> @@ -422,41 +421,39 @@ static int tegra_gart_resume(struct device *dev)
>>  	return 0;
>>  }
>>  
>> -static int tegra_gart_probe(struct platform_device *pdev)
>> +struct gart_device *tegra_gart_probe(struct device *dev,
>> +				     const struct tegra_smmu_soc *soc,
>> +				     struct tegra_mc *mc)
>>  {
>>  	struct gart_device *gart;
>> -	struct resource *res, *res_remap;
>> +	struct resource *res_remap;
>>  	void __iomem *gart_regs;
>> -	struct device *dev = &pdev->dev;
>>  	int ret;
>>  
>>  	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
>>  
>> +	/* Tegra30+ has an SMMU and no GART */
>> +	if (soc)
>> +		return NULL;
> 
> This looks weird. Why do we even call tegra_gart_probe() on anything but
> Tegra20?

Probably because I just wanted to replicate the weirdness of calling tegra_smmu_probe() on Tegra20.. for consistency.

>> +
>>  	/* the GART memory aperture is required */
>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	res_remap = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> -	if (!res || !res_remap) {
>> +	res_remap = platform_get_resource(to_platform_device(dev),
>> +					  IORESOURCE_MEM, 1);
>> +	if (!res_remap) {
>>  		dev_err(dev, "GART memory aperture expected\n");
>> -		return -ENXIO;
>> +		return ERR_PTR(-ENXIO);
>>  	}
>>  
>>  	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
>>  	if (!gart) {
>>  		dev_err(dev, "failed to allocate gart_device\n");
>> -		return -ENOMEM;
>> +		return ERR_PTR(-ENOMEM);
>>  	}
>>  
>> -	gart_regs = devm_ioremap(dev, res->start, resource_size(res));
>> -	if (!gart_regs) {
>> -		dev_err(dev, "failed to remap GART registers\n");
>> -		return -ENXIO;
>> -	}
>> -
>> -	ret = iommu_device_sysfs_add(&gart->iommu, &pdev->dev, NULL,
>> -				     dev_name(&pdev->dev));
>> +	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
>>  	if (ret) {
>>  		dev_err(dev, "Failed to register IOMMU in sysfs\n");
>> -		return ret;
>> +		return ERR_PTR(ret);
>>  	}
>>  
>>  	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
>> @@ -468,7 +465,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
>>  		goto remove_sysfs;
>>  	}
>>  
>> -	gart->dev = &pdev->dev;
>> +	gart->dev = dev;
>> +	gart_regs = mc->regs + GART_REG_BASE;
>>  	spin_lock_init(&gart->pte_lock);
>>  	spin_lock_init(&gart->client_lock);
>>  	INIT_LIST_HEAD(&gart->client);
>> @@ -483,46 +481,19 @@ static int tegra_gart_probe(struct platform_device *pdev)
>>  		goto unregister_iommu;
>>  	}
>>  
>> -	platform_set_drvdata(pdev, gart);
>>  	do_gart_setup(gart, NULL);
>>  
>>  	gart_handle = gart;
>>  
>> -	return 0;
>> +	return gart;
>>  
>>  unregister_iommu:
>>  	iommu_device_unregister(&gart->iommu);
>>  remove_sysfs:
>>  	iommu_device_sysfs_remove(&gart->iommu);
>>  
>> -	return ret;
>> -}
>> -
>> -static const struct dev_pm_ops tegra_gart_pm_ops = {
>> -	.suspend	= tegra_gart_suspend,
>> -	.resume		= tegra_gart_resume,
>> -};
>> -
>> -static const struct of_device_id tegra_gart_of_match[] = {
>> -	{ .compatible = "nvidia,tegra20-gart", },
>> -	{ },
>> -};
>> -
>> -static struct platform_driver tegra_gart_driver = {
>> -	.probe		= tegra_gart_probe,
>> -	.driver = {
>> -		.name	= "tegra-gart",
>> -		.pm	= &tegra_gart_pm_ops,
>> -		.of_match_table = tegra_gart_of_match,
>> -		.suppress_bind_attrs = true,
>> -	},
>> -};
>> -
>> -static int __init tegra_gart_init(void)
>> -{
>> -	return platform_driver_register(&tegra_gart_driver);
>> +	return ERR_PTR(ret);
>>  }
>> -subsys_initcall(tegra_gart_init);
>>  
>>  module_param(gart_debug, bool, 0644);
>>  MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index 55ecfb2d8cfd..4cae1c3a853b 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -702,13 +702,54 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>  				PTR_ERR(mc->smmu));
>>  	}
>>  
>> +	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART)) {
>> +		mc->gart = tegra_gart_probe(&pdev->dev, mc->soc->smmu, mc);
>> +		if (IS_ERR(mc->gart))
>> +			dev_err(&pdev->dev, "failed to probe GART: %ld\n",
>> +				PTR_ERR(mc->gart));
>> +	}
> 
> Perhaps if we add a check for for !mc->soc->smmu here we can avoid
> passing this data structure to tegra_gart_probe() and remove the
> corresponding check from tegra_gart_probe(). That seems more like a
> more logical sequence than attempting to probe GART on device that may
> not have one and return.

Then we also want to invoke tegra_smmu_probe only if mc->soc->smmu != NULL, don't we? Seems it makes sense to factor out that change into a separate patch that will remove soc->smmu checks from both SMMU and GART drivers, moving out the checks into the MC driver.

> Also, since there's no error return here, do we want to set mc->gart to
> NULL on error to avoid crashing later on...

Good catch, thanks!

>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_mc_suspend(struct device *dev)
>> +{
>> +	struct tegra_mc *mc = dev_get_drvdata(dev);
>> +	int err;
>> +
>> +	if (mc->gart) {
> 
> ... like here?
> 
>> +		err = tegra_gart_suspend(mc->gart);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> +static int tegra_mc_resume(struct device *dev)
>> +{
>> +	struct tegra_mc *mc = dev_get_drvdata(dev);
>> +	int err;
>> +
>> +	if (mc->gart) {
> 
> And here?
> 
>> +		err = tegra_gart_resume(mc->gart);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dev_pm_ops tegra_mc_pm_ops = {
>> +	.suspend = tegra_mc_suspend,
>> +	.resume = tegra_mc_resume,
>> +};
>> +
>>  static struct platform_driver tegra_mc_driver = {
>>  	.driver = {
>>  		.name = "tegra-mc",
>>  		.of_match_table = tegra_mc_of_match,
>> +		.pm = &tegra_mc_pm_ops,
>>  		.suppress_bind_attrs = true,
>>  	},
>>  	.prevent_deferred_probe = true,
>> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
>> index db5bfdf589b4..5da42e3fb801 100644
>> --- a/include/soc/tegra/mc.h
>> +++ b/include/soc/tegra/mc.h
>> @@ -77,6 +77,7 @@ struct tegra_smmu_soc {
>>  
>>  struct tegra_mc;
>>  struct tegra_smmu;
>> +struct gart_device;
>>  
>>  #ifdef CONFIG_TEGRA_IOMMU_SMMU
>>  struct tegra_smmu *tegra_smmu_probe(struct device *dev,
>> @@ -96,6 +97,31 @@ static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_TEGRA_IOMMU_GART
>> +struct gart_device *tegra_gart_probe(struct device *dev,
>> +				     const struct tegra_smmu_soc *soc,
>> +				     struct tegra_mc *mc);
>> +int tegra_gart_suspend(struct gart_device *gart);
>> +int tegra_gart_resume(struct gart_device *gart);
>> +#else
>> +static inline struct gart_device *
>> +tegra_gart_probe(struct device *dev, const struct tegra_smmu_soc *soc,
>> +		 struct tegra_mc *mc)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline int tegra_gart_suspend(struct gart_device *gart)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline int tegra_gart_resume(struct gart_device *gart)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif
> 
> That doesn't look right. If we don't enable GART, then the dummy
> implementations will be used, but they return error codes, so
> suspend/resume of MC will also fail, causing the whole system to
> not be able to suspend if GART is disabled.

That's not true because the dummy implementations won't be used at all if GART is disabled, unless something horribly wrong happens that makes mc->gart != NULL.

> I think it'd be better to avoid the dummy functions and instead add
> extra checks for IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) where these are
> called. That way references to these functions should be discarded
> at translation time.
> 
> To be specific, tegra_mc_suspend() and tegra_mc_resume() would change
> like this:
> 
> 	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) && mc->gart)

Okay, thanks!
