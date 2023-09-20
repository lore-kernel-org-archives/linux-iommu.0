Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D8F185D
	for <iommu@lists.linux.dev>; Wed, 20 Sep 2023 05:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695186510; x=1726722510;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1+jAS6yHwzuVm+ydois1vVDLifWQ2vZ5OOkmlSpSb0I=;
  b=Iu7eJ7flbrQPCm1agYeAJnjuFj1f74oH3ymVRbpNMcLdS4tcoVc0qPbC
   B/cvLWWgbZHcE5aBb60kwuHRglnkg6w6qpOsJsR80C/2MHWWR6G9EOsIZ
   PSdkOq600JwOQ4dkJtRtqztfCcYTtoPhQAnt8f5N1PKC6l0LOt46TPd0U
   PQ6oOIW9ZF+eJurybEP5SDvhSyUi7LX4EbX9bNQiUnClB3GPJdgH6ZKsp
   vdLVkPie1JB1174PvYq2bwPmSm3QpQ7/RTWhi5iYhahoPBcVVW5qdch1Z
   H0WshX9EoEtuqjzZONd4oupVPcy1b9ic0jv68yliO3enpsDe7iOpHBkzb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="377434414"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="377434414"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 22:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="781556740"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="781556740"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 19 Sep 2023 22:08:22 -0700
Message-ID: <7d07bea9-02a5-7113-8cc1-f7aed073cf96@linux.intel.com>
Date: Wed, 20 Sep 2023 13:05:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
 chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com, peterx@redhat.com,
 jasowang@redhat.com, shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH 4/6] iommufd/hw_pagetable: Support allocating nested
 parent domain
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, alex.williamson@redhat.com,
 jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-5-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230919092523.39286-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/23 5:25 PM, Yi Liu wrote:
> This extends IOMMU_HWPT_ALLOC to allocate domains used as parent (stage-2)
> in nested translation.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 5be7a31cbd9c..26a8a818ffa3 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -83,6 +83,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   
>   	lockdep_assert_held(&ioas->mutex);
>   
> +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ops->domain_alloc_user)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>   	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
>   	if (IS_ERR(hwpt))
>   		return hwpt;
> @@ -154,7 +157,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>   	struct iommufd_ioas *ioas;
>   	int rc;
>   
> -	if (cmd->flags || cmd->__reserved)
> +	if (cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT || cmd->__reserved)
>   		return -EOPNOTSUPP;

Need a parenthesis here, otherwise the compiler will interpret it as a
different condition.

	if ((cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT) || cmd->__reserved)
		return -EOPNOTSUPP;

Best regards,
baolu
