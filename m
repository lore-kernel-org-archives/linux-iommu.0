Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A0FC33CA3
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:29:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDB52072E
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 15:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuluGIuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDB52072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7389A86B98;
	Fri, 10 Jan 2020 15:29:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l89li42gU_U3; Fri, 10 Jan 2020 15:29:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8B0DE86B8A;
	Fri, 10 Jan 2020 15:29:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79D11C1D7D;
	Fri, 10 Jan 2020 15:29:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5CBFC0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D1C2786B8A
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hxpzFoiuuPwf for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 15:29:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5415686B20
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1C48520838;
 Fri, 10 Jan 2020 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578670150;
 bh=zEcoifwPRLpUwD79hOwKhG2fIUr/tFaxzoSXmIqLENA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IuluGIuM5g0ZWSgXUMY8OBw8o2FKfYT5jtA9RmW5Q1VBOaOjO2Dl9+kvWmyN/jk+5
 qeAvWIujAAXSA2sj2VIk2k1qqWRbMK3IXvR5bfEJWiObYVKZCM9WUNc8kJ2Koc11oy
 kpkqFAuOhixYnEUY8iI49uITHa+ZYE+5ZPrXZ1kY=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 8/8] iommu/io-pgtable-arm: Prepare for TTBR1 usage
Date: Fri, 10 Jan 2020 15:28:52 +0000
Message-Id: <20200110152852.24259-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110152852.24259-1-will@kernel.org>
References: <20200110152852.24259-1-will@kernel.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, kernel-team@android.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

From: Robin Murphy <robin.murphy@arm.com>

Now that we can correctly extract top-level indices without relying on
the remaining upper bits being zero, the only remaining impediments to
using a given table for TTBR1 are the address validation on map/unmap
and the awkward TCR translation granule format. Add a quirk so that we
can do the right thing at those points.

Tested-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++------
 include/linux/io-pgtable.h     |  4 ++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 846963c87e0f..5e966ef0bacf 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -104,6 +104,10 @@
 #define ARM_LPAE_TCR_TG0_64K		1
 #define ARM_LPAE_TCR_TG0_16K		2
 
+#define ARM_LPAE_TCR_TG1_16K		1
+#define ARM_LPAE_TCR_TG1_4K		2
+#define ARM_LPAE_TCR_TG1_64K		3
+
 #define ARM_LPAE_TCR_SH_NS		0
 #define ARM_LPAE_TCR_SH_OS		2
 #define ARM_LPAE_TCR_SH_IS		3
@@ -463,6 +467,7 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	arm_lpae_iopte *ptep = data->pgd;
 	int ret, lvl = data->start_level;
 	arm_lpae_iopte prot;
+	long iaext = (long)iova >> cfg->ias;
 
 	/* If no access, then nothing to do */
 	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
@@ -471,7 +476,9 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
 	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
 		return -EINVAL;
 
-	if (WARN_ON(iova >> data->iop.cfg.ias || paddr >> data->iop.cfg.oas))
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext || paddr >> cfg->oas))
 		return -ERANGE;
 
 	prot = arm_lpae_prot_to_pte(data, iommu_prot);
@@ -637,11 +644,14 @@ static size_t arm_lpae_unmap(struct io_pgtable_ops *ops, unsigned long iova,
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 	arm_lpae_iopte *ptep = data->pgd;
+	long iaext = (long)iova >> cfg->ias;
 
 	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
 		return 0;
 
-	if (WARN_ON(iova >> data->iop.cfg.ias))
+	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1)
+		iaext = ~iaext;
+	if (WARN_ON(iaext))
 		return 0;
 
 	return __arm_lpae_unmap(data, gather, iova, size, data->start_level, ptep);
@@ -777,9 +787,11 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	u64 reg;
 	struct arm_lpae_io_pgtable *data;
 	typeof(&cfg->arm_lpae_s1_cfg.tcr) tcr = &cfg->arm_lpae_s1_cfg.tcr;
+	bool tg1;
 
 	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
-			    IO_PGTABLE_QUIRK_NON_STRICT))
+			    IO_PGTABLE_QUIRK_NON_STRICT |
+			    IO_PGTABLE_QUIRK_ARM_TTBR1))
 		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
@@ -797,15 +809,16 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 		tcr->orgn = ARM_LPAE_TCR_RGN_NC;
 	}
 
+	tg1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1;
 	switch (ARM_LPAE_GRANULE(data)) {
 	case SZ_4K:
-		tcr->tg = ARM_LPAE_TCR_TG0_4K;
+		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_4K : ARM_LPAE_TCR_TG0_4K;
 		break;
 	case SZ_16K:
-		tcr->tg = ARM_LPAE_TCR_TG0_16K;
+		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_16K : ARM_LPAE_TCR_TG0_16K;
 		break;
 	case SZ_64K:
-		tcr->tg = ARM_LPAE_TCR_TG0_64K;
+		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_64K : ARM_LPAE_TCR_TG0_64K;
 		break;
 	}
 
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 40c1b7745fb6..53d53c6c2be9 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -83,12 +83,16 @@ struct io_pgtable_cfg {
 	 * IO_PGTABLE_QUIRK_NON_STRICT: Skip issuing synchronous leaf TLBIs
 	 *	on unmap, for DMA domains using the flush queue mechanism for
 	 *	delayed invalidation.
+	 *
+	 * IO_PGTABLE_QUIRK_ARM_TTBR1: (ARM LPAE format) Configure the table
+	 *	for use in the upper half of a split address space.
 	 */
 	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
 	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
 	#define IO_PGTABLE_QUIRK_TLBI_ON_MAP	BIT(2)
 	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT	BIT(3)
 	#define IO_PGTABLE_QUIRK_NON_STRICT	BIT(4)
+	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
 	unsigned long			quirks;
 	unsigned long			pgsize_bitmap;
 	unsigned int			ias;
-- 
2.25.0.rc1.283.g88dfdc4193-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
