Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E8D1C08
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 10:11:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99B042F4;
	Wed, 30 Aug 2023 03:12:14 -0700 (PDT)
Received: from [10.57.4.99] (unknown [10.57.4.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 761D93F64C;
	Wed, 30 Aug 2023 03:11:34 -0700 (PDT)
Message-ID: <a33702d2-6024-0129-588d-ce1a879f825c@arm.com>
Date: Wed, 30 Aug 2023 11:11:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dma-contiguous: fix the Kconfig entry for
 CONFIG_DMA_NUMA_CMA
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
 yajun.deng@linux.dev
Cc: iommu@lists.linux.dev
References: <20230830092731.148759-1-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230830092731.148759-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-08-30 10:27, Christoph Hellwig wrote:
> It makes no sense to expose CONFIG_DMA_NUMA_CMA if CONFIG_NUMA is not
> enabled, and random config options shouldn't be default unless there
> is a good reason.  Replace the default NUMA with a depends on to fix both
> issues.

I think the "good reason" is that folks who do have NUMA systems are 
likely to be more interested in getting more consistent DMA performance 
than losing a bit more non-movable memory capacity, and the runtime 
impact on non-NUMA systems should be negligible, so I would definitely 
be inclined to make it "default y". But it's not critically important.

For the fundamental dependency change which absolutely makes sense,

Reviewed-by: Robin Murphy <roin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 4c1e9a3c0ab6f0..f488997b071712 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -160,7 +160,7 @@ if  DMA_CMA
>   
>   config DMA_NUMA_CMA
>   	bool "Enable separate DMA Contiguous Memory Area for NUMA Node"
> -	default NUMA
> +	depends on NUMA
>   	help
>   	  Enable this option to get numa CMA areas so that NUMA devices
>   	  can get local memory by DMA coherent APIs.
