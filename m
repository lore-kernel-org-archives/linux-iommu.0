Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FC63F
	for <iommu@lists.linux.dev>; Sat, 21 Oct 2023 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3s3NmEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697857894; x=1729393894;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZFacCnU7Y9wR0trfqq/hr/Y27IJoz94I/0/7y0TdFaY=;
  b=A3s3NmEjyB8uojJET73H4k+nco4AzgvGD2/hnSBJqjfUKMu5Ge4Rhuty
   /PQ4l+LntZxqerEdh4nUkK6HX1wwwv5u95ymMHvioXtczgji4tSo1ZU50
   BaJhzngtH7v9waSFFjj7qBFIuKAhTnmE2SXArDMMzgbB2JyPyjTYft2WW
   0ausHXhP6ODfIP/e8RJ53wzIeEPQqUcmJ8auUj8dJ8vKSy2ql/wGwOTQB
   sadobLQUiqLTWaBWdtkm7djZk0YC/p04utl6xEuYpTyPUJQlyuXBjL5A8
   RbfuKPu8HmCiw+KS9E7hv1c+rbmHFmOWrHdChM5Tnnuq+dqu2DNblUfWc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="366834210"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="366834210"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 20:11:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="786964239"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="786964239"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga008.jf.intel.com with ESMTP; 20 Oct 2023 20:11:19 -0700
Message-ID: <20c7880b-613e-4efe-a43b-c3b9c601ba1c@linux.intel.com>
Date: Sat, 21 Oct 2023 11:07:35 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com
Subject: Re: [PATCH v6 7/8] iommu/vt-d: Add nested domain allocation
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20231020093246.17015-1-yi.l.liu@intel.com>
 <20231020093246.17015-8-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231020093246.17015-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/23 5:32 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> This adds the support for IOMMU_HWPT_DATA_VTD_S1 type.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 39 ++++++++++++++++++++++++++-----------
>   1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b47025fbdea4..c7704e7efd4a 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4076,7 +4076,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
>   			      struct iommu_domain *parent,
>   			      const struct iommu_user_data *user_data)
>   {
> -	struct iommu_domain *domain;
> +	bool request_nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
>   	struct intel_iommu *iommu;
>   
>   	if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
> @@ -4086,18 +4086,35 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
>   	if (!iommu)
>   		return ERR_PTR(-ENODEV);
>   
> -	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
> +	if (!user_data) { /* Must be PAGING domain */
> +		struct iommu_domain *domain;
> +
> +		if (request_nest_parent && !ecap_nest(iommu->ecap))

Hardware capability is not sufficient. How about adding below helper:

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b5f33a7c1973..b04bbabcd696 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -540,6 +540,8 @@ enum {
  #define sm_supported(iommu)    (intel_iommu_sm && 
ecap_smts((iommu)->ecap))
  #define pasid_supported(iommu) (sm_supported(iommu) &&                 \
                                  ecap_pasid((iommu)->ecap))
+#define nested_supported(iommu)        (sm_supported(iommu) && 
        \
+                                ecap_nest((iommu)->ecap))

  struct pasid_entry;
  struct pasid_state_entry;

And, use nested_supported() here and bleow

> +			return ERR_PTR(-EOPNOTSUPP);
> +		if (parent)
> +			return ERR_PTR(-EINVAL);
> +		/*
> +		 * domain_alloc_user op needs to fully initialize a domain
> +		 * before return, so uses iommu_domain_alloc() here for
> +		 * simple.
> +		 */
> +		domain = iommu_domain_alloc(dev->bus);
> +		if (!domain)
> +			return ERR_PTR(-ENOMEM);
> +		return domain;
> +	}
> +
> +	/* Must be nested domain */
> +	if (!ecap_nest(iommu->ecap))

...here.

> +		return ERR_PTR(-EOPNOTSUPP);
> +	if (user_data->type != IOMMU_HWPT_DATA_VTD_S1)
>   		return ERR_PTR(-EOPNOTSUPP);
> +	if (!parent || parent->ops != intel_iommu_ops.default_domain_ops)
> +		return ERR_PTR(-EINVAL);
> +	if (request_nest_parent)
> +		return ERR_PTR(-EINVAL);
>   
> -	/*
> -	 * domain_alloc_user op needs to fully initialize a domain
> -	 * before return, so uses iommu_domain_alloc() here for
> -	 * simple.
> -	 */
> -	domain = iommu_domain_alloc(dev->bus);
> -	if (!domain)
> -		domain = ERR_PTR(-ENOMEM);
> -	return domain;
> +	return intel_nested_domain_alloc(parent, user_data);
>   }
>   
>   static void intel_iommu_domain_free(struct iommu_domain *domain)

Best regards,
baolu
