From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 0/9] iommu/vt-d: Improve PASID id and table management
Date: Sat, 14 Jul 2018 15:46:53 +0800
Message-ID: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

This patch set improves the PASID id and PASID table management
for Intel IOMMU driver.

PATCH 1~3 replace per IOMMU idr name space with a global one.
Current per IOMMU idr doesn't work in some cases where one
application (associated with a PASID) might talk to two physical
devices simultaneously while the two devices could reside behind
two different IOMMU units.

PATCH 4~9 implement per device PASID table. Current per IOMMU
PASID table implementation is insecure in the cases where
multiple devices under one single IOMMU unit support PASID
feature. With per domain PASID table, we can achieve finer
protection and isolation granularity. This has been discussed
at https://lkml.org/lkml/2018/5/16/154.

Best regards,
Lu Baolu

Change log:
v1->v2:
  - Patches have been reviewed by "Liu Yi L <yi.l.liu@intel.com>".
  - An error case handling was added in PATCH 6/9.
  - Some commit messages are refined to be more accurate.
v2->v3:
  - Patches rebased on top of v4.18-rc1.
  - Replace per-domain with per-device pasid table.
v3->v4:
  - Patches rebased on top of Joerg's x86/vt-d branch.
v4->v5:
  - Change the top of the pasid value
  - Refine the code to clear pasid entry

Lu Baolu (9):
  iommu/vt-d: Global PASID name space
  iommu/vt-d: Avoid using idr_for_each_entry()
  iommu/vt-d: Apply global PASID in SVA
  iommu/vt-d: Move device_domain_info to header
  iommu/vt-d: Add for_each_device_domain() helper
  iommu/vt-d: Per PCI device pasid table interfaces
  iommu/vt-d: Allocate and free pasid table
  iommu/vt-d: Apply per pci device pasid table in SVA
  iommu/vt-d: Remove the obsolete per iommu pasid tables

 drivers/iommu/Makefile      |   2 +-
 drivers/iommu/intel-iommu.c | 143 +++++++++++---------------
 drivers/iommu/intel-pasid.c | 239 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h |  39 ++++++++
 drivers/iommu/intel-svm.c   |  79 ++++++---------
 include/linux/intel-iommu.h |  72 ++++++++++++-
 6 files changed, 441 insertions(+), 133 deletions(-)
 create mode 100644 drivers/iommu/intel-pasid.c
 create mode 100644 drivers/iommu/intel-pasid.h

-- 
2.7.4
