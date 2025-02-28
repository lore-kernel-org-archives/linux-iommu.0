Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF60271815;
	Fri, 28 Feb 2025 16:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760331; cv=none; b=KVxl4d7y77rby0F+/eRqMeuz9yk/nhI6kAViGBQ4VRohK4CKQYwstweeZ61XlFlI9l3K8+mJ86KdU9EovI/6QE9SFQ/X5sBiujkKyJz52q+gqLmSlDMFZL7fped/bxC3gZ/U0ymWZi+Bl9+uYLTnPAIpAbojsQ0wlAZTT4OOxJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760331; c=relaxed/simple;
	bh=tsTyrgfGR1TF3kJGjt+QWLhzUmq3p9YOvm4Cf0N//Kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VCekUw+i2aUKKufX9oBoQYd7wr5M+4xJyewyvdsH68n7uMH0MM1Yfv1p93LISrTK6NoeqxylbyZu1mwoDcsIt2GNe/qUWz9FyTt0vlJfs82wAbKyuQnuP6vYIpM0udtTL7cmU3pll9NDH5h+MjlmrsZlBkoNiZFngrSM/nbfse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV7LK789; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV7LK789"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB10EC4CEE5;
	Fri, 28 Feb 2025 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760328;
	bh=tsTyrgfGR1TF3kJGjt+QWLhzUmq3p9YOvm4Cf0N//Kg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eV7LK789topPlHHfQSTWx1vv9ntC6T22GrooijacKuLr8M6EEjQ5tX5cutpeYfbnU
	 KGsheLpfaRH34RrL60jRz4BdzXv7ZWOKF++3ZGQ4MqtQb4yqZsSV0LVbGm9mqsU5X2
	 GMWuqPplDh3f0dNV8NOH2FaxSIR53VPCJKAFHCxcvvA5DCnJwbPbdHAfZD3TUQ/GDQ
	 Pyc3hC/mT07W4s+d2BOLLspcRnckUBHQyLCuBMESlbJx+JcKKKnLgTmGxW2sD9gCP0
	 GSheXggVDPYt0kYqk2RjaAp8QIkKfi+EmdB94vZaViUVujD0GwbwoxPpDuwXWz/BMt
	 SgOALH7gTP0vQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE30C282D1;
	Fri, 28 Feb 2025 16:32:08 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Fri, 28 Feb 2025 17:32:08 +0100
Subject: [PATCH v2 2/2] iommu: apple-dart: Allow mismatched bypass support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-isp-dart-v2-2-0ead81a90e2d@gmail.com>
References: <20250228-isp-dart-v2-0-0ead81a90e2d@gmail.com>
In-Reply-To: <20250228-isp-dart-v2-0-0ead81a90e2d@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740760327; l=2163;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=JQSupRxxeo02jeCiSjlLYXGm5UYUz824xOI4n+kLsIc=;
 b=NIJtNGenNUqCGcrYn+CSg5iwM1CMxzExqc+CYKhhPQo7i/RgO9AE9OfTxrviHYf4OG5lC8nJg
 OGL27PZVqIaAgrswsqJtotv4GAOiML7r1Pe8wVGJdZ2W5H+Kw+Q2c34
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
 drivers/iommu/apple-dart.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index edb2fb22333506d7c64ad1b6321df00ebfd07747..13ccb801f52a4d34f6653f78e92787af7dfed1bc 100644
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
@@ -792,20 +795,24 @@ static int apple_dart_of_xlate(struct device *dev,
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
 
+	cfg->supports_bypass &= dart->supports_bypass;
+
 	for (i = 0; i < MAX_DARTS_PER_DEVICE; ++i) {
 		if (cfg->stream_maps[i].dart == dart) {
 			set_bit(sid, cfg->stream_maps[i].sidmap);
@@ -945,7 +952,7 @@ static int apple_dart_def_domain_type(struct device *dev)
 
 	if (cfg->stream_maps[0].dart->pgsize > PAGE_SIZE)
 		return IOMMU_DOMAIN_IDENTITY;
-	if (!cfg->stream_maps[0].dart->supports_bypass)
+	if (!cfg->supports_bypass)
 		return IOMMU_DOMAIN_DMA;
 
 	return 0;

-- 
2.48.1


