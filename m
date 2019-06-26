Return-Path: <SRS0=d63v=UZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954B3C48BD9
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 15:13:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FC02133F
	for <iommu@archiver.kernel.org>; Wed, 26 Jun 2019 15:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FC02133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D61A6E59;
	Wed, 26 Jun 2019 15:13:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0E9A9AC7
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 15:13:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6BFBF87F
	for <iommu@lists.linux-foundation.org>;
	Wed, 26 Jun 2019 15:13:55 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 5A61315EC890CCFBC107;
	Wed, 26 Jun 2019 23:13:47 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
	DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server
	id 14.3.439.0; Wed, 26 Jun 2019 23:13:36 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
	<pmorel@linux.vnet.ibm.com>
Subject: [PATCH v7 2/6] vfio/type1: Check reserve region conflict and update
	iova list
Date: Wed, 26 Jun 2019 16:12:44 +0100
Message-ID: <20190626151248.11776-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190626151248.11776-1-shameerali.kolothum.thodi@huawei.com>
References: <20190626151248.11776-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Cc: kevin.tian@intel.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	xuwei5@hisilicon.com, linuxarm@huawei.com, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This retrieves the reserved regions associated with dev group and
checks for conflicts with any existing dma mappings. Also update
the iova list excluding the reserved regions.

Reserved regions with type IOMMU_RESV_DIRECT_RELAXABLE are
excluded from above checks as they are considered as directly
mapped regions which are known to be relaxable.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 96 +++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 970d1ec06aed..b6bfdfa16c33 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1508,6 +1508,88 @@ static int vfio_iommu_aper_resize(struct list_head *iova,
 	return 0;
 }
 
+/*
+ * Check reserved region conflicts with existing dma mappings
+ */
+static bool vfio_iommu_resv_conflict(struct vfio_iommu *iommu,
+				     struct list_head *resv_regions)
+{
+	struct iommu_resv_region *region;
+
+	/* Check for conflict with existing dma mappings */
+	list_for_each_entry(region, resv_regions, list) {
+		if (region->type == IOMMU_RESV_DIRECT_RELAXABLE)
+			continue;
+
+		if (vfio_find_dma(iommu, region->start, region->length))
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Check iova region overlap with  reserved regions and
+ * exclude them from the iommu iova range
+ */
+static int vfio_iommu_resv_exclude(struct list_head *iova,
+				   struct list_head *resv_regions)
+{
+	struct iommu_resv_region *resv;
+	struct vfio_iova *n, *next;
+
+	list_for_each_entry(resv, resv_regions, list) {
+		phys_addr_t start, end;
+
+		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
+			continue;
+
+		start = resv->start;
+		end = resv->start + resv->length - 1;
+
+		list_for_each_entry_safe(n, next, iova, list) {
+			int ret = 0;
+
+			/* No overlap */
+			if (start > n->end || end < n->start)
+				continue;
+			/*
+			 * Insert a new node if current node overlaps with the
+			 * reserve region to exlude that from valid iova range.
+			 * Note that, new node is inserted before the current
+			 * node and finally the current node is deleted keeping
+			 * the list updated and sorted.
+			 */
+			if (start > n->start)
+				ret = vfio_iommu_iova_insert(&n->list, n->start,
+							     start - 1);
+			if (!ret && end < n->end)
+				ret = vfio_iommu_iova_insert(&n->list, end + 1,
+							     n->end);
+			if (ret)
+				return ret;
+
+			list_del(&n->list);
+			kfree(n);
+		}
+	}
+
+	if (list_empty(iova))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void vfio_iommu_resv_free(struct list_head *resv_regions)
+{
+	struct iommu_resv_region *n, *next;
+
+	list_for_each_entry_safe(n, next, resv_regions, list) {
+		list_del(&n->list);
+		kfree(n);
+	}
+}
+
 static void vfio_iommu_iova_free(struct list_head *iova)
 {
 	struct vfio_iova *n, *next;
@@ -1559,6 +1641,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	phys_addr_t resv_msi_base;
 	struct iommu_domain_geometry geo;
 	LIST_HEAD(iova_copy);
+	LIST_HEAD(group_resv_regions);
 
 	mutex_lock(&iommu->lock);
 
@@ -1644,6 +1727,13 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		goto out_detach;
 	}
 
+	iommu_get_group_resv_regions(iommu_group, &group_resv_regions);
+
+	if (vfio_iommu_resv_conflict(iommu, &group_resv_regions)) {
+		ret = -EINVAL;
+		goto out_detach;
+	}
+
 	/* Get a copy of the current iova list and work on it */
 	ret = vfio_iommu_iova_get_copy(iommu, &iova_copy);
 	if (ret)
@@ -1654,6 +1744,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_detach;
 
+	ret = vfio_iommu_resv_exclude(&iova_copy, &group_resv_regions);
+	if (ret)
+		goto out_detach;
+
 	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
 
 	INIT_LIST_HEAD(&domain->group_list);
@@ -1714,6 +1808,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	/* Delete the old one and insert new iova list */
 	vfio_iommu_iova_insert_copy(iommu, &iova_copy);
 	mutex_unlock(&iommu->lock);
+	vfio_iommu_resv_free(&group_resv_regions);
 
 	return 0;
 
@@ -1722,6 +1817,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 out_domain:
 	iommu_domain_free(domain->domain);
 	vfio_iommu_iova_free(&iova_copy);
+	vfio_iommu_resv_free(&group_resv_regions);
 out_free:
 	kfree(domain);
 	kfree(group);
-- 
2.17.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
