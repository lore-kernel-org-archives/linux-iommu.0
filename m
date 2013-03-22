From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 0/5 v10] iommu/fsl: Freescale PAMU driver and IOMMU API
	implementation.
Date: Sat, 23 Mar 2013 04:04:55 +0530
Message-ID: <1363991700-21454-1-git-send-email-Varun.Sethi@freescale.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patchset provides the Freescale PAMU (Peripheral Access Management Unit) driver
and the corresponding IOMMU API implementation. PAMU is the IOMMU present on Freescale
QorIQ platforms. PAMU can authorize memory access, remap the memory address, and remap 
the I/O transaction type.

This set consists of the following patches:
1.  Make iova u64 in the iommu_iova_to_phys API.
2. Addition of new field in the device (powerpc) archdata structure for storing iommu domain information
   pointer.
3. Add window permission flags in the iommu_domain_window_enable API.
4. Add domain attributes for FSL PAMU driver.
5. PAMU driver and IOMMU API implementation.

This patch set is based on the master branch (3.9-rc2) of Linus Torvald's git tree.

Varun Sethi (5):
  Make iova u64 in the iommu_iova_to_phys API.
  Add iommu domain pointer to device archdata
  Add the window permission flag as a parameter to iommu_window_enable
  API.
  Add addition iommu attributes required by the PAMU driver.
  FSL PAMU driver.

 arch/powerpc/include/asm/device.h |    6 +
 arch/powerpc/sysdev/fsl_pci.h     |    5 +
 drivers/iommu/Kconfig             |    8 +
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/amd_iommu.c         |    2 +-
 drivers/iommu/exynos-iommu.c      |    2 +-
 drivers/iommu/fsl_pamu.c          | 1250 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu.h          |  405 ++++++++++++
 drivers/iommu/fsl_pamu_domain.c   | 1134 +++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu_domain.h   |   85 +++
 drivers/iommu/intel-iommu.c       |    2 +-
 drivers/iommu/iommu.c             |    8 +-
 drivers/iommu/msm_iommu.c         |    2 +-
 drivers/iommu/omap-iommu.c        |    2 +-
 drivers/iommu/shmobile-iommu.c    |    2 +-
 drivers/iommu/tegra-gart.c        |    2 +-
 drivers/iommu/tegra-smmu.c        |    2 +-
 include/linux/iommu.h             |   51 ++-
 18 files changed, 2948 insertions(+), 21 deletions(-)
 create mode 100644 drivers/iommu/fsl_pamu.c
 create mode 100644 drivers/iommu/fsl_pamu.h
 create mode 100644 drivers/iommu/fsl_pamu_domain.c
 create mode 100644 drivers/iommu/fsl_pamu_domain.h

-- 
1.7.4.1
