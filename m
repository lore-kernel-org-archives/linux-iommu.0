From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 3/3 v18] iommu/fsl: Freescale PAMU driver and iommu
	implementation.
Date: Mon, 1 Jul 2013 14:36:35 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A34A7F5@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1372673475-20929-1-git-send-email-Varun.Sethi@freescale.com>
	<1372689326.30572.788.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1372689326.30572.788.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Thanks Alex.

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Monday, July 01, 2013 8:05 PM
> To: Sethi Varun-B16395
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; Yoder Stuart-B08248;
> Wood Scott-B07421; Timur Tabi
> Subject: Re: [PATCH 3/3 v18] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
> 
> On Mon, 2013-07-01 at 15:41 +0530, Varun Sethi wrote:
> > Following is a brief description of the PAMU hardware:
> > PAMU determines what action to take and whether to authorize the
> > action on the basis of the memory address, a Logical IO Device Number
> > (LIODN), and PAACT table (logically) indexed by LIODN and address.
> > Hardware devices which need to access memory must provide an LIODN in
> addition to the memory address.
> >
> > Peripheral Access Authorization and Control Tables (PAACTs) are the
> > primary data structures used by PAMU. A PAACT is a table of peripheral
> > access authorization and control entries (PAACE).Each PAACE defines
> > the range of I/O bus address space that is accessible by the LIOD and
> > the associated access capabilities.
> >
> > There are two types of PAACTs: primary PAACT (PPAACT) and secondary
> > PAACT (SPAACT).A given physical I/O device may be able to act as one
> > or more independent logical I/O devices (LIODs). Each such logical I/O
> > device is assigned an identifier called logical I/O device number
> > (LIODN). A LIODN is allocated a contiguous portion of the I/O bus
> > address space called the DSA window for performing DSA operations. The
> > DSA window may optionally be divided into multiple sub-windows, each
> > of which may be used to map to a region in system storage space. The
> > first sub-window is referred to as the primary sub-window and the
> remaining are called secondary sub-windows.
> >
> > This patch provides the PAMU driver (fsl_pamu.c) and the corresponding
> > IOMMU API implementation (fsl_pamu_domain.c). The PAMU hardware driver
> > (fsl_pamu.c) has been derived from the work done by Ashish Kalra and
> Timur Tabi.
> >
> > Signed-off-by: Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> 
> For iommu group support
> 
> Acked-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
