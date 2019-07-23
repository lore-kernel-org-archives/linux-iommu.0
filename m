Return-Path: <SRS0=bViT=VU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEF7C7618B
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 16:08:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC0D21734
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 16:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC0D21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DB789CC1;
	Tue, 23 Jul 2019 16:08:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C3409C9A
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 16:08:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E8AEAFE
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 16:08:30 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 20200FD2400338E74217;
	Wed, 24 Jul 2019 00:08:29 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
	DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server
	id 14.3.439.0; Wed, 24 Jul 2019 00:08:18 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <alex.williamson@redhat.com>, <eric.auger@redhat.com>
Subject: [PATCH v8 1/6] vfio/type1: Introduce iova list and add iommu aperture
	validity check
Date: Tue, 23 Jul 2019 17:06:32 +0100
Message-ID: <20190723160637.8384-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20190723160637.8384-1-shameerali.kolothum.thodi@huawei.com>
References: <20190723160637.8384-1-shameerali.kolothum.thodi@huawei.com>
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

This introduces an iova list that is valid for dma mappings. Make
sure the new iommu aperture window doesn't conflict with the current
one or with any existing dma mappings during attach.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v7-->v8
 -Addressed suggestions by Eric to update comments.
---
 drivers/vfio/vfio_iommu_type1.c | 184 +++++++++++++++++++++++++++++++-
 1 file changed, 181 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 054391f30fa8..6a69652b406b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -62,6 +62,7 @@ MODULE_PARM_DESC(dma_entry_limit,
 
 struct vfio_iommu {
 	struct list_head	domain_list;
+	struct list_head	iova_list;
 	struct vfio_domain	*external_domain; /* domain for external user */
 	struct mutex		lock;
 	struct rb_root		dma_list;
@@ -97,6 +98,12 @@ struct vfio_group {
 	bool			mdev_group;	/* An mdev group */
 };
 
+struct vfio_iova {
+	struct list_head	list;
+	dma_addr_t		start;
+	dma_addr_t		end;
+};
+
 /*
  * Guest RAM pinning working set or DMA target
  */
@@ -1388,6 +1395,146 @@ static int vfio_mdev_iommu_device(struct device *dev, void *data)
 	return 0;
 }
 
+/*
+ * This is a helper function to insert an address range to iova list.
+ * The list is initially created with a single entry corresponding to
+ * the IOMMU domain geometry to which the device group is attached.
+ * The list aperture gets modified when a new domain is added to the
+ * container if the new aperture doesn't conflict with the current one
+ * or with any existing dma mappings. The list is also modified to
+ * exclude any reserved regions associated with the device group.
+ */
+static int vfio_iommu_iova_insert(struct list_head *head,
+				  dma_addr_t start, dma_addr_t end)
+{
+	struct vfio_iova *region;
+
+	region = kmalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&region->list);
+	region->start = start;
+	region->end = end;
+
+	list_add_tail(&region->list, head);
+	return 0;
+}
+
+/*
+ * Check the new iommu aperture conflicts with existing aper or with any
+ * existing dma mappings.
+ */
+static bool vfio_iommu_aper_conflict(struct vfio_iommu *iommu,
+				     dma_addr_t start, dma_addr_t end)
+{
+	struct vfio_iova *first, *last;
+	struct list_head *iova = &iommu->iova_list;
+
+	if (list_empty(iova))
+		return false;
+
+	/* Disjoint sets, return conflict */
+	first = list_first_entry(iova, struct vfio_iova, list);
+	last = list_last_entry(iova, struct vfio_iova, list);
+	if (start > last->end || end < first->start)
+		return true;
+
+	/* Check for any existing dma mappings below the new start */
+	if (start > first->start) {
+		if (vfio_find_dma(iommu, first->start, start - first->start))
+			return true;
+	}
+
+	/* Check for any existing dma mappings beyond the new end */
+	if (end < last->end) {
+		if (vfio_find_dma(iommu, end + 1, last->end - end))
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Resize iommu iova aperture window. This is called only if the new
+ * aperture has no conflict with existing aperture and dma mappings.
+ */
+static int vfio_iommu_aper_resize(struct list_head *iova,
+				  dma_addr_t start, dma_addr_t end)
+{
+	struct vfio_iova *node, *next;
+
+	if (list_empty(iova))
+		return vfio_iommu_iova_insert(iova, start, end);
+
+	/* Adjust iova list start */
+	list_for_each_entry_safe(node, next, iova, list) {
+		if (start < node->start)
+			break;
+		if (start >= node->start && start < node->end) {
+			node->start = start;
+			break;
+		}
+		/* Delete nodes before new start */
+		list_del(&node->list);
+		kfree(node);
+	}
+
+	/* Adjust iova list end */
+	list_for_each_entry_safe(node, next, iova, list) {
+		if (end > node->end)
+			continue;
+		if (end > node->start && end <= node->end) {
+			node->end = end;
+			continue;
+		}
+		/* Delete nodes after new end */
+		list_del(&node->list);
+		kfree(node);
+	}
+
+	return 0;
+}
+
+static void vfio_iommu_iova_free(struct list_head *iova)
+{
+	struct vfio_iova *n, *next;
+
+	list_for_each_entry_safe(n, next, iova, list) {
+		list_del(&n->list);
+		kfree(n);
+	}
+}
+
+static int vfio_iommu_iova_get_copy(struct vfio_iommu *iommu,
+				    struct list_head *iova_copy)
+{
+	struct list_head *iova = &iommu->iova_list;
+	struct vfio_iova *n;
+	int ret;
+
+	list_for_each_entry(n, iova, list) {
+		ret = vfio_iommu_iova_insert(iova_copy, n->start, n->end);
+		if (ret)
+			goto out_free;
+	}
+
+	return 0;
+
+out_free:
+	vfio_iommu_iova_free(iova_copy);
+	return ret;
+}
+
+static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
+					struct list_head *iova_copy)
+{
+	struct list_head *iova = &iommu->iova_list;
+
+	vfio_iommu_iova_free(iova);
+
+	list_splice_tail(iova_copy, iova);
+}
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -1398,6 +1545,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	int ret;
 	bool resv_msi, msi_remap;
 	phys_addr_t resv_msi_base;
+	struct iommu_domain_geometry geo;
+	LIST_HEAD(iova_copy);
 
 	mutex_lock(&iommu->lock);
 
@@ -1474,6 +1623,29 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_domain;
 
+	/* Get aperture info */
+	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY, &geo);
+
+	if (vfio_iommu_aper_conflict(iommu, geo.aperture_start,
+				     geo.aperture_end)) {
+		ret = -EINVAL;
+		goto out_detach;
+	}
+
+	/*
+	 * We don't want to work on the original iova list as the list
+	 * gets modified and in case of failure we have to retain the
+	 * original list. Get a copy here.
+	 */
+	ret = vfio_iommu_iova_get_copy(iommu, &iova_copy);
+	if (ret)
+		goto out_detach;
+
+	ret = vfio_iommu_aper_resize(&iova_copy, geo.aperture_start,
+				     geo.aperture_end);
+	if (ret)
+		goto out_detach;
+
 	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
 
 	INIT_LIST_HEAD(&domain->group_list);
