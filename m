Return-Path: <SRS0=9BbX=AP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BA3C433DF
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 11:20:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A4120870
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 11:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A4120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5FF94220EC;
	Sat,  4 Jul 2020 11:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ONMpVuxg6Sc; Sat,  4 Jul 2020 11:19:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5CC862226E;
	Sat,  4 Jul 2020 11:19:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B2F1C08A5;
	Sat,  4 Jul 2020 11:19:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96B00C0733
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8509A89224
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FAIUbZtFFsqi for <iommu@lists.linux-foundation.org>;
 Sat,  4 Jul 2020 11:19:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7FC2A89177
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:54 +0000 (UTC)
IronPort-SDR: EX0t9Ie7LcWAb+uzBdMRlVItA4MrFIQ/WeqvzMQbTLOyOiZSFi3NrocuosSuqV1TZvw/FySFTf
 JCkoex4nwfXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="134701876"
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="134701876"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2020 04:19:52 -0700
IronPort-SDR: rrauR9Mx6KGiNvmAhCO4W1Sohabr5nGaDstSCt4d9E4oD/DBcWH2jjo6raGT1Gft7GI2yyioQR
 dvLBncfZexAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="282521420"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 04 Jul 2020 04:19:52 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v4 04/15] vfio/type1: Report iommu nesting info to userspace
Date: Sat,  4 Jul 2020 04:26:18 -0700
Message-Id: <1593861989-35920-5-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
References: <1593861989-35920-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patch exports iommu nesting capability info to user space through
VFIO. User space is expected to check this info for supported uAPIs (e.g.
PASID alloc/free, bind page table, and cache invalidation) and the vendor
specific format information for first level/stage page table that will be
bound to.

The nesting info is available only after the nesting iommu type is set
for a container. Current implementation imposes one limitation - one
nesting container should include at most one group. The philosophy of
vfio container is having all groups/devices within the container share
the same IOMMU context. When vSVA is enabled, one IOMMU context could
include one 2nd-level address space and multiple 1st-level address spaces.
While the 2nd-leve address space is reasonably sharable by multiple groups
, blindly sharing 1st-level address spaces across all groups within the
container might instead break the guest expectation. In the future sub/
super container concept might be introduced to allow partial address space
sharing within an IOMMU context. But for now let's go with this restriction
by requiring singleton container for using nesting iommu features. Below
link has the related discussion about this decision.

https://lkml.org/lkml/2020/5/15/1028

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
v3 -> v4:
*) address comments against v3.

