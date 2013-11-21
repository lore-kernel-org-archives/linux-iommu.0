From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU (PAMU)
Date: Thu, 21 Nov 2013 11:20:01 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A5C38AC@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
	<1384973243.2879.361.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384973243.2879.361.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bharat Bhushan <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Alex Williamson
> Sent: Thursday, November 21, 2013 12:17 AM
> To: Bhushan Bharat-R65777
> Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; agraf-l3A5Bk7waGM@public.gmane.org; Yoder Stuart-B08248; Wood
> Scott-B07421; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org;
> linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 0/9 v2] vfio-pci: add support for Freescale IOMMU
> (PAMU)
> 
> On Tue, 2013-11-19 at 10:47 +0530, Bharat Bhushan wrote:
> > From: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >
> > PAMU (FSL IOMMU) has a concept of primary window and subwindows.
> > Primary window corresponds to the complete guest iova address space
> > (including MSI space), with respect to IOMMU_API this is termed as
> > geometry. IOVA Base of subwindow is determined from the number of
> > subwindows (configurable using iommu API).
> > MSI I/O page must be within the geometry and maximum supported
> > subwindows, so MSI IO-page is setup just after guest memory iova space.
> >
> > So patch 1/9-4/9(inclusive) are for defining the interface to get:
> >   - Number of MSI regions (which is number of MSI banks for powerpc)
> >   - MSI-region address range: Physical page which have the
> >     address/addresses used for generating MSI interrupt
> >     and size of the page.
> >
> > Patch 5/9-7/9(inclusive) is defining the interface of setting up MSI
> > iova-base for a msi region(bank) for a device. so that when
> > msi-message will be composed then this configured iova will be used.
> > Earlier we were using iommu interface for getting the configured iova
> > which was not currect and Alex Williamson suggeested this type of
> interface.
> >
> > patch 8/9 moves some common functions in a separate file so that these
> > can be used by FSL_PAMU implementation (next patch uses this).
> > These will be used later for iommu-none implementation. I believe we
> > can do more of this but will take step by step.
> >
> > Finally last patch actually adds the support for FSL-PAMU :)
> 
> Patches 1-3: msi_get_region needs to return an error an error (probably
> -EINVAL) if called on a path where there's no backend implementation.
> Otherwise the caller doesn't know that the data in the region pointer
> isn't valid.
> 
> Patches 5&6: same as above for msi_set_iova, return an error if no
> backend implementation.
> 
> Patch 7: Why does fsl_msi_del_iova_device bother to return anything if
> it's always zero?  Return -ENODEV when not found?
> 
> Patch 9:
> 
> vfio_handle_get_attr() passes random kernel data back to userspace in the
> event of iommu_domain_get_attr() error.
> 
> vfio_handle_set_attr(): I don't see any data validation happening, is
> iommu_domain_set_attr() really that safe?
[Sethi Varun-B16395] The parameter validation can be left to the lower level iommu driver. The attribute could be specific to a given hardware.

-Varun
