From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC v1 4/7] iommu/arm-smmu-v3: Enable HiSilicon erratum
 161010701
Date: Tue, 16 May 2017 14:13:13 +0100
Message-ID: <6d290334-cb68-5b20-a969-0cc6010922d5@arm.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
 <20170513094731.3676-5-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170513094731.3676-5-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: shameer <shameerali.kolothum.thodi@huawei.com>, will.deacon@arm.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org
Cc: devicetree@vger.kernel.org, gabriele.paoloni@huawei.com, john.garry@huawei.com, linuxarm@huawei.com, linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org, wangzhou1@hisilicon.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, devel@acpica.org
List-Id: iommu@lists.linux-foundation.org

On 13/05/17 10:47, shameer wrote:
> This replaces the existing broken_prefetch_cmd quirk using
> the new erratum framework.
> 
> Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> ---
>  arch/arm64/Kconfig          | 10 +++++++++-
>  drivers/iommu/arm-smmu-v3.c | 36 ++++++++++--------------------------
>  2 files changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a39029b..21d61ff 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -508,8 +508,16 @@ config QCOM_FALKOR_ERRATUM_1009
>  
>  	  If unsure, say Y.
>  
> -endmenu
> +config HISILICON_ERRATUM_161010701
> +	bool "HiSilicon erratum 161010701: Skip SMMU Prefetch Cmd"
> +	default y
> +	help
> +	  On HiSilicon Hip06/Hip07 platforms, the SMMU v3 doesn't support the
> +	  CMD_PREFETCH_CFG. This will skip the prefetch cmd usage.
>  
> +	  If unsure, say Y.

We don't need a config. This feature (not to mention others like it) is
runtime-detected, and has effectively zero execution overhead and
negligible Image-size overhead either way; why would anyone ever turn it
off?

Robin.

> +
> +endmenu
>  
>  choice
>  	prompt "Page size"
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f20d5d5..14538cb 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -650,16 +650,6 @@ struct arm_smmu_domain {
>  	struct iommu_domain		domain;
>  };
>  
> -struct arm_smmu_option_prop {
> -	u32 opt;
> -	const char *prop;
> -};
> -
> -static struct arm_smmu_option_prop arm_smmu_options[] = {
> -	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
> -	{ 0, NULL},
> -};
> -
>  enum smmu_erratum_match_type {
>  	se_match_dt,
>  };
> @@ -677,7 +667,17 @@ struct smmu_erratum_workaround {
>  };
>  
>  static const struct smmu_erratum_workaround smmu_workarounds[] = {
> +#ifdef CONFIG_HISILICON_ERRATUM_161010701
> +	{
> +		.match_type = se_match_dt,
> +		.id = "hisilicon,erratum-161010701",
> +		.desc_str = "HiSilicon erratum 161010701",
> +		.enable = erratum_skip_prefetch_cmd,
> +	},
> +#endif
> +	{
>  
> +	},
>  };
>  
>  typedef bool (*se_match_fn_t)(const struct smmu_erratum_workaround *,
> @@ -735,20 +735,6 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>  	return container_of(dom, struct arm_smmu_domain, domain);
>  }
>  
> -static void parse_driver_options(struct arm_smmu_device *smmu)
> -{
> -	int i = 0;
> -
> -	do {
> -		if (of_property_read_bool(smmu->dev->of_node,
> -						arm_smmu_options[i].prop)) {
> -			smmu->options |= arm_smmu_options[i].opt;
> -			dev_notice(smmu->dev, "option %s\n",
> -				arm_smmu_options[i].prop);
> -		}
> -	} while (arm_smmu_options[++i].opt);
> -}
> -
>  /* Low-level queue manipulation functions */
>  static bool queue_full(struct arm_smmu_queue *q)
>  {
> @@ -2695,8 +2681,6 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  	else
>  		ret = 0;
>  
> -	parse_driver_options(smmu);
> -
>  	smmu_check_workarounds(smmu, se_match_dt, dev->of_node);
>  
>  	if (of_dma_is_coherent(dev->of_node))
> 

