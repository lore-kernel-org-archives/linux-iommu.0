Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67641D516C
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765786430; cv=none; b=tp6uMrwJ9OfJbE8XsXGQxnziu8S+Vk92pymlI16Ws7N94mzcXLMr/tLFwdNKGAIAlFAE2ecNJysTStPyI0uxtTbD3F5MZBmQdW4H1Z7bGPtcUket9zDbFbk+ZBf2ZIS6y9sptiZ9FxZCf5xWwCPsfMhrx/pBlKNlsKUlgPOATRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765786430; c=relaxed/simple;
	bh=RyLJ/GJuRRs1fiILlPWSEhaQHqtbrnUmmJrtPzfECFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WvkZ7eat14lxBElYuPy6u+y0GcCwP59hy+zmj3Z4EPn7P/B+1oAHdUyJqPWN0ItSdF9615tjys4nxVz6J0Zu3aU/nmJijReuAHzw2mfnWfJuunKIqjmvtYozUJ/6dJTpSxHARYFM4lyBWf+E5eD8IAj8pw+RDeV5h0kKfLFL6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BwQcqntY; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BwQcqntY"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251215081340euoutp026dbc38b126fa645aa67c2e74c9eb7c0b~BVWTMEqiX3126631266euoutp02I
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 08:13:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251215081340euoutp026dbc38b126fa645aa67c2e74c9eb7c0b~BVWTMEqiX3126631266euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1765786420;
	bh=j6MutikF5ULde/hRoOaQ6lqSayHrzSsu7RC8+aRTtfI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=BwQcqntY2l/V1YbQr8ApNjGYOnHb0dWQGcFZIyQgIMlePnU+6QueO21swcwWxot5H
	 b+D8vtSa1XwMjEGO/4xknZ5ERsrdQZtr/5iACWoEjz2N47oMmyHmxidc6g1KMvXw1w
	 +6s3nzowGqo6Dh8FVTH2fkJzMAehUNESueK0g79w=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251215081339eucas1p2f60fa30c00bd66ef72d2e25447a3072c~BVWS3BKRP1278712787eucas1p2W;
	Mon, 15 Dec 2025 08:13:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251215081339eusmtip2bc0661369733084550454011fddfdbae~BVWSgMdYW2946529465eusmtip28;
	Mon, 15 Dec 2025 08:13:39 +0000 (GMT)
Message-ID: <c71603c6-fa05-4cd6-836a-4bbf55ba5ca9@samsung.com>
Date: Mon, 15 Dec 2025 09:13:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-remap: fix dma_common_find_pages() page lookup for
 offsets
To: Christoph Hellwig <hch@infradead.org>, Andrei-Edward Popa
	<andrei.popa105@yahoo.com>
Cc: robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <aT-jZyXGTVz-ziff@infradead.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251215081339eucas1p2f60fa30c00bd66ef72d2e25447a3072c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251215055807eucas1p2c04cd0536dd2d100547c90f3a99df8b8
X-EPHeader: CA
X-CMS-RootMailID: 20251215055807eucas1p2c04cd0536dd2d100547c90f3a99df8b8
References: <20251212200914.138310-1-andrei.popa105.ref@yahoo.com>
	<20251212200914.138310-1-andrei.popa105@yahoo.com>
	<CGME20251215055807eucas1p2c04cd0536dd2d100547c90f3a99df8b8@eucas1p2.samsung.com>
	<aT-jZyXGTVz-ziff@infradead.org>

On 15.12.2025 06:57, Christoph Hellwig wrote:
> On Fri, Dec 12, 2025 at 10:09:14PM +0200, Andrei-Edward Popa wrote:
>> dma_common_find_pages() previously assumed that the CPU virtual address
>> always pointed to the start of a DMA-coherent allocation. This fails when
>> memory is allocated via dma_alloc_attrs() without DMA_ATTR_FORCE_CONTIGUOUS
>> and then subdivided into smaller blocks using a gen_pool, relevant only
>> when an IOMMU is enabled.
>>
>> In such cases, userspace may request a mapping via dma_mmap_attrs()
>> for a CPU address that is offset inside the original allocation. The
>> previous code could return the wrong struct page pointer.
> No, you can't mmap part of a dma coherent allocation.  What caller is
> trying to do this?  It needs to be fixed instead.

I wonder if this was ever explicitly stated.

dma_mmap_coherent() was initially added for mmapeing a 
dma_alloc_coherent()-allocated buffer for fbdev and alsa, and at least 
the first one allowed to mmap the buffer partially or starting at 
non-zero offset. I doubt that this feature was useful for anything, but 
I'm quite sure this was at least allowed and there were some comments in 
the code about that.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

