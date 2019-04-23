From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 12/21] dma-iommu: factor atomic pool allocations into
	helpers
Date: Tue, 23 Apr 2019 11:01:44 +0100
Message-ID: <0a6b3f53-79e5-af83-be39-f04c9acd8384@arm.com>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-13-hch@lst.de>
	<b3f80a11-1504-e8f9-4438-92bcd5f3df7f@arm.com>
	<20190410061157.GA5278@lst.de> <20190417063358.GA24139@lst.de>
	<83615173-a8b4-e0eb-bac3-1a58d61ea4ef@arm.com>
	<20190418163512.GA25347@lst.de>
	<228ee57a-d7b2-48e0-a34e-81d5fba0a090@arm.com>
	<20190419082348.GA22299@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190419082348.GA22299-jcswGhMUV9g@public.gmane.org>
Content-Language: en-GB
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
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 19/04/2019 09:23, Christoph Hellwig wrote:
> On Thu, Apr 18, 2019 at 07:15:00PM +0100, Robin Murphy wrote:
>> Still, I've worked in the vm_map_pages() stuff pending in MM and given them
>> the same treatment to finish the picture. Both x86_64_defconfig and
>> i386_defconfig do indeed compile and link fine as I expected, so I really
>> would like to understand the concern around #ifdefs better.
> 
> This looks generally fine to me.  One thing I'd like to do is to
> generally make use of the fact that __iommu_dma_get_pages returns NULL
> for the force contigous case as that cleans up a few things.  Also
> for the !DMA_REMAP case we need to try the page allocator when
> dma_alloc_from_contiguous does not return a page.  What do you thing
> of the following incremental diff?  If that is fine with you I can
> fold that in and add back in the remaining patches from my series
> not obsoleted by your patches and resend.

Wouldn't this suffice? Since we also use alloc_pages() in the coherent 
atomic case, the free path should already be able to deal with it.

Let me take a proper look at v3 and see how it all looks in context.

Robin.

----->8-----
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 1bc8d1de1a1d..0a02ddc27862 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -944,6 +944,8 @@ static void *iommu_dma_alloc(struct device *dev, 
size_t size,
  		   (attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
  		page = dma_alloc_from_contiguous(dev, count, page_order,
  						 gfp & __GFP_NOWARN);
+		if (!page)
+			page = alloc_pages(gfp, page_order);
  	} else {
  		return iommu_dma_alloc_remap(dev, size, handle, gfp, attrs);
  	}
