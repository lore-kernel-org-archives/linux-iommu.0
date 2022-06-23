Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695C8C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 07:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01ED760EED;
	Thu, 23 Jun 2022 07:01:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01ED760EED
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HpqkRDSj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2mdf1Q5OiSDR; Thu, 23 Jun 2022 07:01:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 96BA960EE0;
	Thu, 23 Jun 2022 07:01:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96BA960EE0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F93CC0032;
	Thu, 23 Jun 2022 07:01:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 187F8C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA1C540940
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:01:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA1C540940
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HpqkRDSj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A-2HH8wdX9ms for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 07:01:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CFE240928
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7CFE240928
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 07:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655967699; x=1687503699;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=si9eTHzrKpyv7C+UAUUnQa0UoXNs9hdOsasdQ/jl1N4=;
 b=HpqkRDSj09P0jLmnSO+wlsnM72BeqAiAMrBhSaQj05nBNIoou+3AoW+L
 qu7gznRb0KFa3h8i2LqKbPSu1OQ7WaS10B3EdGRRvpufN+d5e2LaIKrDl
 IWNchnH27edqffqgISSPb3V3YvSokyB2YUyEQ+xHCHcyW9FBJ8827W8GZ
 O4AcYGGfXwAG13QWRZ2OrtUyPvcvrO/NOBU+G6OtxsVmNMWC3qVcgeFFt
 OHDdSmBESzwAA82sHp8Wx9maVLS3QdqUF+mGXL9F13MW0CbO6Rgz/RqdY
 2abkj2AeTo20XDB9lxyOqX5YSP3hqU10Cbf/eskKwfDVA3iR5Y99w1Z8F A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="306103939"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; d="scan'208";a="306103939"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2022 00:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; d="scan'208";a="586050026"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 23 Jun 2022 00:01:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v3 1/1] iommu/vt-d: Fix RID2PASID setup/teardown failure
Date: Thu, 23 Jun 2022 14:57:20 +0800
Message-Id: <20220623065720.727849-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>
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

The IOMMU driver shares the pasid table for PCI alias devices. When the
RID2PASID entry of the shared pasid table has been filled by the first
device, the subsequent device will encounter the "DMAR: Setup RID2PASID
failed" failure as the pasid entry has already been marked as present.
As the result, the IOMMU probing process will be aborted.

On the contrary, when any alias device is hot-removed from the system,
for example, by writing to /sys/bus/pci/devices/.../remove, the shared
RID2PASID will be cleared without any notifications to other devices.
As the result, any DMAs from those rest devices are blocked.

Sharing pasid table among PCI alias devices could save two memory pages
for devices underneath the PCIe-to-PCI bridges. Anyway, considering that
those devices are rare on modern platforms that support VT-d in scalable
mode and the saved memory is negligible, it's reasonable to remove this
part of immature code to make the driver feasible and stable.

Fixes: ef848b7e5a6a0 ("iommu/vt-d: Setup pasid entry for RID2PASID support")
Reported-by: Chenyi Qiang <chenyi.qiang@intel.com>
Reported-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  3 --
 drivers/iommu/intel/pasid.h |  1 -
 drivers/iommu/intel/iommu.c | 24 -------------
 drivers/iommu/intel/pasid.c | 69 ++-----------------------------------
 4 files changed, 3 insertions(+), 94 deletions(-)

Change log:
v3:
 - Ethan pointed out that there's also problem in the device release
   path. Let's remove this part of immature code for now.

