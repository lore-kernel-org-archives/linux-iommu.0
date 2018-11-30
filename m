From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] dma-debug: hns_enet_drv could use more DMA entries
Date: Fri, 30 Nov 2018 09:16:12 +0000
Message-ID: <23da2426-a397-a33c-cfd8-dba7b3c1aaee@huawei.com>
References: <20181130035456.1586-1-cai@gmx.us> <20181130084203.GA19812@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181130084203.GA19812-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Qian Cai <cai-0UDz38MK/Mo@public.gmane.org>
Cc: netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, yisen.zhuang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

+

Pasting original message at bottom.


On 30/11/2018 08:42, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 10:54:56PM -0500, Qian Cai wrote:
>>  /* allow architectures to override this if absolutely required */
>>  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>> +/* amount of DMA mappings on this driver is huge. */
>> +#ifdef	HNS_ENET
>> +#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 17)
>> +#else
>>  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>>  #endif
>> +#endif
>
> How would this be defined in a header that leaks into this file?
>
> I think we need to turn PREALLOC_DMA_DEBUG_ENTRIES into a user
> selectable config options, as I really don't want to collect hacks like
> this.
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
>







The amount of DMA mappings from Hisilicon HNS ethernet devices is huge,
so it could trigger "DMA-API: debugging out of memory - disabling".

hnae_get_handle [1]
   hnae_init_queue
     hnae_init_ring
       hnae_alloc_buffers [2]
         debug_dma_map_page
           dma_entry_alloc

[1] for (i = 0; i < handle->q_num; i++)
[2] for (i = 0; i < ring->desc_num; i++)

On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
already,

4 (ports) x 16 (handles) x 1024 (rings) = 65536

Signed-off-by: Qian Cai <cai-0UDz38MK/Mo@public.gmane.org>
---
  kernel/dma/debug.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..ae91689cc9ad 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -43,8 +43,13 @@

  /* allow architectures to override this if absolutely required */
  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
+/* amount of DMA mappings on this driver is huge. */
+#ifdef	HNS_ENET
+#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 17)
+#else
  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
  #endif
+#endif

  enum {
  	dma_debug_single,
