Return-Path: <SRS0=HSJZ=5V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F400C2BA1A
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 08:34:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2E020678
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 08:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2E020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3A67420242;
	Sun,  5 Apr 2020 08:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LJPIF5RjW1fQ; Sun,  5 Apr 2020 08:34:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2E9AA204A8;
	Sun,  5 Apr 2020 08:34:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DFB6C1AE2;
	Sun,  5 Apr 2020 08:34:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B42EC0177
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2846C204A8
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IMGA8QDNLFng for <iommu@lists.linux-foundation.org>;
 Sun,  5 Apr 2020 08:34:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id 868B8204F5
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:30 +0000 (UTC)
IronPort-SDR: MoRzVIiH6wjiIpfLyzFGQyl0mzgDgvk8PKJqqC82+yY6x1rYKqEmn520Il5fj3QaFna5doLJjY
 yrlucM9kAWLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2020 01:34:30 -0700
IronPort-SDR: YQEZ9g4ZTJB4iDEeG95ARB80EYlsZEMvrPDSzOj4iJOVYQ7acNUVgVIlwpCqoOp9sHru3VSOZy
 KqFbjpY9AgbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,347,1580803200"; d="scan'208";a="397179423"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by orsmga004.jf.intel.com with ESMTP; 05 Apr 2020 01:34:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 18/19] iommu/vt-d: Report SVA feature with generic flag
Date: Sun,  5 Apr 2020 16:30:52 +0800
Message-Id: <20200405083053.17865-19-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405083053.17865-1-baolu.lu@linux.intel.com>
References: <20200405083053.17865-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
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
index 3c82fcb50ee7..c79e68ae42a8 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5956,6 +5956,14 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
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
 
@@ -5965,6 +5973,16 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
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
