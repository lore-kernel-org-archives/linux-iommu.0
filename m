Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE77C433E1
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 21:54:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDF52082E
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 21:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDF52082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D63FD8A395;
	Mon, 13 Jul 2020 21:54:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4IdK8t-lh6P0; Mon, 13 Jul 2020 21:54:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B79F58A36A;
	Mon, 13 Jul 2020 21:54:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A450EC08A0;
	Mon, 13 Jul 2020 21:54:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A86BC0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:40:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 353C08A11E
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:40:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rFzw4h55MpIx for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 21:40:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 746668A131
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:40:36 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.75,348,1589209200"; d="scan'208";a="51803356"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2020 06:35:34 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id C3C6E40F7FC8;
 Tue, 14 Jul 2020 06:35:30 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 2/9] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
Date: Mon, 13 Jul 2020 22:35:13 +0100
Message-Id: <1594676120-5862-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailman-Approved-At: Mon, 13 Jul 2020 21:53:59 +0000
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Prabhakar <prabhakar.csengg@gmail.com>,
 dmaengine@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Add support for RZ/G2H (R8A774E1) SoC IPMMUs.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iommu/ipmmu-vmsa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index b90cd9ff96f6..cbce88ac5a71 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -751,6 +751,7 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
 static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
 	{ .soc_id = "r8a774b1", },
 	{ .soc_id = "r8a774c0", },
+	{ .soc_id = "r8a774e1", },
 	{ .soc_id = "r8a7795", .revision = "ES3.*" },
 	{ .soc_id = "r8a77961", },
 	{ .soc_id = "r8a77965", },
@@ -963,6 +964,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
 	}, {
 		.compatible = "renesas,ipmmu-r8a774c0",
 		.data = &ipmmu_features_rcar_gen3,
+	}, {
+		.compatible = "renesas,ipmmu-r8a774e1",
+		.data = &ipmmu_features_rcar_gen3,
 	}, {
 		.compatible = "renesas,ipmmu-r8a7795",
 		.data = &ipmmu_features_rcar_gen3,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
