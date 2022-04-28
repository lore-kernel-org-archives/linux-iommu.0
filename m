Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5B7C433FE
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 02:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8752082FE7;
	Thu, 28 Apr 2022 02:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2nANHA7I2xz9; Thu, 28 Apr 2022 02:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4CDDF82951;
	Thu, 28 Apr 2022 02:02:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C4EDC0086;
	Thu, 28 Apr 2022 02:02:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A10C5C0080
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BC0D4191C
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sholland.org header.b="B27RA3E1";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="HN2J6N7E"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1d2vHrJKozmH for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 01:10:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2FA154190E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:10:47 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 3FE065C0216;
 Wed, 27 Apr 2022 21:04:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 27 Apr 2022 21:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1651107858; x=1651194258; bh=EW
 QuBrshtflaBYZQbOQftY716qHgPAQrgs5xYJD0PZQ=; b=B27RA3E11tPFjhXoZl
 BCXngJ4YKleJDrSbx28eZHU8/vEasIR/rNzdX+0YfcwNkYs22yPGBbBjNktJtMOe
 np3rp6oQ3OLLc5xXlLifCZV4CkCux2q0f0al1x1odNlZniJGqSzPV0YYSEf5Cz39
 a963ajqTtRnxiCeQh2vBRYypvbH0RCUaljLvXP9YoeHUDk3YG40CqnCyYGJikvuj
 AwQbtuMTLbrp7Nmq9PgSb50Dka2xAM6P1CLCurp5QzUpx7AGrq1mM/0LZXnDuW4d
 Y+KhLbeCOBWMMD8spVkuwdyfcAliYIpfwz68yOpsZyOCxuRFGecIyImrHLCoJoC2
 mo2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1651107858; x=1651194258; bh=EWQuBrshtflaBYZQbOQftY716qHgPAQrgs5
 xYJD0PZQ=; b=HN2J6N7ELnQR3Gy9fUmDvuEk9YlYKp9j7GPM2wWJGOlfvoLRYro
 qPxAJxQXaPAiCFUANedSSSTw6H7d23TRSskiqrtJ+sEsSBq3+a8XHJDBOcJoHFd7
 QUc0TV3p1g7bdK2v9lyV5qA9FcsV+xn8syFJQo8RdXd8iHf/C59/sp5DLVrRmomL
 RebZWUBp3uuLATt8lGTZRx4HRMUI5Fq9kxiLOcZ1BzlkB34tsPzHuND4M9OCPqEX
 gurem5f3Z/74dn2SHEMHIDVkSuqkdCTQJCTZYy8LRl3EV7SVB9z+2aXBkfyGcOtV
 Ve5zqxdiy/bGIjDnOBKmfMTMllDYbEaYB0A==
X-ME-Sender: <xms:EuhpYiffe1DAaWEuU_68hMUOBvbCoui-fcIL1RS2YG0nVIiGRlauZA>
 <xme:EuhpYsMpJWFJo0J0ehGz_Ii_rQr8oLWQsgQk9ozuccLjyIapi2z0cLOKXiFzGlszg
 eADy8XQY9N25tVVZg>
X-ME-Received: <xmr:EuhpYjhSfFHsGZ9OUA-7tBa6NWIdm7Icl5arTlUJOxHwV-VGhyRF1QzLUyiCCB8FIcTcUZrp5pCukFkB1F4bWpzEGG9_osOF49FghfEr2aP-_ZdGdojfqyBwn3eS2Uek5Q0Fag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigdegfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
 feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:EuhpYv-9UAS85yEzxjAya6_MNmWfVVLGaDvoLZeI8-PENgg-cMupMg>
 <xmx:EuhpYuvDa-YXf4W-vmvlhT17qVRPnqantOu7Lb8H9GlVebkFWL3ilw>
 <xmx:EuhpYmEpctWVjsxcZdxljjMhExeISxNIc93WvPZSXSBMRyosXrkFWQ>
 <xmx:EuhpYqOvI53ClkFNLgbr8waNRaIs9DQ4WmvEDlRQaI5dyEhshxRHlQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Apr 2022 21:04:17 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 2/5] iommu/sun50i: Support variants without an external reset
Date: Wed, 27 Apr 2022 20:03:57 -0500
Message-Id: <20220428010401.11323-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428010401.11323-1-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 28 Apr 2022 02:02:11 +0000
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Maxime Ripard <mripard@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

The IOMMU in the Allwinner D1 SoC does not have an external reset line.

Only attempt to get the reset on hardware variants which should have one
according to the binding. And switch from the deprecated function to the
explicit "exclusive" variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/iommu/sun50i-iommu.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index c54ab477b8fd..ec07b60016d3 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -92,6 +92,10 @@
 #define NUM_PT_ENTRIES			256
 #define PT_SIZE				(NUM_PT_ENTRIES * PT_ENTRY_SIZE)
 
+struct sun50i_iommu_variant {
+	bool has_reset;
+};
+
 struct sun50i_iommu {
 	struct iommu_device iommu;
 
@@ -905,9 +909,14 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 
 static int sun50i_iommu_probe(struct platform_device *pdev)
 {
+	const struct sun50i_iommu_variant *variant;
 	struct sun50i_iommu *iommu;
 	int ret, irq;
 
+	variant = of_device_get_match_data(&pdev->dev);
+	if (!variant)
+		return -EINVAL;
+
 	iommu = devm_kzalloc(&pdev->dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
 		return -ENOMEM;
@@ -947,7 +956,8 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 		goto err_free_group;
 	}
 
-	iommu->reset = devm_reset_control_get(&pdev->dev, NULL);
+	if (variant->has_reset)
+		iommu->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(iommu->reset)) {
 		dev_err(&pdev->dev, "Couldn't get our reset line.\n");
 		ret = PTR_ERR(iommu->reset);
@@ -987,8 +997,12 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct sun50i_iommu_variant sun50i_h6_iommu = {
+	.has_reset = true,
+};
+
 static const struct of_device_id sun50i_iommu_dt[] = {
-	{ .compatible = "allwinner,sun50i-h6-iommu", },
+	{ .compatible = "allwinner,sun50i-h6-iommu", .data = &sun50i_h6_iommu },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun50i_iommu_dt);
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
