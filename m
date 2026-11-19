Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795112124;
	b=p+tJa3tRhQ7wClx9JElDFNbg94AnYS5Zq2GGBfFTHhjxKLR+TcfG1tsBKy84V8+doTV7
	 MLAdK3vnxWQIUVnZE67d06Sewl4XHTa6Lteo+EZe+7h7AfKY8ePE0A509/bzYnxB7xEqN
	 2ULgSV8dZWymvJ8uBjNL0K2Dx7ugwEVMz21LcLhtIxASR/fk2ZzexI+ZNNzhUp3X5aDrB
	 EkmTdPhN+V4YVM2MUNYLhBi6Wcz08AyvHeSagBEu2wsZDrQXwFnPYyJVOLZkmo/Edygf4
	 bMNDq5TEwtrxspxQh8DKBJDic3zg9adqnGUK6ozPZiP5sBHk+XFOJsSqXHGU0cAmcBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795112124;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=mqGkD9I85lMxxh2pXUJtphRW9gwZyygiSvkEg9y6zhg=;
	b=iOtVDyFsO5N8in1kRdfc0sa3CKWiFMWzgG8+0t/pJL2HSaBkIlT0QCh5UAMB1GFQlQ39
	 SqIVrkHjvfo2+Io7p5pEdqGYb9cGIe1lPWS7N0ZSkwbl4R9iPzuPZXgrsoTYl3i3yqfXN
	 hAVpHMcTivVM35TxIAc+lOFYkOlmFl/1G9qrHR7le9b2y8mgMCBM7nkCdcZdvilyLd1tR
	 7zF8HBIQTPp9h1i3R3DOzsY83P9Nd5ispLxHirOytJ6LMOA+8ZltLCmeHLjbNW7MnTxPx
	 31aahqxc64WKF9r9jQTuARsBjMnXgHc0c3KPIFfN2W8byG+RiLms/wAdV339mjYCjlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=m3vwdRBI;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCD606A330
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 18:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12FCD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=m3vwdRBI
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261119181521euoutp024d3fbadae5c3f8aace4cc32d5767520a~phPaf7z3C0740807408euoutp02v
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 18:15:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261119181521euoutp024d3fbadae5c3f8aace4cc32d5767520a~phPaf7z3C0740807408euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795112121;
	bh=mqGkD9I85lMxxh2pXUJtphRW9gwZyygiSvkEg9y6zhg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=m3vwdRBIFQ+xJcwYjPZUilKlUyqOuRlXHG+GoDe3w3tVL80BjVNUIOuqx9BdV299U
	 LSWlUw7lWPZVxqSZJvxwWpozPn2D8yudVaik143glGyt0vDTL+N/6Ki0Lhy3K6r0Nx
	 +1eyxGxqyfZLYbp8mj79YuHQPO6Hpz8+L4+ZEf6s=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261119181520eucas1p15056e661966e438ca7fcf5f4cc6f83da~phPZc8smn3120131201eucas1p1R;
	Thu, 19 Nov 2026 18:15:20 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261119181518eusmtip1f369868376049534c22cce45c363981b~phPYUTA913171431714eusmtip1Q;
	Thu, 19 Nov 2026 18:15:18 +0000 (GMT)
Message-ID: <8cbec036-10ec-4fd4-81a7-2235260985a0@samsung.com>
Date: Thu, 19 Nov 2026 19:15:18 +0100
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
Subject: Re: [PATCH v3 0/7] dma-mapping: DMA_ATTR_NO_KERNEL_MAPPING related
 fixes
To: linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig
	<hch@infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy
 (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)"
	<ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Chris
	Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261119151520.2383226-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119181520eucas1p15056e661966e438ca7fcf5f4cc6f83da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119151527eucas1p16c69a0580b2caabe66f952572362021f
X-EPHeader: CA
X-CMS-RootMailID: 20261119151527eucas1p16c69a0580b2caabe66f952572362021f
References: <CGME20261119151527eucas1p16c69a0580b2caabe66f952572362021f@eucas1p1.samsung.com>
	<20261119151520.2383226-1-m.szyprowski@samsung.com>

On 19.11.2026 16:15, Marek Szyprowski wrote:
> arch_dma_prep_coherent() is called by the generic DMA code on pages
> which may be located in highmem: dma_direct_alloc() forces the remap
> path for a highmem page returned from CMA and calls this hook on it
> before creating the uncached mapping. However, the hook has never been
> documented and some implementations assume that the page has a kernel
> linear mapping. This issue affects MIPS, xtensa and PowerPC. It gets
> fixed by patches #2-#5.
>
> xtensa also only invalidates the cache, which discards the zeroes
> written by the dma_direct_alloc(). Patch #1 switches it to a
> writeback+invalidate.
>
> Patch #6 documents that arch_dma_prep_coherent() must write back dirty
> lines and must accept highmem pages. With that in place, patch #7 drops
> the PageHighMem() check in dma_direct_alloc_no_mapping(), which so far
> skipped cache maintenance for highmem CMA pages allocated with
> DMA_ATTR_NO_KERNEL_MAPPING.
>
> Patch #8 makes dma_direct_alloc_no_mapping() always return zeroed
> memory, like all other dma_alloc_* paths. Passing __GFP_ZERO is not
> enough there, because CMA ignores it.
>
> The analysis and the patchset was prepared with the help of an LLM. The
> code compiles fine, but it has not been runtime tested on any of the
> affected architectures yet. Testing on real hardware would be
> appreciated. I've reviewed the resulting changes.
>
> I plan to merge this via my dma-mapping tree, I can provide a tag if
> needed for merging it also to arch code.
>
> Best regards
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland


Merged into dma-mapping-for-next, with Fixes tag dropped in patch #5
as requested by Ritesh. Here is a stable tag if one needs to merge
this patchset also to arch tree:

git://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git tags/no_kernel_mapping_fixes

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

