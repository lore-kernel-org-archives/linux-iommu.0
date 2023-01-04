Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0370810;
	Wed,  4 Jan 2023 11:01:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 1BC6642137;
	Wed,  4 Jan 2023 11:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1672830115; bh=9qeK0960DBm3uT4WTHaZxXPxTgGnc67kJHFXWZqK+Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z5C87PwJ20w4WYbDV4SqDj7mJwZoJ0kdpEtDtJ/292VLLl2X/B0HUarLvCSFrda7Y
	 NHN4P9cD8tsVM/RoDjsiYkSVp9IE+RKJ8CUufnIDQCRjZuUrMbzZV67HiKpqYfn7u2
	 AzeW1L2UJjVoqMTMNHGZdanAqtmqmb0/VoTc3hpEAsO7Ca/E7nhp4KoxIMGGDuqN/m
	 SCfRMrl8YfYJVajzcY/uTKI3VSL+keXCoMumrnqS5gJhDONG/e7Bmu+4kxI8JEgnaA
	 rBPyZWimKw+rrinnLoO5lCXw7xNus/NvVWOXQSOzWn7e/Grksfqe77Zq3adnfOvE0y
	 73dhrxS+xQhoA==
From: Hector Martin <marcan@marcan.st>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: [PATCH 3/7] iommu: dart: Support >64 stream IDs
Date: Wed,  4 Jan 2023 20:00:09 +0900
Message-Id: <20230104110013.24738-4-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104110013.24738-1-marcan@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T8110 DARTs have up to 256 SIDs, so we need to switch to a bitmap to
handle them properly.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/apple-dart.c | 114 +++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 2458416122f8..48743bcd5b9d 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -34,11 +34,10 @@
 
 #include "dma-iommu.h"
 
-#define DART_MAX_STREAMS 16
+#define DART_MAX_STREAMS 256
 #define DART_MAX_TTBR 4
 #define MAX_DARTS_PER_DEVICE 2
 
-#define DART_STREAM_ALL 0xffff
 
 #define DART_PARAMS1 0x00
 #define DART_PARAMS_PAGE_SHIFT GENMASK(27, 24)
@@ -85,6 +84,8 @@
 struct apple_dart_hw {
 	u32 oas;
 	enum io_pgtable_fmt fmt;
+
+	int max_sid_count;
 };
 
 /*
@@ -116,6 +117,7 @@ struct apple_dart {
 	spinlock_t lock;
 
 	u32 pgsize;
+	u32 num_streams;
 	u32 supports_bypass : 1;
 	u32 force_bypass : 1;
 
@@ -143,11 +145,11 @@ struct apple_dart {
  */
 struct apple_dart_stream_map {
 	struct apple_dart *dart;
-	unsigned long sidmap;
+	DECLARE_BITMAP(sidmap, DART_MAX_STREAMS);
 };
 struct apple_dart_atomic_stream_map {
 	struct apple_dart *dart;
-	atomic64_t sidmap;
+	atomic_long_t sidmap[BITS_TO_LONGS(DART_MAX_STREAMS)];
 };
 
 /*
@@ -205,50 +207,55 @@ static struct apple_dart_domain *to_dart_domain(struct iommu_domain *dom)
 static void
 apple_dart_hw_enable_translation(struct apple_dart_stream_map *stream_map)
 {
+	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
-	for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
+	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
 		writel(DART_TCR_TRANSLATE_ENABLE,
-		       stream_map->dart->regs + DART_TCR(sid));
+		       dart->regs + DART_TCR(sid));
 }
 
 static void apple_dart_hw_disable_dma(struct apple_dart_stream_map *stream_map)
 {
+	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
-	for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
-		writel(0, stream_map->dart->regs + DART_TCR(sid));
+	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
+		writel(0, dart->regs + DART_TCR(sid));
 }
 
 static void
 apple_dart_hw_enable_bypass(struct apple_dart_stream_map *stream_map)
 {
+	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
 	WARN_ON(!stream_map->dart->supports_bypass);
-	for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
+	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
 		writel(DART_TCR_BYPASS0_ENABLE | DART_TCR_BYPASS1_ENABLE,
-		       stream_map->dart->regs + DART_TCR(sid));
+		       dart->regs + DART_TCR(sid));
 }
 
 static void apple_dart_hw_set_ttbr(struct apple_dart_stream_map *stream_map,
 				   u8 idx, phys_addr_t paddr)
 {
+	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
 	WARN_ON(paddr & ((1 << DART_TTBR_SHIFT) - 1));
-	for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
+	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
 		writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
-		       stream_map->dart->regs + DART_TTBR(sid, idx));
+		       dart->regs + DART_TTBR(sid, idx));
 }
 
 static void apple_dart_hw_clear_ttbr(struct apple_dart_stream_map *stream_map,
 				     u8 idx)
 {
+	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
-	for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
-		writel(0, stream_map->dart->regs + DART_TTBR(sid, idx));
+	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
+		writel(0, dart->regs + DART_TTBR(sid, idx));
 }
 
 static void
@@ -270,7 +277,7 @@ apple_dart_hw_stream_command(struct apple_dart_stream_map *stream_map,
 
 	spin_lock_irqsave(&stream_map->dart->lock, flags);
 
-	writel(stream_map->sidmap, stream_map->dart->regs + DART_STREAM_SELECT);
+	writel(stream_map->sidmap[0], stream_map->dart->regs + DART_STREAM_SELECT);
 	writel(command, stream_map->dart->regs + DART_STREAM_COMMAND);
 
 	ret = readl_poll_timeout_atomic(
@@ -283,7 +290,7 @@ apple_dart_hw_stream_command(struct apple_dart_stream_map *stream_map,
 	if (ret) {
 		dev_err(stream_map->dart->dev,
 			"busy bit did not clear after command %x for streams %lx\n",
-			command, stream_map->sidmap);
+			command, stream_map->sidmap[0]);
 		return ret;
 	}
 
@@ -301,6 +308,7 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
 {
 	u32 config;
 	struct apple_dart_stream_map stream_map;
+	int i;
 
 	config = readl(dart->regs + DART_CONFIG);
 	if (config & DART_CONFIG_LOCK) {
@@ -310,12 +318,14 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
 	}
 
 	stream_map.dart = dart;
-	stream_map.sidmap = DART_STREAM_ALL;
+	bitmap_zero(stream_map.sidmap, DART_MAX_STREAMS);
+	bitmap_set(stream_map.sidmap, 0, dart->num_streams);
 	apple_dart_hw_disable_dma(&stream_map);
 	apple_dart_hw_clear_all_ttbrs(&stream_map);
 
 	/* enable all streams globally since TCR is used to control isolation */
