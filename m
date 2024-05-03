Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AF7153505
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739398; cv=none; b=PZG0tnICyo/DQ+yYVTD8g9GPsM4T5hNhWfyTvRV2ugH0jLKipJyx1yM5YIR8bZaCJhke8kr7ViKBt0V1R/6cLLS5d7dwnxdQhZG9c/syNPavoHc2J5GhlV5ZC7h0M8QpzCEQTjRcvju3jrA7rUAIFZfIhtXN7BeDGdKR6EDkbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739398; c=relaxed/simple;
	bh=9LBlAtBXIHHo+J7MWF9oeoqbPN0hFvzoulgQLJ7oDPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poJbt2RCg4R3Hex8QoSewfJFs2+WE3CO00Ak3SxgMhUqztVzY7O+HELmaqCneFXLeEH2XRUh82ajXrjiNge1sHM9bPhFpcD8z6pv/JhViO08mAQ9YUgGvDo9NVLDui9AxSwXoWTJW/c/30z3ZY/eg/5RSggsaQFPA0cnryioic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1FF2139F;
	Fri,  3 May 2024 05:30:19 -0700 (PDT)
Received: from [10.57.4.36] (unknown [10.57.4.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04F833F793;
	Fri,  3 May 2024 05:29:52 -0700 (PDT)
Message-ID: <3c474453-fc89-42b2-9ddc-fdc3a2893064@arm.com>
Date: Fri, 3 May 2024 13:29:23 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma-mapping: benchmark: fix up kthread creation error
 handling
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Xiang Chen <chenxiang66@hisilicon.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Barry Song <song.bao.hua@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
 lvc-project@linuxtesting.org
References: <20240502161827.403338-1-pchelkin@ispras.ru>
 <20240502161827.403338-2-pchelkin@ispras.ru>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240502161827.403338-2-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-02 5:18 pm, Fedor Pchelkin wrote:
> If a kthread creation fails for some reason then uninitialized members of
> the tasks array will be accessed on the error path since it is allocated
> by kmalloc_array().
> 
> Limit the bound in such case.

I don't think this is right... The put_task_struct() calls on the error 
path are supposed to balance the get_task_struct() calls which only 
happen *after* all the threads are successfully created - see commit 
d17405d52bac ("dma-mapping: benchmark: fix kernel crash when 
dma_map_single fails") - although I now wonder whether that might have 
been better done by replacing kthread_stop() with kthread_stop_put(). It 
doesn't look like we've ever actually tried to free any previous threads 
from the point of allocation failure.

Thanks,
Robin.

> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>   kernel/dma/map_benchmark.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 02205ab53b7e..ea938bc6c7e3 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -118,6 +118,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
>   		if (IS_ERR(tsk[i])) {
>   			pr_err("create dma_map thread failed\n");
>   			ret = PTR_ERR(tsk[i]);
> +			threads = i;
>   			goto out;
>   		}
>   