v2:
 - Add domain validity check in RID2PASID entry setup.

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4f29139bbfc3..5fcf89faa31a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -612,7 +612,6 @@ struct intel_iommu {
 struct device_domain_info {
 	struct list_head link;	/* link to domain siblings */
 	struct list_head global; /* link to global list */
-	struct list_head table;	/* link to pasid table */
 	u32 segment;		/* PCI segment number */
 	u8 bus;			/* PCI bus number */
 	u8 devfn;		/* PCI devfn number */
@@ -729,8 +728,6 @@ extern int dmar_ir_support(void);
 void *alloc_pgtable_page(int node);
 void free_pgtable_page(void *vaddr);
 struct intel_iommu *domain_get_iommu(struct dmar_domain *domain);
-int for_each_device_domain(int (*fn)(struct device_domain_info *info,
-				     void *data), void *data);
 void iommu_flush_write_buffer(struct intel_iommu *iommu);
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
 struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 583ea67fc783..bf5b937848b4 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -74,7 +74,6 @@ struct pasid_table {
 	void			*table;		/* pasid table pointer */
 	int			order;		/* page order of pasid table */
 	u32			max_pasid;	/* max pasid */
-	struct list_head	dev;		/* device list */
 };
 
 /* Get PRESENT bit of a PASID directory entry. */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 44016594831d..5c0dce78586a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -320,30 +320,6 @@ EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 DEFINE_SPINLOCK(device_domain_lock);
 static LIST_HEAD(device_domain_list);
 
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
index cb4c1d0cf25c..17cad7c1f62d 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -86,54 +86,6 @@ void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid)
 /*
  * Per device pasid table management:
  */
-static inline void
-device_attach_pasid_table(struct device_domain_info *info,
-			  struct pasid_table *pasid_table)
-{
-	info->pasid_table = pasid_table;
-	list_add(&info->table, &pasid_table->dev);
-}
-
-static inline void
-device_detach_pasid_table(struct device_domain_info *info,
-			  struct pasid_table *pasid_table)
-{
-	info->pasid_table = NULL;
-	list_del(&info->table);
-}
-
-struct pasid_table_opaque {
-	struct pasid_table	**pasid_table;
-	int			segment;
-	int			bus;
-	int			devfn;
-};
-
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
-static int get_alias_pasid_table(struct pci_dev *pdev, u16 alias, void *opaque)
-{
-	struct pasid_table_opaque *data = opaque;
-
-	data->segment = pci_domain_nr(pdev->bus);
-	data->bus = PCI_BUS_NUM(alias);
-	data->devfn = alias & 0xff;
-
-	return for_each_device_domain(&search_pasid_table, data);
-}
 
 /*
  * Allocate a pasid table for @dev. It should be called in a
@@ -143,28 +95,18 @@ int intel_pasid_alloc_table(struct device *dev)
 {
 	struct device_domain_info *info;
 	struct pasid_table *pasid_table;
-	struct pasid_table_opaque data;
 	struct page *pages;
 	u32 max_pasid = 0;
-	int ret, order;
-	int size;
+	int order, size;
 
 	might_sleep();
 	info = dev_iommu_priv_get(dev);
 	if (WARN_ON(!info || !dev_is_pci(dev) || info->pasid_table))
 		return -EINVAL;
 
-	/* DMA alias device already has a pasid table, use it: */
-	data.pasid_table = &pasid_table;
-	ret = pci_for_each_dma_alias(to_pci_dev(dev),
-				     &get_alias_pasid_table, &data);
-	if (ret)
-		goto attach_out;
-
 	pasid_table = kzalloc(sizeof(*pasid_table), GFP_KERNEL);
 	if (!pasid_table)
 		return -ENOMEM;
-	INIT_LIST_HEAD(&pasid_table->dev);
 
 	if (info->pasid_supported)
 		max_pasid = min_t(u32, pci_max_pasids(to_pci_dev(dev)),
@@ -182,9 +124,7 @@ int intel_pasid_alloc_table(struct device *dev)
 	pasid_table->table = page_address(pages);
 	pasid_table->order = order;
 	pasid_table->max_pasid = 1 << (order + PAGE_SHIFT + 3);
-
-attach_out:
-	device_attach_pasid_table(info, pasid_table);
+	info->pasid_table = pasid_table;
 
 	return 0;
 }
@@ -202,10 +142,7 @@ void intel_pasid_free_table(struct device *dev)
 		return;
 
 	pasid_table = info->pasid_table;
-	device_detach_pasid_table(info, pasid_table);
-
-	if (!list_empty(&pasid_table->dev))
-		return;
+	info->pasid_table = NULL;
 
 	/* Free scalable mode PASID directory tables: */
 	dir = pasid_table->table;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
