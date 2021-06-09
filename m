Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D7CC48BCF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 08:33:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4B961285
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 08:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4B961285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A25D83C0E;
	Wed,  9 Jun 2021 08:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FtnA5U-AzkVY; Wed,  9 Jun 2021 08:33:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 85F4C83C12;
	Wed,  9 Jun 2021 08:33:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57AADC000D;
	Wed,  9 Jun 2021 08:33:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1A8CC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C439402B2
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:33:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VZv0eCdJNKiW for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 08:33:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04A35402BB
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 08:33:08 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0Kzr2b5DzZf1j;
 Wed,  9 Jun 2021 16:30:16 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 16:33:06 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 16:33:05 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Yong Wu <yong.wu@mediatek.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 "Chen-Yu Tsai" <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 iommu <iommu@lists.linux-foundation.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, linux-mediatek
 <linux-mediatek@lists.infradead.org>, linux-sunxi
 <linux-sunxi@lists.linux.dev>
Subject: [PATCH v3 2/2] iommu: Fix spelling mistakes
Date: Wed, 9 Jun 2021 16:32:51 +0800
Message-ID: <20210609083251.13827-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210609083251.13827-1-thunder.leizhen@huawei.com>
References: <20210609083251.13827-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Fix some spelling mistakes in comments found by "codespell":
alignement ==> alignment
implemtation ==> implementation
assignement ==> assignment
initally ==> initially
Returs ==> Returns
Traverese ==> Traverse
guarentees ==> guarantees
resgister ==> register
insufficent ==> insufficient
Specifiction ==> Specification
creats ==> creates
tabke ==> table
shuld ==> should
requeset ==> request
funcions ==> functions
distiguish ==> distinguish
phyiscal ==> physical
Uppon ==> Upon
consits ==> consists

And two were discovered manually by John Garry and Will Deacon:
appropriatley ==> appropriately
Additionally, The ==> Additionally, the

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/amd/amd_iommu_types.h   | 2 +-
 drivers/iommu/amd/init.c              | 2 +-
 drivers/iommu/amd/iommu.c             | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 drivers/iommu/fsl_pamu.c              | 2 +-
 drivers/iommu/fsl_pamu_domain.c       | 2 +-
 drivers/iommu/intel/dmar.c            | 8 ++++----
 drivers/iommu/intel/iommu.c           | 2 +-
 drivers/iommu/intel/irq_remapping.c   | 2 +-
 drivers/iommu/intel/svm.c             | 4 ++--
 drivers/iommu/iommu.c                 | 6 +++---
 drivers/iommu/mtk_iommu.c             | 4 ++--
 drivers/iommu/omap-iommu.c            | 2 +-
 drivers/iommu/sun50i-iommu.c          | 2 +-
 14 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 94c1a7a9876d..67a6c2fb4de9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -446,7 +446,7 @@ extern struct irq_remap_table **irq_lookup_table;
 /* Interrupt remapping feature used? */
 extern bool amd_iommu_irq_remap;
 
-/* kmem_cache to get tables with 128 byte alignement */
+/* kmem_cache to get tables with 128 byte alignment */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
 /*
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 4e4fb0f4e412..52d450962288 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2040,7 +2040,7 @@ static int intcapxt_irqdomain_activate(struct irq_domain *domain,
 	xt.destid_24_31 = cfg->dest_apicid >> 24;
 
 	/**
-	 * Current IOMMU implemtation uses the same IRQ for all
+	 * Current IOMMU implementation uses the same IRQ for all
 	 * 3 IOMMU interrupts.
 	 */
 	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b1fbf2c83df5..1b635d4c2142 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1809,7 +1809,7 @@ int __init amd_iommu_init_api(void)
  * The following functions belong to the exported interface of AMD IOMMU
  *
  * This interface allows access to lower level functions of the IOMMU
- * like protection domain handling and assignement of devices to domains
+ * like protection domain handling and assignment of devices to domains
  * which is not possible with the dma_ops interface.
  *
  *****************************************************************************/
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index dba15f312cbd..79db6e8c5e31 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1360,7 +1360,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		ret = arm_smmu_register_legacy_master(dev, &smmu);
 
 		/*
-		 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
+		 * If dev->iommu_fwspec is initially NULL, arm_smmu_register_legacy_master()
 		 * will allocate/initialise a new one. Thus we need to update fwspec for
 		 * later use.
 		 */
diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index fc38b1fba7cf..53aff2766367 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -246,7 +246,7 @@ void get_ome_index(u32 *omi_index, struct device *dev)
  * @stash_dest_hint: L1, L2 or L3
  * @vcpu: vpcu target for a particular cache type.
  *
