Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB2148838
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750068945; cv=none; b=gs1TSI8M9QzbFE252J5/ndFUptmP1vccIpTSQGwncoL+0mCdRUDC+LA2alDkZDbl273N4r5XAZvibiFaGMFpaz/zn86wl4NVoVOlX/wfevMEt5U03rNIG8vTK243WrsFDGKtUKKZaknEcLxSIU1KdhgD/WiBiboFoyWufNPbZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750068945; c=relaxed/simple;
	bh=VXr2AwR/uu7FdFB8EglkTnK7zEK8oCdqat8A4Ajh8pI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHIgnYYQP54o670JfCHqkcsC9hU+JUgEFD97gDgxUO8hvG5zGKYbuZ6H0bBE28my+eWBb4rfSBTMbANeshqKO2Sk4rQl867f+Mx2VVa/tSViHkGdEpgCJHBz9oviDiXDRk4gQX/UR5ZFttHc7zQAf4S4xNjkVJScEBojQUCe3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bLQqK0PP5z6M4bq;
	Mon, 16 Jun 2025 18:15:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1299C14050C;
	Mon, 16 Jun 2025 18:15:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Jun
 2025 12:15:40 +0200
Date: Mon, 16 Jun 2025 11:15:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [RESEND PATCH v4 3/4] dma-mapping: benchmark: add support for
 dma_map_sg
Message-ID: <20250616111538.00007ff3@huawei.com>
In-Reply-To: <20250614143454.2927363-4-xiaqinxin@huawei.com>
References: <20250614143454.2927363-1-xiaqinxin@huawei.com>
	<20250614143454.2927363-4-xiaqinxin@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 14 Jun 2025 22:34:53 +0800
Qinxin Xia <xiaqinxin@huawei.com> wrote:

> Support for dma scatter-gather mapping and is intended for testing
> mapping performance. It achieves by introducing the dma_sg_map_param
> structure and related functions, which enable the implementation of
> scatter-gather mapping preparation, mapping, and unmapping operations.
> Additionally, the dma_map_benchmark_ops array is updated to include
> operations for scatter-gather mapping. This commit aims to provide
> a wider range of mapping performance test to cater to different scenarios.
> 
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
Main thing here is don't do the docs format in a patch that makes
real changes. That hides what is really going on and makes review
harder!

Jonathan

