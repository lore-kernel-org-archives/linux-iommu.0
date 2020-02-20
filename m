Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA44C11D1A
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 18:15:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA0324672
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 18:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="zrqAodOp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgmsgJ/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA0324672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cerno.tech
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5544D875B4;
	Thu, 20 Feb 2020 18:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dz+U6oL77iQp; Thu, 20 Feb 2020 18:15:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F4CD875AD;
	Thu, 20 Feb 2020 18:15:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 364D3C1D81;
	Thu, 20 Feb 2020 18:15:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1780BC013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 14299875AD
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:15:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fj0j67zD5Rc0 for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 18:15:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 06CFF86BCF
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 18:15:27 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 585E221E5B;
 Thu, 20 Feb 2020 13:15:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 20 Feb 2020 13:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=EO4iHaNxeieQg
 LG+TqEp9sUs9WIn/s4CrJUTMJBjELo=; b=zrqAodOpNdj3RUp2IZomKJmh1InYg
 DMIunaYe5pwFkSN/OH4Ai+zPqSZz1CAr3ifV+fLVrw+0mz+nuYaEe9cMdKp9tyo0
 Yqxv0nUPkF3AdMZ0bFmMulwH+p0g/fr6KbTqSHnpU9m3v8d6yOurE4jXBkyT7ai+
 vgfcEI1FccxP0gqit2UGJWpuvZnpD/hdBaxNxicsqQ7fNT56PwHScjNL/EcsMpxP
 71prnuPNmeJMIN0oD5Ndj6y+PxnmXpowIWaWll52n8FKVA5AE5tGeIjwmZm+XXd2
 PEOXxHtsdyDhbVPlGTHB4QTvt2pfxJ8go7AxsbopTLh+PP7UCRHK6I32g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=EO4iHaNxeieQgLG+TqEp9sUs9WIn/s4CrJUTMJBjELo=; b=WgmsgJ/Z
 QiEtmM4Vhn7AFskFoNxWrwLynxpIGfDQuuU+eWufiFZyi8Kfj5cqYXmA887NYTwr
 a7Qrp2FuT6DAzhG0DMcQVv7+HRHu7i91eQ5tC6InJ4t+WSayfYCbu/Lov8llIu9T
 Qo/Qi0CJyo4OAyFgCfHf+aye/RAWAMOKa0wX2xQ16ptSeFgKFzoT/V7jp6DXWL3S
 mHB8AJeAx9DYuQY2EvvThNE00u6Cauv/WDp3wbWOdME6LdkJ6zArJHfQF2o2OhxA
 EGG+mubs5UWZBp8nMx16EFf65/UPyQJnmBvsJ3Tp4ZANt6C0H6ZX4CFwcOOR3USj
 MiXwjlSCj7PvVQ==
X-ME-Sender: <xms:vsxOXmD_DXlqg-MRJQ-TFjnTVARVW0sWdrzqvhrfeqDJadCwrD6BjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgdduudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
 vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
 drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghi
 lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vsxOXtQlS2l-d4RUiFJYpaAyTw5fLRQ2WwP5b8Lv9GgymxKNoeruHA>
 <xmx:vsxOXpJdjdhXq6XXMqODEBwTrehRQ-Wiky4s0_o3eY3Hekd1es2Vxw>
 <xmx:vsxOXtZdPuhj9cGfKZHaV0HtBZDNtYaguuXcLD01keRny_wZDGAHpQ>
 <xmx:vsxOXpYIOC4sgdyyG8UsVTT5drBHzNrjBvckfOMvapPA3Ilfz9oV3w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr
 [90.89.68.76])
 by mail.messagingengine.com (Postfix) with ESMTPA id 0BC893280060;
 Thu, 20 Feb 2020 13:15:25 -0500 (EST)
From: Maxime Ripard <maxime@cerno.tech>
To: Joerg Roedel <joro@8bytes.org>, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <mripard@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2 4/4] drm/sun4i: mixer: Call of_dma_configure if there's an
 IOMMU
Date: Thu, 20 Feb 2020 19:15:16 +0100
Message-Id: <5ebdf117248c6189e7e4a2631a6681cf9909bd66.1582222496.git-series.maxime@cerno.tech>
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

The main DRM device is actually a virtual device so it doesn't have the
iommus property, which is instead on the DMA masters, in this case the
mixers.

Add a call to of_dma_configure with the mixers DT node but on the DRM
virtual device to configure it in the same way than the mixers.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 7c24f8f832a5..85b8930e334c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -372,6 +372,19 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	mixer->engine.ops = &sun8i_engine_ops;
 	mixer->engine.node = dev->of_node;
 
+	if (of_find_property(dev->of_node, "iommus", NULL)) {
+		/*
+		 * This assume we have the same DMA constraints for
+		 * all our the mixers in our pipeline. This sounds
+		 * bad, but it has always been the case for us, and
+		 * DRM doesn't do per-device allocation either, so we
+		 * would need to fix DRM first...
+		 */
+		ret = of_dma_configure(drm->dev, dev->of_node, true);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * While this function can fail, we shouldn't do anything
 	 * if this happens. Some early DE2 DT entries don't provide
-- 
git-series 0.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
