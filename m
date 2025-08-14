Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF60A2E9EB0;
	Thu, 14 Aug 2025 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160859; cv=none; b=TtiEXLxD/5Ze6eIQjDlScf3LleeAPs06qgF2C9zrJECRl+IfongTM30BKRTVxlQq9wFxssCbH+PvBYiMdy7oPtjkMdCQyFeUyr/JG19EL7ElkAN313XDVoc6ApbirvgAsJUFaiilKQYOXH3O4dxLjd01rc0Y2GGP/vfcFvNmcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160859; c=relaxed/simple;
	bh=gWJwlS88i16HpoPuqvaPOKo986ultjZxcO66aCiGV/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phYitBZr7oyuTIihxWet/WBTO5u3RIn8fjpboZ1kZTxOPTA6MvsljFSpbDBvIg03mG1tdyfIS86mVrjXnK0at7ntZip+n+l6TeQU5BL+8jsZiQIj5FbtQEhJa0oJiP8Dhiica/Y61bGFvOMFx8e1Fs3OGbuKKuGDyaDTQpWtByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=QUwWwTlG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QvZZkPt0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="QUwWwTlG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QvZZkPt0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01A1614001A4;
	Thu, 14 Aug 2025 04:40:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 14 Aug 2025 04:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755160856;
	 x=1755247256; bh=bLfHLlJrKDPCs/FZhmHqK0Zp1Gpj5ygoSbCyX153n2Y=; b=
	QUwWwTlGGlUdh5D2EoYElGo4npNi9nDOcuOvtBZ9OWlu6yTnd1Z9NrQ1jBEabcZ3
	6VbadAiTU/7b1it/1GM7XY292nR0UHUBWxstu4hL7C3kwukUdX80sKfmaVC6fubH
	I/8bAxa/ZYF0ebrrZZ1pVORmqRP8B6ZFdpdgMJ8QTAXTFgRm1mJC5zaMm5/gMNu9
	0l5J6nEhKkSca7oAXZA/lO5RuM4ZWNy/+7SMJsQQjbwrdE7LgZ7MK4Xr/c+lfx0m
	Q9bKKw7OToFQwV+5E0QX4hRqT8VJiKbNe1LZS96XoyD8H1WYQL0u1mZIxqzsCc0U
	ZFvyUSdhsGKpSDNwEW+2Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755160856; x=
	1755247256; bh=bLfHLlJrKDPCs/FZhmHqK0Zp1Gpj5ygoSbCyX153n2Y=; b=Q
	vZZkPt0+rLKd8n6m/AcekTro7Nl3Q76TNOYw8LTtjI2u1OmyjansK5LsPsD2ynRA
	NxWBwalFpxD/ad0k4TIuo2K+p0hjPoo/jP7IBNq4VllVbOMJOBMFNWrtXTuwrdUB
	KvHL4XTQAyFu0dl7mSZwu8+zElq0xj1InW7SiVtmzcDoQIBmzqoYMDyWTJp7dOYu
	evrupFXmaJxwq+N57vQWcNn46Zp1/gOXKw1W4zlWxR5Sy8ScDJSClklA0yLdTRnT
	CPy6dSAkhaMEO/AB61fvbWx97NhHVu99ZmYTHw3o5OYH4H8st7hMfAKbvtlOida9
	4+4biEfWT9/MVPJ9bJDfQ==
X-ME-Sender: <xms:GKGdaEdb759aERT8sHUfdtZPTmkkn79196azzGI9yzWEUwfYd01QNA>
    <xme:GKGdaMLIT1n0gLWOjf_pGSQeq5QlTob8bF7GYPkQEMtZ4kwZEYsJBXzrz3JkjBZEB
    ggRLx7Yx2pCNa9zvZc>
X-ME-Received: <xmr:GKGdaCpmnGlbriZLp9b1Owv1f4fMF7KIn2nJGl2A3Tcv4MHocn7pQ6Rsz9oT4tPF4h2KDs5dCBaxA0iUKPDHXxuZ2ZIdte7_Dsng_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehiohhmmhhusehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhgrrhgtrghnsehmrghrtggrnhdr
    shhtpdhrtghpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpth
    htohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhs
    thhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvg
    hlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepnhgvrghlsehg
    ohhmphgrrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GKGdaKtGA6_VsDeKeXTG-RZNQD85D7J8CWfpzPLGPRczEuGjjnGgGA>
    <xmx:GKGdaMIEMfMQRLOLLqt2vCnIHxW8_eZLwuxhGqi2YKuD47ek8_6wSg>
    <xmx:GKGdaJo1667luzGsKaaj5pejBX40K6hDyFxaVH04VMNyfI6PmiQNIw>
    <xmx:GKGdaPUhDGCiqg41hDosW1H0hT4cBm0WRh-rs8bPcxJakHhIl2Ly-Q>
    <xmx:GKGdaDvVHbzv3dnu-eYgfHPrMcflksOVuTvfdbXDYuyWthNj0u1BJjQq>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 04:40:56 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 14 Aug 2025 10:40:26 +0200
Subject: [PATCH 3/3] iommu: apple-dart: Add 4-level page table support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-apple-dart-4levels-v1-3-db2214a78c08@jannau.net>
References: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
In-Reply-To: <20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4726; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=i3kAZWxlRfiQa+q5rET420js2FzDp/g4XWlOhDOKngU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoy5C/kmZwqe6Ti8S/vm27rkGRaaz7tWtj17l9L/41Hmw
 ss9p8rcO0pZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExkiybDf9+Eb056a2zqmyuO
 GGTyHChsa5ZM/Fl4ofTofcFGCV57N0aGTRnv8pdf0L1aZH5lkf6hvORI3lsKMX+6VopcutnxcfZ
 afgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Hector Martin <marcan@marcan.st>

