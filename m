From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
Date: Tue, 10 Dec 2013 14:29:17 -0600
Message-ID: <1386707357.10013.114.camel@snotra.buserror.net>
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
	<34c6142137194b1cbd2336013ed3b10d@BN1PR03MB266.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <34c6142137194b1cbd2336013ed3b10d-1xfNCLzsyCo4Ngm60E62wOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Wood Scott-B07421' <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

My e-mail address is <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, not
<IMCEAEX-_O=MMS_OU=EXTERNAL+20+28FYDIBOHF25SPDLT
+29_CN=RECIPIENTS_CN=F0FAAC8D7E74473A9EE1C45B068D838A-nA3rOoH6FIycE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>

On Tue, 2013-12-10 at 05:37 +0000, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, December 07, 2013 12:55 AM
> > To: Bhushan Bharat-R65777
> > Cc: Alex Williamson; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Yoder Stuart-
> > B08248; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; linuxppc-
> > dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
> > 
> > If the administrator does not opt into this partial loss of isolation, then once
> > you run out of MSI groups, new users should not be able to set up MSIs.
> 
> So mean vfio should use Legacy when out of MSI banks?

Yes, if the administrator hasn't granted permission to share.

-Scott
