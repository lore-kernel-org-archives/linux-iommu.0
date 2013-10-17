From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 0/3 v2] iommu/fsl: PAMU driver fixes.
Date: Thu, 17 Oct 2013 13:47:38 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A5456C2@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381922582-28724-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1381922582-28724-1-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
To: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,
Please consider these patches for 3.12.

Regards
Varun

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Wednesday, October 16, 2013 4:53 PM
> To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Yoder Stuart-B08248;
> Wood Scott-B07421; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; Bhushan Bharat-R65777
> Cc: Sethi Varun-B16395
> Subject: [PATCH 0/3 v2] iommu/fsl: PAMU driver fixes.
> 
> The first patch fixes a build failure, when we try to build for a
> Freescale platform without PCI support.
> 
> The second patch enables a default DMA window for the device, once it's
> detached from a domain. In case of vfio, once device is detached from a
> guest it can be again used by the host.
> 
> The last patch adds the maintainer entry for the Freescale PAMU driver.
> 
> Varun Sethi (3):
>   iommu/fsl: Factor out PCI specific code.
>   iommu/fsl: Enable default DMA window for PCIe devices once detached
>   Add maintainers entry for the Freescale PAMU driver.
> 
>  MAINTAINERS                     |    7 ++
>  drivers/iommu/fsl_pamu.c        |   43 ++++++++++---
>  drivers/iommu/fsl_pamu.h        |    1 +
>  drivers/iommu/fsl_pamu_domain.c |  134 +++++++++++++++++++++++++--------
> ------
>  4 files changed, 128 insertions(+), 57 deletions(-)
> 
> --
> 1.7.9.5
