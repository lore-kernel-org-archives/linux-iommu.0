From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: WARN_ON(irqs_disabled()) in dma_free_attrs?
Date: Fri, 2 Mar 2018 22:47:46 +0100
Message-ID: <20180302214746.GA30506@lst.de>
References: <20180302180704.GA3846@localhost.localdomain>
	<bfe85e97-2974-06ee-8c6d-f8e8a83348ea@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <bfe85e97-2974-06ee-8c6d-f8e8a83348ea-5wv7dgnIgG8@public.gmane.org>
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
Cc: =?iso-8859-1?Q?J=FCrgen?= Urban <JuergenUrban-Mmb7MZpHnFY@public.gmane.org>, Fredrik Noring <noring-zgYzP9v7iJcdnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 02, 2018 at 07:55:48PM +0000, Robin Murphy wrote:
> On the other hand, HCD_LOCAL_MEM implies a per-device coherent pool. Since 
> those bypass the arch-specific code, then depending on how unlikely we 
> think it is for devices covered by a single driver to exist both with and 
> without their own memory then it *might* also be reasonable to make the 
> change below. Christoph, what do you reckon?

For the case where the coherent pool really is per-device this looks
technically ok.  But it would also cover cases like arm nommu where
we have a single global nommu pool and we wouldn't warn for a driver
that frees with irqs disabled.

That being said I think allowing coherent frees from irqs disabled
context is a very bad idea to do in general, so if we can at all I'd
rather fix the driver than lifting any restrictions.
