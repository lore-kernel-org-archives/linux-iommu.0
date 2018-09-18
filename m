From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: move swiotlb noncoherent dma support from arm64 to generic code
Date: Tue, 18 Sep 2018 18:11:13 +0200
Message-ID: <20180918161112.GA4713@lst.de>
References: <20180917153826.28052-1-hch@lst.de>
	<d6a4f58e-975f-e7dc-d622-d56760710a92@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d6a4f58e-975f-e7dc-d622-d56760710a92-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 18, 2018 at 02:28:42PM +0100, Robin Murphy wrote:
> On 17/09/18 16:38, Christoph Hellwig wrote:
>> Hi all,
>>
>> this series starts with various swiotlb cleanups, then adds support for
>> non-cache coherent devices to the generic swiotlb support, and finally
>> switches arm64 to use the generic code.
>
> I think there's going to be an issue with the embedded folks' grubby hack 
> in arm64's mem_init() which skips initialising SWIOTLB at all with 
> sufficiently little DRAM. I've been waiting for 
> dma-direct-noncoherent-merge so that I could fix that case to swizzle in 
> dma_direct_ops and avoid swiotlb_dma_ops entirely.

I wait for your review of dma-direct-noncoherent-merge to put it
into dma-mapping for-next..

That being said one thing I'm investigating is to eventually further
merge dma_direct_ops and swiotlb_ops - the reason for that beeing that
I want to remove the indirect calls for the common direct mapping case,
and if we don't merge them that will get complicated.  Note that
swiotlb will generally just work if you don't initialize the buffer
as long as we never see a physical address large enough to cause bounce
buffering.

>
>> Given that this series depends on patches in the dma-mapping tree, or
>> pending for it I've also published a git tree here:
>>
>>      git://git.infradead.org/users/hch/misc.git swiotlb-noncoherent
>
> However, upon sitting down to eagerly write that patch I've just 
> boot-tested the above branch as-is for a baseline and discovered a rather 
> more significant problem: arch_dma_alloc() is recursing back into 
> __swiotlb_alloc() and blowing the stack. Not good :(

Oops, I messed up when renaming things.  Try this patch on top:

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 83e597101c6a..c75c721eb74e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -955,7 +955,7 @@ void *__swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 */
 	gfp |= __GFP_NOWARN;
 
-	vaddr = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
+	vaddr = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
 	if (!vaddr)
 		vaddr = swiotlb_alloc_buffer(dev, size, dma_handle, attrs);
 	return vaddr;
@@ -973,7 +973,7 @@ void __swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
 	if (!swiotlb_free_buffer(dev, size, dma_addr))
-		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
+		dma_direct_free_pages(dev, size, vaddr, dma_addr, attrs);
 }
 
 static void swiotlb_free(struct device *dev, size_t size, void *vaddr,