> ---
>  include/linux/map_benchmark.h |  43 ++++++++++----
>  kernel/dma/map_benchmark.c    | 103 ++++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
> index 020b3155c262..9e8ec59e027a 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -17,22 +17,41 @@
>  
>  enum {
>  	DMA_MAP_BENCH_SINGLE_MODE,
> +	DMA_MAP_BENCH_SG_MODE,
>  	DMA_MAP_BENCH_MODE_MAX
>  };
>  
> +/**
> + * struct map_benchmark - Benchmarking data for DMA mapping operations.
> + * @avg_map_100ns: Average map latency in 100ns.
> + * @map_stddev: Standard deviation of map latency.
> + * @avg_unmap_100ns: Average unmap latency in 100ns.
> + * @unmap_stddev: Standard deviation of unmap latency.
> + * @threads: Number of threads performing map/unmap operations in parallel.
> + * @seconds: Duration of the test in seconds.
> + * @node: NUMA node on which this benchmark will run.
> + * @dma_bits: DMA addressing capability.
> + * @dma_dir: DMA data direction.
> + * @dma_trans_ns: Time for DMA transmission in ns.
> + * @granule: Number of PAGE_SIZE units to map/unmap at once.
> +	     In SG mode, this represents the number of scatterlist entries.
> +	     In single mode, this represents the total size of the mapping.
> + * @map_mode: Mode of DMA mapping.
> + * @expansion: Reserved for future use.
> + */
>  struct map_benchmark {
> -	__u64 avg_map_100ns; /* average map latency in 100ns */
> -	__u64 map_stddev; /* standard deviation of map latency */
> -	__u64 avg_unmap_100ns; /* as above */
> +	__u64 avg_map_100ns;

Do this docs format change in a precursor patch.  As done here
we can't see easily what changed in adding the dma_map_sg support.


> +	__u64 map_stddev;
> +	__u64 avg_unmap_100ns;
>  	__u64 unmap_stddev;
> -	__u32 threads; /* how many threads will do map/unmap in parallel */
> -	__u32 seconds; /* how long the test will last */
> -	__s32 node; /* which numa node this benchmark will run on */
> -	__u32 dma_bits; /* DMA addressing capability */
> -	__u32 dma_dir; /* DMA data direction */
> -	__u32 dma_trans_ns; /* time for DMA transmission in ns */
> -	__u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
> -	__u8  map_mode; /* the mode of dma map */
> -	__u8 expansion[75];     /* For future use */
> +	__u32 threads;
> +	__u32 seconds;
> +	__s32 node;
> +	__u32 dma_bits;
> +	__u32 dma_dir;
> +	__u32 dma_trans_ns;
> +	__u32 granule;
> +	__u8  map_mode;
> +	__u8 expansion[75];
>  };
>  #endif /* _KERNEL_DMA_BENCHMARK_H */
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 05f85cf00c35..843be4dc0993 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/timekeeping.h>
>  
> @@ -111,8 +112,110 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
>  	.do_unmap = dma_single_map_benchmark_do_unmap,
>  };
>  
> +struct dma_sg_map_param {
> +	struct sg_table sgt;
> +	struct device *dev;
> +	void **buf;
> +	u32 npages;
> +	u32 dma_dir;
> +};
> +
> +static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
> +{
> +	struct scatterlist *sg;
> +	int i;
> +
> +	struct dma_sg_map_param *params __free(kfree) = kzalloc(sizeof(*params), GFP_KERNEL);

I'd keep style of previous patch and break this long line.

The mix of cleanup.h and gotos is sometimes problematic. I'm not sure I'd
bother the the __free() in this case as the benefit is really small.


> +	if (!params)
> +		return NULL;
> +
> +	/*
> +	 * Set the number of scatterlist entries based on the granule.
> +	 * In SG mode, 'granule' represents the number of scatterlist entries.
> +	 * Each scatterlist entry corresponds to a single page.
> +	 */
> +	params->npages = map->bparam.granule;
> +	params->dma_dir = map->bparam.dma_dir;
> +	params->dev = map->dev;
> +	params->buf = kmalloc_array(params->npages, sizeof(*params->buf),
> +				    GFP_KERNEL);
> +	if (!params->buf)
> +		goto out;
> +
> +	if (sg_alloc_table(&params->sgt, params->npages, GFP_KERNEL))
> +		goto free_buf;
> +
> +	for_each_sgtable_sg(&params->sgt, sg, i) {
> +		params->buf[i] = (void *)__get_free_page(GFP_KERNEL);
> +		if (!params->buf[i])
> +			goto free_page;
> +
> +		if (params->dma_dir != DMA_FROM_DEVICE)
> +			memset(params->buf[i], 0x66, PAGE_SIZE);

As in the previous - not sure this has the affect we want if
we are doing multiple loops in the thread.

> +
> +		sg_set_buf(sg, params->buf[i], PAGE_SIZE);
> +	}
> +
> +	return_ptr(params);
> +
> +free_page:
> +	while (i-- > 0)
> +		free_page((unsigned long)params->buf[i]);
> +
> +	sg_free_table(&params->sgt);
> +free_buf:
> +	kfree(params->buf);
> +out:

A label where there is nothing to do is usually better handled
with early returns in the error paths.  Those are easier to
review as reader doesn't need to go look for where anything is
done.


> +	return NULL;
> +}

> +static int dma_sg_map_benchmark_do_map(void *mparam)
> +{
> +	struct dma_sg_map_param *params = mparam;
> +	int ret = 0;
> +
> +	int sg_mapped = dma_map_sg(params->dev, params->sgt.sgl,
> +				   params->npages, params->dma_dir);
> +	if (!sg_mapped) {
> +		pr_err("dma_map_sg failed on %s\n", dev_name(params->dev));
> +		ret = -ENOMEM;
Similar comments to those in previous patch apply here as well.

> +	}
> +
> +	return ret;
> +}


