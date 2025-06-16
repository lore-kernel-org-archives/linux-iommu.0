Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5427E1DC
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069011; cv=none; b=OtNab3bGot/J8k0mo++JB+O8aAUKP2tZ/X14lvipkkwkhQz1ssSm8UbLew1+luDRlGhj0k/kSJoahFYjZTL2ibP5tVADWD2ZqzoClL84GFaLv8fkdwHOxqVmz8VQWxa2EQRaoGxjOXtldfl1vSeeSBCwa2dHCKtLAAna35yKa1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069011; c=relaxed/simple;
	bh=gBJpNY8IJHaShcKvSsKrq9I+5X+qpSCJeCfTUVZqS4c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNifGmRNwbbotbvP/Fvm0uHHBESfT4i9gP9b0s9omiADZSkXfwGXHnnmwynpSXv284Iu/y+k6UjgMRTzUV75CwXv0RqLk+A8OXqC6oVYC6PvOIE6s4f+gLplMXvnn7h2roK/0/0zJrQ2zkQwLkWPXWUOFFBHEgU8liAFmqDLDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bLQlw5yvJz6L5bl;
	Mon, 16 Jun 2025 18:12:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 41B5E140119;
	Mon, 16 Jun 2025 18:16:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Jun
 2025 12:16:45 +0200
Date: Mon, 16 Jun 2025 11:16:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [RESEND PATCH v4 4/4] selftests/dma: Add dma_map_sg support for
 dma_map_benchmark
Message-ID: <20250616111644.0000565b@huawei.com>
In-Reply-To: <20250614143454.2927363-5-xiaqinxin@huawei.com>
References: <20250614143454.2927363-1-xiaqinxin@huawei.com>
	<20250614143454.2927363-5-xiaqinxin@huawei.com>
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

On Sat, 14 Jun 2025 22:34:54 +0800
Qinxin Xia <xiaqinxin@huawei.com> wrote:

> Support for dma_map_sg, add option '-m' to distinguish mode.
> 
> i) Users can set option '-m' to select mode:
>    DMA_MAP_BENCH_SINGLE_MODE=0, DMA_MAP_BENCH_SG_MODE:=1
>    (The mode is also show in the test result).

shown

> ii) Users can set option '-g' to set sg_nents
>     (total count of entries in scatterlist)
>     the maximum number is 1024. Each of sg buf size is PAGE_SIZE.
>     e.g
>     [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
>     dma mapping mode: DMA_MAP_BENCH_SG_MODE
>     dma mapping benchmark: threads:8 seconds:30 node:-1
>     dir:FROM_DEVICE granule/sg_nents: 8
>     average map latency(us):1.4 standard deviation:0.3
>     average unmap latency(us):1.3 standard deviation:0.3
>     [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>     dma mapping mode: DMA_MAP_BENCH_SINGLE_MODE
>     dma mapping benchmark: threads:8 seconds:30 node:-1
>     dir:FROM_DEVICE granule/sg_nents: 8
>     average map latency(us):1.0 standard deviation:0.3
>     average unmap latency(us):1.3 standard deviation:0.5
> 
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
Looks fine to me.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  tools/testing/selftests/dma/dma_map_benchmark.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index b12f1f9babf8..c37cbc7e8766 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -27,6 +27,7 @@ int main(int argc, char **argv)
>  	int fd, opt;
>  	/* default single thread, run 20 seconds on NUMA_NO_NODE */
>  	int threads = 1, seconds = 20, node = -1;
> +	int map_mode = DMA_MAP_BENCH_SINGLE_MODE;
>  	/* default dma mask 32bit, bidirectional DMA */
>  	int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
>  	/* default granule 1 PAGESIZE */
> @@ -34,7 +35,7 @@ int main(int argc, char **argv)
>  
>  	int cmd = DMA_MAP_BENCHMARK;
>  
> -	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
> +	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:m:")) != -1) {
>  		switch (opt) {
>  		case 't':
>  			threads = atoi(optarg);
> @@ -57,11 +58,20 @@ int main(int argc, char **argv)
>  		case 'g':
>  			granule = atoi(optarg);
>  			break;
> +		case 'm':
> +			map_mode = atoi(optarg);
> +			break;
>  		default:
>  			return -1;
>  		}
>  	}
>  
> +	if (map_mode >= DMA_MAP_BENCH_MODE_MAX) {
> +		fprintf(stderr, "invalid map mode, DMA_MAP_BENCH_SINGLE_MODE:%d, DMA_MAP_BENCH_SG_MODE:%d\n",
> +			DMA_MAP_BENCH_SINGLE_MODE, DMA_MAP_BENCH_SG_MODE);
> +		exit(1);
> +	}
> +
>  	if (threads <= 0 || threads > DMA_MAP_MAX_THREADS) {
>  		fprintf(stderr, "invalid number of threads, must be in 1-%d\n",
>  			DMA_MAP_MAX_THREADS);
> @@ -111,13 +121,15 @@ int main(int argc, char **argv)
>  	map.dma_dir = dir;
>  	map.dma_trans_ns = xdelay;
>  	map.granule = granule;
> +	map.map_mode = map_mode;
>  
>  	if (ioctl(fd, cmd, &map)) {
>  		perror("ioctl");
>  		exit(1);
>  	}
>  
> -	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
> +	printf("dma mapping mode: %d\n", map_mode);
> +	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule/sg_nents: %d\n",
>  			threads, seconds, node, dir[directions], granule);
>  	printf("average map latency(us):%.1f standard deviation:%.1f\n",
>  			map.avg_map_100ns/10.0, map.map_stddev/10.0);

