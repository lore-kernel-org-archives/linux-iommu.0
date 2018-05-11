From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 20/23] iommu/intel-svm: do not flush iotlb for viommu
Date: Fri, 11 May 2018 13:54:12 -0700
Message-ID: <1526072055-86990-21-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

vIOMMU passdown invalidation will be inclusive, PASID cache invalidation
includes TLBs. See Intel VT-d Specification Ch 6.5.2.2 for details.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index bdda1b6..697d5c2 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -284,7 +284,9 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdev, &svm->devs, list) {
 		intel_flush_pasid_dev(svm, sdev, svm->pasid);
-		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
+		/* for emulated iommu, PASID cache invalidation implies IOTLB/DTLB */
+		if (!cap_caching_mode(svm->iommu->cap))
+			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
 	}
 	rcu_read_unlock();
 
-- 
2.7.4
