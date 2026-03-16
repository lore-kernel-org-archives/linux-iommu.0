Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902F34BA5A
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773645864; cv=none; b=tSZX7/6rUEbo55G1RJqY5YjoAwCzrr9O0nt3Rx7gDx2DBj64P0mBZtZRuLOJ9zLNuBrX2BN7ykDZFnwbJNilSLCeRZi5tIbcLe/XjHvW2Cg10fuKSglTf5D/1O3UX/XnH8W1iIUBqwHvJfmJQDb3G5FaaHk3qHuwNMl5YB+W9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773645864; c=relaxed/simple;
	bh=I4wj+BWrnoyEgsz9LT1ZC9/RvzprRBrb3JorKoQR7WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=e44ZrP5eCMAe/Fiabmp+nxQrwGiawpCJQvxL04GW4dCD1IyzrKml993l4ml7A2syNJB+9/hMN9/f3isakkwLXLhiUAxhY6aOU0xOiiULQZslUz7PuGAZyjUj3ZT/uHaXeMRtE+tRBdQLeRcenaAyKiF0I/AA0fQKYP3upDw5lyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Z1+KruBI; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z1+KruBI"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260316072413euoutp029fd4f7087401c7111c6bdb765c53fdae~dQYG0-yDv3136031360euoutp02i
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 07:24:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260316072413euoutp029fd4f7087401c7111c6bdb765c53fdae~dQYG0-yDv3136031360euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773645853;
	bh=uhwLCFj1K33dcEqv/kiFh30HJo0bl8qoV3C5IgbXAEE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Z1+KruBIiw+ApvkZId0hSluHfmdnIY9Owm3K8P0+xPVHAaK/bJFHPAgh8M3IlXHC0
	 JF6TTYRGs3luDLp6Y7McSCdy2lFPz4ntZMvx/t3fS7p2lWSd7NlkgWZs85XQwbbTbh
	 WBmhlpHDz/whDosr6YOixVSGAPie4sRA8MmC31N8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260316072413eucas1p19a5d7fa66dc5b41f46d1902cb1f23f4c~dQYGhJqwM1822818228eucas1p1f;
	Mon, 16 Mar 2026 07:24:13 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260316072412eusmtip27d300c8399f0712ba101524571c37dba~dQYFirlLa0581405814eusmtip2-;
	Mon, 16 Mar 2026 07:24:12 +0000 (GMT)
Message-ID: <7e7a708a-6238-416c-96e4-c1d46f6be528@samsung.com>
Date: Mon, 16 Mar 2026 08:24:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 0/5] dma-mapping: arm64: support batched cache sync
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, robin.murphy@arm.com, will@kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>, Leon
	Romanovsky <leon@kernel.org>, Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Anshuman
	Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>, Joerg Roedel <joro@8bytes.org>,
	Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Tangquan Zheng <zhengtangquan@oppo.com>,
	Huacai Zhou <zhouhuacai@oppo.com>, Xueyuan Chen <xueyuan.chen21@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <abRnUk-vfvS51FtW@arm.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260316072413eucas1p19a5d7fa66dc5b41f46d1902cb1f23f4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260228221143eucas1p12a276d4216b6ce0f3c374b093f73acd5
X-EPHeader: CA
X-CMS-RootMailID: 20260228221143eucas1p12a276d4216b6ce0f3c374b093f73acd5
References: <CGME20260228221143eucas1p12a276d4216b6ce0f3c374b093f73acd5@eucas1p1.samsung.com>
	<20260228221125.59863-1-21cnbao@gmail.com>
	<3ece80c7-697e-4d46-a6f8-49c07b0117a1@samsung.com>
	<abRnUk-vfvS51FtW@arm.com>

On 13.03.2026 20:36, Catalin Marinas wrote:
> On Tue, Mar 03, 2026 at 05:33:37PM +0100, Marek Szyprowski wrote:
>> On 28.02.2026 23:11, Barry Song wrote:
>>> From: Barry Song <baohua@kernel.org>
>>>
>>> Many embedded ARM64 SoCs still lack hardware cache coherency support, which
>>> causes DMA mapping operations to appear as hotspots in on-CPU flame graphs.
>>>
>>> For an SG list with *nents* entries, the current dma_map/unmap_sg() and DMA
>>> sync APIs perform cache maintenance one entry at a time. After each entry,
>>> the implementation synchronously waits for the corresponding region’s
>>> D-cache operations to complete. On architectures like arm64, efficiency can
>>> be improved by issuing all entries’ operations first and then performing a
>>> single batched wait for completion.
>>>
>>> Tangquan's results show that batched synchronization can reduce
>>> dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
>>> phone platform (MediaTek Dimensity 9500). The tests were performed by
>>> pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
>>> running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
>>> sg entries per buffer) for 200 iterations and then averaging the
>>> results.
>>>
>>> Thanks to Xueyuan for volunteering to take on the testing tasks. He
>>> put significant effort into validating paths such as IOVA link/unlink
>>> and SWIOTLB on RK3588 boards with NVMe.
>> Catalin, Will, I would like to merge this to dma-mapping tree, give Your
>> ack or comment if You are okay with ARM64 related parts.
> Sorry for the delay. Yes, feel free to pick them up. I doubt there would
> be any conflicts in this area with what I'm merging through the arm64
> tree.

Thanks, applied to dma-mapping-for-next.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

