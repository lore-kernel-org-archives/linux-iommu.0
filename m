From: "Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
Date: Tue, 10 Dec 2013 05:37:14 +0000
Message-ID: <34c6142137194b1cbd2336013ed3b10d@BN1PR03MB266.namprd03.prod.outlook.com>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
	<1384973243.2879.361.camel@ul30vt.home>
	<6A3DF150A5B70D4F9B66A25E3F7C888D0721D9AC@039-SN2MPN1-012.039d.mgd.msft.net>
	<1385066603.2879.414.camel@ul30vt.home>
	<1385066835.1403.489.camel@snotra.buserror.net>
	<1385067648.2879.421.camel@ul30vt.home>
	<6A3DF150A5B70D4F9B66A25E3F7C888D0722C180@039-SN2MPN1-012.039d.mgd.msft.net>
	<1386288052.7375.100.camel@snotra.buserror.net>
	<6A3DF150A5B70D4F9B66A25E3F7C888D07251EFF@039-SN2MPN1-012.039d.mgd.msft.net>
	<1386357907.7375.127.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1386357907.7375.127.camel-88ow+0ZRuxG2UiBs7uKeOtHuzzzSOjJt@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Wood Scott-B07421' <IMCEAEX-_O=MMS_OU=EXTERNAL+20+28FYDIBOHF25SPDLT+29_CN=RECIPIENTS_CN=F0FAAC8D7E74473A9EE1C45B068D838A-nA3rOoH6FIycE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>, "Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Saturday, December 07, 2013 12:55 AM
> To: Bhushan Bharat-R65777
> Cc: Alex Williamson; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Yoder Stuart-
> B08248; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
> 
> On Thu, 2013-12-05 at 22:17 -0600, Bharat Bhushan wrote:
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Friday, December 06, 2013 5:31 AM
> > > To: Bhushan Bharat-R65777
> > > Cc: Alex Williamson; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Yoder
> > > Stuart- B08248; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> > > bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; linuxppc- dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org;
> > > linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale
> > > IOMMU (PAMU)
> > >
> > > On Sun, 2013-11-24 at 23:33 -0600, Bharat Bhushan wrote:
> > > >
> > > > > -----Original Message-----
> > > > > From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> > > > > Sent: Friday, November 22, 2013 2:31 AM
> > > > > To: Wood Scott-B07421
> > > > > Cc: Bhushan Bharat-R65777; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > > > agraf-l3A5Bk7waGM@public.gmane.org; Yoder Stuart-B08248;
> > > > > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; linuxppc-
> > > > > dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > > Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale
> > > > > IOMMU (PAMU)
> > > > >
> > > > > On Thu, 2013-11-21 at 14:47 -0600, Scott Wood wrote:
> > > > > > They can interfere.
> > > >
> > > > Want to be sure of how they can interfere?
> > >
> > > If more than one VFIO user shares the same MSI group, one of the
> > > users can send MSIs to another user, by using the wrong interrupt
> > > within the bank.  Unexpected MSIs could cause misbehavior or denial of
> service.
> > >
> > > > >>  With this hardware, the only way to prevent that
> > > > > > is to make sure that a bank is not shared by multiple protection
> contexts.
> > > > > > For some of our users, though, I believe preventing this is
> > > > > > less important than the performance benefit.
> > > >
> > > > So should we let this patch series in without protection?
> > >
> > > No, there should be some sort of opt-in mechanism similar to
> > > IOMMU-less VFIO -- but not the same exact one, since one is a much
> > > more serious loss of isolation than the other.
> >
> > Can you please elaborate "opt-in mechanism"?
> 
> The system should be secure by default.  If the administrator wants to relax
> protection in order to accomplish some functionality, that should require an
> explicit request such as a write to a sysfs file.
> 
> > > > > I think we need some sort of ownership model around the msi banks then.
> > > > > Otherwise there's nothing preventing another userspace from
> > > > > attempting an MSI based attack on other users, or perhaps even
> > > > > on the host.  VFIO can't allow that.  Thanks,
> > > >
> > > > We have very few (3 MSI bank on most of chips), so we can not
> > > > assign one to each userspace.
> > >
> > > That depends on how many users there are.
> >
> > What I think we can do is:
> >  - Reserve one MSI region for host. Host will not share MSI region with Guest.
> >  - For upto 2 Guest (MAX msi with host - 1) give then separate MSI sub
> > regions
> >  - Additional Guest will share MSI region with other guest.
> >
> > Any better suggestion are most welcome.
> 
> If the administrator does not opt into this partial loss of isolation, then once
> you run out of MSI groups, new users should not be able to set up MSIs.

So mean vfio should use Legacy when out of MSI banks?

Thanks
-Bharat

> 
> -Scott
> 