The T8110 variant DART implementation on T602x SoCs indicates an IAS of
42, which requires an extra page table level. The extra level is
optional, but let's implement it.

Since the driver failed at IO page table creation with 42-bit IAS add
"apple,t6020-dart" as separate compatible using the T8110 HW data.

Later it might be useful to restrict this based on the actual attached
devices, since most won't need that much address space anyway.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/iommu/apple-dart.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index e72a93e78e26ca61b233c83d439dbdfadf040fc6..bb48e8603d6c84bcf107294d851c2f2fc1273298 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -133,6 +133,7 @@
 #define DART_T8110_TCR                  0x1000
 #define DART_T8110_TCR_REMAP            GENMASK(11, 8)
 #define DART_T8110_TCR_REMAP_EN         BIT(7)
+#define DART_T8110_TCR_FOUR_LEVEL       BIT(3)
 #define DART_T8110_TCR_BYPASS_DAPF      BIT(2)
 #define DART_T8110_TCR_BYPASS_DART      BIT(1)
 #define DART_T8110_TCR_TRANSLATE_ENABLE BIT(0)
@@ -177,6 +178,7 @@ struct apple_dart_hw {
 	u32 tcr_enabled;
 	u32 tcr_disabled;
 	u32 tcr_bypass;
+	u32 tcr_4level;
 
 	u32 ttbr;
 	u32 ttbr_valid;
@@ -217,6 +219,7 @@ struct apple_dart {
 	u32 pgsize;
 	u32 num_streams;
 	u32 supports_bypass : 1;
+	u32 four_level : 1;
 
 	struct iommu_group *sid2group[DART_MAX_STREAMS];
 	struct iommu_device iommu;
@@ -305,13 +308,16 @@ static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
 }
 
 static void
-apple_dart_hw_enable_translation(struct apple_dart_stream_map *stream_map)
+apple_dart_hw_enable_translation(struct apple_dart_stream_map *stream_map, int levels)
 {
 	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
+	WARN_ON(levels != 3 && levels != 4);
+	WARN_ON(levels == 4 && !dart->four_level);
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
-		writel(dart->hw->tcr_enabled, dart->regs + DART_TCR(dart, sid));
+		writel(dart->hw->tcr_enabled | (levels == 4 ? dart->hw->tcr_4level : 0),
+		       dart->regs + DART_TCR(dart, sid));
 }
 
 static void apple_dart_hw_disable_dma(struct apple_dart_stream_map *stream_map)
@@ -569,7 +575,8 @@ apple_dart_setup_translation(struct apple_dart_domain *domain,
 	for (; i < stream_map->dart->hw->ttbr_count; ++i)
 		apple_dart_hw_clear_ttbr(stream_map, i);
 
-	apple_dart_hw_enable_translation(stream_map);
+	apple_dart_hw_enable_translation(stream_map,
+					 pgtbl_cfg->apple_dart_cfg.n_levels);
 	stream_map->dart->hw->invalidate_tlb(stream_map);
 }
 
@@ -614,7 +621,7 @@ static int apple_dart_finalize_domain(struct apple_dart_domain *dart_domain,
 	dart_domain->domain.pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 	dart_domain->domain.geometry.aperture_start = 0;
 	dart_domain->domain.geometry.aperture_end =
-		(dma_addr_t)DMA_BIT_MASK(dart->ias);
+		(dma_addr_t)DMA_BIT_MASK(pgtbl_cfg.ias);
 	dart_domain->domain.geometry.force_aperture = true;
 
 	dart_domain->finalized = true;
@@ -807,6 +814,8 @@ static int apple_dart_of_xlate(struct device *dev,
 	if (cfg_dart) {
 		if (cfg_dart->pgsize != dart->pgsize)
 			return -EINVAL;
+		if (cfg_dart->ias != dart->ias)
+			return -EINVAL;
 	}
 
 	cfg->supports_bypass &= dart->supports_bypass;
@@ -1137,6 +1146,7 @@ static int apple_dart_probe(struct platform_device *pdev)
 		dart->ias = FIELD_GET(DART_T8110_PARAMS3_VA_WIDTH, dart_params[2]);
 		dart->oas = FIELD_GET(DART_T8110_PARAMS3_PA_WIDTH, dart_params[2]);
 		dart->num_streams = FIELD_GET(DART_T8110_PARAMS4_NUM_SIDS, dart_params[3]);
+		dart->four_level = dart->ias > 36;
 		break;
 	}
 
@@ -1169,9 +1179,9 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 	dev_info(
 		&pdev->dev,
-		"DART [pagesize %x, %d streams, bypass support: %d, bypass forced: %d] initialized\n",
+		"DART [pagesize %x, %d streams, bypass support: %d, bypass forced: %d, AS %d -> %d] initialized\n",
 		dart->pgsize, dart->num_streams, dart->supports_bypass,
-		dart->pgsize > PAGE_SIZE);
+		dart->pgsize > PAGE_SIZE, dart->ias, dart->oas);
 	return 0;
 
 err_sysfs_remove:
@@ -1292,6 +1302,7 @@ static const struct apple_dart_hw apple_dart_hw_t8110 = {
 	.tcr_enabled = DART_T8110_TCR_TRANSLATE_ENABLE,
 	.tcr_disabled = 0,
 	.tcr_bypass = DART_T8110_TCR_BYPASS_DAPF | DART_T8110_TCR_BYPASS_DART,
+	.tcr_4level = DART_T8110_TCR_FOUR_LEVEL,
 
 	.ttbr = DART_T8110_TTBR,
 	.ttbr_valid = DART_T8110_TTBR_VALID,

-- 
2.50.1

