From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/3 v2] iommu/fsl: Add iommu domain attributes required
	by fsl PAMU driver.
Date: Thu, 4 Oct 2012 16:22:18 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D1EFC03@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1349351808-7156-1-git-send-email-b16395@freescale.com>
	<1349351808-7156-3-git-send-email-b16395@freescale.com>
	<43F13A8A-BF97-427C-8736-8F2E55B7A3D1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <43F13A8A-BF97-427C-8736-8F2E55B7A3D1-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Kumar Gala [mailto:galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org]
> Sent: Thursday, October 04, 2012 6:47 PM
> To: Sethi Varun-B16395
> Cc: joerg.roedel-5C7GfCeVMHo@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sethi Varun-B16395
> Subject: Re: [PATCH 2/3 v2] iommu/fsl: Add iommu domain attributes
> required by fsl PAMU driver.
> 
> 
> On Oct 4, 2012, at 6:56 AM, <b16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org> <b16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> wrote:
> 
> > From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >
> > Added the following domain attributes required by FSL PAMU driver:
> > 1. Subwindows field added to the iommu domain geometry attribute.
> > 2. Added new iommu stash attribute, which allows setting of the
> >   LIODN specific stash id parameter through IOMMU API.
> > 3. Added an attribute for enabling/disabling DMA to a particular
> >   memory window.
> >
> > Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> > include/linux/iommu.h |   35 +++++++++++++++++++++++++++++++++++
> > 1 files changed, 35 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > f3b99e1..62e22f0 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -44,6 +44,33 @@ struct iommu_domain_geometry {
> > 	dma_addr_t aperture_start; /* First address that can be mapped
> */
> > 	dma_addr_t aperture_end;   /* Last address that can be mapped
> */
> > 	bool force_aperture;       /* DMA only allowed in mappable range?
> */
> > +
> > +	/* The subwindows field indicates number of DMA subwindows
> supported
> > +	 * by the geometry. Following is the interpretation of
> > +	 * values for this field:
> > +	 * 0 : This implies that the supported geometry size is 1 MB
> > +         * with each subwindow size being 4KB. Thus number of
> subwindows
> > +	 * being = 1MB/4KB = 256.
> > +	 * 1 : Only one DMA window i.e. no subwindows.
> > +	 * value other than 0 or 1 would indicate actual number of
> subwindows.
> > +	 */
> > +	u32 subwindows;
> > +};
> > +
> > +/* cache stash targets */
> > +#define L1_CACHE 1
> > +#define L2_CACHE 2
> > +#define L3_CACHE 3
> 
> These names are way to generic for being exposed to user space
Will fix naming to IOMMU_ATTR_CACHE_L1 etc.

-Varun