- * Returs stash on success or ~(u32)0 on failure.
+ * Returns stash on success or ~(u32)0 on failure.
  *
  */
 u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index a47f47307109..2da312645279 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -363,7 +363,7 @@ static struct iommu_group *get_shared_pci_device_group(struct pci_dev *pdev)
 	struct pci_bus *bus = pdev->bus;
 
 	/*
-	 * Traverese the pci bus device list to get
+	 * Traverse the pci bus device list to get
 	 * the shared iommu group.
 	 */
 	while (bus) {
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 84057cb9596c..e1626f5eb689 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -45,7 +45,7 @@ struct dmar_res_callback {
 
 /*
  * Assumptions:
- * 1) The hotplug framework guarentees that DMAR unit will be hot-added
+ * 1) The hotplug framework guarantees that DMAR unit will be hot-added
  *    before IO devices managed by that unit.
  * 2) The hotplug framework guarantees that DMAR unit will be hot-removed
  *    after IO devices managed by that unit.
@@ -960,10 +960,10 @@ static void unmap_iommu(struct intel_iommu *iommu)
 /**
  * map_iommu: map the iommu's registers
  * @iommu: the iommu to map
- * @phys_addr: the physical address of the base resgister
+ * @phys_addr: the physical address of the base register
  *
  * Memory map the iommu's registers.  Start w/ a single page, and
- * possibly expand if that turns out to be insufficent.
+ * possibly expand if that turns out to be insufficient.
  */
 static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 {
@@ -2128,7 +2128,7 @@ IOMMU_INIT_POST(detect_intel_iommu);
 /*
  * DMAR Hotplug Support
  * For more details, please refer to Intel(R) Virtualization Technology
- * for Directed-IO Architecture Specifiction, Rev 2.2, Section 8.8
+ * for Directed-IO Architecture Specification, Rev 2.2, Section 8.8
  * "Remapping Hardware Unit Hot Plug".
  */
 static guid_t dmar_hp_guid =
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be35284a2016..80221f836ae8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -288,7 +288,7 @@ static inline void context_clear_entry(struct context_entry *context)
 
 /*
  * This domain is a statically identity mapping domain.
- *	1. This domain creats a static 1:1 mapping to all usable memory.
+ *	1. This domain creates a static 1:1 mapping to all usable memory.
  * 	2. It maps to each iommu if successful.
  *	3. Each iommu mapps to this domain if successful.
  */
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index f912fe45bea2..d66210308ede 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -74,7 +74,7 @@ static struct hpet_scope ir_hpet[MAX_HPET_TBS];
  *	->iommu->register_lock
  * Note:
  * intel_irq_remap_ops.{supported,prepare,enable,disable,reenable} are called
- * in single-threaded environment with interrupt disabled, so no need to tabke
+ * in single-threaded environment with interrupt disabled, so no need to take
  * the dmar_global_lock.
  */
 DEFINE_RAW_SPINLOCK(irq_2_ir_lock);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5165cea90421..da69a214ea12 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -485,7 +485,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 	} else
 		pasid_max = 1 << 20;
 
-	/* Bind supervisor PASID shuld have mm = NULL */
+	/* Bind supervisor PASID should have mm = NULL */
 	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
 		if (!ecap_srs(iommu->ecap) || mm) {
 			pr_err("Supervisor PASID with user provided mm.\n");
@@ -917,7 +917,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			/* No need to find the matching sdev as for bad_req */
 			goto no_pasid;
 		}
-		/* DMA read with exec requeset is not supported. */
+		/* DMA read with exec request is not supported. */
 		if (req->exe_req && req->rd_req) {
 			pr_err("Execution request not supported\n");
 			goto no_pasid;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df5..971068da67cb 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1479,7 +1479,7 @@ struct iommu_group *pci_device_group(struct device *dev)
 
 	/*
 	 * Look for existing groups on non-isolated functions on the same
-	 * slot and aliases of those funcions, if any.  No need to clear
+	 * slot and aliases of those functions, if any.  No need to clear
 	 * the search bitmap, the tested devfns are still valid.
 	 */
 	group = get_pci_function_alias_group(pdev, (unsigned long *)devfns);
@@ -2285,7 +2285,7 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
  * iterating over the devices in a group.  Ideally we'd have a single
  * device which represents the requestor ID of the group, but we also
  * allow IOMMU drivers to create policy defined minimum sets, where
- * the physical hardware may be able to distiguish members, but we
+ * the physical hardware may be able to distinguish members, but we
  * wish to group them at a higher level (ex. untrusted multi-function
  * PCI devices).  Thus we attach each device.
  */
@@ -3152,7 +3152,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	 */
 	mutex_unlock(&group->mutex);
 
-	/* Make sure dma_ops is appropriatley set */
+	/* Make sure dma_ops is appropriately set */
 	iommu_group_do_probe_finalize(dev, group->default_domain);
 	iommu_domain_free(prev_dom);
 	return 0;
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6f7c69688ce2..0d2e13d957e1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -160,7 +160,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
  * The Region 'A'(I/O) can NOT be mapped by M4U; For Region 'B'/'C'/'D', the
  * bit32 of the CPU physical address always is needed to set, and for Region
  * 'E', the CPU physical address keep as is.
- * Additionally, The iommu consumers always use the CPU phyiscal address.
+ * Additionally, the iommu consumers always use the CPU physical address.
  */
 #define MTK_IOMMU_4GB_MODE_REMAP_BASE	 0x140000000UL
 
@@ -974,7 +974,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	}
 
 	/*
-	 * Uppon first resume, only enable the clk and return, since the values of the
+	 * Upon first resume, only enable the clk and return, since the values of the
 	 * registers are not yet set.
 	 */
 	if (!m4u_dom)
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 91749654fd49..c5bcf3e577cd 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1750,7 +1750,7 @@ static int __init omap_iommu_init(void)
 {
 	struct kmem_cache *p;
 	const slab_flags_t flags = SLAB_HWCACHE_ALIGN;
-	size_t align = 1 << 10; /* L2 pagetable alignement */
+	size_t align = 1 << 10; /* L2 pagetable alignment */
 	struct device_node *np;
 	int ret;
 
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 181bb1c3437c..a28a44e21669 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -149,7 +149,7 @@ static void iommu_write(struct sun50i_iommu *iommu, u32 offset, u32 value)
  * 4096 4-bytes Directory Table Entries (DTE), each pointing to a Page
  * Table (PT).
  *
- * Each PT consits of 256 4-bytes Page Table Entries (PTE), each
+ * Each PT consists of 256 4-bytes Page Table Entries (PTE), each
  * pointing to a 4kB page of physical memory.
  *
  * The IOMMU supports a single DT, pointed by the IOMMU_TTB_REG
-- 
2.25.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
