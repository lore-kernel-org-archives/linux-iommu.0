Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4FEC433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F73A401C5;
	Tue,  4 Jan 2022 15:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlNdjS5gKIiU; Tue,  4 Jan 2022 15:53:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B4D2400A8;
	Tue,  4 Jan 2022 15:53:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB2CEC002F;
	Tue,  4 Jan 2022 15:53:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95CDFC001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 848CF8267C
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aKns9C4C_dYj for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:53:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8628D82640
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:53:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 220F51F434D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641311606;
 bh=8YQxFbvnIvsl0bXf11gulFrkxkDU8PWus97Bhbnjwoc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=j/EV3NtSordrsTUj8H8TAxeAccfm0+fuX5BE6C5pnJw5aHba8HJThhaX3MUdwwZUM
 tGRsxyt2yOWiO9Zeqg0gVLU7vZ1IcO83FDPT2J9/sXrQ8NlfuL+6QYAhVtEKWeoChI
 CtIlAJQ8ZUZHiF0sGbhY5AuGs7hUYi5leuxd/a/PpYWMZaC1L53BfXB8vY4jlwzNUn
 DQnt+uCZoIPykQXAC/cPwZHnoALbQuCfZOLnIjYAGhN+6HKBwn0Hv+jWNzlIplM0rU
 CYld++ZTVbHnAk1jszWUuxpCObT9jBwP+h6xOGebqJxSIUP+GLZYTpLPXCWtl2v849
 U8nDWu23ObTKw==
Subject: Re: [PATCH v3 28/33] iommu/mediatek: Add bank_nr and bank_enable
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-29-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <48493504-8877-b78d-0476-118a8b1441e0@collabora.com>
Date: Tue, 4 Jan 2022 16:53:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-29-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, yen-chang.chen@mediatek.com,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 23/09/21 13:58, Yong Wu ha scritto:
> Prepare for supporting multi banks, Adds two variables in the plat_data:
> bank_nr: the bank number that this SoC support;
> bank_enable: list if the banks is enabled.
> 
> Add them for all the current SoC, bank_nr always is 1 and only
> bank_enable[0] is enabled.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 18 ++++++++++++++++++
>   drivers/iommu/mtk_iommu.h |  3 +++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index c139675d99e6..4ad85469f68f 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1134,6 +1134,8 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>   			NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
>   	.hw_list      = &m4ulist,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.bank_nr      = 1,
> +	.bank_enable  = {true},
>   	.iova_region  = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
> @@ -1144,6 +1146,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
>   	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN | WR_THROT_EN |
>   			 NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
>   	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
> +	.bank_nr       = 1,
> +	.bank_enable   = {true},
>   	.iova_region   = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
> @@ -1154,6 +1158,8 @@ static const struct mtk_iommu_plat_data mt8167_data = {
>   	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
>   			MTK_IOMMU_TYPE_MM,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.bank_nr      = 1,
> +	.bank_enable  = {true},
>   	.iova_region  = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
> @@ -1165,6 +1171,8 @@ static const struct mtk_iommu_plat_data mt8173_data = {
>   			HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
>   			MTK_IOMMU_TYPE_MM,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.bank_nr      = 1,
> +	.bank_enable  = {true},
>   	.iova_region  = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
> @@ -1174,6 +1182,8 @@ static const struct mtk_iommu_plat_data mt8183_data = {
>   	.m4u_plat     = M4U_MT8183,
>   	.flags        = RESET_AXI | MTK_IOMMU_TYPE_MM,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.bank_nr      = 1,
> +	.bank_enable  = {true},
>   	.iova_region  = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
> @@ -1185,6 +1195,8 @@ static const struct mtk_iommu_plat_data mt8192_data = {
>   			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE |
>   			  MTK_IOMMU_TYPE_MM,
>   	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
> +	.bank_nr        = 1,
> +	.bank_enable    = {true},
>   	.iova_region    = mt8192_multi_dom,
>   	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
>   	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
> @@ -1196,6 +1208,8 @@ static const struct mtk_iommu_plat_data mt8195_data_infra = {
>   	.flags            = WR_THROT_EN | DCM_DISABLE |
>   			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIe_SUPPORT,
>   	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
> +	.bank_nr	  = 1,
> +	.bank_enable      = {true},
>   	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
>   	.iova_region      = single_domain,
>   	.iova_region_nr   = ARRAY_SIZE(single_domain),
> @@ -1208,6 +1222,8 @@ static const struct mtk_iommu_plat_data mt8195_data_vdo = {
>   			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
>   	.hw_list        = &m4ulist,
>   	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
> +	.bank_nr	= 1,
> +	.bank_enable    = {true},
>   	.iova_region	= mt8192_multi_dom,
>   	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
>   	.larbid_remap   = {{2, 0}, {21}, {24}, {7}, {19}, {9, 10, 11},
> @@ -1221,6 +1237,8 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
>   			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
>   	.hw_list        = &m4ulist,
>   	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
> +	.bank_nr	= 1,
> +	.bank_enable    = {true},
>   	.iova_region	= mt8192_multi_dom,
>   	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
>   	.larbid_remap   = {{1}, {3}, {22, 0, 0, 0, 23}, {8},
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 881fade8d39a..dc0190edebf0 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -62,6 +62,9 @@ struct mtk_iommu_plat_data {
>   	struct list_head			*hw_list;
>   	unsigned int				iova_region_nr;
>   	const struct mtk_iommu_iova_region	*iova_region;
> +
> +	unsigned int        bank_nr;

As said in the review for patch 26/33, maybe this can be renamed as `num_banks`
instead... and also, this can be a `u8` to save some memory.

> +	bool                bank_enable[MTK_IOMMU_BANK_MAX];
>   	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
>   };
>   
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
