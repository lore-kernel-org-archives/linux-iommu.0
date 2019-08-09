Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C027CC31E40
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:08:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B40120820
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B40120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 25A5DDDD;
	Fri,  9 Aug 2019 17:08:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 70ADABA9
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:08:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 14FCD67F
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:08:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B90B81684;
	Fri,  9 Aug 2019 10:08:21 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8102E3F575; 
	Fri,  9 Aug 2019 10:08:20 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 06/15] iommu/arm-smmu: Get rid of weird "atomic" write
Date: Fri,  9 Aug 2019 18:07:43 +0100
Message-Id: <17cf46a983ff4009cb7251f47c62937d7f834446.1565369764.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1565369764.git.robin.murphy@arm.com>
References: <cover.1565369764.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
	gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

The smmu_write_atomic_lq oddity made some sense when the context
format was effectively tied to CONFIG_64BIT, but these days it's
simpler to just pick an explicit access size based on the format
for the one-and-a-half times we actually care.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index a681e000e704..544c992cf586 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -83,17 +83,6 @@
 		((smmu->options & ARM_SMMU_OPT_SECURE_CFG_ACCESS)	\
 			? 0x400 : 0))
 
-/*
- * Some 64-bit registers only make sense to write atomically, but in such
- * cases all the data relevant to AArch32 formats lies within the lower word,
- * therefore this actually makes more sense than it might first appear.
- */
-#ifdef CONFIG_64BIT
-#define smmu_write_atomic_lq		writeq_relaxed
-#else
-#define smmu_write_atomic_lq		writel_relaxed
-#endif
-
 /* Translation context bank */
 #define ARM_SMMU_CB(smmu, n)	((smmu)->base + (((smmu)->cb_base + (n)) << (smmu)->pgshift))
 
@@ -533,7 +522,10 @@ static void arm_smmu_tlb_inv_range_s2(unsigned long iova, size_t size,
 	reg += leaf ? ARM_SMMU_CB_S2_TLBIIPAS2L : ARM_SMMU_CB_S2_TLBIIPAS2;
 	iova >>= 12;
 	do {
-		smmu_write_atomic_lq(iova, reg);
+		if (smmu_domain->cfg.fmt == ARM_SMMU_CTX_FMT_AARCH64)
+			writeq_relaxed(iova, reg);
+		else
+			writel_relaxed(iova, reg);
 		iova += granule >> 12;
 	} while (size -= granule);
 }
@@ -1371,11 +1363,10 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
 
 	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
-	/* ATS1 registers can only be written atomically */
 	va = iova & ~0xfffUL;
-	if (smmu->version == ARM_SMMU_V2)
-		smmu_write_atomic_lq(va, cb_base + ARM_SMMU_CB_ATS1PR);
-	else /* Register is only 32-bit in v1 */
+	if (cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
+		writeq_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
+	else
 		writel_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
 
 	if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
