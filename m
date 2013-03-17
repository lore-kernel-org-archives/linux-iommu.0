From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
	implementation.
Date: Sun, 17 Mar 2013 15:49:20 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D40ABC2@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1363200580-11623-1-git-send-email-Varun.Sethi@freescale.com>
	<0080B56D-8417-41B9-8341-665457D04DE6@kernel.crashing.org>
	<DF9A711B-63AF-411C-84E4-0C9F61A2EB21@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <DF9A711B-63AF-411C-84E4-0C9F61A2EB21-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
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
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Kumar Gala [mailto:galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org]
> Sent: Friday, March 15, 2013 1:53 AM
> To: Sethi Varun-B16395
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Yoder Stuart-B08248;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Wood Scott-B07421; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> Subject: Re: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
> 
> 
> On Mar 14, 2013, at 3:20 PM, Kumar Gala wrote:
> 
> >
> > On Mar 13, 2013, at 1:49 PM, Varun Sethi wrote:
> >
> >> +/*
> >> + * Table of SVRs and the corresponding PORT_ID values.
> >> + *
> >> + * All future CoreNet-enabled SOCs will have this erratum fixed, so
> >> +this table
> >> + * should never need to be updated.  SVRs are guaranteed to be
> >> +unique, so
> >> + * there is no worry that a future SOC will inadvertently have one
> >> +of these
> >> + * values.
> >> + */
> >
> > Maybe add to the comment about what port_id represents
> 
> also, add reference to the erratum #/id/name
> 
[Sethi Varun-B16395] Ok.

-Varun
