Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C01DC433EF
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 10:05:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1C1F611E7;
	Wed, 18 May 2022 10:05:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OGSSSVred5aG; Wed, 18 May 2022 10:05:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BF80F611E6;
	Wed, 18 May 2022 10:05:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70E96C0083;
	Wed, 18 May 2022 10:05:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F71EC0032
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0618A41A41
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:05:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0t17HIgDShp for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 10:05:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD8AF41A00
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:05:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 8EE241F44E07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652868311;
 bh=U70cvP2/Lgt8lNyOqWL39jq+Fark+U7neoHz5F2M2Nw=;
 h=From:To:Cc:Subject:Date:From;
 b=IsAoTuF0LZAK/38ZusnqIkI10GGd2aWgxdN2rhyFkvOY3sbmzggDeRnYWAI6SbDSu
 ARC0oZ7uzAKHX27vDoS7ruoS1PWqv19s3xjNgagzfltsoJoxEwnlt9krLrIyuiHFtA
 W1CTf+5vhhtcu5bLxzlld4STZIHFdhy4fyYNrI6EDrOKNkmJwa1uFM9LvBqyqPBccP
 XnRtWgFvqjV1XeLyqQmiPp3KzW3TvugS98vL9sYxT8ECATIakSJ28M1nmHK/W+Bhh4
 y+fiK2jGk5YvAyqJN/bapRl105yVdat8KERFg8G1mNKQbiRToc6Qqn5wyKjN55r32X
 4HvGjdXoTvj5Q==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Subject: [PATCH v2 0/7] mtk_iommu: Specify phandles to infracfg and pericfg
Date: Wed, 18 May 2022 12:04:56 +0200
Message-Id: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

Changes in v2:
 - Squashed dt-bindings patches as suggested by Matthias
 - Removed quotes from infra/peri phandle refs
 - Changed dev_warn to dev_info in patches [2/7], [3/7]

AngeloGioacchino Del Regno (7):
  dt-bindings: iommu: mediatek: Add phandles for mediatek infra/pericfg
  iommu: mtk_iommu: Lookup phandle to retrieve syscon to infracfg
  iommu: mtk_iommu: Lookup phandle to retrieve syscon to pericfg
  arm64: dts: mediatek: mt8173: Add mediatek,infracfg phandle for IOMMU
  arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
  dt-bindings: iommu: mediatek: Require mediatek,infracfg for
    mt2712/8173
  dt-bindings: iommu: mediatek: Require mediatek,pericfg for
    mt8195-infra

 .../bindings/iommu/mediatek,iommu.yaml        | 30 +++++++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  2 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  1 +
 drivers/iommu/mtk_iommu.c                     | 66 ++++++++++++-------
 4 files changed, 75 insertions(+), 24 deletions(-)

-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
