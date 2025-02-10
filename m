Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FE2580D9
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216433; cv=none; b=I5+diZM0hzvjLKGedWJwSr0IxkQ6Bhwj/hWTyUdXcK7wlOBqWrCr6TfNUjaVyXNeBhA1JT1/YyAh2sIBOicjFHtrbpLfyE0KFe/rf5MIo8BW6sJgxWOsLZTJfKePnl/mGihvTJDaY9/nQgqEBk/XpqqVl5fK7dpyIu4OW0C9fMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216433; c=relaxed/simple;
	bh=apwlrHK+NFmUFcATPM4IEl3yfbQ24a1UqxWS9zc+/wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AdbjX2KUo+RevpcnR0nZw6FI+Ophy1Mgbq3uue3dQdW3/Ag3I7vhBYjNYANILZE6vEO8GCcYAI5v1N7H5wS8DIQ/K1hGdHjLtglZq8GHpJdTFMPDuPfxbT7bjHpcLK6X5GizV8FJwAYR1HzYNg1nXPyqbyh/8n0p1DUJBR52P2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=mEB+Xkj8; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="mEB+Xkj8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739216428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOD2Sq5+ZH4AcnNDOmSUoO/ljPGq1eIifxgBsdfQLiY=;
	b=mEB+Xkj8T8zGigBKiyv7FB06VJrCxIGpILs21+CpcutU5jlc0MWNb1aUfNlgnvwcp5Zwub
	psyi+BgX8tRe1LYfw35T0eLHelVndz55BfAqxCuXw8Ecyw0yPUbJcHTsJmD9mZhEfT9DdP
	bIEZWiNNb4U52rCnloNeb9NjZMv1yOVQTL5x3mbfRvc+Mc+xFEwZJkf8kk25clMtRcvDa9
	IRYHl+O2rWr+dmA452gcgDFHawO8b09IezIHm3NA553dfTGiaPHi47vRE5ObJdaO0iIQVI
	T45sAe5S5uPg7yezUVNN8zVAS4XMYpOxL9Fw2Ebw1edHwxE2E2qT4Jho5N5uyA==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Mon, 10 Feb 2025 14:39:57 -0500
Subject: [PATCH 5/5] iommu/dart: Assert !locked when configuring
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-locked-dart-v1-5-5d97fe247f35@rosenzweig.io>
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
In-Reply-To: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2308; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=apwlrHK+NFmUFcATPM4IEl3yfbQ24a1UqxWS9zc+/wc=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnqlYZdwU6iimgUcyo61wE4/xA3zJtr53OpF+Dx
 ctCIBx48SSJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6pWGQAKCRD+/lBaCvVY
 DVycD/49tr1weIxdnNGNmj3jpsXXmZOfwks2OSyN89yavv1Na4aT4E+O2fNw3BRnk1VspirBigp
 ll9E48WekXnXMa8kQxS/2I1/aYigRPd2T4L2iiKbxPEi8UCNQgbAqGlHGxvqhCLvvYh+2aiDLpv
 xH2nW+kMVzdMlunP7GVyAZZvOyCG2RtlbboG0Qj5J4G3nZpDU6AaDXYbHX1a4FzTsPS0LqiTnpt
 qUqjp6NjnCOMaQlHvKIjhf83bVlSMr7tzYIhdzb80lX/ZAJGtOhM5feKQyeF9wkfVhaFtU/pN4V
 35/in4R1dTefaMz6tsoF3MBj/m44M8slSaK86gCIePgTWDpr+e6z8wqy8fjqgghaxlNuV7f1wMz
 34yVh6f/hp1tQn0C7xlKfF1rhCAk+LblHY9/U2CLdt85dWhLBFnANsyPpPgMCqqp0z6G2pqYGOB
 qz1a1oPkM8XMYzed6vENNWVflXNkAYPcHfY1/tXCck/4jWHVdfp7ZUaCDX6wTFBOMHKy9LVPJsl
 UBZX50SMZJhbfMPNyhvJFTuPc3c0W4HFibXi+NA2Pw92klqA2ja8fy8CQ6hOMYf+PvjKayDLUZv
 lil/vSW3MdZk8Hee4FrkwJv+iftK+Js8/p9i3HQRHdzCNRXjNkiTXHTc6x/iYwiWIWIM3oaGoWz
 T6IiGUagk+V8YCw==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

Configuration is only possible and needed for non-locked DARTs and will
fail for locked DARTs. We cannot try -- assert that we do not.

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/iommu/apple-dart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 29b627b38e8c37afd2b6a72865f43d24b633834a..87eb87bb2f5158d000a2c2fc801b722a2262c941 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -309,6 +309,7 @@ apple_dart_hw_enable_translation(struct apple_dart_stream_map *stream_map)
 	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
+	WARN_ON(stream_map->dart->locked);
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
 		writel(dart->hw->tcr_enabled, dart->regs + DART_TCR(dart, sid));
 }
@@ -318,6 +319,7 @@ static void apple_dart_hw_disable_dma(struct apple_dart_stream_map *stream_map)
 	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
+	WARN_ON(stream_map->dart->locked);
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
 		writel(dart->hw->tcr_disabled, dart->regs + DART_TCR(dart, sid));
 }
@@ -328,7 +330,7 @@ apple_dart_hw_enable_bypass(struct apple_dart_stream_map *stream_map)
 	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
-	WARN_ON(!stream_map->dart->supports_bypass);
+	WARN_ON(stream_map->dart->locked || !stream_map->dart->supports_bypass);
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
 		writel(dart->hw->tcr_bypass,
 		       dart->regs + DART_TCR(dart, sid));
@@ -340,6 +342,7 @@ static void apple_dart_hw_set_ttbr(struct apple_dart_stream_map *stream_map,
 	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
+	WARN_ON(stream_map->dart->locked);
 	WARN_ON(paddr & ((1 << dart->hw->ttbr_shift) - 1));
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
 		writel(dart->hw->ttbr_valid |
@@ -353,6 +356,7 @@ static void apple_dart_hw_clear_ttbr(struct apple_dart_stream_map *stream_map,
 	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
+	WARN_ON(stream_map->dart->locked);
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
 		writel(0, dart->regs + DART_TTBR(dart, sid, idx));
 }

-- 
2.48.1

