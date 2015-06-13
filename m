From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 01/19] iommu/vt-d: Cleanup log messages
Date: Sat, 13 Jun 2015 08:47:09 +0200
Message-ID: <1434178047-17809-2-git-send-email-joro@8bytes.org>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434178047-17809-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jroedel-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Give them a common prefix that can be grepped for and
improve the wording here and there.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/dmar.c                |  28 +++----
 drivers/iommu/intel-iommu.c         | 154 +++++++++++++++++-------------------
 drivers/iommu/intel_irq_remapping.c |  29 ++++---
 3 files changed, 101 insertions(+), 110 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 9847613..c588658 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -26,7 +26,7 @@
  * These routines are used by both DMA-remapping and Interrupt-remapping
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt /* has to precede printk.h */
+#define pr_fmt(fmt)     "DMAR: " fmt
 
 #include <linux/pci.h>
 #include <linux/dmar.h>
@@ -555,7 +555,7 @@ static int dmar_walk_remapping_entries(struct acpi_dmar_header *start,
 			break;
 		} else if (next > end) {
 			/* Avoid passing table end */
-			pr_warn(FW_BUG "record passes table end\n");
+			pr_warn(FW_BUG "Record passes table end\n");
 			ret = -EINVAL;
 			break;
 		}
@@ -802,7 +802,7 @@ int __init dmar_table_init(void)
 		ret = parse_dmar_table();
 		if (ret < 0) {
 			if (ret != -ENODEV)
-				pr_info("parse DMAR table failure.\n");
+				pr_info("Parse DMAR table failure.\n");
 		} else  if (list_empty(&dmar_drhd_units)) {
 			pr_info("No DMAR devices found\n");
 			ret = -ENODEV;
@@ -847,7 +847,7 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
 	else
 		addr = early_ioremap(drhd->address, VTD_PAGE_SIZE);
 	if (!addr) {
-		pr_warn("IOMMU: can't validate: %llx\n", drhd->address);
+		pr_warn("Can't validate DRHD address: %llx\n", drhd->address);
 		return -EINVAL;
 	}
 
@@ -921,14 +921,14 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 	iommu->reg_size = VTD_PAGE_SIZE;
 
 	if (!request_mem_region(iommu->reg_phys, iommu->reg_size, iommu->name)) {
-		pr_err("IOMMU: can't reserve memory\n");
+		pr_err("Can't reserve memory\n");
 		err = -EBUSY;
 		goto out;
 	}
 
 	iommu->reg = ioremap(iommu->reg_phys, iommu->reg_size);
 	if (!iommu->reg) {
-		pr_err("IOMMU: can't map the region\n");
+		pr_err("Can't map the region\n");
 		err = -ENOMEM;
 		goto release;
 	}
@@ -952,13 +952,13 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 		iommu->reg_size = map_size;
 		if (!request_mem_region(iommu->reg_phys, iommu->reg_size,
 					iommu->name)) {
-			pr_err("IOMMU: can't reserve memory\n");
+			pr_err("Can't reserve memory\n");
 			err = -EBUSY;
 			goto out;
 		}
 		iommu->reg = ioremap(iommu->reg_phys, iommu->reg_size);
 		if (!iommu->reg) {
-			pr_err("IOMMU: can't map the region\n");
+			pr_err("Can't map the region\n");
 			err = -ENOMEM;
 			goto release;
 		}
@@ -1014,14 +1014,14 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		return -ENOMEM;
 
 	if (dmar_alloc_seq_id(iommu) < 0) {
-		pr_err("IOMMU: failed to allocate seq_id\n");
+		pr_err("Failed to allocate seq_id\n");
 		err = -ENOSPC;
 		goto error;
 	}
 
 	err = map_iommu(iommu, drhd->reg_base_addr);
 	if (err) {
-		pr_err("IOMMU: failed to map %s\n", iommu->name);
+		pr_err("Failed to map %s\n", iommu->name);
 		goto error_free_seq_id;
 	}
 
@@ -1045,8 +1045,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	iommu->node = -1;
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
-	pr_info("IOMMU %d: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
-		iommu->seq_id,
+	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
+		iommu->name,
 		(unsigned long long)drhd->reg_base_addr,
 		DMAR_VER_MAJOR(ver), DMAR_VER_MINOR(ver),
 		(unsigned long long)iommu->cap,
@@ -1644,7 +1644,7 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 
 	irq = dmar_alloc_hwirq();
 	if (irq <= 0) {
-		pr_err("IOMMU: no free vectors\n");
+		pr_err("No free IRQ vectors\n");
 		return -EINVAL;
 	}
 
@@ -1661,7 +1661,7 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 
 	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
 	if (ret)
-		pr_err("IOMMU: can't request irq\n");
+		pr_err("Can't request irq\n");
 	return ret;
 }
 
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 68d43be..14af51d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -15,8 +15,11 @@
  *          Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
  *          Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
  *          Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+ *          Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
  */
 
+#define pr_fmt(fmt)     "DMAR: " fmt
+
 #include <linux/init.h>
 #include <linux/bitmap.h>
 #include <linux/debugfs.h>
@@ -445,25 +448,21 @@ static int __init intel_iommu_setup(char *str)
 	while (*str) {
 		if (!strncmp(str, "on", 2)) {
 			dmar_disabled = 0;
-			printk(KERN_INFO "Intel-IOMMU: enabled\n");
+			pr_info("IOMMU enabled\n");
 		} else if (!strncmp(str, "off", 3)) {
 			dmar_disabled = 1;
-			printk(KERN_INFO "Intel-IOMMU: disabled\n");
+			pr_info("IOMMU disabled\n");
 		} else if (!strncmp(str, "igfx_off", 8)) {
 			dmar_map_gfx = 0;
-			printk(KERN_INFO
-				"Intel-IOMMU: disable GFX device mapping\n");
+			pr_info("Disable GFX device mapping\n");
 		} else if (!strncmp(str, "forcedac", 8)) {
-			printk(KERN_INFO
-				"Intel-IOMMU: Forcing DAC for PCI devices\n");
+			pr_info("Forcing DAC for PCI devices\n");
 			dmar_forcedac = 1;
 		} else if (!strncmp(str, "strict", 6)) {
-			printk(KERN_INFO
-				"Intel-IOMMU: disable batched IOTLB flush\n");
+			pr_info("Disable batched IOTLB flush\n");
 			intel_iommu_strict = 1;
 		} else if (!strncmp(str, "sp_off", 6)) {
-			printk(KERN_INFO
-				"Intel-IOMMU: disable supported super page\n");
+			pr_info("Disable supported super page\n");
 			intel_iommu_superpage = 0;
 		}
 
@@ -1112,7 +1111,7 @@ static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 
 	root = (struct root_entry *)alloc_pgtable_page(iommu->node);
 	if (!root) {
-		pr_err("IOMMU: allocating root entry for %s failed\n",
+		pr_err("Allocating root entry for %s failed\n",
 			iommu->name);
 		return -ENOMEM;
 	}
@@ -1250,9 +1249,9 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 
 	/* check IOTLB invalidation granularity */
 	if (DMA_TLB_IAIG(val) == 0)
-		printk(KERN_ERR"IOMMU: flush IOTLB failed\n");
+		pr_err("Flush IOTLB failed\n");
 	if (DMA_TLB_IAIG(val) != DMA_TLB_IIRG(type))
-		pr_debug("IOMMU: tlb flush request %Lx, actual %Lx\n",
+		pr_debug("TLB flush request %Lx, actual %Lx\n",
 			(unsigned long long)DMA_TLB_IIRG(type),
 			(unsigned long long)DMA_TLB_IAIG(val));
 }
@@ -1423,8 +1422,8 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	unsigned long nlongs;
 
 	ndomains = cap_ndoms(iommu->cap);
-	pr_debug("IOMMU%d: Number of Domains supported <%ld>\n",
-		 iommu->seq_id, ndomains);
+	pr_debug("%s: Number of Domains supported <%ld>\n",
+		 iommu->name, ndomains);
 	nlongs = BITS_TO_LONGS(ndomains);
 
 	spin_lock_init(&iommu->lock);
@@ -1434,15 +1433,15 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 	 */
 	iommu->domain_ids = kcalloc(nlongs, sizeof(unsigned long), GFP_KERNEL);
 	if (!iommu->domain_ids) {
-		pr_err("IOMMU%d: allocating domain id array failed\n",
-		       iommu->seq_id);
+		pr_err("%s: Allocating domain id array failed\n",
+		       iommu->name);
 		return -ENOMEM;
 	}
 	iommu->domains = kcalloc(ndomains, sizeof(struct dmar_domain *),
 			GFP_KERNEL);
 	if (!iommu->domains) {
-		pr_err("IOMMU%d: allocating domain array failed\n",
-		       iommu->seq_id);
+		pr_err("%s: Allocating domain array failed\n",
+		       iommu->name);
 		kfree(iommu->domain_ids);
 		iommu->domain_ids = NULL;
 		return -ENOMEM;
@@ -1547,7 +1546,7 @@ static int iommu_attach_domain(struct dmar_domain *domain,
 	num = __iommu_attach_domain(domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 	if (num < 0)
-		pr_err("IOMMU: no free domain ids\n");
+		pr_err("%s: No free domain ids\n", iommu->name);
 
 	return num;
 }
@@ -1639,7 +1638,7 @@ static int dmar_init_reserved_ranges(void)
 	iova = reserve_iova(&reserved_iova_list, IOVA_PFN(IOAPIC_RANGE_START),
 		IOVA_PFN(IOAPIC_RANGE_END));
 	if (!iova) {
-		printk(KERN_ERR "Reserve IOAPIC range failed\n");
+		pr_err("Reserve IOAPIC range failed\n");
 		return -ENODEV;
 	}
 
@@ -1655,7 +1654,7 @@ static int dmar_init_reserved_ranges(void)
 					    IOVA_PFN(r->start),
 					    IOVA_PFN(r->end));
 			if (!iova) {
-				printk(KERN_ERR "Reserve iova failed\n");
+				pr_err("Reserve iova failed\n");
 				return -ENODEV;
 			}
 		}
@@ -1702,7 +1701,7 @@ static int domain_init(struct dmar_domain *domain, int guest_width)
 	sagaw = cap_sagaw(iommu->cap);
 	if (!test_bit(agaw, &sagaw)) {
 		/* hardware doesn't support it, choose a bigger one */
-		pr_debug("IOMMU: hardware doesn't support agaw %d\n", agaw);
+		pr_debug("Hardware doesn't support agaw %d\n", agaw);
 		agaw = find_next_bit(&sagaw, 5, agaw);
 		if (agaw >= 5)
 			return -ENODEV;
@@ -1803,7 +1802,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			id = iommu_attach_vm_domain(domain, iommu);
 			if (id < 0) {
 				spin_unlock_irqrestore(&iommu->lock, flags);
-				pr_err("IOMMU: no free domain ids\n");
+				pr_err("%s: No free domain ids\n", iommu->name);
 				return -EFAULT;
 			}
 		}
@@ -2030,8 +2029,8 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 		tmp = cmpxchg64_local(&pte->val, 0ULL, pteval);
 		if (tmp) {
 			static int dumps = 5;
-			printk(KERN_CRIT "ERROR: DMA PTE for vPFN 0x%lx already set (to %llx not %llx)\n",
-			       iov_pfn, tmp, (unsigned long long)pteval);
+			pr_crit("ERROR: DMA PTE for vPFN 0x%lx already set (to %llx not %llx)\n",
+				iov_pfn, tmp, (unsigned long long)pteval);
 			if (dumps) {
 				dumps--;
 				debug_dma_dump_mappings(NULL);
@@ -2303,7 +2302,7 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 
 	if (!reserve_iova(&domain->iovad, dma_to_mm_pfn(first_vpfn),
 			  dma_to_mm_pfn(last_vpfn))) {
-		printk(KERN_ERR "IOMMU: reserve iova failed\n");
+		pr_err("Reserving iova failed\n");
 		return -ENOMEM;
 	}
 
@@ -2336,15 +2335,14 @@ static int iommu_prepare_identity_map(struct device *dev,
 	   range which is reserved in E820, so which didn't get set
 	   up to start with in si_domain */
 	if (domain == si_domain && hw_pass_through) {
-		printk("Ignoring identity map for HW passthrough device %s [0x%Lx - 0x%Lx]\n",
-		       dev_name(dev), start, end);
+		pr_warn("Ignoring identity map for HW passthrough device %s [0x%Lx - 0x%Lx]\n",
+			dev_name(dev), start, end);
 		return 0;
 	}
 
-	printk(KERN_INFO
-	       "IOMMU: Setting identity map for device %s [0x%Lx - 0x%Lx]\n",
-	       dev_name(dev), start, end);
-	
+	pr_info("Setting identity map for device %s [0x%Lx - 0x%Lx]\n",
+		dev_name(dev), start, end);
+
 	if (end < start) {
 		WARN(1, "Your BIOS is broken; RMRR ends before it starts!\n"
 			"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
@@ -2401,12 +2399,11 @@ static inline void iommu_prepare_isa(void)
 	if (!pdev)
 		return;
 
-	printk(KERN_INFO "IOMMU: Prepare 0-16MiB unity mapping for LPC\n");
+	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
 	ret = iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - 1);
 
 	if (ret)
-		printk(KERN_ERR "IOMMU: Failed to create 0-16MiB identity map; "
-		       "floppy might not work\n");
+		pr_err("Failed to create 0-16MiB identity map - floppy might not work\n");
 
 	pci_dev_put(pdev);
 }
@@ -2450,7 +2447,7 @@ static int __init si_domain_init(int hw)
 		return -EFAULT;
 	}
 
-	pr_debug("IOMMU: identity mapping domain is domain %d\n",
+	pr_debug("Identity mapping domain is domain %d\n",
 		 si_domain->id);
 
 	if (hw)
@@ -2650,8 +2647,8 @@ static int __init dev_prepare_static_identity_mapping(struct device *dev, int hw
 				  hw ? CONTEXT_TT_PASS_THROUGH :
 				       CONTEXT_TT_MULTI_LEVEL);
 	if (!ret)
-		pr_info("IOMMU: %s identity mapping for device %s\n",
-			hw ? "hardware" : "software", dev_name(dev));
+		pr_info("%s identity mapping for device %s\n",
+			hw ? "Hardware" : "Software", dev_name(dev));
 	else if (ret == -ENODEV)
 		/* device not associated with an iommu */
 		ret = 0;
@@ -2728,12 +2725,12 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 		 */
 		iommu->flush.flush_context = __iommu_flush_context;
 		iommu->flush.flush_iotlb = __iommu_flush_iotlb;
-		pr_info("IOMMU: %s using Register based invalidation\n",
+		pr_info("%s: Using Register based invalidation\n",
 			iommu->name);
 	} else {
 		iommu->flush.flush_context = qi_flush_context;
 		iommu->flush.flush_iotlb = qi_flush_iotlb;
-		pr_info("IOMMU: %s using Queued invalidation\n", iommu->name);
+		pr_info("%s: Using Queued invalidation\n", iommu->name);
 	}
 }
 
@@ -2761,8 +2758,7 @@ static int __init init_dmars(void)
 			g_num_of_iommus++;
 			continue;
 		}
-		printk_once(KERN_ERR "intel-iommu: exceeded %d IOMMUs\n",
-			  DMAR_UNITS_SUPPORTED);
+		pr_err_once("Exceeded %d IOMMUs\n", DMAR_UNITS_SUPPORTED);
 	}
 
 	/* Preallocate enough resources for IOMMU hot-addition */
@@ -2772,7 +2768,7 @@ static int __init init_dmars(void)
 	g_iommus = kcalloc(g_num_of_iommus, sizeof(struct intel_iommu *),
 			GFP_KERNEL);
 	if (!g_iommus) {
-		printk(KERN_ERR "Allocating global iommu array failed\n");
+		pr_err("Allocating global iommu array failed\n");
 		ret = -ENOMEM;
 		goto error;
 	}
@@ -2823,7 +2819,7 @@ static int __init init_dmars(void)
 	if (iommu_identity_mapping) {
 		ret = iommu_prepare_static_identity_mapping(hw_pass_through);
 		if (ret) {
-			printk(KERN_CRIT "Failed to setup IOMMU pass-through\n");
+			pr_crit("Failed to setup IOMMU pass-through\n");
 			goto free_iommu;
 		}
 	}
@@ -2841,15 +2837,14 @@ static int __init init_dmars(void)
 	 *    endfor
 	 * endfor
 	 */
-	printk(KERN_INFO "IOMMU: Setting RMRR:\n");
+	pr_info("Setting RMRR:\n");
 	for_each_rmrr_units(rmrr) {
 		/* some BIOS lists non-exist devices in DMAR table. */
 		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
 					  i, dev) {
 			ret = iommu_prepare_rmrr_dev(rmrr, dev);
 			if (ret)
-				printk(KERN_ERR
-				       "IOMMU: mapping reserved region failed\n");
+				pr_err("Mapping reserved region failed\n");
 		}
 	}
 
@@ -2924,7 +2919,7 @@ static struct iova *intel_alloc_iova(struct device *dev,
 	}
 	iova = alloc_iova(&domain->iovad, nrpages, IOVA_PFN(dma_mask), 1);
 	if (unlikely(!iova)) {
-		printk(KERN_ERR "Allocating %ld-page iova for %s failed",
+		pr_err("Allocating %ld-page iova for %s failed",
 		       nrpages, dev_name(dev));
 		return NULL;
 	}
@@ -2939,7 +2934,7 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 
 	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
 	if (!domain) {
-		printk(KERN_ERR "Allocating domain for %s failed",
+		pr_err("Allocating domain for %s failed\n",
 		       dev_name(dev));
 		return NULL;
 	}
@@ -2948,7 +2943,7 @@ static struct dmar_domain *__get_valid_domain_for_dev(struct device *dev)
 	if (unlikely(!domain_context_mapped(dev))) {
 		ret = domain_context_mapping(domain, dev, CONTEXT_TT_MULTI_LEVEL);
 		if (ret) {
-			printk(KERN_ERR "Domain context map for %s failed",
+			pr_err("Domain context map for %s failed\n",
 			       dev_name(dev));
 			return NULL;
 		}
@@ -2995,8 +2990,8 @@ static int iommu_no_mapping(struct device *dev)
 			 * to non-identity mapping.
 			 */
 			domain_remove_one_dev_info(si_domain, dev);
-			printk(KERN_INFO "32bit %s uses non-identity mapping\n",
-			       dev_name(dev));
+			pr_info("32bit %s uses non-identity mapping\n",
+				dev_name(dev));
 			return 0;
 		}
 	} else {
@@ -3011,8 +3006,8 @@ static int iommu_no_mapping(struct device *dev)
 						  CONTEXT_TT_PASS_THROUGH :
 						  CONTEXT_TT_MULTI_LEVEL);
 			if (!ret) {
-				printk(KERN_INFO "64bit %s uses identity mapping\n",
-				       dev_name(dev));
+				pr_info("64bit %s uses identity mapping\n",
+					dev_name(dev));
 				return 1;
 			}
 		}
@@ -3081,7 +3076,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 error:
 	if (iova)
 		__free_iova(&domain->iovad, iova);
-	printk(KERN_ERR"Device %s request: %zx@%llx dir %d --- failed\n",
+	pr_err("Device %s request: %zx@%llx dir %d --- failed\n",
 		dev_name(dev), size, (unsigned long long)paddr, dir);
 	return 0;
 }
@@ -3396,7 +3391,7 @@ static inline int iommu_domain_cache_init(void)
 
 					 NULL);
 	if (!iommu_domain_cache) {
-		printk(KERN_ERR "Couldn't create iommu_domain cache\n");
+		pr_err("Couldn't create iommu_domain cache\n");
 		ret = -ENOMEM;
 	}
 
@@ -3413,7 +3408,7 @@ static inline int iommu_devinfo_cache_init(void)
 					 SLAB_HWCACHE_ALIGN,
 					 NULL);
 	if (!iommu_devinfo_cache) {
-		printk(KERN_ERR "Couldn't create devinfo cache\n");
+		pr_err("Couldn't create devinfo cache\n");
 		ret = -ENOMEM;
 	}
 
@@ -3790,19 +3785,19 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		return 0;
 
 	if (hw_pass_through && !ecap_pass_through(iommu->ecap)) {
-		pr_warn("IOMMU: %s doesn't support hardware pass through.\n",
+		pr_warn("%s: Doesn't support hardware pass through.\n",
 			iommu->name);
 		return -ENXIO;
 	}
 	if (!ecap_sc_support(iommu->ecap) &&
 	    domain_update_iommu_snooping(iommu)) {
-		pr_warn("IOMMU: %s doesn't support snooping.\n",
+		pr_warn("%s: Doesn't support snooping.\n",
 			iommu->name);
 		return -ENXIO;
 	}
 	sp = domain_update_iommu_superpage(iommu) - 1;
 	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
-		pr_warn("IOMMU: %s doesn't support large page.\n",
+		pr_warn("%s: Doesn't support large page.\n",
 			iommu->name);
 		return -ENXIO;
 	}
@@ -4033,7 +4028,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 		start = mhp->start_pfn << PAGE_SHIFT;
 		end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
 		if (iommu_domain_identity_map(si_domain, start, end)) {
-			pr_warn("dmar: failed to build identity map for [%llx-%llx]\n",
+			pr_warn("Failed to build identity map for [%llx-%llx]\n",
 				start, end);
 			return NOTIFY_BAD;
 		}
@@ -4051,7 +4046,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 
 			iova = find_iova(&si_domain->iovad, start_vpfn);
 			if (iova == NULL) {
-				pr_debug("dmar: failed get IOVA for PFN %lx\n",
+				pr_debug("Failed get IOVA for PFN %lx\n",
 					 start_vpfn);
 				break;
 			}
@@ -4059,7 +4054,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 			iova = split_and_remove_iova(&si_domain->iovad, iova,
 						     start_vpfn, last_vpfn);
 			if (iova == NULL) {
-				pr_warn("dmar: failed to split IOVA PFN [%lx-%lx]\n",
+				pr_warn("Failed to split IOVA PFN [%lx-%lx]\n",
 					start_vpfn, last_vpfn);
 				return NOTIFY_BAD;
 			}
@@ -4185,10 +4180,10 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 
 	if (list_empty(&dmar_rmrr_units))
-		printk(KERN_INFO "DMAR: No RMRR found\n");
+		pr_info("No RMRR found\n");
 
 	if (list_empty(&dmar_atsr_units))
-		printk(KERN_INFO "DMAR: No ATSR found\n");
+		pr_info("No ATSR found\n");
 
 	if (dmar_init_reserved_ranges()) {
 		if (force_on)
@@ -4202,12 +4197,11 @@ int __init intel_iommu_init(void)
 	if (ret) {
 		if (force_on)
 			panic("tboot: Failed to initialize DMARs\n");
-		printk(KERN_ERR "IOMMU: dmar init failed\n");
+		pr_err("Initialization failed\n");
 		goto out_free_reserved_range;
 	}
 	up_write(&dmar_global_lock);
-	printk(KERN_INFO
-	"PCI-DMA: Intel(R) Virtualization Technology for Directed I/O\n");
+	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 	init_timer(&unmap_timer);
 #ifdef CONFIG_SWIOTLB
@@ -4349,13 +4343,11 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 
 	dmar_domain = alloc_domain(DOMAIN_FLAG_VIRTUAL_MACHINE);
 	if (!dmar_domain) {
-		printk(KERN_ERR
-			"intel_iommu_domain_init: dmar_domain == NULL\n");
+		pr_err("Can't allocate dmar_domain\n");
 		return NULL;
 	}
 	if (md_domain_init(dmar_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
-		printk(KERN_ERR
-			"intel_iommu_domain_init() failed\n");
+		pr_err("Domain initialization failed\n");
 		domain_exit(dmar_domain);
 		return NULL;
 	}
@@ -4414,7 +4406,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		addr_width = cap_mgaw(iommu->cap);
 
 	if (dmar_domain->max_addr > (1LL << addr_width)) {
-		printk(KERN_ERR "%s: iommu width (%d) is not "
+		pr_err("%s: iommu width (%d) is not "
 		       "sufficient for the mapped address (%llx)\n",
 		       __func__, addr_width, dmar_domain->max_addr);
 		return -EFAULT;
@@ -4468,7 +4460,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
 		/* check if minimum agaw is sufficient for mapped address */
 		end = __DOMAIN_MAX_ADDR(dmar_domain->gaw) + 1;
 		if (end < max_addr) {
-			printk(KERN_ERR "%s: iommu width (%d) is not "
+			pr_err("%s: iommu width (%d) is not "
 			       "sufficient for the mapped address (%llx)\n",
 			       __func__, dmar_domain->gaw, max_addr);
 			return -EFAULT;
@@ -4609,7 +4601,7 @@ static const struct iommu_ops intel_iommu_ops = {
 static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
 {
 	/* G4x/GM45 integrated gfx dmar support is totally busted. */
-	printk(KERN_INFO "DMAR: Disabling IOMMU for graphics on this chipset\n");
+	pr_info("Disabling IOMMU for graphics on this chipset\n");
 	dmar_map_gfx = 0;
 }
 
@@ -4627,7 +4619,7 @@ static void quirk_iommu_rwbf(struct pci_dev *dev)
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
 	 * but needs it. Same seems to hold for the desktop versions.
 	 */
-	printk(KERN_INFO "DMAR: Forcing write-buffer flush capability\n");
+	pr_info("Forcing write-buffer flush capability\n");
 	rwbf_quirk = 1;
 }
 
@@ -4657,11 +4649,11 @@ static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 		return;
 
 	if (!(ggc & GGC_MEMORY_VT_ENABLED)) {
-		printk(KERN_INFO "DMAR: BIOS has allocated no shadow GTT; disabling IOMMU for graphics\n");
+		pr_info("BIOS has allocated no shadow GTT; disabling IOMMU for graphics\n");
 		dmar_map_gfx = 0;
 	} else if (dmar_map_gfx) {
 		/* we have to ensure the gfx device is idle before we flush */
-		printk(KERN_INFO "DMAR: Disabling batched IOTLB flush on Ironlake\n");
+		pr_info("Disabling batched IOTLB flush on Ironlake\n");
 		intel_iommu_strict = 1;
        }
 }
@@ -4723,7 +4715,7 @@ static void __init check_tylersburg_isoch(void)
 		iommu_identity_mapping |= IDENTMAP_AZALIA;
 		return;
 	}
-	
-	printk(KERN_WARNING "DMAR: Recommended TLB entries for ISOCH unit is 16; your BIOS set %d\n",
+
+	pr_warn("Recommended TLB entries for ISOCH unit is 16; your BIOS set %d\n",
 	       vtisochctrl);
 }
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 5709ae9..3fe3fc7 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1,3 +1,6 @@
+
+#define pr_fmt(fmt)     "DMAR-IR: " fmt
+
 #include <linux/interrupt.h>
 #include <linux/dmar.h>
 #include <linux/spinlock.h>
@@ -100,8 +103,7 @@ static int alloc_irte(struct intel_iommu *iommu, int irq, u16 count)
 	}
 
 	if (mask > ecap_max_handle_mask(iommu->ecap)) {
-		printk(KERN_ERR
-		       "Requested mask %x exceeds the max invalidation handle"
+		pr_err("Requested mask %x exceeds the max invalidation handle"
 		       " mask value %Lx\n", mask,
 		       ecap_max_handle_mask(iommu->ecap));
 		return -1;
@@ -333,7 +335,7 @@ static int set_ioapic_sid(struct irte *irte, int apic)
 	up_read(&dmar_global_lock);
 
 	if (sid == 0) {
-		pr_warning("Failed to set source-id of IOAPIC (%d)\n", apic);
+		pr_warn("Failed to set source-id of IOAPIC (%d)\n", apic);
 		return -1;
 	}
 
@@ -360,7 +362,7 @@ static int set_hpet_sid(struct irte *irte, u8 id)
 	up_read(&dmar_global_lock);
 
 	if (sid == 0) {
-		pr_warning("Failed to set source-id of HPET block (%d)\n", id);
+		pr_warn("Failed to set source-id of HPET block (%d)\n", id);
 		return -1;
 	}
 
@@ -580,7 +582,7 @@ static void __init intel_cleanup_irq_remapping(void)
 	}
 
 	if (x2apic_supported())
-		pr_warn("Failed to enable irq remapping.  You are vulnerable to irq-injection attacks.\n");
+		pr_warn("Failed to enable irq remapping. You are vulnerable to irq-injection attacks.\n");
 }
 
 static int __init intel_prepare_irq_remapping(void)
@@ -589,8 +591,7 @@ static int __init intel_prepare_irq_remapping(void)
 	struct intel_iommu *iommu;
 
 	if (irq_remap_broken) {
-		printk(KERN_WARNING
-			"This system BIOS has enabled interrupt remapping\n"
+		pr_warn("This system BIOS has enabled interrupt remapping\n"
 			"on a chipset that contains an erratum making that\n"
 			"feature unstable.  To maintain system stability\n"
 			"interrupt remapping is being disabled.  Please\n"
@@ -606,7 +607,7 @@ static int __init intel_prepare_irq_remapping(void)
 		return -ENODEV;
 
 	if (parse_ioapics_under_ir() != 1) {
-		printk(KERN_INFO "Not enabling interrupt remapping\n");
+		pr_info("Not enabling interrupt remapping\n");
 		goto error;
 	}
 
@@ -667,8 +668,8 @@ static int __init intel_enable_irq_remapping(void)
 	 */
 	for_each_iommu(iommu, drhd)
 		if (eim && !ecap_eim_support(iommu->ecap)) {
-			printk(KERN_INFO "DRHD %Lx: EIM not supported by DRHD, "
-			       " ecap %Lx\n", drhd->reg_base_addr, iommu->ecap);
+			pr_info("DRHD %Lx: EIM not supported by DRHD, "
+				" ecap %Lx\n", drhd->reg_base_addr, iommu->ecap);
 			eim = 0;
 		}
 	eim_mode = eim;
@@ -682,7 +683,7 @@ static int __init intel_enable_irq_remapping(void)
 		int ret = dmar_enable_qi(iommu);
 
 		if (ret) {
-			printk(KERN_ERR "DRHD %Lx: failed to enable queued, "
+			pr_err("DRHD %Lx: failed to enable queued, "
 			       " invalidation, ecap %Lx, ret %d\n",
 			       drhd->reg_base_addr, iommu->ecap, ret);
 			goto error;
@@ -1145,14 +1146,12 @@ static int intel_msi_alloc_irq(struct pci_dev *dev, int irq, int nvec)
 	down_read(&dmar_global_lock);
 	iommu = map_dev_to_ir(dev);
 	if (!iommu) {
-		printk(KERN_ERR
-		       "Unable to map PCI %s to iommu\n", pci_name(dev));
+		pr_err("Unable to map PCI %s to iommu\n", pci_name(dev));
 		index = -ENOENT;
 	} else {
 		index = alloc_irte(iommu, irq, nvec);
 		if (index < 0) {
-			printk(KERN_ERR
-			       "Unable to allocate %d IRTE for PCI %s\n",
+			pr_err("Unable to allocate %d IRTE for PCI %s\n",
 			       nvec, pci_name(dev));
 			index = -ENOSPC;
 		}
-- 
1.9.1
