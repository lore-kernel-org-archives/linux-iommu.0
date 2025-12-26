Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A77081E;
	Fri, 26 Dec 2025 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766739572; cv=none; b=nnY6qRzENK93G/kr8jQi8UcDQNwPjfyGCG1IZHCbpTcS6UT4ZdVGzUrsFKVjzEtWxO/Js8I/iK2h0ibBXK26hSufSIPgLFJUQQ+aH+IumUPuxhZ576QpLVplJHS69Dt2CE83kRZgihEi/xcExKVzdFKHS1OUpVo+KGOASZ/sKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766739572; c=relaxed/simple;
	bh=t17XSjNclcaVd2nsSo4MOjcBQS2nAgC3yiSvta1qyhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cP8QB0s63nUxOUS62OUcUx2lopgunxZUEVyfpHt017OOO4NvZSBqQUvTPKf+IpyzJnagJyJ+Pk9Vy8RTg0//leaT3gGYqFjL/BcwW6KoHT4Sd5qDs9heMPfITXAPCqAmkZGYhNc1wBmb2sxBmA1Sdklc10kBWnnY81Xk3O/h84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDI+FacG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDI+FacG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64CFC4CEF7;
	Fri, 26 Dec 2025 08:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766739572;
	bh=t17XSjNclcaVd2nsSo4MOjcBQS2nAgC3yiSvta1qyhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KDI+FacGL3+U0zMS7RH1Ii7Xrc8GUcCrT1yaIahts6HkioTm/rSfw04vHX7oOfYcL
	 tCTyelAtUn4eYh7qEGi8ZIFHY3fNyo9dX/LvXMz48XVf/BS/QODSFzBqhCL0OVOXHq
	 IGeLVsz5D4k0Pfeya+CY75bU7kcDRSlq+C36fNGG941HKqsUHkCJOz0kyLKk2MqY0T
	 C1mEaQ+LdBxN7RuwNAGqALk9bU7Q2FDqxYR9LsZrpe/sZF9uE3m2YlC6aWIB3+UrRS
	 AziptPPtoQyE5auy7gxAMBZxcezC/M47TDGn+M6VKozkEQB7co9nurZFO9N3uZwApq
	 CnL0XQJi4cu+w==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
	akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com
Subject: Re: [PATCH v2 4/4] dma: direct: set decrypted flag for remapped dma
 allocations
In-Reply-To: <yq5ams39txvk.fsf@kernel.org>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
 <20251221160920.297689-5-aneesh.kumar@kernel.org>
 <5820e8f3-9cf8-423f-89df-0df7ca78a84b@arm.com>
 <yq5ams39txvk.fsf@kernel.org>
Date: Fri, 26 Dec 2025 14:29:24 +0530
Message-ID: <yq5abjjl4o0j.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
>
>> On 21/12/2025 16:09, Aneesh Kumar K.V (Arm) wrote:
>>> Devices that are DMA non-coherent and need a remap were skipping
>>> dma_set_decrypted(), leaving buffers encrypted even when the device
>>> requires unencrypted access. Move the call after the remap
>>> branch so both paths mark the allocation decrypted (or fail cleanly)
>>> before use.
>>> 
>>> Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>> ---
>>>   kernel/dma/direct.c | 8 +++-----
>>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>> 
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 3448d877c7c6..a62dc25524cc 100644
>>> --- a/kernel/dma/direct.c
>>> +++ b/kernel/dma/direct.c
>>> @@ -271,9 +271,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>>   	if (remap) {
>>>   		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
>>>   
>>> -		if (force_dma_unencrypted(dev))
>>> -			prot = pgprot_decrypted(prot);
>>
>> This would be problematic, isn't it ? We don't support decrypted on a
>> vmap area for arm64. If we move this down, we might actually use the
>> vmapped area. Not sure if other archs are fine with "decrypting" a
>> "vmap" address.
>>
>> If we map the "vmap" address with pgprot_decrypted, we could go ahead
>> and further map the linear map (i.e., page_address(page)) decrypted
>> and get everything working.
>
> We still have the problem w.r.t free
>
> dma_direct_free():
>
> 	if (is_vmalloc_addr(cpu_addr)) {
> 		vunmap(cpu_addr);
> 	} else {
> 		if (dma_set_encrypted(dev, cpu_addr, size))
> 			return;
> 	}
>

How about the below change? 

commit 8261c528961c6959b85de87c5659ce9081dc85b7
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Date:   Fri Dec 19 14:46:20 2025 +0530

    dma: direct: set decrypted flag for remapped DMA allocations
    
    Devices that are DMA non-coherent and require a remap were skipping
    dma_set_decrypted(), leaving DMA buffers encrypted even when the device
    requires unencrypted access. Move the call after the if (remap) branch
    so that both direct and remapped allocation paths correctly mark the
    allocation as decrypted (or fail cleanly) before use.
    
    If CMA allocations return highmem pages, treat this as an allocation
    error so that dma_direct_alloc() falls back to the standard allocation
    path. This is required because some architectures (e.g. arm64) cannot
    mark vmap addresses as decrypted, and highmem pages necessarily require
    a vmap remap. As a result, such allocations cannot be safely marked
    unencrypted for DMA.
    
    Other architectures (e.g. x86) do not have this limitation, but instead
    of making this architecture-specific, I have made the restriction apply
    when the device requires unencrypted DMA access. This was done for
    simplicity,
    
    Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
    Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 7c0b55ca121f..811de37ad81c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -264,6 +264,15 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * remapped to return a kernel virtual address.
 	 */
 	if (PageHighMem(page)) {
+		/*
+		 * Unencrypted/shared DMA requires a linear-mapped buffer
+		 * address to look up the PFN and set architecture-required PFN
+		 * attributes. This is not possible with HighMem, so return
+		 * failure.
+		 */
+		if (force_dma_unencrypted(dev))
+			goto out_free_pages;
+
 		remap = true;
 		set_uncached = false;
 	}
@@ -284,7 +293,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_free_pages;
 	} else {
 		ret = page_address(page);
-		if (dma_set_decrypted(dev, ret, size))
+	}
+
+	if (force_dma_unencrypted(dev)) {
+		void *lm_addr;
+
+		lm_addr = page_address(page);
+		if (set_memory_decrypted((unsigned long)lm_addr, PFN_UP(size)))
 			goto out_leak_pages;
 	}
 
@@ -349,8 +364,16 @@ void dma_direct_free(struct device *dev, size_t size,
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-		if (dma_set_encrypted(dev, cpu_addr, size))
+	}
+
+	if (force_dma_unencrypted(dev)) {
+		void *lm_addr;
+
+		lm_addr = phys_to_virt(dma_to_phys(dev, dma_addr));
+		if (set_memory_encrypted((unsigned long)lm_addr, PFN_UP(size))) {
+			pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
 			return;
+		}
 	}
 
 	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
