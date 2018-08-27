From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] Changing the AMD IOMMU API path to work in an atomic
	context which is necessary for any custom drivers using the IOMMU API
	while holding a spinlock.
Date: Sun, 26 Aug 2018 23:58:41 -0700
Message-ID: <20180827065841.GA7053@infradead.org>
References: <1535120929-5693-1-git-send-email-murphyt7@tcd.ie>
	<20180824145328.GA7996@infradead.org>
	<24d3f04a-e6e2-ed8f-e2bd-b38144f33f26@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <24d3f04a-e6e2-ed8f-e2bd-b38144f33f26-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, murphyt7-/Zw1syy4LHg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 24, 2018 at 04:24:49PM +0100, Robin Murphy wrote:
> Although IIRC the AMD driver is in fact the only one whose map/unmap
> callbacks aren't already spinlock-safe (or at least it was last time I was
> looking). Stuff like iommu-dma is already relying on this in order to
> implement streaming DMA API calls (which may be in atomic context) on top of
> the corresponding IOMMU API operations.

True.  That should be mentioned in the spinlock, though - and once
it is done the calling conventions should be documented.
