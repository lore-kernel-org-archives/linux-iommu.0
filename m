From: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 19/27] iommu/exynos: add support for power management
 subsystems.
Date: Fri, 14 Mar 2014 17:07:53 +0100
Message-ID: <53232959.7020306@samsung.com>
References: <20140314141028.4b0b62d895905988ab5dda88@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20140314141028.4b0b62d895905988ab5dda88-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi KyongHo,

On 14.03.2014 06:10, Cho KyongHo wrote:
> This adds support for Suspend to RAM and Runtime Power Management.
>
> Since System MMU is located in the same local power domain of its
> master H/W, System MMU must be initialized before it is working if
> its power domain was ever turned off. TLB invalidation according to
> unmapping on page tables must also be performed while power domain is
> turned on.
>
> This patch ensures that resume and runtime_resume(restore_state)
> functions in this driver is called before the calls to resume and
> runtime_resume callback functions in the drivers of master H/Ws.
> Likewise, suspend and runtime_suspend(save_state) functions in this
> driver is called after the calls to suspend and runtime_suspend in the
> drivers of master H/Ws.
>
> In order to get benefit of this support, the master H/W and its System
> MMU must resides in the same power domain in terms of Linux kernel. If
> a master H/W does not use generic I/O power domain, its driver must
> call iommu_attach_device() after its local power domain is turned on,
> iommu_detach_device before turned off.
>
> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/iommu/exynos-iommu.c |  220 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 201 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 9037da0..84ba29a 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -28,6 +28,7 @@
>   #include <linux/export.h>
>   #include <linux/of.h>
>   #include <linux/of_platform.h>
> +#include <linux/pm_domain.h>
>   #include <linux/notifier.h>
>
>   #include <asm/cacheflush.h>
> @@ -203,6 +204,7 @@ struct sysmmu_drvdata {
>   	int activations;
>   	rwlock_t lock;
>   	struct iommu_domain *domain;
> +	bool runtime_active;
>   	unsigned long pgtable;
>   };
>
> @@ -388,7 +390,8 @@ static bool __sysmmu_disable(struct sysmmu_drvdata *data)
>   		data->pgtable = 0;
>   		data->domain = NULL;
>
> -		__sysmmu_disable_nocount(data);
> +		if (data->runtime_active)
> +			__sysmmu_disable_nocount(data);
>
>   		dev_dbg(data->sysmmu, "Disabled\n");
>   	} else  {
> @@ -449,7 +452,8 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
>   		data->pgtable = pgtable;
>   		data->domain = domain;
>
> -		__sysmmu_enable_nocount(data);
> +		if (data->runtime_active)
> +			__sysmmu_enable_nocount(data);
>
>   		dev_dbg(data->sysmmu, "Enabled\n");
>   	} else {
> @@ -534,13 +538,11 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
>   	data = dev_get_drvdata(owner->sysmmu);
>
>   	read_lock_irqsave(&data->lock, flags);
> -	if (is_sysmmu_active(data)) {
> -		unsigned int maj;
> +	if (is_sysmmu_active(data) && data->runtime_active) {
>   		unsigned int num_inv = 1;
>
>   		__master_clk_enable(data);
>
> -		maj = __raw_readl(data->sfrbase + REG_MMU_VERSION);
>   		/*
>   		 * L2TLB invalidation required
>   		 * 4KB page: 1 invalidation
> @@ -551,7 +553,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
>   		 * 1MB page can be cached in one of all sets.
>   		 * 64KB page can be one of 16 consecutive sets.
>   		 */
> -		if ((maj >> 28) == 2) /* major version number */
> +		if (__sysmmu_version(data, NULL) == 2) /* major version number */
>   			num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
>
>   		if (sysmmu_block(data->sfrbase)) {
> @@ -576,7 +578,7 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
>   	data = dev_get_drvdata(owner->sysmmu);
>
>   	read_lock_irqsave(&data->lock, flags);
> -	if (is_sysmmu_active(data)) {
> +	if (is_sysmmu_active(data) && data->runtime_active) {
>   		__master_clk_enable(data);
>   		if (sysmmu_block(data->sfrbase)) {
>   			__sysmmu_tlb_invalidate(data->sfrbase);
> @@ -677,11 +679,40 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, data);
>
>   	pm_runtime_enable(dev);
> +	data->runtime_active = !pm_runtime_enabled(dev);

Hmm, this seems to be a bit misleading. The field is named 
runtime_active, but the assignment makes it true if PM runtime is _not_ 
enabled (i.e. inactive). Is this correct?

>
>   	dev_dbg(dev, "Probed and initialized\n");
>   	return 0;
>   }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sysmmu_suspend(struct device *dev)
> +{
> +	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
> +	unsigned long flags;
> +	read_lock_irqsave(&data->lock, flags);
> +	if (is_sysmmu_active(data) &&
> +		(!pm_runtime_enabled(dev) || data->runtime_active))
> +		__sysmmu_disable_nocount(data);
> +	read_unlock_irqrestore(&data->lock, flags);
> +	return 0;
> +}
> +
> +static int sysmmu_resume(struct device *dev)
> +{
> +	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
> +	unsigned long flags;
> +	read_lock_irqsave(&data->lock, flags);
> +	if (is_sysmmu_active(data) &&
> +		(!pm_runtime_enabled(dev) || data->runtime_active))
> +		__sysmmu_enable_nocount(data);
> +	read_unlock_irqrestore(&data->lock, flags);
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(sysmmu_pm_ops, sysmmu_suspend, sysmmu_resume);
> +
>   #ifdef CONFIG_OF
>   static struct of_device_id sysmmu_of_match[] __initconst = {
>   	{ .compatible	= "samsung,sysmmu-v1", },
> @@ -698,6 +729,7 @@ static struct platform_driver exynos_sysmmu_driver __refdata = {
>   	.driver	= {
>   		.owner		= THIS_MODULE,
>   		.name		= "exynos-sysmmu",
> +		.pm		= &sysmmu_pm_ops,
>   		.of_match_table	= of_match_ptr(sysmmu_of_match),
>   	}
>   };
> @@ -1111,24 +1143,152 @@ err_reg_driver:
>   }
>   subsys_initcall(exynos_iommu_init);
>
> +#ifdef CONFIG_PM_SLEEP
> +static int sysmmu_pm_genpd_suspend(struct device *dev)
> +{
> +	struct exynos_iommu_owner *owner = dev->archdata.iommu;
> +	int ret;
> +
> +	ret = pm_generic_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	return pm_generic_suspend(owner->sysmmu);
> +}
> +
> +static int sysmmu_pm_genpd_resume(struct device *dev)
> +{
> +	struct exynos_iommu_owner *owner = dev->archdata.iommu;
> +	int ret;
> +
> +	ret = pm_generic_resume(owner->sysmmu);
> +	if (ret)
> +		return ret;
> +
> +	return pm_generic_resume(dev);
> +}
> +#endif
> +
> +#ifdef CONFIG_PM_RUNTIME
> +static void sysmmu_restore_state(struct device *sysmmu)
> +{
> +	struct sysmmu_drvdata *data = dev_get_drvdata(sysmmu);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	data->runtime_active = true;
> +	if (is_sysmmu_active(data))
> +		__sysmmu_enable_nocount(data);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +static void sysmmu_save_state(struct device *sysmmu)
> +{
> +	struct sysmmu_drvdata *data = dev_get_drvdata(sysmmu);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	if (is_sysmmu_active(data))
> +		__sysmmu_disable_nocount(data);
> +	data->runtime_active = false;
> +	spin_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +static int sysmmu_pm_genpd_save_state(struct device *dev)
> +{
> +	struct exynos_iommu_client *client = dev->archdata.iommu;
> +	int (*cb)(struct device *__dev);
> +	int ret = 0;
> +
> +	if (dev->type && dev->type->pm)
> +		cb = dev->type->pm->runtime_suspend;
> +	else if (dev->class && dev->class->pm)
> +		cb = dev->class->pm->runtime_suspend;
> +	else if (dev->bus && dev->bus->pm)
> +		cb = dev->bus->pm->runtime_suspend;
> +	else
> +		cb = NULL;
> +
> +	if (!cb && dev->driver && dev->driver->pm)
> +		cb = dev->driver->pm->runtime_suspend;
> +
> +	if (cb)
> +		ret = cb(dev);
> +
> +	if (ret == 0)
> +		sysmmu_save_state(client->sysmmu);
> +
> +	return ret;
> +}
> +
> +static int sysmmu_pm_genpd_restore_state(struct device *dev)
> +{
> +	struct exynos_iommu_client *client = dev->archdata.iommu;
> +	int (*cb)(struct device *__dev);
> +	int ret = 0;
> +
> +	if (dev->type && dev->type->pm)
> +		cb = dev->type->pm->runtime_resume;
> +	else if (dev->class && dev->class->pm)
> +		cb = dev->class->pm->runtime_resume;
> +	else if (dev->bus && dev->bus->pm)
> +		cb = dev->bus->pm->runtime_resume;
> +	else
> +		cb = NULL;
> +
> +	if (!cb && dev->driver && dev->driver->pm)
> +		cb = dev->driver->pm->runtime_resume;
> +
> +	sysmmu_restore_state(client->sysmmu);
> +
> +	if (cb)
> +		ret = cb(dev);
> +
> +	if (ret)
> +		sysmmu_save_state(client->sysmmu);
> +
> +	return ret;
> +}
> +#endif
> +
> +#ifdef CONFIG_PM_GENERIC_DOMAINS
> +struct gpd_dev_ops sysmmu_devpm_ops = {
> +#ifdef CONFIG_PM_RUNTIME
> +	.save_state = &sysmmu_pm_genpd_save_state,
> +	.restore_state = &sysmmu_pm_genpd_restore_state,
> +#endif
> +#ifdef CONFIG_PM_SLEEP
> +	.suspend = &sysmmu_pm_genpd_suspend,
> +	.resume = &sysmmu_pm_genpd_resume,
> +#endif
> +};
> +#endif /* CONFIG_PM_GENERIC_DOMAINS */
> +
>   static int sysmmu_hook_driver_register(struct notifier_block *nb,
>   					unsigned long val,
>   					void *p)
>   {
>   	struct device *dev = p;
>
> +	/*
> +	 * No System MMU assigned even though in the initial state.
> +	 * See exynos_sysmmu_probe().
> +	 */
> +	if (dev->archdata.iommu == NULL)
> +		return 0;
> +
>   	switch (val) {
>   	case BUS_NOTIFY_BIND_DRIVER:
>   	{
>   		struct exynos_iommu_owner *owner;
> +		int ret;
>
> -		/* No System MMU assigned. See exynos_sysmmu_probe(). */
> -		if (dev->archdata.iommu == NULL)
> -			break;
> +		BUG_ON(!dev_get_drvdata(dev->archdata.iommu));
>
>   		owner = devm_kzalloc(dev, sizeof(*owner), GFP_KERNEL);
>   		if (!owner) {
>   			dev_err(dev, "No Memory for exynos_iommu_owner\n");
> +			dev->archdata.iommu = NULL;
>   			return -ENOMEM;
>   		}
>
> @@ -1136,22 +1296,44 @@ static int sysmmu_hook_driver_register(struct notifier_block *nb,
>   		INIT_LIST_HEAD(&owner->client);
>   		owner->sysmmu = dev->archdata.iommu;
>
> +		ret = pm_genpd_add_callbacks(dev, &sysmmu_devpm_ops, NULL);
> +		if (ret && (ret != -ENOSYS)) {
> +			dev_err(dev,
> +				"Failed to register 'dev_pm_ops' for iommu\n");
> +			devm_kfree(dev, owner);
> +			dev->archdata.iommu = NULL;
> +			return ret;
> +		}
> +
>   		dev->archdata.iommu = owner;
>   		break;
>   	}
> -	case BUS_NOTIFY_UNBOUND_DRIVER:
> +	case BUS_NOTIFY_BOUND_DRIVER:
>   	{
>   		struct exynos_iommu_owner *owner = dev->archdata.iommu;
> -		if (owner) {
> -			struct device *sysmmu = owner->sysmmu;
> -			/* if still attached to an iommu_domain. */
> -			if (WARN_ON(!list_empty(&owner->client)))
> -				iommu_detach_device(owner->domain, owner->dev);
> -			devm_kfree(dev, owner);
> -			dev->archdata.iommu = sysmmu;
> +		if (!pm_runtime_enabled(dev)) {
> +			struct sysmmu_drvdata *data =
> +					dev_get_drvdata(owner->sysmmu);
> +			if (pm_runtime_enabled(data->sysmmu)) {
> +				data->runtime_active = true;
> +				if (is_sysmmu_active(data))
> +					__sysmmu_enable_nocount(data);
> +				pm_runtime_disable(data->sysmmu);
> +			}
>   		}
>   		break;
>   	}
> +	case BUS_NOTIFY_UNBOUND_DRIVER:
> +	{
> +		struct exynos_iommu_owner *owner = dev->archdata.iommu;
> +		struct device *sysmmu = owner->sysmmu;
> +		if (WARN_ON(!list_empty(&owner->client)))
> +			iommu_detach_device(owner->domain, dev);
> +		__pm_genpd_remove_callbacks(dev, false);
> +		devm_kfree(dev, owner);
> +		dev->archdata.iommu = sysmmu;
> +		break;
> +	}
>   	} /* switch (val) */
>
>   	return 0;
> @@ -1165,4 +1347,4 @@ static int __init exynos_iommu_prepare(void)
>   {
>   	return bus_register_notifier(&platform_bus_type, &sysmmu_notifier);
>   }
> -arch_initcall(exynos_iommu_prepare);
> +subsys_initcall_sync(exynos_iommu_prepare);

Again, initcall is not quite right way to handle platform-specific 
things, considering that we are going to have a multiplatform kernel.

Anyway, I'm not sure if genpd is the right place to plug into with IOMMU 
power management. Marek Szyprowski has already solved this issue without 
hacks like this in our internal code, he's on holidays right now, but I 
added him on Cc and also Bartlomiej Zolnierkiewicz, who may also know 
something about this. Also added some PM guys on Cc.

Best regards,
Tomasz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
