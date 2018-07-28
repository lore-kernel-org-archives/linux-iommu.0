From: Paul Burton <paul.burton-8NJIiSa5LzA@public.gmane.org>
Subject: Re: [PATCH] MIPS: remove mips_swiotlb_ops
Date: Sat, 28 Jul 2018 12:06:18 -0700
Message-ID: <20180728190618.sq5xbuc2hnthmkhl@pburton-laptop>
References: <20180727172606.21253-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180727172606.21253-1-hch-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Huacai Chen <chenhc-h23VmSynlr/QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On Fri, Jul 27, 2018 at 07:26:06PM +0200, Christoph Hellwig wrote:
> mips_swiotlb_ops differs from the generic swiotlb_dma_ops only in that
> it contains a mb() barrier after each operations that maps or syncs
> dma memory to the device.
> 
> The dma operations are defined to not be memory barriers, but instead
> the write* operations to kick the DMA off are supposed to contain them.
> 
> For mips this handled by war_io_reorder_wmb(), which evaluates to the
> stronger wmb() instead of the pure compiler barrier barrier() for
> just those platforms that use swiotlb, so I think we are covered
> properly.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  arch/mips/include/asm/dma-mapping.h |  3 +-
>  arch/mips/mm/Makefile               |  1 -
>  arch/mips/mm/dma-swiotlb.c          | 61 -----------------------------
>  3 files changed, 1 insertion(+), 64 deletions(-)
>  delete mode 100644 arch/mips/mm/dma-swiotlb.c

Thanks - this looks reasonable, but needed a small tweak to gain the
definition of swiotlb_dma_ops from linux/swiotlb.h (as riscv & unicore32
do) in order to avoid build failures.

Hooray for even more deleted code :)

Applied to mips-next for 4.19.

Paul
