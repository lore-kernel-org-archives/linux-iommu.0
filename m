Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335A5C43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 13:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C200441A4C;
	Wed, 22 Jun 2022 13:45:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C200441A4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X0JWlPE6Dzsy; Wed, 22 Jun 2022 13:45:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4A00741C0A;
	Wed, 22 Jun 2022 13:45:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A00741C0A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20823C0032;
	Wed, 22 Jun 2022 13:45:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AE21C002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 13:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 35CAC82848
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 13:45:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35CAC82848
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fwLo-A7rrCKf for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 13:45:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91A098274E
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91A098274E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 13:45:00 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 8C22F2D0; Wed, 22 Jun 2022 15:44:57 +0200 (CEST)
Date: Wed, 22 Jun 2022 15:44:56 +0200
From: Joerg Roedel <joro@8bytes.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 0/5] mtk_iommu: Specify phandles to infracfg and pericfg
Message-ID: <YrMc2EUBDIxnoWiB@8bytes.org>
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 miles.chen@mediatek.com, matthias.bgg@gmail.com, will@kernel.org
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

On Thu, Jun 16, 2022 at 01:08:25PM +0200, AngeloGioacchino Del Regno wrote:
> AngeloGioacchino Del Regno (5):
>   dt-bindings: iommu: mediatek: Add mediatek,infracfg phandle
>   iommu/mediatek: Lookup phandle to retrieve syscon to infracfg
>   arm64: dts: mediatek: mt8173: Add mediatek,infracfg phandle for IOMMU
>   arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
>   iommu/mediatek: Cleanup pericfg lookup flow
> 
>  .../bindings/iommu/mediatek,iommu.yaml        | 17 +++++++
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi     |  2 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  1 +
>  drivers/iommu/mtk_iommu.c                     | 50 +++++++++++--------
>  4 files changed, 49 insertions(+), 21 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
