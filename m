Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE532C433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 02:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7140340647;
	Wed, 16 Feb 2022 02:55:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tpsPobNd-dV7; Wed, 16 Feb 2022 02:55:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B5128400D7;
	Wed, 16 Feb 2022 02:54:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90FECC001A;
	Wed, 16 Feb 2022 02:54:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A9A0C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 02:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 79937415F8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 02:54:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J-0DiQY-URZf for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 02:54:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BAE85415EF
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 02:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644980097; x=1676516097;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uXrn14nMTQITQECZX3ONrx8+Lps8fl1/nT7YqPDyvjs=;
 b=BsUI4BPlz0pIa2L7jbpHfmoSMjgqisEzD9U76oXiMAkmp67nKuY0k7i8
 wOPzH5oYgi/l5nQJTbQPvJt0LBHHgU2ZtHUC/GXnsZenmwlWX26i1FoSI
 udW7U+CWMeI4FDEjDOrm6/+efvt2W5jE4/4LalJ3jSlKEIubIbuT2+hnu
 RyxwoN7AMB/MZ+mJQPesQnhEGOjZT/9pUjdsvrJdNmihCM3oQfSO9S7ID
 OUKDdBKiC/j9AM77kixWDb+/xgSadItV//Ajm2cwvvRiyKadR6WDetLNQ
 ZnsXOw1GEuolDSeKov84gLiqB8xWKZfHpCxTDPQ+QJvCPzNGYxNnp2aPm Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="248106910"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; d="scan'208";a="248106910"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Feb 2022 18:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; d="scan'208";a="681312533"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 18:54:53 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 7/9] iommu: Use right way to retrieve iommu_ops
Date: Wed, 16 Feb 2022 10:52:47 +0800
Message-Id: <20220216025249.3459465-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Christoph Hellwig <hch@lst.de>
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

The common iommu_ops is hooked to both device and domain. When a helper
has both device and domain pointer, the way to get the iommu_ops looks
messy in iommu core. This sorts out the way to get iommu_ops. The device
related helpers go through device pointer, while the domain related ones
go through domain pointer.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/iommu.h | 11 ++++++++++
 drivers/iommu/iommu.c | 50 +++++++++++++++++++++----------------------
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9ffa2e88f3d0..90f1b5e3809d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -381,6 +381,17 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 	};
 }
 
+static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
+{
+	/*
+	 * Assume that valid ops must be installed if iommu_probe_device()
+	 * has succeeded. The device ops are essentially for internal use
+	 * within the IOMMU subsystem itself, so we should be able to trust
+	 * ourselves not to misuse the helper.
+	 */
+	return dev->iommu->iommu_dev->ops;
+}
+
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
 #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
 #define IOMMU_GROUP_NOTIFY_BIND_DRIVER		3 /* Pre Driver bind */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7cf073c56036..7af0ee670deb 100644
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
@@ -833,8 +834,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 static bool iommu_is_attach_deferred(struct iommu_domain *domain,
 				     struct device *dev)
 {
-	if (domain->ops->is_attach_deferred)
-		return domain->ops->is_attach_deferred(domain, dev);
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	if (ops->is_attach_deferred)
+		return ops->is_attach_deferred(domain, dev);
 
 	return false;
 }
@@ -1252,10 +1255,10 @@ int iommu_page_response(struct device *dev,
 	struct iommu_fault_event *evt;
 	struct iommu_fault_page_request *prm;
 	struct dev_iommu *param = dev->iommu;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
-	if (!domain || !domain->ops->page_response)
+	if (!ops->page_response)
 		return -ENODEV;
 
 	if (!param || !param->fault_param)
@@ -1296,7 +1299,7 @@ int iommu_page_response(struct device *dev,
 			msg->pasid = 0;
 		}
 
-		ret = domain->ops->page_response(dev, evt, msg);
+		ret = ops->page_response(dev, evt, msg);
 		list_del(&evt->list);
 		kfree(evt);
 		break;
@@ -1521,7 +1524,7 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 
 static int iommu_get_def_domain_type(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
 		return IOMMU_DOMAIN_DMA;
@@ -1580,7 +1583,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
  */
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_group *group;
 	int ret;
 
@@ -1588,9 +1591,6 @@ static struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 	if (group)
 		return group;
 
-	if (!ops)
-		return ERR_PTR(-EINVAL);
-
 	group = ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
 		return ERR_PTR(-EINVAL);
@@ -1759,10 +1759,10 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
 
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
 {
-	struct iommu_domain *domain = data;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (domain->ops->probe_finalize)
-		domain->ops->probe_finalize(dev);
+	if (ops->probe_finalize)
+		ops->probe_finalize(dev);
 
 	return 0;
 }
@@ -2020,7 +2020,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
 		return __iommu_attach_device(domain, dev);
@@ -2579,17 +2579,17 @@ EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
 
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
 
@@ -2794,9 +2794,9 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (!ops || !ops->sva_bind)
+	if (!ops->sva_bind)
 		return ERR_PTR(-ENODEV);
 
 	group = iommu_group_get(dev);
@@ -2837,9 +2837,9 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 	struct iommu_group *group;
 	struct device *dev = handle->dev;
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
-	if (!ops || !ops->sva_unbind)
+	if (!ops->sva_unbind)
 		return;
 
 	group = iommu_group_get(dev);
@@ -2856,9 +2856,9 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
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