-	writel(DART_STREAM_ALL, dart->regs + DART_STREAMS_ENABLE);
+	for (i = 0; i < BITS_TO_U32(dart->num_streams); i++)
+		writel(U32_MAX, dart->regs + DART_STREAMS_ENABLE);
 
 	/* clear any pending errors before the interrupt is unmasked */
 	writel(readl(dart->regs + DART_ERROR), dart->regs + DART_ERROR);
@@ -325,13 +335,16 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
 
 static void apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
 {
-	int i;
+	int i, j;
 	struct apple_dart_atomic_stream_map *domain_stream_map;
 	struct apple_dart_stream_map stream_map;
 
 	for_each_stream_map(i, domain, domain_stream_map) {
 		stream_map.dart = domain_stream_map->dart;
-		stream_map.sidmap = atomic64_read(&domain_stream_map->sidmap);
+
+		for (j = 0; j < BITS_TO_LONGS(stream_map.dart->num_streams); j++)
+			stream_map.sidmap[j] = atomic_long_read(&domain_stream_map->sidmap[j]);
+
 		apple_dart_hw_invalidate_tlb(&stream_map);
 	}
 }
@@ -416,7 +429,7 @@ static int apple_dart_finalize_domain(struct iommu_domain *domain,
 	struct apple_dart *dart = cfg->stream_maps[0].dart;
 	struct io_pgtable_cfg pgtbl_cfg;
 	int ret = 0;
-	int i;
+	int i, j;
 
 	mutex_lock(&dart_domain->init_lock);
 
@@ -425,8 +438,9 @@ static int apple_dart_finalize_domain(struct iommu_domain *domain,
 
 	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
 		dart_domain->stream_maps[i].dart = cfg->stream_maps[i].dart;
-		atomic64_set(&dart_domain->stream_maps[i].sidmap,
-			     cfg->stream_maps[i].sidmap);
+		for (j = 0; j < BITS_TO_LONGS(dart->num_streams); j++)
+			atomic_long_set(&dart_domain->stream_maps[i].sidmap[j],
+					cfg->stream_maps[i].sidmap[j]);
 	}
 
 	pgtbl_cfg = (struct io_pgtable_cfg){
@@ -461,7 +475,7 @@ apple_dart_mod_streams(struct apple_dart_atomic_stream_map *domain_maps,
 		       struct apple_dart_stream_map *master_maps,
 		       bool add_streams)
 {
-	int i;
+	int i, j;
 
 	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
 		if (domain_maps[i].dart != master_maps[i].dart)
@@ -471,12 +485,14 @@ apple_dart_mod_streams(struct apple_dart_atomic_stream_map *domain_maps,
 	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
 		if (!domain_maps[i].dart)
 			break;
-		if (add_streams)
-			atomic64_or(master_maps[i].sidmap,
-				    &domain_maps[i].sidmap);
-		else
-			atomic64_and(~master_maps[i].sidmap,
-				     &domain_maps[i].sidmap);
+		for (j = 0; j < BITS_TO_LONGS(domain_maps[i].dart->num_streams); j++) {
+			if (add_streams)
+				atomic_long_or(master_maps[i].sidmap[j],
+					       &domain_maps[i].sidmap[j]);
+			else
+				atomic_long_and(~master_maps[i].sidmap[j],
+						&domain_maps[i].sidmap[j]);
+		}
 	}
 
 	return 0;
@@ -640,14 +656,14 @@ static int apple_dart_of_xlate(struct device *dev, struct of_phandle_args *args)
 
 	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
 		if (cfg->stream_maps[i].dart == dart) {
-			cfg->stream_maps[i].sidmap |= 1 << sid;
+			set_bit(sid, cfg->stream_maps[i].sidmap);
 			return 0;
 		}
 	}
 	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
 		if (!cfg->stream_maps[i].dart) {
 			cfg->stream_maps[i].dart = dart;
-			cfg->stream_maps[i].sidmap = 1 << sid;
+			set_bit(sid, cfg->stream_maps[i].sidmap);
 			return 0;
 		}
 	}
@@ -666,7 +682,7 @@ static void apple_dart_release_group(void *iommu_data)
 	mutex_lock(&apple_dart_groups_lock);
 
 	for_each_stream_map(i, group_master_cfg, stream_map)
-		for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
+		for_each_set_bit(sid, stream_map->sidmap, stream_map->dart->num_streams)
 			stream_map->dart->sid2group[sid] = NULL;
 
 	kfree(iommu_data);
@@ -685,7 +701,7 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
 	mutex_lock(&apple_dart_groups_lock);
 
 	for_each_stream_map(i, cfg, stream_map) {
-		for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS) {
+		for_each_set_bit(sid, stream_map->sidmap, stream_map->dart->num_streams) {
 			struct iommu_group *stream_group =
 				stream_map->dart->sid2group[sid];
 
@@ -724,7 +740,7 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
 		apple_dart_release_group);
 
 	for_each_stream_map(i, cfg, stream_map)
-		for_each_set_bit(sid, &stream_map->sidmap, DART_MAX_STREAMS)
+		for_each_set_bit(sid, stream_map->sidmap, stream_map->dart->num_streams)
 			stream_map->dart->sid2group[sid] = group;
 
 	res = group;
@@ -869,16 +885,26 @@ static int apple_dart_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = apple_dart_hw_reset(dart);
-	if (ret)
-		goto err_clk_disable;
-
 	dart_params[0] = readl(dart->regs + DART_PARAMS1);
 	dart_params[1] = readl(dart->regs + DART_PARAMS2);
 	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
 	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
+
+	dart->num_streams = dart->hw->max_sid_count;
+
+	if (dart->num_streams > DART_MAX_STREAMS) {
+		dev_err(&pdev->dev, "Too many streams (%d > %d)\n",
+			dart->num_streams, DART_MAX_STREAMS);
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
 	dart->force_bypass = dart->pgsize > PAGE_SIZE;
 
+	ret = apple_dart_hw_reset(dart);
+	if (ret)
+		goto err_clk_disable;
+
 	ret = request_irq(dart->irq, apple_dart_irq, IRQF_SHARED,
 			  "apple-dart fault handler", dart);
 	if (ret)
@@ -897,8 +923,8 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 	dev_info(
 		&pdev->dev,
-		"DART [pagesize %x, bypass support: %d, bypass forced: %d] initialized\n",
-		dart->pgsize, dart->supports_bypass, dart->force_bypass);
+		"DART [pagesize %x, %d streams, bypass support: %d, bypass forced: %d] initialized\n",
+		dart->pgsize, dart->num_streams, dart->supports_bypass, dart->force_bypass);
 	return 0;
 
 err_sysfs_remove:
@@ -929,10 +955,12 @@ static int apple_dart_remove(struct platform_device *pdev)
 static const struct apple_dart_hw apple_dart_hw_t8103 = {
 	.oas = 36,
 	.fmt = APPLE_DART,
+	.max_sid_count = 16,
 };
 static const struct apple_dart_hw apple_dart_hw_t6000 = {
 	.oas = 42,
 	.fmt = APPLE_DART2,
+	.max_sid_count = 16,
 };
 
 static __maybe_unused int apple_dart_suspend(struct device *dev)
@@ -940,7 +968,7 @@ static __maybe_unused int apple_dart_suspend(struct device *dev)
 	struct apple_dart *dart = dev_get_drvdata(dev);
 	unsigned int sid, idx;
 
-	for (sid = 0; sid < DART_MAX_STREAMS; sid++) {
+	for (sid = 0; sid < dart->num_streams; sid++) {
 		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
 		for (idx = 0; idx < DART_MAX_TTBR; idx++)
 			dart->save_ttbr[sid][idx] =
@@ -962,7 +990,7 @@ static __maybe_unused int apple_dart_resume(struct device *dev)
 		return ret;
 	}
 
-	for (sid = 0; sid < DART_MAX_STREAMS; sid++) {
+	for (sid = 0; sid < dart->num_streams; sid++) {
 		for (idx = 0; idx < DART_MAX_TTBR; idx++)
 			writel(dart->save_ttbr[sid][idx],
 			       dart->regs + DART_TTBR(sid, idx));
-- 
2.35.1

