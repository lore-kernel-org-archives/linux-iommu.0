Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F175810;
	Wed,  4 Jan 2023 11:02:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id DC01341DF4;
	Wed,  4 Jan 2023 11:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1672830123; bh=6O6u/DiwF8q7P6Yv/PpHELUbZYJkapFUTj1HP8/Sg6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xbUI3R/qFHwBvDCZsyCio7NVckEz+1/4EhgmDZkgYjeU6h2mgnP/V9akZ7+uJxjBA
	 BS0694famCGv6qB8Yy5449gpx8Ij5lnifJVPJmJlHJARuXbw3oAw6myUiQ+lvCJDgZ
	 MsE3dj4wzOJolPr18opaUPXj6cyXVIiYbrGQs+Whl7MP7abQhqvkuVlHgqdGxZCf5L
	 o5eZb8rTSzoqRz6S2rSp5oZ09I6ex3Pxcc/DL9eyh/gLvm5jKXNj2qZw8FMW6diWrK
	 KPxjtLx519xsTQ8mOTfcE2dzfwXrFKGEdKS1P+m39DJCRlJxuknw4bWlTdpA/tRsOX
	 sClceEQUxXmrA==
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
Subject: [PATCH 5/7] iommu: dart: Fix DART_PARAMS1/2 bit define names
Date: Wed,  4 Jan 2023 20:00:11 +0900
Message-Id: <20230104110013.24738-6-marcan@marcan.st>
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

They didn't have the PARAMS reg index in them, but they should.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/apple-dart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 189487c1d978..03a3cb5638ba 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -40,10 +40,10 @@
 
 
 #define DART_PARAMS1 0x00
-#define DART_PARAMS_PAGE_SHIFT GENMASK(27, 24)
+#define DART_PARAMS1_PAGE_SHIFT GENMASK(27, 24)
 
 #define DART_PARAMS2 0x04
-#define DART_PARAMS_BYPASS_SUPPORT BIT(0)
+#define DART_PARAMS2_BYPASS_SUPPORT BIT(0)
 
 #define DART_STREAM_COMMAND 0x20
 #define DART_STREAM_COMMAND_BUSY BIT(2)
@@ -893,8 +893,8 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 	dart_params[0] = readl(dart->regs + DART_PARAMS1);
 	dart_params[1] = readl(dart->regs + DART_PARAMS2);
-	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
-	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
+	dart->pgsize = 1 << FIELD_GET(DART_PARAMS1_PAGE_SHIFT, dart_params[0]);
+	dart->supports_bypass = dart_params[1] & DART_PARAMS2_BYPASS_SUPPORT;
 
 	dart->num_streams = dart->hw->max_sid_count;
 
-- 
2.35.1

