Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427C24BD1A
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047566; cv=none; b=omejAieSHE5AWD0htXV/1eQGYyhkQlJXoBgiXv1yJOPIOENyaGi2IurFxisPntiE+Q4ZzCV9Nwp/aVRyWL9NaKvy/6q/O7pgaMTwGSlVmQCmQjGQakWuhxIwEv/FUCtVN6+ztTqRm6RCudfDr0NzNeVLqTxTUUz6e1kY12K932c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047566; c=relaxed/simple;
	bh=jo23qPItnlEzMgqpMtVGVo3K+RTTxPVFAmNH6S6L53Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ehq4tnrH2b4+02zP5n2Jj6nDOKLuQuLxIMlEb4z/iy/T70zGe62//9kf0b0Ypha2TcHSY5PpTh8nkNpqBMOnvimnXg4uM14M2si4kYQAN1kd4685yY1D0Hvk7HJQgOJpywqS2s6cwzVGwdTM9+l0n9gTDs94TQ6jM4z3sbhHUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EL2X1FVw; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EL2X1FVw"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260202155235euoutp0160cbd75df0d7afd34704eb518a978f19~QeN_KApF22033420334euoutp018
	for <iommu@lists.linux.dev>; Mon,  2 Feb 2026 15:52:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260202155235euoutp0160cbd75df0d7afd34704eb518a978f19~QeN_KApF22033420334euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770047555;
	bh=RkDBu9CM99vQqf9gHCXw5QKe3qh04l6wgdBpEQftz+o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EL2X1FVwU6ofr1LgNGNo1dE1IKCnRfI5HZIc/6VU8nxgf1YtOi5tna7plbYlL8nPX
	 FXlJXQNYivYOzvjEKXpExfmZY2C0iHHc8jtkUWDATP+TTb0wPyE26Wmf8MC/dAkQnH
	 pFWyzS+N0aakufVwGG3MC29qHTq+5zhREQTHQCts=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260202155234eucas1p1f79765448f3cf78b815c8c0e216afd9e~QeN9eiKSN1284312843eucas1p1h;
	Mon,  2 Feb 2026 15:52:34 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260202155233eusmtip1a49146c8d9bd6a6b342b9c6c51d82cef~QeN9GRlou1750917509eusmtip1E;
	Mon,  2 Feb 2026 15:52:33 +0000 (GMT)
Message-ID: <6e57194b-3cb0-4593-af9f-075f1807dd6a@samsung.com>
Date: Mon, 2 Feb 2026 16:52:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma: contiguous: Check return value of
 dma_contiguous_reserve_area()
To: Shanker Donthineni <sdonthineni@nvidia.com>, Maxime Ripard
	<mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, "T . J . Mercier"
	<tjmercier@google.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260129181317.2429196-1-sdonthineni@nvidia.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260202155234eucas1p1f79765448f3cf78b815c8c0e216afd9e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260129181410eucas1p2860c5d8fe66dfcaa98b29d5fa1f0b623
X-EPHeader: CA
X-CMS-RootMailID: 20260129181410eucas1p2860c5d8fe66dfcaa98b29d5fa1f0b623
References: <CGME20260129181410eucas1p2860c5d8fe66dfcaa98b29d5fa1f0b623@eucas1p2.samsung.com>
	<20260129181317.2429196-1-sdonthineni@nvidia.com>

On 29.01.2026 19:13, Shanker Donthineni wrote:
> Commit 8f1fc1bf1a3d ("dma: contiguous: Reserve default CMA heap")
> introduced a bug where dma_heap_cma_register_heap() is called with
> a NULL pointer when dma_contiguous_reserve_area() fails to reserve
> the CMA area.
>
> When dma_contiguous_reserve_area() fails, dma_contiguous_default_area
> remains NULL (initialized as a global variable), but the code doesn't
> check the return value and proceeds to call dma_heap_cma_register_heap()
> with this NULL pointer.
>
> Later during boot, add_cma_heaps() iterates through the dma_areas[]
> array and attempts to register heaps. When it encounters the NULL
> pointer stored by the earlier call, it crashes in __add_cma_heap()
> -> dma_heap_add() when trying to dereference the NULL CMA pointer.
>
> The crash manifests as:
>    Unable to handle kernel NULL pointer dereference at virtual address
>    0000000000000038
>    ...
>    Call trace:
>     dma_heap_add+0x40/0x2b0
>     __add_cma_heap+0x80/0xe0
>     add_cma_heaps+0x64/0xb0
>     do_one_initcall+0x60/0x318
>     kernel_init_freeable+0x260/0x2f0
>     kernel_init+0x2c/0x168
>     ret_from_fork+0x10/0x20
>
> Fix this by checking the return value of dma_contiguous_reserve_area()
> and only calling dma_heap_cma_register_heap() when the reservation
> succeeds.
>
> Fixes: 8f1fc1bf1a3d ("dma: contiguous: Reserve default CMA heap")
> Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
Applied to dma-mapping-fixes, thanks!
> ---
>   kernel/dma/contiguous.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index d8fd6f779f797..92c539d76412b 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -247,10 +247,12 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>   		pr_debug("%s: reserving %ld MiB for global area\n", __func__,
>   			 (unsigned long)selected_size / SZ_1M);
>   
> -		dma_contiguous_reserve_area(selected_size, selected_base,
> -					    selected_limit,
> -					    &dma_contiguous_default_area,
> -					    fixed);
> +		ret = dma_contiguous_reserve_area(selected_size, selected_base,
> +						  selected_limit,
> +						  &dma_contiguous_default_area,
> +						  fixed);
> +		if (ret)
> +			return;
>   
>   		ret = dma_heap_cma_register_heap(dma_contiguous_default_area);
>   		if (ret)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

