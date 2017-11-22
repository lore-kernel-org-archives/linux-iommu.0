From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/6] iommu/vt-d: Add debugfs support for Intel IOMMU
	internals
Date: Wed, 22 Nov 2017 11:25:41 -0800
Message-ID: <1511378746-109275-2-git-send-email-sohil.mehta@intel.com>
References: <1511378746-109275-1-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1511378746-109275-1-git-send-email-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andriy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Enable Intel IOMMU debug to export Intel IOMMU internals in debugfs

Cc: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

v2: No change

 drivers/iommu/Kconfig       | 10 ++++++++++
 drivers/iommu/intel-iommu.c | 31 +++----------------------------
 include/linux/intel-iommu.h | 32 ++++++++++++++++++++++++++++++++
 include/linux/intel-svm.h   |  2 +-
 4 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a2134..d7588ee 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -152,6 +152,16 @@ config INTEL_IOMMU
 	  and include PCI device scope covered by these DMA
 	  remapping devices.
 
+config INTEL_IOMMU_DEBUG
+	bool "Export Intel IOMMU internals in DebugFS"
+	depends on INTEL_IOMMU && DEBUG_FS
+	default n
+	help
+	  IOMMU internal states such as context, PASID tables can be seen via
+	  debugfs. Select this option if you want to export these internals.
+
+	  Say Y if you need this.
+
 config INTEL_IOMMU_SVM
 	bool "Support for Shared Virtual Memory with Intel IOMMU"
 	depends on INTEL_IOMMU && X86
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6784a05..419a559 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -185,16 +185,6 @@ static int rwbf_quirk;
 static int force_on = 0;
 int intel_iommu_tboot_noforce;
 
-/*
- * 0: Present
- * 1-11: Reserved
- * 12-63: Context Ptr (12 - (haw-1))
- * 64-127: Reserved
- */
-struct root_entry {
-	u64	lo;
-	u64	hi;
-};
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
 
 /*
@@ -220,21 +210,6 @@ static phys_addr_t root_entry_uctp(struct root_entry *re)
 
 	return re->hi & VTD_PAGE_MASK;
 }
-/*
- * low 64 bits:
- * 0: present
- * 1: fault processing disable
- * 2-3: translation type
- * 12-63: address space root
- * high 64 bits:
- * 0-2: address width
- * 3-6: aval
- * 8-23: domain id
- */
-struct context_entry {
-	u64 lo;
-	u64 hi;
-};
 
 static inline void context_clear_pasid_enable(struct context_entry *context)
 {
@@ -261,7 +236,7 @@ static inline bool __context_present(struct context_entry *context)
 	return (context->lo & 1);
 }
 
-static inline bool context_present(struct context_entry *context)
+bool context_present(struct context_entry *context)
 {
 	return context_pasid_enabled(context) ?
 	     __context_present(context) :
@@ -821,7 +796,7 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	domain->iommu_superpage = domain_update_iommu_superpage(NULL);
 }
 
-static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
+struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
 						       u8 bus, u8 devfn, int alloc)
 {
 	struct root_entry *root = &iommu->root_entry[bus];
@@ -5200,7 +5175,7 @@ static void intel_iommu_put_resv_regions(struct device *dev,
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 #define MAX_NR_PASID_BITS (20)
-static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
+unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
 {
 	/*
 	 * Convert ecap_pss to extend context entry pts encoding, also
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 485a5b4..defbc32 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -382,6 +382,33 @@ struct pasid_entry;
 struct pasid_state_entry;
 struct page_req_dsc;
 
+/*
+ * 0: Present
+ * 1-11: Reserved
+ * 12-63: Context Ptr (12 - (haw-1))
+ * 64-127: Reserved
+ */
+struct root_entry {
+	u64     lo;
+	u64     hi;
+};
+
+/*
+ * low 64 bits:
+ * 0: present
+ * 1: fault processing disable
+ * 2-3: translation type
+ * 12-63: address space root
+ * high 64 bits:
+ * 0-2: address width
+ * 3-6: aval
+ * 8-23: domain id
+ */
+struct context_entry {
+	u64 lo;
+	u64 hi;
+};
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -487,8 +514,13 @@ struct intel_svm {
 
 extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev);
 extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
+extern unsigned long intel_iommu_get_pts(struct intel_iommu *iommu);
 #endif
 
 extern const struct attribute_group *intel_iommu_groups[];
+extern void intel_iommu_debugfs_init(void);
+extern bool context_present(struct context_entry *context);
+extern struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
+						u8 bus, u8 devfn, int alloc);
 
 #endif
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 99bc5b3..733eaf9 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -130,7 +130,7 @@ static inline int intel_svm_unbind_mm(struct device *dev, int pasid)
 	BUG();
 }
 
-static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
+static inline int intel_svm_is_pasid_valid(struct device *dev, int pasid)
 {
 	return -EINVAL;
 }
-- 
2.7.4
