Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A7AC3A59E
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 15:19:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAB7216F4
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 15:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAB7216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D4C5CECB;
	Wed, 21 Aug 2019 15:19:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EEF4CECB
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 15:19:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 8E17DE6
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 15:19:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4826B1576;
	Wed, 21 Aug 2019 08:19:22 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 44E1C3F718; 
	Wed, 21 Aug 2019 08:19:21 -0700 (PDT)
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/8] iommu/arm-smmu-v3: Disable detection of ATS and PRI
Date: Wed, 21 Aug 2019 16:17:43 +0100
Message-Id: <20190821151749.23743-3-will@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190821151749.23743-1-will@kernel.org>
References: <20190821151749.23743-1-will@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org,
	Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Detecting the ATS capability of the SMMU at probe time introduces a
spinlock into the ->unmap() fast path, even when ATS is not actually
in use. Furthermore, the ATC invalidation that exists is broken, as it
occurs before invalidation of the main SMMU TLB which leaves a window
where the ATC can be repopulated with stale entries.

Given that ATS is both a new feature and a specialist sport, disable it
for now whilst we fix it properly in subsequent patches. Since PRI
requires ATS, disable that too.

Cc: <stable@vger.kernel.org>
Fixes: 9ce27afc0830 ("iommu/arm-smmu-v3: Add support for PCI ATS")
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 3402b1bc8e94..7a368059cd7d 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3295,11 +3295,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	}
 
 	/* Boolean feature flags */
+#if 0	/* ATS invalidation is slow and broken */
 	if (IS_ENABLED(CONFIG_PCI_PRI) && reg & IDR0_PRI)
 		smmu->features |= ARM_SMMU_FEAT_PRI;
 
 	if (IS_ENABLED(CONFIG_PCI_ATS) && reg & IDR0_ATS)
 		smmu->features |= ARM_SMMU_FEAT_ATS;
+#endif
 
 	if (reg & IDR0_SEV)
 		smmu->features |= ARM_SMMU_FEAT_SEV;
-- 
2.11.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
