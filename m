Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AED7B;
	Sat, 11 Mar 2023 13:39:08 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id F30535C00F8;
	Sat, 11 Mar 2023 08:39:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 11 Mar 2023 08:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1678541947; x=
	1678628347; bh=4yK7FQCj5sNr0/yKnIfjlg5p1SyzkrDsZm+IWMQebB0=; b=f
	4ojv2OkJiyTvEYCjKIIGR68r4djyuTWSBxKCcDWkDIzB/+SiEThAxzXG9hiQirkz
	jDs2aJ+ARRON2X/V99I0w//pKhhFpei2cKMgc54AvpFyeUiCGtwfvXNVr/pnclCD
	khRo0hgy9YovIvOtFGY5hJN2UWpPny1j9YQw46kuooKSXRaPEKcaHVmlCYifp+n/
	yo8vg/fzjRoDkoixrbh7uOz5QIbR8ZNQ5Wx3PpaLHZFGEDl3CPp647baee2F+QRw
	RQuB/Yix9n/J5afKWt9Gd3CvpiyxjNItpaCFdIgkY2eTWEH9Cz93e5KOLEMWxdtu
	0EE/B+mCZcFK5POy5gVtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1678541947; x=
	1678628347; bh=4yK7FQCj5sNr0/yKnIfjlg5p1SyzkrDsZm+IWMQebB0=; b=l
	uxl2pT6hJmT0n13oDTEYQ7CFT+xa2vLs3h4Ejso1Q7gEpbSfvOXsq6MGZLIkgUI4
	H4aUV1sUZeBx0oY+lEEHfCgfRMP6mBXvNoScnuYqeCOZuk+aXwcFMMQ4LBl+qItw
	UWKSLtyEwWsQv3o0+JEDkED0QFXO6mnaUXYrpfpiiHTiwjEfJ0r2kOmlNDpiwpiW
	nLPV93xbUMjCKTpkjjHvOjLMf0JS+q925+sHK9t0D+RowYekTk2cXGlgNPqNRmXw
	VZax6ecrWpexhBT68wumBylQIYCqeo2KKIdi45w/9+exg5bUbZEqhM25wEedPYHX
	XKE2Oau1/rj/bqG29t+hg==
X-ME-Sender: <xms:e4QMZJj1-aGyJZKZM40K5Fsxc5LjTswtBogWVFs1R9z7UbL-U5yUqw>
    <xme:e4QMZOA9KgopxXoJcs0HUqti2it4hVDPBOIM_PniOorAIitQHp9GmPy3CbAAOzbvd
    t4ORwWkMQ69exeo6QY>
X-ME-Received: <xmr:e4QMZJHwc4ms5XC6opF2b6oHqRSX7PKWGQkzzEPv2T8XEvkbkakxMQrSoXVZlssP7nwC5nXjWk6UeK0vx9A9ePh2h4Of9feyboVTUi6KQNZLxK8HDzn_HqHoceXCqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvtddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:e4QMZOQfD3kT6RCxDvmQ67F-75UOgx7uIBHq8ceJC23brRWjxRJ52w>
    <xmx:e4QMZGwwi3zhNoTRWRU4Q5zPi67_IbXDcf03qOQEJLEiBvj4dCldNA>
    <xmx:e4QMZE5CO-ELLBGS_P1NC-4rYPpsNoDQo9AA-bkw0Qxdm_wg9EpG5Q>
    <xmx:e4QMZI6EfjAll3euTnKidF-E0aWYN1Zqbto7k76pItYNz4jbJvb4eQ>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Mar 2023 08:39:05 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	linux-arm-kernel@lists.infradead.org,
	asahi@lists.linux.dev,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] iommu: dart: Add support for t8103 USB4 DART
Date: Sat, 11 Mar 2023 14:38:56 +0100
Message-Id: <20230311133856.63840-4-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20230311133856.63840-1-sven@svenpeter.dev>
References: <20230311133856.63840-1-sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variant of the regular t8103 DART is used for the two
USB4/Thunderbolt PCIe controllers. It supports 64 instead of 16 streams
which requires a slightly different MMIO layout.

Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index f73d0288e133..23f79659a48b 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -81,6 +81,7 @@
 #define DART_T8020_TCR_BYPASS_DAPF      BIT(12)
 
 #define DART_T8020_TTBR       0x200
+#define DART_T8020_USB4_TTBR  0x400
 #define DART_T8020_TTBR_VALID BIT(31)
 #define DART_T8020_TTBR_ADDR_FIELD_SHIFT 0
 #define DART_T8020_TTBR_SHIFT 12
@@ -1192,6 +1193,33 @@ static const struct apple_dart_hw apple_dart_hw_t8103 = {
 	.ttbr_shift = DART_T8020_TTBR_SHIFT,
 	.ttbr_count = 4,
 };
+
+static const struct apple_dart_hw apple_dart_hw_t8103_usb4 = {
+	.type = DART_T8020,
+	.irq_handler = apple_dart_t8020_irq,
+	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
+	.oas = 36,
+	.fmt = APPLE_DART,
+	.max_sid_count = 64,
+
+	.enable_streams = DART_T8020_STREAMS_ENABLE,
+	.lock = DART_T8020_CONFIG,
+	.lock_bit = DART_T8020_CONFIG_LOCK,
+
+	.error = DART_T8020_ERROR,
+
+	.tcr = DART_T8020_TCR,
+	.tcr_enabled = DART_T8020_TCR_TRANSLATE_ENABLE,
+	.tcr_disabled = 0,
+	.tcr_bypass = 0,
+
+	.ttbr = DART_T8020_USB4_TTBR,
+	.ttbr_valid = DART_T8020_TTBR_VALID,
+	.ttbr_addr_field_shift = DART_T8020_TTBR_ADDR_FIELD_SHIFT,
+	.ttbr_shift = DART_T8020_TTBR_SHIFT,
+	.ttbr_count = 4,
+};
+
 static const struct apple_dart_hw apple_dart_hw_t6000 = {
 	.type = DART_T6000,
 	.irq_handler = apple_dart_t8020_irq,
@@ -1292,6 +1320,7 @@ DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, apple_dart_resum
 
 static const struct of_device_id apple_dart_of_match[] = {
 	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
+	{ .compatible = "apple,t8103-usb4-dart", .data = &apple_dart_hw_t8103_usb4 },
 	{ .compatible = "apple,t8110-dart", .data = &apple_dart_hw_t8110 },
 	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
 	{},
-- 
2.25.1

