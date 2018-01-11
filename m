From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/9] iommu/of: Drop early initialisation hooks
Date: Thu, 11 Jan 2018 10:40:48 +0100
Message-ID: <60fdd375-ca74-0fea-c598-39a68b9e7735@samsung.com>
References: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
        <CGME20180111082537epcas3p274f6bfeb31f10742e8129dc0c877745e@epcas3p2.samsung.com>
        <20180111082229.24011-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20180111082229.24011-2-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jeffy,

On 2018-01-11 09:22, Jeffy Chen wrote:
> With the probe-deferral mechanism, early initialisation hooks are no
> longer needed.
>
> Suggested-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>
>   drivers/iommu/arm-smmu-v3.c  |  2 +-
>   drivers/iommu/arm-smmu.c     | 12 ++++++------
>   drivers/iommu/exynos-iommu.c |  2 +-

For Exynos IOMMU:
Acked-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

IPMMU and MSM IOMMU are no longer multi-platform safe after this patch.
It breaks them in the same way as my commit 928055a01b3f ("iommu/exynos:
Remove custom platform device registration code") broke Exynos IOMMU.

You need a similar fix for them:
https://www.spinics.net/lists/arm-kernel/msg627648.html

>   drivers/iommu/ipmmu-vmsa.c   | 17 ++---------------
>   drivers/iommu/msm_iommu.c    | 24 +++++++-----------------
>   drivers/iommu/of_iommu.c     | 16 ----------------
>   drivers/iommu/qcom_iommu.c   |  2 +-
>   include/linux/of_iommu.h     |  6 ++----
>   8 files changed, 20 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 744592d330ca..3f2f1fc68b52 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2971,7 +2971,7 @@ static struct platform_driver arm_smmu_driver = {
>   };
>   module_platform_driver(arm_smmu_driver);
>   
> -IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", NULL);
> +IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3");
>   
>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>   MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 78d4c6b8f1ba..69e7c60792a8 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2211,12 +2211,12 @@ static struct platform_driver arm_smmu_driver = {
>   };
>   module_platform_driver(arm_smmu_driver);
>   
> -IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1", NULL);
> -IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2", NULL);
> -IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400", NULL);
> -IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401", NULL);
> -IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500", NULL);
> -IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2", NULL);
> +IOMMU_OF_DECLARE(arm_smmuv1, "arm,smmu-v1");
> +IOMMU_OF_DECLARE(arm_smmuv2, "arm,smmu-v2");
> +IOMMU_OF_DECLARE(arm_mmu400, "arm,mmu-400");
> +IOMMU_OF_DECLARE(arm_mmu401, "arm,mmu-401");
> +IOMMU_OF_DECLARE(arm_mmu500, "arm,mmu-500");
> +IOMMU_OF_DECLARE(cavium_smmuv2, "cavium,smmu-v2");
>   
>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>   MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 79c45650f8de..1c7f926fad0e 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1394,4 +1394,4 @@ static int __init exynos_iommu_init(void)
>   }
>   core_initcall(exynos_iommu_init);
>   
> -IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu", NULL);
> +IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu");
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 8dce3a9de9d8..07b711bb4b16 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1081,12 +1081,8 @@ static struct platform_driver ipmmu_driver = {
>   
>   static int __init ipmmu_init(void)
>   {
> -	static bool setup_done;
>   	int ret;
>   
> -	if (setup_done)
> -		return 0;
> -
>   	ret = platform_driver_register(&ipmmu_driver);
>   	if (ret < 0)
>   		return ret;
> @@ -1096,7 +1092,6 @@ static int __init ipmmu_init(void)
>   		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
>   #endif
>   
> -	setup_done = true;
>   	return 0;
>   }
>   
> @@ -1109,16 +1104,8 @@ subsys_initcall(ipmmu_init);
>   module_exit(ipmmu_exit);
>   
>   #ifdef CONFIG_IOMMU_DMA
> -static int __init ipmmu_vmsa_iommu_of_setup(struct device_node *np)
> -{
> -	ipmmu_init();
> -	return 0;
> -}
> -
> -IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
> -		 ipmmu_vmsa_iommu_of_setup);
> -IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795",
> -		 ipmmu_vmsa_iommu_of_setup);
> +IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa");
> +IOMMU_OF_DECLARE(ipmmu_r8a7795_iommu_of, "renesas,ipmmu-r8a7795");
>   #endif
>   
>   MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 04f4d51ffacb..a41d4251b0a9 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -856,7 +856,7 @@ static struct platform_driver msm_iommu_driver = {
>   	.remove		= msm_iommu_remove,
>   };
>   
> -static int __init msm_iommu_driver_init(void)
> +static int __init msm_iommu_init(void)
>   {
>   	int ret;
>   
> @@ -864,30 +864,20 @@ static int __init msm_iommu_driver_init(void)
>   	if (ret != 0)
>   		pr_err("Failed to register IOMMU driver\n");
>   
> +	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
> +
>   	return ret;
>   }
>   
> -static void __exit msm_iommu_driver_exit(void)
> +static void __exit msm_iommu_exit(void)
>   {
>   	platform_driver_unregister(&msm_iommu_driver);
>   }
>   
> -subsys_initcall(msm_iommu_driver_init);
> -module_exit(msm_iommu_driver_exit);
> -
> -static int __init msm_iommu_init(void)
> -{
> -	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
> -	return 0;
> -}
> -
> -static int __init msm_iommu_of_setup(struct device_node *np)
> -{
> -	msm_iommu_init();
> -	return 0;
> -}
> +subsys_initcall(msm_iommu_init);
> +module_exit(msm_iommu_exit);
>   
> -IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu", msm_iommu_of_setup);
> +IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu");
>   
>   MODULE_LICENSE("GPL v2");
>   MODULE_AUTHOR("Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>");
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 50947ebb6d17..5c36a8b7656a 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -231,19 +231,3 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   
>   	return ops;
>   }
> -
> -static int __init of_iommu_init(void)
> -{
> -	struct device_node *np;
> -	const struct of_device_id *match, *matches = &__iommu_of_table;
> -
> -	for_each_matching_node_and_match(np, matches, &match) {
> -		const of_iommu_init_fn init_fn = match->data;
> -
> -		if (init_fn && init_fn(np))
> -			pr_err("Failed to initialise IOMMU %pOF\n", np);
> -	}
> -
> -	return 0;
> -}
> -postcore_initcall_sync(of_iommu_init);
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index e07f02d00c68..65b9c99707f8 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -947,7 +947,7 @@ static void __exit qcom_iommu_exit(void)
>   module_init(qcom_iommu_init);
>   module_exit(qcom_iommu_exit);
>   
> -IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1", NULL);
> +IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1");
>   
>   MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
>   MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index cddfaff4d0b7..ae03752e8e3a 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -34,9 +34,7 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>   
>   extern struct of_device_id __iommu_of_table;
>   
> -typedef int (*of_iommu_init_fn)(struct device_node *);
> -
> -#define IOMMU_OF_DECLARE(name, compat, fn) \
> -	_OF_DECLARE(iommu, name, compat, fn, of_iommu_init_fn)
> +#define IOMMU_OF_DECLARE(name, compat) \
> +	OF_DECLARE_1(iommu, name, compat, NULL)
>   
>   #endif /* __OF_IOMMU_H */

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
