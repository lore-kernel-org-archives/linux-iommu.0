From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH v2 0/3] iommu: Avoid DMA ops domain refcount contention
Date: Mon, 17 Sep 2018 15:33:59 +0200
Message-ID: <20180917133359.GA972@lst.de>
References: <cover.1536764440.git.robin.murphy@arm.com>
	<20180914124858.GA4010@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180914124858.GA4010-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, Tom Murphy <murphyt7-/Zw1syy4LHg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 14, 2018 at 01:48:59PM +0100, Will Deacon wrote:
> > As far as merging goes, I don't mind at all whether this goes via IOMMU,
> > or via dma-mapping provided Joerg's happy to ack it.
> 
> I think it makes most sense for Joerg to take this series via his tree.

FYI, I have WIP patches to move the arm dma-iommu wrappers to common
code:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-maybe-coherent

which will require some synchronization of the involved trees.  In the
end it is iommu code, so the actual iommu patches should probably
go into the iommu tree after all, but it might have to pull in the
dma-mapping branch for that.  Or we just punt it until the next merge
window.  Not sure how fast Tom needs the common dma-iommu code for
the x86 AMD iommu conversion.
