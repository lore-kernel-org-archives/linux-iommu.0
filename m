Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8554B3E00BC
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946280; cv=none; b=jU2FmSErR2atdUSFOnrnIP/Bd0uc/6YThk5n54FM+h+ZU/2DhP0xWk+5Nfd3JpEh+pLRWpz6QDdnWTepRYclm/kykagT+Q/XcHIQbcibsPkGLxy0vrFft0RFZS2iUcGu2xZCgkgMu8j/ak/fQEjL4+9/f6Bu9fJ9+cr4WOBBrNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946280; c=relaxed/simple;
	bh=Wogea+KEzeap1Lp6Hh6RIuEaHRo08Y+0sJrsM3lFcUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=EHeRqIOST4b1YRxjLSz/nOfwYuyusxXvse7XlMHhZ42nAaT49XCyeYLUs9X9fZaqGlK1PkEdEByA0dj8E+jbPtlh/eOAuKcIuz+1zdI0QeQUIQLwepT6OQqytyojTdVo616itFT3gUqpWk5or+Q5fGmRCCwhWsoxkF8O5z/jOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oGti7xWP; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oGti7xWP"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260909093113euoutp02595c923ddb29fc4a77c0879ec6953378~TnShETCBl1187411874euoutp02I
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 09:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260909093113euoutp02595c923ddb29fc4a77c0879ec6953378~TnShETCBl1187411874euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788946273;
	bh=HO6oHU6+x0iADCv4F2Kq7ObM80NEpWfdqWcE+sOXJ0Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=oGti7xWP0pC3X47vHVzo4vTBtvFK5a4HXHQWqUNXMVwatbYB5MrrTRGWkT9uLyar1
	 0Od4Rg2VrudnHJkPl//xuBQm5ucHz95VZigqFvjo30ugVXW3P32lZqT7ErxGnafVJF
	 D6BUb9f8u1PfrK9KjZSP6lEkfQK+aoclF5dOO674=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260909093113eucas1p1e60dc5b40650691465cd1d37f79afac1~TnSg0i0Va2506425064eucas1p1i;
	Wed,  9 Sep 2026 09:31:13 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260909093112eusmtip1f94adf08cb3dd111e0ae7ce9444f53cb~TnSf8xVsD1514415144eusmtip1W;
	Wed,  9 Sep 2026 09:31:12 +0000 (GMT)
Message-ID: <3d764722-a52e-46a9-8db2-4bd7d5178546@samsung.com>
Date: Wed, 9 Sep 2026 11:31:11 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] dma-mapping: don't trace the DMA address when the
 allocation fails
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Sean Anderson <sean.anderson@linux.dev>,
	iommu@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260907120124.603373-1-donggeunyoo.kernel@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260909093113eucas1p1e60dc5b40650691465cd1d37f79afac1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260907120135eucas1p2e978bcaf868b9446219dc1fb6ad11bc0
X-EPHeader: CA
X-CMS-RootMailID: 20260907120135eucas1p2e978bcaf868b9446219dc1fb6ad11bc0
References: <CGME20260907120135eucas1p2e978bcaf868b9446219dc1fb6ad11bc0@eucas1p2.samsung.com>
	<20260907120124.603373-1-donggeunyoo.kernel@gmail.com>

On 07.09.2026 14:01, Donggeun Yoo wrote:
> dma_alloc_attrs() passes *dma_handle to trace_dma_alloc() without
> checking whether the allocation succeeded. No backend writes it on
> failure: dma_direct_alloc(), iommu_dma_alloc() and the dma_map_ops
> instances assign it only on the path that returns a buffer. Callers
> usually pass an uninitialized automatic variable, so a failed allocation
> records whatever the stack held, next to the virt_addr=(null) that marks
> the record as an error:
>
>  dma_alloc: dmatrace dir=BIDIRECTIONAL dma_addr=deadbeefdeadbeef
>  size=1099511627776 virt_addr=0000000000000000
>
> The device coherent pool path reaches the same call: a non-zero return
> from dma_alloc_from_dev_coherent() means the request was handled, not
> that it succeeded, so cpu_addr is NULL and dma_handle is untouched once
> the pool runs out.
>
> For an allocation event a NULL virt_addr already means the request
> failed, so the address field carries nothing. Report 0 for it in the
> event class rather than at each call site, which covers dma_alloc_pages()
> and dma_alloc_sgt_err() as well.
>
> Fixes: 038eb433dc14 ("dma-mapping: add tracing for dma-mapping API calls")
> Fixes: 68b6dbf1f441 ("dma-mapping: trace more error paths")
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Applied to dma-mapping-fixes, thanks!

> ---
> v2:
> - report 0 in the event class instead of splitting the two call sites,
>   as suggested by Marek. kernel/dma/mapping.c is untouched now, so
>   debug_dma_alloc_coherent() keeps being called for a failed allocation
>   and decides for itself what to do with it.
> - tested on x86_64 rather than compile-tested only.
> v1: https://lore.kernel.org/linux-iommu/20260905071919.30784-1-donggeunyoo.kernel@gmail.com/
>
> Tested with a module that puts a known value in the caller's handle and
> then asks for 1 TiB from a 32-bit capable device, with the dma_alloc
> event enabled. Before, the record carries the caller's stale value; after,
> it carries 0:
>
>  -dma_addr=deadbeefdeadbeef size=1099511627776 virt_addr=0000000000000000
>  +dma_addr=0 size=1099511627776 virt_addr=0000000000000000
>
> A PAGE_SIZE request from the same device, as a control, reports its real
> address on both kernels, matching the handle the caller got back.
>
> This changes what the record contains, not what the caller does:
> *dma_handle is still read to build the tracepoint arguments, since those
> are evaluated before the static branch.
>
>  include/trace/events/dma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index 9df02c1511de..b06d8f99922d 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -134,7 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
>  	TP_fast_assign(
>  		__assign_str(device);
>  		__entry->virt_addr = virt_addr;
> -		__entry->dma_addr = dma_addr;
> +		__entry->dma_addr = virt_addr ? dma_addr : 0;
>  		__entry->size = size;
>  		__entry->flags = flags;
>  		__entry->dir = dir;
>
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

