From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 1/3] hexagon: remove the sync_single_for_cpu DMA operation
Date: Tue, 7 Aug 2018 09:01:36 +0200
Message-ID: <20180807070136.GA32634@lst.de>
References: <20180719125635.824-1-hch@lst.de> <20180719125635.824-2-hch@lst.de>
	<20180725032948.GG12771@codeaurora.org>
	<20180725043927.GA10827@lst.de> <20180731152229.GA956@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180731152229.GA956-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 31, 2018 at 05:22:29PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 25, 2018 at 06:39:27AM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 24, 2018 at 10:29:48PM -0500, Richard Kuo wrote:
> > > Patch series looks good.  Definitely appreciate the cleanup.
> > > 
> > > I can take it through my tree, or if not:
> > > 
> > > Acked-by: Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > 
> > Please take it through your tree, thanks!
> 
> I haven't seen it in linux-next yet, do you still plan to take it?
> 
> Otherwise I'll merge it in the dma-mapping tree.

Given that I haven't seen this in linux-next nor haven't heard back
from you I assume you are on your well deserved summer vacation.

If I don't hear back until tomorrow night I'll merge it through the
dma-mapping tree, so that I have it in linux-next before heading out
to my summer vacation.
