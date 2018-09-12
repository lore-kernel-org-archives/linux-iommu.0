From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 1/6] iommu/vt-d: Relocate struct/function declarations to
	its header files
Date: Tue, 11 Sep 2018 17:11:36 -0700
Message-ID: <20180912001141.64025-2-sohil.mehta@intel.com>
References: <20180912001141.64025-1-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180912001141.64025-1-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

To reuse the static functions and the struct declarations, move them to
corresponding header files and export the needed functions.

Cc: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

v8: Remove pasid table related changes
    Add Interrupt remapping related changes
    Remove redundant extern type from functions

v7: Split patch 1/5 and 2/5 differently
    Update the commit message

v6: No change

v5: No change

v4: No change

v3: No change

v2: No change

 arch/x86/include/asm/irq_remapping.h |  2 ++
 drivers/iommu/intel-iommu.c          | 31 +++-------------------------
 drivers/iommu/intel_irq_remapping.c  |  2 +-
 include/linux/intel-iommu.h          | 30 +++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 5f26962eff42..67ed72f31cc2 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -45,6 +45,8 @@ struct vcpu_data {
 
 #ifdef CONFIG_IRQ_REMAP
 
+extern raw_spinlock_t irq_2_ir_lock;
+
 extern bool irq_remapping_cap(enum irq_remap_cap cap);
 extern void set_irq_remapping_broken(void);
 extern int irq_remapping_prepare(void);
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5f3f10cf9d9d..b5868c757995 100644
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
@@ -788,8 +763,8 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
 	domain->iommu_superpage = domain_update_iommu_superpage(NULL);
 }
 
-static inline struct context_entry *iommu_context_addr(struct intel_iommu *iommu,
-						       u8 bus, u8 devfn, int alloc)
+struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
+					 u8 devfn, int alloc)
 {
 	struct root_entry *root = &iommu->root_entry[bus];
 	struct context_entry *context;
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 967450bd421a..c2d6c11431de 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -76,7 +76,7 @@ static struct hpet_scope ir_hpet[MAX_HPET_TBS];
  * in single-threaded environment with interrupt disabled, so no need to tabke
  * the dmar_global_lock.
  */
-static DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
+DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
 static const struct irq_domain_ops intel_ir_domain_ops;
 
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 28004d74ae04..b7cf32e8ae1f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -389,6 +389,33 @@ struct pasid_entry;
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
 struct dmar_domain {
 	int	nid;			/* node id */
 
@@ -559,5 +586,8 @@ extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
 #endif
 
 extern const struct attribute_group *intel_iommu_groups[];
+bool context_present(struct context_entry *context);
+struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
+					 u8 devfn, int alloc);
 
 #endif
-- 
2.18.0
