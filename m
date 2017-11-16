From: nick klingsman <nick.klingsman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Intel-iommu: Possible memory corruption due to deferred iommu flush
Date: Thu, 16 Nov 2017 12:20:47 +0200
Message-ID: <CAGkh+XfVC0Ki0T88qdKke4Hsp2nyAZewRupEOLTds+1i4eBQYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

* Note: Please 'CC'/Reply my email as I'm not subscribed to the list yet.

Hi,

During __iommu_flush_iotlb() we set the WD (WriteDrain) bit if the
iommu supports cap_write_drain(). This part of the logic exists from
day one of the code and later even added to QI logic.

Back than, when we dma_unmap_xxx() we 'synchronically' did the
iommu_flush() and within it the the Write-Drain logic.

However, today, we do a batch-flush  which means that all/most calls
to dma_unmap() don't perform the Write-Drain.

Questions:

1. If WD is a must, how come the batch-flush doesn't cause any memory
corruption ? For example:
   a. dma_map_page(100, from_device)
   b. Device writes data to device
   c. dma_unmap_page() -> batched and not sync-flushed
   d. Possible BUG ? Data read before the write is drained can be stale ?

2. If WD is not needed, why do we do it ? Why do we effect IOMMU work
with unneeded actions (in the most critical fast path of map/unmap) ?


Thanks,
Nick
