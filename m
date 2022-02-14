Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9425C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 01:58:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E73B4012A;
	Mon, 14 Feb 2022 01:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IfBHq9LwOE4X; Mon, 14 Feb 2022 01:58:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2C25B40139;
	Mon, 14 Feb 2022 01:58:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14982C0011;
	Mon, 14 Feb 2022 01:58:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E74AC000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 01:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D24C400C7
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 01:58:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nofEIG8dPptG for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 01:58:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91FED402C1
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 01:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644803888; x=1676339888;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F26i5auVutrL0981CHcSyAs4eEJxP31jaSB2EXCl+uI=;
 b=fTY5Qs9oWUjRYstQ7KuG8g8a8DiazoQmafEY5Exl6xeiBhUCumP08OqT
 6TRsyTtNmeS6cgj7V6O86rUha4T/ViGNrDiytLXncN+zgvs6HUfn8GNBI
 7/Lwff3aQYtph0+Aa5gnZNhosMkso7mFDtByfseiMGMyDU5ynFZfOdWei
 Y77LQA5Jzhm81xM5QdGXZnxLUAYRQz5HuiLRDJAhDaqzt35CvBa3lx2GL
 7G/K1DswA9tRo1Ldu2x6Mjaj/k4+coIoC+kz11s6/w8vSnZxQA09pfz8Z
 JKeybXynRjxwojVsk18gdJOsXgJju4r+yfo6iGe/bycv+rmsP03FTeI+V Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249938544"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="249938544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2022 17:58:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; d="scan'208";a="680137441"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 17:58:04 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 09/10] iommu: Use dev_iommu_ops() helper
Date: Mon, 14 Feb 2022 09:55:37 +0800
Message-Id: <20220214015538.2828933-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

This converts all the feasible instances of dev->bus->iommu_ops to
dev_iommu_ops() in order to make the operation of obtaining iommu_ops
from a device consistent. The dev_iommu_ops() warns on NULL ops, so
we don't need to keep the confusing ops check.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 245e3d2fb74b..27276421d253 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -323,13 +323,14 @@ int iommu_probe_device(struct device *dev)
 
 void iommu_release_device(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops;
 
 	if (!dev->iommu)
 		return;
 
 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
 
+	ops = dev_iommu_ops(dev);
 	ops->release_device(dev);
 
 	iommu_group_remove_device(dev);
@@ -1522,7 +1523,7 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
 static int iommu_get_def_domain_type(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
 		return IOMMU_DOMAIN_DMA;
@@ -1581,7 +1582,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
  */
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_group *group;
 	int ret;
 
@@ -1589,9 +1590,6 @@ static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (group)
 		return group;
 
-	if (!ops)
-		return ERR_PTR(-EINVAL);
-
 	group = ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
 		return ERR_PTR(-EINVAL);
@@ -2578,17 +2576,17 @@ EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
 
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (ops && ops->get_resv_regions)
+	if (ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
 }
 
 void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (ops && ops->put_resv_regions)
+	if (ops->put_resv_regions)
 		ops->put_resv_regions(dev, list);
 }
 
@@ -2793,9 +2791,9 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (!ops || !ops->sva_bind)
+	if (!ops->sva_bind)
 		return ERR_PTR(-ENODEV);
 
 	group = iommu_group_get(dev);
@@ -2836,9 +2834,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 	struct iommu_group *group;
 	struct device *dev = handle->dev;
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (!ops || !ops->sva_unbind)
+	if (!ops->sva_unbind)
 		return;
 
 	group = iommu_group_get(dev);
@@ -2855,9 +2853,9 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
 u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
-	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
 
-	if (!ops || !ops->sva_get_pasid)
+	if (!ops->sva_get_pasid)
 		return IOMMU_PASID_INVALID;
 
 	return ops->sva_get_pasid(handle);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
