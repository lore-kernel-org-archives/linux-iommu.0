From: <b16395@freescale.com>
Subject: [RFC][PATCH 0/3] iommu/fsl: Freescale PAMU driver and IOMMU API implementation.
Date: Wed, 19 Sep 2012 18:47:09 +0530
Message-ID: <1348060632-12997-1-git-send-email-b16395@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, joerg.roedel@amd.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

From: Varun Sethi <Varun.Sethi@freescale.com>

This patchset provides the Freescale PAMU (Peripheral Access Management Unit) driver
and the corresponding IOMMU API implementation. PAMU is the IOMMU present on Freescale
QorIQ platforms. PAMU can authorize memory access, remap the memory address, and remap 
the I/O transaction type.

This set consists of the following patches:
1. Addition of new field in the device (powerpc) archdata structure for storing iommu domain information
   pointer. This pointer is stored when the device is attached to a particular iommu domain.
2. Addition of domain attributes required by the PAMU driver IOMMU API.
3. PAMU driver and IOMMU API implementation.

Varun Sethi (3):
  Store iommu domain information pointer in archdata.
  Add iommu domain attributes required by fsl PAMU driver.
  FSL PAMU driver and IOMMU API implementation.

 arch/powerpc/include/asm/device.h |    4 +
 drivers/iommu/Kconfig             |    7 +
 drivers/iommu/Makefile            |    1 +
 drivers/iommu/fsl_pamu.c          | 1033 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu.h          |  377 ++++++++++++++
 drivers/iommu/fsl_pamu_domain.c   |  990 +++++++++++++++++++++++++++++++++++
 drivers/iommu/fsl_pamu_domain.h   |   94 ++++
 drivers/iommu/fsl_pamu_proto.h    |   49 ++
 include/linux/iommu.h             |   30 ++
 9 files changed, 2585 insertions(+), 0 deletions(-)
 create mode 100644 drivers/iommu/fsl_pamu.c
 create mode 100644 drivers/iommu/fsl_pamu.h
 create mode 100644 drivers/iommu/fsl_pamu_domain.c
 create mode 100644 drivers/iommu/fsl_pamu_domain.h
 create mode 100644 drivers/iommu/fsl_pamu_proto.h

-- 
1.7.4.1
