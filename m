From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Thu, 26 Jan 2012 19:51:01 +0100
Message-ID: <20120126185101.GJ19255@amd.com>
References: <1326983405-319-1-git-send-email-joerg.roedel@amd.com>
	<1326983405-319-3-git-send-email-joerg.roedel@amd.com>
	<C5ECD7A89D1DC44195F34B25E172658D038749@039-SN2MPN1-011.039d.mgd.msft.net>
	<20120120160344.GG2205@amd.com> <4F219A9C.8000400@freescale.com>
	<20120126183116.GI19255@amd.com> <4F219E82.106@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F219E82.106-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Hiroshi DOYU <Hiroshi.DOYU-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 26, 2012 at 12:42:10PM -0600, Scott Wood wrote:
> On 01/26/2012 12:31 PM, Joerg Roedel wrote:
> > The force_aperture flag indicated whether DMA is only allowed between
> > aperture_start and apertuer_end or if DMA is allowed outside of this
> > range too (unmapped in this case).
> > 
> > The AMD GART for example would set this flag to false because it does
> > not enforce DMA to be in the aperture-range.
> 
> Why is this not an AMD GART specific attribute?  Is there any feature
> reporting mechanism by which a user would know if that flag is supported?

Because this is a flag that makes sense for all IOMMU. Every IOMMU
either allows DMA outside its aperture or it doesn't.

Another reason why it must be in the generic struct is the intended
generic dma-ops layer on-top. This code can decide on this flag wheter a
address needs to be remapped at all.

> If it must be in the generic struct, it would be nice to invert the
> polarity so that the default (after zeroing) is something that should be
> more widely supportable, and less likely to create unintended identity
> mappings.

Setting this flag wrong does not create unintended identity mappings.

> How in general are available attributes and restrictions on possible
> values to be communicated to users of the API?

The possible attributes can be found in inlude/linux/iommu.h. But I
don't understand what you mean by 'restrictions on possible values'. The
geometry attribute is filled by the IOMMU driver dependent on the
hardware capabilities. There are no limits from the iommu-code side.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
