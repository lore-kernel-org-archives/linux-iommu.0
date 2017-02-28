From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] iommu/amd: Fix crash when accessing AMD-Vi sysfs entries
Date: Tue, 28 Feb 2017 15:10:19 +0100
Message-ID: <1488291019-13836-2-git-send-email-joro@8bytes.org>
References: <1488291019-13836-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1488291019-13836-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
amd_iommu is no longer stored as driver-data. Update the
code to the new correct way of getting from device to
amd_iommu.

Reported-by: Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>
Fixes: 39ab9555c241 ('iommu: Add sysfs bindings for struct iommu_device')
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c  | 4 ++--
 drivers/iommu/amd_iommu_types.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 04cdac7..6130278 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1507,7 +1507,7 @@ static ssize_t amd_iommu_show_cap(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	struct amd_iommu *iommu = dev_get_drvdata(dev);
+	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
 	return sprintf(buf, "%x\n", iommu->cap);
 }
 static DEVICE_ATTR(cap, S_IRUGO, amd_iommu_show_cap, NULL);
@@ -1516,7 +1516,7 @@ static ssize_t amd_iommu_show_features(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	struct amd_iommu *iommu = dev_get_drvdata(dev);
+	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
 	return sprintf(buf, "%llx\n", iommu->features);
 }
 static DEVICE_ATTR(features, S_IRUGO, amd_iommu_show_features, NULL);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index af00f38..003f3ce 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -569,6 +569,11 @@ struct amd_iommu {
 	volatile u64 __aligned(8) cmd_sem;
 };
 
+static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
+{
+	return container_of(dev, struct amd_iommu, iommu.dev);
+}
+
 #define ACPIHID_UID_LEN 256
 #define ACPIHID_HID_LEN 9
 
-- 
1.9.1
