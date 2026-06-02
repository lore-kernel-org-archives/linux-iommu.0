Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D53793CB;
	Tue,  2 Jun 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419161; cv=none; b=Gp5wNLW4bNvk3WY9cvKkxP2DFBdXvqj36VThM7mWMW7sIcvumfUhLGjUZLIH8K1555yVdiDk6QhCkJU1JpIKMDwVVYQ+ZVp/KS5VkVfp/DLdJc49oUe2jemb6G+4BwBRwnzI93TQw9ZLguW07pxkO8Qtx7ut2dfXRwETSAErJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419161; c=relaxed/simple;
	bh=MZg5xlfaZe2c3NW/NL+KbbyfpaQGrJTutc1FRzMdNvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvyWfZqYPJmy6Z29TIyJeUijVwAJ51XAn6JZm8MzShQyALMUDZmgyS2pv/XHpzSP/4FnHGuxRwd8QjpYM1KbTQjj66ttrjIDyUUEk3UYgDeb1J6D3ftZkthiKMQFppip6VQfacY+neviSB7565e9NqxZih7/OhuLR/EkdmQMPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2bkUhD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2bkUhD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4241F00893;
	Tue,  2 Jun 2026 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780419160;
	bh=lXQ0xBb2uV/cy6GFqv10Fq7wGDS1tDJr6eDAK2jyzL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b2bkUhD5eK60ZTOk8HI5lyFLhMPfIIm3aya54sr+Vtt1KLB/kPR/4jcduOIF1XZy0
	 SlSM+6BXD5rKxtF6X9vaEgeP5/+Z/kHQkbLiudZReASwmjfea7WmvYAWMOZEik6/ag
	 cM/vEvteIO0XGSlBZtP9TJ2vOhpgXcnUD5MMSot4BJXqAsUEI3NjDBYWUFcHmhrZ69
	 qOzesm3kkkqkUtI1hqniZzXubpaWxxKrpbRLdLq3XfZCGCDG7qnzUYfAG7IrPvOKP5
	 cqjP3nZlhCerzW1/zgOXR//V9mFYfnsT/kqT6FUbhNWuazO519intywX7puuZ0N/I7
	 9m5U4MS+BxOHQ==
Date: Tue, 2 Jun 2026 09:52:40 -0700
From: Kees Cook <kees@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: iommu@lists.linux.dev, Barry Song <baohua@kernel.org>,
	linusw@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] dma: map_benchmark: turn dma_sg_map_param buf into a
 flexible array
Message-ID: <202606020951.6AD1467B@keescook>
References: <20260525220628.94833-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525220628.94833-1-rosenp@gmail.com>

On Mon, May 25, 2026 at 03:06:28PM -0700, Rosen Penev wrote:
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
> ---
>  kernel/dma/map_benchmark.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 29eeb5fdf199..a65da5c7710c 100644
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
> -	if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
> -		goto free_buf;
> +	if (sg_alloc_table(&params->sgt, npages, GFP_KERNEL))

nit: I think it's better to use the params->npages here just because it
is obviously tied to params->sgt, and reduces code churn for this patch
(i.e. that line would be left alone).

Otherwise looks good.

-Kees

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
> -- 
> 2.54.0
> 

-- 
Kees Cook
