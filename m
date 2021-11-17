Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5241C433FE
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:15:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9710461B62
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9710461B62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7671660A73;
	Wed, 17 Nov 2021 21:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vtWDB4ndGT9Z; Wed, 17 Nov 2021 21:15:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72F4560A8A;
	Wed, 17 Nov 2021 21:15:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51DA8C002E;
	Wed, 17 Nov 2021 21:15:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA7CDC0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97F3B40919
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="Hyb0Pqfi";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="IsYHOIOK"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 93L_9UjZ5fju for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 21:15:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E4AF4405BB
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:32 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.nyi.internal (Postfix) with ESMTP id 1A2645806D3;
 Wed, 17 Nov 2021 16:15:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Wed, 17 Nov 2021 16:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=mT0wnBBvzdwTn
 WLPC9AuFvDLgJbzDS9nH0+PdHCOPmI=; b=Hyb0PqficAU0VQumZ7+H0pDKZUAVE
 5XBlkFfmehx45j9lWRYfguU2Qq4MGmzsJyg6oOirv73l8pvDqmi54LRniooSvJV2
 tmX3ptZAbKUMC7uj8qLNlwU0ZmKhSh2UlLcI9eQWGiIdqsslgFlq8I06amiCzv3I
 AeW4t+YoO+5WZ5WnH5qnxZvtEqZio7XRdX0fpCM/UZEuxA1bugjmrMq1C44VEPmQ
 nLoAtk4HJJPXrFIA6j6EAxQOipJ18yHEfvS6ZEvUGLZcKri8WjROv5+6D9RdI0sR
 rHs7dpHP2q706y5+dmvV70ZXpxP+bQZrP/k90GrvNbZjJccT488T+YBBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=mT0wnBBvzdwTnWLPC9AuFvDLgJbzDS9nH0+PdHCOPmI=; b=IsYHOIOK
 tcYaz1g8U5/xHBRNpZ0o3Qpyu/9ZSb5jAMA24Q4noDL+FkUFpIDv/gVENR8H+ea3
 C7G2rV0uR6I/CQLGj6Am9UVAfvsn8o+OnM5d6hRutF/pVLW4d+G6PeXXBRR3zCbs
 PGSmELjHwOgesGFUeV6VD+p5fgn5h3YNDNZrTEewCvso+xJ4CR0xcuDIhiGnuKA0
 OkTkm1joWKxn1Q4jQyLciM/rd5jMdTjWAuhGcv+/o7vuK49CM3dsVwUwGVFUXIhZ
 cftS61HIIF4sl/WN5l7nVh/PSzxPSUJf/Z9dYJTQs0wJVm1Jl6MDYTG28YLHLB/F
 1vzoYElooUz0+A==
X-ME-Sender: <xms:83CVYR9onA3SqyT3KdJwIJoGSzKTbQ-_Ktzdn7Gvly62bq7UEH1j9w>
 <xme:83CVYVtLrnftKtEAsRVlv5Rz9kCT-sKaxQEWEGDB6sgzjOJ9Hsh_eN501SuC5aI5Z
 iiJoqLk57UCX03PqJM>
X-ME-Received: <xmr:83CVYfAvLuZQ4Ysi0EfKliyJrcVhBSJT40QiY-7q1SvRrZ0H79MhPBIi6ddvrtLtBJFsu9kytmadB7IJeW2UqhRNk6Wvjv8H5JZJlcGbrH1NQFRuvUyXJA2epov--g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggddugedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnhepteejvdehleduvddthfetgeeljeegfeeludetkedtkedvteffvdejhfefvdevtedt
 necuffhomhgrihhnpegtfhhgrdgrphhplhgvnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:83CVYVd13xZuvjAvmjvQZ3_2za10nt0EM_yguvQVbnp_u6d91mxkQg>
 <xmx:83CVYWPkCFvo2QhJ0K-5ccPyPE9_g40Gv1msMROsYnGELspoxgVFGw>
 <xmx:83CVYXnMJKaki234d46FiyXI6FengPLfNnes2QNlDjjj0gRz2uKOKQ>
 <xmx:9HCVYXFVTVx5h_fVJIBocq_3ZJmvATgcfGPbx0zwOU2yN2cJ9XZsFw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 16:15:30 -0500 (EST)
