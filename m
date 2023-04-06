Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84CE8BE0;
	Thu,  6 Apr 2023 15:45:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 368D5169E;
	Thu,  6 Apr 2023 08:45:48 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CD0A3F762;
	Thu,  6 Apr 2023 08:45:02 -0700 (PDT)
Message-ID: <51111b86-97af-b3d2-d3e8-5cebc350f37f@arm.com>
Date: Thu, 6 Apr 2023 16:44:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 07/17] iommu: Make iommu_group_do_dma_first_attach()
 simpler
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <7-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2023 12:38 am, Jason Gunthorpe wrote:
> It should always attach to the current group->domain, so don't take in a
> domain parameter. Use the __iommu_device_set_domain() common code to
> handle the attach.

Hmm, why do we still end up with this in two places, and potentially 
called twice in the same path?

iommu_probe_device()
   __iommu_probe_device()
     iommu_group_get_for_dev()
       iommu_group_add_device()
         iommu_group_do_dma_first_attach()
   iommu_create_device_direct_mappings()
   iommu_group_do_dma_first_attach()

Seems off to me... at best it's confusing, but at worst it's plain wrong 
(it's the one in iommu_group_add_device() that I'm most suspicious of)

Not to mention the slightly different open-coded variant we still seem 
to have in iommu_setup_default_domain() via the "else if 
(!group->default_domain)" path :/

(BTW if any comments seem misplaced, it's because I'm really looking at 
the end result at the cover-letter commit in your branch, rather than 
trying to review each patch independently)

Thanks,
Robin.

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index af3af752c255e4..c68cf551d05dc4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -105,6 +105,10 @@ enum {
>   	IOMMU_SET_DOMAIN_WITH_DEFERRED = 1 << 1,
>   };
>   
> +static int __iommu_device_set_domain(struct iommu_group *group,
> +				     struct device *dev,
> +				     struct iommu_domain *new_domain,
> +				     unsigned int flags);
>   static int __iommu_group_set_domain_internal(struct iommu_group *group,
>   					     struct iommu_domain *new_domain,
>   					     unsigned int flags);
> @@ -405,18 +409,10 @@ static bool iommu_is_attach_deferred(struct device *dev)
>   	return false;
>   }
>   
> -static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
> +static int iommu_group_do_dma_first_attach(struct iommu_group *group, struct device *dev)
>   {
> -	struct iommu_domain *domain = data;
> -
> -	lockdep_assert_held(&dev->iommu_group->mutex);
> -
> -	if (iommu_is_attach_deferred(dev)) {
> -		dev->iommu->attach_deferred = 1;
> -		return 0;
> -	}
> -
> -	return __iommu_attach_device(domain, dev);
> +	return __iommu_device_set_domain(group, dev, group->domain,
> +					 IOMMU_SET_DOMAIN_WITH_DEFERRED);
>   }
>   
>   int iommu_probe_device(struct device *dev)
> @@ -449,7 +445,7 @@ int iommu_probe_device(struct device *dev)
>   	 * attach the default domain.
>   	 */
>   	if (group->default_domain && !group->owner) {
> -		ret = iommu_group_do_dma_first_attach(dev, group->default_domain);
> +		ret = iommu_group_do_dma_first_attach(group, dev);
>   		if (ret) {
>   			mutex_unlock(&group->mutex);
>   			iommu_group_put(group);
> @@ -1117,7 +1113,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>   	mutex_lock(&group->mutex);
>   	list_add_tail(&device->list, &group->devices);
>   	if (group->domain)
> -		ret = iommu_group_do_dma_first_attach(dev, group->domain);
> +		ret = iommu_group_do_dma_first_attach(group, dev);
>   	mutex_unlock(&group->mutex);
>   	if (ret)
>   		goto err_put_group;
