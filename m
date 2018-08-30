From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC PATCH v2 04/10] iommu/vt-d: Enable/disable multiple domains per
	device
Date: Thu, 30 Aug 2018 12:09:16 +0800
Message-ID: <20180830040922.30426-5-baolu.lu@linux.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180830040922.30426-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add iommu ops for enabling and disabling multiple domains
for a device.

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 891ae70e7bf2..3606d25bc40c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2501,6 +2501,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	info->domain = domain;
 	info->iommu = iommu;
 	info->pasid_table = NULL;
+	info->auxd_enabled = 0;
 
 	if (dev && dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(info->dev);
@@ -5384,6 +5385,39 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
+static int intel_iommu_enable_auxd(struct device *dev)
+{
+	struct device_domain_info *info;
+	struct dmar_domain *domain;
+	unsigned long flags;
+
+	if (!scalable_mode_support())
+		return -ENODEV;
+
+	domain = get_valid_domain_for_dev(dev);
+	if (!domain)
+		return -ENODEV;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info = dev->archdata.iommu;
+	info->auxd_enabled = 1;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return 0;
+}
+
+static void intel_iommu_disable_auxd(struct device *dev)
+{
+	struct device_domain_info *info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info = dev->archdata.iommu;
+	if (!WARN_ON(!info))
+		info->auxd_enabled = 0;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5398,6 +5432,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= intel_iommu_put_resv_regions,
 	.device_group		= pci_device_group,
+	.enable_auxd		= intel_iommu_enable_auxd,
+	.disable_auxd		= intel_iommu_disable_auxd,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b34cf8b887a0..15981245796e 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -487,6 +487,7 @@ struct device_domain_info {
 	u8 pri_enabled:1;
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
+	u8 auxd_enabled:1;	/* Multiple domains per device */
 	u8 ats_qdep;
 	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
 	struct intel_iommu *iommu; /* IOMMU used by this device */
-- 
2.17.1
