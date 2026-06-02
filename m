Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741003EB809
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415433; cv=none; b=keip6k2I7dadNmR656Z18RVNGSdaifjtbnolSk4kdL1FYftvCeVp4hN5XUyii8C5EFJPRX0F+XASigK21AoRCiX6CDPaLSSNR528RpsE6J86iTRFwW3WykO2eB1KdR6VLYwzebb1c30U0xZB7THuj9o0f/8VwxkAVomW6Wh3CTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415433; c=relaxed/simple;
	bh=M3Ybb3enQGQhWqNqM1yR4OAbLYbobj8ZPoSt+4++ri8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nd0r5XWnRJyGTXtg2XxjjRzYq4ITrPzhfCYm6YRW+2+FFA/7RWkgHx/kS3M9gokxNclzCJTAEx/vufq+stCcHvzgcgFT6qLh9Wg2Suwqt5losLHOHmffOpTxuusAnEYoHWsX96QWMolH+baT5JC9NEOt5LUukprw7ZK88IW5x4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6Dda8bYH; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6Dda8bYH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hU62HGQ7xHtEKciM/4KTgYEwj/sAX7Xh5dGMtfI9phA=;
	b=6Dda8bYHhb0K6wsqNpm/ksgvRIuy5OetQtbJMwbF31Qgdx+FeJ3BL4Pl3NwH7vH1MMzCqtcdI
	dtQPyRSp2nSvM/i1UKO/UKwCvOpBYh7p7NDxiwkX3q7OABtXsBTR7CkvkqZpYImpRAm8RXXW2VL
	IQWxN1m35OY8FhdY0IWLeA0=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gVFSv5bCqzcZxm;
	Tue,  2 Jun 2026 23:42:23 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id BBF5940538;
	Tue,  2 Jun 2026 23:50:21 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 23:50:21 +0800
Message-ID: <d78c453a-1edf-42b2-9ac8-cab6cc0305c5@huawei.com>
Date: Tue, 2 Jun 2026 23:50:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: map_benchmark: turn dma_sg_map_param buf into a
 flexible array
To: Rosen Penev <rosenp@gmail.com>, <iommu@lists.linux.dev>
CC: Barry Song <baohua@kernel.org>, <linusw@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not covered by
 other areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
	<linux-hardening@vger.kernel.org>
References: <20260525220628.94833-1-rosenp@gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20260525220628.94833-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200003.china.huawei.com (7.202.194.15)



在 2026/5/26 6:06, Rosen Penev 写道:
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
>   kernel/dma/map_benchmark.c | 29 +++++++++++++----------------
>   1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 29eeb5fdf199..a65da5c7710c 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -121,35 +121,35 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
>   struct dma_sg_map_param {
>   	struct sg_table sgt;
>   	struct device *dev;
> -	void **buf;
>   	u32 npages;
>   	u32 dma_dir;
> +	void *buf[] __counted_by(npages);
>   };
>   
>   static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
>   {
> +	struct dma_sg_map_param *params;
>   	struct scatterlist *sg;
> +	u32 npages;
>   	int i;
>   
> -	struct dma_sg_map_param *params = kzalloc(sizeof(*params), GFP_KERNEL);
> -
> -	if (!params)
> -		return NULL;
>   	/*
>   	 * Set the number of scatterlist entries based on the granule.
>   	 * In SG mode, 'granule' represents the number of scatterlist entries.
>   	 * Each scatterlist entry corresponds to a single page.
>   	 */
> -	params->npages = map->bparam.granule;
> +	npages = map->bparam.granule;
> +
> +	params = kzalloc_flex(*params, buf, npages);
> +	if (!params)
> +		return NULL;
> +
> +	params->npages = npages;
>   	params->dma_dir = map->bparam.dma_dir;
>   	params->dev = map->dev;
> -	params->buf = kmalloc_array(params->npages, sizeof(*params->buf),
> -				    GFP_KERNEL);
> -	if (!params->buf)
> -		goto out;
>   
> -	if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
> -		goto free_buf;
> +	if (sg_alloc_table(&params->sgt, npages, GFP_KERNEL))
> +		goto free_params;
>   
>   	for_each_sgtable_sg(&params->sgt, sg, i) {
>   		params->buf[i] = (void *)__get_free_page(GFP_KERNEL);
> @@ -166,9 +166,7 @@ static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
>   		free_page((unsigned long)params->buf[i]);
>   
>   	sg_free_table(&params->sgt);
> -free_buf:
> -	kfree(params->buf);
> -out:
> +free_params:
>   	kfree(params);
>   	return NULL;
>   }
> @@ -183,7 +181,6 @@ static void dma_sg_map_benchmark_unprepare(void *mparam)
>   
>   	sg_free_table(&params->sgt);
>   
> -	kfree(params->buf);
>   	kfree(params);
>   }
>   

Thanks for the patch.

Sorry for the delay — your email was unfortunately flagged as phishing
and almost missed. I suspect the issue was the Cc list containing
descriptive text.

It's a nice clean code.
I've tested it on Kunpeng 920, and it looks good.
Feel free to add my Reviewed-by:
Reviewed-by: Qinxin Xia <xiaqinxin@huawei.com>

-- 
Thanks,
Qinxin

