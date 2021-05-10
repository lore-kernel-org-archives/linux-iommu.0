Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA893C43460
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C5A6144F
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C5A6144F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59EAC83A4B;
	Mon, 10 May 2021 06:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FVJ-y03XTm2E; Mon, 10 May 2021 06:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12FDC839C0;
	Mon, 10 May 2021 06:54:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09F39C000D;
	Mon, 10 May 2021 06:54:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C1C2C0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E369F60B4D
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YUBOGFQFD7S1 for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 06:54:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E901F607EA
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=uWXnpdjntQvTGukX3L8+QnDTuraeIHz6AGtnWQeYrSU=; b=GXLaXGhKxAntojzstPGj8jIuuv
 MR0YD2SpOebyht4W2y3yzgofDJP1+6NIKIs6q5RlNdEsVoT2RnIa7T5cIek1jj8Ik8b87onc6CMC8
 Gmx/2Dm9xWr5iWUtF5QgeYN4BLMB/0lA4WvyZz2bwNgEN+ZjXRE5Sgv0iVnaqpvhAnCGZjaccXVIg
 x50qHKL4jiQh6OQCgSAOKIeKGT8c4qxqgZrGZk5zHIzKTQ62hQ4p95+zM3O5w2Eao8VwrmrUG62NT
 9nFhDcNS5KDrcF7DAPI5gnqfo9Y2tLvZjMZWE9PCoFiMixyRGJm3/HKpH4bXh3ZZ//MirUnBE5Vyr
 pM65IwqQ==;
Received: from [2001:4bb8:198:fbc8:e179:16d2:93d1:8e1] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lfzo0-008LoP-2s; Mon, 10 May 2021 06:54:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 3/6] vfio: remove the unused mdev iommu hook
Date: Mon, 10 May 2021 08:54:02 +0200
Message-Id: <20210510065405.2334771-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510065405.2334771-1-hch@lst.de>
References: <20210510065405.2334771-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: kvm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

The iommu_device field in struct mdev_device has never been used
since it was added more than 2 years ago.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/vfio/vfio_iommu_type1.c | 132 ++++++--------------------------
 include/linux/mdev.h            |  20 -----
 2 files changed, 25 insertions(+), 127 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index a0747c35a7781e..5974a3fb2e2e12 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -113,7 +113,6 @@ struct vfio_batch {
 struct vfio_group {
 	struct iommu_group	*iommu_group;
 	struct list_head	next;
-	bool			mdev_group;	/* An mdev group */
 	bool			pinned_page_dirty_scope;
 };
 
@@ -1932,61 +1931,6 @@ static bool vfio_iommu_has_sw_msi(struct list_head *group_resv_regions,
 	return ret;
 }
 
-static int vfio_mdev_attach_domain(struct device *dev, void *data)
-{
-	struct mdev_device *mdev = to_mdev_device(dev);
-	struct iommu_domain *domain = data;
-	struct device *iommu_device;
-
-	iommu_device = mdev_get_iommu_device(mdev);
-	if (iommu_device) {
-		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
-			return iommu_aux_attach_device(domain, iommu_device);
-		else
-			return iommu_attach_device(domain, iommu_device);
-	}
-
-	return -EINVAL;
-}
-
-static int vfio_mdev_detach_domain(struct device *dev, void *data)
-{
-	struct mdev_device *mdev = to_mdev_device(dev);
-	struct iommu_domain *domain = data;
-	struct device *iommu_device;
-
-	iommu_device = mdev_get_iommu_device(mdev);
-	if (iommu_device) {
-		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
-			iommu_aux_detach_device(domain, iommu_device);
-		else
-			iommu_detach_device(domain, iommu_device);
-	}
-
-	return 0;
-}
-
-static int vfio_iommu_attach_group(struct vfio_domain *domain,
-				   struct vfio_group *group)
-{
-	if (group->mdev_group)
-		return iommu_group_for_each_dev(group->iommu_group,
-						domain->domain,
-						vfio_mdev_attach_domain);
-	else
-		return iommu_attach_group(domain->domain, group->iommu_group);
-}
-
-static void vfio_iommu_detach_group(struct vfio_domain *domain,
-				    struct vfio_group *group)
-{
-	if (group->mdev_group)
-		iommu_group_for_each_dev(group->iommu_group, domain->domain,
-					 vfio_mdev_detach_domain);
-	else
-		iommu_detach_group(domain->domain, group->iommu_group);
-}
-
 static bool vfio_bus_is_mdev(struct bus_type *bus)
 {
 	struct bus_type *mdev_bus;
@@ -2001,20 +1945,6 @@ static bool vfio_bus_is_mdev(struct bus_type *bus)
 	return ret;
 }
 
-static int vfio_mdev_iommu_device(struct device *dev, void *data)
-{
-	struct mdev_device *mdev = to_mdev_device(dev);
-	struct device **old = data, *new;
-
-	new = mdev_get_iommu_device(mdev);
-	if (!new || (*old && *old != new))
-		return -EINVAL;
-
-	*old = new;
-
-	return 0;
-}
-
 /*
  * This is a helper function to insert an address range to iova list.
  * The list is initially created with a single entry corresponding to
@@ -2275,38 +2205,24 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		goto out_free;
 
 	if (vfio_bus_is_mdev(bus)) {
-		struct device *iommu_device = NULL;
-
-		group->mdev_group = true;
-
-		/* Determine the isolation type */
-		ret = iommu_group_for_each_dev(iommu_group, &iommu_device,
-					       vfio_mdev_iommu_device);
-		if (ret || !iommu_device) {
-			if (!iommu->external_domain) {
-				INIT_LIST_HEAD(&domain->group_list);
-				iommu->external_domain = domain;
-				vfio_update_pgsize_bitmap(iommu);
-			} else {
-				kfree(domain);
-			}
-
-			list_add(&group->next,
-				 &iommu->external_domain->group_list);
-			/*
-			 * Non-iommu backed group cannot dirty memory directly,
-			 * it can only use interfaces that provide dirty
-			 * tracking.
-			 * The iommu scope can only be promoted with the
-			 * addition of a dirty tracking group.
-			 */
-			group->pinned_page_dirty_scope = true;
-			mutex_unlock(&iommu->lock);
-
-			return 0;
+		if (!iommu->external_domain) {
+			INIT_LIST_HEAD(&domain->group_list);
+			iommu->external_domain = domain;
+			vfio_update_pgsize_bitmap(iommu);
+		} else {
+			kfree(domain);
 		}
 
-		bus = iommu_device->bus;
+		list_add(&group->next, &iommu->external_domain->group_list);
+		/*
+		 * Non-iommu backed group cannot dirty memory directly, it can
+		 * only use interfaces that provide dirty tracking.
+		 * The iommu scope can only be promoted with the addition of a
+		 * dirty tracking group.
+		 */
+		group->pinned_page_dirty_scope = true;
+		mutex_unlock(&iommu->lock);
+		return 0;
 	}
 
 	domain->domain = iommu_domain_alloc(bus);
@@ -2321,7 +2237,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 			goto out_domain;
 	}
 
