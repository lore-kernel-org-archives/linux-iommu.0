Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1524A3876A5
	for <iommu@lists.linux.dev>; Thu, 26 Feb 2026 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772135201; cv=none; b=OkcXKanA2p69HyVl+Ann1lxbK7BtPa2NstM2zoxONadLiaA6YDiYoF7sdg6QeXr2rZEXYCsfJUYvpAMpE5EsNDGY6t4rdpMyqNEfXzfBkG9ro6DA+7wAPH7ijACUw/Pi9X7lFhZX2kmQQFUWA6NUVXJ3kmLZxqGoJ7cBvpuKRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772135201; c=relaxed/simple;
	bh=kfB2qjmkbAfdVdR94Cpl4HpOcncVP2aAo5xIWzu4g2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouQxVQtKFDqLjMzicYDTlHOUHYus7WpuKrn68GPE38j6B9kzL0UfRCeSCoHWr8+N+7yZLrWU5wOiwt8bQeq0rSBL2vzbV7sAQl75i4e0Jw2JqfKXK9SqJQ6ftOknhp6NKm+wLTtBO1J+yaulTznRRojUXm8lmzYyt4gqYiATdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 032631516;
	Thu, 26 Feb 2026 11:46:32 -0800 (PST)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E3433F62B;
	Thu, 26 Feb 2026 11:46:33 -0800 (PST)
Message-ID: <7e3a1d3c-64cb-43a8-bd2f-05b24a8d1611@arm.com>
Date: Thu, 26 Feb 2026 19:46:30 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
 Mario.Limonciello@amd.com
References: <20260221235050.2558321-1-lkml@antheas.dev>
 <aZ36tRwNP8cRRX1l@ziepe.ca>
 <CAGwozwFPLLFfKP90fFrt-QC1rKPRCVo_iHuLm4roHX7erQ=Y5Q@mail.gmail.com>
 <aZ3/W8sw+gW5aTA5@ziepe.ca>
 <CAGwozwFKTeXW7_tPcUw8pYvNSoS9860mNJ=OUKCt2vEawYVOJA@mail.gmail.com>
 <6bac3817-9652-4146-ab44-2a9518c3b339@arm.com>
 <CAGwozwGXpVZ1ctUyZ79itwcX7RPjeLebFPWDVpNMq6-f_UtF3A@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAGwozwGXpVZ1ctUyZ79itwcX7RPjeLebFPWDVpNMq6-f_UtF3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2026 10:05 pm, Antheas Kapenekakis wrote:
> On Wed, 25 Feb 2026 at 19:27, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2026-02-24 7:51 pm, Antheas Kapenekakis wrote:
>>> On Tue, 24 Feb 2026 at 20:43, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>
>>>> On Tue, Feb 24, 2026 at 08:33:50PM +0100, Antheas Kapenekakis wrote:
>>>>> On Tue, 24 Feb 2026 at 20:23, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>>>
>>>>>> On Sun, Feb 22, 2026 at 12:50:50AM +0100, Antheas Kapenekakis wrote:
>>>>>>> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
>>>>>>> introduces the shared iommu page table for AMD IOMMU. Some bioses
>>>>>>> contain an identity mapping for address 0x0, which is not parsed
>>>>>>> properly (e.g., certain Strix Halo devices). This causes the DMA
>>>>>>> components of the device to fail to initialize (e.g., the NVMe SSD
>>>>>>> controller), leading to a failed post.
>>>>>>
>>>>>> I'm trying to understand the issue here, is it that the old AMD code
>>>>>> incorrectly succeeded iommu_map() on top of an existing mapping while
>>>>>> the new code returns -EADDRINUSE?
>>>>>>
>>>>>> Then the existing guard for double mapping doesn't work since 0 is an
>>>>>> ambiguous return?
>>>>>
>>>>> Hi Jason,
>>>>>
>>>>> It seems like the previous code correctly handled the 0 case, and the
>>>>> new code does not due to the ambiguous return.
>>>>
>>>> I checked the old AMD driver it is definately returning 0 from
>>>> iommu_iova_to_phys(), so that hasn't changed.
>>>>
>>>>>> reasonabe. Just please clean up the commit message to be a bit clearer
>>>>>> on what caused this regression and add a short comment above the new if:
>>>>>>
>>>>>>    0 return from iommu_iova_to_phys() is ambiguous, it could mean a
>>>>>>    present mapping. EADDRINUSE is reliable when supported, it means the
>>>>>>    IOVA is already mapped, so ignore it to resolve the ambiguity.
>>>>>
>>>>> If you think that this patch is a long term solution, I can drop the
>>>>> print, the addr == 0 check, add a comment on top, then repost a V2
>>>>> with an updated description to be more concrete.
>>>>
>>>> I think it is a good solution as-is, I just want clarity on what
>>>> actually regressed here, and I think it is that iommu_map() behavior
>>>> changed.
>>>
>>> Reverting 789a5913b29c ("iommu/amd: Use the generic iommu page table")
>>> plus two follow-up fixes also worked.
>>>
>>> Looking through it, the removed amd_iommu_map_pages() /
>>> amd_iommu_iova_to_phys() in the previous ops might have behaved
>>> differently.
>>
>> Yes, the old AMD code would happily replace an existing mapping without
>> question (but whether it would correctly invalidate TLBs if just
>> replacing a leaf entry with a different leaf entry at the same level
>> I'm not entirely sure...)
>>
>> However, waiting for a mapping to fail (which may scream its own
>> warning) and then attempting to paper over it seems like an awful bodge.
>> Why not just do something like this?
>>
>> Cheers,
>> Robin.
>>
>> ----->8-----
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 35db51780954..682e95c94236 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1212,8 +1212,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>>
>>                          if (addr == end)
>>                                  goto map_end;
>> -
>> -                       phys_addr = iommu_iova_to_phys(domain, addr);
>> +                       /*
>> +                        * Check for existing translations using an offset, to
>> +                        * distinguish a mapping of the page at PA 0 from none.
>> +                        */
>> +                       phys_addr = iommu_iova_to_phys(domain, addr + 1);
> 
> Hi Robin,
> Assuming pg_size != 1, which it seems to always be due to `1UL <<
> __ffs(domain->pgsize_bitmap)` is an interesting solution. Then again,
> it assumes that the underlying implementations for iommu_iova_to_phys
> would respect translating unaligned addresses. I cannot comment on
> that.

It was a somewhat rhetorical question. We can safely assume that nobody 
would ever build an IOMMU with a 1-byte page size, and that even if 
someone was insane enough to do so, Linux would never support using that 
granularity (since it would be nice to have some memory left for 
anything other than infinite IOMMU pagetables). It's also indeed not 
impossible that a driver might have a bug in its iova_to_phys 
implementation, but then that driver would have a bug that would also 
break other iova_to_phys users (e.g. iommu-dma) anyway. Every other 
possible return value from iova_to_phys is unambiguous, and the single 
one that isn't is trivial to avoid in this case, so why do anything 
other than avoid it?

> I would tend to consider both solutions not ideal, and edge towards
> Jason's suggestion of universally ignoring EADDRINUSE without an
> error. However, I am not an absolutist in that regard.

Relying on magic return values doesn't even work around this issue 
robustly, since even among the drivers which do treat double-mapping as 
an error, they do not all use the same error codes, and as mentioned 
some would already log a visible warning before getting that far. This 
is some core code not quite working as intended, and that fact that it's 
apparently only shown up on AMD platforms which also previously happened 
to hide it hardly makes it right to paper over in a manner that only 
"works" for a few drivers including AMD, rather than properly fix the 
root cause and make the initial check consistently work as intended to 
prevent double-mapping attempts in the first place.

Thanks,
Robin.

> I am on a business trip and do not have the SMTP credentials with me
> for git, so I will send a V2 tomorrow. I already drafted it. I will
> make sure to cc new participants on this thread if not already
> included.
> 
> As an aside, it seems that the issue fixed by this patch is not the
> only one introduced in 6.19, with [1] having users where this patch
> does not help. It seems there are additional issues with thunderbolt
> docks. iommu_map could be the culprit and perhaps forceful remapping,
> as was done previously for AMD would be a more universal solution.
> This way, EADDRINUSE stops being an error.
> 
> Best,
> Antheas
> 
> [1] https://github.com/CachyOS/linux-cachyos/issues/704
> 
>>                          if (!phys_addr) {
>>                                  map_size += pg_size;
>>                                  continue;
>>
>>
> 