@@ -1507,8 +1679,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 				list_add(&group->next, &d->group_list);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
-				mutex_unlock(&iommu->lock);
-				return 0;
+				goto done;
 			}
 
 			ret = vfio_iommu_attach_group(domain, group);
@@ -1531,7 +1702,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	}
 
 	list_add(&domain->next, &iommu->domain_list);
-
+done:
+	/* Delete the old one and insert new iova list */
+	vfio_iommu_iova_insert_copy(iommu, &iova_copy);
 	mutex_unlock(&iommu->lock);
 
 	return 0;
@@ -1540,6 +1713,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	vfio_iommu_detach_group(domain, group);
 out_domain:
 	iommu_domain_free(domain->domain);
+	vfio_iommu_iova_free(&iova_copy);
 out_free:
 	kfree(domain);
 	kfree(group);
@@ -1679,6 +1853,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	}
 
 	INIT_LIST_HEAD(&iommu->domain_list);
+	INIT_LIST_HEAD(&iommu->iova_list);
 	iommu->dma_list = RB_ROOT;
 	iommu->dma_avail = dma_entry_limit;
 	mutex_init(&iommu->lock);
@@ -1722,6 +1897,9 @@ static void vfio_iommu_type1_release(void *iommu_data)
 		list_del(&domain->next);
 		kfree(domain);
 	}
+
+	vfio_iommu_iova_free(&iommu->iova_list);
+
 	kfree(iommu);
 }
 
-- 
2.17.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
