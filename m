From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 0/4] iommu/fsl: Freescale PAMU driver and IOMMU API
	implementation.
Date: Thu, 3 Jan 2013 05:21:09 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D2F58B0@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1355493114-21776-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,
It's been a while since I submitted this patch. I have tried to address your comments regarding the subwindow attribute. I would really appreciate if I can get some feedback on this patch.

Regards
Varun

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Friday, December 21, 2012 7:17 AM
> To: 'Joerg Roedel'
> Cc: Sethi Varun-B16395; joerg.roedel-5C7GfCeVMHo@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Tabi Timur-B04825; Wood Scott-B07421
> Subject: RE: [PATCH 0/4] iommu/fsl: Freescale PAMU driver and IOMMU API
> implementation.
> 
> ping!!
> 
> > -----Original Message-----
> > From: Sethi Varun-B16395
> > Sent: Friday, December 14, 2012 7:22 PM
> > To: joerg.roedel-5C7GfCeVMHo@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> > dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Tabi Timur-B04825;
> > Wood Scott-B07421
> > Cc: Sethi Varun-B16395
> > Subject: [PATCH 0/4] iommu/fsl: Freescale PAMU driver and IOMMU API
> > implementation.
> >
> > This patchset provides the Freescale PAMU (Peripheral Access
> > Management
> > Unit) driver and the corresponding IOMMU API implementation. PAMU is
> > the IOMMU present on Freescale QorIQ platforms. PAMU can authorize
> > memory access, remap the memory address, and remap the I/O transaction
> type.
> >
> > This set consists of the following patches:
> > 1. Addition of new field in the device (powerpc) archdata structure
> > for storing iommu domain information
> >    pointer. This pointer is stored when the device is attached to a
> > particular iommu domain.
> > 2. Add PAMU bypass enable register to the ccsr_guts structure.
> > 3. Addition of domain attributes required by the PAMU driver IOMMU API.
> > 4. PAMU driver and IOMMU API implementation.
> >
> > This patch set is based on the next branch of the iommu git tree
> > maintained by Joerg.
> >
> > Varun Sethi (4):
> >   store iommu domain info in device arch data.
> >   add pamu bypass enable register to guts.
> >   Add iommu attributes for PAMU
> >   FSL PAMU driver.
> >
> >  arch/powerpc/include/asm/device.h   |    4 +
> >  arch/powerpc/include/asm/fsl_guts.h |    4 +-
> >  drivers/iommu/Kconfig               |    8 +
> >  drivers/iommu/Makefile              |    1 +
> >  drivers/iommu/fsl_pamu.c            | 1152
> > +++++++++++++++++++++++++++++++++++
> >  drivers/iommu/fsl_pamu.h            |  398 ++++++++++++
> >  drivers/iommu/fsl_pamu_domain.c     | 1033
> > +++++++++++++++++++++++++++++++
> >  drivers/iommu/fsl_pamu_domain.h     |   96 +++
> >  include/linux/iommu.h               |   49 ++
> >  9 files changed, 2744 insertions(+), 1 deletions(-)  create mode
> > 100644 drivers/iommu/fsl_pamu.c  create mode 100644
> > drivers/iommu/fsl_pamu.h create mode 100644
> > drivers/iommu/fsl_pamu_domain.c  create mode 100644
> > drivers/iommu/fsl_pamu_domain.h
> >
> > --
> > 1.7.4.1
