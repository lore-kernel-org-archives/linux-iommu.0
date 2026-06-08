Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036193859CE
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948533; cv=none; b=o4iLI+7mGHVbIzPvKKVBnZhvxlX7gd4LjrmrLB86XL3UJkJncCij0Tb0FIr81++9kP61knqwI+Y8Jjv11uAzlasiiE9UJNOU+K7mMbh0dr2RE9THU5O5iPd4iFiaHNyRtMUPxz9Mv7RCYE1QEsnGKZ1x/POJSozd0vgB5sbU6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948533; c=relaxed/simple;
	bh=6+HXf+FDYiwTqChwNe1Waa3meZ8yJYGg35Bx3IDfIRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqe11h4jkLwisWJ96vMGD1DpIbURuVLa3TlMhcuvySiIDA0+vuOKSrbJlUxe9R52zsb+KjbEGOOOtv8/uvmt+JJl4+0r23vwCcndE7XXnKHno6Lv+ewvgQDc8h4s6yt4Q12JK85vbfcYFwpRKbDl5cGTCQ5r1OuXS0t97BLNy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccygvPTi; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccygvPTi"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-133362c30cfso33853c88.0
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780948530; x=1781553330; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ns7tVcW9XWyLcZvttsJ0K9GITGIgrVGAf3TGrFOv8Tc=;
        b=ccygvPTiS3d+nth93FO9C+V1suFFMGgvA2QenwXTqZe5S7oBtJe4Sf5peAlrGbnsYL
         12ZUBBGbxFvKFhe0fKM2M7qzRehkNFF5cdOqJ9diF753nIkhB3LjqYDyAPxsjhLe7jaH
         V6UybSSHOoR1lR/p4Wm6K+jYG6b+PBxcBe/RwG3uPEftD8V4gAlNkVb3Dw/cYKudkLmd
         oZAwGkAg+HW0/VVCum1tZFPXch+tLcc7lTRPL+XkJ2jzzza9ecSfiz8aRxDtgs9CnVaq
         fJ4XqRKvYXuPH+3wpdrbfzEuNh+K/6br0XZicjmQPXwKHPksw2RR1PzAFKy4PZFj7zk4
         hObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948530; x=1781553330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ns7tVcW9XWyLcZvttsJ0K9GITGIgrVGAf3TGrFOv8Tc=;
        b=izgiEwpjxMDUO+8TMdMmV5iCvK9XOWyCcCqohBTacZy0iI4qM9WOPSp85KxthjU8qy
         Fx9KyzouRr5RbG8+q7ym9KL1c+cJpsPRvnHnNuVdP2PneU/iaZKhGOi3h5QmsXtwg73R
         ROx1mhgzMykR/hTwtSOwNy8cZ60U6uNW2oPywNYoupHLEt8FodGEe1OvhNOfGFD224oX
         k8RyIHhzOydEz3vKx71iqdXGZTqDmn6BhXOi3zziOUPsb5HfrLpqT/8/uvnclYi0dDYA
         nSIShoYiOhssEayJNlVZDU+h39IF7sNRzyyxsg2EJEWKAyYbkhOQNasqa58IiQaX3J0T
         A+7g==
X-Forwarded-Encrypted: i=1; AFNElJ9/AaX+T58/544qfgTFx81lEvG7fioq7gKE/XISSQ7re58tV6V43PQzhBiWvupyYSXAJSe0XQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFK1pvaF0EDWj74mq7rWcdKRUnPQSIkm0SsVblUuEw6AeGYX2B
	J/di+Pg3ABTQHD2RO1AnN6zujJS/zEK3FNdIKR0tYJx/j+yGuJtr8YeKNaz3NC/ugQ==
X-Gm-Gg: Acq92OEzzpu6iEUiLYFGq4+LI+qUk1X5qSBFo1IUTcqnJ1Pgfovcojjr/shAb4kJnWu
	I8R8d4tODU8o4Ur24VXQfQ/wm2GLCpNepG5LvrVfm2zFthL4W89uHqR7ASRuChYZccbMDC6kzfw
	OQi0q7D8xkrU7lsA3qfWVDo7O/0HWIKopt7EcwHDJeQUypm8/O0CbBDXXOTLr+shBzOvEBEwKp4
	2KQPjqT95yazV/t6rb906dSoCJ+DGScsVfKLXLZC38GTXnPcTExr8L3lYsbfwhLaQnIdkTyJj8B
	ORHTIwbzxjG0etX+Yl58XDTEp9Dw5y7ZNabw1tBHCvoupQEKaUOwRScDRSZMY+6p/7ei1jPouEB
	7YHLfVIUzj0N49ovoZaCTLFzLCcLYnaaaGFaQWTdgc09uNn2plXM69g96Ib4RGX1KC3Uv91e9mT
	dZX78DTM+4lNGx/qwt0yHK9/FVFzD33XtlIe8bsGIohEw4MwYF+5wxJdx/IZfCa3F8rE4GyU0=
