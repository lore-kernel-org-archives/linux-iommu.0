Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E0DC433F5
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E46E61051
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E46E61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DF1384061;
	Sun, 19 Sep 2021 06:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0LgNtduehwTR; Sun, 19 Sep 2021 06:43:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A1F66837C0;
	Sun, 19 Sep 2021 06:43:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B962C0011;
	Sun, 19 Sep 2021 06:43:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FDC6C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11F3583A7E
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id egeprKkLRJXs for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:43:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F1D3837C0
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:43:18 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="202493422"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="202493422"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510702133"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:43:11 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 16/20] vfio/type1: Export symbols for dma [un]map code sharing
Date: Sun, 19 Sep 2021 14:38:44 +0800
Message-Id: <20210919063848.1476776-17-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210919063848.1476776-1-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, kwankhede@nvidia.com, jean-philippe@linaro.org,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
 david@gibson.dropbear.id.au, robin.murphy@arm.com, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, dwmw2@infradead.org
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

[HACK. will fix in v2]

There are two options to impelement vfio type1v2 mapping semantics in
/dev/iommu.

One is to duplicate the related code from vfio as the starting point,
and then merge with vfio type1 at a later time. However vfio_iommu_type1.c
has over 3000LOC with ~80% related to dma management logic, including:

- the dma map/unmap metadata management
- page pinning, and related accounting
- iova range reporting
- dirty bitmap retrieving
- dynamic vaddr update, etc.

Not sure whether duplicating such amount of code in the transition phase
is acceptable.

The alternative is to consolidate type1v2 logic in /dev/iommu immediately,
which requires converting vfio_iommu_type1 to be a shim driver. The upside
is no code duplication and it is anyway the long-term goal even with the
first approach. The downside is that more effort is required for the
'initial' skeleton thus all new iommu features will be blocked for a longer
time. Main task is to figure out how to handle the remaining 20% code (tied
with group) in vfio_iommu_type1 with device-centric model in iommufd (with
group managed by iommu core). It also implies that no-snoop DMA must be
handled now with extra work on reworked kvm-vfio contract. and also need
to support external page pinning as required by sw mdev.

Due to limited time, we choose a hacky approach in this RFC by directly
calling vfio_iommu_type1 functions in iommufd and raising this open for
discussion. This should not impact the review on other key aspects of the
new framework. Once we reach consensus, we'll follow it to do a clean
implementation 'in' next version.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/vfio_iommu_type1.c | 199 +++++++++++++++++++++++++++++++-
 include/linux/vfio.h            |  13 +++
 2 files changed, 206 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0b4f7c174c7a..c1c6bc803d94 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -115,6 +115,7 @@ struct vfio_iommu_group {
 	struct list_head	next;
 	bool			mdev_group;	/* An mdev group */
 	bool			pinned_page_dirty_scope;
+	int			attach_cnt;
 };
 
 struct vfio_iova {
@@ -2240,6 +2241,135 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
 	list_splice_tail(iova_copy, iova);
 }
 
