Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA93B1FA0
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 08:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660725686; x=1692261686;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Qgw3dITpVYjWWXnFOxqjo9qejf+PqGbq4KN3YKnkoU=;
  b=bpK7QEiHmhXdSm8IpQhJvLb6XhzFex3IQqB7rqzucbiZIaNcvPULDiLQ
   T6zXRlEaRzi04HPGoV4ZALqqBh/ljGMliW+O5o++lKQt1nArd/qmhkGBl
   NZlqxyqDr78gIVsvRkTCWe5lgSFLeowMK+WqTyvdIcYCfbFptbi7s3DeI
   DoECf6q92hMzuzGlDi1+IDJY/mCwJHFUetQJU3m9xBoRV4M+IKF0j3GZs
   CEITxkGdoAJYl3Cumixiemr10qLYUHjJ3wo7LgFp2a/nBYURTscW9D/Om
   NDbwb7NIrX4L/U2YPNgkJcOyMGnTxb53CB6mD6LcWthWTlu2PS+DlCj5q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272832862"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="272832862"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:41:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667514571"
Received: from jzhan60-mobl1.ccr.corp.intel.com (HELO [10.254.209.228]) ([10.254.209.228])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:41:24 -0700
Message-ID: <0030c6c6-7c35-916a-9663-8b71b4378ee7@linux.intel.com>
Date: Wed, 17 Aug 2022 16:41:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] iommu: Retire iommu_capable()
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/8/15 23:26, Robin Murphy wrote:
> With all callers now converted to the device-specific version, retire
> the old bus-based interface, and give drivers the chance to indicate
> accurate per-instance capabilities.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/amd/iommu.c                   |  2 +-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  2 +-
>   drivers/iommu/fsl_pamu_domain.c             |  2 +-
>   drivers/iommu/intel/iommu.c                 |  2 +-
>   drivers/iommu/iommu.c                       | 11 +----------
>   drivers/iommu/s390-iommu.c                  |  2 +-
>   include/linux/iommu.h                       |  8 +-------
>   9 files changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 65b8e4fd8217..94220eb5bff3 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2251,7 +2251,7 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
>   	return ops->iova_to_phys(ops, iova);
>   }
>   
> -static bool amd_iommu_capable(enum iommu_cap cap)
> +static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
>   {
>   	switch (cap) {
>   	case IOMMU_CAP_CACHE_COHERENCY:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d32b02336411..ab919ec43c4d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1992,7 +1992,7 @@ static const struct iommu_flush_ops arm_smmu_flush_ops = {
>   };
>   
>   /* IOMMU API */
> -static bool arm_smmu_capable(enum iommu_cap cap)
> +static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>   {
>   	switch (cap) {
>   	case IOMMU_CAP_CACHE_COHERENCY:
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index dfa82df00342..ce036a053fb8 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1330,7 +1330,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
>   	return ops->iova_to_phys(ops, iova);
>   }
>   
> -static bool arm_smmu_capable(enum iommu_cap cap)
> +static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>   {
>   	switch (cap) {
>   	case IOMMU_CAP_CACHE_COHERENCY:
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 17235116d3bb..66ca47f2e57f 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -493,7 +493,7 @@ static phys_addr_t qcom_iommu_iova_to_phys(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> -static bool qcom_iommu_capable(enum iommu_cap cap)
> +static bool qcom_iommu_capable(struct device *dev, enum iommu_cap cap)
>   {
>   	switch (cap) {
>   	case IOMMU_CAP_CACHE_COHERENCY:
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index 011f9ab7f743..08fd9089e3ba 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -178,7 +178,7 @@ static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
>   	return iova;
>   }
>   
> -static bool fsl_pamu_capable(enum iommu_cap cap)
> +static bool fsl_pamu_capable(struct device *dev, enum iommu_cap cap)
>   {
>   	return cap == IOMMU_CAP_CACHE_COHERENCY;
>   }
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7cca030a508e..da63b358ef4a 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4429,7 +4429,7 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>   	return true;
>   }
>   
> -static bool intel_iommu_capable(enum iommu_cap cap)
> +static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
>   {
>   	if (cap == IOMMU_CAP_CACHE_COHERENCY)
>   		return true;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 780fb7071577..6283a8b4def4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1869,19 +1869,10 @@ bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
>   	if (!ops->capable)
>   		return false;
>   
> -	return ops->capable(cap);
> +	return ops->capable(dev, cap);
>   }
>   EXPORT_SYMBOL_GPL(device_iommu_capable);
>   
> -bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
> -{
> -	if (!bus->iommu_ops || !bus->iommu_ops->capable)
> -		return false;
> -
> -	return bus->iommu_ops->capable(cap);
> -}
> -EXPORT_SYMBOL_GPL(iommu_capable);
> -
>   /**
>    * iommu_set_fault_handler() - set a fault handler for an iommu domain
>    * @domain: iommu domain
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index c898bcbbce11..cd0ee89d63e0 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -39,7 +39,7 @@ static struct s390_domain *to_s390_domain(struct iommu_domain *dom)
>   	return container_of(dom, struct s390_domain, domain);
>   }
>   
> -static bool s390_iommu_capable(enum iommu_cap cap)
> +static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
>   {
>   	switch (cap) {
>   	case IOMMU_CAP_CACHE_COHERENCY:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ea30f00dc145..e39372dfe8c4 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -227,7 +227,7 @@ struct iommu_iotlb_gather {
>    * @owner: Driver module providing these ops
>    */
>   struct iommu_ops {
> -	bool (*capable)(enum iommu_cap);
> +	bool (*capable)(struct device *dev, enum iommu_cap);
>   
>   	/* Domain allocation and freeing by the iommu driver */
>   	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
> @@ -420,7 +420,6 @@ extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
>   extern int bus_iommu_probe(struct bus_type *bus);
>   extern bool iommu_present(struct bus_type *bus);
>   extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
> -extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
>   extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
>   extern struct iommu_group *iommu_group_get_by_id(int id);
>   extern void iommu_domain_free(struct iommu_domain *domain);
> @@ -697,11 +696,6 @@ static inline bool device_iommu_capable(struct device *dev, enum iommu_cap cap)
>   	return false;
>   }
>   
> -static inline bool iommu_capable(struct bus_type *bus, enum iommu_cap cap)
> -{
> -	return false;
> -}
> -
>   static inline struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>   {
>   	return NULL;

