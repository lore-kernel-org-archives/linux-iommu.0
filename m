From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 0/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
	implementation.
Date: Mon, 25 Feb 2013 10:15:55 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3B8CF1@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1361191939-21260-1-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,
Do you have any comments on the patch set.

Regards
Varun

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Monday, February 18, 2013 6:22 PM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wood Scott-B07421; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; Yoder
> Stuart-B08248
> Cc: Sethi Varun-B16395
> Subject: [PATCH 0/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
> implementation.
> 
> This patchset provides the Freescale PAMU (Peripheral Access Management
> Unit) driver and the corresponding IOMMU API implementation. PAMU is the
> IOMMU present on Freescale QorIQ platforms. PAMU can authorize memory
> access, remap the memory address, and remap the I/O transaction type.
> 
> This set consists of the following patches:
> 1. Addition of new field in the device (powerpc) archdata structure for
> storing iommu domain information
>    pointer. This pointer is stored when the device is attached to a
> particular iommu domain.
> 2. Store PCI controller platform device information in the PCI controller
> structure.
> 3. Add defines for FSL PCI controller BRR1 register.
> 4. Add window permission flags in the iommu_domain_window_enable API.
> 5. Add domain attributes for FSL PAMU driver.
> 6. PAMU driver and IOMMU API implementation.
> 
> This patch set is based on the next branch of the iommu git tree
> maintained by Joerg.
> 
> Varun Sethi (6):
>   Store iommu domain information in the device structure.
>   Store the platform device information corresponding to the pci
>     controller.
>   Added defines for the FSL PCI controller BRR1 register.
>   Add window permission flags for iommu_domain_window_enable API.
>   Add addtional attributes specific to the PAMU driver.
>   FSL PAMU driver and IOMMU API implementation.
> 
>  arch/powerpc/include/asm/device.h     |    4 +
>  arch/powerpc/include/asm/pci-bridge.h |    4 +
>  arch/powerpc/sysdev/fsl_pci.c         |    9 +-
>  arch/powerpc/sysdev/fsl_pci.h         |    2 +-
>  drivers/iommu/Kconfig                 |    8 +
>  drivers/iommu/Makefile                |    1 +
>  drivers/iommu/fsl_pamu.c              | 1260
> +++++++++++++++++++++++++++++++++
>  drivers/iommu/fsl_pamu.h              |  398 +++++++++++
>  drivers/iommu/fsl_pamu_domain.c       | 1135
> +++++++++++++++++++++++++++++
>  drivers/iommu/fsl_pamu_domain.h       |   89 +++
>  drivers/iommu/iommu.c                 |    5 +-
>  include/linux/iommu.h                 |   40 +-
>  12 files changed, 2947 insertions(+), 8 deletions(-)  create mode 100644
> drivers/iommu/fsl_pamu.c  create mode 100644 drivers/iommu/fsl_pamu.h
> create mode 100644 drivers/iommu/fsl_pamu_domain.c  create mode 100644
> drivers/iommu/fsl_pamu_domain.h
> 
> --
> 1.7.4.1
