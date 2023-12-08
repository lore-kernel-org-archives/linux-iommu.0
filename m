Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E419BB6
	for <iommu@lists.linux.dev>; Fri,  8 Dec 2023 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69E4411FB;
	Fri,  8 Dec 2023 03:15:48 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D89AB3F762;
	Fri,  8 Dec 2023 03:15:01 -0800 (PST)
Message-ID: <4fb1b999-7b1b-4d54-a0ca-87b596458ba0@arm.com>
Date: Fri, 8 Dec 2023 11:15:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu: Set owner token to SVA domain
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231208015314.320663-1-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231208015314.320663-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/12/2023 1:53 am, Lu Baolu wrote:
> Commit a9c362db3920 ("iommu: Validate that devices match domains") added
> an owner token to the iommu_domain. This token is checked during domain
> attachment to RID or PASID through the generic iommu interfaces.
> 
> The SVA domains are attached to PASIDs through those iommu interfaces.
> Therefore, they require the owner token to be set during allocation.
> Otherwise, they fail to attach.
> 
> Set the owner token for SVA domains.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: a9c362db3920 ("iommu: Validate that devices match domains")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/iommu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> Change log:
> v2:
> - The user domain allocation path does the right thing. Hence no need
>    to fix anything.
> v1:
> - https://lore.kernel.org/linux-iommu/20231207021938.306738-1-baolu.lu@linux.intel.com/
> 
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