X-Received: by 2002:a05:7022:170e:b0:138:888:e99d with SMTP id a92af1059eb24-1380888eb22mr103345c88.32.1780948529234;
        Mon, 08 Jun 2026 12:55:29 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30791f6381fsm9666160eec.0.2026.06.08.12.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:55:28 -0700 (PDT)
Date: Mon, 8 Jun 2026 19:55:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 3/4] dma-direct: Add API to preserve/restore
 allocations
Message-ID: <aiceKYmc323G7tBs@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505002737.2213734-4-skhawaja@google.com>

On Tue, May 05, 2026 at 12:27:36AM +0000, Samiullah Khawaja wrote:
> Add an API to preserve/restore the DMA direct allocation for liveupdate.
> The underlying memory is preserved/restored using KHO. During restore
> the memory is setup based on the device configuration, gfp flags and
> allocation attributes. Once restored, the driver can use the usual
> dma_free* API to deallocate the restored DMA allocation.
> 
> This API will be used to add support in dma_alloc* APIs to
> preseve/restore the DMA allocations.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  include/linux/dma-direct.h |  29 +++++++
>  kernel/dma/Kconfig         |   3 +
>  kernel/dma/direct.c        | 163 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
> 

[...]

> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index bfef21b4a9ae..d92852942c6c 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -265,3 +265,6 @@ config DMA_MAP_BENCHMARK
>  	  performance of dma_(un)map_page.
>  
>  	  See tools/testing/selftests/dma/dma_map_benchmark.c
> +
> +config DMA_LIVEUPDATE
> +	bool "Enable preservation of DMA direct allocations"

