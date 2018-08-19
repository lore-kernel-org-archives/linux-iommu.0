From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] swiotlb: Fix uninitialized pointer on DMA ops
Date: Sun, 19 Aug 2018 08:57:31 -0400
Message-ID: <779B2AB6-0FF2-4A58-A333-E7207184E0BE@oracle.com>
References: <1534619091-14258-1-git-send-email-estebanzacr.20@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1534619091-14258-1-git-send-email-estebanzacr.20-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Esteban Zamora <estebanzacr.20-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>estebanzacr.20-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On August 18, 2018 3:04:51 PM EDT, Esteban Zamora <estebanzacr.20-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>The mmap function pointer on swiotlb_dma_ops struct is
>uninitialized, which causes a random crash when calling
>the dma_mmap_coherent function on platforms where no DMA
>address translation hardware is available.
>
>Set this pointer to NULL in order to fix the issue.


By default unused entries in .rodata structure (like this one) are zero - meaning they are NULL if not set by the complier.

You should be able to verify this by looking at the objdump of the kernel and find this structure.


>
>Signed-off-by: Esteban Zamora <estebanzacr.20-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>---
> kernel/dma/swiotlb.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>index 4f8a6db..9a7718c 100644
>--- a/kernel/dma/swiotlb.c
>+++ b/kernel/dma/swiotlb.c
>@@ -1082,5 +1082,6 @@ const struct dma_map_ops swiotlb_dma_ops = {
> 	.map_page		= swiotlb_map_page,
> 	.unmap_page		= swiotlb_unmap_page,
> 	.dma_supported		= dma_direct_supported,
>+	.mmap                   = NULL,
> };
> EXPORT_SYMBOL(swiotlb_dma_ops);
