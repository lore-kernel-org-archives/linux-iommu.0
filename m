Return-Path: <SRS0=qRzs=4A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4EEC35242
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 00:47:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24A120724
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 00:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24A120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AA86986378;
	Wed, 12 Feb 2020 00:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dlkLhwYw741Y; Wed, 12 Feb 2020 00:47:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0CD1386372;
	Wed, 12 Feb 2020 00:47:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC6B5C1D80;
	Wed, 12 Feb 2020 00:47:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B712C07FE
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 00:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9868784D0A
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 00:47:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1lmKwT2ajazW for <iommu@lists.linux-foundation.org>;
 Wed, 12 Feb 2020 00:47:14 +0000 (UTC)
X-Greylist: delayed 00:09:31 by SQLgrey-1.7.6
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AFC9384BAF
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 00:47:14 +0000 (UTC)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9E5881C6A9B;
 Wed, 12 Feb 2020 01:37:41 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com
 [134.27.49.11])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 628A41A00C8;
 Wed, 12 Feb 2020 01:37:41 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
 by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id
 8E69B40CB6; Tue, 11 Feb 2020 17:37:40 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/arm-smmu: fix the module name to be consistent with
 older kernel
Date: Tue, 11 Feb 2020 18:37:20 -0600
Message-Id: <1581467841-25397-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>
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

Commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module")
introduced a side effect that changed the module name from arm-smmu to
arm-smmu-mod.  This breaks the users of kernel parameters for the driver
(e.g. arm-smmu.disable_bypass).  This patch changes the module name back
to be consistent.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/iommu/Makefile                          | 4 ++--
 drivers/iommu/{arm-smmu.c => arm-smmu-common.c} | 0
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/iommu/{arm-smmu.c => arm-smmu-common.c} (100%)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 2104fb8afc06..f39e82e68640 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -14,8 +14,8 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
-obj-$(CONFIG_ARM_SMMU) += arm-smmu-mod.o
-arm-smmu-mod-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
+obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
+arm-smmu-objs := arm-smmu-common.o arm-smmu-impl.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu-common.c
similarity index 100%
rename from drivers/iommu/arm-smmu.c
rename to drivers/iommu/arm-smmu-common.c
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
