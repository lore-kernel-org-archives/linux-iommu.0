From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 4/9] iommu/vt-d: Move device_domain_info to header
Date: Sat, 14 Jul 2018 15:46:57 +0800
Message-ID: <1531554422-6874-5-git-send-email-baolu.lu@linux.intel.com>
References: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531554422-6874-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This allows the per device iommu data and some helpers to be
used in other files.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/iommu/intel-iommu.c | 63 +++------------------------------------------
 include/linux/intel-iommu.h | 61 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 59 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index dd5a617..d7d2ff9 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -380,61 +380,6 @@ static int hw_pass_through = 1;
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
 		if (domain->iommu_refcnt[idx])
 
-struct dmar_domain {
-	int	nid;			/* node id */
-
-	unsigned	iommu_refcnt[DMAR_UNITS_SUPPORTED];
-					/* Refcount of devices per iommu */
-
-
-	u16		iommu_did[DMAR_UNITS_SUPPORTED];
-					/* Domain ids per IOMMU. Use u16 since
-					 * domain ids are 16 bit wide according
-					 * to VT-d spec, section 9.3 */
-
-	bool has_iotlb_device;
-	struct list_head devices;	/* all devices' list */
-	struct iova_domain iovad;	/* iova's that belong to this domain */
-
-	struct dma_pte	*pgd;		/* virtual address */
-	int		gaw;		/* max guest address width */
-
-	/* adjusted guest address width, 0 is level 2 30-bit */
-	int		agaw;
-
-	int		flags;		/* flags to find out type of domain */
-
-	int		iommu_coherency;/* indicate coherency of iommu access */
-	int		iommu_snooping; /* indicate snooping control feature*/
-	int		iommu_count;	/* reference count of iommu */
-	int		iommu_superpage;/* Level of superpages supported:
-					   0 == 4KiB (no superpages), 1 == 2MiB,
-					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
-	u64		max_addr;	/* maximum mapped address */
-
-	struct iommu_domain domain;	/* generic domain data structure for
-					   iommu core */
-};
-
-/* PCI domain-device relationship */
-struct device_domain_info {
-	struct list_head link;	/* link to domain siblings */
-	struct list_head global; /* link to global list */
-	u8 bus;			/* PCI bus number */
-	u8 devfn;		/* PCI devfn number */
-	u16 pfsid;		/* SRIOV physical function source ID */
-	u8 pasid_supported:3;
-	u8 pasid_enabled:1;
-	u8 pri_supported:1;
-	u8 pri_enabled:1;
-	u8 ats_supported:1;
-	u8 ats_enabled:1;
-	u8 ats_qdep;
-	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
-	struct intel_iommu *iommu; /* IOMMU used by this device */
-	struct dmar_domain *domain; /* pointer to domain */
-};
-
 struct dmar_rmrr_unit {
 	struct list_head list;		/* list of rmrr units	*/
 	struct acpi_dmar_header *hdr;	/* ACPI header		*/
@@ -603,7 +548,7 @@ static void set_iommu_domain(struct intel_iommu *iommu, u16 did,
 		domains[did & 0xff] = domain;
 }
 
-static inline void *alloc_pgtable_page(int node)
+void *alloc_pgtable_page(int node)
 {
 	struct page *page;
 	void *vaddr = NULL;
@@ -614,7 +559,7 @@ static inline void *alloc_pgtable_page(int node)
 	return vaddr;
 }
 
-static inline void free_pgtable_page(void *vaddr)
+void free_pgtable_page(void *vaddr)
 {
 	free_page((unsigned long)vaddr);
 }
@@ -697,7 +642,7 @@ int iommu_calculate_agaw(struct intel_iommu *iommu)
 }
 
 /* This functionin only returns single iommu in a domain */
-static struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
+struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
 {
 	int iommu_id;
 
@@ -3527,7 +3472,7 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	return iova_pfn;
 }
 
-static struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
+struct dmar_domain *get_valid_domain_for_dev(struct device *dev)
 {
 	struct dmar_domain *domain, *tmp;
 	struct dmar_rmrr_unit *rmrr;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 2ff1519..2e1fbde 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -31,6 +31,7 @@
 #include <linux/list.h>
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/dmar.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -387,6 +388,42 @@ struct pasid_entry;
 struct pasid_state_entry;
 struct page_req_dsc;
 
+struct dmar_domain {
+	int	nid;			/* node id */
+
+	unsigned	iommu_refcnt[DMAR_UNITS_SUPPORTED];
+					/* Refcount of devices per iommu */
+
+
+	u16		iommu_did[DMAR_UNITS_SUPPORTED];
+					/* Domain ids per IOMMU. Use u16 since
+					 * domain ids are 16 bit wide according
+					 * to VT-d spec, section 9.3 */
+
+	bool has_iotlb_device;
+	struct list_head devices;	/* all devices' list */
+	struct iova_domain iovad;	/* iova's that belong to this domain */
+
+	struct dma_pte	*pgd;		/* virtual address */
+	int		gaw;		/* max guest address width */
+
+	/* adjusted guest address width, 0 is level 2 30-bit */
+	int		agaw;
+
+	int		flags;		/* flags to find out type of domain */
+
+	int		iommu_coherency;/* indicate coherency of iommu access */
+	int		iommu_snooping; /* indicate snooping control feature*/
+	int		iommu_count;	/* reference count of iommu */
+	int		iommu_superpage;/* Level of superpages supported:
+					   0 == 4KiB (no superpages), 1 == 2MiB,
+					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
+	u64		max_addr;	/* maximum mapped address */
+
+	struct iommu_domain domain;	/* generic domain data structure for
+					   iommu core */
+};
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -435,6 +472,25 @@ struct intel_iommu {
 	u32		flags;      /* Software defined flags */
 };
 
+/* PCI domain-device relationship */
+struct device_domain_info {
+	struct list_head link;	/* link to domain siblings */
+	struct list_head global; /* link to global list */
+	u8 bus;			/* PCI bus number */
+	u8 devfn;		/* PCI devfn number */
+	u16 pfsid;		/* SRIOV physical function source ID */
+	u8 pasid_supported:3;
+	u8 pasid_enabled:1;
+	u8 pri_supported:1;
+	u8 pri_enabled:1;
+	u8 ats_supported:1;
+	u8 ats_enabled:1;
+	u8 ats_qdep;
+	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
+	struct intel_iommu *iommu; /* IOMMU used by this device */
+	struct dmar_domain *domain; /* pointer to domain */
+};
+
 static inline void __iommu_flush_cache(
 	struct intel_iommu *iommu, void *addr, int size)
 {
@@ -460,6 +516,11 @@ extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu);
 
 extern int dmar_ir_support(void);
 
+struct dmar_domain *get_valid_domain_for_dev(struct device *dev);
+void *alloc_pgtable_page(int node);
+void free_pgtable_page(void *vaddr);
+struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu);
 extern int intel_svm_free_pasid_tables(struct intel_iommu *iommu);
-- 
2.7.4
