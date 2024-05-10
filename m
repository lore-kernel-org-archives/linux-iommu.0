Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5B11B285
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363584; cv=none; b=iljwfg0S/Y9tjYUQrftqfcpuYScg84YXOuk7wncuRDyyfY2j9wFCk7/TuPv5F+V6Ura43P1wQNhugJ//i9BhNIzLGS98t62z8WR5oMpcFnVEuZscvIVBydEZkjtLIEuGQVlj7UUFVLbQ3Q2Gh2b3jAEXJqMqJz5uDgXFygi6F5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363584; c=relaxed/simple;
	bh=q3TrzDS55l9J6UMQ36bleJhhFObCuaaoaHrIrZTYPyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsKbXPGTOYgiGq1G6OgMSM4FJS3ceLR8QoqOKuQWT3+oT1ksl5knYT8XKWqoUgRF4ITodhEvxxRgZSJdH9Qshc5FgoYlnA5G9DV8t7XVBNDgInAF/nIbJJxc4LrmL+ku8frdOj7RywzpNjoj2TARf3thm/BMlI68iYJ5M5Yykl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E918F339;
	Fri, 10 May 2024 10:53:25 -0700 (PDT)
Received: from [10.57.3.158] (unknown [10.57.3.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88BE83F6A8;
	Fri, 10 May 2024 10:52:58 -0700 (PDT)
Message-ID: <7dd13232-b5c0-42b1-b096-f374dd9bef85@arm.com>
Date: Fri, 10 May 2024 18:52:56 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dma-mapping: benchmark: avoid needless
 copy_to_user if benchmark fails
To: Fedor Pchelkin <pchelkin@ispras.ru>,
 Xiang Chen <chenxiang66@hisilicon.com>, Barry Song <21cnbao@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
 lvc-project@linuxtesting.org
References: <20240504114713.567164-1-pchelkin@ispras.ru>
 <20240504114713.567164-3-pchelkin@ispras.ru>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240504114713.567164-3-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-04 12:47 pm, Fedor Pchelkin wrote:
> If do_map_benchmark() has failed, there is nothing useful to copy back
> to userspace.

I guess there could be some valid partial data if for instance it failed 
due to OOM in the middle of running, but the standard tool is still 
going to ignore that if the ioctl() returns an error, so meh.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Suggested-by: Barry Song <21cnbao@gmail.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>   kernel/dma/map_benchmark.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 2478957cf9f8..a6edb1ef98c8 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -256,6 +256,9 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
>   		 * dma_mask changed by benchmark
>   		 */
>   		dma_set_mask(map->dev, old_dma_mask);
> +
> +		if (ret)
> +			return ret;
>   		break;
>   	default:
>   		return -EINVAL;
