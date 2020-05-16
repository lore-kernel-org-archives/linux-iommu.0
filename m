Return-Path: <SRS0=RRah=66=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B8AC433DF
	for <iommu@archiver.kernel.org>; Sat, 16 May 2020 06:24:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C09220709
	for <iommu@archiver.kernel.org>; Sat, 16 May 2020 06:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C09220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3BDFF87E37;
	Sat, 16 May 2020 06:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yXKcx_yFNNRV; Sat, 16 May 2020 06:24:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C14888826A;
	Sat, 16 May 2020 06:24:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AED53C088E;
	Sat, 16 May 2020 06:24:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC478C016F
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D519387E6E
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rb6zEY2mCuLh for <iommu@lists.linux-foundation.org>;
 Sat, 16 May 2020 06:24:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C23768827D
 for <iommu@lists.linux-foundation.org>; Sat, 16 May 2020 06:24:51 +0000 (UTC)
IronPort-SDR: OMjX0dCjtJCfsM3nI1o/GOVe4DjsGpiziMlP1l0LNyNUzkgyJ1F7C3Lwyqp+U57lXRQ2pDmgFJ
 WHQ8QBska43Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2020 23:24:51 -0700
IronPort-SDR: JJwfLhZaF4UlVYFfq2YU4QiKYO5DEE8inCbwnZTvWfedewMpY8dlsi70MqlDSQLDaenJ2CBQWH
 S/J3rh0EmP+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; d="scan'208";a="281442441"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by orsmga002.jf.intel.com with ESMTP; 15 May 2020 23:24:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 10/18] iommu/vt-d: Report SVA feature with generic flag
Date: Sat, 16 May 2020 14:20:53 +0800
Message-Id: <20200516062101.29541-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200516062101.29541-1-baolu.lu@linux.intel.com>
References: <20200516062101.29541-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Query Shared Virtual Address/Memory capability is a generic feature.
SVA feature check is the required first step before calling
iommu_sva_bind_device().

VT-d checks SVA feature enabling at per IOMMU level during this step,
SVA bind device will check and enable PCI ATS, PRS, and PASID capabilities
at device level.

This patch reports Intel SVM as SVA feature such that generic code
(e.g. Uacce [1]) can use it.

[1] https://lkml.org/lkml/2020/1/15/604

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a13b723ca38d..ed7de7420b3c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5944,6 +5944,14 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 		return !!siov_find_pci_dvsec(to_pci_dev(dev));
 	}
 
+	if (feat == IOMMU_DEV_FEAT_SVA) {
+		struct device_domain_info *info = get_domain_info(dev);
+
+		return info && (info->iommu->flags & VTD_FLAG_SVM_CAPABLE) &&
+			info->pasid_supported && info->pri_supported &&
+			info->ats_supported;
+	}
+
 	return false;
 }
 
@@ -5953,6 +5961,16 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 	if (feat == IOMMU_DEV_FEAT_AUX)
 		return intel_iommu_enable_auxd(dev);
 
+	if (feat == IOMMU_DEV_FEAT_SVA) {
+		struct device_domain_info *info = get_domain_info(dev);
+
+		if (!info)
+			return -EINVAL;
+
+		if (info->iommu->flags & VTD_FLAG_SVM_CAPABLE)
+			return 0;
+	}
+
 	return -ENODEV;
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
