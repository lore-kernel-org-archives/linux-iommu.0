Return-Path: <SRS0=k9Qp=3L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C703DC2D0DB
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 12:59:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8713B2467F
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 12:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="TK7Swu1g";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hyJOoqRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8713B2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 574ED2039B;
	Wed, 22 Jan 2020 12:59:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jQiXtJOhBvzJ; Wed, 22 Jan 2020 12:59:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F135120348;
	Wed, 22 Jan 2020 12:59:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D140FC1796;
	Wed, 22 Jan 2020 12:59:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EB4DC0174
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 12:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6257C84854
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 12:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gq6DNtbZY+6C for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jan 2020 12:51:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B4CD184189
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 12:51:07 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id EAE79220A7;
 Wed, 22 Jan 2020 07:44:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Wed, 22 Jan 2020 07:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=fmwpTx6jswx4kvnYxowEmIfQd9
 MqmpuQXCivarwrIOU=; b=TK7Swu1g57HGuOJ3XeY2yFLXpgnYBZSP8L53rhcVrg
 v/Ui/A1cFNzNxnH+I3MF9KUzhHsbZc64n8xpEtcSatOOG1NK5S4SHs+5yVHiHTOa
 F4SKyIcnYvauhdljL+4zTV4T3LiEH1seGKgfuHVYOys/kxNBkNepWV0KsXiMwn7G
 ZX4w9+fm9A61wtz1sIkRXrqEpFwhQKj9Q/99Z+/49Ym2FOEGao03yqYtEUPfY4ZF
 Wx9YBF+cY7d+iKWHwuQDXh4YhbH9HghS1tQbLq7D4fi6u8XRFJpCV7ye3qMW/7vw
 74BHLtBLNleYLbZPq6UC2+7e4exbXbEohCN6UabQeV2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fmwpTx6jswx4kvnYx
 owEmIfQd9MqmpuQXCivarwrIOU=; b=hyJOoqRPpLaP2EQw/Wa6oCBAgXsBy6wNW
 AfTGz+/LRs1wMaIaSJh9HdV8ELAomAvC9UNBAcbmOPLlNL3NFNNx8TVniwG8kuRs
 zXmu+GUX0Y9p4xHty4l10Y0aJVeJXDvO+hW+aK52GMMMIm+h/l99O7VLk10ju3WY
 2DsuMpLG66BNW4dW7pyPS+X1UjfL3hE2t4yi/iPJTuuDzyVAtz5NTVgm7eXj3+JJ
 MI6X1+ilDPSPaebNvE0wYd5hHq+uUnSYXr0CvhKQjLla8YWKEy/KnqOYMUY16n6C
 44OZVBKcH/He80XTbnIdnR139RfsJ340TLYKQ1e433QVbuNOcCZjg==
X-ME-Sender: <xms:oUMoXnk0YthgklaU7_OPAPfenBFx7NYnr_Gn09AUViprpBD422JEPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgdegtdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucft
 ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrdekle
 drieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:oUMoXuqM0jifKtzLNqzFtQCXn3h-iOJJUk4cvaerv1d-AkTac0vDDQ>
 <xmx:oUMoXr2LFRwO54xoDD0Hn3_kPK_kqGGWXhyLEzO0BVNzsr38Z7mLjQ>
 <xmx:oUMoXpaqZonSrySMbDJCYc7duUBG_ypqIHu8ww_WE7W4Tx5PxEm7Mw>
 <xmx:okMoXuN6-QcMNjtAVak5BFSV0pOCphbcsEtl2UDMmic5ClCXkx8Brg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 54C0D3280062;
 Wed, 22 Jan 2020 07:44:17 -0500 (EST)
From: Maxime Ripard <maxime@cerno.tech>
To: Joerg Roedel <joro@8bytes.org>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 0/3] iommu: Add Allwinner H6 IOMMU driver
Date: Wed, 22 Jan 2020 13:44:06 +0100
Message-Id: <cover.b2a9e1507135d81e726fcbb65137665a7f0ab74f.1579696927.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 22 Jan 2020 12:59:04 +0000
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

Hi,

Here's a series adding support for the IOMMU introduced in the Allwinner
H6. The driver from Allwinner hints at more SoCs using it in the future
(with more masters), so we can bet on that IOMMU becoming pretty much
standard in new SoCs from Allwinner.

One thing I wasn't really sure about was how to expose the statistics
reported by the IOMMU PMU (TLB hit rates, latencies, and so on). The
Allwinner driver exposes them through custom sysfs files, while they would
be best represented through perf I guess? Anyway, I'm planning to support
them later on.

Let me know what you think,
Maxime

Maxime Ripard (3):
  dt-bindings: iommu: Add Allwinner H6 IOMMU bindings
  iommu: Add Allwinner H6 IOMMU driver
  arm64: dts: allwinner: h6: Add IOMMU

 Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml |   61 ++++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                           |   11 +-
 drivers/iommu/Kconfig                                                  |   10 +-
 drivers/iommu/Makefile                                                 |    1 +-
 drivers/iommu/sun50i-iommu.c                                           | 1126 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 1209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/allwinner,sun50i-h6-iommu.yaml
 create mode 100644 drivers/iommu/sun50i-iommu.c

base-commit: e42617b825f8073569da76dc4510bfa019b1c35a
-- 
git-series 0.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
