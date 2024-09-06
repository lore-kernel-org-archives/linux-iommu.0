Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0D41CB313
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625487; cv=none; b=aDO0afcGHAnHAIXIxOlDa2whjw9cLrLg/MMCLOlQjKjwHq2UpuSmYMLMCKo/zme8Irxubpw0wk706x6OsYtooEvImFJCWqCQ1oQu/Kb1wikIJIwxxfnovWMi9fhcTb8wyPXlPjOdryDADdhcUSoVzIvaAjNfLQfqhR9j7tcW8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625487; c=relaxed/simple;
	bh=afDotwk1goIpE4/B9AcsfhwAPXbo1B75M+DlwUkKNE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uytDT5lHcegA+OxjR2ILU7pJrHm+fhSVlhPF3pg9fbkX9PV7/OCEjZn2neks+hVq8yK5n+hrRQMBJHh4w2yWORru2n2+CSR9hA1/kHc8/GAOHq2QBtcNE7X0Og2O1JGG1qEk3ckbW97Ol+/v1Y5oNE2AXrA4YKrxZ2Qk9InbmNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D70113E;
	Fri,  6 Sep 2024 05:25:11 -0700 (PDT)
Received: from [10.1.36.41] (010265703453.arm.com [10.1.36.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFE513F73B;
	Fri,  6 Sep 2024 05:24:42 -0700 (PDT)
Message-ID: <a30d3968-5fb8-423d-9524-0e694930a6b1@arm.com>
Date: Fri, 6 Sep 2024 13:24:37 +0100
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
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Ashish Mhetre <amhetre@nvidia.com>, Rob Clark <robdclark@chromium.org>,
 Joerg Roedel <joro@8bytes.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240905124956.84932-1-robdclark@gmail.com>
 <20240905155330.GA15246@willie-the-truck>
 <53f13813-a515-475a-836d-0b6017a117eb@arm.com>
 <CAF6AEGs3aRXbnnhD84GBbz9wJmyNR=dA3hbGuMLcM22Vs8CU_g@mail.gmail.com>
 <CAF6AEGsqdxO4+kaz6jOLBS_syjEkZg-7Veqh3j-o=RiGNcBH8A@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAF6AEGsqdxO4+kaz6jOLBS_syjEkZg-7Veqh3j-o=RiGNcBH8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-05 6:10 pm, Rob Clark wrote:
> On Thu, Sep 5, 2024 at 10:00 AM Rob Clark <robdclark@gmail.com> wrote:
>>
>> On Thu, Sep 5, 2024 at 9:27 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 05/09/2024 4:53 pm, Will Deacon wrote:
>>>> Hi Rob,
>>>>
>>>> On Thu, Sep 05, 2024 at 05:49:56AM -0700, Rob Clark wrote:
>>>>> From: Rob Clark <robdclark@chromium.org>
>>>>>
>>>>> This reverts commit 85b715a334583488ad7fbd3001fe6fd617b7d4c0.
>>>>>
>>>>> It was causing gpu smmu faults on x1e80100.
>>>>>
>>>>> I _think_ what is causing this is the change in ordering of
>>>>> __arm_lpae_clear_pte() (dma_sync_single_for_device() on the pgtable
>>>>> memory) and io_pgtable_tlb_flush_walk().  I'm not entirely sure how
>>>>> this patch is supposed to work correctly in the face of other
>>>>> concurrent translations (to buffers unrelated to the one being
>>>>> unmapped(), because after the io_pgtable_tlb_flush_walk() we can have
>>>>> stale data read back into the tlb.
>>>>>
>>>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>>>>> ---
>>>>>    drivers/iommu/io-pgtable-arm.c | 31 ++++++++++++++-----------------
>>>>>    1 file changed, 14 insertions(+), 17 deletions(-)
>>>>
>>>> Please can you try the diff below, instead?
>>>
>>> Given that the GPU driver's .tlb_add_page is a no-op, I can't see this
>>> making a difference. In fact, given that msm_iommu_pagetable_unmap()
>>> still does a brute-force iommu_flush_iotlb_all() after io-pgtable
>>> returns, and in fact only recently made .tlb_flush_walk start doing
>>> anything either for the sake of the map path, I'm now really wondering
>>> how this patch has had any effect at all... :/
>>
>> Yeah..  and unfortunately the TBU code only supports two devices so
>> far, so I can't easily repro with TBU enabled atm.  Hmm..
>> __arm_lpae_unmap() is also called in the ->map() path, although not
>> sure how that changes things.
> 
> Ok, an update.. after a reboot, still with this patch reverted, I once
> again see faults.  So I guess that vindicates the original patch, and
> leaves me still searching..
> 
> fwiw, fault info from the gpu devcore:
> 
> -------------
> fault-info:
>    - ttbr0=0000000919306000
>    - iova=0000000100c17000
>    - dir=WRITE
>    - type=UNKNOWN
>    - source=CP
> pgtable-fault-info:
>    - ttbr0: 000000090ca40000
>    - asid: 0
>    - ptes: 000000095db47003 000000095db48003 0000000914c8f003 00000008fd7f0f47
> -------------
> 
> the 'ptes' part shows the table walk, which looks ok to me..

But is it the right pagetable at all, given that the "ttbr0" values 
appear to be indicating different places?

Robin.
