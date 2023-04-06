Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F8A320B;
	Thu,  6 Apr 2023 16:38:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E844153B;
	Thu,  6 Apr 2023 09:38:54 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1DBD3F6C4;
	Thu,  6 Apr 2023 09:38:01 -0700 (PDT)
Message-ID: <db92f18c-e2ed-78d0-db7e-83d8ee8a4dce@arm.com>
Date: Thu, 6 Apr 2023 17:37:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 08/17] iommu: Make iommu_group_do_dma_first_attach()
 work with owned groups
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <8-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <8-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/04/2023 12:38 am, Jason Gunthorpe wrote:
> If the group is already owned then defered attach should not be done and
> the device should be directly connected to the correct domain.
> 
> Owned means that some driver is already bound to devices in the group and
> is operating the group possibly without DMA API support. In this case
> there would be no way to correct the mismatched domain.

Looking more closely at the current code, it seems we just skip any 
attach at all in this case. Thus although there can be technically be a 
mismatch (physically, the device will be either partly or fully assigned 
to the current domain if it is grouped by ID aliasing, or in limbo if it 
is grouped for ACS reasons), it *should* be corrected whenever the 
current owner next detaches its domain. This shouldn't actually be a 
problem in the usual case, since the new device generally won't do 
anything if the existing ownership prevents its driver from binding.

I don't have a particularly strong opinion on changing this behaviour, 
but I guess what's nagging me is that we could do a better job of 
calling out that it *is* a behaviour change, and its implications. 
Namely that they are slightly better if the device binds to the same 
owner, in that it could rely use the current domain straight off without 
the risk of being in ACS limbo, but also slightly worse in that if the 
attach fails for any reason, it will now trash aliased RIDs of devices 
that *were* working OK. It also means that the device could bind to any 
*other* driver with driver_managed_dma and have a much better guarantee 
of having access to the other owner's domain, with all the pitfalls 
therein, but that's only a strengthening of a pre-existing problem :)

Thanks,
Robin.

> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
