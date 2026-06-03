Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FC36922D
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467686; cv=none; b=LTpoaRV35N6Yi3pv5MVUBZWSi1CrqQ1429R9ep9jhFtqdj6Bo48yjeDC2w1nUJHoMxbIqEwjz6n1OjVlgQ9Bt1ulNSc9r5H6UZwvJ0qLWGbpZEjuPKkfSFatFw5UmLx4GG6GAClnR3pGeUMBkqLbqPwPehgj6DblbfII4SMOlrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467686; c=relaxed/simple;
	bh=5VJ6Khi8jmUgeyzIr1tFCau/Jrd+cLfxO8pMX4vhNPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sxjk/pltXZe0AL31/oSwhnsr5fTPUipyIDUQKptcmviW9fUbLmBFxjhZLDDRfvT6l8NVH6VwA3KODNLxMaoqgvTkRFI83pLNVrGuYBRzAzAUgqNI3l/LOL89s5rNKs2RhcfzbUnsxLNKrT71mkGhZBzjckogoPbDUT/xSgTzFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QDBPOacv; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QDBPOacv"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260603062116euoutp0103cad0c8d06d58201978cf64fcc590a1~1fesvDI2A1469914699euoutp01o
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 06:21:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260603062116euoutp0103cad0c8d06d58201978cf64fcc590a1~1fesvDI2A1469914699euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780467676;
	bh=r4JAF/oGqqFivlMzuB/hWWVWZUT8LM53+f6ybQNbl9I=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=QDBPOacvtjOdBepRISsCGUG3J4LZ73kGHnZZ5oUWwbbwYSQuDqU8H0qsgUEGM4SlN
	 5moQ23wz37iDKnoQ/RKdAIat6HMkGpcRtlMC1oMGzhP56D7rQf22YyPAGdtRKuol9F
	 ffZWletH8wvvzX3mO+lfgP2PsztjzZoSlvqZp1WU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260603062116eucas1p230019365fe95968f0ebbb8ce336677c8~1fesXgLuf0291302913eucas1p2E;
	Wed,  3 Jun 2026 06:21:16 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260603062115eusmtip20fc38d45d9f8514c9ec7df14dd3ac4dc~1ferzQi2Q2813928139eusmtip2P;
	Wed,  3 Jun 2026 06:21:15 +0000 (GMT)
Message-ID: <1dffa3ef-ffb1-43e2-8042-be7b52bb1fb3@samsung.com>
Date: Wed, 3 Jun 2026 08:21:14 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCHv2] dma: map_benchmark: turn dma_sg_map_param buf into a
 flexible array
To: Rosen Penev <rosenp@gmail.com>, iommu@lists.linux.dev
Cc: Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>, Robin
	Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>,
	open "list:KERNEL" HARDENING "(not" covered by other
	"areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
	<linux-hardening@vger.kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260603031758.290538-1-rosenp@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260603062116eucas1p230019365fe95968f0ebbb8ce336677c8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260603031819eucas1p1fdc46c3987c9e47bc236286042ba8f29
X-EPHeader: CA
X-CMS-RootMailID: 20260603031819eucas1p1fdc46c3987c9e47bc236286042ba8f29
References: <CGME20260603031819eucas1p1fdc46c3987c9e47bc236286042ba8f29@eucas1p1.samsung.com>
	<20260603031758.290538-1-rosenp@gmail.com>

On 03.06.2026 05:17, Rosen Penev wrote:
> The buf pointer was kmalloc_array()'d immediately after the parent
> struct allocation, with the count (granule, validated to 1..1024 by
> the ioctl) trivially available beforehand.  Move buf to the struct
> tail as a flexible array member and fold the two allocations into a
> single kzalloc_flex(), dropping the kfree(params->buf) in both the
> prepare error path and unprepare.
>
> Add __counted_by for extra runtime analysis.
>
> Assisted-by: Claude:Opus-4.7
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Qinxin Xia <xiaqinxin@huawei.com>

Applied to dma-mapping-for-next, thanks!


> ---
>  v2: use params->npages in sg_alloc_table
>  kernel/dma/map_benchmark.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 29eeb5fdf199..fdc070f419f6 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -121,35 +121,35 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
>  struct dma_sg_map_param {
>  	struct sg_table sgt;
>  	struct device *dev;
> -	void **buf;
>  	u32 npages;
>  	u32 dma_dir;
> +	void *buf[] __counted_by(npages);
>  };
>  
>  static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
>  {
> +	struct dma_sg_map_param *params;
>  	struct scatterlist *sg;
> +	u32 npages;
>  	int i;
>  
> -	struct dma_sg_map_param *params = kzalloc(sizeof(*params), GFP_KERNEL);
> -
> -	if (!params)
> -		return NULL;
>  	/*
>  	 * Set the number of scatterlist entries based on the granule.
>  	 * In SG mode, 'granule' represents the number of scatterlist entries.
>  	 * Each scatterlist entry corresponds to a single page.
>  	 */
> -	params->npages = map->bparam.granule;
> +	npages = map->bparam.granule;
> +
> +	params = kzalloc_flex(*params, buf, npages);
> +	if (!params)
> +		return NULL;
> +
> +	params->npages = npages;
>  	params->dma_dir = map->bparam.dma_dir;
>  	params->dev = map->dev;
> -	params->buf = kmalloc_array(params->npages, sizeof(*params->buf),
> -				    GFP_KERNEL);
> -	if (!params->buf)
> -		goto out;
>  
>  	if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
> -		goto free_buf;
> +		goto free_params;
>  
>  	for_each_sgtable_sg(&params->sgt, sg, i) {
>  		params->buf[i] = (void *)__get_free_page(GFP_KERNEL);
> @@ -166,9 +166,7 @@ static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
>  		free_page((unsigned long)params->buf[i]);
>  
>  	sg_free_table(&params->sgt);
> -free_buf:
> -	kfree(params->buf);
> -out:
> +free_params:
>  	kfree(params);
>  	return NULL;
>  }
> @@ -183,7 +181,6 @@ static void dma_sg_map_benchmark_unprepare(void *mparam)
>  
>  	sg_free_table(&params->sgt);
>  
> -	kfree(params->buf);
>  	kfree(params);
>  }
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

