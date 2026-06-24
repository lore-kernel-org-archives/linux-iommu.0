Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2732E75A
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327624; cv=none; b=Kk5bA06mm32mGauYY2shJZ/L8tUXjwFvbxBhffDzDgMn5s2+2cdZc0t2WM5Ajng4MilIzxCxGvr/2y14+b1o0K3Jbfdgb3Hfgr4SMPQZvxo1eubWHMysztSzyhllmuUQhtUb6qffUv8pHKsLzhbK+haqbrNHP6kZ/b0gDtXSfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327624; c=relaxed/simple;
	bh=xAyVGp79r3oiYm1l4SEBcrZIyZKjBb0Mf34OfpyI9HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fl4tU77U6mr2oyZozhtRqovATgNEc92cUwDIoq998Cu83x19jGvXnjgz79mHdTd0AMky9xaLY5ywWb8D9GmY2WWRr0BJa7iBODYl05Bu6LKPjQrcEqqZDfhvq9kivcEsd/Ro6MUAg7fG/Ms3A6S5Qp4dpVq/cISRZFyXVcjwS/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pI56kDIG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pI56kDIG"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c6a4eccab1so7785ad.1
        for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782327621; x=1782932421; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uyPzc/lVYNWutlEG7aHFYV3dkzH3OXj7mqtnKUaIHcc=;
        b=pI56kDIGZtbfTmdeoyWwgoYSD3IYweFT4O2g8otjJFZRaAKNpS18fRd+d75Q8reXk+
         hyPlIc8urrzRL9BzqX+16YStUS49T1IvztFLlR72yAvUrpifg5m2q4BquERyCFEPOwg5
         /SIEFZ21Qv7zUHWNhGxJpEUvXrqh5B7wKexrNYYxtW/2eWr3t/tfFLGDxBPmZLduHAfr
         5tG87QAlVNfQPyz2l7nxu/AQ94pHjiiIwomFUT3PFcyhuYo0BUbl9emXXMwERVXfmmiJ
         6EzemGkNTor7mOQYskcPL16GjkAQhbOA/MGC96XURCdfkOB7hJBd18Sbz/lQkqSX769S
         sQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782327621; x=1782932421;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uyPzc/lVYNWutlEG7aHFYV3dkzH3OXj7mqtnKUaIHcc=;
        b=jlZIQu5Zl4i+Md9HEjSbZR36rt+A/ecc4BTF3p/JgtaXWpkXXBN4SoSgzUc6iuQxnI
         x7Sd+xtJR4DzmQtu8lUymoI38jcoUAFjtPJhdk6cynNoWvCghNSSEAvJuLMchK18CVNW
         F5HMFJTcPRiw40tV9zJm1UdNfOu/2/UpSwNB2C0Wtg2DuNL0O1nhWdNG9MQeMiG8m134
         mCb5aDKX7NNeaw5hL31v554N/obArsEDBTxB9EvMciI2NJZRH2jZ1nYVOW50e7hFou/D
         LP0wDmIkW/NLpLE2OZ7jcqTM5K1whcBTO/cLATU39la8RzQczFGzFem2y67lPdC62pO8
         tzLA==
X-Forwarded-Encrypted: i=1; AHgh+RrxHslAnDh6DMRjZECIBcwDTRFHh1oHBUu5ncfNVyKmDNTfbDjTfTP/V4WayD3tN5KtzM4XlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdqOUFdFckr0TU93NWBp/WrKiXWPmr6DFEZqJ+fq9bT3CYL9/U
	5B5XslPY0LVdHcFtASSwouZzMBZF9T0arXjcrivegUlKYOEdMC12ivwZhCG+J4zQCA==
X-Gm-Gg: AfdE7ckPjKUIvBf7ki14kaFu8Bw/s5UmcM/Nw/sVyvVjRDs7KVhlwnhcuOgi70aaSN6
	QWit2bCNEmsajWPCU1YjOLDRiZkm3U6U3vGSizpWCL0xzwvq78jh0guKd+/D0VrCvVQ6ssinyLw
	Vs7dvnOUQhKdFA1ik791qQ5LqesuYr//AyVZv3V18dJGgMF8ubayyj8eqgP6014urzluTUfvotY
	luLoBAW4+N1dOi8U4nhg9+27GaEyTf4MjAjuN4dA80GLmaKtfYgZyXoL0QCfXLcXL5/Ivg4yzIm
	aqAS5dz6IidyWalbrsV6oGaXdjE8+FgleuA0Zo/A3HcoS17hz1DQah/AoZiZPi/HesGxYBylZhw
	rS+M3AudYmkn90aTCbBujNl7pEImTX27dkR4aK0X25RQM4iqTvQ09ziYy1QjWKrGdnl3Cq3jLLt
	F6Qqzg2qhUojxzI5QBeFahQiTx3Vjud3G6ovJFvwUPnl2Wn9ml7G2avLT3XQXcF5szHEexnerjh
	odxYXz4
