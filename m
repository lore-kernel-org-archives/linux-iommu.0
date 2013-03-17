From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
	implementation.
Date: Sun, 17 Mar 2013 15:49:47 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D40ABD3@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1363200580-11623-1-git-send-email-Varun.Sethi@freescale.com>
	<0080B56D-8417-41B9-8341-665457D04DE6@kernel.crashing.org>
	<9F6FE96B71CF29479FF1CDC8046E1503586936@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E1503586936-TcFNo7jSaXPiTqIcKZ1S2K4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
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
To: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Yoder Stuart-B08248
> Sent: Friday, March 15, 2013 2:45 AM
> To: Kumar Gala; Sethi Varun-B16395
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; Wood Scott-B07421
> Subject: RE: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
> 
> 
> 
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org]
> > Sent: Thursday, March 14, 2013 3:20 PM
> > To: Sethi Varun-B16395
> > Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> > linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux- kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; Wood Scott-B07421; Yoder Stuart-B08248
> > Subject: Re: [PATCH 5/5 v9] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
> >
> >
> > On Mar 13, 2013, at 1:49 PM, Varun Sethi wrote:
> >
> > > +/*
> > > + * Table of SVRs and the corresponding PORT_ID values.
> > > + *
> > > + * All future CoreNet-enabled SOCs will have this erratum fixed, so
> > > +this table
> > > + * should never need to be updated.  SVRs are guaranteed to be
> > > +unique, so
> > > + * there is no worry that a future SOC will inadvertently have one
> > > +of these
> > > + * values.
> > > + */
> >
> > Maybe add to the comment about what port_id represents
> 
> When you update the comment, I would also suggest identifying the
> specific errata here (A-004510) so that it's easy to reference back to
> the specific issue this code is fixing.

[Sethi Varun-B16395] Ok

-Varun
