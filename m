Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8678B1945D
	for <iommu@lists.linux.dev>; Thu,  2 Nov 2023 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C65F02F4;
	Thu,  2 Nov 2023 06:10:35 -0700 (PDT)
Received: from [10.57.83.230] (unknown [10.57.83.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C8233F738;
	Thu,  2 Nov 2023 06:09:51 -0700 (PDT)
Message-ID: <2ae85ba5-5aa5-459a-ace8-b49d12f1ca07@arm.com>
Date: Thu, 2 Nov 2023 13:09:50 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Flow ERR_PTR out from __iommu_domain_alloc()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Janne Grunau <j@jannau.net>,
 Joerg Roedel <jroedel@suse.de>, Sven Peter <sven@svenpeter.dev>
References: <0-v1-ee4b137bfe3f+57-domain_alloc_err_ptr_jgg@nvidia.com>
 <65qhudcviofmcl2g64wca4yy2a772uqvoky6xp62ij2svj67vg@cr2pu6anogqh>
 <20231101231727.GA5675@nvidia.com>
 <98af21ae-f0f0-458a-8a21-7d2002b18ea4@kadam.mountain>
 <3gvk4gzznjsrqouilcqzq7f3lyhmumrm5l25xqk24uuf7426fr@qivhtqql7d2k>
 <9895fa9b-29f6-493f-b4c3-7e227144bd0b@kadam.mountain>
 <20231102121247.GA4488@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231102121247.GA4488@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-02 12:12 pm, Jason Gunthorpe wrote:
> On Thu, Nov 02, 2023 at 08:22:13AM +0300, Dan Carpenter wrote:
>> On Wed, Nov 01, 2023 at 10:09:18PM -0700, Jerry Snitselaar wrote:
>>> On Thu, Nov 02, 2023 at 07:10:57AM +0300, Dan Carpenter wrote:
>>>> On Wed, Nov 01, 2023 at 08:17:27PM -0300, Jason Gunthorpe wrote:
>>>>>          /* The driver gave no guidance on what type to use, try the default */
>>>>>          dom = __iommu_group_alloc_default_domain(group, iommu_def_domain_type);
>>>>> -       if (dom)
>>>>> +       if (!IS_ERR(dom))
>>>>>                  return dom;
>>>>>   
>>>>>          /* Otherwise IDENTITY and DMA_FQ defaults will try DMA */
>>>>>          if (iommu_def_domain_type == IOMMU_DOMAIN_DMA)
>>>>> -               return ERR_PTR(-ENODEV);
>>>>> +               return ERR_PTR(-EINVAL);
>>>>>          dom = __iommu_group_alloc_default_domain(group, IOMMU_DOMAIN_DMA);
>>>>> -       if (!dom)
>>>>> +       if (IS_ERR(dom))
>>>>>                  return dom;
>>>>>   
>>>>>          pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
>>>>
>>>> Not related to your patch, but we should delete/move this warning as
>>>> well.  It's on a success path.
>>>>
>>>> regards,
>>>> dan carpenter
>>>>
>>>
>>> It seems worthwhile to note due to the performance implications, if
>>> nothing else, of having to fall back to the dma domain type from the
>>> two types mentioned in the comment. I'm not sure where would be a
>>> better place since this is first spot where it knows that is going to
>>> be the case.
>>
>> Maybe it should be a pr_info() instead of a pr_warn()?  Maybe I'm just
>> wrong.
> 
> TBH, I'm not entirely sure what it is for, it has been there a long
> time.. I think it means that kernel config and command line options
> are incompatible with this iommu driver

Yes, it's a failure path in the sense that the user has requested 
something (via config or command line) that the IOMMU driver cannot 
provide. Falling back to allocating something different is more "damage 
limitation" than "success".

> But at this moment there are very few drivers that don't support
> IDENTITY (s390 notably, I suppose) and the DMA_FQ stuff is no longer
> driver visible, so it probably never triggers..

Indeed if we get to the point where any platform/driver combination that 
would support IOMMU_DOMAIN_DMA also supports IOMMU_DOMAIN_IDENTITY 
anyway, then this fallback is no longer useful (and we could 
consequently also simplify some stuff further out), however as things 
stand I see at least apple-dart remaining a thorn in the side of that plan.

Thanks,
Robin.
