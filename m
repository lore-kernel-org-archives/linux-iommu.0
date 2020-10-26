Return-Path: <SRS0=cbBT=EB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15FFC4363A
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 12:00:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5749422263
	for <iommu@archiver.kernel.org>; Mon, 26 Oct 2020 12:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5749422263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02281867E3;
	Mon, 26 Oct 2020 12:00:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgxnesXoGIvb; Mon, 26 Oct 2020 12:00:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 34071867D5;
	Mon, 26 Oct 2020 12:00:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21641C088B;
	Mon, 26 Oct 2020 12:00:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EFA8C0051
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 12:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6B86B2E0E0
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 12:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tSZNVY+Qnh1a for <iommu@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 12:00:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 552632DE3B
 for <iommu@lists.linux-foundation.org>; Mon, 26 Oct 2020 12:00:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3F981476;
 Mon, 26 Oct 2020 05:00:26 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F08393F719;
 Mon, 26 Oct 2020 05:00:25 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Subject: [PATCH] iommu/arm-smmu: Use new devm_krealloc()
Date: Mon, 26 Oct 2020 12:00:22 +0000
Message-Id: <355e8d70c7f47d462d85b386aa09f2b5c655f023.1603713428.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

The implementation-specific subclassing of struct arm_smmu_device really
wanted an appropriate version of realloc(). Now that one exists, take
full advantage of it to clarify what's actually being done here.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c   |  5 +----
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 17 +----------------
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c   |  5 +----
 3 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 88f17cc33023..336f36ed9ed7 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -91,15 +91,12 @@ static struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smm
 {
 	struct cavium_smmu *cs;
 
-	cs = devm_kzalloc(smmu->dev, sizeof(*cs), GFP_KERNEL);
+	cs = devm_krealloc(smmu->dev, smmu, sizeof(*cs), GFP_KERNEL);
 	if (!cs)
 		return ERR_PTR(-ENOMEM);
 
-	cs->smmu = *smmu;
 	cs->smmu.impl = &cavium_impl;
 
-	devm_kfree(smmu->dev, smmu);
-
 	return &cs->smmu;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 31368057e9be..29117444e5a0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -242,18 +242,10 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
 	struct nvidia_smmu *nvidia_smmu;
 	struct platform_device *pdev = to_platform_device(dev);
 
-	nvidia_smmu = devm_kzalloc(dev, sizeof(*nvidia_smmu), GFP_KERNEL);
+	nvidia_smmu = devm_krealloc(dev, smmu, sizeof(*nvidia_smmu), GFP_KERNEL);
 	if (!nvidia_smmu)
 		return ERR_PTR(-ENOMEM);
 
-	/*
-	 * Copy the data from struct arm_smmu_device *smmu allocated in
-	 * arm-smmu.c. The smmu from struct nvidia_smmu replaces the smmu
-	 * pointer used in arm-smmu.c once this function returns.
-	 * This is necessary to derive nvidia_smmu from smmu pointer passed
-	 * through arm_smmu_impl function calls subsequently.
-	 */
-	nvidia_smmu->smmu = *smmu;
 	/* Instance 0 is ioremapped by arm-smmu.c. */
 	nvidia_smmu->bases[0] = smmu->base;
 
@@ -267,12 +259,5 @@ struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
 
 	nvidia_smmu->smmu.impl = &nvidia_smmu_impl;
 
-	/*
-	 * Free the struct arm_smmu_device *smmu allocated in arm-smmu.c.
-	 * Once this function returns, arm-smmu.c would use arm_smmu_device
-	 * allocated as part of struct nvidia_smmu.
-	 */
-	devm_kfree(dev, smmu);
-
 	return &nvidia_smmu->smmu;
 }
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index be4318044f96..600670588521 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -69,14 +69,11 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
 {
 	struct qcom_smmu *qsmmu;
 
-	qsmmu = devm_kzalloc(smmu->dev, sizeof(*qsmmu), GFP_KERNEL);
+	qsmmu = devm_krealloc(smmu->dev, smmu, sizeof(*qsmmu), GFP_KERNEL);
 	if (!qsmmu)
 		return ERR_PTR(-ENOMEM);
 
-	qsmmu->smmu = *smmu;
-
 	qsmmu->smmu.impl = &qcom_smmu_impl;
-	devm_kfree(smmu->dev, smmu);
 
 	return &qsmmu->smmu;
 }
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
