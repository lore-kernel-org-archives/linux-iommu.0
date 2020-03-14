Return-Path: <SRS0=cr9L=47=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FD8C5ACBF
	for <iommu@archiver.kernel.org>; Sat, 14 Mar 2020 01:10:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E0D2074C
	for <iommu@archiver.kernel.org>; Sat, 14 Mar 2020 01:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E0D2074C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6E315886A0;
	Sat, 14 Mar 2020 01:10:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g-GMTRfm8hhf; Sat, 14 Mar 2020 01:10:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 341D0881BC;
	Sat, 14 Mar 2020 01:10:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B6F6C18D3;
	Sat, 14 Mar 2020 01:10:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 661CEC0177
 for <iommu@lists.linux-foundation.org>; Sat, 14 Mar 2020 01:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5C1C3881BE
 for <iommu@lists.linux-foundation.org>; Sat, 14 Mar 2020 01:10:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m73w4e+HNck6 for <iommu@lists.linux-foundation.org>;
 Sat, 14 Mar 2020 01:10:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 30918881BC
 for <iommu@lists.linux-foundation.org>; Sat, 14 Mar 2020 01:10:00 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 18:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,550,1574150400"; d="scan'208";a="266912440"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2020 18:09:56 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 5/6] iommu/vt-d: Add def_domain_type callback
Date: Sat, 14 Mar 2020 09:07:04 +0800
Message-Id: <20200314010705.30711-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314010705.30711-1-baolu.lu@linux.intel.com>
References: <20200314010705.30711-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

Add vt-d specific def_domain_type callback and remove the unnecessary
homemade private domain implementation.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 311 ++----------------------------------
 1 file changed, 11 insertions(+), 300 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 351a83f40527..ef5fa70d8a3c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -299,27 +299,19 @@ static int hw_pass_through = 1;
 /* si_domain contains mulitple devices */
 #define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
 
-/*
- * This is a DMA domain allocated through the iommu domain allocation
- * interface. But one or more devices belonging to this domain have
- * been chosen to use a private domain. We should avoid to use the
- * map/unmap/iova_to_phys APIs on it.
- */
-#define DOMAIN_FLAG_LOSE_CHILDREN		BIT(1)
-
 /*
  * When VT-d works in the scalable mode, it allows DMA translation to
  * happen through either first level or second level page table. This
  * bit marks that the DMA translation for the domain goes through the
  * first level page table, otherwise, it goes through the second level.
  */
-#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(2)
+#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(1)
 
 /*
  * Domain represents a virtual machine which demands iommu nested
  * translation mode support.
  */
-#define DOMAIN_FLAG_NESTING_MODE		BIT(3)
+#define DOMAIN_FLAG_NESTING_MODE		BIT(2)
 
 #define for_each_domain_iommu(idx, domain)			\
 	for (idx = 0; idx < g_num_of_iommus; idx++)		\
@@ -355,11 +347,6 @@ static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
-static void domain_context_clear(struct intel_iommu *iommu,
-				 struct device *dev);
-static int domain_detach_iommu(struct dmar_domain *domain,
-			       struct intel_iommu *iommu);
-static bool device_is_rmrr_locked(struct device *dev);
 static int intel_iommu_attach_device(struct iommu_domain *domain,
 				     struct device *dev);
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
@@ -1930,65 +1917,6 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 	return agaw;
 }
 
-static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
-		       int guest_width)
-{
-	int adjust_width, agaw;
-	unsigned long sagaw;
-	int ret;
-
-	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
-
-	if (!intel_iommu_strict) {
-		ret = init_iova_flush_queue(&domain->iovad,
-					    iommu_flush_iova, iova_entry_free);
-		if (ret)
-			pr_info("iova flush queue initialization failed\n");
-	}
-
-	domain_reserve_special_ranges(domain);
-
-	/* calculate AGAW */
-	if (guest_width > cap_mgaw(iommu->cap))
-		guest_width = cap_mgaw(iommu->cap);
-	domain->gaw = guest_width;
-	adjust_width = guestwidth_to_adjustwidth(guest_width);
-	agaw = width_to_agaw(adjust_width);
-	sagaw = cap_sagaw(iommu->cap);
-	if (!test_bit(agaw, &sagaw)) {
-		/* hardware doesn't support it, choose a bigger one */
-		pr_debug("Hardware doesn't support agaw %d\n", agaw);
-		agaw = find_next_bit(&sagaw, 5, agaw);
-		if (agaw >= 5)
-			return -ENODEV;
-	}
-	domain->agaw = agaw;
-
-	if (ecap_coherent(iommu->ecap))
-		domain->iommu_coherency = 1;
-	else
-		domain->iommu_coherency = 0;
-
-	if (ecap_sc_support(iommu->ecap))
-		domain->iommu_snooping = 1;
-	else
-		domain->iommu_snooping = 0;
-
-	if (intel_iommu_superpage)
-		domain->iommu_superpage = fls(cap_super_page_val(iommu->cap));
-	else
-		domain->iommu_superpage = 0;
-
-	domain->nid = iommu->node;
-
-	/* always allocate the top pgd */
-	domain->pgd = (struct dma_pte *)alloc_pgtable_page(domain->nid);
-	if (!domain->pgd)
-		return -ENOMEM;
-	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
-	return 0;
-}
-
 static void domain_exit(struct dmar_domain *domain)
 {
 
@@ -2704,94 +2632,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	return domain;
 }
 
