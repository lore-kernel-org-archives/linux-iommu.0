Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E5F14BF92;
	Mon, 12 Jan 2026 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221845; cv=none; b=Gy0+TF56kazObBdjF7nNqu9x1Ibyau9jkK5/1rhNULf8RNSEHSlVwPUoBZZcGgx43yPPyOACf475/KUbH4UqY9bQ4bTfkj8l6AXIWYLvJFN5vUe8cNRcJdhOSe5qvx0z5vsKiwbKl7B3VQ270RFWP3gM8Nbi1A+LSrWsRVieaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221845; c=relaxed/simple;
	bh=sO5CSior1ucRCEHEADA1y2VLnkOozIkNZWAX5rabVpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvtbOpxermdYuQXAwu4UIfpZvL2SFSdc6ZuK12KBL4ERT++5le3iR/O3HM2BFSlxfw4JnJynv9FKfPCekAsro/G5TQu38+UXJT2ew0EnM+Ldk/r/WXNyiGMX2Vmi/1PP1XIvMD7P8zIx4D12XKJbGnaa0lTiSfzhyOIWijnAgCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0F33497;
	Mon, 12 Jan 2026 04:43:56 -0800 (PST)
Received: from [10.57.48.115] (unknown [10.57.48.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3C243F59E;
	Mon, 12 Jan 2026 04:44:00 -0800 (PST)
Message-ID: <03daf175-fcab-45a4-812b-9a338415565e@arm.com>
Date: Mon, 12 Jan 2026 12:43:53 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-pool: don't allocate DMA32 pool if no 32-bit
 memory
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, lkp@intel.com,
 mick@ics.forth.gr, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 akpm@linux-foundation.org, alex@ghiti.fr, aou@eecs.berkeley.edu,
 hch@infradead.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com
References: <202601120747.TAMpIDnI-lkp@intel.com>
 <20260112065857.3137331-1-vladimir.kondratiev@mobileye.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260112065857.3137331-1-vladimir.kondratiev@mobileye.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-12 6:58 am, Vladimir Kondratiev wrote:
> If system have no 32-bit memory, GFP_DMA32 pool allocation will
> obviously fail, so skip it.

Note that the rest of the code doesn't quite work right if 
CONFIG_ZONE_DMA32 is enabled but atomic_pool_dma32 is NULL - seems such 
a setup wasn't really anticipated. Funnily enough, I also recently wrote 
a patch series to improve this more generally, but hadn't got round to 
writing a cover letter yet - lemme finish that up and post it...

Thanks,
Robin.

> Changes in v2: use arch-independent "memblock_start_of_DRAM" to get
> DRAM base address
> 
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> ---
>   kernel/dma/pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index ee45dee33d49..ecd77a0272f2 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -209,7 +209,7 @@ static int __init dma_atomic_pool_init(void)
>   		if (!atomic_pool_dma)
>   			ret = -ENOMEM;
>   	}
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
> +	if (IS_ENABLED(CONFIG_ZONE_DMA32) && memblock_start_of_DRAM() < BIT_ULL(32)) {
>   		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
>   						GFP_KERNEL | GFP_DMA32);
>   		if (!atomic_pool_dma32)
> 
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449