Nit: depends on LIVEUPDATE?

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ec887f443741..c2b98f91900a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -6,6 +6,8 @@
>   */
>  #include <linux/memblock.h> /* for max_pfn */
>  #include <linux/export.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kho/abi/dma_alloc.h>
>  #include <linux/mm.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/scatterlist.h>
> @@ -307,6 +309,167 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_DMA_LIVEUPDATE
> +int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
> +				   size_t size, dma_addr_t dma_handle,
> +				   unsigned long attrs, u64 *state)
> +{
> +	struct dma_alloc_ser *ser;
> +	int ret;
> +
> +	if (!kho_is_enabled())
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_DMA_CMA))
> +		return -EOPNOTSUPP;
> +
> +	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> +	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
> +	    !dev_is_dma_coherent(dev) &&
> +	    !is_swiotlb_for_alloc(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> +	    !dev_is_dma_coherent(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> +	    dma_is_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
> +		return -EOPNOTSUPP;
> +
> +	ser = kho_alloc_preserve(sizeof(*ser));
> +	if (IS_ERR(ser))
> +		return PTR_ERR(ser);
> +
> +	ser->page_phys = dma_to_phys(dev, dma_handle);
> +	ser->force_decrypted = force_dma_unencrypted(dev);
> +	ser->size = size;
> +
> +	ret = kho_preserve_pages(phys_to_page(ser->page_phys),
> +				 size >> PAGE_SHIFT);

Should this be `PAGE_ALIGN(size) >> PAGE_SHIFT` OR 
`DIV_ROUND_UP(size, PAGE_SIZE)`?

Otherwise, if size is small, say, size == 64-bytes, we preserve 0 pages?

Also, IIRC, even with PAGE_ALIGN, preserving just the requested pgcount
is not enough because buddy allocator allocates in order-N.

For e.g. if a driver requests 20KB (5 pages), the buddy allocator 
fulfills it with an order-3 block (8 pages).

Now, if we only tell KHO to preserve 5 pages, the remaining 3 pages are 
free in the new kernel. When the driver eventually tears down and calls
dma_free_coherent(), dma_direct_free() will call 
__free_pages(page, get_order(size)), which will attempt to free all 8 
pages, causing a double-free panic on the 3 unpreserved pages?

Should we be preserving exactly 1 << get_order(size) pages as per buddy?
Same applies to unpreserve, and restore.

> +	if (ret) {
> +		kho_unpreserve_free(ser);
> +		return ret;
> +	}
> +
> +	*state = virt_to_phys(ser);
> +	return 0;
> +}
> +
> +void dma_direct_unpreserve_allocation(struct device *dev, u64 state)
> +{
> +	struct dma_alloc_ser *ser;
> +
> +	if (!kho_is_enabled())
> +		return;
> +
> +	ser = phys_to_virt(state);
> +	kho_unpreserve_pages(phys_to_page(ser->page_phys),
> +			     ser->size >> PAGE_SHIFT);
> +	kho_unpreserve_free(ser);
> +}
> +
> +void *dma_direct_restore_allocation(struct device *dev, size_t size,
> +				    dma_addr_t *dma_handle, gfp_t gfp,
> +				    unsigned long attrs, u64 state)

Are we relying on the caller to pass same attrs? So, a buffer with 
non-coherent attrs can be mapped with coherent attrs in the new kernel.
Could this cause side-effects? Should we check for such driver bugs with
a WARN here while comparing older attrs with the newer ones too?

Coherency breaking due to subtle driver bugs is very painful to debug :/

> +{
> +	bool remap = false, set_uncached = false;
> +	struct dma_alloc_ser *ser = NULL;
> +	struct page *page;
> +	void *cpu_addr;
> +
> +	if (!kho_is_enabled())
> +		return NULL;
> +
> +	ser = phys_to_virt(state);
> +	page = phys_to_page(ser->page_phys);

[...]

> +
> +	/*
> +	 * Remapping will be blocking so return error. The preserved memory
> +	 * might be already decrypted in the previous kernel, but the decryption
> +	 * call is not guaranteed to be non-blocking so return error always if
> +	 * decryption is required.
> +	 */
> +	if ((remap || force_dma_unencrypted(dev)) &&
> +	    dma_direct_use_pool(dev, gfp))
> +		return NULL; 
> +
> +	/*
> +	 * Encryption scheme changed between two kernels and this might cause
> +	 * issues if device/driver is not handling it properly.
> +	 */
> +	WARN_ON_ONCE(ser->force_decrypted != force_dma_unencrypted(dev));
> +
> +	/*
> +	 * arch_dma_prep_coherent() should make sure that any cache lines from
> +	 * the previous kernel, if the device was coherent previously or cached
> +	 * mapping in this kernel during init are not problamatic for
> +	 * non-coherent allocations.
> +	 */
> +	if (remap) {
> +		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
> +
> +		if (force_dma_unencrypted(dev))
> +			prot = pgprot_decrypted(prot);
> +
> +		arch_dma_prep_coherent(page, size);
> +
> +		cpu_addr = dma_common_contiguous_remap(page, size, prot,
> +						       __builtin_return_address(0));
> +		if (!cpu_addr)
> +			return NULL;

Should we be kho_restore_free-ing on all these error paths?
We only seem to be kho_restore_free-ing on the success path.
Same for kho_restore_pages.. if we return an error here, we don't
restore the preserved pages? Are we leaking those too?

> +	} else {
> +		cpu_addr = page_address(page);
> +		if (dma_set_decrypted(dev, cpu_addr, size))
> +			return NULL;
> +	}
> +
> +	if (set_uncached) {
> +		arch_dma_prep_coherent(page, size);
> +		cpu_addr = arch_dma_set_uncached(cpu_addr, size);
> +		if (IS_ERR(cpu_addr))
> +			return NULL;
> +	}
> +
> +	*dma_handle = phys_to_dma_direct(dev, ser->page_phys);
> +
> +	/*
> +	 * Cannot free the restored pages on error here as these might be in use
> +	 * by a device with direct allocation in the previous kernel.
> +	 */
> +	WARN_ON(!kho_restore_pages(ser->page_phys,
> +				   ser->size >> PAGE_SHIFT));
> +	kho_restore_free(ser);
> +	return cpu_addr;
> +}
> +#endif
> +
>  void dma_direct_free(struct device *dev, size_t size,
>  		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>  {

Thanks,
Praan
