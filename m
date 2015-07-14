From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] iommu/vt-d: Report domain usage in sysfs
Date: Tue, 14 Jul 2015 15:24:53 -0600
Message-ID: <20150714212448.11515.38240.stgit@gimli.home>
References: <20150714211624.11515.25204.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150714211624.11515.25204.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
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
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Debugging domain ID leakage typically requires long running tests in
order to exhaust the domain ID space or kernel instrumentation to
track the setting and clearing of bits.  A couple trivial intel-iommu
specific sysfs extensions make it much easier to expose the IOMMU
capabilities and current usage.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0649b94..560afc0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4449,11 +4449,32 @@ static ssize_t intel_iommu_show_ecap(struct device *dev,
 }
 static DEVICE_ATTR(ecap, S_IRUGO, intel_iommu_show_ecap, NULL);
 
+static ssize_t intel_iommu_show_ndoms(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	return sprintf(buf, "%ld\n", cap_ndoms(iommu->cap));
+}
+static DEVICE_ATTR(domains_supported, S_IRUGO, intel_iommu_show_ndoms, NULL);
+
+static ssize_t intel_iommu_show_ndoms_used(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", bitmap_weight(iommu->domain_ids,
+						  cap_ndoms(iommu->cap)));
+}
+static DEVICE_ATTR(domains_used, S_IRUGO, intel_iommu_show_ndoms_used, NULL);
+
 static struct attribute *intel_iommu_attrs[] = {
 	&dev_attr_version.attr,
 	&dev_attr_address.attr,
 	&dev_attr_cap.attr,
 	&dev_attr_ecap.attr,
+	&dev_attr_domains_supported.attr,
+	&dev_attr_domains_used.attr,
 	NULL,
 };
 
