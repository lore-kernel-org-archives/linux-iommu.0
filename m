Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18170C4332F
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 06:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B50BD40133;
	Thu,  7 Apr 2022 06:26:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c464OBANtdcL; Thu,  7 Apr 2022 06:26:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 603D640160;
	Thu,  7 Apr 2022 06:26:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25A98C002F;
	Thu,  7 Apr 2022 06:26:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A300C002F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24B2883F04
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N_NieApz0Bri for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:26:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63DD783E62
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
 Reply-To:Cc:Content-Type:Content-ID:Content-Description;
 bh=wpC1TuAMkasMCBWKtoj/S1/ycqtoivz8J8anY5EwAP0=; b=BeXy3HuhsBTZ7pXanyced6uyMn
 2zGNjvZR3mWPM1igStdrMzGwTpGePGxmZQfPdE/Bey6oQO0UUq2wyN692YaEiylmvYvvr/RFWag3q
 wJ+93l+lcBDmfEMOsaBPG0Xcjh2CSOpuy6GDlnt1V3TShnDO4iIjpNyPd/KYNAedekJJphw2x9NLh
 HIYE0/+H9MOWO1bV1ybjjLiATSpacuOKdjG+sTrQV0RjyIiYKcdT+Wv2JfIOmTZLzE95U+OoeYXjl
 3Nvt3awTBWEz7jKIB8E199eruerxQxjMwzPY2cl7CKcP/LNR8ooIfmwOp0iZyTG+1MLZ1hf8k1z7Q
 8NuE0cgg==;
Received: from [2001:4bb8:184:7553:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncLb1-009fkr-8z; Thu, 07 Apr 2022 06:26:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Sven Peter <sven@svenpeter.dev>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Yong Wu <yong.wu@mediatek.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 3/4] iommu: remove the put_resv_regions method
Date: Thu,  7 Apr 2022 08:26:07 +0200
Message-Id: <20220407062608.711392-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407062608.711392-1-hch@lst.de>
References: <20220407062608.711392-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

All drivers that implement get_resv_regions just use
generic_put_resv_regions to implement the put side.  Remove the
indirections and document the allocations constraints.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/amd/iommu.c                   |  1 -
 drivers/iommu/apple-dart.c                  |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  1 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  1 -
 drivers/iommu/intel/iommu.c                 |  1 -
 drivers/iommu/iommu.c                       | 20 +-------------------
 drivers/iommu/mtk_iommu.c                   |  1 -
 drivers/iommu/virtio-iommu.c                |  5 ++---
 include/linux/iommu.h                       |  4 ----
 9 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a1ada7bff44e61..7011b46022dcbb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2279,7 +2279,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.probe_finalize = amd_iommu_probe_finalize,
 	.device_group = amd_iommu_device_group,
 	.get_resv_regions = amd_iommu_get_resv_regions,
-	.put_resv_regions = generic_iommu_put_resv_regions,
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
 	.def_domain_type = amd_iommu_def_domain_type,
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index decafb07ad0831..a45ad9ade0dba6 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -771,7 +771,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.of_xlate = apple_dart_of_xlate,
 	.def_domain_type = apple_dart_def_domain_type,
 	.get_resv_regions = apple_dart_get_resv_regions,
-	.put_resv_regions = generic_iommu_put_resv_regions,
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= apple_dart_attach_dev,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 36461fb46d436c..1ea184bbf750a6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2847,7 +2847,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.sva_bind		= arm_smmu_sva_bind,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 568cce590ccc13..41da1275689ebd 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1589,7 +1589,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
-	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df5c62ecf942b8..cafe50cb484cd5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4875,7 +4875,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.device_group		= intel_iommu_device_group,
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 6ce73f35c43aac..2e1f7d1cf74793 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2584,31 +2584,13 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 }
 
 void iommu_put_resv_regions(struct device *dev, struct list_head *list)
-{
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (ops->put_resv_regions)
-		ops->put_resv_regions(dev, list);
-}
-
-/**
- * generic_iommu_put_resv_regions - Reserved region driver helper
- * @dev: device for which to free reserved regions
- * @list: reserved region list for device
- *
- * IOMMU drivers can use this to implement their .put_resv_regions() callback
- * for simple reservations. Memory allocated for each reserved region will be
- * freed. If an IOMMU driver allocates additional resources per region, it is
- * going to have to implement a custom callback.
- */
-void generic_iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
 	struct iommu_resv_region *entry, *next;
 
 	list_for_each_entry_safe(entry, next, list, list)
 		kfree(entry);
 }
-EXPORT_SYMBOL(generic_iommu_put_resv_regions);
+EXPORT_SYMBOL(iommu_put_resv_regions);
 
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 						  size_t length, int prot,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6fd75a60abd678..d970fd301e8f31 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -688,7 +688,6 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.device_group	= mtk_iommu_device_group,
 	.of_xlate	= mtk_iommu_of_xlate,
 	.get_resv_regions = mtk_iommu_get_resv_regions,
-	.put_resv_regions = generic_iommu_put_resv_regions,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 25be4b822aa07f..36385b3deb8981 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -964,7 +964,7 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	return &viommu->iommu;
 
 err_free_dev:
-	generic_iommu_put_resv_regions(dev, &vdev->resv_regions);
+	iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 
 	return ERR_PTR(ret);
@@ -989,7 +989,7 @@ static void viommu_release_device(struct device *dev)
 
 	vdev = dev_iommu_priv_get(dev);
 
-	generic_iommu_put_resv_regions(dev, &vdev->resv_regions);
+	iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
 
@@ -1013,7 +1013,6 @@ static struct iommu_ops viommu_ops = {
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.of_xlate		= viommu_of_xlate,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a2d3562a501d3e..fed4c09e8e7cfe 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -198,7 +198,6 @@ struct iommu_iotlb_gather {
  *                  group and attached to the groups domain
  * @device_group: find iommu group for a particular device
  * @get_resv_regions: Request list of reserved regions for a device
- * @put_resv_regions: Free list of reserved regions for a device
  * @of_xlate: add OF master IDs to iommu grouping
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
@@ -229,7 +228,6 @@ struct iommu_ops {
 
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
-	void (*put_resv_regions)(struct device *dev, struct list_head *list);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct device *dev);
@@ -445,8 +443,6 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
 
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
-extern void generic_iommu_put_resv_regions(struct device *dev,
-					   struct list_head *list);
 extern void iommu_set_default_passthrough(bool cmd_line);
 extern void iommu_set_default_translated(bool cmd_line);
 extern bool iommu_default_passthrough(void);
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
