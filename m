Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38FB1E489
	for <iommu@lists.linux.dev>; Thu,  7 Dec 2023 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E31B512FC;
	Thu,  7 Dec 2023 01:56:59 -0800 (PST)
Received: from [10.57.74.174] (unknown [10.57.74.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B579F3F762;
	Thu,  7 Dec 2023 01:56:12 -0800 (PST)
Message-ID: <f1c473f7-ba40-454e-bd3e-a47f6d58513e@arm.com>
Date: Thu, 7 Dec 2023 09:56:10 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu: Set owner token to sva and nested domains
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231207021938.306738-1-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231207021938.306738-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-07 2:19 am, Lu Baolu wrote:
> Commit a9c362db3920 ("iommu: Validate that devices match domains") added
> an owner token to an iommu_domain. This token is checked during domain
> attachment to RID or PASID through the generic iommu interfaces.
> 
> The sva and nested domains are attached to device or PASID through the
> generic iommu interfaces. Therefore, they require the owner token to be
> set during allocation. Otherwise, they fail to attach.

Oops, I missed that iommu_sva_domain_alloc() is a thing - when did we 
get such a confusing proliferation of domain allocation paths? Sigh...

I think we should set the owner generically there, since presumably it's 
being missed for SMMUv3/AMD/etc. SVA domains as well. Nested domains are 
supposed to be OK since both ->domain_alloc_user callsites are covered, 
or is there some other sneaky path I've also missed?

Thanks,
Robin.

> Set the owner token for sva and nested domains.
> 
> Fixes: a9c362db3920 ("iommu: Validate that devices match domains")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/nested.c | 1 +
>   drivers/iommu/iommu.c        | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index b5a5563ab32c..014d4a4e7586 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -108,6 +108,7 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
>   	domain->s1_cfg = vtd;
>   	domain->domain.ops = &intel_nested_domain_ops;
>   	domain->domain.type = IOMMU_DOMAIN_NESTED;
> +	domain->domain.owner = &intel_iommu_ops;
>   	INIT_LIST_HEAD(&domain->devices);
>   	INIT_LIST_HEAD(&domain->dev_pasids);
>   	spin_lock_init(&domain->lock);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0d25468d53a6..d0a28667479a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3617,6 +3617,7 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>   	domain->type = IOMMU_DOMAIN_SVA;
>   	mmgrab(mm);
>   	domain->mm = mm;
> +	domain->owner = ops;
>   	domain->iopf_handler = iommu_sva_handle_iopf;
>   	domain->fault_data = mm;
>   
