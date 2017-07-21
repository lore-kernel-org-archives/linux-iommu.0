From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v8 12/13] iommu/amd: Clear out the GV flag when handle deferred domain attach
Date: Fri, 21 Jul 2017 16:59:10 +0800
Message-ID: <1500627551-12930-13-git-send-email-bhe@redhat.com>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500627551-12930-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
List-Id: iommu@lists.linux-foundation.org

When handle deferred domain attach, we need check if the domain is
v2. If not, should try to clear out the GV flag which could be
copied from the old device table entry.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 drivers/iommu/amd_iommu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 46d077784da0..98aaccecbb76 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2085,6 +2085,11 @@ static void clear_dte_entry(u16 devid)
 	amd_iommu_apply_erratum_63(devid);
 }
 
+static void clear_dte_flag_gv(u16 devid)
+{
+	amd_iommu_dev_table[devid].data[0] &= (~DTE_FLAG_GV);
+}
+
 static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
@@ -2459,6 +2464,7 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
  */
 static struct protection_domain *get_domain(struct device *dev)
 {
+	struct iommu_dev_data *dev_data = get_dev_data(dev);
 	struct protection_domain *domain;
 	struct iommu_domain *io_domain;
 
@@ -2466,11 +2472,21 @@ static struct protection_domain *get_domain(struct device *dev)
 		return ERR_PTR(-EINVAL);
 
 	domain = get_dev_data(dev)->domain;
-	if (domain == NULL && get_dev_data(dev)->defer_attach) {
+	if (domain == NULL && dev_data->defer_attach) {
+		u16 alias = amd_iommu_alias_table[dev_data->devid];
 		get_dev_data(dev)->defer_attach = false;
 		io_domain = iommu_get_domain_for_dev(dev);
 		domain = to_pdomain(io_domain);
 		attach_device(dev, domain);
+		/*
+		 * If the deferred attached domain is not v2, should clear out
+		 * the old GV flag.
+		 */
+		if (!(domain->flags & PD_IOMMUV2_MASK)) {
+			clear_dte_flag_gv(dev_data->devid);
+			if (alias != dev_data->devid)
+				clear_dte_flag_gv(dev_data->devid);
+		}
 	}
 	if (!dma_ops_domain(domain))
 		return ERR_PTR(-EBUSY);
-- 
2.5.5
