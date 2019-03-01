From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/4] iommu/vt-d: Several fixes for 5.1
Date: Fri,  1 Mar 2019 11:23:09 +0800
Message-ID: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

This includes several small fixes. All are stable kernel irrelated.
Please consider it for 5.1-rc1.

Best regards,
Lu Baolu

Lu Baolu (4):
  iommu/vt-d: Disable ATS support on untrusted devices
  iommu/vt-d: Set context field after value initialized
  iommu/vt-d: Fix NULL pointer reference in intel_svm_bind_mm()
  iommu/vt-d: Get domain ID before clear pasid entry

 drivers/iommu/intel-iommu.c | 6 ++++--
 drivers/iommu/intel-pasid.c | 2 +-
 drivers/iommu/intel-svm.c   | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.17.1
