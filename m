Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86474C43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 02:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AD8E8145D;
	Tue, 14 Jun 2022 02:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O8WE3P57FDRG; Tue, 14 Jun 2022 02:55:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F007C81452;
	Tue, 14 Jun 2022 02:55:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF088C0032;
	Tue, 14 Jun 2022 02:55:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA0CCC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97E0141619
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LNMr_uYkZ6m8 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 02:55:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A170409F1
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655175347; x=1686711347;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=29AHg92ykddBPrrPE1x24Akt3wGIsfhUFlU0p8Ba9Jg=;
 b=PCsBruZEhevjgmwsn4k7kF2b2IIPIl3jzUzyysZzvELd4tXoNFMZgQj2
 B+1tdi14GplEYA4s4DSR0VuzW7UE3njSVjPb5FakP/XZC5kXu3tfvdHjo
 zhU1uF5KfrVzUOr6tYywxPPxz5/BZFb7UF9vTXVVsnHLJ4se9mNq6b0r4
 NDq9MrCxXQxCNs/MtE9JVUd2aSc8pJ9GrZ+Gfd3OtIXlJG5+soItYhEEM
 IamZBMBjJ+ABIJC3zAd9akazJr5xSqe4InrBLlknDvc6IKv9p/pH97J3S
 uqNgEouHcjD6F68j6zJ9BALiuJisolMKHXYr7dZguthRK7dogp6QDxnye Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303887057"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="303887057"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 19:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="588166481"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 19:55:44 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 04/12] iommu/vt-d: Use pci_get_domain_bus_and_slot() in
 pgtable_walk()
Date: Tue, 14 Jun 2022 10:51:29 +0800
Message-Id: <20220614025137.1632762-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

Use pci_get_domain_bus_and_slot() instead of searching the global list
to retrieve the pci device pointer. This also removes the global
device_domain_list as there isn't any consumer anymore.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/iommu.c | 33 ++++++---------------------------
 2 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 2f4a5b9509c0..6724703d573b 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -609,7 +609,6 @@ struct intel_iommu {
 /* PCI domain-device relationship */
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
-	struct list_head global; /* link to global list */
 	struct list_head table;	/* link to pasid table */
 	u32 segment;		/* PCI segment number */
 	u8 bus;			/* PCI bus number */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 695aed474e5d..839bb5f3e000 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -131,8 +131,6 @@ static struct intel_iommu **g_iommus;
 
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
-static inline struct device_domain_info *
-dmar_search_domain_by_dev_info(int segment, int bus, int devfn);
 
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
@@ -315,7 +313,6 @@ static int iommu_skip_te_disable;
 #define IDENTMAP_AZALIA		4
 
 static DEFINE_SPINLOCK(device_domain_lock);
-static LIST_HEAD(device_domain_list);
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
@@ -845,9 +842,14 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn, u8 bus, u
 	struct device_domain_info *info;
 	struct dma_pte *parent, *pte;
 	struct dmar_domain *domain;
+	struct pci_dev *pdev;
 	int offset, level;
 
-	info = dmar_search_domain_by_dev_info(iommu->segment, bus, devfn);
+	pdev = pci_get_domain_bus_and_slot(iommu->segment, bus, devfn);
+	if (!pdev)
+		return;
+
+	info = dev_iommu_priv_get(&pdev->dev);
 	if (!info || !info->domain) {
 		pr_info("device [%02x:%02x.%d] not probed\n",
 			bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
@@ -2356,19 +2358,6 @@ static void domain_remove_dev_info(struct dmar_domain *domain)
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-static inline struct device_domain_info *
-dmar_search_domain_by_dev_info(int segment, int bus, int devfn)
-{
-	struct device_domain_info *info;
-
-	list_for_each_entry(info, &device_domain_list, global)
-		if (info->segment == segment && info->bus == bus &&
-		    info->devfn == devfn)
-			return info;
-
-	return NULL;
-}
-
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
@@ -4572,7 +4561,6 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
-	unsigned long flags;
 	u8 bus, devfn;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
@@ -4615,10 +4603,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		}
 	}
 
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_add(&info->global, &device_domain_list);
 	dev_iommu_priv_set(dev, info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return &iommu->iommu;
 }
@@ -4626,15 +4611,9 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	unsigned long flags;
 
 	dmar_remove_one_dev_info(dev);
-
-	spin_lock_irqsave(&device_domain_lock, flags);
 	dev_iommu_priv_set(dev, NULL);
-	list_del(&info->global);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
 	kfree(info);
 	set_dma_ops(dev, NULL);
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
