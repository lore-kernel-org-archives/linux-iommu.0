Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147CD7C;
	Tue,  4 Apr 2023 11:29:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F23E5C14;
	Tue,  4 Apr 2023 04:30:37 -0700 (PDT)
Received: from [10.57.54.55] (unknown [10.57.54.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE22A3F6C4;
	Tue,  4 Apr 2023 04:29:51 -0700 (PDT)
Message-ID: <ed3bbe38-6c70-d6c5-dd97-2eddc2f944ec@arm.com>
Date: Tue, 4 Apr 2023 12:29:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 12/14] iommu: Consolidate the default_domain setup to
 one function
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <12-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <19197c52-139e-c3c5-2771-42323d38c045@linux.intel.com>
 <559f8b71-6636-b4b8-27c4-bd0764baa741@arm.com> <ZCWgdiT12RixU7wU@nvidia.com>
 <ZCWtzjHIYWq6/zvg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZCWtzjHIYWq6/zvg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-03-30 16:42, Jason Gunthorpe wrote:
> On Thu, Mar 30, 2023 at 11:45:10AM -0300, Jason Gunthorpe wrote:
> 
>> IIRC the existing code had both orderings :( I'll add a note about
>> this justification
> 
> Robin, would this be helpful in the short term for ARM?

Yeah, something along these lines seems like the neatest compromise for now.

Cheers,
Robin.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c31c5d6f913194..39c923e71e625a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1778,6 +1778,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   	struct bus_type *bus =
>   		list_first_entry(&group->devices, struct group_device, list)
>   			->dev->bus;
> +	bool direct_failed;
>   	int req_type;
>   	int ret;
>   
> @@ -1824,8 +1825,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   	 * mapped before their device is attached, in order to guarantee
>   	 * continuity with any FW activity
>   	 */
> +	direct_failed = false;
>   	for_each_group_device(group, gdev)
> -		iommu_create_device_direct_mappings(dom, gdev->dev);
> +		if (iommu_create_device_direct_mappings(dom, gdev->dev))
> +			direct_failed = true;
>   
>   	ret = __iommu_group_set_domain_internal(group, dom,
>   						IOMMU_SET_DOMAIN_WITH_DEFERRED);
> @@ -1845,6 +1848,16 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   		goto out_set;
>   	}
>   
> +	/*
> +	 * Driver's are supposed to allow mappings to be installed in a domain
> +	 * before device attachment, but some don't. Hack around this defect by
> +	 * trying again after.
> +	 */
> +	if (direct_failed) {
> +		for_each_group_device(group, gdev)
> +			iommu_create_device_direct_mappings(dom, gdev->dev);
> +	}
> +
>   out_set:
>   	if (group->default_domain)
>   		iommu_domain_free(group->default_domain);
