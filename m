Return-Path: <SRS0=8IIh=I2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DA3C433DB
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 07:41:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581166196D
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 07:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581166196D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D9A783B67;
	Sun, 28 Mar 2021 07:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z8E-xeIH1IT6; Sun, 28 Mar 2021 07:41:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04A8683D1D;
	Sun, 28 Mar 2021 07:41:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B031AC0014;
	Sun, 28 Mar 2021 07:41:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76BBAC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 639B64037E
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="iKDzZYT1";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="vlBjORCF"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zozl3vleETuv for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 07:41:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27E2C4037D
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:40:40 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id C2336580832;
 Sun, 28 Mar 2021 03:40:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 28 Mar 2021 03:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=FbUZQ9FrBqVlB
 HDujKZen+1NIj/M3bRfEtKExFUix1U=; b=iKDzZYT1QYBmQLjm3EsaiaVx0cb50
 1/yIw+j7gxfRgLASLdyDapVFvo9yF+fLJsPIb74PJwHd2ewdO2133vV70fcsaKuR
 tMc9BM8QWx/UV4YCaI4SfJl9gWVStKHUntZr6DuoyHix4yffBByjNqOagfpHR1fh
 QPEfIEvirnf/+J9vdta4nGwqQx54IqO9CVnLArMnNr5TiCnO8LYvl8fI8Q0uA7cT
 AZuhdgfhUh/zs04yqpZr4UR7KnBiaCX17f1ViwQp4kBwGhnRgpK7hABDvF/y7jln
 5WLK/r/uZrgoYXoQJlAZGGxywyGnkMlsyxa0ZOMjCLaulNtG4YnRnqQmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=FbUZQ9FrBqVlBHDujKZen+1NIj/M3bRfEtKExFUix1U=; b=vlBjORCF
 sI0HuEx+vtl2V0vwhCgOFqtO8p0sd5WXpqgqSgS8A+0hVL3FMlnNixSDq47fqfbR
 JoujyrwmDtgZOdAZLCz/Kjnn/ss3YD3q/FCvxyPgJKLjQZZmC/3qPLmm9SKermt5
 5QlYug5lS1k6T2rCTVb6l3YLOPLB0USjkz2/GBdVLvEl+snFQwnZgN6HJU7eHboJ
 vkP8qAEVuYrwUsiK/1U+MZFjN9IqjvtN3A3XBEbGCBGfLxQ9v6Ojm0Cxv7nK+Bg1
 BEN0LqmmIegN6luattt0sizt1pyzE3toElPhtn7iwy5XSQlTS2KkneOmQuGbIuCL
 eENUKzmRkUG8eA==
X-ME-Sender: <xms:9TJgYCb_I6iS7fs7yfmwQNTYm03miUtsUgGEbYAoKpde65Dq_xJfwA>
 <xme:9TJgYFbjjWEtERhN2CfmJiet1Tbk1juLe4G0NaVUi3yUxfzCvOerz8OJLBXVmzSsb
 j5I3njQ8atj2Nghxe4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehhedguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
 ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
 gvrhhnpeetvdekteeluefffffhkeetteffgefggfevheeileeufedvtdeuffevveelhfef
 jeenucfkphepudejiedrudelledrvddutddrudehieenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
 vh
X-ME-Proxy: <xmx:9TJgYM9nUSKjNZ9pSK0Er3zrYmAVcOOJJVg8F2716_yRgRF6VqhyTQ>
 <xmx:9TJgYEqZpDnczUr12QndrVBljjdle5iZKjqZAEC-DsIGfMSOZ418iQ>
 <xmx:9TJgYNqESSVLD5-tbtCA3Kw5iIla7fRpOBqfPeMtTIejc5uyZWqg2w>
 <xmx:9TJgYLj48slBIGTDaUOuy-WXcFZUWHiT5WfT7z7rr-s_br6rzUadpmYuCMI>
Received: from localhost.localdomain
 (ip-176-199-210-156.hsi06.unitymediagroup.de [176.199.210.156])
 by mail.messagingengine.com (Postfix) with ESMTPA id 2639A240057;
 Sun, 28 Mar 2021 03:40:35 -0400 (EDT)
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/3] iommu: io-pgtable: add DART pagetable format
Date: Sun, 28 Mar 2021 09:40:07 +0200
Message-Id: <20210328074009.95932-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210328074009.95932-1-sven@svenpeter.dev>
References: <20210328074009.95932-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sven Peter <sven@svenpeter.dev>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org,
 Stan Skowronek <stan@corellium.com>
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

Apple's DART iommu uses a pagetable format that shares some
similarities with the ones already implemented by io-pgtable.c.
Add a new format variant to support the required differences
so that we don't have to duplicate the pagetable handling code.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/io-pgtable-arm.c | 59 ++++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c     |  1 +
 include/linux/io-pgtable.h     |  6 ++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 87def58e79b5..2f63443fd115 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -127,6 +127,9 @@
 #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
 
+#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
+#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -381,6 +384,15 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte;
 
+	if (data->iop.fmt == ARM_APPLE_DART) {
+		pte = 0;
+		if (!(prot & IOMMU_WRITE))
+			pte |= APPLE_DART_PTE_PROT_NO_WRITE;
+		if (!(prot & IOMMU_READ))
+			pte |= APPLE_DART_PTE_PROT_NO_READ;
+		return pte;
+	}
+
 	if (data->iop.fmt == ARM_64_LPAE_S1 ||
 	    data->iop.fmt == ARM_32_LPAE_S1) {
 		pte = ARM_LPAE_PTE_nG;
@@ -1043,6 +1055,48 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }
 
+static struct io_pgtable *
+apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct arm_lpae_io_pgtable *data;
+
+	if (cfg->ias > 36)
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
+	if (cfg->quirks)
+		return NULL;
+
+	data = arm_lpae_alloc_pgtable(cfg);
+	if (!data)
+		return NULL;
+
+	data->start_level = 2;
+	data->pgd_bits = 11;
+	data->bits_per_level = 11;
+
+	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
+					   cfg);
+	if (!data->pgd)
+		goto out_free_data;
+
+	cfg->apple_dart_cfg.ttbr = virt_to_phys(data->pgd);
+
+	return &data->iop;
+
+out_free_data:
+	kfree(data);
+	return NULL;
+}
+
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
@@ -1068,6 +1122,11 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
 	.free	= arm_lpae_free_pgtable,
 };
 
+struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns = {
+	.alloc	= apple_dart_alloc_pgtable,
+	.free	= arm_lpae_free_pgtable,
+};
+
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
 static struct io_pgtable_cfg *cfg_cookie __initdata;
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 6e9917ce980f..6ec75f3e9c3b 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -27,6 +27,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_AMD_IOMMU
 	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
 #endif
+	[ARM_APPLE_DART] = &io_pgtable_apple_dart_init_fns,
 };
 
 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index a4c9ca2c31f1..b06925eb20d3 100644
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
+			u64 ttbr;
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
