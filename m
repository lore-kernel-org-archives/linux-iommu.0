From: Varun Sethi <Varun.Sethi@freescale.com>
Subject: [PATCH 0/4] iommu/fsl: Freescale PAMU driver and IOMMU API implementation.
Date: Mon, 5 Nov 2012 16:49:18 +0530
Message-ID: <1352114361-25192-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg.roedel@amd.com, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@freescale.com, scottwood@freescale.com
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

This patchset provides the Freescale PAMU (Peripheral Access Management Unit) driver
and the corresponding IOMMU API implementation. PAMU is the IOMMU present on Freescale
QorIQ platforms. PAMU can authorize memory access, remap the memory address, and remap 
the I/O transaction type.

This set consists of the following patches:
1. Addition of new field in the device (powerpc) archdata structure for storing iommu domain information
   pointer. This pointer is stored when the device is attached to a particular iommu domain.
2. Add PAMU bypass enable register to the ccsr_guts structure.
3. Addition of domain attributes required by the PAMU driver IOMMU API.
4. PAMU driver and IOMMU API implementation.

This patch set is based on the next branch of the iommu git tree maintained by Joerg.



Varun Sethi (4):
  store iommu domain pointer in device archdata structure.
  Add PAMU bypass enable register to ccsr_guts structure.
  Add attributes for fsl PAMU driver.
  FSL PAMU driver.

 arch/powerpc/include/asm/device.h   |    4 +
 arch/powerpc/include/asm/fsl_guts.h |    4 +-
 drivers/iommu/Kconfig               |    8 +
 drivers/iommu/Makefile              |    1 +
 drivers/iommu/fsl_pamu.c            | 1116 +++++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu.h            |  400 +++++++++++++
 drivers/iommu/fsl_pamu_domain.c     | 1010 +++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu_domain.h     |  102 ++++
 include/linux/iommu.h               |   36 ++
 9 files changed, 2680 insertions(+), 1 deletions(-)
 create mode 100644 drivers/iommu/fsl_pamu.c
 create mode 100644 drivers/iommu/fsl_pamu.h
 create mode 100644 drivers/iommu/fsl_pamu_domain.c
 create mode 100644 drivers/iommu/fsl_pamu_domain.h

-- 
1.7.4.1
