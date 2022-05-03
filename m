Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBD1C4321E
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 06:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CAF2B40123;
	Tue,  3 May 2022 06:30:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sA89_CYa1sBw; Tue,  3 May 2022 06:30:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9A02340528;
	Tue,  3 May 2022 06:30:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AB6CC007A;
	Tue,  3 May 2022 06:30:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 324F5C008B
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 06:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2EF4660C1A
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 06:30:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6RfCidbzqvoY for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 06:30:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B865F60FCB
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 06:30:35 +0000 (UTC)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de
 [87.154.217.136])
 by soltyk.jannau.net (Postfix) with ESMTPSA id 30E1126E9B7;
 Tue,  3 May 2022 08:23:04 +0200 (CEST)
From: Janne Grunau <j@jannau.net>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 4/4] iommu: dart: Support t6000 variant
Date: Tue,  3 May 2022 08:23:01 +0200
Message-Id: <20220503062301.20872-5-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503062301.20872-1-j@jannau.net>
References: <20220503062301.20872-1-j@jannau.net>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Sven Peter <sven@svenpeter.dev>

The M1 Pro/Max/Ultra SoCs come with a new variant of DART which
supports a larger physical address space with a different PTE format.
Pass through the correct paddr address space size and the PTE format
to the io-pgtable code which will take care of the rest.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>

---
Changes since v1:
 - use APPLE_DART PTE format for dart-t6000
---
 drivers/iommu/apple-dart.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index decafb07ad08..fe0dedd67fd8 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -81,10 +81,16 @@
 #define DART_TTBR_VALID BIT(31)
 #define DART_TTBR_SHIFT 12
 
+struct apple_dart_hw {
+	u32 oas;
+	enum io_pgtable_fmt fmt;
+};
+
 /*
  * Private structure associated with each DART device.
  *
  * @dev: device struct
+ * @hw: SoC-specific hardware data
  * @regs: mapped MMIO region
  * @irq: interrupt number, can be shared with other DARTs
  * @clks: clocks associated with this DART
@@ -98,6 +104,7 @@
  */
 struct apple_dart {
 	struct device *dev;
+	const struct apple_dart_hw *hw;
 
 	void __iomem *regs;
 
@@ -421,13 +428,13 @@ static int apple_dart_finalize_domain(struct iommu_domain *domain,
 	pgtbl_cfg = (struct io_pgtable_cfg){
 		.pgsize_bitmap = dart->pgsize,
 		.ias = 32,
-		.oas = 36,
+		.oas = dart->hw->oas,
 		.coherent_walk = 1,
 		.iommu_dev = dart->dev,
 	};
 
 	dart_domain->pgtbl_ops =
-		alloc_io_pgtable_ops(APPLE_DART, &pgtbl_cfg, domain);
+		alloc_io_pgtable_ops(dart->hw->fmt, &pgtbl_cfg, domain);
 	if (!dart_domain->pgtbl_ops) {
 		ret = -ENOMEM;
 		goto done;
@@ -857,6 +864,7 @@ static int apple_dart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dart->dev = dev;
+	dart->hw = of_device_get_match_data(dev);
 	spin_lock_init(&dart->lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -946,8 +954,18 @@ static int apple_dart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct apple_dart_hw apple_dart_hw_t8103 = {
+	.oas = 36,
+	.fmt = APPLE_DART,
+};
+static const struct apple_dart_hw apple_dart_hw_t6000 = {
+	.oas = 42,
+	.fmt = APPLE_DART2,
+};
+
 static const struct of_device_id apple_dart_of_match[] = {
-	{ .compatible = "apple,t8103-dart", .data = NULL },
+	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
+	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, apple_dart_of_match);
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
