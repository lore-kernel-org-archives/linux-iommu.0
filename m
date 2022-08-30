Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC4625
	for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 09:24:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BD991474;
	Tue, 30 Aug 2022 02:24:03 -0700 (PDT)
Received: from [10.57.13.45] (unknown [10.57.13.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E28D3F766;
	Tue, 30 Aug 2022 02:23:56 -0700 (PDT)
Message-ID: <cd53526d-2564-996b-7b0d-d1fe9f114590@arm.com>
Date: Tue, 30 Aug 2022 10:23:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] swiotlb: fix a typo
Content-Language: en-GB
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Cc: hch@infradead.org, m.szyprowski@samsung.com
References: <20220826095046.880626-1-chao.gao@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220826095046.880626-1-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-08-26 10:50, Chao Gao wrote:
> "overwirte" isn't a word. It should be "overwrite".
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
> BTW, I am wondering if copying the original buffer to the tlb buffer
> unconditionally will leak the original buffer to the VMM, especially
> when VMM isn't trusted e.g., by confidential VMs. Would it be better
> to zero the tlb buffer for dir == DMA_FROM_DEVICE?

No, at the point of dma_map(), the buffer contents are owned by the 
caller, so if parts of that buffer are sensitive and shouldn't be 
exposed to DMA, then don't map the whole buffer for DMA. There are more 
DMA API implementations than SWIOTLB.

The whole point of bouncing the original contents here is that doing 
anything else effectively corrupts any part of the mapping that the 
device may end up *not* writing to - see the whole sordid original 
discussion (but don't be confused by the fact that the caller's original 
data happened to be zeros in that particular case).

Thanks,
Robin.

> 
>   kernel/dma/swiotlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c5a9190b218f..f67e5f50ee3c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -765,7 +765,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   	/*
>   	 * When dir == DMA_FROM_DEVICE we could omit the copy from the orig
>   	 * to the tlb buffer, if we knew for sure the device will
> -	 * overwirte the entire current content. But we don't. Thus
> +	 * overwrite the entire current content. But we don't. Thus
>   	 * unconditional bounce may prevent leaking swiotlb content (i.e.
>   	 * kernel memory) to user-space.
>   	 */
