Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CA374C2
	for <iommu@lists.linux.dev>; Tue, 19 Sep 2023 12:18:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACCB51FB;
	Tue, 19 Sep 2023 05:19:31 -0700 (PDT)
Received: from [10.1.27.72] (010265703453.arm.com [10.1.27.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FC0B3F67D;
	Tue, 19 Sep 2023 05:18:52 -0700 (PDT)
Message-ID: <fef0b304-5a19-b2a3-c399-7f21c05623bf@arm.com>
Date: Tue, 19 Sep 2023 13:18:31 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 8/8] iommu: Improve map/unmap sanity checks
Content-Language: en-GB
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
 heiko@sntech.de, jernej.skrabec@gmail.com, thierry.reding@gmail.com,
 vdumpa@nvidia.com
References: <cover.1694525662.git.robin.murphy@arm.com>
 <524db1ec0139c964d26928a6a264945aa66d010c.1694525662.git.robin.murphy@arm.com>
 <ZQHJoK0Er/nekjL6@ziepe.ca> <8c8451aa-d0d7-058e-cfc2-7402f9002234@arm.com>
 <ZQMBLFB20ke4hv9t@ziepe.ca> <e37085dc-cac4-b7f4-8c2e-e51e56a66887@arm.com>
 <ZQM5WRzyQkk7sq+t@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZQM5WRzyQkk7sq+t@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-09-14 17:48, Jason Gunthorpe wrote:
> On Thu, Sep 14, 2023 at 03:23:46PM +0100, Robin Murphy wrote:
>>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>>> index c83f2e4c56f5..391bcae4d02d 100644
>>>>>> --- a/drivers/iommu/iommu.c
>>>>>> +++ b/drivers/iommu/iommu.c
>>>>>> @@ -2427,12 +2427,12 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>>>>>>     	phys_addr_t orig_paddr = paddr;
>>>>>>     	int ret = 0;
>>>>>> -	if (unlikely(!ops->map_pages || domain->pgsize_bitmap == 0UL))
>>>>>> -		return -ENODEV;
>>>>>> -
>>>>>>     	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
>>>>>>     		return -EINVAL;
>>>>>
>>>>> Why isn't this a WARN_ON? The caller is clearly lost its mind if it
>>>>> is calling map on a non paging domain..
>>>>
>>>> Sure it's a dumb thing to do, however I don't think we can reasonably say
>>>> without question that an external caller being dumb represents an unexpected
>>>> and serious loss of internal consistency.
>>>
>>> WARN_ON is not just for "serious loss of internal consistency" it
>>> should be use in all places where invariant are violated. We can't
>>> guess why the caller is using this wrong (most likely it is UAF or
>>> memory corruption), but if this fires something definately has gone
>>> wrong with the kernel.
>>
>> Has it? It's not *functionally* incorrect to obtain a valid domain by
>> calling iommu_get_domain_for_dev(), pass that domain to iommu_map(), and
>> handle any failure returned.
> 
> This is not a theoretical question - does any in-kernel code actually
> do that and expect it to work? I didn't notice any..

I was hoping to have to say I'd only seen it in unmerged (e.g. [1]) and 
downstream code, but then I found drivers/net/ipa/ :(

(and amusingly, the line I happened to look at first blamed you, but 
that was only for that mechanical change of the iommu_map() prototype)

> It doesn't matter that someone *could*, our task is not to make an
> overly general API. We can, and should, have tight invarients because
> it allows discovery of more bug classes, and prevents "creative" use
> of APIs.
> 
>> is calling iommu_iova_to_phys() on non-paging domains, and we have to
>> support that, because callers are dumb, and "callers aren't dumb" is not a
>> realistic invariant which we can uphold.
> 
> Someone does that? :(

Only every user of iommu_iova_to_phys() outside of drivers/iommu/, VFIO, 
and the arch/arm DMA ops...

>>> eg if syzkaller somehow hits this we want the WARN_ON so it reports
>>> it.
>>
>> But then an "IOMMU bug" is reported to us, and we say "yeah, that's not
>> ours, that's some code somewhere down in the middle of that callstack being
>> dumb", and then what?
> 
> The report gets handed off to the part of the callstack that is making
> the problem.

And if it's critical to them that a mapping succeeds, they should 
probably have their own warning already. An inappropriate domain type is 
far from critical to us, and is something we've already allowed to fail 
cleanly and gracefully for the best part of a decade.

>> iommu_map() can already fail for numerous reasons that may or may not
>> represent a bug in the caller, like the IOVA or PA being out-of-range, or
>> the IOVA already being mapped, or whatever.
> 
> IMHO some of those certainly could be WARN too, depends what you think
> the API should be.

We don't even have consistent behaviour across IOMMU drivers for most of 
them, and some callers are written around particular driver-specific 
behaviours (yes, even VFIO), so IMO there's no way we're in a position 
to suddenly decree that anyone's fundamentally wrong for doing something 
that we've long considered a non-critical failure, but have now decided 
looks sketchy.

> eg iommufd and vfio both are designed to never double map/use out of
> aperture IOVA/etc, if they do it is a significant bug and a WARN_ON
> would be welcomed.
> 
>> another reason to fail (in, as far as we're concerned, an entirely safe and
>> manageable way). Callers have to be prepared to handle failure, but it's up
>> to them how unexpected or serious it is; we can't second-guess them.
> 
> We can always convert things into error codes, but that can also hide
> bugs if no existing caller needs that functionality. IMHO it is always
> better to have tighter invarients, and be noisy when they fail. This
> gives us better understandablity, bug discoverability and discourages
> people from introducing new code doing crazy things.
All that said, I don't mind if you want to propose a separate patch to 
turn certain external caller conditions into noisy warnings, but I 
wouldn't want to tie it up with any other changes which would risk 
getting caught in the crossfire if someone does then hit a 
newly-introduced warning and start arguing to revert it. And I'm not 
going to do so in any of my patches since as above I don't personally 
believe it's a valuable thing to do.

Thanks,
Robin.
