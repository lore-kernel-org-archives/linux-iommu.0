Return-Path: <SRS0=maFY=IS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2A9C433E0
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 16:05:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3857161968
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 16:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3857161968
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E2DB5401E5;
	Sat, 20 Mar 2021 16:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GWXwwd1K8OAQ; Sat, 20 Mar 2021 16:05:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1811A401D6;
	Sat, 20 Mar 2021 16:05:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1F45C000A;
	Sat, 20 Mar 2021 16:05:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37435C0001
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 102EF83AA7
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:27:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jyn_WBpZICkS for <iommu@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 15:27:15 +0000 (UTC)
X-Greylist: delayed 00:07:23 by SQLgrey-1.8.0
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch
 [185.70.41.103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF55583A99
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:27:14 +0000 (UTC)
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com
 [91.134.188.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-41103.protonmail.ch (Postfix) with ESMTPS id 4F2kwB4Zrhz4x0dH
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:20:10 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev
 header.b="fsOp8RQJ"
Date: Sat, 20 Mar 2021 15:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 s=protonmail3; t=1616253599;
 bh=UmBJ19FRNdQXRczXhAbcIfSvSxmkFnUO3Bq5JKvNzm4=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=fsOp8RQJauPiKI+aSzOXutFeZjwRHtDBIoMZCO44lpdoyPTgn38/PDhPAwXA9C4Eo
 qG13iUY5rRpS2WrrF4Z/67tO1l7tTZo6qR+6gJ/Ju2OG35nS5Ftt7dr9Rjxx647uLl
 eKue8xA3PtyNAi5seCk6ZGbdxbv+d9CdVl+OmMTlnr9Q0H4mhv6O3W1/AerEXroMRT
 +tXFhO/FXdC5YQdnBejMvFR+ZwMcE2+20nUgUDsbRF2WRXC8ZIi/UBlnVsaVVY5gpF
 MLpH5AILG+0axnQtDjgF7feZiGkA9qfILeWJJcoVgset9eC3HVz3GIF84ThxWV7OOI
 UzrJ19V3e8Prg==
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/3] iommu: io-pgtable: add DART pagetable format
Message-ID: <20210320151903.60759-2-sven@svenpeter.dev>
In-Reply-To: <20210320151903.60759-1-sven@svenpeter.dev>
References: <20210320151903.60759-1-sven@svenpeter.dev>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 20 Mar 2021 16:05:05 +0000
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Stan Skowronek <stan@corellium.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Mark Kettenis <mark.kettenis@xs4all.nl>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Apple's DART iommu uses a pagetable format that's very similar to the ones
already implemented by io-pgtable.c.
Add a new format variant to support the required differences.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/Kconfig          | 13 +++++++
 drivers/iommu/io-pgtable-arm.c | 70 ++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c     |  3 ++
 include/linux/io-pgtable.h     |  6 +++
 4 files changed, 92 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 192ef8f61310..3c95c8524abe 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -39,6 +39,19 @@ config IOMMU_IO_PGTABLE_LPAE
 	  sizes at both stage-1 and stage-2, as well as address spaces
 	  up to 48-bits in size.

+config IOMMU_IO_PGTABLE_APPLE_DART
+	bool "Apple DART Descriptor Format"
+	select IOMMU_IO_PGTABLE
+	select IOMMU_IO_PGTABLE_LPAE
+	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	help
+	  Enable support for the Apple DART iommu pagetable format.
+	  This format is a variant of the ARMv7/v8 Long Descriptor
+	  Format specific to Apple's iommu found in their SoCs.
+
+	  Say Y here if you have a Apple SoC like the M1 which
+	  contains DART iommus.
+
 config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 	bool "LPAE selftests"
 	depends on IOMMU_IO_PGTABLE_LPAE
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58e79b5..18674469313d 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -127,6 +127,10 @@
 #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL

+/* APPLE_DART_PTE_PROT_NO_WRITE actually maps to ARM_LPAE_PTE_AP_RDONLY  */
+#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
+#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))

@@ -381,6 +385,17 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte;

+#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
+	if (data->iop.fmt == ARM_APPLE_DART) {
+		pte = 0;
+		if (!(prot & IOMMU_WRITE))
+			pte |= APPLE_DART_PTE_PROT_NO_WRITE;
+		if (!(prot & IOMMU_READ))
+			pte |= APPLE_DART_PTE_PROT_NO_READ;
+		return pte;
+	}
+#endif
+
 	if (data->iop.fmt == ARM_64_LPAE_S1 ||
 	    data->iop.fmt == ARM_32_LPAE_S1) {
 		pte = ARM_LPAE_PTE_nG;
@@ -1043,6 +1058,54 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }

+#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
+static struct io_pgtable *
+apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct arm_lpae_io_pgtable *data;
+
+	if (cfg->ias > 38)
+		return NULL;
+	if (cfg->oas > 36)
+		return NULL;
+
+	if (!cfg->coherent_walk)
+		return NULL;
+
+	cfg->pgsize_bitmap &= SZ_16K;
+	if (!cfg->pgsize_bitmap)
+		return NULL;
+
+	data = arm_lpae_alloc_pgtable(cfg);
+	if (!data)
+		return NULL;
+
+	/*
+	 * the hardware only supports this specific three level pagetable layout with
+	 * the first level being encoded into four hardware registers
+	 */
+	data->start_level = ARM_LPAE_MAX_LEVELS - 2;
+	data->pgd_bits = 13;
+	data->bits_per_level = 11;
+
+	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
+					   cfg);
+	if (!data->pgd)
+		goto out_free_data;
+
+	cfg->apple_dart_cfg.pgd[0] = virt_to_phys(data->pgd);
+	cfg->apple_dart_cfg.pgd[1] = virt_to_phys(data->pgd + 0x4000);
+	cfg->apple_dart_cfg.pgd[2] = virt_to_phys(data->pgd + 0x8000);
+	cfg->apple_dart_cfg.pgd[3] = virt_to_phys(data->pgd + 0xc000);
+
+	return &data->iop;
+
+out_free_data:
+	kfree(data);
+	return NULL;
+}
+#endif
+
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
@@ -1068,6 +1131,13 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
 	.free	= arm_lpae_free_pgtable,
 };

+#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
+struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns = {
+	.alloc	= apple_dart_alloc_pgtable,
+	.free	= arm_lpae_free_pgtable,
+};
+#endif
+
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST

 static struct io_pgtable_cfg *cfg_cookie __initdata;
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 6e9917ce980f..d86590b0673a 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -27,6 +27,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_AMD_IOMMU
 	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
 #endif
+#ifdef CONFIG_IOMMU_IO_PGTABLE_APPLE_DART
+	[ARM_APPLE_DART] = &io_pgtable_apple_dart_init_fns,
+#endif
 };

 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index a4c9ca2c31f1..19d9b631d319 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -16,6 +16,7 @@ enum io_pgtable_fmt {
 	ARM_V7S,
 	ARM_MALI_LPAE,
 	AMD_IOMMU_V1,
+	ARM_APPLE_DART,
 	IO_PGTABLE_NUM_FMTS,
 };

@@ -136,6 +137,10 @@ struct io_pgtable_cfg {
 			u64	transtab;
 			u64	memattr;
 		} arm_mali_lpae_cfg;
+
+		struct {
+			u64 pgd[4];
+		} apple_dart_cfg;
 	};
 };

@@ -250,5 +255,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
 extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
+extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;

 #endif /* __IO_PGTABLE_H */
--
2.25.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