-static int get_last_alias(struct pci_dev *pdev, u16 alias, void *opaque)
-{
-	*(u16 *)opaque = alias;
-	return 0;
-}
-
-static struct dmar_domain *find_or_alloc_domain(struct device *dev, int gaw)
-{
-	struct device_domain_info *info;
-	struct dmar_domain *domain = NULL;
-	struct intel_iommu *iommu;
-	u16 dma_alias;
-	unsigned long flags;
-	u8 bus, devfn;
-
-	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
-		return NULL;
-
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-
-		pci_for_each_dma_alias(pdev, get_last_alias, &dma_alias);
-
-		spin_lock_irqsave(&device_domain_lock, flags);
-		info = dmar_search_domain_by_dev_info(pci_domain_nr(pdev->bus),
-						      PCI_BUS_NUM(dma_alias),
-						      dma_alias & 0xff);
-		if (info) {
-			iommu = info->iommu;
-			domain = info->domain;
-		}
-		spin_unlock_irqrestore(&device_domain_lock, flags);
-
-		/* DMA alias already has a domain, use it */
-		if (info)
-			goto out;
-	}
-
-	/* Allocate and initialize new domain for the device */
-	domain = alloc_domain(0);
-	if (!domain)
-		return NULL;
-	if (domain_init(domain, iommu, gaw)) {
-		domain_exit(domain);
-		return NULL;
-	}
-
-out:
-	return domain;
-}
-
-static struct dmar_domain *set_domain_for_dev(struct device *dev,
-					      struct dmar_domain *domain)
-{
-	struct intel_iommu *iommu;
-	struct dmar_domain *tmp;
-	u16 req_id, dma_alias;
-	u8 bus, devfn;
-
-	iommu = device_to_iommu(dev, &bus, &devfn);
-	if (!iommu)
-		return NULL;
-
-	req_id = ((u16)bus << 8) | devfn;
-
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-
-		pci_for_each_dma_alias(pdev, get_last_alias, &dma_alias);
-
-		/* register PCI DMA alias device */
-		if (req_id != dma_alias) {
-			tmp = dmar_insert_one_dev_info(iommu, PCI_BUS_NUM(dma_alias),
-					dma_alias & 0xff, NULL, domain);
-
-			if (!tmp || tmp != domain)
-				return tmp;
-		}
-	}
-
-	tmp = dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
-	if (!tmp || tmp != domain)
-		return tmp;
-
-	return domain;
-}
-
 static int iommu_domain_identity_map(struct dmar_domain *domain,
 				     unsigned long long start,
 				     unsigned long long end)
@@ -2817,45 +2657,6 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 				DMA_PTE_READ|DMA_PTE_WRITE);
 }
 
-static int domain_prepare_identity_map(struct device *dev,
-				       struct dmar_domain *domain,
-				       unsigned long long start,
-				       unsigned long long end)
-{
-	/* For _hardware_ passthrough, don't bother. But for software
-	   passthrough, we do it anyway -- it may indicate a memory
-	   range which is reserved in E820, so which didn't get set
-	   up to start with in si_domain */
-	if (domain == si_domain && hw_pass_through) {
-		dev_warn(dev, "Ignoring identity map for HW passthrough [0x%Lx - 0x%Lx]\n",
-			 start, end);
-		return 0;
-	}
-
-	dev_info(dev, "Setting identity map [0x%Lx - 0x%Lx]\n", start, end);
-
-	if (end < start) {
-		WARN(1, "Your BIOS is broken; RMRR ends before it starts!\n"
-			"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-			dmi_get_system_info(DMI_BIOS_VENDOR),
-			dmi_get_system_info(DMI_BIOS_VERSION),
-		     dmi_get_system_info(DMI_PRODUCT_VERSION));
-		return -EIO;
-	}
-
-	if (end >> agaw_to_width(domain->agaw)) {
-		WARN(1, "Your BIOS is broken; RMRR exceeds permitted address width (%d bits)\n"
-		     "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-		     agaw_to_width(domain->agaw),
-		     dmi_get_system_info(DMI_BIOS_VENDOR),
-		     dmi_get_system_info(DMI_BIOS_VERSION),
-		     dmi_get_system_info(DMI_PRODUCT_VERSION));
-		return -EIO;
-	}
-
-	return iommu_domain_identity_map(domain, start, end);
-}
-
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
 static int __init si_domain_init(int hw)
