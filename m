Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D38C43381
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:18:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD7164DEF
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 15:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD7164DEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A96D0868B4;
	Thu, 28 Jan 2021 15:18:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5oAP-Lbj_JPX; Thu, 28 Jan 2021 15:18:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ED91A86895;
	Thu, 28 Jan 2021 15:18:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDA40C0FA7;
	Thu, 28 Jan 2021 15:18:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DBD6C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EDD728743F
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:18:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3s3SdqDxmauH for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 15:18:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6150687431
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 15:18:18 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DRPG04PzBz7bL1;
 Thu, 28 Jan 2021 23:16:56 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 28 Jan 2021 23:18:01 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <kvm@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
 <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Marc Zyngier <maz@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC PATCH 09/11] vfio/iommu_type1: Add HWDBM status maintanance
Date: Thu, 28 Jan 2021 23:17:40 +0800
Message-ID: <20210128151742.18840-10-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210128151742.18840-1-zhukeqian1@huawei.com>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Cornelia Huck <cohuck@redhat.com>,
 lushenming@huawei.com, Kirti Wankhede <kwankhede@nvidia.com>,
 James Morse <james.morse@arm.com>, wanghaibin.wang@huawei.com,
 Robin Murphy <robin.murphy@arm.com>
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

From: jiangkunkun <jiangkunkun@huawei.com>

We are going to optimize dirty log tracking based on iommu
HWDBM feature, but the dirty log from iommu is useful only
when all iommu backed groups are connected to iommu with
HWDBM feature. This maintains a counter for this feature.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
---
 drivers/vfio/vfio_iommu_type1.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0b4dedaa9128..3b8522ebf955 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -74,6 +74,7 @@ struct vfio_iommu {
 	bool			nesting;
 	bool			dirty_page_tracking;
 	bool			pinned_page_dirty_scope;
+	uint64_t		num_non_hwdbm_groups;
 };
 
 struct vfio_domain {
@@ -102,6 +103,7 @@ struct vfio_group {
 	struct list_head	next;
 	bool			mdev_group;	/* An mdev group */
 	bool			pinned_page_dirty_scope;
+	bool			iommu_hwdbm;	/* Valid for non-mdev group */
 };
 
 struct vfio_iova {
@@ -976,6 +978,27 @@ static void vfio_update_pgsize_bitmap(struct vfio_iommu *iommu)
 	}
 }
 
+static int vfio_dev_has_feature(struct device *dev, void *data)
+{
+	enum iommu_dev_features *feat = data;
+
+	if (!iommu_dev_has_feature(dev, *feat))
+		return -ENODEV;
+
+	return 0;
+}
+
+static bool vfio_group_supports_hwdbm(struct vfio_group *group)
+{
+	enum iommu_dev_features feat = IOMMU_DEV_FEAT_HWDBM;
+
+	if (iommu_group_for_each_dev(group->iommu_group, &feat,
+				     vfio_dev_has_feature))
+		return false;
+
+	return true;
+}
+
 static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
 			      struct vfio_dma *dma, dma_addr_t base_iova,
 			      size_t pgsize)
@@ -2189,6 +2212,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	 * capable via the page pinning interface.
 	 */
 	iommu->pinned_page_dirty_scope = false;
+
+	/* Update the hwdbm status of group and iommu */
+	group->iommu_hwdbm = vfio_group_supports_hwdbm(group);
+	if (!group->iommu_hwdbm)
+		iommu->num_non_hwdbm_groups++;
+
 	mutex_unlock(&iommu->lock);
 	vfio_iommu_resv_free(&group_resv_regions);
 
@@ -2342,6 +2371,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 	struct vfio_domain *domain;
 	struct vfio_group *group;
 	bool update_dirty_scope = false;
+	bool update_iommu_hwdbm = false;
 	LIST_HEAD(iova_copy);
 
 	mutex_lock(&iommu->lock);
@@ -2380,6 +2410,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 
 		vfio_iommu_detach_group(domain, group);
 		update_dirty_scope = !group->pinned_page_dirty_scope;
+		update_iommu_hwdbm = !group->iommu_hwdbm;
 		list_del(&group->next);
 		kfree(group);
 		/*
@@ -2417,6 +2448,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 	 */
 	if (update_dirty_scope)
 		update_pinned_page_dirty_scope(iommu);
+	if (update_iommu_hwdbm)
+		iommu->num_non_hwdbm_groups--;
 	mutex_unlock(&iommu->lock);
 }
 
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