To: iommu@lists.linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 3/4] iommu/io-pgtable: Add DART PTE support for t6000
Date: Wed, 17 Nov 2021 22:15:08 +0100
Message-Id: <20211117211509.28066-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211117211509.28066-1-sven@svenpeter.dev>
References: <20211117211509.28066-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

The DARTs present in the M1 Pro/Max SoC support a 42bit physical address
space by shifting the paddr and extending its mask inside the PTE.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/io-pgtable-arm.c | 30 +++++++++++++++++++++++++++++-
 include/linux/io-pgtable.h     |  2 ++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index a8c660b8b3e9..be66774aaf70 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -137,6 +137,11 @@
 #define APPLE_DART_PTE_SUBPAGE_START	GENMASK_ULL(63, 52)
 #define APPLE_DART_PTE_SUBPAGE_END	GENMASK_ULL(51, 40)
 
+#define APPLE_DART_PADDR_MASK_PS_36BIT	GENMASK_ULL(35, 12)
+#define APPLE_DART_PADDR_SHIFT_PS_36BIT	(0)
+#define APPLE_DART_PADDR_MASK_PS_42BIT	GENMASK_ULL(37, 10)
+#define APPLE_DART_PADDR_SHIFT_PS_42BIT	(4)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -171,6 +176,13 @@ static arm_lpae_iopte paddr_to_iopte(phys_addr_t paddr,
 {
 	arm_lpae_iopte pte = paddr;
 
+	if (data->iop.fmt == APPLE_DART) {
+		pte = paddr >> data->iop.cfg.apple_dart_cfg.paddr_shift;
+		pte &= data->iop.cfg.apple_dart_cfg.paddr_mask;
+
+		return pte;
+	}
+
 	/* Of the bits which overlap, either 51:48 or 15:12 are always RES0 */
 	return (pte | (pte >> (48 - 12))) & ARM_LPAE_PTE_ADDR_MASK;
 }
@@ -180,6 +192,12 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
 {
 	u64 paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
 
+	if (data->iop.fmt == APPLE_DART) {
+		paddr = pte & data->iop.cfg.apple_dart_cfg.paddr_mask;
+		paddr <<= data->iop.cfg.apple_dart_cfg.paddr_shift;
+		return paddr;
+	}
+
 	if (ARM_LPAE_GRANULE(data) < SZ_64K)
 		return paddr;
 
@@ -1122,8 +1140,18 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	struct arm_lpae_io_pgtable *data;
 	int i;
 
-	if (cfg->oas > 36)
+	switch (cfg->oas) {
+	case 36:
+		cfg->apple_dart_cfg.paddr_shift = APPLE_DART_PADDR_SHIFT_PS_36BIT;
+		cfg->apple_dart_cfg.paddr_mask = APPLE_DART_PADDR_MASK_PS_36BIT;
+		break;
+	case 42:
+		cfg->apple_dart_cfg.paddr_shift = APPLE_DART_PADDR_SHIFT_PS_42BIT;
+		cfg->apple_dart_cfg.paddr_mask = APPLE_DART_PADDR_MASK_PS_42BIT;
+		break;
+	default:
 		return NULL;
+	}
 
 	data = arm_lpae_alloc_pgtable(cfg);
 	if (!data)
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 86af6f0a00a2..4e26ebb0be93 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -136,6 +136,8 @@ struct io_pgtable_cfg {
 		struct {
 			u64 ttbr[4];
 			u32 n_ttbrs;
+			u32 paddr_shift;
+			u64 paddr_mask;
 		} apple_dart_cfg;
 	};
 };
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
