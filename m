From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 7/7] x86: switch the VIA 32-bit DMA quirk to use the
	struct device flag
Date: Mon, 28 May 2018 10:34:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1805281034150.1578@nanos.tec.linutronix.de>
References: <20180525143512.1466-1-hch@lst.de>
	<20180525143512.1466-8-hch@lst.de>
	<alpine.DEB.2.21.1805280808280.1585@nanos.tec.linutronix.de>
	<20180528061859.GA4145@lst.de>
	<alpine.DEB.2.21.1805280817310.1585@nanos.tec.linutronix.de>
	<20180528062725.GA4309@lst.de>
	<alpine.DEB.2.21.1805280823240.1585@nanos.tec.linutronix.de>
	<20180528083931.GA7169@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180528083931.GA7169-jcswGhMUV9g@public.gmane.org>
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
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 28 May 2018, Christoph Hellwig wrote:
> On Mon, May 28, 2018 at 08:23:35AM +0200, Thomas Gleixner wrote:
> > > > They remove the commandline switch before having the replacement in place
> > > > unless I'm misreading something.
> > > 
> > > The command line switch to force 32-bit dma is removed without
> > > replacement.   The PCI quirk for force the 32-bit dma for VIA bridges
> > > is kept in place, and switch to a different mechanism in this patch.
> > 
> > Fair enough
> 
> Thanks.  Do you want me to repost them for the x86 tree, or should
> just pull the changes with the commit logs fixed to the dma-mapping
> tree?

Just take them through your tree. There is nothing conflicting in tip.

Thanks,

	tglx
