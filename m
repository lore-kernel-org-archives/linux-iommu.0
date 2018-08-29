From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: new SBus related DMA warnings in 4.18+git
Date: Wed, 29 Aug 2018 07:51:33 +0200
Message-ID: <20180829055133.GA28945@lst.de>
References: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
	<20180827154716.GA30492@lst.de>
	<alpine.LRH.2.21.1808272203270.28446@math.ut.ee>
	<20180828092915.GC12488@lst.de>
	<alpine.LRH.2.21.1808281330270.13945@math.ut.ee>
	<20180828114358.GA14519@lst.de>
	<alpine.LRH.2.21.1808281649580.19903@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1808281649580.19903-ptEonEWSGqKptlylMvRsHA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 29, 2018 at 08:47:04AM +0300, Meelis Roos wrote:
> > Updated version including that has survived contact with a sparc cross
> > compiler below.  Note that this is on top of the previous patch adding
> > a dma_mask to struct platform_device, which I've included as well.
> 
> Works completely fine on both Ultra 1 and Ultra 2 - nothing DMA-relaated 
> in dmesg.

Thanks for testing!  I'll submit the patch for 4.19 in a bit.
