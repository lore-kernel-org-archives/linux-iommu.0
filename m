Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1118C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 02:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 790B960BAA;
	Tue, 14 Jun 2022 02:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9FdoouhDU2Jl; Tue, 14 Jun 2022 02:55:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5C98660B00;
	Tue, 14 Jun 2022 02:55:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3022EC0032;
	Tue, 14 Jun 2022 02:55:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A1E0C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33C7D409ED
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nwVWJK9SgFOA for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 02:55:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35CDB40992
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655175341; x=1686711341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XkrY1IFtBFukO48gqiQ0AuYcbFkThuu4cQHVHVcOWwQ=;
 b=dC6NEzesiMnGlNzJiQhg71SBwi2JFXjgiyj47+OR3oVyGCBBXmhtkTYE
 bfCralLiAt/UfZexTChIAJ58H9+eJyG5potwGQoKeh59xDqDsPVfh3a09
 kY7JwgEF5T9BkxEtB0yQYcVu+n/DAbwsgenqLcM6yCgJWaYsQAds9hN7h
 SlNlb8HQKmcAP8NMGu3BQA9khWhjr0kNWYSe97IQ8anpFJMZSDotTd5QB
 VAgYGzKdRMzP7/JvMGd/YJZTioIgvWKn2Ph3JcZo4VUEEtGVCKaVglH+5
 qO8YJHwhG9O/AZylJLtk+/zhd7KSEwAWfgQUQ/agY7CNeNVzuvNIy/jLi w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303887032"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="303887032"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 19:55:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="588166431"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 19:55:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 02/12] iommu/vt-d: Remove for_each_device_domain()
Date: Tue, 14 Jun 2022 10:51:27 +0800
Message-Id: <20220614025137.1632762-3-baolu.lu@linux.intel.com>
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

The per-device device_domain_info data could be retrieved from the
device itself. There's no need to search a global list.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h |  2 --
 drivers/iommu/intel/iommu.c | 25 ----------------------
 drivers/iommu/intel/pasid.c | 41 +++++++++++--------------------------
 3 files changed, 12 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8a6d64d726c0..2f4a5b9509c0 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -727,8 +727,6 @@ extern int dmar_ir_support(void);
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
 struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
-int for_each_device_domain(int (*fn)(struct device_domain_info *info,
-				     void *data), void *data);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a39d72a9d1cf..ff6018f746e0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -316,31 +316,6 @@ static int iommu_skip_te_disable;
 
 static DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
-
-/*
- * Iterate over elements in device_domain_list and call the specified
- * callback @fn against each element.
- */
-int for_each_device_domain(int (*fn)(struct device_domain_info *info,
-				     void *data), void *data)
-{
-	int ret = 0;
-	unsigned long flags;
-	struct device_domain_info *info;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry(info, &device_domain_list, global) {
-		ret = fn(info, data);
-		if (ret) {
-			spin_unlock_irqrestore(&device_domain_lock, flags);
-			return ret;
-		}
-	}
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	return 0;
-}
-
 const struct iommu_ops intel_iommu_ops;
 
 static bool translation_pre_enabled(struct intel_iommu *iommu)
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b2ac5869286f..641a4a6eb61e 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -103,36 +103,19 @@ device_detach_pasid_table(struct device_domain_info *info,
 }
 
 struct pasid_table_opaque {
-	struct pasid_table	**pasid_table;
-	int			segment;
-	int			bus;
-	int			devfn;
+	struct pasid_table	*pasid_table;
 };
 
-static int search_pasid_table(struct device_domain_info *info, void *opaque)
-{
-	struct pasid_table_opaque *data = opaque;
-
-	if (info->iommu->segment == data->segment &&
-	    info->bus == data->bus &&
-	    info->devfn == data->devfn &&
-	    info->pasid_table) {
-		*data->pasid_table = info->pasid_table;
-		return 1;
-	}
-
-	return 0;
-}
-
 static int get_alias_pasid_table(struct pci_dev *pdev, u16 alias, void *opaque)
 {
 	struct pasid_table_opaque *data = opaque;
+	struct device_domain_info *info;
 
-	data->segment = pci_domain_nr(pdev->bus);
-	data->bus = PCI_BUS_NUM(alias);
-	data->devfn = alias & 0xff;
+	info = dev_iommu_priv_get(&pdev->dev);
+	if (info && info->pasid_table)
+		data->pasid_table = info->pasid_table;
 
-	return for_each_device_domain(&search_pasid_table, data);
+	return data->pasid_table != NULL;
 }
 
 /*
@@ -141,12 +124,12 @@ static int get_alias_pasid_table(struct pci_dev *pdev, u16 alias, void *opaque)
  */
 int intel_pasid_alloc_table(struct device *dev)
 {
+	struct pasid_table_opaque data = { NULL };
 	struct device_domain_info *info;
 	struct pasid_table *pasid_table;
-	struct pasid_table_opaque data;
 	struct page *pages;
 	u32 max_pasid = 0;
-	int ret, order;
+	int order;
 	int size;
 
 	might_sleep();
@@ -155,11 +138,11 @@ int intel_pasid_alloc_table(struct device *dev)
 		return -EINVAL;
 
 	/* DMA alias device already has a pasid table, use it: */
-	data.pasid_table = &pasid_table;
-	ret = pci_for_each_dma_alias(to_pci_dev(dev),
-				     &get_alias_pasid_table, &data);
-	if (ret)
+	if (pci_for_each_dma_alias(to_pci_dev(dev),
+				   get_alias_pasid_table, &data)) {
+		pasid_table = data.pasid_table;
 		goto attach_out;
+	}
 
 	pasid_table = kzalloc(sizeof(*pasid_table), GFP_KERNEL);
 	if (!pasid_table)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
