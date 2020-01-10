Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163C7C282DD
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:22:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEDDA2072E
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEDDA2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A7DFF8591D;
	Fri, 10 Jan 2020 15:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QQ6eadEP7wxA; Fri, 10 Jan 2020 15:21:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0BF7D85803;
	Fri, 10 Jan 2020 15:21:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1B49C1D7D;
	Fri, 10 Jan 2020 15:21:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11229C0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F124385888
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:21:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YQOxh2VPAEPr for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 15:21:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0B59985803
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:21:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E7F830E;
 Fri, 10 Jan 2020 07:21:55 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9EFF3F6C4;
 Fri, 10 Jan 2020 07:21:54 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH] iommu/io-pgtable-arm: Improve attribute handling
Date: Fri, 10 Jan 2020 15:21:51 +0000
Message-Id: <dee4fff7765629ca5d215af1105b5f98b32f073a.1578669544.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.23.0.dirty
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

By VMSA rules, using Normal Non-Cacheable type with a shareability
attribute of anything other than Outer Shareable is liable to lead into
unpredictable territory. Although the SMMU architectures seem to give
some slightly stronger guarantees of Non-Cacheable output types becoming
implicitly Outer Shareable in most cases, we may as well be explicit and
not take any chances. It's also weird that LPAE attribute handling is
currently split between prot_to_pte() and init_pte() given that it can
all be statically determined up-front. Thus, collect *all* the LPAE
attributes into prot_to_pte() in order to logically pick the
shareability based on the incoming IOMMU API prot value, and tweak the
short-descriptor code to stop setting TTBR0.NOS for Non-Cacheable walks.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c |  7 +++----
 drivers/iommu/io-pgtable-arm.c     | 17 +++++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 7c3bd2c3cdca..7d6a8622f2e6 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -823,10 +823,9 @@ static struct io_pgtable *arm_v7s_alloc_pgtable(struct io_pgtable_cfg *cfg,
 	wmb();
 
 	/* TTBRs */
-	cfg->arm_v7s_cfg.ttbr[0] = virt_to_phys(data->pgd) |
-				   ARM_V7S_TTBR_S | ARM_V7S_TTBR_NOS |
-				   (cfg->coherent_walk ?
-				   (ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
+	cfg->arm_v7s_cfg.ttbr[0] = virt_to_phys(data->pgd) | ARM_V7S_TTBR_S |
+				   (cfg->coherent_walk ? (ARM_V7S_TTBR_NOS |
+				    ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
 				    ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBWA)) :
 				   (ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC) |
 				    ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)));
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index bdf47f745268..b5025d732f5e 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -293,17 +293,11 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte = prot;
 
-	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
-		pte |= ARM_LPAE_PTE_NS;
-
 	if (data->iop.fmt != ARM_MALI_LPAE && lvl == ARM_LPAE_MAX_LEVELS - 1)
 		pte |= ARM_LPAE_PTE_TYPE_PAGE;
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
-	if (data->iop.fmt != ARM_MALI_LPAE)
-		pte |= ARM_LPAE_PTE_AF;
-	pte |= ARM_LPAE_PTE_SH_IS;
 	pte |= paddr_to_iopte(paddr, data);
 
 	__arm_lpae_set_pte(ptep, pte, &data->iop.cfg);
@@ -460,9 +454,20 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
 	}
 
+	if (prot & IOMMU_CACHE)
+		pte |= ARM_LPAE_PTE_SH_IS;
+	else
+		pte |= ARM_LPAE_PTE_SH_OS;
+
 	if (prot & IOMMU_NOEXEC)
 		pte |= ARM_LPAE_PTE_XN;
 
+	if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_NS)
+		pte |= ARM_LPAE_PTE_NS;
+
+	if (data->iop.fmt != ARM_MALI_LPAE)
+		pte |= ARM_LPAE_PTE_AF;
+
 	return pte;
 }
 
-- 
2.23.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
