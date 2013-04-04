From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
	implementation.
Date: Thu, 04 Apr 2013 09:22:10 -0600
Message-ID: <1365088930.2882.296.camel@bling.home>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
	<1364500442-20927-6-git-send-email-Varun.Sethi@freescale.com>
	<20130402161812.GI15687@8bytes.org>
	<1365012091.2882.252.camel@bling.home>
	<C5ECD7A89D1DC44195F34B25E172658D45883B@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D45883B-RL0Hj/+nBVDYdknt8GnhQq4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2013-04-04 at 13:00 +0000, Sethi Varun-B16395 wrote:
> 
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > Sent: Wednesday, April 03, 2013 11:32 PM
> > To: Joerg Roedel
> > Cc: Sethi Varun-B16395; Yoder Stuart-B08248; Wood Scott-B07421;
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
> > kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org;
> > benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org
> > Subject: Re: [PATCH 5/5 v11] iommu/fsl: Freescale PAMU driver and iommu
> > implementation.
> > 
> > On Tue, 2013-04-02 at 18:18 +0200, Joerg Roedel wrote:
> > > Cc'ing Alex Williamson
> > >
> > > Alex, can you please review the iommu-group part of this patch?
> > 
> > Sure, it looks pretty reasonable.  AIUI, all PCI devices are below some
> > kind of host bridge that is either new and supports partitioning or old
> > and doesn't.  I don't know if that's a visibility or isolation
> > requirement, perhaps PCI ACS-ish.  In the new host bridge case, each
> > device gets a group.  This seems not to have any quirks for multifunction
> > devices though.  On AMD and Intel IOMMUs we test multifunction device ACS
> > support to determine whether all the functions should be in the same
> > group.  Is there any reason to trust multifunction devices on PAMU?
> > 
> [Sethi Varun-B16395] In the case where we can partition endpoints we
> can distinguish transactions based on the bus,device,function number
> combination. This support is available in the PCIe controller (host
> bridge).

So can x86 IOMMUs, that's the visibility aspect of IOMMU groups.
Visibility alone doesn't necessarily imply that a device is isolated
though.  A multifunction PCI device that doesn't expose ACS support may
not isolate functions from each other.  For example a peer-to-peer DMA
between functions may not be translated by the upstream IOMMU.  IOMMU
groups should encompass both visibility and isolation.

> > I also find it curious what happens to the iommu group of the host
> > bridge.  In the partitionable case the host bridge group is removed, in
> > the non-partitionable case the host bridge group becomes the group for
> > the children, removing the host bridge.  It's unique to PAMU so far that
> > these host bridges are even in an iommu group (x86 only adds pci
> > devices), but I don't see it as necessarily wrong leaving it in either
> > scenario.  Does it solve some problem to remove them from the groups?
> > Thanks,
> [Sethi Varun-B16395] The PCIe controller isn't a partitionable entity,
> it would always be owned by the host.

Ownership of a device shouldn't play into the group context.  An IOMMU
group should be defined by it's visibility and isolation from other
devices.  Whether the PCIe controller is allowed to be handed to
userspace is a question for VFIO.  Thanks,

Alex
