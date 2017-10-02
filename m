From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: road blocks for using dma-iommu on more than arm64
Date: Mon, 2 Oct 2017 07:50:25 -0700
Message-ID: <20171002145025.GA28291@infradead.org>
References: <20171001090245.GA22124@infradead.org>
	<7fcdaa8c-a12c-3264-0173-5c1be6f11ff7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7fcdaa8c-a12c-3264-0173-5c1be6f11ff7-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 02, 2017 at 03:47:06PM +0100, Robin Murphy wrote:
> dma-iommu does require that the IOMMU driver allows iommu_{un,}map() to
> be called in atomic context, but last time I looked I think it was only
> the AMD driver that needs attention there. The main other concern, for
> x86 at least, was the performance overhead of the extra level of API
> abstraction and indirection. However, dma-iommu is now on a par with all
> the IOVA optimisations, and once we've got the new IOMMU API TLB
> maintenance calls implemented and hooked up, the difference will
> hopefully be small enough to make the conversion viable.

Thanks, that's good news.

> It's been on my to-do list for ages to convert 32-bit ARM over to
> dma-iommu as well - some of the blockers like DMA configuration order
> have now been resolved, but there are still some awkward dependencies
> between IOMMU and DRM drivers that I need to get a handle on.

Talking about arm32 - do you remember why it uses it's own dmabounce
subsystem instead of swiotlb?
