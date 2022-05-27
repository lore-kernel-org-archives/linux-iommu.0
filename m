Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE05C433F5
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 06:34:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1123241C8F;
	Fri, 27 May 2022 06:34:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q7rENC_0rfBa; Fri, 27 May 2022 06:34:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8FAE341CE7;
	Fri, 27 May 2022 06:34:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FDACC0032;
	Fri, 27 May 2022 06:34:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FDAFC007E
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C496412E8
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLrnqPzhkTIH for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:34:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C848412E2
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653633242; x=1685169242;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SaezIU2KemVpoNQHn3KxEWZBO5XA8cmu4TjU1ZF0rFA=;
 b=iH8mHNo0DQqMk5ROoMwByOrKqEOLlIk32jFNA59H2kO3xpcLm3mRKCNz
 +bLuJ0WN6j3ebUukOGPPJ3C9ewsxg2B6p0A5AbyRD56aXWlw0AUAY7G/B
 ke210XoBBowxfIl6BCe2/D8jv1X6mSqwN1e4zjXg+GQl4FtfbPCp6x7y2
 LZ3yUrO7jb6dOORNH3brWqLxuB0oGVCxxY8YWdmN1N1ytLlS+PV3nsnAp
 Drf36Epq4Ut0N3m8EXPqGB5Ohl9KMtG/EBACdOFDNURK2egKMvb5SRv8C
 KrqDXkUYBqljUoFsHDs+tOSljk+yR1+OP8jI6E3lsOdTQFXrsAa6yZyg4 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274123247"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="274123247"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2022 23:34:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="718688412"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:33:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 02/12] iommu/vt-d: Remove for_each_device_domain()
Date: Fri, 27 May 2022 14:30:09 +0800
Message-Id: <20220527063019.3112905-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.h |  2 --
 drivers/iommu/intel/iommu.c | 25 -------------------------
 drivers/iommu/intel/pasid.c | 37 +++++++++++--------------------------
 3 files changed, 11 insertions(+), 53 deletions(-)

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
index cacae8bdaa65..6549b09d7f32 100644
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
index b2ac5869286f..0627d6465f25 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -103,36 +103,20 @@ device_detach_pasid_table(struct device_domain_info *info,
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
+	if (!info || !info->pasid_table)
+		return 0;
 
-	return for_each_device_domain(&search_pasid_table, data);
+	data->pasid_table = info->pasid_table;
+	return 1;
 }
 
 /*
@@ -141,9 +125,9 @@ static int get_alias_pasid_table(struct pci_dev *pdev, u16 alias, void *opaque)
  */
 int intel_pasid_alloc_table(struct device *dev)
 {
+	struct pasid_table_opaque data = { NULL };
 	struct device_domain_info *info;
 	struct pasid_table *pasid_table;
-	struct pasid_table_opaque data;
 	struct page *pages;
 	u32 max_pasid = 0;
 	int ret, order;
@@ -155,11 +139,12 @@ int intel_pasid_alloc_table(struct device *dev)
 		return -EINVAL;
 
 	/* DMA alias device already has a pasid table, use it: */
-	data.pasid_table = &pasid_table;
 	ret = pci_for_each_dma_alias(to_pci_dev(dev),
 				     &get_alias_pasid_table, &data);
-	if (ret)
+	if (ret) {
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
