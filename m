Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098978;
	b=fdOCVuJYyIA/CdvTfaYqztAgnPGEKQRqKNvX0d5lDDoZQlmYiV15nRPobQDULXbK6paY
	 aqxhTD7468FBTG10GUpU5uGui0XXDA1ehKJQLJ27R+3zS7VcrjkSh1Kqfh4kq/waS48jv
	 BSseR7FnZ6WB/0M7wJ4Uoa+Gox9GZF6aNmIUykdczBWSLkxTCLVwzqSvBJjVBpT0+YuTJ
	 RPXL3JkmyepIVTeUP73YrvDyy0H0mRD4/c5E8378XwYzLPkL4AaoKJbTaL3AoMMxe145t
	 Ma/i4rz2wC7//JKJypqV7Y8ZBd9n3OkHpk1DkChYdV3xPVRTMyVkOZFar2l31ks1anw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type:Content-Transfer-Encoding;
	bh=VnF6ja6VhKpFTfNVvE3jU57UL6Hk22nBfY4kDDWDjbs=;
	b=OieGYNaL1GgFNF8qs5JGrPweImrCsP6yY2zCAyCZ8W6YmYOAnE9P/Q6TTOLLf/7ihkKS
	 onRlbB+TZedY9sT/yf6AWYIP4vPzl2bVC6bxQck7aAFPNFYJfsmvySnZwZFtn9mZUpxT2
	 +M+g6Jsn0fiR5BMx0c8xydOhWbH1UuZsuQOzozhy30MavunK4I19D1Vlt9IHCNYvWDh1Z
	 pzm+aIM3QavUKyjcehICL1SxQaA4tW6kAsLXWY2WyvopMKhBSMGNEzZmkCvmbLE1YF/N0
	 kiKB3MRtlCMi9Wo/C9pgOElf1XjA+uOlGCNSAbpHq2+I1XpF2rAvnelNtDORfd8IwJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oAgxDnXj;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B52606A320
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 14:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12B52606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oAgxDnXj
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1612845a12.0
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 06:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795098976; x=1795703776; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VnF6ja6VhKpFTfNVvE3jU57UL6Hk22nBfY4kDDWDjbs=;
        b=oAgxDnXjHBoOAoKUncUk+yMvuZJ3JinqAwBBLrP231HzJI3fhxxq2FfAxdOua1xBCy
         6beVMOoz7RueQCAOgEl3DZkd6QP5knaiRRVO/fHECypa1RzTHf6bPUdCm4F526geEPyj
         l+YhhzHQ3wFZt1Z7qoU7njjumO3f3NYeAbqLMXsudm4cOfavhTlHuwZR5Se83l932odc
         0bhdZIDrze20QKvDPfUlyHHMvPmLhEFGiV2xmAe70dYVfKF0d8GosRfPUqtqzEiXiyDj
         E4nCyTQ5xp0EgcaJFM7sv7IhXZnr/zn9j4gEyrtav4v3yunD+mCwQEDDHNfCguwmYmQE
         MSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098976; x=1795703776;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VnF6ja6VhKpFTfNVvE3jU57UL6Hk22nBfY4kDDWDjbs=;
        b=ppuMl42h5SGPMQvfs6Uq4TPkGAccWQu3xuPmx2Tjb/REqwKipndJrvDVluC7pfhU3O
         xFp+1xUbTYa6k7xvS8FiNyIrujIJPm56L+ppKht9cj/xeXAjpsWA9cJ8LWAb5bPI6n1D
         fIwTanMItEuPLEkIG6qkeV9iNB/ftHT+XdXiwLN4XarxL/vUKrHAaDepSdUdhihP/c/P
         1k0ke4x6GKuBpMrApXyd2eSggFaZInCTdr8Am63VDEs/mcX2YARdiV4BAK/bzhT+jWm6
         3Htth8Qy3tP00weVPjQEW/RMQJYO8b3wV4HgulNnNZs/ZZy6ahtqC1GqUpBYDmwgb5Y6
         hfuQ==
X-Forwarded-Encrypted: i=1; AL+hErEGjCE2XHtgiLgOhO+XOFwcmUiAwoPoS7tqoQ8iD7ucQFRLSOv/jTmxg6fBEeyPM4nPcFiZng==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ubxVnCk0siWfnO2/mb5M17t2turkjmeIhXN3tWxq+bZrOhmLM
	o00iW6w6dhcf6MW/hLreV1+uYqzwUeJTRykrL5JDztNJGG4vdcwP7CkK
