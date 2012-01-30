From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Mon, 30 Jan 2012 06:27:30 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D041E81@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1326983405-319-1-git-send-email-joerg.roedel@amd.com>
	<1326983405-319-3-git-send-email-joerg.roedel@amd.com>
	<C5ECD7A89D1DC44195F34B25E172658D038749@039-SN2MPN1-011.039d.mgd.msft.net>
	<20120120160344.GG2205@amd.com> <4F219A9C.8000400@freescale.com>
	<20120126183116.GI19255@amd.com> <4F219E82.106@freescale.com>
	<20120126185101.GJ19255@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120126185101.GJ19255-5C7GfCeVMHo@public.gmane.org>
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
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Hiroshi DOYU <Hiroshi.DOYU-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Joerg Roedel [mailto:joerg.roedel-5C7GfCeVMHo@public.gmane.org]
> Sent: Friday, January 27, 2012 12:21 AM
> To: Wood Scott-B07421
> Cc: Sethi Varun-B16395; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Ohad Ben-Cohen;
> Tony Lindgren; Hiroshi DOYU; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Laurent
> Pinchart; Wood Scott-B07421; David Brown; David Woodhouse
> Subject: Re: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY
> attribute
> 
> On Thu, Jan 26, 2012 at 12:42:10PM -0600, Scott Wood wrote:
> > On 01/26/2012 12:31 PM, Joerg Roedel wrote:
> > > The force_aperture flag indicated whether DMA is only allowed
> > > between aperture_start and apertuer_end or if DMA is allowed outside
> > > of this range too (unmapped in this case).
> > >
> > > The AMD GART for example would set this flag to false because it
> > > does not enforce DMA to be in the aperture-range.
> >
> > Why is this not an AMD GART specific attribute?  Is there any feature
> > reporting mechanism by which a user would know if that flag is
> supported?
> 
> Because this is a flag that makes sense for all IOMMU. Every IOMMU either
> allows DMA outside its aperture or it doesn't.
> 
> Another reason why it must be in the generic struct is the intended
> generic dma-ops layer on-top. This code can decide on this flag wheter a
> address needs to be remapped at all.


Can you please explain how would IOMMU remapping be used, based on the force_aperture flag.

-Varun 
