Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C83B9608
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088475; cv=none; b=AICWNWI96XMtKv9tyrbcDZO7DqYV4ldGOZFrbWG5Ul8KAKsEGGwtGmcTE1YQ9A6FT0LWINKlkbo9bV/0DD6tDtafOU7iZiNEqX1iyMUFKvbVVYBbqFx9Qfp4+OqvJIPd6gg4lJ1jhRpDWYPGzevzO2CvqexuND+ZnrYToKyWVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088475; c=relaxed/simple;
	bh=Ddfpw7OqAUg4uD8ewJq0QQlmGQmEVI2PsZmNxztAooc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BCON6QFiD2wZ7hAqmsx8Ymzb8/IBqeVAF0pQpVPn/FxkxSZ6u+wokklIqDD07cK1B9Qgd6e3XSgLZyw73pmjdLLhiK6A31sjzUrVcmjIAarwYtYb90tcMxPfkox0X0+AJLkNdS1gB9639ex6jd+cqqbBwxcTl1kdkAID4oT19Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZTZLi9dy; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZTZLi9dy"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260518071429euoutp02bf7e07eb612fd3338c9f36213821e9cd~wl4mFpfwd1898118981euoutp02e
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 07:14:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260518071429euoutp02bf7e07eb612fd3338c9f36213821e9cd~wl4mFpfwd1898118981euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779088469;
	bh=9hejV/tmqwLHbKahfMWeS4MTA8R3C7KzYBatO1tjh/8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZTZLi9dyAQO5VE/UmH63k0mnt+MOcLYIJA6f7KdeRjPPnpbzlNP9445pRkI2LohNe
	 8DuOSm43l9ZjBiftP/QYR5DClExjL7eZpb/FXq/0/1/fd68rHh2HgkMkTNuZhKOY3L
	 qfU7sft8X0IXgsIkXAmZWKwTKKUuCmhHoTjzX7Ec=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260518071429eucas1p1bda81655e398737dab2d498abf9abfcf~wl4l1YZO31335413354eucas1p1h;
	Mon, 18 May 2026 07:14:29 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260518071428eusmtip11d1413a3932c737e1c2a98b0435599ad~wl4lMCr3l1755917559eusmtip1n;
	Mon, 18 May 2026 07:14:28 +0000 (GMT)
Message-ID: <0da45751-e4e1-4c98-91ba-08340723ed95@samsung.com>
Date: Mon, 18 May 2026 09:14:28 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5] dma-contiguous: add kconfig option to setup numa cma
 area if not configured explicitly
To: Feng Tang <feng.tang@linux.alibaba.com>, Robin Murphy
	<robin.murphy@arm.com>, Ying Huang <ying.huang@linux.alibaba.com>, Andrew
	Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, Christoph Hellwig
	<hch@lst.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260512085509.83002-1-feng.tang@linux.alibaba.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260518071429eucas1p1bda81655e398737dab2d498abf9abfcf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260512085518eucas1p15d8e1a1173b398b496936d96aa29378a
X-EPHeader: CA
X-CMS-RootMailID: 20260512085518eucas1p15d8e1a1173b398b496936d96aa29378a
References: <CGME20260512085518eucas1p15d8e1a1173b398b496936d96aa29378a@eucas1p1.samsung.com>
	<20260512085509.83002-1-feng.tang@linux.alibaba.com>

On 12.05.2026 10:55, Feng Tang wrote:
> There was a report on a multi-numa-nodes arm64 server that when IOMMU
> is disabled, the dma_alloc_coherent() function always returns memory
> from node 0 even for devices attaching to other nodes, while they can
> get local dma memory when IOMMU is on with the same API.
>
> The reason is, when IOMMU is disabled, the dma_alloc_coherent() will
> go the direct way and call dma_alloc_contiguous(). The system doesn't
> have any explicit cma setting (like per-numa cma), and only has a
> default 64MB cma reserved area (on node 0), where kernel will try
> first to allocate memory from.
>
> Robin Murphy suggested to setup pernuma cma or disable cma, which did
> solve the issue. While there is still concern that for customers
> which don't have much kernel knowledge, they could still suffer from
> this silently as some architectures enable cma area by default (not
> an issue for X86 though, which set CONFIG_CMA_SIZE_MBYTES to 0 by
> default) for most Linux distributions.
>
> One thought is to follow the current cma reserving policy for platform
> with 'CONFIG_DMA_NUMA_CMA=y', that if the numa cma (either the 'numa cma'
> or 'cma pernuma' method) is not explicitly configured, and the platform
> really has multiple NUMA nodes, set it up according to size of default
> 'dma_contiguous_default_area'. This way, the default behavior of
> platform with one NUMA node is kept unchanged (say embedded/small
> devices don't need to allocate extra memory), while the general dma
> locality is improved.
>
> Add a new bool kernel config CONFIG_CMA_SIZE_PERNUMA to control whether
> to enable it. Even when the config is enabled, user can still disable
> it by kernel-cmdline setting like "numa_cma=0:0" or "cma_pernuma=0".
>
> Reported-by: Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
> Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Applied to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