-	ret = vfio_iommu_attach_group(domain, group);
+	ret = iommu_attach_group(domain->domain, group->iommu_group);
 	if (ret)
 		goto out_domain;
 
@@ -2388,15 +2304,17 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	list_for_each_entry(d, &iommu->domain_list, next) {
 		if (d->domain->ops == domain->domain->ops &&
 		    d->prot == domain->prot) {
-			vfio_iommu_detach_group(domain, group);
-			if (!vfio_iommu_attach_group(d, group)) {
+			iommu_detach_group(domain->domain, group->iommu_group);
+			if (!iommu_attach_group(d->domain,
+						group->iommu_group)) {
 				list_add(&group->next, &d->group_list);
 				iommu_domain_free(domain->domain);
 				kfree(domain);
 				goto done;
 			}
 
-			ret = vfio_iommu_attach_group(domain, group);
+			ret = iommu_attach_group(domain->domain,
+						 group->iommu_group);
 			if (ret)
 				goto out_domain;
 		}
@@ -2433,7 +2351,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	return 0;
 
 out_detach:
-	vfio_iommu_detach_group(domain, group);
+	iommu_detach_group(domain->domain, group->iommu_group);
 out_domain:
 	iommu_domain_free(domain->domain);
 	vfio_iommu_iova_free(&iova_copy);
@@ -2598,7 +2516,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 		if (!group)
 			continue;
 
-		vfio_iommu_detach_group(domain, group);
+		iommu_detach_group(domain->domain, group->iommu_group);
 		update_dirty_scope = !group->pinned_page_dirty_scope;
 		list_del(&group->next);
 		kfree(group);
@@ -2686,7 +2604,7 @@ static void vfio_release_domain(struct vfio_domain *domain, bool external)
 	list_for_each_entry_safe(group, group_tmp,
 				 &domain->group_list, next) {
 		if (!external)
-			vfio_iommu_detach_group(domain, group);
+			iommu_detach_group(domain->domain, group->iommu_group);
 		list_del(&group->next);
 		kfree(group);
 	}
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 1fb34ea394ad46..bf818e6f8931ed 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -18,7 +18,6 @@ struct mdev_device {
 	void *driver_data;
 	struct list_head next;
 	struct mdev_type *type;
-	struct device *iommu_device;
 	bool active;
 };
 
@@ -27,25 +26,6 @@ static inline struct mdev_device *to_mdev_device(struct device *dev)
 	return container_of(dev, struct mdev_device, dev);
 }
 
-/*
- * Called by the parent device driver to set the device which represents
- * this mdev in iommu protection scope. By default, the iommu device is
- * NULL, that indicates using vendor defined isolation.
- *
- * @dev: the mediated device that iommu will isolate.
- * @iommu_device: a pci device which represents the iommu for @dev.
- */
-static inline void mdev_set_iommu_device(struct mdev_device *mdev,
-					 struct device *iommu_device)
-{
-	mdev->iommu_device = iommu_device;
-}
-
-static inline struct device *mdev_get_iommu_device(struct mdev_device *mdev)
-{
-	return mdev->iommu_device;
-}
-
 unsigned int mdev_get_type_group_id(struct mdev_device *mdev);
 unsigned int mtype_get_type_group_id(struct mdev_type *mtype);
 struct device *mtype_get_parent_dev(struct mdev_type *mtype);
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
