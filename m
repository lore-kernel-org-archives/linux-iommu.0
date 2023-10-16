Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE47FF
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwrHUf8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697417692; x=1728953692;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eVVOKNaoV1GqhQSSBWrVREy2npI2C53gYQVRc8E/coM=;
  b=nwrHUf8EALFXz/RrbxqF3f+btWd3wzsKWGBqOAEb8y8PZ8s/gNbYkTHJ
   kSdS4R1w3bkpog/l4FZhDHiXnqk9mTmiELAbr7Pf/TUpDd55jTuYLYc+j
   jQ09MOO3JHglFBqk2KWIPpZdZ657TaI1ja4nB5r9aDVruA4RJpFgx7e69
   jEsUYE4+DiIL62ynC54+FP0vQb2ZIsn241Ez+q4FAcMY+CEiefSWbWjQE
   RkSDO6F7+L8ExfknSlBPKyBAzTV5zmRoYo3Fos9u3KSz2O8IfhHnIWX1R
   oC6F5wPmdzQGItjNqG3az6AzReWrAaN73fw04slhvlPIMcyht9vU6V+lF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4036721"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="4036721"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 17:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1002731447"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="1002731447"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 15 Oct 2023 17:54:47 -0700
Message-ID: <046e8881-2fe4-45db-846e-99122d4dce86@linux.intel.com>
Date: Mon, 16 Oct 2023 08:51:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 19/19] iommu/intel: Access/Dirty bit support for SL
 domains
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
 <20230923012511.10379-20-joao.m.martins@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230923012511.10379-20-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/23 9:25 AM, Joao Martins wrote:
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -300,6 +300,7 @@ static int iommu_skip_te_disable;
>   #define IDENTMAP_AZALIA		4
>   
>   const struct iommu_ops intel_iommu_ops;
> +const struct iommu_dirty_ops intel_dirty_ops;
>   
>   static bool translation_pre_enabled(struct intel_iommu *iommu)
>   {
> @@ -4077,6 +4078,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>   static struct iommu_domain *
>   intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
>   {
> +	bool enforce_dirty = (flags & IOMMU_HWPT_ALLOC_ENFORCE_DIRTY);
>   	struct iommu_domain *domain;
>   	struct intel_iommu *iommu;
>   
> @@ -4087,9 +4089,15 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
>   	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
>   		return ERR_PTR(-EOPNOTSUPP);
>   
> +	if (enforce_dirty &&
> +	    !device_iommu_capable(dev, IOMMU_CAP_DIRTY))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>   	domain = iommu_domain_alloc(dev->bus);
>   	if (!domain)
>   		domain = ERR_PTR(-ENOMEM);
> +	if (domain && enforce_dirty)

@domain can not be NULL here.

> +		domain->dirty_ops = &intel_dirty_ops;
>   	return domain;
>   }

The VT-d driver always uses second level for a user domain translation.
In order to avoid checks of "domain->use_first_level" in the callbacks,
how about check it here and return failure if first level is used for
user domain?


[...]
         domain = iommu_domain_alloc(dev->bus);
         if (!domain)
                 return ERR_PTR(-ENOMEM);

         if (enforce_dirty) {
                 if (to_dmar_domain(domain)->use_first_level) {
                         iommu_domain_free(domain);
                         return ERR_PTR(-EOPNOTSUPP);
                 }
                 domain->dirty_ops = &intel_dirty_ops;
         }

         return domain;

>   
> @@ -4367,6 +4375,9 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
>   		return dmar_platform_optin();
>   	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
>   		return ecap_sc_support(info->iommu->ecap);
> +	case IOMMU_CAP_DIRTY:
> +		return sm_supported(info->iommu) &&
> +			ecap_slads(info->iommu->ecap);

Above appears several times in this patch. Is it possible to define it
as a macro?

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index bccd44db3316..379e141bbb28 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -542,6 +542,8 @@ enum {
  #define sm_supported(iommu)    (intel_iommu_sm && 
ecap_smts((iommu)->ecap))
  #define pasid_supported(iommu) (sm_supported(iommu) &&                 \
                                  ecap_pasid((iommu)->ecap))
+#define slads_supported(iommu) (sm_supported(iommu) &&                 \
+                                ecap_slads((iommu)->ecap))

>   	default:
>   		return false;
>   	}

Best regards,
baolu