@@ -3031,7 +2832,7 @@ static bool device_is_rmrr_locked(struct device *dev)
  *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
  *  - 0: both identity and dynamic domains work for this device
  */
-static int device_def_domain_type(struct device *dev)
+static int intel_iommu_dev_def_domain_type(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
@@ -3506,54 +3307,6 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	return iova_pfn;
 }
 
-static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
-{
-	struct dmar_domain *domain, *tmp;
-	struct dmar_rmrr_unit *rmrr;
-	struct device *i_dev;
-	int i, ret;
-
-	/* Device shouldn't be attached by any domains. */
-	domain = find_domain(dev);
-	if (domain)
-		return NULL;
-
-	domain = find_or_alloc_domain(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
-	if (!domain)
-		goto out;
-
-	/* We have a new domain - setup possible RMRRs for the device */
-	rcu_read_lock();
-	for_each_rmrr_units(rmrr) {
-		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
-					  i, i_dev) {
-			if (i_dev != dev)
-				continue;
-
-			ret = domain_prepare_identity_map(dev, domain,
-							  rmrr->base_address,
-							  rmrr->end_address);
-			if (ret)
-				dev_err(dev, "Mapping reserved region failed\n");
-		}
-	}
-	rcu_read_unlock();
-
-	tmp = set_domain_for_dev(dev, domain);
-	if (!tmp || domain != tmp) {
-		domain_exit(domain);
-		domain = tmp;
-	}
-
-out:
-	if (!domain)
-		dev_err(dev, "Allocating domain failed\n");
-	else
-		domain->domain.type = IOMMU_DOMAIN_DMA;
-
-	return domain;
-}
-
 /* Check if the dev needs to go through non-identity map and unmap process.*/
 static bool iommu_need_mapping(struct device *dev)
 {
@@ -5226,12 +4979,6 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	domain_detach_iommu(domain, iommu);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
-	/* free the private domain */
-	if (domain->flags & DOMAIN_FLAG_LOSE_CHILDREN &&
-	    !(domain->flags & DOMAIN_FLAG_STATIC_IDENTITY) &&
-	    list_empty(&domain->devices))
-		domain_exit(info->domain);
-
 	free_devinfo_mem(info);
 }
 
@@ -5713,73 +5460,36 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 
 static int intel_iommu_add_device(struct device *dev)
 {
-	struct dmar_domain *dmar_domain;
-	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
 	struct iommu_group *group;
 	u8 bus, devfn;
-	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
 
-	iommu_device_link(&iommu->iommu, dev);
-
 	if (translation_pre_enabled(iommu))
 		dev->archdata.iommu = DEFER_DEVICE_DOMAIN_INFO;
 
-	group = iommu_group_get_for_dev(dev);
+	group = iommu_group_get(dev);
+	if (!group) {
+		group = iommu_group_get_for_dev(dev);
+		iommu_device_link(&iommu->iommu, dev);
+	}
 
 	if (IS_ERR(group)) {
-		ret = PTR_ERR(group);
-		goto unlink;
+		iommu_device_unlink(&iommu->iommu, dev);
+		return PTR_ERR(group);
 	}
 
 	iommu_group_put(group);
 
-	domain = iommu_get_domain_for_dev(dev);
-	dmar_domain = to_dmar_domain(domain);
-	if (domain->type == IOMMU_DOMAIN_DMA) {
-		if (device_def_domain_type(dev) == IOMMU_DOMAIN_IDENTITY) {
-			ret = iommu_request_dm_for_dev(dev);
-			if (ret) {
-				dmar_remove_one_dev_info(dev);
-				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-				domain_add_dev_info(si_domain, dev);
-				dev_info(dev,
-					 "Device uses a private identity domain.\n");
-			}
-		}
-	} else {
-		if (device_def_domain_type(dev) == IOMMU_DOMAIN_DMA) {
-			ret = iommu_request_dma_domain_for_dev(dev);
-			if (ret) {
-				dmar_remove_one_dev_info(dev);
-				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-				if (!get_private_domain_for_dev(dev)) {
-					dev_warn(dev,
-						 "Failed to get a private domain.\n");
-					ret = -ENOMEM;
-					goto unlink;
-				}
-
-				dev_info(dev,
-					 "Device uses a private dma domain.\n");
-			}
-		}
-	}
-
 	if (device_needs_bounce(dev)) {
 		dev_info(dev, "Use Intel IOMMU bounce page dma_ops\n");
 		set_dma_ops(dev, &bounce_dma_ops);
 	}
 
 	return 0;
-
-unlink:
-	iommu_device_unlink(&iommu->iommu, dev);
-	return ret;
 }
 
 static void intel_iommu_remove_device(struct device *dev)
@@ -6139,6 +5849,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
+	.def_domain_type	= intel_iommu_dev_def_domain_type,
 	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
