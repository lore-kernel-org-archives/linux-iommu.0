Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380CC8835;
	Thu, 30 Mar 2023 15:54:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC9C72F4;
	Thu, 30 Mar 2023 08:55:17 -0700 (PDT)
Received: from [10.57.54.254] (unknown [10.57.54.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0ACF3F6C4;
	Thu, 30 Mar 2023 08:54:31 -0700 (PDT)
Message-ID: <6f0e39a3-3a46-f9e3-614e-e6e3c88b59ab@arm.com>
Date: Thu, 30 Mar 2023 16:54:27 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 08/14] iommu: Make iommu_group_do_dma_first_attach()
 work with owned groups
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <8-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <8-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-03-30 00:40, Jason Gunthorpe wrote:
> If the group is already owned then defered attach should not be done and
> the device should be directly connected to the correct domain.
> 
> Owned means that some driver is already bound to devices in the group and
> is operating the group possibly without DMA API support. In this case
> there would be no way to correct the mismatched domain.

How much do we really care about supporting device hotplug while using 
VFIO in a kdump kernel? Surely if anything ever deserved a "don't do 
that"...

In fact I struggle to imagine how it would even be possible for a device 
which *was* present and active when the previous kernel crashed, and 
thus needs deferred attach, to somehow evade bus_iommu_probe() in the 
kdump kernel until after the rest of its group has managed to get as far 
as binding a driver to claim ownership :/

And even if someone did manage to achieve all of this, is it really 
beneficial to let this device start spamming IOMMU faults and/or 
potentially corrupting whatever the kdump kernel *is* trying to do in 
said owned domain, on the offchance that the user might eventually bind 
it to VFIO (or whatever) as well and expect it to then work? TBH I'd say 
that banishing it to roam free in deferred-attach limbo, peacefully 
grazing the wastelands of dead-kernel memory and failing to support any 
non-DMA-API funny business, is the preferable option.

Thanks,
Robin.

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c68cf551d05dc4..6fe8bc78db2016 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -411,8 +411,9 @@ static bool iommu_is_attach_deferred(struct device *dev)
>   
>   static int iommu_group_do_dma_first_attach(struct iommu_group *group, struct device *dev)
>   {
> -	return __iommu_device_set_domain(group, dev, group->domain,
> -					 IOMMU_SET_DOMAIN_WITH_DEFERRED);
> +	return __iommu_device_set_domain(
> +		group, dev, group->domain,
> +		group->owner ? 0 : IOMMU_SET_DOMAIN_WITH_DEFERRED);
>   }
>   
>   int iommu_probe_device(struct device *dev)