+/* HACK: called by /dev/iommu core to init group to vfio_iommu_type1 */
+int vfio_iommu_add_group(struct vfio_iommu *iommu,
+			 struct iommu_group *iommu_group,
+			 struct iommu_domain *iommu_domain)
+{
+	struct vfio_iommu_group *group;
+	struct vfio_domain *domain = NULL;
+	struct bus_type *bus = NULL;
+	int ret = 0;
+	bool resv_msi, msi_remap;
+	phys_addr_t resv_msi_base = 0;
+	struct iommu_domain_geometry *geo;
+	LIST_HEAD(iova_copy);
+	LIST_HEAD(group_resv_regions);
+
+	/* Determine bus_type */
+	ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
+	if (ret)
+		return ret;
+
+	mutex_lock(&iommu->lock);
+
+	/* Check for duplicates */
+	group = vfio_iommu_find_iommu_group(iommu, iommu_group);
+	if (group) {
+		group->attach_cnt++;
+		mutex_unlock(&iommu->lock);
+		return 0;
+	}
+
+	/* Get aperture info */
+	geo = &iommu_domain->geometry;
+	if (vfio_iommu_aper_conflict(iommu, geo->aperture_start,
+				     geo->aperture_end)) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	ret = iommu_get_group_resv_regions(iommu_group, &group_resv_regions);
+	if (ret)
+		goto out_free;
+
+	if (vfio_iommu_resv_conflict(iommu, &group_resv_regions)) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	/*
+	 * We don't want to work on the original iova list as the list
+	 * gets modified and in case of failure we have to retain the
+	 * original list. Get a copy here.
+	 */
+	ret = vfio_iommu_iova_get_copy(iommu, &iova_copy);
+	if (ret)
+		goto out_free;
+
+	ret = vfio_iommu_aper_resize(&iova_copy, geo->aperture_start,
+				     geo->aperture_end);
+	if (ret)
+		goto out_free;
+
+	ret = vfio_iommu_resv_exclude(&iova_copy, &group_resv_regions);
+	if (ret)
+		goto out_free;
+
+	resv_msi = vfio_iommu_has_sw_msi(&group_resv_regions, &resv_msi_base);
+
+	msi_remap = irq_domain_check_msi_remap() ||
+		    iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
+
+	if (!allow_unsafe_interrupts && !msi_remap) {
+		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
+		       __func__);
+		ret = -EPERM;
+		goto out_free;
+	}
+
+	if (resv_msi) {
+		ret = iommu_get_msi_cookie(iommu_domain, resv_msi_base);
+		if (ret && ret != -ENODEV)
+			goto out_free;
+	}
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	if (!group) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	group->iommu_group = iommu_group;
+
+	if (!list_empty(&iommu->domain_list)) {
+		domain = list_first_entry(&iommu->domain_list,
+					  struct vfio_domain, next);
+	} else {
+		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+		if (!domain) {
+			kfree(group);
+			ret = -ENOMEM;
+			goto out_free;
+		}
+		domain->domain = iommu_domain;
+		INIT_LIST_HEAD(&domain->group_list);
+		list_add(&domain->next, &iommu->domain_list);
+	}
+
+	list_add(&group->next, &domain->group_list);
+
+	vfio_test_domain_fgsp(domain);
+
+	vfio_update_pgsize_bitmap(iommu);
+
+	/* Delete the old one and insert new iova list */
+	vfio_iommu_iova_insert_copy(iommu, &iova_copy);
+
+	group->attach_cnt = 1;
+	mutex_unlock(&iommu->lock);
+	vfio_iommu_resv_free(&group_resv_regions);
+
+	return 0;
+
+out_free:
+	vfio_iommu_iova_free(&iova_copy);
+	vfio_iommu_resv_free(&group_resv_regions);
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_iommu_add_group);
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -2557,6 +2687,59 @@ static int vfio_iommu_resv_refresh(struct vfio_iommu *iommu,
 	return ret;
 }
 
+/* HACK: called by /dev/iommu core to remove group to vfio_iommu_type1 */
+void vfio_iommu_remove_group(struct vfio_iommu *iommu,
+			     struct iommu_group *iommu_group)
+{
+	struct vfio_iommu_group *group;
+	struct vfio_domain *domain = NULL;
+	LIST_HEAD(iova_copy);
+
+	mutex_lock(&iommu->lock);
+	domain = list_first_entry(&iommu->domain_list,
+				  struct vfio_domain, next);
+	group = find_iommu_group(domain, iommu_group);
+	if (!group) {
+		mutex_unlock(&iommu->lock);
+		return;
+	}
+
+	if (!--group->attach_cnt) {
+		mutex_unlock(&iommu->lock);
+		return;
+	}
+
+	/*
+	 * Get a copy of iova list. This will be used to update
+	 * and to replace the current one later. Please note that
+	 * we will leave the original list as it is if update fails.
+	 */
+	vfio_iommu_iova_get_copy(iommu, &iova_copy);
+
+	list_del(&group->next);
+	kfree(group);
+	/*
+	 * Group ownership provides privilege, if the device list is
+	 * empty, the domain goes away.
+	 */
+	if (list_empty(&domain->group_list)) {
+		WARN_ON(iommu->notifier.head);
+		vfio_iommu_unmap_unpin_all(iommu);
+		list_del(&domain->next);
+		kfree(domain);
+		vfio_iommu_aper_expand(iommu, &iova_copy);
+		vfio_update_pgsize_bitmap(iommu);
+	}
+
+	if (!vfio_iommu_resv_refresh(iommu, &iova_copy))
+		vfio_iommu_iova_insert_copy(iommu, &iova_copy);
+	else
+		vfio_iommu_iova_free(&iova_copy);
+
+	mutex_unlock(&iommu->lock);
+}
+EXPORT_SYMBOL_GPL(vfio_iommu_remove_group);
+
 static void vfio_iommu_type1_detach_group(void *iommu_data,
 					  struct iommu_group *iommu_group)
 {
@@ -2647,7 +2830,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 	mutex_unlock(&iommu->lock);
 }
 
