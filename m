Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BE0437858
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846725; cv=none; b=GJBl+bvBKthfsv+o/5DxRf/Z5As+E/T5XJbyJ78dqvhDc0vxBjDW1XJCa764rMXY11Lw56jZBOIsbZLt6Y4FqOyDfrP72wAJQ7YYMuj6ixXtXXv0zJ2MJbC9MuqkcNrkS+1r3uPcwkeqylTbVtQy7OdbniBOPjmeMnw0pOSYOIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846725; c=relaxed/simple;
	bh=gETAEBgYwDXWClB5e9959ZIcXDa0GZBBwA4nXRnjY6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/9Rt7rewCDFxgLk+zt8aKo7/SIpVEOMY0w93nE4HV+lMzd1q1o2LDIzpYPcqU7MN+jPE7M/L+8RvnXmQQ33WhJRH7MCVg3DEv+Y40E05qjZXGulrEwHsQo/nCcegWdCe9IySsIN6jjq81YwBwPfpihyjCkZvLGUcEaM4CcJRls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oHoVmnkF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHoVmnkF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-499add6348fso51195e9.1
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787846722; x=1788451522; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CmON3stCzHBRSuZfkMe1xGImPljQrocTgH9KyyEufC0=;
        b=oHoVmnkF4Em/x27s5puwH/MbK5i4q9tlT0IWsHAAcbG+IQIUisvBamFxOSRh5BqMlO
         6fKlcfLxXIaNraPSfrF20QWhHb//zU4j8UieOHPzeAQLXFgoKiNaOLMyek5mDqGjH/60
         fFAITP9If+ek4zr+mZRJx8e8tVdelEwAb6ODVH+9TE74ASNwMtURFRpmHAutwk9U/yyS
         NYr3bPTZZnPDDLncu9MCg3ffyvIoX+cqtfPKSnsul5pE19vHOOg3Sne5DL6es50jxEIf
         jQ/Q2u1bM69lCIEqu4NVMJhUa0z/nEssoBWEWsldw6NiKnYTXf0uui7uk4LP10Ebb+1u
         kkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846722; x=1788451522;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CmON3stCzHBRSuZfkMe1xGImPljQrocTgH9KyyEufC0=;
        b=I9qiHc0dK/lBw6pW/KkQes5ggghWXYXEPmZTyR9ohDRv6rpTaKuGBAvYB0yM6VLTlw
         tqjPiUOuqMWuASfmagJK1vFTdbUv7dvPaFsZFc0EuO9Mf6j/4aFqMUFgQ3SEoEZLousp
         CQzqzQybVhrT+v3+fW2WuB0sQwPrhXik+dWP/sMybms+5JeuJ7rJc1fWQg4bo3CRdRwo
         FLD3Y1IBmVRZZbDwgaolzzKbEpG69xbsgL9uNigO+CkmAw8iBZvstN3s81jn8eWA9RZ8
         dbjmC67ZnqpgHQaHwhT42n1Y9jIgbkQODgR+MjIQK4UpeHPDD6pEIBpWHE4Q1tD4Doos
         31lg==
X-Forwarded-Encrypted: i=1; AHgh+RqPegpLVi8OkUrZBJNorQ4JKuSQJkd5tojCFQT2qPHgyxZYoPv+MtitxgYd3Radvyr3N9CIiQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lYcX7QdPlnpT+0lLsGGW4HMNk2wAhMLIb+nu1mAySlMIJUFfBT
	kCWrulC8ro8L2jJo3AndyKsOr0p5LHogWq5zMuSRwW0R1GMSE0OYUGFLUAcFMEkTxA==
X-Gm-Gg: AR+sD10XtMPG5DxnYG8zHbmqKv8FAYdlEg5GMW9+pEONIreTPerZme54D6Lwdqt2x+n
	5pO1S2AeqBddSc8/F3Q0lB92FqiCgZIJ1olCoJeFqCV+sMQBTejthvwuZ4iweZxONL1uneKnTXY
	H5aBw8P/PYSEx7jCgzFbNhlhFWRO4/DA3/j9GFFSlyxnVLxG3MHsxig9qhaeAUB34MlU8DdKqhu
	LXQpxf43ewyjnbTZOgK1A0DepMha3e63rC9x0Pg2Ww/xiCiVN/ndjJRPSqSf5JdRsJBpgcwa9ZG
	FPknRHd2LP9TD8gqoA4Z1XcqIkxqMtmnSNc5gwOTtHAKKVcvYCHVuUgj0q7UXIp/5+nxbzLUWsP
	f8SU+HMIHWxXq2p61cjObDq8PRJA2ezFr302D0aawqoiZQn+LCdlc0s5WOoDcNZIvgGSww5/f+c
	HuGCt9PBdaortQy5Jwnj54fJGbkqY/eCVHMdo3LuVNV2L3Ed/RoIFQ64x9V6+sCpkKohNRrkmkF
	Hc17cin0sRT3fGLcU1HuBKfKhNNtrKzJbEdSiME
