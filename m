From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC: vfio / iommu driver for hardware with no iommu
Date: Tue, 30 Apr 2013 15:11:31 -0400
Message-ID: <20130430191131.GC24298@phenom.dumpdata.com>
References: <9F6FE96B71CF29479FF1CDC8046E15035BE0A3@039-SN1MPN1-002.039d.mgd.msft.net>
	<1366736189.2918.573.camel@bling.home>
	<9F6FE96B71CF29479FF1CDC8046E15035BE2BD@039-SN1MPN1-002.039d.mgd.msft.net>
	<1366746427.2918.650.camel@bling.home> <51783553.80202@redhat.com>
	<C5ECD7A89D1DC44195F34B25E172658D4BA91B@039-SN2MPN1-011.039d.mgd.msft.net>
	<5179ACE8.2030506@redhat.com>
	<CAJtEV7ac17Em6Q2jwObkdrujMnQuFbyuyxG2UihwGifGQuQ9=Q@mail.gmail.com>
	<20130430172849.GB22752@phenom.dumpdata.com>
	<518009D3.2050304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <518009D3.2050304-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> >>Does vfio work with swiotlb and if not, can/should swiotlb be
> >>extended? Or does the time and space overhead make it a moot point?
> >
> >It does not work with SWIOTLB as it uses the DMA API, not the IOMMU API.
> >
> I think you got it reversed.  vfio uses iommu api, not dma api.

Right.  That is what I was saying :-) SWIOTLB uses the DMA API, not
the IOMMU API. Hence it won't work with VFIO. Unless SWIOTLB implements
the IOMMU API.


> if vfio used dma api, swiotlb is configured as the default dma-ops interface
> and it could work (with more interfaces... domain-alloc, etc.).

<nods>
> 
> >It could be extended to use it. I was toying with this b/c for Xen to
> >use VFIO I would have to implement an Xen IOMMU driver that would basically
> >piggyback on the SWIOTLB (as Xen itself does the IOMMU parts and takes
> >care of all the hard work of securing each guest).
> >
> >But your requirement would be the same, so it might as well be an generic
> >driver called SWIOTLB-IOMMU driver.
> >
> >If you are up for writting I am up for reviewing/Ack-ing/etc.
> >
> >The complexity would be to figure out the VFIO group thing and how to assign
> >PCI B:D:F devices to the SWIOTLB-IOMMU driver. Perhaps the same way as
> >xen-pciback does (or pcistub). That is by writting the BDF in the "bind"
> >attribute in SysFS (or via a kernel parameter).
> >
> 
> Did uio provide this un-secure support, and just needs some attention upstream?

I don't recall how UIO did it. Not sure if it even had the group
support.
