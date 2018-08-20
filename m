From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] swiotlb: Fix uninitialized pointer on DMA ops
Date: Mon, 20 Aug 2018 11:00:29 +0100
Message-ID: <e6f42561-e47f-ae6a-a444-da007e88459f@arm.com>
References: <1534619091-14258-1-git-send-email-estebanzacr.20@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534619091-14258-1-git-send-email-estebanzacr.20@gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Esteban Zamora <estebanzacr.20@gmail.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 18/08/18 20:04, Esteban Zamora wrote:
> The mmap function pointer on swiotlb_dma_ops struct is
> uninitialized, which causes a random crash when calling
> the dma_mmap_coherent function on platforms where no DMA
> address translation hardware is available.

Can you share any kernel logs with details of those crashes? As Konrad 
mentions, the rules for partial structure initialisation in C are 
well-defined, even with designated initialisers[1], and if this commit 
message were true then half of the subsystems in the kernel would be 
crashing left right and centre.

Robin.

[1] 
https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html#Designated-Inits

> Set this pointer to NULL in order to fix the issue.
> 
> Signed-off-by: Esteban Zamora <estebanzacr.20@gmail.com>
> ---
>   kernel/dma/swiotlb.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 4f8a6db..9a7718c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1082,5 +1082,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
>   	.map_page		= swiotlb_map_page,
>   	.unmap_page		= swiotlb_unmap_page,
>   	.dma_supported		= dma_direct_supported,
> +	.mmap                   = NULL,
>   };
>   EXPORT_SYMBOL(swiotlb_dma_ops);
> 
