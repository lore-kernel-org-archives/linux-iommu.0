Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6876CC433FE
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 06:21:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4622820759
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 06:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4622820759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 151048690E;
	Tue, 28 Jul 2020 06:21:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d_jwYxMjoSyT; Tue, 28 Jul 2020 06:21:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 50EE4869D0;
	Tue, 28 Jul 2020 06:21:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32706C004F;
	Tue, 28 Jul 2020 06:21:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8031EC004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 06:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6458A22812
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 06:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V3DNN-5Cgl7b for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 06:20:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by silver.osuosl.org (Postfix) with ESMTPS id F35332039A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 06:20:56 +0000 (UTC)
IronPort-SDR: IqZejte8gnSXtgGExLNEjtQQTyn5U6dtnUlKd9OGaQz7S24ZdcDM7eDhgY0/Iw2y7aooNGtkUy
 vuEHMg7pZckg==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="130719786"
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; d="scan'208";a="130719786"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2020 23:20:56 -0700
IronPort-SDR: FdetQ7pJX1vBwEWxMioDORW1sMLGf3G1G+2QwRHnLuTHtAKD7fop8b58T+v2E27JYezdazCnpL
 Pjz2f6s+6Bbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; d="scan'208";a="320274388"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga008.jf.intel.com with ESMTP; 27 Jul 2020 23:20:55 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, eric.auger@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
Subject: [PATCH v6 03/15] iommu/smmu: Report empty domain nesting info
Date: Mon, 27 Jul 2020 23:27:32 -0700
Message-Id: <1595917664-33276-4-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, hao.wu@intel.com
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

This patch is added as instead of returning a boolean for DOMAIN_ATTR_NESTING,
iommu_domain_get_attr() should return an iommu_nesting_info handle. For
now, return an empty nesting info struct for now as true nesting is not
yet supported by the SMMUs.

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v5 -> v6:
*) add review-by from Eric Auger.

v4 -> v5:
*) address comments from Eric Auger.
---
 drivers/iommu/arm-smmu-v3.c | 29 +++++++++++++++++++++++++++--
 drivers/iommu/arm-smmu.c    | 29 +++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677..c702ef9 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3019,6 +3019,32 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	return group;
 }
 
+static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
+					void *data)
+{
+	struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
+	unsigned int size;
+
+	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		return -ENODEV;
+
+	size = sizeof(struct iommu_nesting_info);
+
+	/*
+	 * if provided buffer size is smaller than expected, should
+	 * return 0 and also the expected buffer size to caller.
+	 */
+	if (info->argsz < size) {
+		info->argsz = size;
+		return 0;
+	}
+
+	/* report an empty iommu_nesting_info for now */
+	memset(info, 0x0, size);
+	info->argsz = size;
+	return 0;
+}
+
 static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr, void *data)
 {
@@ -3028,8 +3054,7 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case IOMMU_DOMAIN_UNMANAGED:
 		switch (attr) {
 		case DOMAIN_ATTR_NESTING:
-			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
-			return 0;
+			return arm_smmu_domain_nesting_info(smmu_domain, data);
 		default:
 			return -ENODEV;
 		}
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 243bc4c..2bd58f4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1506,6 +1506,32 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	return group;
 }
 
+static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
+					void *data)
+{
+	struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
+	unsigned int size;
+
+	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
+		return -ENODEV;
+
+	size = sizeof(struct iommu_nesting_info);
+
+	/*
+	 * if provided buffer size is smaller than expected, should
+	 * return 0 and also the expected buffer size to caller.
+	 */
+	if (info->argsz < size) {
+		info->argsz = size;
+		return 0;
+	}
+
+	/* report an empty iommu_nesting_info for now */
+	memset(info, 0x0, size);
+	info->argsz = size;
+	return 0;
+}
+
 static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 				    enum iommu_attr attr, void *data)
 {
@@ -1515,8 +1541,7 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case IOMMU_DOMAIN_UNMANAGED:
 		switch (attr) {
 		case DOMAIN_ATTR_NESTING:
-			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
-			return 0;
+			return arm_smmu_domain_nesting_info(smmu_domain, data);
 		default:
 			return -ENODEV;
 		}
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
