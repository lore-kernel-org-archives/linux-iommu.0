Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D078020B80B
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765183318; cv=none; b=EeOi1xtHlMrFtWoPF0V9gv01qvgia0zxhr304N4AXMlI6e4j5rKPJwXwik8x9GwOqhSk7dwRZsfK1YnL78/8TwbxKWLiB7V6y3ZJMvCqtW/Da2sVuFt8zry4PPFtUKBr5fHPMOtya8HhiVlxdhJiIadvj6bliuVKtlQdS4WO+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765183318; c=relaxed/simple;
	bh=AKbv7hmEHgd/h+oHnWfs/01InXeaddhkbh9lPOHhQL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=K7QofV0yWmMtI+dqsJTxFOrNOsgkSZUEaaRiziK3sgL34MH0VmomBwH4V4KqmPywteVplGcSzMNcKwZYHHKRucBaxehjK92A0vV8g360k8xAsqkiteKc0atNT6odTKIsu11RbnIRY+hhtKW3FAsA4ofqeAt/ffRqTOCb6jmJgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VlMwyr9i; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VlMwyr9i"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251208084154euoutp022b1d18a69e75964a8cabf1c0958249dd~-MN8u9JyN1096110961euoutp02m
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 08:41:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251208084154euoutp022b1d18a69e75964a8cabf1c0958249dd~-MN8u9JyN1096110961euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1765183314;
	bh=Comaw2YZFn1lYuHpF+XzVg5FtNQMnOeyuHWZyYaVQLg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=VlMwyr9iFs5XCQ3MXFtEvlv3GY66q8pa54En5q71VHCAglk0rCZO+hJltQD2MN7zk
	 Lx/xtY7F9dE1gX1EO3knwNEUWz3XL7zfrUWuFxKpauyo+07LdmE3XVka5HSwi/HsX7
	 tvYZnfopQeDOpKxlP+eNu3ObTS1AqzijHz/VX5+o=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251208084153eucas1p268d267a15d5581aae8d6451ec360ac76~-MN8j4-EY2594725947eucas1p2R;
	Mon,  8 Dec 2025 08:41:53 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251208084153eusmtip2eb67e3f07d21d5a2b7c3fcf3df993706~-MN8Hk55C1339613396eusmtip2l;
	Mon,  8 Dec 2025 08:41:53 +0000 (GMT)
Message-ID: <fc388df0-ab34-4a8d-a068-5376a3b7c81f@samsung.com>
Date: Mon, 8 Dec 2025 09:41:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma/pool: eliminate alloc_pages warning in
 atomic_pool_expand
To: Dave Kleikamp <dave.kleikamp@oracle.com>, Robin Murphy
	<robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251202152810.142370-1-dave.kleikamp@oracle.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251208084153eucas1p268d267a15d5581aae8d6451ec360ac76
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251202152846eucas1p201ac63a0baab0ac4ead2fb25fdbaf1e0
X-EPHeader: CA
X-CMS-RootMailID: 20251202152846eucas1p201ac63a0baab0ac4ead2fb25fdbaf1e0
References: <CGME20251202152846eucas1p201ac63a0baab0ac4ead2fb25fdbaf1e0@eucas1p2.samsung.com>
	<20251202152810.142370-1-dave.kleikamp@oracle.com>

On 02.12.2025 16:28, Dave Kleikamp wrote:
> atomic_pool_expand iterately tries the allocation while decrementing the
> page order. There is no need to issue a warning if an attempted
> allocation fails.
>
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

Fixes: d7e673ec2c8e ("dma-pool: Only allocate from CMA when in same 
memory zone")

Applied to dma-mapping-fixes branch with typo in commit message fixed.

> ---
>   kernel/dma/pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index ee45dee33d49..26392badc36b 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -93,7 +93,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   			page = dma_alloc_from_contiguous(NULL, 1 << order,
>   							 order, false);
>   		if (!page)
> -			page = alloc_pages(gfp, order);
> +			page = alloc_pages(gfp | __GFP_NOWARN, order);
>   	} while (!page && order-- > 0);
>   	if (!page)
>   		goto out;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

