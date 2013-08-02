From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v8 07/12] iommu/exynos: support for device tree
Date: Fri, 02 Aug 2013 19:17:34 +0200
Message-ID: <1720760.jtrXTGRgvT@amdc1032>
References: <003d01ce89f3$44ec2cf0$cec486d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <003d01ce89f3$44ec2cf0$cec486d0$@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Linux Samsung SOC' <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Hyunwoong Kim' <khw0178.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Prathyush' <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Grant Grundler' <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Keyyoung Park' <keyyoung.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux Kernel' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'Sachin Kamat' <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Antonios Motakis' <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, 'Linux ARM Kernel' <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, 'Rahul Sharma' <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


Hi,

On Friday, July 26, 2013 08:28:36 PM Cho KyongHo wrote:
> This commit adds device tree support for System MMU.
> This also include the following changes and enhancements:
> 
> * use managed device helper functions.
> Simplyfies System MMU device driver.
> 
> * use only a single clock descriptor.
> System MMU device descriptor is seperate if it is imposible to make
> a single clock descriptor to make a device descriptor for a group of
> System MMUs.
> 
> * removed dbgname member from sysmmu_drvdata structure.
> debugging kernel message for a System MMU is distinguisheable with the
> name of device descroptors.

It would make review easier and speed up merge process if this patch
would be split on separate ones (each containing one logical change).

> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/iommu/Kconfig        |    5 +-
>  drivers/iommu/exynos-iommu.c |  182 ++++++++++++++++--------------------------
>  2 files changed, 70 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c332fb9..d45f3c9 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -168,16 +168,15 @@ config TEGRA_IOMMU_SMMU
>  
>  config EXYNOS_IOMMU
>  	bool "Exynos IOMMU Support"
> -	depends on ARCH_EXYNOS && EXYNOS_DEV_SYSMMU
> +	depends on ARCH_EXYNOS
>  	select IOMMU_API
> +	default n

default n is superfluous

>  	help
>  	  Support for the IOMMU(System MMU) of Samsung Exynos application
>  	  processor family. This enables H/W multimedia accellerators to see
>  	  non-linear physical memory chunks as a linear memory in their
>  	  address spaces
>  
> -	  If unsure, say N here.
> -

