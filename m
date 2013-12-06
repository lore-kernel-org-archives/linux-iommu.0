From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
Date: Fri, 06 Dec 2013 12:30:26 -0700
Message-ID: <1386358226.25738.506.camel@ul30vt.home>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
	<1384973243.2879.361.camel@ul30vt.home>
	<6A3DF150A5B70D4F9B66A25E3F7C888D0721D9AC@039-SN2MPN1-012.039d.mgd.msft.net>
	<1385066603.2879.414.camel@ul30vt.home>
	<1385066835.1403.489.camel@snotra.buserror.net>
	<1385067648.2879.421.camel@ul30vt.home>
	<6A3DF150A5B70D4F9B66A25E3F7C888D0722C180@039-SN2MPN1-012.039d.mgd.msft.net>
	<1385397493.2879.557.camel@ul30vt.home>
	<6A3DF150A5B70D4F9B66A25E3F7C888D0723624C@039-SN2MPN1-012.039d.mgd.msft.net>
	<1386289316.7375.107.camel@snotra.buserror.net>
	<6A3DF150A5B70D4F9B66A25E3F7C888D07251EE4@039-SN2MPN1-012.039d.mgd.msft.net>
	<1386356393.7375.118.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386356393.7375.118.camel-88ow+0ZRuxG2UiBs7uKeOtHuzzzSOjJt@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Yoder Stuart-B08248 <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 2013-12-06 at 12:59 -0600, Scott Wood wrote:
> On Thu, 2013-12-05 at 22:11 -0600, Bharat Bhushan wrote:
> > 
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Friday, December 06, 2013 5:52 AM
> > > To: Bhushan Bharat-R65777
> > > Cc: Alex Williamson; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Yoder Stuart-
> > > B08248; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; linuxppc-
> > > dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
> > >
> > > On Thu, 2013-11-28 at 03:19 -0600, Bharat Bhushan wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Bhushan Bharat-R65777
> > > > > Sent: Wednesday, November 27, 2013 9:39 PM
> > > > > To: 'Alex Williamson'
> > > > > Cc: Wood Scott-B07421; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org;
> > > > > Yoder Stuart- B08248; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> > > > > bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; linuxppc- dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org;
> > > > > linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > Subject: RE: [PATCH 0/9 v2] vfio-pci: add support for Freescale
> > > > > IOMMU (PAMU)
> > > > >
> > > > > If we just provide the size of MSI bank to userspace then userspace
> > > > > cannot do anything wrong.
> > > >
> > > > So userspace does not know address, so it cannot mmap and cause any
> > > interference by directly reading/writing.
> > >
> > > That's security through obscurity...  Couldn't the malicious user find out the
> > > address via other means, such as experimentation on another system over which
> > > they have full control?  What would happen if the user reads from their device's
> > > PCI config space?  Or gets the information via some back door in the PCI device
> > > they own?  Or pokes throughout the address space looking for something that
> > > generates an interrupt to its own device?
> > 
> > So how to solve this problem, Any suggestion ?
> > 
> > We have to map one window in PAMU for MSIs and a malicious user can ask
> > its device to do DMA to MSI window region with any pair of address and
> > data, which can lead to unexpected MSIs in system?
> 
> I don't think there are any solutions other than to limit each bank to
> one user, unless the admin turns some knob that says they're OK with the
> partial loss of isolation.

Even if the admin does opt-in to an allow_unsafe_interrupts options, it
should still be reasonably difficult for one guest to interfere with the
other.  I don't think we want to rely on the blind luck of making the
full MSI bank accessible to multiple guests and hoping they don't step
on each other.  That probably means that vfio needs to manage the space
rather than the guest.  Thanks,

Alex
