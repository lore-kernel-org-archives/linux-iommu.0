Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A8C433E6
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 08:49:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B14E20B80
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 08:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B14E20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2EEAB867ED;
	Wed, 24 Jun 2020 08:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lc6hwLWSIjp4; Wed, 24 Jun 2020 08:49:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9E52E87DAC;
	Wed, 24 Jun 2020 08:49:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77DA0C0894;
	Wed, 24 Jun 2020 08:49:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A851AC016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 08:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9044120530
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 08:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wCu+NvYQe003 for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 08:48:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id F251522005
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 08:48:56 +0000 (UTC)
IronPort-SDR: rpfMxfwk5BAxP2vlnL08OyRRNVpRFWnfsJspBfhgviC7ziC1LyJdhP9uc7kZyrvURJ4fTuWOJo
 ujoPISnrZtmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="141879056"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="141879056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2020 01:48:56 -0700
IronPort-SDR: ErmQurzQgDq9ukx/suh91j2ddBBL+uI3lDxNeSyEYCBuXHjYlADG2368Ri0BrSgsMxhH1/N0pW
 6Ii595tlRKOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="275624498"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 24 Jun 2020 01:48:55 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v3 03/14] vfio/type1: Report iommu nesting info to userspace
Date: Wed, 24 Jun 2020 01:55:16 -0700
Message-Id: <1592988927-48009-4-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com
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
 drivers/vfio/vfio_iommu_type1.c | 73 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  9 +++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 7accb59..8c143d5 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -72,6 +72,7 @@ struct vfio_iommu {
 	uint64_t		pgsize_bitmap;
 	bool			v2;
 	bool			nesting;
+	struct iommu_nesting_info *nesting_info;
 	bool			dirty_page_tracking;
 	bool			pinned_page_dirty_scope;
 };
@@ -130,6 +131,9 @@ struct vfio_regions {
 #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
 					(!list_empty(&iommu->domain_list))
 
+#define IS_DOMAIN_IN_CONTAINER(iommu)	((iommu->external_domain) || \
+					 (!list_empty(&iommu->domain_list)))
+
 #define DIRTY_BITMAP_BYTES(n)	(ALIGN(n, BITS_PER_TYPE(u64)) / BITS_PER_BYTE)
 
 /*
@@ -1959,6 +1963,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
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
@@ -2029,6 +2039,36 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
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
 
@@ -2138,6 +2178,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
 	return 0;
 
 out_detach:
+	kfree(iommu->nesting_info);
 	vfio_iommu_detach_group(domain, group);
 out_domain:
 	iommu_domain_free(domain->domain);
@@ -2338,6 +2379,8 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
 					vfio_iommu_unmap_unpin_all(iommu);
 				else
 					vfio_iommu_unmap_unpin_reaccount(iommu);
+
+				kfree(iommu->nesting_info);
 			}
 			iommu_domain_free(domain->domain);
 			list_del(&domain->next);
@@ -2546,6 +2589,30 @@ static int vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
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
@@ -2586,6 +2653,12 @@ static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
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
index eca66926..f1f39e1 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/iommu.h>
 
 #define VFIO_API_VERSION	0
 
@@ -1039,6 +1040,14 @@ struct vfio_iommu_type1_info_cap_migration {
 	__u64	max_dirty_bitmap_size;		/* in bytes */
 };
 
+#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  3
+
+struct vfio_iommu_type1_info_cap_nesting {
+	struct	vfio_info_cap_header header;
+	__u32	flags;
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
