Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7311B85DF;
	Thu, 27 Feb 2025 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675368; cv=none; b=XTfL8JWb1CLcY7HAPJ5hLf2TwqEphsKZ3LwMCcqnU2xbplJvxCVceivLjq0pfOaYPzk8mJj4H3b2FlKcP3k6eCWz/jb1OSYssUZswnk75MHHWJHVHEBGO9zvP5upQk1daBpP25LoRRiY7SwxpGUzmSJauvONDFrWul2Wd+3/EeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675368; c=relaxed/simple;
	bh=7HnH0tkGi++tfrMg4A08fP3/JgYCMXFck9UdnyuZJUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hD0WAfK27BTK3u/fNdojqFcDvrmrJR1uPs8rG2gbENIhee5X6S9hWQ4Uu3lV08ZpmRv658PsK/KVOCChzNU3AIrfnfjMy6ZOUFdiGVUItH7P4y1Wz7mZ/z//H+mFzyLMhFACbvGvAAGnacdIEcj6zsmFAwj9aWqjU9u+Ft4oKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udyyN6QF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udyyN6QF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 185F3C4CEE8;
	Thu, 27 Feb 2025 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675368;
	bh=7HnH0tkGi++tfrMg4A08fP3/JgYCMXFck9UdnyuZJUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=udyyN6QF3gJwdGi82uRXy1tzgOU7TXWlRPmdUlftb9igMmTr9KWTJHIVQdQCP0xjC
	 p9zo264hg3iIvw3m3l7l0v5+qjAn36NUP/DPGXJ6v+GBvVXW770vxgLJuZPIr6d5ca
	 zfyMSVLGdv9e3RNF2R/Rdt2S0bjkgVJ3ZPUgQNEn7OAMdNq6IG+g+Rnu0qmZuhLuax
	 JqTZckq5slG6yr4FLb8yNNL8PEb6yVZxkSS3CJal8ufMtzF3ejs2IqQXwAhvpfoGmd
	 QIRXRJBC+/yzR8jS1TnRRmaoJBICCBZKUef1bhKBsxTII8XFXNrT6TsbXG/8460pUk
	 2IybkQuOlVzUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08632C282C6;
	Thu, 27 Feb 2025 16:56:08 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Thu, 27 Feb 2025 17:56:04 +0100
Subject: [PATCH 2/2] iommu: apple-dart: Allow mismatched bypass support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-isp-dart-v1-2-161e91ef4f46@gmail.com>
References: <20250227-isp-dart-v1-0-161e91ef4f46@gmail.com>
In-Reply-To: <20250227-isp-dart-v1-0-161e91ef4f46@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740675366; l=2179;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=oluYR6lIJ3W34r9MjQqDF6TqqSgqgYrQRwERY4BEI9Q=;
 b=eSN3v9XIi1argWNG7Tks59zvBzP73SHZjZmG7g7vHKGjGjGTcH8kxslRl9ra2VlQRsSOi+cNx
 TvD1Mx+i6jVD/mlzanTcUEi2j/UABzguTp0j3oJDjvGU15w3aEgz8t6
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Hector Martin <marcan@marcan.st>

This is needed by ISP, which has DART0 with bypass and DART1/2 without.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 drivers/iommu/apple-dart.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index edb2fb22333506d7c64ad1b6321df00ebfd07747..a41ad0627be003f2b0ce42a128c3b04bb2537d56 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -277,6 +277,9 @@ struct apple_dart_domain {
  * @streams: streams for this device
  */
 struct apple_dart_master_cfg {
+	/* Intersection of DART capabilitles */
+	u32 supports_bypass : 1;
+
 	struct apple_dart_stream_map stream_maps[MAX_DARTS_PER_DEVICE];
 };
 
@@ -684,7 +687,7 @@ static int apple_dart_attach_dev_identity(struct iommu_domain *domain,
 	struct apple_dart_stream_map *stream_map;
 	int i;
 
-	if (!cfg->stream_maps[0].dart->supports_bypass)
+	if (!cfg->supports_bypass)
 		return -EINVAL;
 
 	for_each_stream_map(i, cfg, stream_map)
@@ -792,20 +795,25 @@ static int apple_dart_of_xlate(struct device *dev,
 		return -EINVAL;
 	sid = args->args[0];
 
-	if (!cfg)
+	if (!cfg) {
 		cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+
+		/* Will be ANDed with DART capabilities */
+		cfg->supports_bypass = true;
+	}
 	if (!cfg)
 		return -ENOMEM;
 	dev_iommu_priv_set(dev, cfg);
 
 	cfg_dart = cfg->stream_maps[0].dart;
 	if (cfg_dart) {
-		if (cfg_dart->supports_bypass != dart->supports_bypass)
-			return -EINVAL;
 		if (cfg_dart->pgsize != dart->pgsize)
 			return -EINVAL;
 	}
 
+	if (!dart->supports_bypass)
+		cfg->supports_bypass = false;
+
 	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
 		if (cfg->stream_maps[i].dart == dart) {
 			set_bit(sid, cfg->stream_maps[i].sidmap);
@@ -945,7 +953,7 @@ static int apple_dart_def_domain_type(struct device *dev)
 
 	if (cfg->stream_maps[0].dart->pgsize > PAGE_SIZE)
 		return IOMMU_DOMAIN_IDENTITY;
-	if (!cfg->stream_maps[0].dart->supports_bypass)
+	if (!cfg->supports_bypass)
 		return IOMMU_DOMAIN_DMA;
 
 	return 0;

-- 
2.48.1


