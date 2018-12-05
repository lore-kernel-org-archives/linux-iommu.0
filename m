From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/4] Consolitate iommu_ops->add/remove_device() calls
Date: Wed,  5 Dec 2018 15:36:42 +0100
Message-ID: <20181205143646.4876-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

this patch-set consolidates the calls to iommu_ops->add_device()
and remove_device() and the necessary checks into
probe/release functions that be extended later with more
setup work.

Regards,

       Joerg

Joerg Roedel (4):
  iommu/sysfs: Rename iommu_release_device()
  iommu: Consolitate ->add/remove_device() calls
  iommu/of: Don't call iommu_ops->add_device directly
  ACPI/IORT: Don't call iommu_ops->add_device directly

 drivers/acpi/arm64/iort.c   |  4 +--
 drivers/iommu/iommu-sysfs.c | 12 ++++-----
 drivers/iommu/iommu.c       | 54 +++++++++++++++++++------------------
 drivers/iommu/of_iommu.c    |  6 ++---
 include/linux/iommu.h       |  3 +++
 5 files changed, 42 insertions(+), 37 deletions(-)

-- 
2.17.1