v1 -> v2:
*) added in v2
---

 drivers/vfio/vfio_iommu_type1.c | 105 +++++++++++++++++++++++++++++++++++-----
 include/uapi/linux/vfio.h       |  16 ++++++
 2 files changed, 109 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 7accb59..80623b8 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -62,18 +62,20 @@ MODULE_PARM_DESC(dma_entry_limit,
 		 "Maximum number of user DMA mappings per container (65535).");
 
 struct vfio_iommu {
-	struct list_head	domain_list;
-	struct list_head	iova_list;
-	struct vfio_domain	*external_domain; /* domain for external user */
-	struct mutex		lock;
-	struct rb_root		dma_list;
-	struct blocking_notifier_head notifier;
-	unsigned int		dma_avail;
-	uint64_t		pgsize_bitmap;
-	bool			v2;
-	bool			nesting;
-	bool			dirty_page_tracking;
-	bool			pinned_page_dirty_scope;
+	struct list_head		domain_list;
+	struct list_head		iova_list;
+	struct vfio_domain		*external_domain; /* domain for
+							     external user */
+	struct mutex			lock;
+	struct rb_root			dma_list;
+	struct blocking_notifier_head	notifier;
+	unsigned int			dma_avail;
+	uint64_t			pgsize_bitmap;
+	bool				v2;
+	bool				nesting;
+	bool				dirty_page_tracking;
+	bool				pinned_page_dirty_scope;
+	struct iommu_nesting_info	*nesting_info;
 };
 
 struct vfio_domain {
@@ -130,6 +132,9 @@ struct vfio_regions {
 #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
 					(!list_empty(&iommu->domain_list))
 
+#define IS_DOMAIN_IN_CONTAINER(iommu)	((iommu->external_domain) || \
+					 (!list_empty(&iommu->domain_list)))
+
 #define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) / BITS_PER_BYTE)
 
 /*
@@ -1929,6 +1934,13 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
 
 	list_splice_tail(iova_copy, iova);
 }
+
+static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
+{
+	kfree(iommu->nesting_info);
+	iommu->nesting_info = NULL;
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -1959,6 +1971,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		}
 	}
 
+	/* Nesting type container can include only one group */
+	if (iommu->nesting && IS_DOMAIN_IN_CONTAINER(iommu)) {
+		mutex_unlock(&iommu->lock);
+		return -EINVAL;
+	}
+
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!group || !domain) {
@@ -2029,6 +2047,36 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_domain;
 
+	/* Nesting cap info is available only after attaching */
+	if (iommu->nesting) {
+		struct iommu_nesting_info tmp;
+		struct iommu_nesting_info *info;
+
+		/* First get the size of vendor specific nesting info */
+		ret = iommu_domain_get_attr(domain->domain,
+					    DOMAIN_ATTR_NESTING,
+					    &tmp);
+		if (ret)
+			goto out_detach;
+
+		info = kzalloc(tmp.size, GFP_KERNEL);
+		if (!info) {
+			ret = -ENOMEM;
+			goto out_detach;
+		}
+
+		/* Now get the nesting info */
+		info->size = tmp.size;
+		ret = iommu_domain_get_attr(domain->domain,
+					    DOMAIN_ATTR_NESTING,
+					    info);
+		if (ret) {
+			kfree(info);
+			goto out_detach;
+		}
+		iommu->nesting_info = info;
+	}
+
 	/* Get aperture info */
 	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY, &geo);
 
@@ -2138,6 +2186,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	return 0;
 
 out_detach:
+	vfio_iommu_release_nesting_info(iommu);
 	vfio_iommu_detach_group(domain, group);
 out_domain:
 	iommu_domain_free(domain->domain);
@@ -2338,6 +2387,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 					vfio_iommu_unmap_unpin_all(iommu);
 				else
 					vfio_iommu_unmap_unpin_reaccount(iommu);
+
+				vfio_iommu_release_nesting_info(iommu);
 			}
 			iommu_domain_free(domain->domain);
 			list_del(&domain->next);
@@ -2546,6 +2597,30 @@ static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
 	return vfio_info_add_capability(caps, &cap_mig.header, sizeof(cap_mig));
 }
 
+static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
+					   struct vfio_info_cap *caps)
+{
+	struct vfio_info_cap_header *header;
+	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
+	size_t size;
+
+	size = sizeof(*nesting_cap) + iommu->nesting_info->size;
+
+	header = vfio_info_cap_add(caps, size,
+				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
+	if (IS_ERR(header))
+		return PTR_ERR(header);
+
+	nesting_cap = container_of(header,
+				   struct vfio_iommu_type1_info_cap_nesting,
+				   header);
+
+	memcpy(&nesting_cap->info, iommu->nesting_info,
+	       iommu->nesting_info->size);
+
+	return 0;
+}
+
 static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
 				     unsigned long arg)
 {
@@ -2586,6 +2661,12 @@ static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
 	if (ret)
 		return ret;
 
+	if (iommu->nesting_info) {
+		ret = vfio_iommu_info_add_nesting_cap(iommu, &caps);
+		if (ret)
+			return ret;
+	}
+
 	if (caps.size) {
 		info.flags |= VFIO_IOMMU_INFO_CAPS;
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 9204705..3e3de9c 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1039,6 +1039,22 @@ struct vfio_iommu_type1_info_cap_migration {
 	__u64	max_dirty_bitmap_size;		/* in bytes */
 };
 
+#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
+
+/*
+ * Reporting nesting info to user space.
+ *
+ * @info:	the nesting info provided by IOMMU driver. Today
+ *		it is expected to be a struct iommu_nesting_info
+ *		data.
+ */
+struct vfio_iommu_type1_info_cap_nesting {
+	struct	vfio_info_cap_header header;
+	__u32	flags;
+	__u32	padding;
+	__u8	info[];
+};
+
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
 
 /**
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
