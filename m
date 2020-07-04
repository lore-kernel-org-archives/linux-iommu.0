Return-Path: <SRS0=9BbX=AP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A11AC433E0
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 11:20:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5634120885
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 11:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5634120885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2704B2265B;
	Sat,  4 Jul 2020 11:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iwKQTa6Lhm9o; Sat,  4 Jul 2020 11:20:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 13113259CB;
	Sat,  4 Jul 2020 11:20:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC5D1C0733;
	Sat,  4 Jul 2020 11:20:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81BB2C0733
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6FE5A89177
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WwUBx7gAesbJ for <iommu@lists.linux-foundation.org>;
 Sat,  4 Jul 2020 11:19:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 58C4E89348
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 11:19:55 +0000 (UTC)
IronPort-SDR: /9zx90HpseTkCRKzyKvWz7mu0rmQzT7dOBUzi126uYDVc2vg+7oewch0zTdzidCSEpL2Iz8TJc
 /k0kSr/zgxxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="134701883"
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="134701883"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2020 04:19:53 -0700
IronPort-SDR: YsjoZH501qmpyn9DGovXZv7BEMxRmtsbnuRvyEzNQlHe7377nr7TCNlu71ivl5kyNKmjmAC5Dz
 xpVPv6Z1Ig6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="282521450"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 04 Jul 2020 04:19:53 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v4 11/15] vfio/type1: Allow invalidating first-level/stage
 IOMMU cache
Date: Sat,  4 Jul 2020 04:26:25 -0700
Message-Id: <1593861989-35920-12-git-send-email-yi.l.liu@intel.com>
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

This patch provides an interface allowing the userspace to invalidate
IOMMU cache for first-level page table. It is required when the first
level IOMMU page table is not managed by the host kernel in the nested
translation setup.

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v1 -> v2:
*) rename from "vfio/type1: Flush stage-1 IOMMU cache for nesting type"
*) rename vfio_cache_inv_fn() to vfio_dev_cache_invalidate_fn()
*) vfio_dev_cache_inv_fn() always successful
*) remove VFIO_IOMMU_CACHE_INVALIDATE, and reuse VFIO_IOMMU_NESTING_OP
---
 drivers/vfio/vfio_iommu_type1.c | 50 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h       |  3 +++
 2 files changed, 53 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 6de0b8e..116b28e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -3077,6 +3077,53 @@ static long vfio_iommu_handle_pgtbl_op(struct vfio_iommu *iommu,
 	return ret;
 }
 
+static int vfio_dev_cache_invalidate_fn(struct device *dev, void *data)
+{
+	struct domain_capsule *dc = (struct domain_capsule *)data;
+	unsigned long arg = *(unsigned long *) dc->data;
+
+	iommu_cache_invalidate(dc->domain, dev, (void __user *) arg);
+	return 0;
+}
+
+static long vfio_iommu_invalidate_cache(struct vfio_iommu *iommu,
+					unsigned long arg)
+{
+	struct domain_capsule dc = { .data = &arg };
+	struct vfio_group *group;
+	struct vfio_domain *domain;
+	int ret = 0;
+	struct iommu_nesting_info *info;
+
+	mutex_lock(&iommu->lock);
+	/*
+	 * Cache invalidation is required for any nesting IOMMU,
+	 * so no need to check system-wide PASID support.
+	 */
+	info = iommu->nesting_info;
+	if (!info || !(info->features & IOMMU_NESTING_FEAT_CACHE_INVLD)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
+	group = vfio_find_nesting_group(iommu);
+	if (!group) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	domain = list_first_entry(&iommu->domain_list,
+				      struct vfio_domain, next);
+	dc.group = group;
+	dc.domain = domain->domain;
+	iommu_group_for_each_dev(group->iommu_group, &dc,
+				 vfio_dev_cache_invalidate_fn);
+
+out_unlock:
+	mutex_unlock(&iommu->lock);
+	return ret;
+}
+
 static long vfio_iommu_type1_nesting_op(struct vfio_iommu *iommu,
 					unsigned long arg)
 {
@@ -3099,6 +3146,9 @@ static long vfio_iommu_type1_nesting_op(struct vfio_iommu *iommu,
 	case VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL:
 		ret = vfio_iommu_handle_pgtbl_op(iommu, false, arg + minsz);
 		break;
+	case VFIO_IOMMU_NESTING_OP_CACHE_INVLD:
+		ret = vfio_iommu_invalidate_cache(iommu, arg + minsz);
+		break;
 	default:
 		ret = -EINVAL;
 	}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 095a52a..d7a565a 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1220,6 +1220,8 @@ struct vfio_iommu_type1_pasid_request {
  * +-----------------+-----------------------------------------------+
  * | UNBIND_PGTBL    |      struct iommu_gpasid_bind_data            |
  * +-----------------+-----------------------------------------------+
+ * | CACHE_INVLD     |      struct iommu_cache_invalidate_info       |
+ * +-----------------+-----------------------------------------------+
  *
  * returns: 0 on success, -errno on failure.
  */
@@ -1232,6 +1234,7 @@ struct vfio_iommu_type1_nesting_op {
 
 #define VFIO_IOMMU_NESTING_OP_BIND_PGTBL	(0)
 #define VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL	(1)
+#define VFIO_IOMMU_NESTING_OP_CACHE_INVLD	(2)
 
 #define VFIO_IOMMU_NESTING_OP		_IO(VFIO_TYPE, VFIO_BASE + 19)
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
