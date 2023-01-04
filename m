Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D36810;
	Wed,  4 Jan 2023 11:02:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 98D6842300;
	Wed,  4 Jan 2023 11:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1672830119; bh=142QbbUohcowan5JaKEvzqkzDXOTXTkt2BTbRaBx+j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OooIov772mSNFIsjnQOuis1lqhvu4NLFsgs7+rXRxXr43HWhl9d+sVjOvyLUMyIot
	 RUPwqQAP9tsTM0KLiR0LtuRihLhqz6Fav1Na/KoC8sBbyqnJA+iFDgjbrj56ihx1iT
	 hnz9S7bYeVanxhR2PfA43oFUWKuDmAcFRiv61fvAF9d/EN+MJm8Yo/+c7mtEwsoQLT
	 0cZBNKmZtXge2mM0RTrNSCKb+aYmt3/oW44t59ryUDlDlfkFgGq2tkQlrbGJk4fkPp
	 BlmtoIE0u8kuQ9ER81AgC1YQ751Te00fb5hV5zA8AWfMlJFDya6xZMo593k6TcGFaX
	 H55YW358mECbA==
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
Subject: [PATCH 4/7] iommu: dart: Support a variable number of TTBRs per stream
Date: Wed,  4 Jan 2023 20:00:10 +0900
Message-Id: <20230104110013.24738-5-marcan@marcan.st>
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

T8110 only has one TTBR per stream, so un-hardcode that.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/apple-dart.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 48743bcd5b9d..189487c1d978 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -77,15 +77,21 @@
 #define DART_TCR_BYPASS0_ENABLE BIT(8)
 #define DART_TCR_BYPASS1_ENABLE BIT(12)
 
-#define DART_TTBR(sid, idx) (0x200 + 16 * (sid) + 4 * (idx))
 #define DART_TTBR_VALID BIT(31)
 #define DART_TTBR_SHIFT 12
 
+#define DART_TTBR(dart, sid, idx) (0x200 + \
+				   (((dart)->hw->ttbr_count * (sid)) << 2) + \
+				   ((idx) << 2))
+
+
 struct apple_dart_hw {
 	u32 oas;
 	enum io_pgtable_fmt fmt;
 
 	int max_sid_count;
+
+	int ttbr_count;
 };
 
 /*
@@ -245,7 +251,7 @@ static void apple_dart_hw_set_ttbr(struct apple_dart_stream_map *stream_map,
 	WARN_ON(paddr & ((1 << DART_TTBR_SHIFT) - 1));
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
 		writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
-		       dart->regs + DART_TTBR(sid, idx));
+		       dart->regs + DART_TTBR(dart, sid, idx));
 }
 
 static void apple_dart_hw_clear_ttbr(struct apple_dart_stream_map *stream_map,
@@ -255,7 +261,7 @@ static void apple_dart_hw_clear_ttbr(struct apple_dart_stream_map *stream_map,
 	int sid;
 
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
-		writel(0, dart->regs + DART_TTBR(sid, idx));
+		writel(0, dart->regs + DART_TTBR(dart, sid, idx));
 }
 
 static void
@@ -263,7 +269,7 @@ apple_dart_hw_clear_all_ttbrs(struct apple_dart_stream_map *stream_map)
 {
 	int i;
 
-	for (i = 0; i < DART_MAX_TTBR; ++i)
+	for (i = 0; i < stream_map->dart->hw->ttbr_count; ++i)
 		apple_dart_hw_clear_ttbr(stream_map, i);
 }
 
@@ -415,7 +421,7 @@ apple_dart_setup_translation(struct apple_dart_domain *domain,
 	for (i = 0; i < pgtbl_cfg->apple_dart_cfg.n_ttbrs; ++i)
 		apple_dart_hw_set_ttbr(stream_map, i,
 				       pgtbl_cfg->apple_dart_cfg.ttbr[i]);
-	for (; i < DART_MAX_TTBR; ++i)
+	for (; i < stream_map->dart->hw->ttbr_count; ++i)
 		apple_dart_hw_clear_ttbr(stream_map, i);
 
 	apple_dart_hw_enable_translation(stream_map);
@@ -956,11 +962,15 @@ static const struct apple_dart_hw apple_dart_hw_t8103 = {
 	.oas = 36,
 	.fmt = APPLE_DART,
 	.max_sid_count = 16,
+
+	.ttbr_count = 4,
 };
 static const struct apple_dart_hw apple_dart_hw_t6000 = {
 	.oas = 42,
 	.fmt = APPLE_DART2,
 	.max_sid_count = 16,
+
+	.ttbr_count = 4,
 };
 
 static __maybe_unused int apple_dart_suspend(struct device *dev)
@@ -970,9 +980,9 @@ static __maybe_unused int apple_dart_suspend(struct device *dev)
 
 	for (sid = 0; sid < dart->num_streams; sid++) {
 		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
-		for (idx = 0; idx < DART_MAX_TTBR; idx++)
+		for (idx = 0; idx < dart->hw->ttbr_count; idx++)
 			dart->save_ttbr[sid][idx] =
-				readl(dart->regs + DART_TTBR(sid, idx));
+				readl(dart->regs + DART_TTBR(dart, sid, idx));
 	}
 
 	return 0;
@@ -993,7 +1003,7 @@ static __maybe_unused int apple_dart_resume(struct device *dev)
 	for (sid = 0; sid < dart->num_streams; sid++) {
 		for (idx = 0; idx < DART_MAX_TTBR; idx++)
 			writel(dart->save_ttbr[sid][idx],
-			       dart->regs + DART_TTBR(sid, idx));
+			       dart->regs + DART_TTBR(dart, sid, idx));
 		writel(dart->save_tcr[sid], dart->regs + DART_TCR(sid));
 	}
 
-- 
2.35.1