X-Gm-Gg: AZFdTZeuoIAg+QsyQOJ8LWrqkyEYlnbsXRmhHZQX2+0UJDg3JWziKPPQvi1fjWhuv1g
	JxsozUSbz7dgRaxZYTel21mgfRZXc9TOhEulHnN+0+Z79LjcpRykN7ygneXPsYDhJdshPmydnrA
	w+8nQp7eU1jwoHzIK4AxDPpycQyGgvm0MGhqDrfMA1LnUcKK6Hx30QHgVBRbg3IrqPpEfXFx5Kr
	PG1PrmxIAaQzB+Tvo6552RJkIV5cYB3X7ew+Y0xjxYe6rLf5vVKPxlNIGh402Q061kL8lkaJ2Sp
	Akg4vjXPEH8DYUUTujE4Ywkh7f0lt+ivGLdgu1jMu2lOWVwSg5q8Wu/A0EXUgd71i838D1Pb2gW
	9SgMAI1Y33LxJELyRrdhDZs3M9oNUE41cqndbKJKqu1TbJE0rjd7lNole/xJ2tVqITTAJOBE5p0
	W8rtkJOZMXQXFsWM1+bmLC7RMThcIDnbMibeFHu/BroHt9SyUvHcSz1Ntg/Ljk1I8CY5bZ7IDm0
	D9x9xLRkEO9Lng9wpBqPeeCXQkk5pRapqKXDRyszWenIWj/kHvb/q033iD4ptdUhgnkyoQLg2gY
	5r2ffezsWnTpEQtKLmhHSfHkiTc9NXb1ervyhqtq3VWQujFq
X-Received: by 2002:a05:7300:bc19:b0:36a:18e2:64c with SMTP id 5a478bee46e88-3827f98ff0cmr7469514eec.11.1795098976262;
        Thu, 19 Nov 2026 06:36:16 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a7fbceffsm19156884eec.28.2026.11.19.06.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:36:15 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, "Christophe Leroy (CS
 GROUP)" <chleroy@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 4/7] powerpc/mm: handle highmem pages in arch_dma_prep_coherent()
In-Reply-To: <2b64e853-89a7-4fa5-a4f8-2c6b0b62bf74@samsung.com>
Date: Thu, 19 Nov 2026 19:59:02 +0530
Message-ID: <5wxslwsx.ritesh.list@gmail.com>
References: <20261110094830.2081847-1-m.szyprowski@samsung.com> <CGME20261110094850eucas1p1f10fa1473aca341473077f60a088b490@eucas1p1.samsung.com> <20261110094830.2081847-5-m.szyprowski@samsung.com> <jym96n4p.ritesh.list@gmail.com> <2b64e853-89a7-4fa5-a4f8-2c6b0b62bf74@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 19.11.2026 13:07, Ritesh Harjani (IBM) wrote:
>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>
>>> arch_dma_prep_coherent() performs the cache maintenance on the address
>>> returned by page_address(). On 32-bit powerpc with CONFIG_HIGHMEM that
>>> is NULL for a highmem page which is not kmapped, so the flush would
>>> operate on the wrong virtual range and leave the dirty lines of the
>>> buffer in place.
>>>
>>> The generic DMA code may pass highmem pages to this hook:
>>> dma_direct_alloc() handles a highmem page returned by
>>> dma_alloc_contiguous() by forcing the remap path, which calls
>>> arch_dma_prep_coherent() on that page before creating the uncached
>>> mapping. This cannot happen on powerpc today only because it does not
>>> select HAVE_DMA_CONTIGUOUS, so dma-direct never gets a highmem page
>>> there, but nothing in the hook's contract rules it out.
>>>
>>> Use __dma_sync_page() with DMA_BIDIRECTIONAL, which the
>>> arch_sync_dma_for_*() hooks already use and which kmaps highmem pages
>>> one at a time. Without CONFIG_HIGHMEM it does the same
>>> flush_dcache_range() on the linear mapping as before.
>>>
>> Does that mean, this change can add additional overhead for
>> CONFIG_HIGHMEM=y kernels, where the buffer received still belongs to
>> lowmem? (Because of extra per-page book keeping like
>> local_irq_save/restore, kmap_xxx). Thoughts?
>>
>> Although functionally the change looks correct to me. But maybe
>> __dma_sync_page() on powerpc side could use some cleanups (outside of
>> this patch series perhaps).
> Indeed, __dma_sync_page() could be improved by calling __dma_sync_page_highmem()
> only for highmem pages. Something like:
>
>
> diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
> index e646256365d5..199ce0467b58 100644
> --- a/arch/powerpc/mm/dma-noncoherent.c
> +++ b/arch/powerpc/mm/dma-noncoherent.c
> @@ -97,11 +97,12 @@ static void __dma_sync_page(phys_addr_t paddr, size_t size, int dir)
>         unsigned offset = paddr & ~PAGE_MASK;
>

Should we return early if size=0 is passed. Although I couldn't find any
caller where this could happen, but since we are doing "paddr + size - 1",
hence wanted to flag it.


>  #ifdef CONFIG_HIGHMEM
> -       __dma_sync_page_highmem(page, offset, size, dir);
> -#else
> -       unsigned long start = (unsigned long)page_address(page) + offset;
> -       __dma_sync((void *)start, size, dir);
> +       if (PageHighMem(pfn_to_page(PHYS_PFN(paddr + size - 1)))) {
> +               __dma_sync_page_highmem(page, offset, size, dir);
> +               return;
> +       }
>  #endif
> +       __dma_sync(page_address(page) + offset, size, dir);
>  }
>
>  void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>
>
> Do You want me to add it as another patch for this series?

I think this should work. I guess we should add this patch first and
then patch-4 on top of it.

Thanks for taking care of it. This at least will avoid the extra work
which we would have done otherwise for highmem kernels, where the buffer
passed to this still comes from lowmem.

-ritesh
