Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840DBC433DB
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 12:37:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156A064F3D
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 12:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156A064F3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDDBC6F684;
	Tue,  2 Mar 2021 12:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0doUFVZf_BT7; Tue,  2 Mar 2021 12:37:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4636D6F64A;
	Tue,  2 Mar 2021 12:37:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2650DC000A;
	Tue,  2 Mar 2021 12:37:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96A11C0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:37:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 785EA83E43
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EgfGhO_PsXpY for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 12:37:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3685B83EC4
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 12:37:03 +0000 (UTC)
IronPort-SDR: 4FBfMm1qlMSYvLs8Uub5hRMdC33VRb/cMdrG9KKKZKDSKEHAlHKMZfKSog3FGbxSCv4SVHvVcB
 JHB0N0XTS20Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="166675048"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="166675048"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 04:37:02 -0800
IronPort-SDR: 6PvTlkpEnKUt+CMuP/1yphVGSCBkuzDohh64GrZ39e/TfSS4aT9/w9NdYmN3HsWzwqqIZUBHJp
 dhRVOpXCPJjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="427472034"
Received: from yiliu-dev.bj.intel.com (HELO dual-ub.bj.intel.com)
 ([10.238.156.135])
 by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2021 04:36:57 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [Patch v8 03/10] vfio/type1: Report iommu nesting info to userspace
Date: Wed,  3 Mar 2021 04:35:38 +0800
Message-Id: <20210302203545.436623-4-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302203545.436623-1-yi.l.liu@intel.com>
References: <20210302203545.436623-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, vivek.gautam@arm.com, yi.y.sun@intel.com,
 jgg@nvidia.com, Lingshan.Zhu@intel.com, jasowang@redhat.com, hao.wu@intel.com
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

This patch exports iommu nesting capability info to user space through
VFIO. Userspace is expected to check this info for supported uAPIs (e.g.
bind page table, cache invalidation) and the vendor specific format
information for first level/stage page table that will be bound to.

The nesting info is available only after container set to be NESTED type.
Current implementation imposes one limitation - one nesting container
should include at most one iommu group. The philosophy of vfio container
is having all groups/devices within the container share the same IOMMU
context. When vSVA is enabled, one IOMMU context could include one 2nd-
level address space and multiple 1st-level address spaces. While the
2nd-level address space is reasonably sharable by multiple groups, blindly
sharing 1st-level address spaces across all groups within the container
might instead break the guest expectation. In the future sub/super container
concept might be introduced to allow partial address space sharing within
an IOMMU context. But for now let's go with this restriction by requiring
singleton container for using nesting iommu features. Below link has the
related discussion about this decision.

https://lore.kernel.org/kvm/20200515115924.37e6996d@w520.home/

This patch also changes the NESTING type container behaviour. Something
that would have succeeded before will now fail: Before this series, if
user asked for a VFIO_IOMMU_TYPE1_NESTING, it would have succeeded even
if the SMMU didn't support stage-2, as the driver would have silently
fallen back on stage-1 mappings (which work exactly the same as stage-2
only since there was no nesting supported). After the series, we do check
for DOMAIN_ATTR_NESTING so if user asks for VFIO_IOMMU_TYPE1_NESTING and
the SMMU doesn't support stage-2, the ioctl fails. But it should be a good
fix and completely harmless. Detail can be found in below link as well.

https://lore.kernel.org/kvm/20200717090900.GC4850@myrica/

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
v7 -> v8:
*) tweak per Alex's comments against v7.
*) check "iommu->nesting_info->format == 0" in attach_group()

v6 -> v7:
*) using vfio_info_add_capability() for adding nesting cap per suggestion
   from Eric.

v5 -> v6:
*) address comments against v5 from Eric Auger.
*) don't report nesting cap to userspace if the nesting_info->format is
   invalid.

v4 -> v5:
*) address comments from Eric Auger.
*) return struct iommu_nesting_info for VFIO_IOMMU_TYPE1_INFO_CAP_NESTING as
   cap is much "cheap", if needs extension in future, just define another cap.
   https://lore.kernel.org/kvm/20200708132947.5b7ee954@x1.home/

v3 -> v4:
*) address comments against v3.

