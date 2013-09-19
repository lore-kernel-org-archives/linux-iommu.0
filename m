From: Bharat Bhushan <r65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 0/7] vfio-pci: add support for Freescale IOMMU (PAMU)
Date: Thu, 19 Sep 2013 12:59:16 +0530
Message-ID: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

This patchset adds support for vfio-pci with Freescale
IOMMU (PAMU- Peripheral Access Management Unit)

The Freescale PAMU is an aperture-based IOMMU with the following
characteristics.  Each device has an entry in a table in memory
describing the iova->phys mapping. The mapping has:
  -an overall aperture that is power of 2 sized, and has a start iova that
   is naturally aligned
  -has 1 or more windows within the aperture
  -number of windows must be power of 2, max is 256
  -size of each window is determined by aperture size / # of windows
  -iova of each window is determined by aperture start iova / # of windows
  -the mapped region in each window can be different than
   the window size...mapping must power of 2
  -physical address of the mapping must be naturally aligned
   with the mapping size

Because of some of above said limitations we need to set limited aperture 
window which will have space for MSI address mapping. So we create space
for MSI windows just after the IOVA (guest memory).
First 4 patches in this patchset are for setting up MSI window and MSI address
at device accordingly.

Fifth patch resolves compilation error.
Sixth patch moves some common functions in a separate file so that they can be
used by FSL_PAMU implementation (next patch uses this). These will be used later for
iommu-none implementation. I believe we can do more of this but will take step by step.

Finally the seventh patch actually adds the support for FSL-PAMU :)

Bharat Bhushan (7):
  powerpc: Add interface to get msi region information
  iommu: add api to get iommu_domain of a device
  fsl iommu: add get_dev_iommu_domain
  powerpc: translate msi addr to iova if iommu is in use
  iommu: supress loff_t compilation error on powerpc
  vfio: moving some functions in common file
  vfio pci: Add vfio iommu implementation for FSL_PAMU

 arch/powerpc/include/asm/machdep.h |    8 +
 arch/powerpc/include/asm/pci.h     |    2 +
 arch/powerpc/kernel/msi.c          |   18 +
 arch/powerpc/sysdev/fsl_msi.c      |   95 ++++-
 arch/powerpc/sysdev/fsl_msi.h      |   11 +-
 drivers/iommu/fsl_pamu_domain.c    |   30 ++
 drivers/iommu/iommu.c              |   10 +
 drivers/pci/msi.c                  |   26 +
 drivers/vfio/Kconfig               |    6 +
 drivers/vfio/Makefile              |    5 +-
 drivers/vfio/pci/vfio_pci_rdwr.c   |    3 +-
 drivers/vfio/vfio_iommu_common.c   |  235 +++++++++
 drivers/vfio/vfio_iommu_common.h   |   30 ++
 drivers/vfio/vfio_iommu_fsl_pamu.c |  952 ++++++++++++++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c    |  206 +--------
 include/linux/iommu.h              |    7 +
 include/linux/msi.h                |    8 +
 include/linux/pci.h                |   13 +
 include/uapi/linux/vfio.h          |  100 ++++
 19 files changed, 1550 insertions(+), 215 deletions(-)
 create mode 100644 drivers/vfio/vfio_iommu_common.c
 create mode 100644 drivers/vfio/vfio_iommu_common.h
 create mode 100644 drivers/vfio/vfio_iommu_fsl_pamu.c
