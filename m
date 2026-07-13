Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F037BE71
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928021; cv=none; b=XIyszY0eUs5D9faP7PEYHxmsSed8pLf5kSkIo6OCbCA9CDOPvLXb4SJWDMow9300urWml9sDZZsyM/KoW3apqkuXtTt0oKzCd8IscJejcV4+ZTbcnF/nW+Ut7wXthxcdnR6TB+epqyfwR/NqIQE4rBBlg1ToWLr2Z2Lp+D4/j/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928021; c=relaxed/simple;
	bh=/VqTNl171P2oyUmMdoqYXXeMquCev8LDyEMRwxaHUeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=f7274ojVxf2bcAniDd89ZjjPA+mQGqmaIx6xBvkIN23E4oSYFE6oufNljCP5wg1AEIu8fBa4K0DsefwgGQ17A1qWtS6DV30WKlMHHw34TcNlasiT/e7ubC+4l6MonkW2XlUwQcSp4g2xSJf00vz1OKcP4MmcK886oU6YRxUPWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=I5zP54ov; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I5zP54ov"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260713073331euoutp01e86cbeff15044381172252c2c462fa80~ByRML-37J1331913319euoutp01g
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 07:33:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260713073331euoutp01e86cbeff15044381172252c2c462fa80~ByRML-37J1331913319euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783928011;
	bh=lBdi6xg8dh852tmXTVsoH2aRdscrAmHxScUv84+OrZw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=I5zP54ovpNMh0SaCtJaeHah1n67mCflqB0UOY6bdkIQexXonQtkwPP4akLd1XzCSi
	 q1/Uzv4knOklOYdY7I7jlfFyadhATmvZEnPU7hz+luspcRp+FZW1y5PsVCKxHdcaJS
	 hoiczQ7/OCy803a1kK7YiaVtpvB2DNFIojXCa8po=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260713073330eucas1p17916245e06678fa06aa97b79fd4be08b~ByRL83U9r0333803338eucas1p1c;
	Mon, 13 Jul 2026 07:33:30 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260713073330eusmtip24e0113d462c31bc2a51ad5dbb21c6522~ByRLg9-Q92101121011eusmtip2C;
	Mon, 13 Jul 2026 07:33:30 +0000 (GMT)
Message-ID: <5f49e2c3-a442-4aa3-82da-ffb4ca88fbdb@samsung.com>
Date: Mon, 13 Jul 2026 09:33:29 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] dma-coherent: use KiB in DMA allocation logs
To: Vova Sharaienko <sharaienko@google.com>, Robin Murphy
	<robin.murphy@arm.com>
Cc: android-mm@google.com, kernel-team@android.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260629223759.2637162-1-sharaienko@google.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260713073330eucas1p17916245e06678fa06aa97b79fd4be08b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260629223817eucas1p2313aed48a121788c92b6710f63ddb03f
X-EPHeader: CA
X-CMS-RootMailID: 20260629223817eucas1p2313aed48a121788c92b6710f63ddb03f
References: <CGME20260629223817eucas1p2313aed48a121788c92b6710f63ddb03f@eucas1p2.samsung.com>
	<20260629223759.2637162-1-sharaienko@google.com>

On 30.06.2026 00:37, Vova Sharaienko wrote:
> Update DMA reserved memory pool allocation log messages to display
> sizes in KiB instead of MiB. Using MiB caused allocations less than
> 1 MiB to be logged as 0 MiB due to integer truncation. KiB provides
> better precision for smaller memory regions specified in the Device Tree.
>
> Signed-off-by: Vova Sharaienko <sharaienko@google.com>


Applied to dma-mapping-for-next. Thanks!


> ---
> v1: https://lore.kernel.org/all/20260624000516.597555-1-sharaienko@google.com/
> Addressed feedback from v1: changed %ld to %llu for size in KiB
> to avoid truncation for sizes (which can be 64-bit on a 32-bit kernel)
> larger than 4 GiB.
>
>  kernel/dma/coherent.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index bcdc0f76d2e8..67f9a88ec4fe 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -69,8 +69,8 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
>  	kfree(dma_mem);
>  out_unmap_membase:
>  	memunmap(mem_base);
> -	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zd MiB\n",
> -		&phys_addr, size / SZ_1M);
> +	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zu KiB\n",
> +		&phys_addr, size / SZ_1K);
>  	return ERR_PTR(-ENOMEM);
>  }
>
> @@ -384,8 +384,8 @@ static int __init rmem_dma_setup(unsigned long node, struct reserved_mem *rmem)
>  	}
>  #endif
>
> -	pr_info("Reserved memory: created DMA memory pool at %pa, size %ld MiB\n",
> -		&rmem->base, (unsigned long)rmem->size / SZ_1M);
> +	pr_info("Reserved memory: created DMA memory pool at %pa, size %llu KiB\n",
> +		&rmem->base, (unsigned long long)(rmem->size / SZ_1K));
>  	return 0;
>  }
>
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

