From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 4/9] iommu/vt-d: Move common code out of iommu_attch_device()
Date: Wed, 13 Feb 2019 12:02:56 +0800
Message-ID: <20190213040301.23021-5-baolu.lu@linux.intel.com>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213040301.23021-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, xin.zeng@intel.com, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This part of code could be used by both normal and aux
domain specific attach entries. Hence move them into a
common function to avoid duplication.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 60 ++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a7e2238f869a..3d83451a414d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5054,35 +5054,14 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
 	domain_exit(to_dmar_domain(domain));
 }
 
-static int intel_iommu_attach_device(struct iommu_domain *domain,
-				     struct device *dev)
+static int prepare_domain_attach_device(struct iommu_domain *domain,
+					struct device *dev)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu;
 	int addr_width;
 	u8 bus, devfn;
 
-	if (device_is_rmrr_locked(dev)) {
-		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
-		return -EPERM;
-	}
-
-	/* normally dev is not mapped */
-	if (unlikely(domain_context_mapped(dev))) {
-		struct dmar_domain *old_domain;
-
-		old_domain = find_domain(dev);
-		if (old_domain) {
-			rcu_read_lock();
-			dmar_remove_one_dev_info(dev);
-			rcu_read_unlock();
-
-			if (!domain_type_is_vm_or_si(old_domain) &&
-			     list_empty(&old_domain->devices))
-				domain_exit(old_domain);
-		}
-	}
-
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
@@ -5115,7 +5094,40 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		dmar_domain->agaw--;
 	}
 
-	return domain_add_dev_info(dmar_domain, dev);
+	return 0;
+}
+
+static int intel_iommu_attach_device(struct iommu_domain *domain,
+				     struct device *dev)
+{
+	int ret;
+
+	if (device_is_rmrr_locked(dev)) {
+		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
+		return -EPERM;
+	}
+
+	/* normally dev is not mapped */
+	if (unlikely(domain_context_mapped(dev))) {
+		struct dmar_domain *old_domain;
+
+		old_domain = find_domain(dev);
+		if (old_domain) {
+			rcu_read_lock();
+			dmar_remove_one_dev_info(dev);
+			rcu_read_unlock();
+
+			if (!domain_type_is_vm_or_si(old_domain) &&
+			    list_empty(&old_domain->devices))
+				domain_exit(old_domain);
+		}
+	}
+
+	ret = prepare_domain_attach_device(domain, dev);
+	if (ret)
+		return ret;
+
+	return domain_add_dev_info(to_dmar_domain(domain), dev);
 }
 
 static void intel_iommu_detach_device(struct iommu_domain *domain,
-- 
2.17.1
