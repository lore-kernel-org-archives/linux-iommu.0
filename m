From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/17] iommu/vt-d: Don't reuse domain-ids from old kernel
Date: Fri,  5 Jun 2015 16:10:54 +0200
Message-ID: <1433513463-19128-9-git-send-email-joro@8bytes.org>
References: <1433513463-19128-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1433513463-19128-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: rwright-VXdhtT5mjnY@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, billsumnerlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, tom.vaden-VXdhtT5mjnY@public.gmane.org, lisa.mitchell-VXdhtT5mjnY@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, li.zhang6-VXdhtT5mjnY@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Change the context table copy code to copy context
entrys one by one and check whether they are present and
mark the used domain-id as reserved in the allocation
bitmap. This way the domain-id will not be reused by new
domains allocated in the kdump kernel.

Tested-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 80 ++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 55 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2602b33..82239e3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -367,10 +367,6 @@ static inline int first_pte_in_page(struct dma_pte *pte)
  * do the same thing as crashdump kernel.
  */
 
-static struct context_entry *device_to_existing_context_entry(
-				struct intel_iommu *iommu,
-				u8 bus, u8 devfn);
-
 /*
  * A structure used to store the address allocated by ioremap();
  * The we need to call iounmap() to free them out of spin_lock_irqsave/unlock;
@@ -2337,7 +2333,6 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	unsigned long flags;
 	u8 bus, devfn;
 	int did = -1;   /* Default to "no domain_id supplied" */
-	struct context_entry *ce = NULL;
 
 	domain = find_domain(dev);
 	if (domain)
@@ -2372,19 +2367,6 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	if (!domain)
 		return NULL;
 
-	if (iommu->pre_enabled_trans) {
-		/*
-		 * if this device had a did in the old kernel
-		 * use its values instead of generating new ones
-		 */
-		ce = device_to_existing_context_entry(iommu, bus, devfn);
-
-		if (ce) {
-			did = context_domain_id(ce);
-			gaw = agaw_to_width(context_address_width(ce));
-		}
-	}
-
 	domain->id = iommu_attach_domain_with_id(domain, iommu, did);
 	if (domain->id < 0) {
 		free_domain_mem(domain);
@@ -4931,49 +4913,37 @@ static void __init check_tylersburg_isoch(void)
 	       vtisochctrl);
 }
 
-static struct context_entry *device_to_existing_context_entry(
-				struct intel_iommu *iommu,
-				u8 bus, u8 devfn)
-{
-	struct root_entry *root;
-	struct context_entry *context;
-	struct context_entry *ret = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&iommu->lock, flags);
-	root = &iommu->root_entry[bus];
-	context = get_context_addr_from_root(root);
-	if (context && context_present(context+devfn))
-		ret = &context[devfn];
-	spin_unlock_irqrestore(&iommu->lock, flags);
-	return ret;
-}
-
 /*
- * Copy memory from a physically-addressed area into a virtually-addressed area
+ * Copy one context table
  */
-static int copy_from_oldmem_phys(void *to, phys_addr_t from, size_t size)
+static int copy_one_context_table(struct intel_iommu *iommu,
+				  struct context_entry *ctxt_tbl,
+				  phys_addr_t old_table_phys)
 {
-	void __iomem *virt_mem;
-	unsigned long offset;
-	unsigned long pfn;
+	struct context_entry __iomem *ctxt_tbl_old, ce;
+	int did, devfn;
 
-	pfn    = from >> VTD_PAGE_SHIFT;
-	offset = from & (~VTD_PAGE_MASK);
+	ctxt_tbl_old = ioremap_cache(old_table_phys, VTD_PAGE_SIZE);
+	if (!ctxt_tbl_old)
+		return -ENOMEM;
 
-	if (page_is_ram(pfn)) {
-		memcpy(to, pfn_to_kaddr(pfn) + offset, size);
-	} else {
-		virt_mem = ioremap_cache((unsigned long)from, size);
-		if (!virt_mem)
-			return -ENOMEM;
+	for (devfn = 0; devfn < 256; devfn++) {
+		memcpy_fromio(&ce, &ctxt_tbl_old[devfn],
+			      sizeof(struct context_entry));
 
-		memcpy(to, virt_mem, size);
+		if (!context_present(&ce))
+			continue;
+
+		did = context_domain_id(&ce);
+		if (did >=0 && did < cap_ndoms(iommu->cap))
+			set_bit(did, iommu->domain_ids);
 
-		iounmap(virt_mem);
+		ctxt_tbl[devfn] = ce;
 	}
 
-	return size;
+	iounmap(ctxt_tbl_old);
+
+	return 0;
 }
 
 /*
@@ -5002,9 +4972,9 @@ static int copy_context_tables(struct intel_iommu *iommu,
 		if (!context_new_virt)
 			goto out_err;
 
-		ret = copy_from_oldmem_phys(context_new_virt, context_old_phys,
-					    VTD_PAGE_SIZE);
-		if (ret != VTD_PAGE_SIZE) {
+		ret = copy_one_context_table(iommu, context_new_virt,
+					     context_old_phys);
+		if (ret) {
 			pr_err("Failed to copy context table for bus %d from physical address 0x%llx\n",
 			       bus, context_old_phys);
 			free_pgtable_page(context_new_virt);
-- 
1.9.1
