From: Sohil Mehta <sohil.mehta@intel.com>
Subject: [PATCH v3 0/6] Intel IOMMU debugfs support
Date: Tue,  5 Dec 2017 19:43:21 -0800
Message-ID: <1512531807-24268-1-git-send-email-sohil.mehta@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Gayatri Kammela <gayatri.kammela@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>, Andriy Shevchenko <andriy.shevchenko@intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi all,

This series aims to add debugfs support for Intel IOMMU. It exposes IOMMU
registers, internal context and dumps individual table entries to help debug
Intel IOMMUs.

The first patch does the ground work for the following patches by creating a
new Kconfig option - INTEL_IOMMU_DEBUG. It also reorganizes some Intel IOMMU
data structures. The next five patches add debugfs support for IOMMU context
internals, extended context, register contents, PASID internals, and Interrupt
remapping in that order. The information can be accessed in sysfs at
'/sys/kernel/debug/intel_iommu/'.

Regards,
Sohil

Changes since v2:
 - Added a macro for seq file operations based on recommendation by Andy 
   Shevchenko. The marco can be moved to seq_file.h at a future point
 - Changed the debugfs file names to more relevant ones
 - Added information for MTRR registers in the regset file

Changes since v1:
 - Fixed seq_printf formatting
 - Handled the case when Interrupt remapping is not enabled

Gayatri Kammela (5):
  iommu/vt-d: Add debugfs support for Intel IOMMU internals
  iommu/vt-d: Add Intel IOMMU debugfs to show context internals
  iommu/vt-d: Add Intel IOMMU debugfs to show extended context internals
  iommu/vt-d: Add debugfs extension to show register contents
  iommu/vt-d: Add debugfs extension to show Pasid table contents

Sohil Mehta (1):
  iommu/vt-d: Add debugfs support for Intel IOMMU Interrupt remapping

 drivers/iommu/Kconfig             |  10 +
 drivers/iommu/Makefile            |   1 +
 drivers/iommu/intel-iommu-debug.c | 417 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c       |  35 +---
 drivers/iommu/intel-svm.c         |   8 -
 include/linux/intel-iommu.h       |  34 ++++
 include/linux/intel-svm.h         |  10 +-
 7 files changed, 478 insertions(+), 37 deletions(-)
 create mode 100644 drivers/iommu/intel-iommu-debug.c

-- 
2.7.4
