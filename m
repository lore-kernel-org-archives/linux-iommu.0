Return-Path: <SRS0=UwG5=XG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D76C5ACAE
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 14:42:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81602053B
	for <iommu@archiver.kernel.org>; Wed, 11 Sep 2019 14:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81602053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 83ADC1393;
	Wed, 11 Sep 2019 14:42:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 91D9F1388
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 14:42:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 148DB894
	for <iommu@lists.linux-foundation.org>;
	Wed, 11 Sep 2019 14:42:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1DED1570;
	Wed, 11 Sep 2019 07:42:17 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 94E373F67D; 
	Wed, 11 Sep 2019 07:42:16 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	joro@8bytes.org
Subject: [PATCH 1/3] iommu/io-pgtable-arm: Correct Mali attributes
Date: Wed, 11 Sep 2019 15:42:07 +0100
Message-Id: <8b9515e86053910196cbc90b71af97be8928585c.1568211045.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1568211045.git.robin.murphy@arm.com>
References: <cover.1568211045.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: robh@kernel.org, tomeu.vizoso@collabora.com, narmstrong@baylibre.com,
	steven.price@arm.com, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
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

Whilst Midgard's MEMATTR follows a similar principle to the VMSA MAIR,
the actual attribute values differ, so although it currently appears to
work to some degree, we probably shouldn't be using our standard stage 1
MAIR for that. Instead, generate a reasonable MEMATTR with attribute
values borrowed from the kbase driver; at this point we'll be overriding
or ignoring pretty much all of the LPAE config, so just implement these
Mali details in a dedicated allocator instead of pretending to subclass
the standard VMSA format.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 53 +++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 161a7d56264d..9e35cd991f06 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -167,6 +167,9 @@
 #define ARM_MALI_LPAE_TTBR_READ_INNER	BIT(2)
 #define ARM_MALI_LPAE_TTBR_SHARE_OUTER	BIT(4)
 
+#define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
+#define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -1013,27 +1016,51 @@ arm_32_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 static struct io_pgtable *
 arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 {
-	struct io_pgtable *iop;
+	struct arm_lpae_io_pgtable *data;
+
+	/* No quirks for Mali (hopefully) */
+	if (cfg->quirks)
+		return NULL;
 
 	if (cfg->ias != 48 || cfg->oas > 40)
 		return NULL;
 
 	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
-	iop = arm_64_lpae_alloc_pgtable_s1(cfg, cookie);
-	if (iop) {
-		u64 mair, ttbr;
 
-		/* Copy values as union fields overlap */
-		mair = cfg->arm_lpae_s1_cfg.mair[0];
-		ttbr = cfg->arm_lpae_s1_cfg.ttbr[0];
+	data = arm_lpae_alloc_pgtable(cfg);
+	if (!data)
+		return NULL;
 
-		cfg->arm_mali_lpae_cfg.memattr = mair;
-		cfg->arm_mali_lpae_cfg.transtab = ttbr |
-			ARM_MALI_LPAE_TTBR_READ_INNER |
-			ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
-	}
+	/*
+	 * MEMATTR: Mali has no actual notion of a non-cacheable type, so the
+	 * best we can do is mimic the out-of-tree driver and hope that the
+	 * "implementation-defined caching policy" is good enough. Similarly,
+	 * we'll use it for the sake of a valid attribute for our 'device'
+	 * index, although callers should never request that in practice.
+	 */
+	cfg->arm_mali_lpae_cfg.memattr =
+		(ARM_MALI_LPAE_MEMATTR_IMP_DEF
+		 << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_NC)) |
+		(ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC
+		 << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
+		(ARM_MALI_LPAE_MEMATTR_IMP_DEF
+		 << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV));
 
-	return iop;
+	data->pgd = __arm_lpae_alloc_pages(data->pgd_size, GFP_KERNEL, cfg);
+	if (!data->pgd)
+		goto out_free_data;
+
+	/* Ensure the empty pgd is visible before TRANSTAB can be written */
+	wmb();
+
+	cfg->arm_mali_lpae_cfg.transtab = virt_to_phys(data->pgd) |
+					  ARM_MALI_LPAE_TTBR_READ_INNER |
+					  ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
+	return &data->iop;
+
+out_free_data:
+	kfree(data);
+	return NULL;
 }
 
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
