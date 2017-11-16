From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Intel-iommu: Possible memory corruption due to deferred iommu
	flush
Date: Thu, 16 Nov 2017 14:52:26 -0800
Message-ID: <20171116225226.GA53404@otc-nc-03>
References: <CAGkh+XfVC0Ki0T88qdKke4Hsp2nyAZewRupEOLTds+1i4eBQYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGkh+XfVC0Ki0T88qdKke4Hsp2nyAZewRupEOLTds+1i4eBQYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: nick klingsman <nick.klingsman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 16, 2017 at 12:20:47PM +0200, nick klingsman wrote:
> * Note: Please 'CC'/Reply my email as I'm not subscribed to the list yet.
> 
> Hi,
> 
> During __iommu_flush_iotlb() we set the WD (WriteDrain) bit if the
> iommu supports cap_write_drain(). This part of the logic exists from
> day one of the code and later even added to QI logic.
> 
> Back than, when we dma_unmap_xxx() we 'synchronically' did the
> iommu_flush() and within it the the Write-Drain logic.
> 
> However, today, we do a batch-flush  which means that all/most calls
> to dma_unmap() don't perform the Write-Drain.
> 
> Questions:
> 
> 1. If WD is a must, how come the batch-flush doesn't cause any memory
> corruption ? For example:
>    a. dma_map_page(100, from_device)
>    b. Device writes data to device
>    c. dma_unmap_page() -> batched and not sync-flushed
>    d. Possible BUG ? Data read before the write is drained can be stale ?

__iommu_flush_iotlb() will do DMA_TLB_WRITE_DRAIN.. so that's actually 
done even in the batched more.

> 
> 2. If WD is not needed, why do we do it ? Why do we effect IOMMU work
> with unneeded actions (in the most critical fast path of map/unmap) ?
> 
> 
> Thanks,
> Nick
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
