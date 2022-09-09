Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F19612F
	for <iommu@lists.linux.dev>; Fri,  9 Sep 2022 20:11:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02317165C;
	Fri,  9 Sep 2022 13:11:07 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA2BE3F93E;
	Fri,  9 Sep 2022 13:10:58 -0700 (PDT)
Message-ID: <8e564675-4d65-86c7-0db7-2cce43f2341c@arm.com>
Date: Fri, 9 Sep 2022 21:10:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH rc] iommu: Fix false ownership failure on AMD systems with
 PASID activated
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <0-v1-ea566e16b06b+811-amd_owner_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0-v1-ea566e16b06b+811-amd_owner_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-09 20:46, Jason Gunthorpe wrote:
> The AMD IOMMU driver cannot activate PASID mode on a RID without the RID's
> translation being set to IDENTITY. Further it requires changing the RID's
> page table layout from the normal v1 IOMMU_DOMAIN_IDENTITY layout to a
> different v2 layout.
> 
> It does this by creating a new iommu_domain, configuring that domain for
> v2 identity operation and then attaching it to the group, from within the
> driver. This logic assumes the group is already set to the IDENTITY domain
> and is being used by the DMA API.
> 
> However, since the ownership logic is based on the group's domain pointer
> equaling the default domain to detect DMA API ownership, this causes it to
> look like the group is not attached to the DMA API any more. This blocks
> attaching drivers to any other devices in the group.
> 
> In a real system this manifests itself as the HD-audio devices on some AMD
> platforms loosing their device drivers.
> 
> Work around this unique behavior of the AMD driver by checking for
> equality of IDENTITY domains based on their type, not their pointer
> value. This allows the AMD driver to have two IDENTITY domains for
> internal purposes without breaking the check.
> 
> Have the AMD driver properly declare that the special domain it created is
> actually an IDENTITY domain.

I concur that this seems the least risky fix for now, and removing it 
again in future with a more significant rework of 
amd_iommu_init_device() is best off being its own thing.

Modulo the "idenity" typo in the comment,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: stable@vger.kernel.org
> Fixes: 512881eacfa7 ("bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management")
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Tested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> --
> 
> Robin points out, and I agree, that this logic in the AMD driver is poorly
> organized.
> 
> With the coming support for AMD's RID as PASID 0 it makes more sense to
> eventually follow what the SMMU driver does and decouple the RID's
> configuration from the iommu_domains. This flow would have the underlying
> config to be upgraded from v1 to v2 and keep the same IDENTITY or
> DMA/UNMANAGED domain attached unchanged.
> 
> ---
>   drivers/iommu/amd/iommu_v2.c |  2 ++
>   drivers/iommu/iommu.c        | 21 +++++++++++++++++++--
>   2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> index 696d5555be5794..6a1f02c62dffcc 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -777,6 +777,8 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>   	if (dev_state->domain == NULL)
>   		goto out_free_states;
>   
> +	/* See iommu_is_default_domain() */
> +	dev_state->domain->type = IOMMU_DOMAIN_IDENTITY;
>   	amd_iommu_domain_direct_map(dev_state->domain);
>   
>   	ret = amd_iommu_domain_enable_v2(dev_state->domain, pasids);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cb83576b1877d5..21373cf6be748f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3137,6 +3137,24 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>   	return ret;
>   }
>   
> +static bool iommu_is_default_domain(struct iommu_group *group)
> +{
> +	if (group->domain == group->default_domain)
> +		return true;
> +
> +	/*
> +	 * If the default domain was set to identity and it is still an identity
> +	 * domain then we consider this a pass. This happens because of
> +	 * amd_iommu_init_device() replacing the default idenity domain with an
> +	 * identity domain that has a different configuration for AMDGPU.
> +	 */
> +	if (group->default_domain &&
> +	    group->default_domain->type == IOMMU_DOMAIN_IDENTITY &&
> +	    group->domain && group->domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return true;
> +	return false;
> +}
> +
>   /**
>    * iommu_device_use_default_domain() - Device driver wants to handle device
>    *                                     DMA through the kernel DMA API.
> @@ -3155,8 +3173,7 @@ int iommu_device_use_default_domain(struct device *dev)
>   
>   	mutex_lock(&group->mutex);
>   	if (group->owner_cnt) {
> -		if (group->domain != group->default_domain ||
> -		    group->owner) {
> +		if (group->owner || !iommu_is_default_domain(group)) {
>   			ret = -EBUSY;
>   			goto unlock_out;
>   		}
> 
> base-commit: 848c62cb24a820066994d6cccc218dba58725ce9
