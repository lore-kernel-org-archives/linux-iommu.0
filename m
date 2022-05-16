Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434C7C433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 02:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E42260A81;
	Mon, 16 May 2022 02:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ugy3o10fl5vA; Mon, 16 May 2022 02:01:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A61B60B1E;
	Mon, 16 May 2022 02:01:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ECBAC007F;
	Mon, 16 May 2022 02:01:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56A92C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38490409AD
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:01:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 38-c9Lzbp6DS for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 02:01:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 081D7414E7
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 02:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652666485; x=1684202485;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LHhv25RN3InxjHy86FN8zSgjz6xAFhg1jRNzCYo5Vn8=;
 b=kvFOTZWinUpUlEGtjpOVBJXn6kMvgW6RDJfuSWDdUd5Gcq2qZfowjrV3
 RgliUnYi10k8Sfg9BB8gaVBrWjUTzZSEzAQDjL4x/zjVqRPYnrKz1h4eI
 4c36hbsBggYU1RZ6lvnzUBkwtZ4hy4bdYofS7R4y3KMD/UKodtVL4DFZ4
 H0Zt1S1TwB1hAS2xZ0iIW/p+61IoYhhXuiQ/OlHSjb6DGcDKek3dm67mZ
 iP9xf+YlOVz0VK9ZYGWDIrTIIYhQeiZknCVGMvAO+VEtCnKYNPCff1F/h
 +ff5ipHUijxrHRkbz5WxWKHQzYfr10w9GElCixtQRCsk1ZwQLI02h+4qd A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270829252"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="270829252"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2022 19:01:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; d="scan'208";a="713172177"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 15 May 2022 19:01:21 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH 3/5] iommu: Make blocking domain static for iommu group
Date: Mon, 16 May 2022 09:57:57 +0800
Message-Id: <20220516015759.2952771-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

This makes the blocking_domain static for an iommu group. It's allocated
when the first device joins the group and freed after the last device
leaves. Essentially the blocking domain is a dummy domain used to remove
the domain from IOMMU's device context. Unfortunately, some IOMMU devices
don't provide such capability. In this case, we use an UNMANAGED domain
without any mapping instead.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 85 +++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8eba26be4363..dcbc55c9d8d7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -604,8 +604,6 @@ static void iommu_group_release(struct kobject *kobj)
 
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
-	if (group->blocking_domain)
-		iommu_domain_free(group->blocking_domain);
 
 	kfree(group->name);
 	kfree(group);
@@ -854,6 +852,46 @@ static bool iommu_is_attach_deferred(struct device *dev)
 	return false;
 }
 
+static int iommu_group_alloc_blocking_domain(struct iommu_group *group,
+					     struct device *dev)
+{
+	struct iommu_domain *domain;
+	const struct iommu_ops *iommu_ops = dev_iommu_ops(dev);
+	const struct iommu_domain_ops *ops = iommu_ops->blocking_domain_ops;
+
+	if (group->blocking_domain)
+		return 0;
+
+	if (ops->blocking_domain_detach) {
+		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+		if (domain)
+			domain->type = IOMMU_DOMAIN_BLOCKED;
+	} else {
+		domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
+	}
+
+	if (!domain)
+		return -ENOMEM;
+
+	domain->ops = ops;
+	group->blocking_domain = domain;
+
+	return 0;
+}
+
+static void iommu_group_free_blocking_domain(struct iommu_group *group,
+					     struct device *dev)
+{
+	struct iommu_domain *domain = group->blocking_domain;
+
+	if (domain->type == IOMMU_DOMAIN_BLOCKED)
+		kfree(domain);
+	else
+		iommu_domain_free(domain);
+
+	group->blocking_domain = NULL;
+}
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
@@ -867,6 +905,12 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	int ret, i = 0;
 	struct group_device *device;
 
+	mutex_lock(&group->mutex);
+	ret = iommu_group_alloc_blocking_domain(group, dev);
+	mutex_unlock(&group->mutex);
+	if (ret)
+		return -ENODEV;
+
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (!device)
 		return -ENOMEM;
@@ -961,6 +1005,8 @@ void iommu_group_remove_device(struct device *dev)
 			break;
 		}
 	}
+	if (list_empty(&group->devices))
+		iommu_group_free_blocking_domain(group, dev);
 	mutex_unlock(&group->mutex);
 
 	if (!device)
@@ -1961,12 +2007,16 @@ static void __iommu_group_set_core_domain(struct iommu_group *group)
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
+	const struct iommu_domain_ops *ops = domain->ops;
 	int ret;
 
-	if (unlikely(domain->ops->set_dev == NULL))
+	if (unlikely(ops->set_dev == NULL))
 		return -ENODEV;
 
-	ret = domain->ops->set_dev(domain, dev);
+	if (domain->type == IOMMU_DOMAIN_BLOCKED)
+		domain = iommu_get_domain_for_dev(dev);
+
+	ret = ops->set_dev(domain, dev);
 	if (!ret)
 		trace_attach_device_to_domain(dev);
 	return ret;
@@ -3146,29 +3196,6 @@ void iommu_device_unuse_default_domain(struct device *dev)
 	iommu_group_put(group);
 }
 
-static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
-{
-	struct group_device *dev =
-		list_first_entry(&group->devices, struct group_device, list);
-
-	if (group->blocking_domain)
-		return 0;
-
-	group->blocking_domain =
-		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
-	if (!group->blocking_domain) {
-		/*
-		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
-		 * create an empty domain instead.
-		 */
-		group->blocking_domain = __iommu_domain_alloc(
-			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
-		if (!group->blocking_domain)
-			return -EINVAL;
-	}
-	return 0;
-}
-
 /**
  * iommu_group_claim_dma_owner() - Set DMA ownership of a group
  * @group: The group.
@@ -3192,10 +3219,6 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 			goto unlock_out;
 		}
 
-		ret = __iommu_group_alloc_blocking_domain(group);
-		if (ret)
-			goto unlock_out;
-
 		ret = __iommu_group_set_domain(group, group->blocking_domain);
 		if (ret)
 			goto unlock_out;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
