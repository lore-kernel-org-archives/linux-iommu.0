Return-Path: <SRS0=A6MP=2O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C3CC2D0D2
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C2620706
	for <iommu@archiver.kernel.org>; Tue, 24 Dec 2019 07:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C2620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8CEE585712;
	Tue, 24 Dec 2019 07:46:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z1h22w6tFOaO; Tue, 24 Dec 2019 07:46:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E166485650;
	Tue, 24 Dec 2019 07:46:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2A25C1D81;
	Tue, 24 Dec 2019 07:46:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DC94C0881
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1AB3B85650
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EbKLYH8S80NP for <iommu@lists.linux-foundation.org>;
 Tue, 24 Dec 2019 07:46:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5E6A085321
 for <iommu@lists.linux-foundation.org>; Tue, 24 Dec 2019 07:46:31 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Dec 2019 23:46:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,350,1571727600"; d="scan'208";a="223177103"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2019 23:46:29 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v5 9/9] iommu/vt-d: debugfs: Add support to show page table
 internals
Date: Tue, 24 Dec 2019 15:45:02 +0800
Message-Id: <20191224074502.5545-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191224074502.5545-1-baolu.lu@linux.intel.com>
References: <20191224074502.5545-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Export page table internals of the domain attached to each device.
Example of such dump on a Skylake machine:

$ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
[ ... ]
Device 0000:00:14.0 with pasid 0 @0x15f3d9000
IOVA_PFN                PML5E                   PML4E
0x000000008ced0 |       0x0000000000000000      0x000000015f3da003
0x000000008ced1 |       0x0000000000000000      0x000000015f3da003
0x000000008ced2 |       0x0000000000000000      0x000000015f3da003
0x000000008ced3 |       0x0000000000000000      0x000000015f3da003
0x000000008ced4 |       0x0000000000000000      0x000000015f3da003
0x000000008ced5 |       0x0000000000000000      0x000000015f3da003
0x000000008ced6 |       0x0000000000000000      0x000000015f3da003
0x000000008ced7 |       0x0000000000000000      0x000000015f3da003
0x000000008ced8 |       0x0000000000000000      0x000000015f3da003
0x000000008ced9 |       0x0000000000000000      0x000000015f3da003

PDPE                    PDE                     PTE
0x000000015f3db003      0x000000015f3dc003      0x000000008ced0003
0x000000015f3db003      0x000000015f3dc003      0x000000008ced1003
0x000000015f3db003      0x000000015f3dc003      0x000000008ced2003
0x000000015f3db003      0x000000015f3dc003      0x000000008ced3003
0x000000015f3db003      0x000000015f3dc003      0x000000008ced4003
0x000000015f3db003      0x000000015f3dc003      0x000000008ced5003
0x000000015f3db003      0x000000015f3dc003      0x000000008ced6003
0x000000015f3db003      0x000000015f3dc003      0x000000008ced7003
0x000000015f3db003      0x000000015f3dc003      0x000000008ced8003
0x000000015f3db003      0x000000015f3dc003      0x000000008ced9003
[ ... ]

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu-debugfs.c | 75 +++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c         |  4 +-
 include/linux/intel-iommu.h         |  2 +
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index 471f05d452e0..c1257bef553c 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -5,6 +5,7 @@
  * Authors: Gayatri Kammela <gayatri.kammela@intel.com>
  *	    Sohil Mehta <sohil.mehta@intel.com>
  *	    Jacob Pan <jacob.jun.pan@linux.intel.com>
+ *	    Lu Baolu <baolu.lu@linux.intel.com>
  */
 
 #include <linux/debugfs.h>
@@ -283,6 +284,77 @@ static int dmar_translation_struct_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(dmar_translation_struct);
 
+static inline unsigned long level_to_directory_size(int level)
+{
+	return BIT_ULL(VTD_PAGE_SHIFT + VTD_STRIDE_SHIFT * (level - 1));
+}
+
+static inline void
+dump_page_info(struct seq_file *m, unsigned long iova, u64 *path)
+{
+	seq_printf(m, "0x%013lx |\t0x%016llx\t0x%016llx\t0x%016llx\t0x%016llx\t0x%016llx\n",
+		   iova >> VTD_PAGE_SHIFT, path[5], path[4],
+		   path[3], path[2], path[1]);
+}
+
+static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
+			       int level, unsigned long start,
+			       u64 *path)
+{
+	int i;
+
+	if (level > 5 || level < 1)
+		return;
+
+	for (i = 0; i < BIT_ULL(VTD_STRIDE_SHIFT);
+			i++, pde++, start += level_to_directory_size(level)) {
+		if (!dma_pte_present(pde))
+			continue;
+
+		path[level] = pde->val;
+		if (dma_pte_superpage(pde) || level == 1)
+			dump_page_info(m, start, path);
+		else
+			pgtable_walk_level(m, phys_to_virt(dma_pte_addr(pde)),
+					   level - 1, start, path);
+		path[level] = 0;
+	}
+}
+
+static int show_device_domain_translation(struct device *dev, void *data)
+{
+	struct dmar_domain *domain = find_domain(dev);
+	struct seq_file *m = data;
+	u64 path[6] = { 0 };
+
+	if (!domain)
+		return 0;
+
+	seq_printf(m, "Device %s with pasid %d @0x%llx\n",
+		   dev_name(dev), domain->default_pasid,
+		   (u64)virt_to_phys(domain->pgd));
+	seq_puts(m, "IOVA_PFN\t\tPML5E\t\t\tPML4E\t\t\tPDPE\t\t\tPDE\t\t\tPTE\n");
+
+	pgtable_walk_level(m, domain->pgd, domain->agaw + 2, 0, path);
+	seq_putc(m, '\n');
+
+	return 0;
+}
+
+static int domain_translation_struct_show(struct seq_file *m, void *unused)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	ret = bus_for_each_dev(&pci_bus_type, NULL, m,
+			       show_device_domain_translation);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
+
 #ifdef CONFIG_IRQ_REMAP
 static void ir_tbl_remap_entry_show(struct seq_file *m,
 				    struct intel_iommu *iommu)
@@ -396,6 +468,9 @@ void __init intel_iommu_debugfs_init(void)
 			    &iommu_regset_fops);
 	debugfs_create_file("dmar_translation_struct", 0444, intel_iommu_debug,
 			    NULL, &dmar_translation_struct_fops);
+	debugfs_create_file("domain_translation_struct", 0444,
+			    intel_iommu_debug, NULL,
+			    &domain_translation_struct_fops);
 #ifdef CONFIG_IRQ_REMAP
 	debugfs_create_file("ir_translation_struct", 0444, intel_iommu_debug,
 			    NULL, &ir_translation_struct_fops);
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 51d60bad0b1d..609931f6d771 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -396,7 +396,7 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
 #define DUMMY_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-1))
 #define DEFER_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-2))
-static DEFINE_SPINLOCK(device_domain_lock);
+DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
 #define device_needs_bounce(d) (!intel_no_bounce && dev_is_pci(d) &&	\
@@ -2513,7 +2513,7 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-static struct dmar_domain *find_domain(struct device *dev)
+struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 3a4708a8a414..4a16b39ae353 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -441,6 +441,7 @@ enum {
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
 extern int intel_iommu_sm;
+extern spinlock_t device_domain_lock;
 
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
@@ -663,6 +664,7 @@ int for_each_device_domain(int (*fn)(struct device_domain_info *info,
 				     void *data), void *data);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
+struct dmar_domain *find_domain(struct device *dev);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 extern void intel_svm_check(struct intel_iommu *iommu);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
