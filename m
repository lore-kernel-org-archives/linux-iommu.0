Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06534C4332F
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 10:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DC9D41A4F;
	Wed, 18 May 2022 10:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ftnzRDvuKc9U; Wed, 18 May 2022 10:05:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B51541A00;
	Wed, 18 May 2022 10:05:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1740DC0032;
	Wed, 18 May 2022 10:05:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10368C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F26A0611EC
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aEO-aTlIP2TF for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 10:05:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98E0760E1E
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:05:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 61ED61F44E08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652868312;
 bh=QldET8Tith6XpQTESLUFmBU4bL4nM1vDAby2xnsh/3s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OKHk/q8oiV3Jx3vURxCYvrr6N5xQTM4Rz6VneBa345wqTTsd7cyy706N9/c1Ef0LL
 Uo1pcr/J2bfK7IVi5S9JVpE/Nzf6FstsiVPOvRJl4MlMxGL3Ffaak2NLVO+DSIGoEY
 JuzIue3TVMTOZMsjQrkpI9Klyql3w06eO6Iz1ewjzOf5gReh2QeNyB+tIjoZ01uTu+
 RdSzpYgDrgYJ08oMFOboynMNmbYDJas7zfM/stIogyptfG2a+ilzRJAhVi84l5a61K
 Od5YBOeDWxAzgYZvKUQs10U5B9x8RW2k5FderWzNRBuPsanB3Bl88sZmBErSkoRv4z
 TMN2KNghaK3dA==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Subject: [PATCH v2 1/7] dt-bindings: iommu: mediatek: Add phandles for
 mediatek infra/pericfg
Date: Wed, 18 May 2022 12:04:57 +0200
Message-Id: <20220518100503.37279-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org,
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

Add properties "mediatek,infracfg" and "mediatek,pericfg" to let the
mtk_iommu driver retrieve phandles to the infracfg and pericfg syscon(s)
instead of performing a per-soc compatible lookup.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/iommu/mediatek,iommu.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 2ae3bbad7f1a..c4af41947593 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -101,6 +101,10 @@ properties:
     items:
       - const: bclk
 
+  mediatek,infracfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle to the mediatek infracfg syscon
+
   mediatek,larbs:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 1
@@ -112,6 +116,10 @@ properties:
       Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
       according to the local arbiter index, like larb0, larb1, larb2...
 
+  mediatek,pericfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle to the mediatek pericfg syscon
+
   '#iommu-cells':
     const: 1
     description: |
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
