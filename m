Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CD3C43217
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 02:02:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4B35404F9;
	Thu, 28 Apr 2022 02:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uL45nVfVw2Xl; Thu, 28 Apr 2022 02:02:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E76F94087D;
	Thu, 28 Apr 2022 02:02:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F13F8C008B;
	Thu, 28 Apr 2022 02:02:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1B47C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC58340159
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sholland.org header.b="Qa28EnWD";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="Ctd+nXjD"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X1KyQxgDn_Qc for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 01:10:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 185CF403A4
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:10:48 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 33D725C01FE;
 Wed, 27 Apr 2022 21:04:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 27 Apr 2022 21:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:sender:subject:subject:to:to;
 s=fm2; t=1651107854; x=1651194254; bh=0qHdH/aUtGspfDKe2hAdz5hp/
 F+OiM7JmLMvDU3bPw4=; b=Qa28EnWDuDVWE2ISFELEF+hZAOOuNnx4LInuXphKn
 H1tjGCJMYJ0jM/tdY9JPWkv4EEXHipesTIpusxShqL5Lopwb0PXAU145bMomsQcV
 Tj6TeXWwGyIY+rbKE+ESln/OoadnhFtIv1YNhF7PlifvZ23JCBBdjQ9KNeWe1QNf
 9XUy88nvNi0nOSHLpynCXXITZ+0LsDoEtOwOGUgUIFpughHOz/kQJTrbB53H5LHZ
 7YV4Ms6ryf9DMCIYHflnD2nCOdGQzHiGfMRC8scneBfqwGsI87apyefWfE85in+e
 SgWpryrnxXYG3BzRnAMvn7nUtzymaekqmATypbmMZSZ+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:sender
 :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1651107854; x=1651194254; bh=0
 qHdH/aUtGspfDKe2hAdz5hp/F+OiM7JmLMvDU3bPw4=; b=Ctd+nXjDrJF93m8q9
 4884fI2HuMUVHTvS6OtjPjdMMxeb0mEmgV+TPRLvLGtsNoMHC24RE20Q/TEGsSoY
 QFfblIOpzH/qMYi5r3gfDnm3PmPX6XpUsDamHP+avlKHe4j9XcWJN2FWi4k+Mq0j
 Jo5YlPsa7Ir6PrLSU6UDHIj8fARHn+K7jhmKduNWNgq7JM1enqBIVXtwBLGxjHji
 Go30TSjwQdbzeWCc7ImiTjnnBXpPyPpYZwaj5SXmaDLNYqYwzm9X5mWC3ItSxd4s
 Pw6m9R86aXO7vTHKkaMiN+XSwdY6UM4snaHfMlkE/u1/mhoGVDnDPI5N/2ke9gSY
 prpOw==
X-ME-Sender: <xms:DehpYgeX_6qKGPT47LkRTAxskuWuvflZBFo8DTLOIZ-wqmhlam6w4g>
 <xme:DehpYiO07QSZn8XPFn0EvZb7XC4Qi6XFx6zmqkGJ6xUrfUZgPgv9zs8-XIBGdBy1k
 pjW5SuWE-tIoXJgHQ>
X-ME-Received: <xmr:DehpYhh9sQrossGblUCj8_sceKYCBQz42FGoOTKrRbV4nznjL6SWjCxThwgAaAPy3U5mQ-7yfnqvOy_K6G5vMgyBw2WHvhc3Mhk_vvQtKVcNndjCOYPigrF5yF8Bma6PUKM5Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigdegfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
 jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
 htthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheelvddv
 fffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
 ohhrgh
X-ME-Proxy: <xmx:DehpYl8_-WowG7fkI6O-QXUCLtoSPUeqfwvx8KHTQSYsO4MaDGM6UA>
 <xmx:DehpYssZ54RJ-1okNWK10aSS7CN9KCr8SDVPpimMJoicfMXN6PY26w>
 <xmx:DehpYsH5nIk5ujCBidCy3LPs5K6a206BePOBxlCcgNme2XlsqWsTuA>
 <xmx:DuhpYgN-GY3Ca7ikOxOHItuiVkzGBL_JVDGjnAqDaVj1oL-3ZbcVAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Apr 2022 21:04:12 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 0/5] iommu/sun50i: Allwinner D1 support
Date: Wed, 27 Apr 2022 20:03:55 -0500
Message-Id: <20220428010401.11323-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

D1 is a RISC-V SoC from Allwinner's sunxi family. This series adds IOMMU
binding and driver support.

One piece is still missing to use the IOMMU for DMA allocations: a call
to iommu_setup_dma_ops(). On ARM64 this is handled by the architecture's
code. RISC-V does not currently select ARCH_HAS_SETUP_DMA_OPS, but it
will once Zicbom support[1] is merged.

[1]: https://lore.kernel.org/lkml/20220307224620.1933061-2-heiko@sntech.de/

So I cannot follow virtio-iommu.c and call iommu_setup_dma_ops() when
ARCH_HAS_SETUP_DMA_OPS=n. However, if I apply the following patch on top
of Heiko's non-coherent DMA series, the display engine successfully uses
the IOMMU to allocate its framebuffer:

--- a/arch/riscv/mm/dma-noncoherent.c
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -6,6 +6,7 @@
  */

 #include <linux/dma-direct.h>
+#include <linux/dma-iommu.h>
 #include <linux/dma-map-ops.h>
 #include <linux/mm.h>

@@ -53,4 +54,7 @@
 {
 	/* If a specific device is dma-coherent, set it here */
 	dev->dma_coherent = coherent;
+
+	if (iommu)
+		iommu_setup_dma_ops(dev, dma_base, dma_base + size - 1);
 }


Samuel Holland (5):
  dt-bindings: iommu: sun50i: Add compatible for Allwinner D1
  iommu/sun50i: Support variants without an external reset
  iommu/sun50i: Ensure bypass is disabled
  iommu/sun50i: Add support for the D1 variant
  iommu/sun50i: Ensure the IOMMU can be used for DMA

 .../iommu/allwinner,sun50i-h6-iommu.yaml      | 16 +++++++++++--
 drivers/iommu/Kconfig                         |  1 +
 drivers/iommu/sun50i-iommu.c                  | 24 +++++++++++++++++--
 3 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
