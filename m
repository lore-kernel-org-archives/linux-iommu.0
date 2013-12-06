From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
Date: Thu, 5 Dec 2013 18:00:52 -0600
Message-ID: <1386288052.7375.100.camel@snotra.buserror.net>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
	<1384973243.2879.361.camel@ul30vt.home>
	<6A3DF150A5B70D4F9B66A25E3F7C888D0721D9AC@039-SN2MPN1-012.039d.mgd.msft.net>
	<1385066603.2879.414.camel@ul30vt.home>
	<1385066835.1403.489.camel@snotra.buserror.net>
	<1385067648.2879.421.camel@ul30vt.home>
	<6A3DF150A5B70D4F9B66A25E3F7C888D0722C180@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0722C180-RL0Hj/+nBVDAtPZc1oz0FK4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bharat Bhushan <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Yoder Stuart-B08248 <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, 2013-11-24 at 23:33 -0600, Bharat Bhushan wrote:
> 
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > Sent: Friday, November 22, 2013 2:31 AM
> > To: Wood Scott-B07421
> > Cc: Bhushan Bharat-R65777; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Yoder
> > Stuart-B08248; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; linuxppc-
> > dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
> >
> > On Thu, 2013-11-21 at 14:47 -0600, Scott Wood wrote:
> > > On Thu, 2013-11-21 at 13:43 -0700, Alex Williamson wrote:
> > > > On Thu, 2013-11-21 at 11:20 +0000, Bharat Bhushan wrote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > > > > > Sent: Thursday, November 21, 2013 12:17 AM
> > > > > > To: Bhushan Bharat-R65777
> > > > > > Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Wood
> > > > > > Scott-B07421; Yoder Stuart-B08248;
> > > > > > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux- pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > > > > linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux- kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > > > > Bhushan Bharat-R65777
> > > > > > Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale
> > > > > > IOMMU (PAMU)
> > > > > >
> > > > > > Is VFIO_IOMMU_PAMU_GET_MSI_BANK_COUNT per aperture (ie. each
> > > > > > vfio user has $COUNT regions at their disposal exclusively)?
> > > > >
> > > > > Number of msi-bank count is system wide and not per aperture, But will be
> > setting windows for banks in the device aperture.
> > > > > So say if we are direct assigning 2 pci device (both have different iommu
> > group, so 2 aperture in iommu) to VM.
> > > > > Now qemu can make only one call to know how many msi-banks are there but
> > it must set sub-windows for all banks for both pci device in its respective
> > aperture.
> > > >
> > > > I'm still confused.  What I want to make sure of is that the banks
> > > > are independent per aperture.  For instance, if we have two separate
> > > > userspace processes operating independently and they both chose to
> > > > use msi bank zero for their device, that's bank zero within each
> > > > aperture and doesn't interfere.  Or another way to ask is can a
> > > > malicious user interfere with other users by using the wrong bank.
> > > > Thanks,
> > >
> > > They can interfere.
> 
> Want to be sure of how they can interfere?

If more than one VFIO user shares the same MSI group, one of the users
can send MSIs to another user, by using the wrong interrupt within the
bank.  Unexpected MSIs could cause misbehavior or denial of service.

> >>  With this hardware, the only way to prevent that
> > > is to make sure that a bank is not shared by multiple protection contexts.
> > > For some of our users, though, I believe preventing this is less
> > > important than the performance benefit.
> 
> So should we let this patch series in without protection?

No, there should be some sort of opt-in mechanism similar to IOMMU-less
VFIO -- but not the same exact one, since one is a much more serious
loss of isolation than the other.

> > I think we need some sort of ownership model around the msi banks then.
> > Otherwise there's nothing preventing another userspace from attempting an MSI
> > based attack on other users, or perhaps even on the host.  VFIO can't allow
> > that.  Thanks,
> 
> We have very few (3 MSI bank on most of chips), so we can not assign
> one to each userspace.

That depends on how many users there are.

-Scott
