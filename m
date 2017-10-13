From: Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH 0/6] Intel IOMMU debugfs support
Date: Thu, 12 Oct 2017 17:03:36 -0700
Message-ID: <1507853022-136228-1-git-send-email-sohil.mehta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Ashok Raj <ashok.raj@intel.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi all,

This series aims to add debugfs support for Intel IOMMU. It exposes IOMMU
registers, internal context and dumps individual table entries to help debug
Intel IOMMUs.

The first patch does the ground work for the following patches by creating a new
Kconfig option - INTEL_IOMMU_DEBUG. It also reorganizes some Intel IOMMU data
structures. The next five patches add debugfs support for IOMMU context
internals, extended context, register contents, PASID internals, and Interrupt
remapping in that order. The information can be accessed in sysfs at
'/sys/kernel/debug/intel_iommu/'.

Regards,
Sohil


Gayatri Kammela (5):
  iommu/vt-d: Add debugfs support for Intel IOMMU internals
  iommu/vt-d: Add Intel IOMMU debugfs to show context internals
  iommu/vt-d: Add Intel IOMMU debugfs to show extended context internals
  iommu/vt-d: Add debugfs extension to show register contents
  iommu/vt-d: Add debugfs extension to show Pasid table contents

Sohil Mehta (1):
  iommu/vt-d: Debugfs support for Intel IOMMU Interrupt remapping

 drivers/iommu/Kconfig             |  10 +
 drivers/iommu/Makefile            |   1 +
 drivers/iommu/intel-iommu-debug.c | 429 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c       |  35 +---
 drivers/iommu/intel-svm.c         |   8 -
 include/linux/intel-iommu.h       |  32 +++
 include/linux/intel-svm.h         |  10 +-
 7 files changed, 488 insertions(+), 37 deletions(-)
 create mode 100644 drivers/iommu/intel-iommu-debug.c

-- 
2.7.4
