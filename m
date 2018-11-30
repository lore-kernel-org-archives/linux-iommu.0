From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
Date: Fri, 30 Nov 2018 19:39:50 +0000
Message-ID: <b22d2ad6-2638-96d7-1df2-24701589202f@arm.com>
References: <20181130175449.2625-1-cai@gmx.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130175449.2625-1-cai@gmx.us>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Qian Cai <cai@gmx.us>, hch@lst.de, m.szyprowski@samsung.com
Cc: netdev@vger.kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, yisen.zhuang@huawei.com
List-Id: iommu@lists.linux-foundation.org

On 30/11/2018 17:54, Qian Cai wrote:
> The amount of DMA mappings from Hisilicon HNS ethernet devices is huge,
> so it could trigger "DMA-API: debugging out of memory - disabling".
> 
> hnae_get_handle [1]
>    hnae_init_queue
>      hnae_init_ring
>        hnae_alloc_buffers [2]
>          debug_dma_map_page
>            dma_entry_alloc
> 
> [1] for (i = 0; i < handle->q_num; i++)
> [2] for (i = 0; i < ring->desc_num; i++)
> 
> On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
> already,
> 
> 4 (ports) x 16 (handles) x 1024 (rings) = 65536
> 
> Added a Kconfig entry for PREALLOC_DMA_DEBUG_ENTRIES, so make it easier
> for users to deal with special cases like this.
> 
> Signed-off-by: Qian Cai <cai@gmx.us>
> ---
>   kernel/dma/debug.c | 9 ++-------
>   lib/Kconfig.debug  | 9 +++++++++
>   2 files changed, 11 insertions(+), 7 deletions(-)

Oh, right, the arch overrides actually got cleaned up already. I'd 
forgotten that...

> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 231ca4628062..3752fb23f72f 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -41,11 +41,6 @@
>   #define HASH_FN_SHIFT   13
>   #define HASH_FN_MASK    (HASH_SIZE - 1)
>   
> -/* allow architectures to override this if absolutely required */
> -#ifndef PREALLOC_DMA_DEBUG_ENTRIES
> -#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> -#endif
> -
>   enum {
>   	dma_debug_single,
>   	dma_debug_page,
> @@ -132,7 +127,7 @@ static u32 min_free_entries;
>   static u32 nr_total_entries;
>   
>   /* number of preallocated entries requested by kernel cmdline */
> -static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
> +static u32 nr_prealloc_entries = CONFIG_PREALLOC_DMA_DEBUG_ENTRIES;
>   
>   /* debugfs dentry's for the stuff above */
>   static struct dentry *dma_debug_dent        __read_mostly;
> @@ -1063,7 +1058,7 @@ static __init int dma_debug_entries_cmdline(char *str)
>   	if (!str)
>   		return -EINVAL;
>   	if (!get_option(&str, &nr_prealloc_entries))
> -		nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
> +		nr_prealloc_entries = CONFIG_PREALLOC_DMA_DEBUG_ENTRIES;
>   	return 0;
>   }
>   
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af29b8224fd..2c281edcb5ad 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1659,6 +1659,15 @@ config DMA_API_DEBUG
>   
>   	  If unsure, say N.
>   
> +config PREALLOC_DMA_DEBUG_ENTRIES
> +	int "Preallocated DMA-API debugging entries"
> +	depends on DMA_API_DEBUG
> +	default 65536

I was assuming the point was to also add something like

	default 131072 if HNS_ENET

so that DMA debug doesn't require too much thought from the user. If 
they still have to notice the overflow message and empirically figure 
out a value that does work, rebuilding the kernel each time is far less 
convenient than simply adding "dma_debug_entries=..." to their kernel 
command line and rebooting, which they can do today. If they do already 
know up-front that the default will need overriding and what the 
appropriate value is, then the command line still seems seems just as 
convenient.

Robin.

> +	help
> +	  The number of preallocated entries for DMA-API debugging code. One
> +	  entry is required per DMA-API allocation. Increase this if the DMA-API
> +	  debugging code disables itself because the default is too low.
> +
>   config DMA_API_DEBUG_SG
>   	bool "Debug DMA scatter-gather usage"
>   	default y
> 