v1 -> v2:
*) added in v2
---
 drivers/vfio/vfio_iommu_type1.c | 102 +++++++++++++++++++++++++++-----
 include/uapi/linux/vfio.h       |  19 ++++++
 2 files changed, 105 insertions(+), 16 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 4bb162c1d649..3a5c84d4f19b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -63,22 +63,24 @@ MODULE_PARM_DESC(dma_entry_limit,
 		 "Maximum number of user DMA mappings per container (65535).");
 
 struct vfio_iommu {
-	struct list_head	domain_list;
-	struct list_head	iova_list;
-	struct vfio_domain	*external_domain; /* domain for external user */
-	struct mutex		lock;
-	struct rb_root		dma_list;
-	struct blocking_notifier_head notifier;
-	unsigned int		dma_avail;
-	unsigned int		vaddr_invalid_count;
-	uint64_t		pgsize_bitmap;
-	uint64_t		num_non_pinned_groups;
-	wait_queue_head_t	vaddr_wait;
-	bool			v2;
-	bool			nesting;
-	bool			dirty_page_tracking;
-	bool			pinned_page_dirty_scope;
-	bool			container_open;
+	struct list_head		domain_list;
+	struct list_head		iova_list;
+	/* domain for external user */
+	struct vfio_domain		*external_domain;
+	struct mutex			lock;
+	struct rb_root			dma_list;
+	struct blocking_notifier_head	notifier;
+	unsigned int			dma_avail;
+	unsigned int			vaddr_invalid_count;
+	uint64_t			pgsize_bitmap;
+	uint64_t			num_non_pinned_groups;
+	wait_queue_head_t		vaddr_wait;
+	struct iommu_nesting_info	*nesting_info;
+	bool				v2;
+	bool				nesting;
+	bool				dirty_page_tracking;
+	bool				pinned_page_dirty_scope;
+	bool				container_open;
 };
 
 struct vfio_domain {
@@ -144,6 +146,9 @@ struct vfio_regions {
 #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
 					(!list_empty(&iommu->domain_list))
 
+#define CONTAINER_HAS_DOMAIN(iommu)	(((iommu)->external_domain) || \
+					 (!list_empty(&(iommu)->domain_list)))
+
 #define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) / BITS_PER_BYTE)
 
 /*
@@ -2242,6 +2247,12 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
 	list_splice_tail(iova_copy, iova);
 }
 
+static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
+{
+	kfree(iommu->nesting_info);
+	iommu->nesting_info = NULL;
+}
+
 static int vfio_iommu_type1_attach_group(void *iommu_data,
 					 struct iommu_group *iommu_group)
 {
@@ -2264,6 +2275,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 		return -EINVAL;
 	}
 
+	/* Nesting type container can include only one group */
+	if (iommu->nesting && CONTAINER_HAS_DOMAIN(iommu)) {
+		mutex_unlock(&iommu->lock);
+		return -EINVAL;
+	}
+
 	group = kzalloc(sizeof(*group), GFP_KERNEL);
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!group || !domain) {
@@ -2332,6 +2349,31 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	if (ret)
 		goto out_domain;
 
+	/* Nesting cap info is available only after attaching */
+	if (iommu->nesting) {
+		int size = sizeof(struct iommu_nesting_info);
+
+		iommu->nesting_info = kzalloc(size, GFP_KERNEL);
+		if (!iommu->nesting_info) {
+			ret = -ENOMEM;
+			goto out_detach;
+		}
+
+		/* Now get the nesting info */
+		iommu->nesting_info->argsz = size;
+		ret = iommu_domain_get_attr(domain->domain,
+					    DOMAIN_ATTR_NESTING,
+					    iommu->nesting_info);
+		if (ret)
+			goto out_detach;
+
+		/* when @format of nesting_info is 0, fail the attach */
+		if (iommu->nesting_info->format == 0) {
+			ret = -ENOENT;
+			goto out_detach;
+		}
+	}
+
 	/* Get aperture info */
 	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY, &geo);
 
@@ -2441,6 +2483,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	return 0;
 
 out_detach:
+	vfio_iommu_release_nesting_info(iommu);
 	vfio_iommu_detach_group(domain, group);
 out_domain:
 	iommu_domain_free(domain->domain);
@@ -2626,6 +2669,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 				} else {
 					vfio_iommu_unmap_unpin_reaccount(iommu);
 				}
+
+				vfio_iommu_release_nesting_info(iommu);
 			}
 			iommu_domain_free(domain->domain);
 			list_del(&domain->next);
@@ -2854,6 +2899,28 @@ static int vfio_iommu_dma_avail_build_caps(struct vfio_iommu *iommu,
 					sizeof(cap_dma_avail));
 }
 
+static int vfio_iommu_nesting_build_caps(struct vfio_iommu *iommu,
+					 struct vfio_info_cap *caps)
+{
+	struct vfio_iommu_type1_info_cap_nesting nesting_cap;
+	size_t size;
+
+	/* when nesting_info is null, no need to go further */
+	if (!iommu->nesting_info)
+		return 0;
+
+	size = offsetof(struct vfio_iommu_type1_info_cap_nesting, info) +
+	       iommu->nesting_info->argsz;
+
+	nesting_cap.header.id = VFIO_IOMMU_TYPE1_INFO_CAP_NESTING;
+	nesting_cap.header.version = 1;
+
+	memcpy(&nesting_cap.info, iommu->nesting_info,
+	       iommu->nesting_info->argsz);
+
+	return vfio_info_add_capability(caps, &nesting_cap.header, size);
+}
+
 static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
 				     unsigned long arg)
 {
@@ -2892,6 +2959,9 @@ static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
 	if (!ret)
 		ret = vfio_iommu_iova_build_caps(iommu, &caps);
 
+	if (!ret)
+		ret = vfio_iommu_nesting_build_caps(iommu, &caps);
+
 	mutex_unlock(&iommu->lock);
 
 	if (ret)
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 8ce36c1d53ca..5dab20aaf7e7 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/iommu.h>
 
 #define VFIO_API_VERSION	0
 
@@ -1073,6 +1074,24 @@ struct vfio_iommu_type1_info_dma_avail {
 	__u32	avail;
 };
 
+/*
+ * The nesting capability allows to report the related capability
+ * and info for nesting iommu type.
+ *
+ * The structures below define version 1 of this capability.
+ *
+ * Nested capabilities should be checked by the userspace after
+ * setting VFIO_TYPE1_NESTING_IOMMU.
+ *
+ * @info: the nesting info provided by IOMMU driver.
+ */
+#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  4
+
+struct vfio_iommu_type1_info_cap_nesting {
+	struct	vfio_info_cap_header header;
+	struct	iommu_nesting_info info;
+};
+
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
 
 /**
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
