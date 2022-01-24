Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AA8C433FE
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 07:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC3DF40179;
	Mon, 24 Jan 2022 07:12:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BDEM0lz56YAZ; Mon, 24 Jan 2022 07:12:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 79D1C40180;
	Mon, 24 Jan 2022 07:12:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54BF6C0031;
	Mon, 24 Jan 2022 07:12:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F8B0C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 07:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BCC940116
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 07:12:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jnGrHASEMfJR for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 07:12:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AD13400F1
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643008372; x=1674544372;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N6lXBd1Dp4wenuwyBvOUNcK/XHtYdsl24YRAMWC14ws=;
 b=nk0gG1wNJKu9CrzibVKvyBdZOlRe9XmfEZyYmKRlG3zVEMXuL7tiY/iQ
 JRsft+EXTWUoG2lfAYf812S4ji4SbypHSy3QzqQ82uj/oiNnlB6BMl1EA
 jvIYu46c0SNCrzHmXZ7Ds+uxXFISPbwAcyvVfeodwdxYw3WbQwRcX519a
 YuYkoh0Y0STc3fRHbW4biJkc8BV3bGJ/2nkY6J4ROTODNypACX+xITliJ
 0B4TzQbwIYxpvoFMQDVM/jdrlYv53fG9EbRS5ggiDYiUOgNRYdhw8Afo+
 W0yaAGpCMXHBlGXUoSXMgtPeQQQh6CtMUnRc4/HdJl+MiWHmKLonUBtdR A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245925952"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="245925952"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2022 23:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="627387820"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga004.jf.intel.com with ESMTP; 23 Jan 2022 23:12:47 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Date: Mon, 24 Jan 2022 15:11:01 +0800
Message-Id: <20220124071103.2097118-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
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

The common iommu_ops is hooked to both device and domain. When a helper
has both device and domain pointer, the way to get the iommu_ops looks
messy in iommu core. This sorts out the way to get iommu_ops. The device
related helpers go through device pointer, while the domain related ones
go through domain pointer.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  8 ++++++++
 drivers/iommu/iommu.c | 25 ++++++++++++++-----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index aa5486243892..111b3e9c79bb 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -385,6 +385,14 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 	};
 }
 
+static inline const struct iommu_ops *dev_iommu_ops_get(struct device *dev)
+{
+	if (dev && dev->iommu && dev->iommu->iommu_dev)
+		return dev->iommu->iommu_dev->ops;
+
+	return NULL;
+}
+
 #define IOMMU_BUS_NOTIFY_PRIORITY		0
 #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
 #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5230c6d90ece..6631e2ea44df 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -764,6 +764,7 @@ EXPORT_SYMBOL_GPL(iommu_group_set_name);
 static int iommu_create_device_direct_mappings(struct iommu_group *group,
 					       struct device *dev)
 {
+	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
 	struct iommu_domain *domain = group->default_domain;
 	struct iommu_resv_region *entry;
 	struct list_head mappings;
@@ -785,8 +786,8 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 		dma_addr_t start, end, addr;
 		size_t map_size = 0;
 
-		if (domain->ops->apply_resv_region)
-			domain->ops->apply_resv_region(dev, domain, entry);
+		if (ops->apply_resv_region)
+			ops->apply_resv_region(dev, domain, entry);
 
 		start = ALIGN(entry->start, pg_size);
 		end   = ALIGN(entry->start + entry->length, pg_size);
@@ -831,8 +832,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 static bool iommu_is_attach_deferred(struct iommu_domain *domain,
 				     struct device *dev)
 {
-	if (domain->ops->is_attach_deferred)
-		return domain->ops->is_attach_deferred(domain, dev);
+	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
+
+	if (ops->is_attach_deferred)
+		return ops->is_attach_deferred(domain, dev);
 
 	return false;
 }
@@ -1251,10 +1254,10 @@ int iommu_page_response(struct device *dev,
 	struct iommu_fault_event *evt;
 	struct iommu_fault_page_request *prm;
 	struct dev_iommu *param = dev->iommu;
+	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
 	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 
-	if (!domain || !domain->ops->page_response)
+	if (!ops || !ops->page_response)
 		return -ENODEV;
 
 	if (!param || !param->fault_param)
@@ -1295,7 +1298,7 @@ int iommu_page_response(struct device *dev,
 			msg->pasid = 0;
 		}
 
-		ret = domain->ops->page_response(dev, evt, msg);
+		ret = ops->page_response(dev, evt, msg);
 		list_del(&evt->list);
 		kfree(evt);
 		break;
@@ -1758,10 +1761,10 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
 
 static int iommu_group_do_probe_finalize(struct device *dev, void *data)
 {
-	struct iommu_domain *domain = data;
+	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
 
-	if (domain->ops->probe_finalize)
-		domain->ops->probe_finalize(dev);
+	if (ops->probe_finalize)
+		ops->probe_finalize(dev);
 
 	return 0;
 }
@@ -2020,7 +2023,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	const struct iommu_ops *ops = domain->ops;
+	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
 
 	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
 		return __iommu_attach_device(domain, dev);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