X-Received: by 2002:a05:600c:468b:b0:499:7da3:dd0c with SMTP id 5b1f17b1804b1-49b0e3a0067mr1313355e9.0.1787846721412;
        Thu, 27 Aug 2026 09:05:21 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b4dfdf00csm57599795e9.14.2026.08.27.09.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:05:18 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:05:14 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: joro@8bytes.org, will@kernel.org, jgg@ziepe.ca, robin.murphy@arm.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com, praan@google.com,
	skhawaja@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu: Drop IOMMU_DEBUG_PAGEALLOC refs on iommupt
 domain teardown
Message-ID: <apBgOqEP4Fv6cOaV@google.com>
References: <20260827145855.1616223-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827145855.1616223-1-xiangzao@linux.alibaba.com>

Hi Yuanhe,

On Thu, Aug 27, 2026 at 10:58:53PM +0800, Yuanhe Shu wrote:
> Since commit b948a8722848 ("iommu: Fix up map/unmap debugging for
> iommupt domains") iommu_map() takes an IOMMU_DEBUG_PAGEALLOC reference
> for every page it maps into a domain, and the only path that drops
> those references is the IOVA based unmap.  When a generic_pt domain is
> freed while mappings are still installed, pt_iommu_deinit() releases
> the page table memory without going through that path, so every mapped
> page keeps its reference forever and each later allocation or free of
> it trips:
> 
>     WARNING: drivers/iommu/iommu-debug-pagealloc.c:91 at __iommu_debug_check_unmapped+0x4e/0x70, CPU#0: init/1
>     iommu: Detected page leak!
> 
> Freeing a domain with mappings still installed is not driver misuse:
> the deinit contract in include/linux/generic_pt/iommu.h only requires

Which drivers cause this?

AFAICT, users of the DMA-API must unmap the pages, otherwise they
run into bigger issue (as leaking IOVA).
This is stated in Documentation/core-api/dma-api-howto.rst
  Every dma_map_{single,sg}() call should have its dma_unmap_{single,sg}()
  counterpart, because the DMA address space is a shared resource and
  you could render the machine unusable by consuming all DMA addresses.

On the other side, there are very few driver that use the IOMMU API
directly, and from what I can see they do iommu_unmap().

Some page table implementations might tolerate it (because it is simpler
and more efficient to implement instead of descending to last level
tables) but I don't think that makes it right.

Thanks,
Mostafa


> the table to be removed from HW access and caches, with no requirement
> to unmap first.  iommu_setup_default_domain() frees the old domain with
> its IOMMU_RESV_DIRECT mappings still installed (those pages normally
> never return to the page allocator, so it does not WARN today), and the
> generic_pt kunit suite (CONFIG_IOMMU_PT_KUNIT_TEST) does the same in
> pt_kunit_iommu_exit().
> 
> Patch 1 adds __iommu_debug_unmap_phys(), the physical address based
> counterpart of __iommu_debug_map().  Patch 2 wires it into the deinit
> walk: a debug_unmap flag makes __collect_tables() drop the reference of
> every OA leaf it destroys, symmetric to how iommu_map() created them.
> 
> io-pgtable has the same gap in __arm_lpae_free_pgtable(), but its
> cookies cannot reach the struct iommu_domain, so that fix needs an ABI
> change or per-driver handling and is left as a follow-up.
> 
> The kunit suite doubles as an in-tree reproducer: with
> CONFIG_IOMMU_DEBUG_PAGEALLOC=y and CONFIG_IOMMU_PT_KUNIT_TEST=y, boot
> with iommu.debug_pagealloc=1
> kunit.filter_glob=x86_64_iommu_test.test_pgsize_boundary, then
> allocate and free most of memory (the case maps 128K at the hard-coded
> OA 0x208b95d000 and never unmaps it, so the machine needs enough RAM
> for that address to be online memory - a 150G guest was used here, and
> the sweep was a tmpfs filled to 95% of RAM):
> 
>     unpatched:          64 page leak WARNINGs
>     with this series:   0
> 
> The 64 is one WARNING for each of the 32 mapped pages on both its
> allocation and free.  On unpatched mainline the suite already fails
> test_random_map's NR_SECONDARY_PAGETABLE assertion, which aborts its
> cleanup and cascades into the following cases, hence the isolation.  An
> out-of-tree module mapping a page into an amdv1 domain and freeing the
> domain without unmapping shows the same behaviour, 384 WARNINGs over
> 64 iterations unpatched and none with the series; each leaked page is
> reported again on every later allocation and free, so the count
> exceeds the 64 leaked pages.  The control case that unmaps first stays
> silent.
> 
> The generic_pt format code can be built as a module (e.g.
> CONFIG_IOMMU_PT_AMDV1=m), so the new helper and the
> iommu_debug_initialized static key are exported GPL.
> 
> Yuanhe Shu (2):
>   iommu: Add __iommu_debug_unmap_phys() to drop refs by physical address
>   iommupt: Drop pagealloc references during domain deinit
> 
>  drivers/iommu/generic_pt/iommu_pt.h   | 22 +++++++++++++++++---
>  drivers/iommu/iommu-debug-pagealloc.c | 30 ++++++++++++++++++++++++---
>  drivers/iommu/iommu-priv.h            | 24 +++++++++++++++++++++
>  3 files changed, 70 insertions(+), 6 deletions(-)
> 
> base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
> -- 
> 2.43.5
