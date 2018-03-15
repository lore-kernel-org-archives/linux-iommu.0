From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 04/14] x86: use generic swiotlb_ops
Date: Thu, 15 Mar 2018 13:52:14 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1803151351280.1525@nanos.tec.linutronix.de>
References: <20180314175213.20256-1-hch@lst.de>
	<20180314175213.20256-5-hch@lst.de>
	<alpine.DEB.2.21.1803150956300.1525@nanos.tec.linutronix.de>
	<20180315115426.GB16210@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180315115426.GB16210-jcswGhMUV9g@public.gmane.org>
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
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 15 Mar 2018, Christoph Hellwig wrote:

> On Thu, Mar 15, 2018 at 10:00:57AM +0100, Thomas Gleixner wrote:
> > On Wed, 14 Mar 2018, Christoph Hellwig wrote:
> > >  #if defined(CONFIG_INTEL_IOMMU) || defined(CONFIG_AMD_IOMMU)
> > >  	void *iommu; /* hook for IOMMU specific extension */
> > >  #endif
> > > +#ifdef CONFIG_STA2X11
> > > +	bool is_sta2x11 : 1;
> > 
> > Huch? Please use either bool or an unsigned int based bitfield. A boolean
> > bitfield doesn't make sense.
> 
> bool bitfields are perfectly valid in C99 and used in various places in
> the kernel. But if you want either bool or an unsigned bitfield let me
> know and I'll switch it over.

Yeah, I know that the standard defines it, but that doesn't mean it makes
sense. At least not to me.

Thanks,

	tglx
