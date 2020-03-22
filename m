Return-Path: <SRS0=3R3A=5H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E865AC54EEB
	for <iommu@archiver.kernel.org>; Sun, 22 Mar 2020 12:26:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41A62076F
	for <iommu@archiver.kernel.org>; Sun, 22 Mar 2020 12:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41A62076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7FA5C86440;
	Sun, 22 Mar 2020 12:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nJvZnZBZMBj9; Sun, 22 Mar 2020 12:26:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C80658648E;
	Sun, 22 Mar 2020 12:26:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA20DC1D8A;
	Sun, 22 Mar 2020 12:26:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7779FC0177
 for <iommu@lists.linux-foundation.org>; Sun, 22 Mar 2020 12:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 60EB6865C4
 for <iommu@lists.linux-foundation.org>; Sun, 22 Mar 2020 12:26:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F8Elc4MIS9dv for <iommu@lists.linux-foundation.org>;
 Sun, 22 Mar 2020 12:26:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3FD1086506
 for <iommu@lists.linux-foundation.org>; Sun, 22 Mar 2020 12:26:24 +0000 (UTC)
IronPort-SDR: k7hWZz1t9jOyjxWZwVbNLYg8E8HzOiSPIn2Y2Tf5yltOBzRm95iS8vTP2Liziz74ipyuusAgKw
 KXgJJKyzQWQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 05:26:23 -0700
IronPort-SDR: ODU0KUNuNzn/OqGhgj2jPcOOpyU0+gOjRODvSadyb95UTsobMtrBs5/P+2WtfjMzTUOx/yvOxI
 jHywM3xIEA2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,292,1580803200"; d="scan'208";a="239663867"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 22 Mar 2020 05:26:23 -0700
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: alex.williamson@redhat.com,
	eric.auger@redhat.com
Subject: [PATCH v1 2/8] vfio/type1: Add vfio_iommu_type1 parameter for quota
 tuning
Date: Sun, 22 Mar 2020 05:31:59 -0700
Message-Id: <1584880325-10561-3-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
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

From: Liu Yi L <yi.l.liu@intel.com>

This patch adds a module option to make the PASID quota tunable by
administrator.

TODO: needs to think more on how to  make the tuning to be per-process.

Previous discussions:
https://patchwork.kernel.org/patch/11209429/

Cc: Kevin Tian <kevin.tian@intel.com>
CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/vfio.c             | 8 +++++++-
 drivers/vfio/vfio_iommu_type1.c | 7 ++++++-
 include/linux/vfio.h            | 3 ++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index d13b483..020a792 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -2217,13 +2217,19 @@ struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task)
 }
 EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
 
-int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max)
+int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int quota, int min, int max)
 {
 	ioasid_t pasid;
 	int ret = -ENOSPC;
 
 	mutex_lock(&vmm->pasid_lock);
 
+	/* update quota as it is tunable by admin */
+	if (vmm->pasid_quota != quota) {
+		vmm->pasid_quota = quota;
+		ioasid_adjust_set(vmm->ioasid_sid, quota);
+	}
+
 	pasid = ioasid_alloc(vmm->ioasid_sid, min, max, NULL);
 	if (pasid == INVALID_IOASID) {
 		ret = -ENOSPC;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 331ceee..e40afc0 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -60,6 +60,11 @@ module_param_named(dma_entry_limit, dma_entry_limit, uint, 0644);
 MODULE_PARM_DESC(dma_entry_limit,
 		 "Maximum number of user DMA mappings per container (65535).");
 
+static int pasid_quota = VFIO_DEFAULT_PASID_QUOTA;
+module_param_named(pasid_quota, pasid_quota, uint, 0644);
+MODULE_PARM_DESC(pasid_quota,
+		 "Quota of user owned PASIDs per vfio-based application (1000).");
+
 struct vfio_iommu {
 	struct list_head	domain_list;
 	struct list_head	iova_list;
@@ -2200,7 +2205,7 @@ static int vfio_iommu_type1_pasid_alloc(struct vfio_iommu *iommu,
 		goto out_unlock;
 	}
 	if (vmm)
-		ret = vfio_mm_pasid_alloc(vmm, min, max);
+		ret = vfio_mm_pasid_alloc(vmm, pasid_quota, min, max);
 	else
 		ret = -EINVAL;
 out_unlock:
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 75f9f7f1..af2ef78 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -106,7 +106,8 @@ struct vfio_mm {
 
 extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
 extern void vfio_mm_put(struct vfio_mm *vmm);
-extern int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max);
+extern int vfio_mm_pasid_alloc(struct vfio_mm *vmm,
+				int quota, int min, int max);
 extern int vfio_mm_pasid_free(struct vfio_mm *vmm, ioasid_t pasid);
 
 /*
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
