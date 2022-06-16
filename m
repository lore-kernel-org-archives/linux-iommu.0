Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D12C43334
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 11:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B0D260E53;
	Thu, 16 Jun 2022 11:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uI6-_s0Dbedq; Thu, 16 Jun 2022 11:08:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5CDFD61109;
	Thu, 16 Jun 2022 11:08:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C130C007A;
	Thu, 16 Jun 2022 11:08:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02CB0C002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 11:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E576D403AA
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 11:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YI6Iq2vh4TJO for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 11:08:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 040804011D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 11:08:40 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 686846601747;
 Thu, 16 Jun 2022 12:08:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1655377719;
 bh=mpK1TVAIqyX6YVJK1M8Os+7jR/kqhqwVYDvOvGIs95Y=;
 h=From:To:Cc:Subject:Date:From;
 b=Ch6RYiKtPc9VsSjhrKSnp0vU0dODz448sqD29I+hfp7tCSq5/Ms2LWSEmzwV9qCFj
 J3HRBsegQbwFFREW/xctKgGliHrhsNAX/hzS1NR+sNIfg8fXJAyVe/5fqZ0QKL4H6w
 5XeXjANUFC2PrvMdwicA55FIyaMoVZc5uBhj6yMPfuHVu2QLOLG3DQiFH1x0G5qPIF
 BI5vbbrHPn0UYp78uw+RtufGvAbSFKnCq94XwKZFtGPfhDMsIsH8I2XtydLwqLAW93
 sEfCtPjgq0vSZdfTOF91OsyzR9Jq+0/kn8QN0ufQW/4J25FJfL/V6d3ItuimOpVXZh
 R7/M9tiasr5gg==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Subject: [PATCH v4 0/5] mtk_iommu: Specify phandles to infracfg and pericfg
Date: Thu, 16 Jun 2022 13:08:25 +0200
Message-Id: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, miles.chen@mediatek.com,
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

The IOMMU has registers in the infracfg and/or pericfg iospaces: as
for the currently supported SoCs, MT2712 and MT8173 need a phandle to
infracfg, while MT8195 needs one to pericfg.

Before this change, the driver was checking for a SoC-specific infra/peri
compatible but, sooner or later, these lists are going to grow a lot...
...and this is why it was chosen to add phandles (as it was done with
some other drivers already - look at mtk-pm-domains, mt8192-afe

Please note that, while it was necessary to update the devicetrees for
MT8173 and MT2712e, there was no update for MT8195 because there is no
IOMMU node in there yet.

Changes in v4:
 - Dropped changes introducing mediatek,pericfg handle
 - Fixed required property in IOMMU example in patch [1/5]
 - Added a pericfg lookup flow cleanup commit

Changes in v3:
 - Different squashing of dt-bindings patches (sorry for misunderstanding!)
 - Removed legacy devicetree print

Changes in v2:
 - Squashed dt-bindings patches as suggested by Matthias
 - Removed quotes from infra/peri phandle refs
 - Changed dev_warn to dev_info in patches [2/7], [3/7]

AngeloGioacchino Del Regno (5):
  dt-bindings: iommu: mediatek: Add mediatek,infracfg phandle
  iommu/mediatek: Lookup phandle to retrieve syscon to infracfg
  arm64: dts: mediatek: mt8173: Add mediatek,infracfg phandle for IOMMU
  arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
  iommu/mediatek: Cleanup pericfg lookup flow

 .../bindings/iommu/mediatek,iommu.yaml        | 17 +++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  2 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  1 +
 drivers/iommu/mtk_iommu.c                     | 50 +++++++++++--------
 4 files changed, 49 insertions(+), 21 deletions(-)

-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
