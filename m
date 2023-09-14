Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F046EBC
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 14:24:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D65741FB;
	Thu, 14 Sep 2023 07:24:41 -0700 (PDT)
Received: from [10.57.93.68] (unknown [10.57.93.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0184D3F738;
	Thu, 14 Sep 2023 07:24:02 -0700 (PDT)
Message-ID: <e37085dc-cac4-b7f4-8c2e-e51e56a66887@arm.com>
Date: Thu, 14 Sep 2023 15:23:46 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 8/8] iommu: Improve map/unmap sanity checks
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
 heiko@sntech.de, jernej.skrabec@gmail.com, thierry.reding@gmail.com,
 vdumpa@nvidia.com
References: <cover.1694525662.git.robin.murphy@arm.com>
 <524db1ec0139c964d26928a6a264945aa66d010c.1694525662.git.robin.murphy@arm.com>
 <ZQHJoK0Er/nekjL6@ziepe.ca> <8c8451aa-d0d7-058e-cfc2-7402f9002234@arm.com>
 <ZQMBLFB20ke4hv9t@ziepe.ca>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZQMBLFB20ke4hv9t@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-09-14 13:48, Jason Gunthorpe wrote:
> On Wed, Sep 13, 2023 at 07:46:45PM +0100, Robin Murphy wrote:
>> On 2023-09-13 15:39, Jason Gunthorpe wrote:
>>> On Tue, Sep 12, 2023 at 05:18:44PM +0100, Robin Murphy wrote:
>>>> The current checks for the __IOMMU_DOMAIN_PAGING capability seem a
>>>> bit stifled, since it is quite likely now that a non-paging domain
>>>> won't have a pgsize_bitmap and/or mapping ops, and thus get caught
>>>> by the earlier condition anyway. Swap them around to test the more
>>>> fundamental condition first, then we can reasonably also upgrade
>>>> the other to a WARN_ON, since if a driver does ever expose a paging
>>>> domain without the means to actually page, it's clearly very broken.
>>>
>>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>>> ---
>>>>    drivers/iommu/iommu.c | 10 +++++-----
>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index c83f2e4c56f5..391bcae4d02d 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -2427,12 +2427,12 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>>>>    	phys_addr_t orig_paddr = paddr;
>>>>    	int ret = 0;
>>>> -	if (unlikely(!ops->map_pages || domain->pgsize_bitmap == 0UL))
>>>> -		return -ENODEV;
>>>> -
>>>>    	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
>>>>    		return -EINVAL;
>>>
>>> Why isn't this a WARN_ON? The caller is clearly lost its mind if it
>>> is calling map on a non paging domain..
>>
>> Sure it's a dumb thing to do, however I don't think we can reasonably say
>> without question that an external caller being dumb represents an unexpected
>> and serious loss of internal consistency.
> 
> WARN_ON is not just for "serious loss of internal consistency" it
> should be use in all places where invariant are violated. We can't
> guess why the caller is using this wrong (most likely it is UAF or
> memory corruption), but if this fires something definately has gone
> wrong with the kernel.

Has it? It's not *functionally* incorrect to obtain a valid domain by 
calling iommu_get_domain_for_dev(), pass that domain to iommu_map(), and 
handle any failure returned. Sure, it's *semantically* questionable, but 
so is calling iommu_iova_to_phys() on non-paging domains, and we have to 
support that, because callers are dumb, and "callers aren't dumb" is not 
a realistic invariant which we can uphold.

> eg if syzkaller somehow hits this we want the WARN_ON so it reports
> it.

But then an "IOMMU bug" is reported to us, and we say "yeah, that's not 
ours, that's some code somewhere down in the middle of that callstack 
being dumb", and then what? I know I don't have the time or inclination 
to go off debugging and redesigning random other bits of the kernel for 
calling our API in ways that look sketchy but aren't technically 
invalid, do you?

iommu_map() can already fail for numerous reasons that may or may not 
represent a bug in the caller, like the IOVA or PA being out-of-range, 
or the IOVA already being mapped, or whatever. The wrong type of domain 
is just another reason to fail (in, as far as we're concerned, an 
entirely safe and manageable way). Callers have to be prepared to handle 
failure, but it's up to them how unexpected or serious it is; we can't 
second-guess them.

Thanks,
Robin.
