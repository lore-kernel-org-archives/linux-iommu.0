From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 01/10] iommu/vt-d: Enumerate the scalable mode capability
Date: Mon, 16 Jul 2018 14:49:44 +0800
Message-ID: <1531723793-14607-2-git-send-email-baolu.lu@linux.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

The Intel vt-d spec rev3.0 introduces a new translation
mode called scalable mode, which enables PASID-granular
translations for first level, second level, nested and
pass-through modes. At the same time, the previous
Extended Context (ECS) mode is deprecated (no production
ever implements ECS).

This patch adds enumeration for Scalable Mode and removes
the deprecated ECS enumeration. It provides a boot time
option to disable scalable mode in case it's required as
a chicken bit option.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 35 ++++++++++++++++-------------------
 include/linux/intel-iommu.h |  1 +
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fed67c6..0a7362b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -429,15 +429,15 @@ static int dmar_map_gfx = 1;
 static int dmar_forcedac;
 static int intel_iommu_strict;
 static int intel_iommu_superpage = 1;
-static int intel_iommu_ecs = 1;
+static int intel_iommu_sm = 1;
 static int iommu_identity_mapping;
 
 #define IDENTMAP_ALL		1
 #define IDENTMAP_GFX		2
 #define IDENTMAP_AZALIA		4
 
-#define ecs_enabled(iommu)	(intel_iommu_ecs && ecap_ecs(iommu->ecap))
-#define pasid_enabled(iommu)	(ecs_enabled(iommu) && ecap_pasid(iommu->ecap))
+#define sm_supported(iu)	(intel_iommu_sm && ecap_smts((iu)->ecap))
+#define pasid_supported(iu)	(sm_supported(iu) && ecap_pasid((iu)->ecap))
 
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
@@ -517,10 +517,9 @@ static int __init intel_iommu_setup(char *str)
 		} else if (!strncmp(str, "sp_off", 6)) {
 			pr_info("Disable supported super page\n");
 			intel_iommu_superpage = 0;
-		} else if (!strncmp(str, "ecs_off", 7)) {
-			printk(KERN_INFO
-				"Intel-IOMMU: disable extended context table support\n");
-			intel_iommu_ecs = 0;
+		} else if (!strncmp(str, "sm_off", 6)) {
+			pr_info("Intel-IOMMU: disable scalable mode support\n");
+			intel_iommu_sm = 0;
 		} else if (!strncmp(str, "tboot_noforce", 13)) {
 			printk(KERN_INFO
 				"Intel-IOMMU: not forcing on after tboot. This could expose security risk for tboot\n");
@@ -767,7 +766,7 @@ static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu
 	u64 *entry;
 
 	entry = &root->lo;
-	if (ecs_enabled(iommu)) {
+	if (sm_supported(iommu)) {
 		if (devfn >= 0x80) {
 			devfn -= 0x80;
 			entry = &root->hi;
@@ -909,7 +908,7 @@ static void free_context_table(struct intel_iommu *iommu)
 		if (context)
 			free_pgtable_page(context);
 
-		if (!ecs_enabled(iommu))
+		if (!sm_supported(iommu))
 			continue;
 
 		context = iommu_context_addr(iommu, i, 0x80, 0);
@@ -1261,8 +1260,6 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 	unsigned long flag;
 
 	addr = virt_to_phys(iommu->root_entry);
-	if (ecs_enabled(iommu))
-		addr |= DMA_RTADDR_RTT;
 
 	raw_spin_lock_irqsave(&iommu->register_lock, flag);
 	dmar_writeq(iommu->reg + DMAR_RTADDR_REG, addr);
@@ -1739,7 +1736,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	free_context_table(iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_enabled(iommu)) {
+	if (pasid_supported(iommu)) {
 		if (ecap_prs(iommu->ecap))
 			intel_svm_finish_prq(iommu);
 		intel_svm_exit(iommu);
@@ -2418,8 +2415,8 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		    dmar_find_matched_atsr_unit(pdev))
 			info->ats_supported = 1;
 
-		if (ecs_enabled(iommu)) {
-			if (pasid_enabled(iommu)) {
+		if (sm_supported(iommu)) {
+			if (pasid_supported(iommu)) {
 				int features = pci_pasid_features(pdev);
 				if (features >= 0)
 					info->pasid_supported = features | 1;
@@ -3231,7 +3228,7 @@ static int __init init_dmars(void)
 		 * We need to ensure the system pasid table is no bigger
 		 * than the smallest supported.
 		 */
-		if (pasid_enabled(iommu)) {
+		if (pasid_supported(iommu)) {
 			u32 temp = 2 << ecap_pss(iommu->ecap);
 
 			intel_pasid_max_id = min_t(u32, temp,
@@ -3292,7 +3289,7 @@ static int __init init_dmars(void)
 		if (!ecap_pass_through(iommu->ecap))
 			hw_pass_through = 0;
 #ifdef CONFIG_INTEL_IOMMU_SVM
-		if (pasid_enabled(iommu))
+		if (pasid_supported(iommu))
 			intel_svm_init(iommu);
 #endif
 	}
@@ -3396,7 +3393,7 @@ static int __init init_dmars(void)
 		iommu_flush_write_buffer(iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-		if (pasid_enabled(iommu) && ecap_prs(iommu->ecap)) {
+		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
 			ret = intel_svm_enable_prq(iommu);
 			if (ret)
 				goto free_iommu;
@@ -4300,7 +4297,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		goto out;
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_enabled(iommu))
+	if (pasid_supported(iommu))
 		intel_svm_init(iommu);
 #endif
 
@@ -4317,7 +4314,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	iommu_flush_write_buffer(iommu);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	if (pasid_enabled(iommu) && ecap_prs(iommu->ecap)) {
+	if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
 		ret = intel_svm_enable_prq(iommu);
 		if (ret)
 			goto disable_iommu;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 398defb..4124cd9 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -115,6 +115,7 @@
  * Extended Capability Register
  */
 
+#define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
 #define ecap_pss(e)		((e >> 35) & 0x1f)
-- 
2.7.4