X-Received: by 2002:a17:902:c952:b0:2ba:6518:e4d8 with SMTP id d9443c01a7336-2c7f77b6733mr402135ad.20.1782327619882;
        Wed, 24 Jun 2026 12:00:19 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d23ccsm3593388b3a.36.2026.06.24.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:00:19 -0700 (PDT)
Date: Wed, 24 Jun 2026 19:00:15 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 3/4] dma-direct: Add API to preserve/restore
 allocations
Message-ID: <ajwmXYOW080zVRLw@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-4-skhawaja@google.com>
 <aiceKYmc323G7tBs@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiceKYmc323G7tBs@google.com>

On Mon, Jun 08, 2026 at 07:55:21PM +0000, Pranjal Shrivastava wrote:
>On Tue, May 05, 2026 at 12:27:36AM +0000, Samiullah Khawaja wrote:
>> Add an API to preserve/restore the DMA direct allocation for liveupdate.
>> The underlying memory is preserved/restored using KHO. During restore
>> the memory is setup based on the device configuration, gfp flags and
>> allocation attributes. Once restored, the driver can use the usual
>> dma_free* API to deallocate the restored DMA allocation.
>>
>> This API will be used to add support in dma_alloc* APIs to
>> preseve/restore the DMA allocations.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  include/linux/dma-direct.h |  29 +++++++
>>  kernel/dma/Kconfig         |   3 +
>>  kernel/dma/direct.c        | 163 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 195 insertions(+)
>>
>
>[...]
>
>> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
>> index bfef21b4a9ae..d92852942c6c 100644
>> --- a/kernel/dma/Kconfig
>> +++ b/kernel/dma/Kconfig
>> @@ -265,3 +265,6 @@ config DMA_MAP_BENCHMARK
>>  	  performance of dma_(un)map_page.
>>
>>  	  See tools/testing/selftests/dma/dma_map_benchmark.c
>> +
>> +config DMA_LIVEUPDATE
>> +	bool "Enable preservation of DMA direct allocations"
>
>Nit: depends on LIVEUPDATE?

Agreed I will add this.
>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index ec887f443741..c2b98f91900a 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -6,6 +6,8 @@
>>   */
>>  #include <linux/memblock.h> /* for max_pfn */
>>  #include <linux/export.h>
>> +#include <linux/kexec_handover.h>
>> +#include <linux/kho/abi/dma_alloc.h>
>>  #include <linux/mm.h>
>>  #include <linux/dma-map-ops.h>
>>  #include <linux/scatterlist.h>
>> @@ -307,6 +309,167 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>>  	return NULL;
>>  }
>>
>> +#ifdef CONFIG_DMA_LIVEUPDATE
>> +int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
>> +				   size_t size, dma_addr_t dma_handle,
>> +				   unsigned long attrs, u64 *state)
>> +{
>> +	struct dma_alloc_ser *ser;
>> +	int ret;
>> +
>> +	if (!kho_is_enabled())
>> +		return -EOPNOTSUPP;
>> +
>> +	if (IS_ENABLED(CONFIG_DMA_CMA))
>> +		return -EOPNOTSUPP;
>> +
>> +	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
>> +	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
>> +	    !dev_is_dma_coherent(dev) &&
>> +	    !is_swiotlb_for_alloc(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
>> +	    !dev_is_dma_coherent(dev))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
>> +	    dma_is_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>> +		return -EOPNOTSUPP;
>> +
>> +	ser = kho_alloc_preserve(sizeof(*ser));
>> +	if (IS_ERR(ser))
>> +		return PTR_ERR(ser);
>> +
>> +	ser->page_phys = dma_to_phys(dev, dma_handle);
>> +	ser->force_decrypted = force_dma_unencrypted(dev);
>> +	ser->size = size;
>> +
>> +	ret = kho_preserve_pages(phys_to_page(ser->page_phys),
>> +				 size >> PAGE_SHIFT);
>
>Should this be `PAGE_ALIGN(size) >> PAGE_SHIFT` OR
>`DIV_ROUND_UP(size, PAGE_SIZE)`?
>
>Otherwise, if size is small, say, size == 64-bytes, we preserve 0 pages?
>
>Also, IIRC, even with PAGE_ALIGN, preserving just the requested pgcount
>is not enough because buddy allocator allocates in order-N.
>
>For e.g. if a driver requests 20KB (5 pages), the buddy allocator
>fulfills it with an order-3 block (8 pages).
>
>Now, if we only tell KHO to preserve 5 pages, the remaining 3 pages are
>free in the new kernel. When the driver eventually tears down and calls
>dma_free_coherent(), dma_direct_free() will call
>__free_pages(page, get_order(size)), which will attempt to free all 8
>pages, causing a double-free panic on the 3 unpreserved pages?
>
>Should we be preserving exactly 1 << get_order(size) pages as per buddy?
>Same applies to unpreserve, and restore.

Agreed. I will update this and also make sure it is covered in the kunit
tests.
>
>> +	if (ret) {
>> +		kho_unpreserve_free(ser);
>> +		return ret;
>> +	}
>> +
>> +	*state = virt_to_phys(ser);
>> +	return 0;
>> +}
>> +
>> +void dma_direct_unpreserve_allocation(struct device *dev, u64 state)
>> +{
>> +	struct dma_alloc_ser *ser;
>> +
>> +	if (!kho_is_enabled())
>> +		return;
>> +
>> +	ser = phys_to_virt(state);
>> +	kho_unpreserve_pages(phys_to_page(ser->page_phys),
>> +			     ser->size >> PAGE_SHIFT);
>> +	kho_unpreserve_free(ser);
>> +}
>> +
>> +void *dma_direct_restore_allocation(struct device *dev, size_t size,
>> +				    dma_addr_t *dma_handle, gfp_t gfp,
>> +				    unsigned long attrs, u64 state)
>
>Are we relying on the caller to pass same attrs? So, a buffer with
>non-coherent attrs can be mapped with coherent attrs in the new kernel.
>Could this cause side-effects? Should we check for such driver bugs with
>a WARN here while comparing older attrs with the newer ones too?
>
>Coherency breaking due to subtle driver bugs is very painful to debug :/

