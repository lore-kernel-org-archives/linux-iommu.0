From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] iommu/vt-d: Report superpage support in sysfs
Date: Tue, 14 Jul 2015 15:25:04 -0600
Message-ID: <20150714212459.11515.71211.stgit@gimli.home>
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

We already have the VT-d capability register printed raw, but it
typically involves a trip to the code or the spec to figure out
whether superpages are supported.  Make this easier with "2M_pages"
and "1G_pages" sysfs entries that clearly report Y/N.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 560afc0..eb6e3f4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4468,6 +4468,26 @@ static ssize_t intel_iommu_show_ndoms_used(struct device *dev,
 }
 static DEVICE_ATTR(domains_used, S_IRUGO, intel_iommu_show_ndoms_used, NULL);
 
+static ssize_t intel_iommu_show_2M_pages(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	return sprintf(buf, "%c\n", cap_super_page_val(iommu->cap) & 1 ?
+		       'Y' : 'N');
+}
+static DEVICE_ATTR(2M_pages, S_IRUGO, intel_iommu_show_2M_pages, NULL);
+
+static ssize_t intel_iommu_show_1G_pages(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct intel_iommu *iommu = dev_get_drvdata(dev);
+	return sprintf(buf, "%c\n", cap_super_page_val(iommu->cap) & 2 ?
+		       'Y' : 'N');
+}
+static DEVICE_ATTR(1G_pages, S_IRUGO, intel_iommu_show_1G_pages, NULL);
+
 static struct attribute *intel_iommu_attrs[] = {
 	&dev_attr_version.attr,
 	&dev_attr_address.attr,
@@ -4475,6 +4495,8 @@ static struct attribute *intel_iommu_attrs[] = {
 	&dev_attr_ecap.attr,
 	&dev_attr_domains_supported.attr,
 	&dev_attr_domains_used.attr,
+	&dev_attr_2M_pages.attr,
+	&dev_attr_1G_pages.attr,
 	NULL,
 };
 
