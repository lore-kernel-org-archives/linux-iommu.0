From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: swiotlb cleanup (resend)
Date: Mon, 27 Aug 2018 15:00:51 -0400
Message-ID: <20180827190051.GD14594@char.us.oracle.com>
References: <20180725113802.18943-1-hch@lst.de>
	<20180827181309.GA3834@0021ccb48c25> <20180827183308.GA496@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180827183308.GA496-jcswGhMUV9g@public.gmane.org>
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
Cc: Konrad Rzeszutek Wilk <konrad-Gq0aWv8utHQdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 27, 2018 at 08:33:08PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 27, 2018 at 02:13:11PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Wed, Jul 25, 2018 at 01:37:56PM +0200, Christoph Hellwig wrote:
> > > Hi Konrad,
> > > 
> > > below are a few swiotlb patches.  Mostly just cleanups, but the removal
> > > of the panic option is an actual change in (rarely used) functionality.
> > > 
> > > I'd be happy to pick them up through the dma-mapping tree if you are
> > > fine with that.
> > 
> > Hey,
> > 
> > I put them in my 'devel/for-linus-4.19' as I would like to make
> > sure that they work just fine with Xen-SWIOTLB and some baremetal
> > machines.
> 
> I actually have a new version of these combined with merging
> arm64 support into the main swiotlb ops.  Please hold off a bit for
> now.

<nods>
