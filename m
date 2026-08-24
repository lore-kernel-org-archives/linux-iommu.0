Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B007C42E432
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579260; cv=none; b=jvD44nX1uFctRFZJMxCpJdHDmgrI27SWqBuOLj0OZwq5Grw8QKJllHeTmNxOAY/df/BzzSZ7EMjYArX3W3XXLWfIRln3n4Bo80SNJYFMMr29tiDFnv3fsXuaY1lFhcz1rZYrhFKnGMM3G6Xt6bzupTlEwj1hbou5+TWcaQiptWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579260; c=relaxed/simple;
	bh=OeCBjZq5N/oLXV9wNM3gAgzNWZ+9XiSLq4j8UNKYlg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=cwfpVuatAkE72gTWzvdbq5V/GJg7tLM3kKoU/oSSkzY6KR2ff6To0DLMtMljSPao5Uj1+i2hArAq/qqTHkq5ANGSxpPOSUZMLUjBvnLn8A9EkwLju13CU123owCAjdu9npuq5Qdu1lhKZLQpJRd3/qXPjIrWDXVVVji+SXrobJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NEa4EzKC; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NEa4EzKC"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260824134733euoutp02eb8a203f6c2d3372d6c0824faf64c99a~OwdxF8aqW0990209902euoutp02i
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 13:47:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260824134733euoutp02eb8a203f6c2d3372d6c0824faf64c99a~OwdxF8aqW0990209902euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787579253;
	bh=JR4DDH5PWZ/JMNU6Gi/68Pf6lEFV9F51DVbnN26bzKU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NEa4EzKCqVGpOx7bGgLnVrjtcCO6Di0W8+EGfnJe5djDNI1+FUaXrGhhYVdxD9qVL
	 8PKOWpeUE+0VXuTJcORttVgHZ2mduqOWXYVnmQVu96OVWi2LThZankqactry9pcEia
	 57r2RGqEn96XdY6zIA0mU3gahEsXCnV2sAkDak5o=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260824134733eucas1p1da2d16e50672648bbd4fef15c18c19d1~Owdw6NpQe0876408764eucas1p15;
	Mon, 24 Aug 2026 13:47:33 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260824134733eusmtip1448e529e85d58c56d5ceba3078b1e157~OwdwbRjmo3046430464eusmtip1o;
	Mon, 24 Aug 2026 13:47:33 +0000 (GMT)
Message-ID: <e2e039d1-5969-4325-8d9a-bd8e65dea916@samsung.com>
Date: Mon, 24 Aug 2026 15:47:32 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-contiguous: fix truncation of numa_cma /
 cma_pernuma sizes >= 2G
To: Alexander Graf <graf@amazon.com>, Robin Murphy <robin.murphy@arm.com>,
	Feng Tang <feng.tang@linux.alibaba.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260821224252.70640-1-graf@amazon.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260824134733eucas1p1da2d16e50672648bbd4fef15c18c19d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260821224302eucas1p29945ae5d2aeabd37ec1463a74dfe9ffd
X-EPHeader: CA
X-CMS-RootMailID: 20260821224302eucas1p29945ae5d2aeabd37ec1463a74dfe9ffd
References: <CGME20260821224302eucas1p29945ae5d2aeabd37ec1463a74dfe9ffd@eucas1p2.samsung.com>
	<20260821224252.70640-1-graf@amazon.com>

On 22.08.2026 00:42, Alexander Graf wrote:
> numa_cma=0:4G reserves nothing at all. dma_numa_cma_reserve() copies the
> requested size into a local int before handing it to
> cma_declare_contiguous_nid(), so 0x100000000 truncates to zero and the
> loop skips the node silently. Both parameters are documented in
> kernel-parameters.txt as nn[MG], so that is the syntax the documentation
> invites.
>
> Which bits survive decides what a request turns into: 4G, 8G and 16G
> reserve nothing, 2G, 3G and 6G sign-extend into a size the allocator
> rejects with a warning, and 5G quietly reserves 1G.
>
> It reaches further than those parameters. On a CMA_SIZE_PERNUMA kernel
> with no per-node parameter, dma_numa_cma_reserve() takes the per-node
> size from the default area, so a plain cma=4G on a multi-node machine
> feeds that size through the same local and loses every per-node area.
>
> numa_cma_size[] and pernuma_size_bytes are both phys_addr_t, so use it
> for the local too, and give early_numa_cma() separate variables for the
> node id and the size while in there.
>
> Fixes: d5cae2261b86 ("dma-contiguous: simplify numa cma area handling")
> Cc: stable@vger.kernel.org
> Assisted-by: Kiro:claude-opus-5
> Signed-off-by: Alexander Graf <graf@amazon.com>

Applied to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

