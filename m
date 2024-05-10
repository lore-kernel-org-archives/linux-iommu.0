Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9518037
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362524; cv=none; b=frqyN/x7SXYG9hjmnJK0f2O3h1oy8s/1gk4VJUkv5fIA1dCHEw3RsLiItRO5qpXKOgtfcAum/rUICwUgsS324vbBSWdVQu30zoPVHTW2T9JLcbfsASu2PJIf4Td9r4/gmgSl5HzAodr12HaWw6FKnaZJExdInfyS3V7HPbMDAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362524; c=relaxed/simple;
	bh=TO8LzxCyAm4C6o8aGLw9P7lWmy9CduRS+UXiITsLWkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijgyfVTDmmANRrVyKTiq2Ki/ffrDP/6Q+ys+dBV2JAafvx4gSALPAvPm+iKBPELeaPeMt9kE28XxNasWl+wyOuwcwecTc4/nBfgTfPpeAiJGBNLvOJjqjthBpRvbtc1hBcIExAd7lcQu9p/ig0OnDkndfA6OP/C/P5gLsGRYuwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91CAC106F;
	Fri, 10 May 2024 10:35:46 -0700 (PDT)
Received: from [10.57.3.158] (unknown [10.57.3.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13AC03F6A8;
	Fri, 10 May 2024 10:35:18 -0700 (PDT)
Message-ID: <11456e13-23f8-43f7-8ffd-cd4e4ff825d7@arm.com>
Date: Fri, 10 May 2024 18:35:17 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dma-mapping: benchmark: fix up kthread-related
 error handling
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Xiang Chen <chenxiang66@hisilicon.com>, Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
 lvc-project@linuxtesting.org
References: <20240504114713.567164-1-pchelkin@ispras.ru>
 <20240504114713.567164-2-pchelkin@ispras.ru>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240504114713.567164-2-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-04 12:47 pm, Fedor Pchelkin wrote:
> kthread creation failure is invalidly handled inside do_map_benchmark().
> The put_task_struct() calls on the error path are supposed to balance the
> get_task_struct() calls which only happen after all the kthreads are
> successfully created. Rollback using kthread_stop() for already created
> kthreads in case of such failure.
> 
> In normal situation call kthread_stop_put() to gracefully stop kthreads
> and put their task refcounts. This should be done for all started
> kthreads.

Although strictly there were two overlapping bugs here, I'd agree that 
it really doesn't seem worth the bother of trying to distinguish them. 
I'm far from a kthread expert, but as best I can tell this looks like it 
achieves a sensible final state. Modulo one nit below,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>   kernel/dma/map_benchmark.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 02205ab53b7e..2478957cf9f8 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -118,6 +118,8 @@ static int do_map_benchmark(struct map_benchmark_data *map)
>   		if (IS_ERR(tsk[i])) {
>   			pr_err("create dma_map thread failed\n");
>   			ret = PTR_ERR(tsk[i]);
> +			while (--i >= 0)
> +				kthread_stop(tsk[i]);

I think this means we'd end up actually starting the threads purely to 
get them to see the KTHREAD_SHOULD_STOP flag and exit again? Not that 
I'm too fussed about optimising an unexpected error path, however I 
can't help but wonder if we might only need a put_task_struct() if we 
can safely assume that the threads have never been started at this point.

Thanks,
Robin.

>   			goto out;
>   		}
>   
> @@ -139,13 +141,17 @@ static int do_map_benchmark(struct map_benchmark_data *map)
>   
>   	msleep_interruptible(map->bparam.seconds * 1000);
>   
> -	/* wait for the completion of benchmark threads */
> +	/* wait for the completion of all started benchmark threads */
>   	for (i = 0; i < threads; i++) {
> -		ret = kthread_stop(tsk[i]);
> -		if (ret)
> -			goto out;
> +		int kthread_ret = kthread_stop_put(tsk[i]);
> +
> +		if (kthread_ret)
> +			ret = kthread_ret;
>   	}
>   
> +	if (ret)
> +		goto out;
> +
>   	loops = atomic64_read(&map->loops);
>   	if (likely(loops > 0)) {
>   		u64 map_variance, unmap_variance;
> @@ -170,8 +176,6 @@ static int do_map_benchmark(struct map_benchmark_data *map)
>   	}
>   
>   out:
> -	for (i = 0; i < threads; i++)
> -		put_task_struct(tsk[i]);
>   	put_device(map->dev);
>   	kfree(tsk);
>   	return ret;
