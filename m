From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH v2 3/8] dma-debug: Refactor dma_debug_entry allocation
Date: Thu, 6 Dec 2018 19:46:28 +0100
Message-ID: <20181206184628.GA30345@lst.de>
References: <cover.1544037783.git.robin.murphy@arm.com>
	<d868e775492e417f446d6d162f5f792bd41ee7bc.1544037783.git.robin.murphy@arm.com>
	<20181206142326.GA24642@lst.de>
	<9accc5fe-4aae-ff7d-a234-f27167c49614@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9accc5fe-4aae-ff7d-a234-f27167c49614-5wv7dgnIgG8@public.gmane.org>
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
Cc: cai-0UDz38MK/Mo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Dec 06, 2018 at 06:10:47PM +0000, Robin Murphy wrote:
> AFAICS the tmp list wasn't about locking as much as meaning that if 
> kzalloc() failed at any point, we can free the partial allocation and back 
> out without disturbing free_entries at all - that still makes sense to me 
> up until patch #8 where we embrace the "never free anything" paradigm and 
> rip out the final traces.
>
> That said, maybe I should just drop the refactoring of 
> dma_debug_resize_entries() now that I'm deleting it as part of the same 
> series anyway - then I guess I squash what's left of this patch into #4 and 
> bring forward some of the simplification from #8 to start with. Would that 
> be more agreeable?

Yes, I just noticed all this goes away toward the end anyway.  We can
either keep it as is, or just drop the intermediate step if that is
easy enough for you.
