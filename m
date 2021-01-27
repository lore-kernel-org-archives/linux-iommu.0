Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7D4C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 11:33:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2B62075B
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 11:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2B62075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C0FB48664B;
	Wed, 27 Jan 2021 11:33:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P0hgp9873+pZ; Wed, 27 Jan 2021 11:33:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 327008650E;
	Wed, 27 Jan 2021 11:33:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D3C9C08A1;
	Wed, 27 Jan 2021 11:33:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C369C08A1
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 577FC870A7
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id taZvQ-TXew-H for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 11:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DD82F87097
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:33:28 +0000 (UTC)
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DQhK73GBCz7bpB;
 Wed, 27 Jan 2021 19:32:11 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 19:33:15 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Mark
 Rutland" <mark.rutland@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu
 <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] iommu/arm-smmu-v3: Reserving the entire SMMU register
 space
Date: Wed, 27 Jan 2021 19:32:58 +0800
Message-ID: <20210127113258.1421-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210127113258.1421-1-thunder.leizhen@huawei.com>
References: <20210127113258.1421-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

commit 52f3fab0067d ("iommu/arm-smmu-v3: Don't reserve implementation
defined register space") only reserves the basic SMMU register space. So
the ECMDQ register space is not covered, it should be mapped again. Due
to the size of this ECMDQ resource is not fixed, depending on
SMMU_IDR6.CMDQ_CONTROL_PAGE_LOG2NUMQ. Processing its resource reservation
to avoid resource conflict with PMCG is a bit more complicated.

Therefore, the resources of the PMCG are not reserved, and the entire SMMU
resources are reserved.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++--------------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 --
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f04c55a7503c790..fde24403b06a9e3 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3476,14 +3476,6 @@ static int arm_smmu_set_bus_ops(struct iommu_ops *ops)
 	return err;
 }
 
-static void __iomem *arm_smmu_ioremap(struct device *dev, resource_size_t start,
-				      resource_size_t size)
-{
-	struct resource res = DEFINE_RES_MEM(start, size);
-
-	return devm_ioremap_resource(dev, &res);
-}
-
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	int irq, ret;
@@ -3519,22 +3511,14 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	ioaddr = res->start;
 
-	/*
-	 * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
-	 * the PMCG registers which are reserved by the PMU driver.
-	 */
-	smmu->base = arm_smmu_ioremap(dev, ioaddr, ARM_SMMU_REG_SZ);
+	smmu->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(smmu->base))
 		return PTR_ERR(smmu->base);
 
-	if (arm_smmu_resource_size(smmu) > SZ_64K) {
-		smmu->page1 = arm_smmu_ioremap(dev, ioaddr + SZ_64K,
-					       ARM_SMMU_REG_SZ);
-		if (IS_ERR(smmu->page1))
-			return PTR_ERR(smmu->page1);
-	} else {
+	if (arm_smmu_resource_size(smmu) > SZ_64K)
+		smmu->page1 = smmu->base + SZ_64K;
+	else
 		smmu->page1 = smmu->base;
-	}
 
 	/* Interrupt lines */
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index da525f46dab4fc1..63f2b476987d6ae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -152,8 +152,6 @@
 #define ARM_SMMU_PRIQ_IRQ_CFG1		0xd8
 #define ARM_SMMU_PRIQ_IRQ_CFG2		0xdc
 
-#define ARM_SMMU_REG_SZ			0xe00
-
 /* Common MSI config fields */
 #define MSI_CFG0_ADDR_MASK		GENMASK_ULL(51, 2)
 #define MSI_CFG2_SH			GENMASK(5, 4)
-- 
1.8.3


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
