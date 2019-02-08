From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v1 4/7] iommu/vt-d: Remove unnecessary local variable
 initializations
Date: Fri, 08 Feb 2019 16:06:08 -0600
Message-ID: <154966356809.132359.5318207850182898116.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

From: Bjorn Helgaas <bhelgaas@google.com>

A local variable initialization is a hint that the variable will be used in
an unusual way.  If the initialization is unnecessary, that hint becomes a
distraction.

Remove unnecessary initializations.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/intel-iommu.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 81077803880f..2acd08c82cdc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -865,7 +865,7 @@ static void free_context_table(struct intel_iommu *iommu)
 static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 				      unsigned long pfn, int *target_level)
 {
-	struct dma_pte *parent, *pte = NULL;
+	struct dma_pte *parent, *pte;
 	int level = agaw_to_level(domain->agaw);
 	int offset;
 
@@ -922,7 +922,7 @@ static struct dma_pte *dma_pfn_level_pte(struct dmar_domain *domain,
 					 unsigned long pfn,
 					 int level, int *large_page)
 {
-	struct dma_pte *parent, *pte = NULL;
+	struct dma_pte *parent, *pte;
 	int total = agaw_to_level(domain->agaw);
 	int offset;
 
@@ -954,7 +954,7 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
 				unsigned long start_pfn,
 				unsigned long last_pfn)
 {
-	unsigned int large_page = 1;
+	unsigned int large_page;
 	struct dma_pte *first_pte, *pte;
 
 	BUG_ON(!domain_pfn_supported(domain, start_pfn));
@@ -1132,7 +1132,7 @@ static struct page *domain_unmap(struct dmar_domain *domain,
 				 unsigned long start_pfn,
 				 unsigned long last_pfn)
 {
-	struct page *freelist = NULL;
+	struct page *freelist;
 
 	BUG_ON(!domain_pfn_supported(domain, start_pfn));
 	BUG_ON(!domain_pfn_supported(domain, last_pfn));
@@ -1763,7 +1763,7 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 static int domain_detach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu)
 {
-	int num, count = INT_MAX;
+	int num, count;
 
 	assert_spin_locked(&device_domain_lock);
 	assert_spin_locked(&iommu->lock);
@@ -1902,7 +1902,7 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 
 static void domain_exit(struct dmar_domain *domain)
 {
-	struct page *freelist = NULL;
+	struct page *freelist;
 
 	/* Domain 0 is reserved, so dont process it */
 	if (!domain)
@@ -2583,7 +2583,7 @@ static int get_last_alias(struct pci_dev *pdev, u16 alias, void *opaque)
 
 static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
 {
-	struct device_domain_info *info = NULL;
+	struct device_domain_info *info;
 	struct dmar_domain *domain = NULL;
 	struct intel_iommu *iommu;
 	u16 dma_alias;
@@ -2807,7 +2807,7 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
 static int __init si_domain_init(int hw)
 {
-	int nid, ret = 0;
+	int nid, ret;
 
 	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
 	if (!si_domain)
@@ -2931,7 +2931,6 @@ static bool device_is_rmrr_locked(struct device *dev)
 
 static int iommu_should_identity_map(struct device *dev, int startup)
 {
-
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
@@ -3527,7 +3526,7 @@ static unsigned long intel_alloc_iova(struct device *dev,
 				     struct dmar_domain *domain,
 				     unsigned long nrpages, uint64_t dma_mask)
 {
-	unsigned long iova_pfn = 0;
+	unsigned long iova_pfn;
 
 	/* Restrict dma_mask to the width that the iommu can handle */
 	dma_mask = min_t(uint64_t, DOMAIN_MAX_ADDR(domain->gaw), dma_mask);
@@ -4333,7 +4332,7 @@ int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void *arg)
 
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
-	int sp, ret = 0;
+	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
 
 	if (g_iommus[iommu->seq_id])
@@ -4497,7 +4496,7 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
 
 int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 {
-	int ret = 0;
+	int ret;
 	struct dmar_rmrr_unit *rmrru;
 	struct dmar_atsr_unit *atsru;
 	struct acpi_dmar_atsr *atsr;
@@ -4514,7 +4513,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 				((void *)rmrr) + rmrr->header.length,
 				rmrr->segment, rmrru->devices,
 				rmrru->devices_cnt);
-			if(ret < 0)
+			if (ret < 0)
 				return ret;
 		} else if (info->event == BUS_NOTIFY_REMOVED_DEVICE) {
 			dmar_remove_dev_scope(info, rmrr->segment,
@@ -4534,7 +4533,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 					atsru->devices_cnt);
 			if (ret > 0)
 				break;
-			else if(ret < 0)
+			else if (ret < 0)
 				return ret;
 		} else if (info->event == BUS_NOTIFY_REMOVED_DEVICE) {
 			if (dmar_remove_dev_scope(info, atsr->segment,
