Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15FFC433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 08:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C44F416EE;
	Wed,  4 May 2022 08:40:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pkyoFOPqVoL2; Wed,  4 May 2022 08:40:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 04A7B416EA;
	Wed,  4 May 2022 08:40:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3A2DC0039;
	Wed,  4 May 2022 08:40:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF5FAC0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4FB6404A6
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3U__nrDnYqke for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:40:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27BFF40004
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:40:11 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C65FF7EE; Wed,  4 May 2022 10:40:08 +0200 (CEST)
Date: Wed, 4 May 2022 10:40:07 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v7 00/36] MT8195 and MT8186 IOMMU SUPPORT
Message-ID: <YnI751zEqTjrVuuz@8bytes.org>
References: <20220503071427.2285-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220503071427.2285-1-yong.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, chengci.xu@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, yen-chang.chen@mediatek.com,
 xueqi.zhang@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 libo.kang@mediatek.com, yf.wang@mediatek.com,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 mingyuan.ma@mediatek.com, linux-arm-kernel@lists.infradead.org,
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

On Tue, May 03, 2022 at 03:13:51PM +0800, Yong Wu wrote:
> Yong Wu (36):
>   dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
>   dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
>   dt-bindings: mediatek: mt8186: Add binding for MM iommu
>   iommu/mediatek: Fix 2 HW sharing pgtable issue
>   iommu/mediatek: Add list_del in mtk_iommu_remove
>   iommu/mediatek: Remove clk_disable in mtk_iommu_remove
>   iommu/mediatek: Add mutex for m4u_group and m4u_dom in data
>   iommu/mediatek: Add mutex for data in the mtk_iommu_domain
>   iommu/mediatek: Adapt sharing and non-sharing pgtable case
>   iommu/mediatek: Add 12G~16G support for multi domains
>   iommu/mediatek: Add a flag DCM_DISABLE
>   iommu/mediatek: Add a flag STD_AXI_MODE
>   iommu/mediatek: Remove the granule in the tlb flush
>   iommu/mediatek: Always enable output PA over 32bits in isr
>   iommu/mediatek: Add SUB_COMMON_3BITS flag
>   iommu/mediatek: Add IOMMU_TYPE flag
>   iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
>   iommu/mediatek: Adjust device link when it is sub-common
>   iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for PCIe VFIO
>   iommu/mediatek: Add a PM_CLK_AO flag for infra iommu
>   iommu/mediatek: Add infra iommu support
>   iommu/mediatek: Add PCIe support
>   iommu/mediatek: Add mt8195 support
>   iommu/mediatek: Only adjust code about register base
>   iommu/mediatek: Just move code position in hw_init
>   iommu/mediatek: Separate mtk_iommu_data for v1 and v2
>   iommu/mediatek: Remove mtk_iommu.h
>   iommu/mediatek-v1: Just rename mtk_iommu to mtk_iommu_v1
>   iommu/mediatek: Add mtk_iommu_bank_data structure
>   iommu/mediatek: Initialise bank HW for each a bank
>   iommu/mediatek: Change the domid to iova_region_id
>   iommu/mediatek: Get the proper bankid for multi banks
>   iommu/mediatek: Initialise/Remove for multi bank dev
>   iommu/mediatek: Backup/restore regsiters for multi banks
>   iommu/mediatek: mt8195: Enable multi banks for infra iommu
>   iommu/mediatek: Add mt8186 iommu support

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
