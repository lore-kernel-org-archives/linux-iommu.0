From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu: Clean up of_iommu_init_fn
Date: Tue, 9 Jan 2018 11:49:01 +0530
Message-ID: <f18a5ed4-0963-a46b-9211-6d20a5c01f5b@codeaurora.org>
References: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
	<1eb597bb451da7e723b83369d5dc6ee478e802f5.1515436860.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1eb597bb451da7e723b83369d5dc6ee478e802f5.1515436860.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 1/9/2018 12:12 AM, Robin Murphy wrote:
> Now that no more drivers rely on arbitrary early initialisation via an
> of_iommu_init_fn hook, let's clean up the redundant remnants. The
> IOMMU_OF_DECLARE() macro needs to remain for now, as the probe-deferral
> mechanism has no other nice way to detect built-in drivers before they
> have registered themselves, such that it can make the right decision.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c  |  2 +-
>  drivers/iommu/arm-smmu.c     | 12 ++++++------
>  drivers/iommu/exynos-iommu.c |  2 +-
>  drivers/iommu/msm_iommu.c    |  2 +-
>  drivers/iommu/of_iommu.c     | 16 ----------------
>  drivers/iommu/qcom_iommu.c   |  2 +-
>  include/linux/of_iommu.h     |  5 +----
>  7 files changed, 11 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 57c92aa3122e..1abbf42a8bd5 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -3009,7 +3009,7 @@ static struct platform_driver arm_smmu_driver = {
>  };
>  module_platform_driver(arm_smmu_driver);
>  
> -IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", NULL);
> +IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3");
>  
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>  MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 3bdb799d3b4b..56147a2be3d0 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2208,12 +2208,12 @@ static struct platform_driver arm_smmu_driver = {
>  };
>  module_platform_driver(arm_smmu_driver);
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
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
>  MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index f596fcc32898..6a96a4c42153 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -1385,4 +1385,4 @@ static int __init exynos_iommu_init(void)
>  }
>  core_initcall(exynos_iommu_init);
>  
> -IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu", NULL);
> +IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu");
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index dda1ce87a070..0d3350463a3f 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -877,7 +877,7 @@ static void __exit msm_iommu_driver_exit(void)
>  subsys_initcall(msm_iommu_driver_init);
>  module_exit(msm_iommu_driver_exit);
>  
> -IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu", NULL);
> +IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu");
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>");
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 50947ebb6d17..5c36a8b7656a 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -231,19 +231,3 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  
>  	return ops;
>  }
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
> index c8a587d034b0..37ecc49deab8 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -924,7 +924,7 @@ static void __exit qcom_iommu_exit(void)
>  module_init(qcom_iommu_init);
>  module_exit(qcom_iommu_exit);
>  
> -IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1", NULL);
> +IOMMU_OF_DECLARE(qcom_iommu_dev, "qcom,msm-iommu-v1");
>  
>  MODULE_DESCRIPTION("IOMMU API for QCOM IOMMU v1 implementations");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 13394ac83c66..0cac59db95bc 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -33,9 +33,6 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>  
>  extern struct of_device_id __iommu_of_table;
>  
> -typedef int (*of_iommu_init_fn)(struct device_node *);
> -
> -#define IOMMU_OF_DECLARE(name, compat, fn) \
> -	_OF_DECLARE(iommu, name, compat, fn, of_iommu_init_fn)
> +#define IOMMU_OF_DECLARE(name, compat)	OF_DECLARE_1(iommu, name, compat, NULL)
>  
>  #endif /* __OF_IOMMU_H */
> 


Reviewed-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
