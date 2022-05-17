Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190CBC433FE
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 13:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA80B6119D;
	Tue, 17 May 2022 13:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 77AlA4RvZcp2; Tue, 17 May 2022 13:21:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C031D61127;
	Tue, 17 May 2022 13:21:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EFF1C0086;
	Tue, 17 May 2022 13:21:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95C47C0032
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 13:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D95760FA6
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 13:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V910LUA_qIlG for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 13:21:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7F5761127
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 13:21:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id BEE6B1F433FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652793679;
 bh=wExmkwG26MlgAOyGVtuHJ9fB7p/HupGT2oLsUu37GPQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aZBoDF7S6WLjXzn71iCMIL/V+Lycg10Qf7ZK8Ug7yKiDvZZ5tyETWVCdqn6xklQJ+
 CXOSXUk3mZsGhMY/unAz9RgNyzAo7PIM3EB699GyOr0TaimNnoA48fYU8x0SZbt+6B
 gx2mLb0fQbQJ+mw4kkyzJXv8r5DNPar9Folgy/+CyM4SQe4rRQdpgNSja0B96wxFqh
 Gry+R2j5QUj5dMUIbszjkpPGKH037OQv8IGSdhWH/HvRcTBikY0/vPlmY5GeaQHmCb
 NOwxzv7phBvnhQJhpX64+n6enj3E1Gnzq9uTZyi0BJg8kb05E2Rw2r/tq5ItHHRkXo
 veS3kWTfmVYDg==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Subject: [PATCH 8/8] dt-bindings: iommu: mediatek: Require mediatek,
 pericfg for mt8195-infra
Date: Tue, 17 May 2022 15:21:07 +0200
Message-Id: <20220517132107.195932-9-angelogioacchino.delregno@collabora.com>
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

The MT8195 SoC has IOMMU related registers in the pericfg_ao iospace:
require a phandle to that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Note for Rob: as of now, there's no iommu node in upstream mt8195 devicetrees yet.

 .../devicetree/bindings/iommu/mediatek,iommu.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 17d78b17027a..2441c2e8e55d 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -187,6 +187,16 @@ allOf:
       required:
         - mediatek,infracfg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8195-iommu-infra
+
+    then:
+      required:
+        - mediatek,pericfg
+
   - if: # The IOMMUs don't have larbs.
       not:
         properties:
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
