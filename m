Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC3119FA98
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553381; cv=none; b=J1MA5tg8YRUQGaUKXf6asQ+RWeI1jBusPYpx3n8ylfxICUCVYq5ArTWIgoSolaZ1pvBO4/VUkFMZaj+6altZmx0S/7oR6RmPlpbFOqUN3UNtUvE1ysfr05a0wC+lPhozw3CRojKDV2/C5hXuc28OS5IbN+JLRIumi4B7wrTVgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553381; c=relaxed/simple;
	bh=uaScPftzw46kfudcvhqBtQpzC3pXNqXq1+GzDuS1Ax0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtYVVIHmaKaCUxoqr0uJgAYVrtgtSe3KZ7G8QUBpIHhBpucu/7wENei6iRzt2iM0vPqgftMup07xY/lxG7LayeC++ceABw5UkK7eaq6OuZDr5Y8LOEKo8OBGaAQqGxcagGaZLE4RgW5j5UB9WvCmlkw0nF6nqk/9muHXk3EcrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81016FEC;
	Thu,  5 Sep 2024 09:23:24 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 342573F73B;
	Thu,  5 Sep 2024 09:22:53 -0700 (PDT)
Message-ID: <7f4ee8d7-0e17-4363-bf91-d67846157c67@arm.com>
Date: Thu, 5 Sep 2024 17:22:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "iommu/io-pgtable-arm: Optimise non-coherent
 unmap"
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Ashish Mhetre <amhetre@nvidia.com>,
 Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240905124956.84932-1-robdclark@gmail.com>
 <fb54ef8d-f769-47d5-8a9d-aa93f96d5c41@arm.com>
 <CAF6AEGuv=yyVDx58iWU203BQPp-pT2SAC9yW-JMm2U+MTsGUaQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAF6AEGuv=yyVDx58iWU203BQPp-pT2SAC9yW-JMm2U+MTsGUaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/09/2024 2:57 pm, Rob Clark wrote:
> On Thu, Sep 5, 2024 at 6:24 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 05/09/2024 1:49 pm, Rob Clark wrote:
>>> From: Rob Clark <robdclark@chromium.org>
>>>
>>> This reverts commit 85b715a334583488ad7fbd3001fe6fd617b7d4c0.
>>>
>>> It was causing gpu smmu faults on x1e80100.
>>>
>>> I _think_ what is causing this is the change in ordering of
>>> __arm_lpae_clear_pte() (dma_sync_single_for_device() on the pgtable
>>> memory) and io_pgtable_tlb_flush_walk().
>>
>> As I just commented, how do you believe the order of operations between:
>>
>>          __arm_lpae_clear_pte();
>>          if (!iopte_leaf()) {
>>                  io_pgtable_tlb_flush_walk();
>>
>> and:
>>
>>          if (!iopte_leaf()) {
>>                  __arm_lpae_clear_pte();
>>                  io_pgtable_tlb_flush_walk();
>>
>> fundamentally differs?
> 
> from my reading of the original patch, the ordering is the same for
> non-leaf nodes, but not for leaf nodes

But tlb_flush_walk is never called for leaf entries either way, so no 
such ordering exists... And the non-leaf path still calls 
__arm_lpae_clear_pte() and io_pgtable_tlb_add_page() in the same order 
relative to each other too, it's just now done for the whole range in 
one go, after any non-leaf entries have already been dealt with.

Thanks,
Robin.

> 
>> I'm not saying there couldn't be some subtle bug in the implementation
>> which we've all missed, but I still can't see an issue with the intended
>> logic.
>>
>>>   I'm not entirely sure how
>>> this patch is supposed to work correctly in the face of other
>>> concurrent translations (to buffers unrelated to the one being
>>> unmapped(), because after the io_pgtable_tlb_flush_walk() we can have
>>> stale data read back into the tlb.
>>
>> Read back from where? The ex-table PTE which was already set to zero
>> before tlb_flush_walk was called?
>>
>> And isn't the hilariously overcomplicated TBU driver supposed to be
>> telling you exactly what happened here? Otherwise I'm going to continue
>> to seriously question the purpose of shoehorning that upstream at all...
> 
> I guess I could try the TBU driver.  But I already had my patchset to
> extract the pgtable walk for gpu devcore dump, and that is telling me
> that the CPU view of the pgtable is fine.  Which I think just leaves a
> tlbinv problem.  If that is the case, swapping the order of leaf node
> cpu cache ops and tlbinv ops seems like the cause.  But maybe I'm
> missing something.
> 
> BR,
> -R
> 
>> Thanks,
>> Robin.
>>
>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>> ---
>>>    drivers/iommu/io-pgtable-arm.c | 31 ++++++++++++++-----------------
>>>    1 file changed, 14 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
>>> index 16e51528772d..85261baa3a04 100644
>>> --- a/drivers/iommu/io-pgtable-arm.c
>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>> @@ -274,13 +274,13 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
>>>                                   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
>>>    }
>>>
>>> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
>>> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg)
>>>    {
>>> -     for (int i = 0; i < num_entries; i++)
>>> -             ptep[i] = 0;
>>>
>>> -     if (!cfg->coherent_walk && num_entries)
>>> -             __arm_lpae_sync_pte(ptep, num_entries, cfg);
>>> +     *ptep = 0;
>>> +
>>> +     if (!cfg->coherent_walk)
>>> +             __arm_lpae_sync_pte(ptep, 1, cfg);
>>>    }
>>>
>>>    static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>> @@ -653,28 +653,25 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>>>                max_entries = ARM_LPAE_PTES_PER_TABLE(data) - unmap_idx_start;
>>>                num_entries = min_t(int, pgcount, max_entries);
>>>
>>> -             /* Find and handle non-leaf entries */
>>> -             for (i = 0; i < num_entries; i++) {
>>> -                     pte = READ_ONCE(ptep[i]);
>>> +             while (i < num_entries) {
>>> +                     pte = READ_ONCE(*ptep);
>>>                        if (WARN_ON(!pte))
>>>                                break;
>>>
>>> -                     if (!iopte_leaf(pte, lvl, iop->fmt)) {
>>> -                             __arm_lpae_clear_pte(&ptep[i], &iop->cfg, 1);
>>> +                     __arm_lpae_clear_pte(ptep, &iop->cfg);
>>>
>>> +                     if (!iopte_leaf(pte, lvl, iop->fmt)) {
>>>                                /* Also flush any partial walks */
>>>                                io_pgtable_tlb_flush_walk(iop, iova + i * size, size,
>>>                                                          ARM_LPAE_GRANULE(data));
>>>                                __arm_lpae_free_pgtable(data, lvl + 1, iopte_deref(pte, data));
>>> +                     } else if (!iommu_iotlb_gather_queued(gather)) {
>>> +                             io_pgtable_tlb_add_page(iop, gather, iova + i * size, size);
>>>                        }
>>> -             }
>>>
>>> -             /* Clear the remaining entries */
>>> -             __arm_lpae_clear_pte(ptep, &iop->cfg, i);
>>> -
>>> -             if (gather && !iommu_iotlb_gather_queued(gather))
>>> -                     for (int j = 0; j < i; j++)
>>> -                             io_pgtable_tlb_add_page(iop, gather, iova + j * size, size);
>>> +                     ptep++;
>>> +                     i++;
>>> +             }
>>>
>>>                return i * size;
>>>        } else if (iopte_leaf(pte, lvl, iop->fmt)) {
