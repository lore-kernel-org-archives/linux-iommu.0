Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C18C433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 01:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 39B7040180;
	Tue,  8 Feb 2022 01:28:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TOHIRlQvPU0q; Tue,  8 Feb 2022 01:28:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F4AA40136;
	Tue,  8 Feb 2022 01:28:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A33CC001A;
	Tue,  8 Feb 2022 01:28:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E4A2C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EFEE4015F
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:28:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DGRTNhgdMs7S for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 01:28:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE82B40140
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644283682; x=1675819682;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5nC5HUNWEMGddahPwy3d2IwT2x0IWkmWDFevLiz9p1o=;
 b=E6kyAdH8bjEHTy50MVb4HILg+Va3/ZUzaX7z35yIiIdfhOVkBI+73zlU
 xxY/6QTWr/uyEjg98rTHfAcL/RkITpUUAOo0YK6+OENqthKOjizK7xmd9
 pEZrryGA90bTpOyLrRxFfDFNep56nTHd1lRfYOJ9SWHvikYK6T8awHM8c
 gUvIvn/vkNMOLxXZKyD7jMozrW5UTcdYWM2YJLqriD8XNywpO3UC8JaqS
 R0mbZ9njaKqTwU0I6NARcm1DisW7q+kdfif+h0eqEVI+CJ3h3fPxsG5qv
 9qiRJQl4B80Aa5ByxIFkTdDNT+zoPxdGfBR8u2m/er4otYi6lsPmR93jK Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="228816337"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="228816337"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 17:28:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677948859"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 17:27:56 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 08/10] iommu: Remove unused argument in is_attach_deferred
Date: Tue,  8 Feb 2022 09:25:57 +0800
Message-Id: <20220208012559.1121729-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
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

The is_attach_deferred iommu_ops callback is a device op. The domain
argument is unnecessary and never used. Remove it to make code clean.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h         |  2 +-
 drivers/iommu/amd/amd_iommu.h |  3 +--
 drivers/iommu/amd/iommu.c     |  3 +--
 drivers/iommu/amd/iommu_v2.c  |  2 +-
 drivers/iommu/intel/iommu.c   |  3 +--
 drivers/iommu/iommu.c         | 15 ++++++---------
 6 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index eb2684f95018..47ca7eca5d7b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -269,7 +269,7 @@ struct iommu_ops {
 	void (*put_resv_regions)(struct device *dev, struct list_head *list);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
-	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
+	bool (*is_attach_deferred)(struct device *dev);
 
 	/* Per device IOMMU features */
 	bool (*dev_has_feat)(struct device *dev, enum iommu_dev_features f);
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 416815a525d6..3b2f06b7aca6 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -116,8 +116,7 @@ void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
 
 
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
-extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
-					 struct device *dev);
+extern bool amd_iommu_is_attach_deferred(struct device *dev);
 extern int __init add_special_device(u8 type, u8 id, u16 *devid,
 				     bool cmd_line);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 461f1844ed1f..37f2fbb4b129 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2215,8 +2215,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	list_add_tail(&region->list, head);
 }
 
-bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
-				  struct device *dev)
+bool amd_iommu_is_attach_deferred(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 58da08cc3d01..7c94ec05d289 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -537,7 +537,7 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	ret = NOTIFY_DONE;
 
 	/* In kdump kernel pci dev is not initialized yet -> send INVALID */
-	if (amd_iommu_is_attach_deferred(NULL, &pdev->dev)) {
+	if (amd_iommu_is_attach_deferred(&pdev->dev)) {
 		amd_iommu_complete_ppr(pdev, iommu_fault->pasid,
 				       PPR_INVALID, tag);
 		goto out;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2b5f4e57a8bb..80f1294be634 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5052,8 +5052,7 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 	}
 }
 
-static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
-					   struct device *dev)
+static bool intel_iommu_is_attach_deferred(struct device *dev)
 {
 	return attach_deferred(dev);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index de593a9cc09c..3dff30ddebdd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -825,13 +825,12 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 	return ret;
 }
 
-static bool iommu_is_attach_deferred(struct iommu_domain *domain,
-				     struct device *dev)
+static bool iommu_is_attach_deferred(struct device *dev)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops->is_attach_deferred)
-		return ops->is_attach_deferred(domain, dev);
+		return ops->is_attach_deferred(dev);
 
 	return false;
 }
@@ -888,7 +887,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain  && !iommu_is_attach_deferred(group->domain, dev))
+	if (group->domain  && !iommu_is_attach_deferred(dev))
 		ret = __iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
 	if (ret)
@@ -1743,7 +1742,7 @@ static int iommu_group_do_dma_attach(struct device *dev, void *data)
 	struct iommu_domain *domain = data;
 	int ret = 0;
 
-	if (!iommu_is_attach_deferred(domain, dev))
+	if (!iommu_is_attach_deferred(dev))
 		ret = __iommu_attach_device(domain, dev);
 
 	return ret;
@@ -2018,9 +2017,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
+	if (iommu_is_attach_deferred(dev))
 		return __iommu_attach_device(domain, dev);
 
 	return 0;
@@ -2029,7 +2026,7 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	if (iommu_is_attach_deferred(domain, dev))
+	if (iommu_is_attach_deferred(dev))
 		return;
 
 	if (unlikely(domain->ops->detach_dev == NULL))
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
