Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094274;
	b=svD1NF9R2C/fIDKMkxY9nXPmSkov+Ce8vQPoit61DyPrnAldiBGtENhwQDmFyS6Qn+Lm
	 /YlfW9fT+wS/DIboI0kllq9RH5osP3lWADWMo9BOWwv0uOrc8Caqi+Vo99zDvhaIisasW
	 JzsgbMwJ2mdATGsGj/25g41W6uS3DG09VLbbNyI4AWuaa0o44xOCEvH5cliTAnxseaTb1
	 L/PbRNJwHUEx/ng7mZ5g6VBNZqjT2zfVfRVbN90IK1PE2UjX7XiOZkwq3lbEgwkA3Z5Ug
	 QuzmGKaQTSEQLM7EsG9S0pTsqBkMxTXiKBssLl186RIDe4nAjGHMQh9p9pRS5wucN4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094274;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=c4JodCXFJYsFjKsG9M4trE9wchuTecCsKm5CSZLC4hc=;
	b=4rG/UTnJ5KFPfAUpZ+EbXXKmzKeiv8syot87RrSmSWCGJDMvZXM2JNn4T9g284obTifP
	 V4YKeQDb180ZLqJ4Wbg5cR4mtoGq9rNuRJevEy8hAebW7C3wsB49Jm1jbsnWbT/3mi540
	 77NP+9gFFOZ3k+6HwCs5gQyEJH0imlTciYo9trCcnsIzeVEyjMx/UmlzZZo6D2ttyHCgK
	 nCQHfCUScaye8tRONVaf0+mUeQ0VTeCkojosgsqejXCUpX/RE0u4EZKxTd8VhiWh/oaEi
	 lLWuZqC5gTDiq6jX7h5SXKwfyU+0adbm0wo2cUTfDCfSKCAK3LFr+l4Q3JbVFqHVhcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=tCKrdnen;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0EE606A338
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E0EE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=tCKrdnen
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261119131751euoutp02ff7e1b747a048d880a5b5d27521596d3~pdLqeepuH1514615146euoutp02I
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:17:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261119131751euoutp02ff7e1b747a048d880a5b5d27521596d3~pdLqeepuH1514615146euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795094271;
	bh=c4JodCXFJYsFjKsG9M4trE9wchuTecCsKm5CSZLC4hc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tCKrdnenBcm3IgpjF1SGdlm8gc80Rzy8MOKtLvZHDbZ4DzfnsSTC/cJYb64iIQeE0
	 hKy5i/cFoAD0ok+eLMz/0ElmTyA/dK0x6TappCbdLTAe7isXOWreRT5TypImh4S6th
	 9TGQZMmpSxkATQ+cLpVdE6FVbrBWriGKEhdwNoO4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119131751eucas1p188066757e9cd9eb57dbdceb523c9b7ec~pdLqNmLTa2917429174eucas1p1w;
	Thu, 19 Nov 2026 13:17:51 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119131750eusmtip1b09a8063fcb8f57bec92422ad0c4bde6~pdLpUEplc1427414274eusmtip1n;
	Thu, 19 Nov 2026 13:17:50 +0000 (GMT)
Message-ID: <2b64e853-89a7-4fa5-a4f8-2c6b0b62bf74@samsung.com>
Date: Thu, 19 Nov 2026 14:17:49 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 4/7] powerpc/mm: handle highmem pages in
 arch_dma_prep_coherent()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, "Christophe Leroy (CS
 GROUP)" <chleroy@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig
	<hch@infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Max Filippov
	<jcmvbkbc@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <jym96n4p.ritesh.list@gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119131751eucas1p188066757e9cd9eb57dbdceb523c9b7ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261110094850eucas1p1f10fa1473aca341473077f60a088b490
X-EPHeader: CA
X-CMS-RootMailID: 20261110094850eucas1p1f10fa1473aca341473077f60a088b490
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
	<CGME20261110094850eucas1p1f10fa1473aca341473077f60a088b490@eucas1p1.samsung.com>
	<20261110094830.2081847-5-m.szyprowski@samsung.com>
	<jym96n4p.ritesh.list@gmail.com>

On 19.11.2026 13:07, Ritesh Harjani (IBM) wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>
>> arch_dma_prep_coherent() performs the cache maintenance on the address
>> returned by page_address(). On 32-bit powerpc with CONFIG_HIGHMEM that
>> is NULL for a highmem page which is not kmapped, so the flush would
>> operate on the wrong virtual range and leave the dirty lines of the
>> buffer in place.
>>
>> The generic DMA code may pass highmem pages to this hook:
>> dma_direct_alloc() handles a highmem page returned by
>> dma_alloc_contiguous() by forcing the remap path, which calls
>> arch_dma_prep_coherent() on that page before creating the uncached
>> mapping. This cannot happen on powerpc today only because it does not
>> select HAVE_DMA_CONTIGUOUS, so dma-direct never gets a highmem page
>> there, but nothing in the hook's contract rules it out.
>>
>> Use __dma_sync_page() with DMA_BIDIRECTIONAL, which the
>> arch_sync_dma_for_*() hooks already use and which kmaps highmem pages
>> one at a time. Without CONFIG_HIGHMEM it does the same
>> flush_dcache_range() on the linear mapping as before.
>>
> Does that mean, this change can add additional overhead for
> CONFIG_HIGHMEM=y kernels, where the buffer received still belongs to
> lowmem? (Because of extra per-page book keeping like
> local_irq_save/restore, kmap_xxx). Thoughts?
>
> Although functionally the change looks correct to me. But maybe
> __dma_sync_page() on powerpc side could use some cleanups (outside of
> this patch series perhaps).
Indeed, __dma_sync_page() could be improved by calling __dma_sync_page_highmem()
only for highmem pages. Something like:


diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index e646256365d5..199ce0467b58 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -97,11 +97,12 @@ static void __dma_sync_page(phys_addr_t paddr, size_t size, int dir)
        unsigned offset = paddr & ~PAGE_MASK;

 #ifdef CONFIG_HIGHMEM
-       __dma_sync_page_highmem(page, offset, size, dir);
-#else
-       unsigned long start = (unsigned long)page_address(page) + offset;
-       __dma_sync((void *)start, size, dir);
+       if (PageHighMem(pfn_to_page(PHYS_PFN(paddr + size - 1)))) {
+               __dma_sync_page_highmem(page, offset, size, dir);
+               return;
+       }
 #endif
+       __dma_sync(page_address(page) + offset, size, dir);
 }

 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,


Do You want me to add it as another patch for this series?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

