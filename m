Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7786C433F5
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:15:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2DD61B44
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 21:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E2DD61B44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 745D9404BF;
	Wed, 17 Nov 2021 21:15:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t3OhoXfQedoD; Wed, 17 Nov 2021 21:15:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A0B6340452;
	Wed, 17 Nov 2021 21:15:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E0F8C002E;
	Wed, 17 Nov 2021 21:15:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC607C0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE258823A0
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="YJtXE1hm";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="a1rJLphZ"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b-wt6X9ggGdZ for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 21:15:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16058823E0
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 21:15:34 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id 403315806CC;
 Wed, 17 Nov 2021 16:15:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Wed, 17 Nov 2021 16:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=RZy5jJe6QukHS
 cO8gascVhRqt3WsYPfRDs+/HqZFOpA=; b=YJtXE1hmGj34qSjO2WQuEyQ4F8+5s
 UkH5mJWpoIobxM7vUCc9vSPfUm/m6eMrGprM2H6LcymYwdLz4SFknXzm+mYteVJ3
 Cn/XiCa0wtxIe59v5r8Ho0QRdLeMalYq8IpAv4hLWAUWYEUJlWXDKOMWgGY88iKh
 grWhApXgc1uf0g/dlAlOeLgD2gpuBlO8QvmjfuJeiz2ZmVouO9Gt/PmsellU4VmK
 dyFJPEnV3Vor91HN0OOpARdTuxqFIamtKks50K5aL0iZ+xJRutdxmG82UzQhSfn1
 lNKQbbh6G95v0aAmkGU9CwG6z4U9pgVwdeE8muWiUvAMHxguFk5vNrXeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=RZy5jJe6QukHScO8gascVhRqt3WsYPfRDs+/HqZFOpA=; b=a1rJLphZ
 0RUNMQKrBvu8DOFqUxD5MrSeEmXZjn/A+QMfSyti8rMgQXKnUNjQQtPzAX36UnWM
 t17bK8yagNVfgTEbCjrAi1PgVIHl0i6j2sJvda3F+eAS2ViTqOcJ6bePuKAl4iCK
 jRIKzvqB6umoeASgQx1Tqu6WJK22Vgf9ixGncx3bRQnEXENTe9uh1asoiXcfMjo7
 Kt18HRQQ6JFwB4QjI5nMhaPv1+4EbTDJSR7NxWROlXQpyJWa/KPPE5H1cuxtUq4/
 DybtaqhqdSc855XYRzJG+iFu+DjCxPBPT6sjBZFaXOvv7Mq7JSaZSbVXn1KJY/X3
 ZWT/utmEpRF6cA==
X-ME-Sender: <xms:9nCVYd5angPfEevmvT4l3awPUyOXtapUawfksThHKg6uphVVHosKew>
 <xme:9nCVYa5ArmAwcqL8Y8AmHwwMn1Of6ZeKOejQoRkAgB0BlBzoPnuvMcgPt0XCY5dNB
 Ot0hkCiovDa5pr9tw4>
X-ME-Received: <xmr:9nCVYUc2FjRuqilWJuVBg-Yleg5nQ6QX9AigST0dHtnLufbbzaBIHeINEmz9pgwop79d8vE15kd1bg5inds5BAFz9F4l9Zujmrra3yvib5lkqRzVLEiwfbfcJDrRxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeeggddugedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
 necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
 hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:9nCVYWJSkAKLBo9oslw2u7Mtgue2zpWXFFSeanynIZx2LHFCnlTcBg>
 <xmx:9nCVYRLkEuz9KDhVPeGiB4kfT5JfKkRp_o09jPZHnGgndoELShxVpg>
 <xmx:9nCVYfzjcdpcsGflENrA7PeE7eNJtmskCGNizcw17Xeas7xkyF0vPw>
 <xmx:9nCVYeCeIr_oyXfCc0FYreqFLkzBYdg6z4KTw4reggRsPRHas2ksaQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Nov 2021 16:15:32 -0500 (EST)
To: iommu@lists.linux-foundation.org
Subject: [PATCH 4/4] iommu: dart: Support t6000 variant
Date: Wed, 17 Nov 2021 22:15:09 +0100
Message-Id: <20211117211509.28066-5-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211117211509.28066-1-sven@svenpeter.dev>
References: <20211117211509.28066-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Sven Peter <sven@svenpeter.dev>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
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

The M1 Pro/Max SoCs come with a new variant of DART which supports a
larger physical address space with a slightly different PTE format.
Pass through the correct paddr address space size to the io-pgtable code
which will take care of the rest.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 565ef5598811..c04648dfd747 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -81,10 +81,15 @@
 #define DART_TTBR_VALID BIT(31)
 #define DART_TTBR_SHIFT 12
 
+struct apple_dart_hw {
+	u32 oas;
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
@@ -98,6 +103,7 @@
  */
 struct apple_dart {
 	struct device *dev;
+	const struct apple_dart_hw *hw;
 
 	void __iomem *regs;
 
@@ -421,7 +427,7 @@ static int apple_dart_finalize_domain(struct iommu_domain *domain,
 	pgtbl_cfg = (struct io_pgtable_cfg){
 		.pgsize_bitmap = dart->pgsize,
 		.ias = 32,
-		.oas = 36,
+		.oas = dart->hw->oas,
 		.coherent_walk = 1,
 		.iommu_dev = dart->dev,
 	};
@@ -855,6 +861,7 @@ static int apple_dart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dart->dev = dev;
+	dart->hw = of_device_get_match_data(dev);
 	spin_lock_init(&dart->lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -944,8 +951,16 @@ static int apple_dart_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct apple_dart_hw apple_dart_hw_t8103 = {
+	.oas = 36,
+};
+static const struct apple_dart_hw apple_dart_hw_t6000 = {
+	.oas = 42,
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
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
