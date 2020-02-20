Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF5CC11D0C
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 18:15:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FAE2467A
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 18:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="iJ1MFhPk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFgmTXNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FAE2467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2C29D2153F;
	Thu, 20 Feb 2020 18:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RRpW6lnBj2c4; Thu, 20 Feb 2020 18:15:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0C3BB2152C;
	Thu, 20 Feb 2020 18:15:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9073C1D81;
	Thu, 20 Feb 2020 18:15:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7A29C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 947BD21519
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:15:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UjHN93fxuw5H for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 18:15:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by silver.osuosl.org (Postfix) with ESMTPS id 965AD2151F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:15:25 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 0800621F1E;
 Thu, 20 Feb 2020 13:15:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Thu, 20 Feb 2020 13:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=1BfdN/koG36m/
 f9DbPf89uTtUlItLarQ7BWkFlRXBOs=; b=iJ1MFhPkb8XKx37Q4eJJEYJFC4mxg
 TW+9XgktIv6sNoTdgGCpCmR43le3RIdOttSkYXwNPcP1XQLNh6jakyc4yLrccb1+
 T1LdPsVDBevSlP/9c4/3o0geAFBFKXYOEoeLckoPaq/E6NdNIl/7ReFYYzae6Ccm
 XRFt7jfMNElb+9LjGM75BZA3aj1Jnp31KL4v9XKq17fhMDfwpJUnbgjPc73Q/D47
 PaXndkO9Gy6t7lRwpv1AXBx2OBA7KgfVXOgEku1mkzTyE3htL6wegtyCL5KKNHvE
 pkgd2UzvqI5n93KHVy4Jeoqp4OBUE4Pj81/2BgcVknqbOhSB+onPF5Sxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=1BfdN/koG36m/f9DbPf89uTtUlItLarQ7BWkFlRXBOs=; b=ZFgmTXNq
 0Z77UeSd/q2WPKclmS+cia2i0YrtWEQ5p4SPcX8LTODbZBWIgeoc5nztzCzWPPiU
 8ysdEIk9nnaawWaViDRDMZ7HRZoPkyTsKCeS83kMUl4LHs6G7ijEKtHEyv5F1GKS
 XY0sVP80rDRvS139iBVRS2s0k7wZumdLvzfedPBtzSRdilfKmzR1G1ViHuOQMBpt
 CT4EfF7vFmvXJox9lVD1Pvs0iIdVfoh040ErM8PTEqXwfBSumHAnIS6eJDsXDxEg
 nkOBww9VqFejySAdHXJMYj3NJgTXE+3x+UMHv5JfM6tE3T7qVAYqsh+etX/4s8ru
 AHp/bs5sGZwE2A==
X-ME-Sender: <xms:vMxOXthaKzDQB2Ekf5FZFKGJJTw1v_ikjo8JDAhmbRlSs838l91hRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgdduudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
 drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vMxOXtP7MlV-ObceaIWIa4d0RoiicYXHB58zS2l6VHEi0qMbdING7g>
 <xmx:vMxOXg5JsXFv7B7DDQCUrYaBMQ1uoNLxEHv2KIpA5G7_d52N-SjYjQ>
 <xmx:vMxOXsm0swspw0daTL_WhGreioTi6uh9hEZYPYRIp7DP05iZujhU6w>
 <xmx:vcxOXnrr3_DifvpJHd49N-0scaAVWt1CbTW17IU-Le6QL0FTXL1Xvg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 97E5F3060C21;
 Thu, 20 Feb 2020 13:15:24 -0500 (EST)
From: Maxime Ripard <maxime@cerno.tech>
To: Joerg Roedel <joro@8bytes.org>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2 3/4] arm64: dts: allwinner: h6: Add IOMMU
Date: Thu, 20 Feb 2020 19:15:15 +0100
Message-Id: <435c75d9cbccbf32f501ea897775351a73e065f7.1582222496.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.a31c229a83f1d92e6928ae2adb70887da0fd44b3.1582222496.git-series.maxime@cerno.tech>
References: <cover.a31c229a83f1d92e6928ae2adb70887da0fd44b3.1582222496.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 Maxime Ripard <maxime@cerno.tech>, linux-arm-kernel@lists.infradead.org
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

Now that we have a driver for the IOMMU, let's start using it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 3329283e38ab..2d0777ad39aa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -131,6 +131,7 @@
 				clock-names = "bus",
 					      "mod";
 				resets = <&display_clocks RST_MIXER0>;
+				iommus = <&iommu 0>;
 
 				ports {
 					#address-cells = <1>;
@@ -370,6 +371,15 @@
 			#interrupt-cells = <3>;
 		};
 
+		iommu: iommu@30f0000 {
+			compatible = "allwinner,sun50i-h6-iommu";
+			reg = <0x030f0000 0x10000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_IOMMU>;
+			resets = <&ccu RST_BUS_IOMMU>;
+			#iommu-cells = <1>;
+		};
+
 		mmc0: mmc@4020000 {
 			compatible = "allwinner,sun50i-h6-mmc",
 				     "allwinner,sun50i-a64-mmc";
-- 
git-series 0.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
