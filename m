Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195E7F;
	Tue,  3 Jan 2023 01:09:25 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 7CE103200900;
	Mon,  2 Jan 2023 20:09:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 02 Jan 2023 20:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
	cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1672708163; x=1672794563; bh=kZ
	sTHUFAGL+nV4DJ8yYJfUo1prfIfeItgnkARi0XucI=; b=I7sS11A2fNj9GnEtLL
	di2WxTbt2fNqMvmw2JjUkrMMjEGSpUzNj0K6KEkITQSRDIkVAuPjbAPS+s22k7aS
	tfsAgV+9rhwz0OsKtDzaywoFQ5TzYWohtV7IcdmmfJ9PBxrpvEfzw2dj6Y0RjFQ0
	xKrmbQXuOfVFjpqqddgqlSYwYv48DCLF3OhNx9Cqrh5HIE0Fu/auiua9PE/6y3ij
	NjLCren3eo0hKw48PTujzcAXpGXQTe6pCInodtiy9FRNN4bE6LE/fMHgbziM9i8d
	6AGjT2p29+wbfJoj8BJupdBGZM/XTeq82N9bNT1VH0iEqrJqlich4l1ZcpQl8O5w
	sn4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1672708163; x=1672794563; bh=kZsTHUFAGL+nV
	4DJ8yYJfUo1prfIfeItgnkARi0XucI=; b=eX3XuWrX8cm2ftUAKF2gxfelvft5x
	+bjA9gM3kX1V3S39zQtE/PSsqVvhgCHtNInNIuAupyq8jd9GND0d6sxcO9oRLsOd
	GdhKOW9EkeaQFXtKCwYD/eDqIKQpds2sk9gqSH9cjeU5OT4xyyLjM/gYZQtHjCKv
	yF3RlSodYhmfUzGHzVPp1eMl753ra/d/PzadFj3FoI8BwDQb9WEz6yvxhDOoI3AT
	fT6cvdtMMTy9IioN9e1FDX33JWlKHwEn8OmARDTeKDprdkQTwLcmnr98k16P7Ucm
	Y0r/8BUpfPugtHovwcL1DwCsYtF21e58T31Gyj7TRdFjrPvsPSZIIgbTw==
X-ME-Sender: <xms:QoCzYy9TDq9iWF74Sx08Jj2X5BtMYIMHwLJ1M1B8URilJFRNm4b5BQ>
    <xme:QoCzYyvBHyEduguIVDOllusGjDcbo7ASoqRWSJbHTvhjKp2BuOI9oGLcqdtrhaTfQ
    3890VFvM-40RxOqbQ>
X-ME-Received: <xmr:QoCzY4A5Fve0aixke3s71sd1_EuxU27lvm4JErr237ULCze1afkHGrLHs5WYeMBRilmDedcNCL5c-gPJYAoamyShrscsj6WWNzVs_jXkC4yAIi7d7540CIbLg93qwre6U7o20A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Q4CzY6fnAnPQYSmjSVqj0oY1bDJrW05uOYRKGtJzWq6ND-MRD5oqLA>
    <xmx:Q4CzY3NwlDA12CGwmQrotGqdECTzqEqAPp1y6_9CVDtCaKCG0zDzyw>
    <xmx:Q4CzY0nPJfHDUPdYMp8jdKHk0YFpAWOas1q1Bs2YLhkxhollMohmUA>
    <xmx:Q4CzY7kGlOpZCnM6B36tC02s93AE8msh-NalISTYKpsC4WQoVph1bw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 20:09:22 -0500 (EST)
From: Samuel Holland <samuel@sholland.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 6/6] riscv: dts: allwinner: d1: Add the IOMMU node
Date: Mon,  2 Jan 2023 19:09:03 -0600
Message-Id: <20230103010903.11181-7-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230103010903.11181-1-samuel@sholland.org>
References: <20230103010903.11181-1-samuel@sholland.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

D1 contains an IOMMU for its video-related hardware. Add the node, and
hook it up to the masters which are already described in the devicetree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - New patch for v2

 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index dff363a3c934..ade50f1e01a4 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -138,6 +138,14 @@ ccu: clock-controller@2001000 {
 			#reset-cells = <1>;
 		};
 
+		iommu: iommu@2010000 {
+			compatible = "allwinner,sun20i-d1-iommu";
+			reg = <0x2010000 0x10000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(64) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_IOMMU>;
+			#iommu-cells = <1>;
+		};
+
 		dmic: dmic@2031000 {
 			compatible = "allwinner,sun20i-d1-dmic",
 				     "allwinner,sun50i-h6-dmic";
@@ -574,6 +582,7 @@ mixer0: mixer@5100000 {
 				 <&display_clocks CLK_MIXER0>;
 			clock-names = "bus", "mod";
 			resets = <&display_clocks RST_MIXER0>;
+			iommus = <&iommu 2>;
 
 			ports {
 				#address-cells = <1>;
@@ -596,6 +605,7 @@ mixer1: mixer@5200000 {
 				 <&display_clocks CLK_MIXER1>;
 			clock-names = "bus", "mod";
 			resets = <&display_clocks RST_MIXER1>;
+			iommus = <&iommu 2>;
 
 			ports {
 				#address-cells = <1>;
-- 
2.37.4