Hmm... this is interesting. The dma_alloc API relies on the caller to
have consistent attrs accross allocation and free. But when updating
kernel where driver could have been updated, we have to be careful.

Agreed.. I will handle this properly by making sure that the new attr is
compatible with the preserved attr.
>
>> +{
>> +	bool remap = false, set_uncached = false;
>> +	struct dma_alloc_ser *ser = NULL;
>> +	struct page *page;
>> +	void *cpu_addr;
>> +
>> +	if (!kho_is_enabled())
>> +		return NULL;
>> +
>> +	ser = phys_to_virt(state);
>> +	page = phys_to_page(ser->page_phys);
>
>[...]
>
>> +
>> +	/*
>> +	 * Remapping will be blocking so return error. The preserved memory
>> +	 * might be already decrypted in the previous kernel, but the decryption
>> +	 * call is not guaranteed to be non-blocking so return error always if
>> +	 * decryption is required.
>> +	 */
>> +	if ((remap || force_dma_unencrypted(dev)) &&
>> +	    dma_direct_use_pool(dev, gfp))
>> +		return NULL;
>> +
>> +	/*
>> +	 * Encryption scheme changed between two kernels and this might cause
>> +	 * issues if device/driver is not handling it properly.
>> +	 */
>> +	WARN_ON_ONCE(ser->force_decrypted != force_dma_unencrypted(dev));
>> +
>> +	/*
>> +	 * arch_dma_prep_coherent() should make sure that any cache lines from
>> +	 * the previous kernel, if the device was coherent previously or cached
>> +	 * mapping in this kernel during init are not problamatic for
>> +	 * non-coherent allocations.
>> +	 */
>> +	if (remap) {
>> +		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
>> +
>> +		if (force_dma_unencrypted(dev))
>> +			prot = pgprot_decrypted(prot);
>> +
>> +		arch_dma_prep_coherent(page, size);
>> +
>> +		cpu_addr = dma_common_contiguous_remap(page, size, prot,
>> +						       __builtin_return_address(0));
>> +		if (!cpu_addr)
>> +			return NULL;
>
>Should we be kho_restore_free-ing on all these error paths?
>We only seem to be kho_restore_free-ing on the success path.
>Same for kho_restore_pages.. if we return an error here, we don't
>restore the preserved pages? Are we leaking those too?

This is purposefully leaking the memory here. This is because during
liveupdate, this device could be using this memory and freeing it means
that this might cause a memory corruption that would pretty difficult to
debug.
>
>> +	} else {
>> +		cpu_addr = page_address(page);
>> +		if (dma_set_decrypted(dev, cpu_addr, size))
>> +			return NULL;
>> +	}
>> +
>> +	if (set_uncached) {
>> +		arch_dma_prep_coherent(page, size);
>> +		cpu_addr = arch_dma_set_uncached(cpu_addr, size);
>> +		if (IS_ERR(cpu_addr))
>> +			return NULL;
>> +	}
>> +
>> +	*dma_handle = phys_to_dma_direct(dev, ser->page_phys);
>> +
>> +	/*
>> +	 * Cannot free the restored pages on error here as these might be in use
>> +	 * by a device with direct allocation in the previous kernel.
>> +	 */


Check this comment that explains the logic behind not freeing. I think I
will move it up.
>> +	WARN_ON(!kho_restore_pages(ser->page_phys,
>> +				   ser->size >> PAGE_SHIFT));
>> +	kho_restore_free(ser);
>> +	return cpu_addr;
>> +}
>> +#endif
>> +
>>  void dma_direct_free(struct device *dev, size_t size,
>>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>>  {
>
>Thanks,
>Praan

Thanks,
Sami
