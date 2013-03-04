From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
	pointer in archdata.
Date: Mon, 4 Mar 2013 06:35:55 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3D06A1@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
	<1361191939-21260-2-git-send-email-Varun.Sethi@freescale.com>
	<20130227113045.GH26252@8bytes.org>
	<C5ECD7A89D1DC44195F34B25E172658D3C26F6@039-SN2MPN1-013.039d.mgd.msft.net>
	<BAB98EA5-5324-4FB2-97C2-A28A96C569DC@kernel.crashing.org>
	<51300367.6080300@ozlabs.ru>
	<C5ECD7A89D1DC44195F34B25E172658D3C802F@039-SN2MPN1-013.039d.mgd.msft.net>
	<51307DCE.1050506@ozlabs.ru>
	<9F6FE96B71CF29479FF1CDC8046E1503565876@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E1503565876-TcFNo7jSaXOLgTCmFNXF2K4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
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
To: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org list" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org list" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Yoder Stuart-B08248
> Sent: Friday, March 01, 2013 9:52 PM
> To: Alexey Kardashevskiy; Sethi Varun-B16395
> Cc: Kumar Gala; Benjamin Herrenschmidt; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org list; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org list;
> Wood Scott-B07421; Joerg Roedel; Paul Mackerras; David Gibson; Alex
> Williamson
> Subject: RE: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
> pointer in archdata.
> 
> 
> 
> > -----Original Message-----
> > From: Alexey Kardashevskiy [mailto:aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org]
> > Sent: Friday, March 01, 2013 4:07 AM
> > To: Sethi Varun-B16395
> > Cc: Kumar Gala; Benjamin Herrenschmidt;
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org list;
> > linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org list; Wood Scott-B07421; Yoder
> > Stuart-B08248; Joerg Roedel; Paul Mackerras; David Gibson; Alex
> > Williamson
> > Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
> pointer in archdata.
> >
> > btw the device struct already has a pointer to its iommu_group, and
> > the iommu_group struct itself has a pointer void *iommu_data which you
> > could use for anything you want (iommu_group_get_iommudata(),
> > iommu_group_set_iommudata()).
> >
> > By design you are expected to add iommu groups to a domain but not
> > devices so I am not so sure that you really need a pointer to domain
> > in the device struct.
> 
> Well, at the lowest level the IOMMU API does attach devices to domains--
> i.e.
> API attach_dev().  So, it seems to conceptually make sense to have a ptr
> from the device to the associated domain.  When you implement
> attach_dev() you need to be able to see whether the device is already
> attached to
> a domain.   Adding a couple of levels of indirection...from device to
> group to domain...doesn't seems to make things simpler or better IMHO.
> 
> x86 keeps a pointer to the domain in device archdata and since there is a
> direct correlation between a device and domain I'd rather see it where
> this patch has it.
> 

As Stuart stated this allows us to maintain the device <-> domain relationship at the lowest level.

-Varun