Removal of these 2 lines doesn't seem to be an improvement IMHO.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>  config EXYNOS_IOMMU_DEBUG
>  	bool "Debugging log for Exynos IOMMU"
>  	depends on EXYNOS_IOMMU
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 093eea5..cfc02ed 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -26,6 +26,7 @@
>  #include <linux/list.h>
>  #include <linux/memblock.h>
>  #include <linux/export.h>
> +#include <linux/of.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/pgtable.h>
> @@ -170,15 +171,14 @@ struct sysmmu_drvdata {
>  	struct list_head node; /* entry of exynos_iommu_domain.clients */
>  	struct device *sysmmu;	/* System MMU's device descriptor */
>  	struct device *dev;	/* Owner of system MMU */
> -	char *dbgname;
>  	int nsfrs;
> -	void __iomem **sfrbases;
> -	struct clk *clk[2];
> +	struct clk *clk;
>  	int activations;
>  	rwlock_t lock;
>  	struct iommu_domain *domain;
>  	sysmmu_fault_handler_t fault_handler;
>  	unsigned long pgtable;
> +	void __iomem *sfrbases[0];
>  };
>  
>  static bool set_sysmmu_active(struct sysmmu_drvdata *data)
> @@ -385,8 +385,8 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
>  	if (!ret && (itype != SYSMMU_FAULT_UNKNOWN))
>  		__raw_writel(1 << itype, data->sfrbases[i] + REG_INT_CLEAR);
>  	else
> -		dev_dbg(data->sysmmu, "(%s) %s is not handled.\n",
> -				data->dbgname, sysmmu_fault_name[itype]);
> +		dev_dbg(data->sysmmu, "%s is not handled.\n",
> +				sysmmu_fault_name[itype]);
>  
>  	if (itype != SYSMMU_FAULT_UNKNOWN)
>  		sysmmu_unblock(data->sfrbases[i]);
> @@ -410,10 +410,8 @@ static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
>  	for (i = 0; i < data->nsfrs; i++)
>  		__raw_writel(CTRL_DISABLE, data->sfrbases[i] + REG_MMU_CTRL);
>  
> -	if (data->clk[1])
> -		clk_disable(data->clk[1]);
> -	if (data->clk[0])
> -		clk_disable(data->clk[0]);
> +	if (data->clk)
> +		clk_disable(data->clk);
>  
>  	disabled = true;
>  	data->pgtable = 0;
> @@ -422,10 +420,10 @@ finish:
>  	write_unlock_irqrestore(&data->lock, flags);
>  
>  	if (disabled)
> -		dev_dbg(data->sysmmu, "(%s) Disabled\n", data->dbgname);
> +		dev_dbg(data->sysmmu, "Disabled\n");
>  	else
> -		dev_dbg(data->sysmmu, "(%s) %d times left to be disabled\n",
> -					data->dbgname, data->activations);
> +		dev_dbg(data->sysmmu, "%d times left to be disabled\n",
> +					data->activations);
>  
>  	return disabled;
>  }
> @@ -452,14 +450,12 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
>  			ret = 1;
>  		}
>  
> -		dev_dbg(data->sysmmu, "(%s) Already enabled\n", data->dbgname);
> +		dev_dbg(data->sysmmu, "Already enabled\n");
>  		goto finish;
>  	}
>  
> -	if (data->clk[0])
> -		clk_enable(data->clk[0]);
> -	if (data->clk[1])
> -		clk_enable(data->clk[1]);
> +	if (data->clk)
> +		clk_enable(data->clk);
>  
>  	data->pgtable = pgtable;
>  
> @@ -479,7 +475,7 @@ static int __exynos_sysmmu_enable(struct sysmmu_drvdata *data,
>  
>  	data->domain = domain;
>  
> -	dev_dbg(data->sysmmu, "(%s) Enabled\n", data->dbgname);
> +	dev_dbg(data->sysmmu, "Enabled\n");
>  finish:
>  	write_unlock_irqrestore(&data->lock, flags);
>  
> @@ -495,7 +491,7 @@ int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
>  
>  	ret = pm_runtime_get_sync(data->sysmmu);
>  	if (ret < 0) {
> -		dev_dbg(data->sysmmu, "(%s) Failed to enable\n", data->dbgname);
> +		dev_dbg(data->sysmmu, "Failed to enable\n");
>  		return ret;
>  	}
>  
> @@ -503,8 +499,8 @@ int exynos_sysmmu_enable(struct device *dev, unsigned long pgtable)
>  	if (WARN_ON(ret < 0)) {
>  		pm_runtime_put(data->sysmmu);
>  		dev_err(data->sysmmu,
> -			"(%s) Already enabled with page table %#lx\n",
> -			data->dbgname, data->pgtable);
> +			"Already enabled with page table %#lx\n",
> +			data->pgtable);
>  	} else {
>  		data->dev = dev;
>  	}
> @@ -540,9 +536,7 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
>  			}
>  		}
>  	} else {
> -		dev_dbg(data->sysmmu,
> -			"(%s) Disabled. Skipping invalidating TLB.\n",
> -			data->dbgname);
> +		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
>  	}
>  
>  	read_unlock_irqrestore(&data->lock, flags);
> @@ -564,141 +558,101 @@ void exynos_sysmmu_tlb_invalidate(struct device *dev)
>  			}
>  		}
>  	} else {
> -		dev_dbg(data->sysmmu,
> -			"(%s) Disabled. Skipping invalidating TLB.\n",
> -			data->dbgname);
> +		dev_dbg(data->sysmmu, "Disabled. Skipping invalidating TLB.\n");
>  	}
>  
>  	read_unlock_irqrestore(&data->lock, flags);
>  }
>  
> -static int exynos_sysmmu_probe(struct platform_device *pdev)
> +static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>  {
>  	int i, ret;
> -	struct device *dev;
> +	struct device *dev = &pdev->dev;
>  	struct sysmmu_drvdata *data;
>  
> -	dev = &pdev->dev;
> -
> -	data = kzalloc(sizeof(*data), GFP_KERNEL);
> -	if (!data) {
> -		dev_dbg(dev, "Not enough memory\n");
> -		ret = -ENOMEM;
> -		goto err_alloc;
> +	if (pdev->num_resources == 0) {
> +		dev_err(dev, "No System MMU resource defined\n");
> +		return -ENODEV;
>  	}
>  
> -	ret = dev_set_drvdata(dev, data);
> -	if (ret) {
> -		dev_dbg(dev, "Unabled to initialize driver data\n");
> -		goto err_init;
> +	data = devm_kzalloc(dev,
> +			sizeof(*data) +
> +			sizeof(*data->sfrbases) * (pdev->num_resources / 2),
> +			GFP_KERNEL);
> +	if (!data) {
> +		dev_err(dev, "Not enough memory for initialization\n");
> +		return -ENOMEM;
>  	}
>  
>  	data->nsfrs = pdev->num_resources / 2;
> -	data->sfrbases = kmalloc(sizeof(*data->sfrbases) * data->nsfrs,
> -								GFP_KERNEL);
> -	if (data->sfrbases == NULL) {
> -		dev_dbg(dev, "Not enough memory\n");
> -		ret = -ENOMEM;
> -		goto err_init;
> -	}
>  
>  	for (i = 0; i < data->nsfrs; i++) {
>  		struct resource *res;
> +
>  		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
>  		if (!res) {
> -			dev_dbg(dev, "Unable to find IOMEM region\n");
> -			ret = -ENOENT;
> -			goto err_res;
> +			dev_err(dev, "Unable to find IOMEM region\n");
> +			return -ENOENT;
>  		}
>  
> -		data->sfrbases[i] = ioremap(res->start, resource_size(res));
> +		data->sfrbases[i] = devm_request_and_ioremap(dev, res);
>  		if (!data->sfrbases[i]) {
> -			dev_dbg(dev, "Unable to map IOMEM @ PA:%#x\n",
> -							res->start);
> -			ret = -ENOENT;
> -			goto err_res;
> +			dev_err(dev, "Unable to map IOMEM @ %#x\n", res->start);
> +			return -EBUSY;
>  		}
>  	}
>  
>  	for (i = 0; i < data->nsfrs; i++) {
> -		ret = platform_get_irq(pdev, i);
> -		if (ret <= 0) {
> -			dev_dbg(dev, "Unable to find IRQ resource\n");
> -			goto err_irq;
> +		int irq;
> +
> +		irq = platform_get_irq(pdev, i);
> +		if (irq <= 0) {
> +			dev_err(dev, "Unable to find IRQ resource\n");
> +			return -ENOENT;
>  		}
>  
> -		ret = request_irq(ret, exynos_sysmmu_irq, 0,
> -					dev_name(dev), data);
> +		ret = devm_request_irq(dev, irq, exynos_sysmmu_irq,
> +					0, dev_name(dev), data);
>  		if (ret) {
> -			dev_dbg(dev, "Unabled to register interrupt handler\n");
> -			goto err_irq;
> +			dev_err(dev, "Unable to register handler to irq %d\n",
> +				irq);
> +			return ret;
>  		}
>  	}
>  
> -	if (dev_get_platdata(dev)) {
> -		char *deli, *beg;
> -		struct sysmmu_platform_data *platdata = dev_get_platdata(dev);
> -
> -		beg = platdata->clockname;
> -
> -		for (deli = beg; (*deli != '\0') && (*deli != ','); deli++)
> -			/* NOTHING */;
> -
> -		if (*deli == '\0')
> -			deli = NULL;
> -		else
> -			*deli = '\0';
> -
> -		data->clk[0] = clk_get(dev, beg);
> -		if (IS_ERR(data->clk[0])) {
> -			data->clk[0] = NULL;
> -			dev_dbg(dev, "No clock descriptor registered\n");
> -		}
> +	pm_runtime_enable(dev);
>  
> -		if (data->clk[0] && deli) {
> -			*deli = ',';
> -			data->clk[1] = clk_get(dev, deli + 1);
> -			if (IS_ERR(data->clk[1]))
> -				data->clk[1] = NULL;
> -		}
> +	__set_fault_handler(data, &default_fault_handler);
>  
> -		data->dbgname = platdata->dbgname;
> +	data->sysmmu = dev;
> +	data->clk = devm_clk_get(dev, "sysmmu");
> +	if (IS_ERR(data->clk)) {
> +		dev_info(dev, "No gate clock found!\n");
> +		data->clk = NULL;
>  	}
>  
> -	data->sysmmu = dev;
>  	rwlock_init(&data->lock);
>  	INIT_LIST_HEAD(&data->node);
>  
> -	__set_fault_handler(data, &default_fault_handler);
> -
> -	if (dev->parent)
> -		pm_runtime_enable(dev);
> +	platform_set_drvdata(pdev, data);
> +	dev_dbg(dev, "Probed and initialized\n");
>  
> -	dev_dbg(dev, "(%s) Initialized\n", data->dbgname);
> -	return 0;
> -err_irq:
> -	while (i-- > 0) {
> -		int irq;
> -
> -		irq = platform_get_irq(pdev, i);
> -		free_irq(irq, data);
> -	}
> -err_res:
> -	while (data->nsfrs-- > 0)
> -		iounmap(data->sfrbases[data->nsfrs]);
> -	kfree(data->sfrbases);
> -err_init:
> -	kfree(data);
> -err_alloc:
> -	dev_err(dev, "Failed to initialize\n");
>  	return ret;
>  }
>  
> -static struct platform_driver exynos_sysmmu_driver = {
> -	.probe		= exynos_sysmmu_probe,
> -	.driver		= {
> +#ifdef CONFIG_OF
> +static struct of_device_id sysmmu_of_match[] __initconst = {
> +	{ .compatible	= "samsung,exynos4210-sysmmu", },
> +	{ },
> +};
> +#endif
> +
> +static struct platform_driver exynos_sysmmu_driver __refdata = {
> +	.probe	= exynos_sysmmu_probe,
> +	.driver	= {
>  		.owner		= THIS_MODULE,
>  		.name		= "exynos-sysmmu",
> +		.of_match_table	= of_match_ptr(sysmmu_of_match),
>  	}
>  };
