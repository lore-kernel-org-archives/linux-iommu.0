Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7114BC433FE
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 13:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01DF661191;
	Tue, 17 May 2022 13:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GTdYYkwPK-5N; Tue, 17 May 2022 13:21:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E17EF6117C;
	Tue, 17 May 2022 13:21:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62570C0082;
	Tue, 17 May 2022 13:21:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BF4CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 13:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DCB360FA6
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 13:21:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6DdmOrXfLTxE for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:21:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73FDF61124
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 13:21:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id C94481F433FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652793673;
 bh=PV/c5CsQfIEeeK1hM+QeRKiJih/2FjYi3kjZiefnius=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FbaJmAgGCe4rbB7Isi1Deq0+sZu4HnAwVsOVzYvgyjc0lzSa+1eAGbdlEzNtP/cU0
 ajJjmmbxhCPuTdRzhI4o6sX/Dji+385KB8uRFWgxlqGGyeWyEHN36wxJdr7dX2FEVY
 9H9Gdh54JH9NRpRookRdVCLcE7cjDzGm3YUQGo7C3o4rJDQfaBMgcFKN9P0zEbLViT
 RwCSEf44skMDOYcWkthTAxfc1Tg9MLX9CguAwgHdp0Cw4dfZHSiAqY+aT7ekvz4g/M
 FgPb6F4oW9fZSN4A07DWbZM4Z0sYPU3d+wF54oPBbRM/nIELyQRPVysFBHOUv+JnWY
 je++8ZeN7B16w==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Subject: [PATCH 1/8] dt-bindings: iommu: mediatek: Add mediatek,
 infracfg phandle
Date: Tue, 17 May 2022 15:21:00 +0200
Message-Id: <20220517132107.195932-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

Add property "mediatek,infracfg" to let the mtk_iommu driver retrieve
a phandle to the infracfg syscon instead of performing a per-soc
compatible lookup.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 2ae3bbad7f1a..78c72c22740b 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -101,6 +101,10 @@ properties:
     items:
       - const: bclk
 
+  mediatek,infracfg:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: The phandle to the mediatek infracfg syscon
+
   mediatek,larbs:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 1
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
