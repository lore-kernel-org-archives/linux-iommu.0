From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v12 15/31] iommu/exynos: handle 'mmu-masters' property of DT and improve handling sysmmu
Date: Sun, 27 Apr 2014 20:17:48 +0200
Message-ID: <13595839.WFkdpM5auQ@wuerfel>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com> <1398584283-22846-16-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1398584283-22846-16-git-send-email-shaik.ameer@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Shaik Ameer Basha <shaik.ameer@samsung.com>, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kgene.kim@samsung.com, prathyush.k@samsung.com, grundler@chromium.org, joro@8bytes.org, supash.ramaswamy@linaro.org, tomasz.figa@gmail.com, joshi@samsung.com, sachin.kamat@linaro.org, s.nawrocki@samsung.com, Varun.Sethi@freescale.com, a.motakis@virtualopensystems.com, pullip.cho@samsung.com, t.figa@samsung.com, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

On Sunday 27 April 2014 13:07:47 Shaik Ameer Basha wrote:
> @@ -542,14 +592,41 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/* Relation between master and System MMU is 1:1. */
> +	node = of_parse_phandle(dev->of_node, "mmu-masters", 0);
> +	if (node) {
> +		struct platform_device *master = of_find_device_by_node(node);
> +
> +		if (!master) {
> +			dev_err(dev, "%s: mmu-master '%s' not found\n",
> +				__func__, node->name);
> +			return -EINVAL;
> +		}
> +
> +		if (master->dev.archdata.iommu != NULL) {
> +			dev_err(dev, "%s: '%s' is master of other MMU\n",
> +				__func__, node->name);
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * archdata.iommu will be initialized with exynos_iommu_client
> +		 * in sysmmu_hook_driver_register().
> +		 */
> +		master->dev.archdata.iommu = dev;
> +	}

I think parsing of generic properties like this shouldn't be done
by the individual driver. It belongs into core iommu code and should
be done when the devices are probed.

> +
> +static struct notifier_block sysmmu_notifier = {
> +	.notifier_call = &sysmmu_hook_driver_register,
> +};
> +
> +static int __init exynos_iommu_prepare(void)
> +{
> +	static bool registered = false;
> +	int ret;
> +
> +	if (registered)
> +		return 0;
> +
> +	ret = bus_register_notifier(&platform_bus_type, &sysmmu_notifier);
> +	if (!ret)
> +		registered = true;
> +	else
> +		pr_err("Failed to register sysmmu_notifier\n");
> +
> +	return ret;
> +}

This also means we should not have notifiers. Put it into core code to
make sure all IOMMUs are handled the same way.

	Arnd
