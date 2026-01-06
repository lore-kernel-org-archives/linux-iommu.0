Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69631355050
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726730; cv=none; b=gyDKHQvnXQsfrwP9ZDeKY5X53cAZJrKeRJOHMb0h9AjRWGx3sYvqpJeiv8m9ub4uDVtmV6h5YgTVdtrwv+n1wZCf7AgSqUp9Glj0pCishYbH5BzoVg7B3PacQ2WlEDy9Xyjb66BnMABie6Ew8xg3LTtHm8WVxFzyK/Aw+19lzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726730; c=relaxed/simple;
	bh=SDzQKGWuO/sdn64pswtkgKtgQjm2NSK1ETlO5wGxiHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RC7VK+D0szAW+xIctcQxNuR8VJCAL4gtGVW+74yATtJmTE6vRm9Te08BheJkZK7kgDtxaUJVnSXm7pEtExuiv7vrFrjxqg+5sKHOxsnIjQZW2h3TAZra0QsGzZqKVMe5CGpfZ+MlfZ4fXgYr3OTiBiDrHkZ8qk/oA994XIafY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9CDB497;
	Tue,  6 Jan 2026 11:12:00 -0800 (PST)
Received: from [10.57.46.241] (unknown [10.57.46.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C7853F5A1;
	Tue,  6 Jan 2026 11:12:04 -0800 (PST)
Message-ID: <de876e61-42c5-414d-b439-2f9196c6c128@arm.com>
Date: Tue, 6 Jan 2026 19:12:02 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] dma-mapping: Support batch mode for
 dma_direct_sync_sg_for_*
To: Barry Song <21cnbao@gmail.com>, Leon Romanovsky <leon@kernel.org>
Cc: catalin.marinas@arm.com, m.szyprowski@samsung.com, will@kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 Ada Couprie Diaz <ada.coupriediaz@arm.com>, Ard Biesheuvel
 <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tangquan Zheng <zhengtangquan@oppo.com>
References: <20251226225254.46197-1-21cnbao@gmail.com>
 <20251226225254.46197-6-21cnbao@gmail.com> <20251227200933.GO11869@unreal>
 <CAGsJ_4yA83-K7PXiEtyidzF_j6qqKkt92z485KBS9+zGe_rjnw@mail.gmail.com>
 <20251228145041.GS11869@unreal>
 <CAGsJ_4yex5MKQkGtFr2zUcg4h0PtsFs2QVcE_NSfiyOn4qBzhQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAGsJ_4yex5MKQkGtFr2zUcg4h0PtsFs2QVcE_NSfiyOn4qBzhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-01-06 6:41 pm, Barry Song wrote:
> On Mon, Dec 29, 2025 at 3:50 AM Leon Romanovsky <leon@kernel.org> wrote:
>>
>> On Sun, Dec 28, 2025 at 09:52:05AM +1300, Barry Song wrote:
>>> On Sun, Dec 28, 2025 at 9:09 AM Leon Romanovsky <leon@kernel.org> wrote:
>>>>
>>>> On Sat, Dec 27, 2025 at 11:52:45AM +1300, Barry Song wrote:
>>>>> From: Barry Song <baohua@kernel.org>
>>>>>
>>>>> Instead of performing a flush per SG entry, issue all cache
>>>>> operations first and then flush once. This ultimately benefits
>>>>> __dma_sync_sg_for_cpu() and __dma_sync_sg_for_device().
>>>>>
>>>>> Cc: Leon Romanovsky <leon@kernel.org>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Will Deacon <will@kernel.org>
>>>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>>> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
>>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>>>> Cc: Suren Baghdasaryan <surenb@google.com>
>>>>> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
>>>>> Signed-off-by: Barry Song <baohua@kernel.org>
>>>>> ---
>>>>>   kernel/dma/direct.c | 14 +++++++-------
>>>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> <...>
>>>>
>>>>> -             if (!dev_is_dma_coherent(dev)) {
>>>>> +             if (!dev_is_dma_coherent(dev))
>>>>>                        arch_sync_dma_for_device(paddr, sg->length,
>>>>>                                        dir);
>>>>> -                     arch_sync_dma_flush();
>>>>> -             }
>>>>>        }
>>>>> +     if (!dev_is_dma_coherent(dev))
>>>>> +             arch_sync_dma_flush();
>>>>
>>>> This patch should be squashed into the previous one. You introduced
>>>> arch_sync_dma_flush() there, and now you are placing it elsewhere.
>>>
>>> Hi Leon,
>>>
>>> The previous patch replaces all arch_sync_dma_for_* calls with
>>> arch_sync_dma_for_* plus arch_sync_dma_flush(), without any
>>> functional change. The subsequent patches then implement the
>>> actual batching. I feel this is a better approach for reviewing
>>> each change independently. Otherwise, the previous patch would
>>> be too large.
>>
>> Don't worry about it. Your patches are small enough.
> 
> My hardware does not require a bounce buffer, but I am concerned that
> this patch may be incorrect for systems that do require one.
> 
> Now it is:
> 
> void dma_direct_sync_sg_for_cpu(struct device *dev,
>                  struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> {
>          struct scatterlist *sg;
>          int i;
> 
>          for_each_sg(sgl, sg, nents, i) {
>                  phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
> 
>                  if (!dev_is_dma_coherent(dev))
>                          arch_sync_dma_for_cpu(paddr, sg->length, dir);
> 
>                  swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
> 
>                  if (dir == DMA_FROM_DEVICE)
>                          arch_dma_mark_clean(paddr, sg->length);
>          }
> 
>          if (!dev_is_dma_coherent(dev)) {
>                  arch_sync_dma_flush();
>                  arch_sync_dma_for_cpu_all();
>          }
> }
> 
> Should we call swiotlb_sync_single_for_cpu() and
> arch_dma_mark_clean() after the flush to ensure the CPU sees the
> latest data and that the memcpy is correct? I mean:

Yes, this and the equivalents in the later patches are broken for all 
the sync_for_cpu and unmap paths which may end up bouncing (beware some 
of them get a bit fiddly) - any cache maintenance *must* be completed 
before calling SWIOTLB. As for mark_clean, IIRC that was an IA-64 thing, 
and appears to be entirely dead now.

Thanks,
Robin.

> void dma_direct_sync_sg_for_cpu(struct device *dev,
>                  struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> {
>          struct scatterlist *sg;
>          int i;
> 
>          for_each_sg(sgl, sg, nents, i) {
>                  phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
> 
>                  if (!dev_is_dma_coherent(dev))
>                          arch_sync_dma_for_cpu(paddr, sg->length, dir);
>          }
> 
>          if (!dev_is_dma_coherent(dev)) {
>                  arch_sync_dma_flush();
>                  arch_sync_dma_for_cpu_all();
>          }
> 
>          for_each_sg(sgl, sg, nents, i) {
>                  phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
> 
>                  swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
> 
>                  if (dir == DMA_FROM_DEVICE)
>                          arch_dma_mark_clean(paddr, sg->length);
>          }
> }
> 
> Could this be the same issue for dma_direct_unmap_sg()?
> 
> Another option is to not support batched synchronization for the bounce
> buffer case, since it is rare. In that case, it could be:
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 550a1a13148d..a4840f7e8722 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -423,8 +423,11 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>          for_each_sg(sgl, sg, nents, i) {
>                  phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
> 
> -               if (!dev_is_dma_coherent(dev))
> +               if (!dev_is_dma_coherent(dev)) {
>                          arch_sync_dma_for_cpu(paddr, sg->length, dir);
> +                       if (unlikely(dev->dma_io_tlb_mem))
> +                               arch_sync_dma_flush();
> +               }
> 
>                  swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
> 
> What’s your view on this, Leon?
> 
> Thanks
> Barry

