From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v5 3/8] iommu/vt-d: Move common code out of
	iommu_attch_device()
Date: Thu, 10 Jan 2019 11:00:22 +0800
Message-ID: <20190110030027.31447-4-baolu.lu@linux.intel.com>
References: <20190110030027.31447-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190110030027.31447-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zeng-i9wRM+HIrmnmtl4Z8vJ8Kg761KYD1DLY@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This part of code could be used by both normal and aux
domain specific attach entries. Hence move them into a
common function to avoid duplication.

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 60 ++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index ee8832d26f7e..e9119d45a29d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5058,35 +5058,14 @@ static void intel_iommu_domain_free(struct iommu_domain *domain)
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
-			dmar_remove_one_dev_info(old_domain, dev);
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
@@ -5119,7 +5098,40 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
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
+			dmar_remove_one_dev_info(old_domain, dev);
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
