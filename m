From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] iommu/vt-d: Fix crash when accessing VT-d sysfs entries
Date: Tue, 28 Feb 2017 15:10:18 +0100
Message-ID: <1488291019-13836-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The link between the iommu sysfs-device and the struct
intel_iommu is no longer stored as driver-data. Update the
code to use the new access method.

Reported-by: Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>
Fixes: 39ab9555c241 ('iommu: Add sysfs bindings for struct iommu_device')
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 12 ++++++------
 include/linux/intel-iommu.h |  5 +++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a8f7ae0..54662c8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4734,7 +4734,7 @@ static ssize_t intel_iommu_show_version(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	u32 ver = readl(iommu->reg + DMAR_VER_REG);
 	return sprintf(buf, "%d:%d\n",
 		       DMAR_VER_MAJOR(ver), DMAR_VER_MINOR(ver));
@@ -4745,7 +4745,7 @@ static ssize_t intel_iommu_show_address(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->reg_phys);
 }
 static DEVICE_ATTR(address, S_IRUGO, intel_iommu_show_address, NULL);
@@ -4754,7 +4754,7 @@ static ssize_t intel_iommu_show_cap(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->cap);
 }
 static DEVICE_ATTR(cap, S_IRUGO, intel_iommu_show_cap, NULL);
@@ -4763,7 +4763,7 @@ static ssize_t intel_iommu_show_ecap(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->ecap);
 }
 static DEVICE_ATTR(ecap, S_IRUGO, intel_iommu_show_ecap, NULL);
@@ -4772,7 +4772,7 @@ static ssize_t intel_iommu_show_ndoms(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%ld\n", cap_ndoms(iommu->cap));
 }
 static DEVICE_ATTR(domains_supported, S_IRUGO, intel_iommu_show_ndoms, NULL);
@@ -4781,7 +4781,7 @@ static ssize_t intel_iommu_show_ndoms_used(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
 	return sprintf(buf, "%d\n", bitmap_weight(iommu->domain_ids,
 						  cap_ndoms(iommu->cap)));
 }
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index c573a52..089e1cb 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -452,6 +452,11 @@ static inline void __iommu_flush_cache(
 		clflush_cache_range(addr, size);
 }
 
+static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)
+{
+	return container_of(dev, struct intel_iommu, iommu.dev);
+}
+
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
 extern int dmar_find_matched_atsr_unit(struct pci_dev *dev);
 
-- 
1.9.1