-static void *vfio_iommu_type1_open(unsigned long arg)
+void *vfio_iommu_type1_open(unsigned long arg)
 {
 	struct vfio_iommu *iommu;
 
@@ -2680,6 +2863,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 
 	return iommu;
 }
+EXPORT_SYMBOL_GPL(vfio_iommu_type1_open);
 
 static void vfio_release_domain(struct vfio_domain *domain, bool external)
 {
@@ -2697,7 +2881,7 @@ static void vfio_release_domain(struct vfio_domain *domain, bool external)
 		iommu_domain_free(domain->domain);
 }
 
-static void vfio_iommu_type1_release(void *iommu_data)
+void vfio_iommu_type1_release(void *iommu_data)
 {
 	struct vfio_iommu *iommu = iommu_data;
 	struct vfio_domain *domain, *domain_tmp;
@@ -2720,6 +2904,7 @@ static void vfio_iommu_type1_release(void *iommu_data)
 
 	kfree(iommu);
 }
+EXPORT_SYMBOL_GPL(vfio_iommu_type1_release);
 
 static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
 {
@@ -2913,8 +3098,8 @@ static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
 			-EFAULT : 0;
 }
 
-static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
-				    unsigned long arg)
+int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
+			     unsigned long arg)
 {
 	struct vfio_iommu_type1_dma_map map;
 	unsigned long minsz;
@@ -2931,9 +3116,10 @@ static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
 
 	return vfio_dma_do_map(iommu, &map);
 }
+EXPORT_SYMBOL_GPL(vfio_iommu_type1_map_dma);
 
-static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
-				      unsigned long arg)
+int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
+			       unsigned long arg)
 {
 	struct vfio_iommu_type1_dma_unmap unmap;
 	struct vfio_bitmap bitmap = { 0 };
@@ -2984,6 +3170,7 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
 	return copy_to_user((void __user *)arg, &unmap, minsz) ?
 			-EFAULT : 0;
 }
+EXPORT_SYMBOL_GPL(vfio_iommu_type1_unmap_dma);
 
 static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
 					unsigned long arg)
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index fd0629acb948..d904ee5a68cc 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -158,6 +158,19 @@ extern int vfio_dma_rw(struct vfio_group *group, dma_addr_t user_iova,
 
 extern struct iommu_domain *vfio_group_iommu_domain(struct vfio_group *group);
 
+struct vfio_iommu;
+extern void *vfio_iommu_type1_open(unsigned long arg);
+extern void vfio_iommu_type1_release(void *iommu_data);
+extern int vfio_iommu_add_group(struct vfio_iommu *iommu,
+				struct iommu_group *iommu_group,
+				struct iommu_domain *iommu_domain);
+extern void vfio_iommu_remove_group(struct vfio_iommu *iommu,
+				    struct iommu_group *iommu_group);
+extern int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
+				      unsigned long arg);
+extern int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
+				    unsigned long arg);
+
 /* each type has independent events */
 enum vfio_notify_type {
 	VFIO_IOMMU_NOTIFY = 0,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
