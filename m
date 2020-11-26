Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBD4C56202
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 17:12:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED61206B5
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 17:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED61206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1881E87539;
	Thu, 26 Nov 2020 17:12:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zfmu1FigO6O1; Thu, 26 Nov 2020 17:12:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 351978752A;
	Thu, 26 Nov 2020 17:12:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A615C163C;
	Thu, 26 Nov 2020 17:12:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A535C0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 17:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1480587803
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 17:12:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id muo61LvaIzFQ for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 17:12:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id C43C18779F
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 17:12:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E7DB31B;
 Thu, 26 Nov 2020 09:12:06 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 472113F23F;
 Thu, 26 Nov 2020 09:12:02 -0800 (PST)
Subject: Re: [PATCH v4 17/24] iommu/mediatek: Add single domain
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Will Deacon <will@kernel.org>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-18-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <22e49f08-6d23-86cf-bb9c-79d54ce55beb@arm.com>
Date: Thu, 26 Nov 2020 17:11:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201111123838.15682-18-yong.wu@mediatek.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, kernel-team@android.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
 Greg Kroah-Hartman <gregkh@google.com>, linux-arm-kernel@lists.infradead.org
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

On 2020-11-11 12:38, Yong Wu wrote:
> Defaultly the iova range is 0-4G. here we add a single-domain(0-4G)
> for the previous SoC. this also is a preparing patch for supporting
> multi-domains.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bf3f4e0f4748..a7727a3899d1 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -161,6 +161,10 @@ struct mtk_iommu_iova_region {
>   	unsigned long long	size;
>   };
>   
> +static const struct mtk_iommu_iova_region single_domain[] = {
> +	{.iova_base = 0,		.size = SZ_4G},
> +};

Hang on, given how the previous patch works, surely this means you're 
now going to *reserve* the entire address space? That doesn't seem 
right... :/

Robin.

> +
>   /*
>    * There may be 1 or 2 M4U HWs, But we always expect they are in the same domain
>    * for the performance.
> @@ -922,6 +926,8 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>   	.m4u_plat     = M4U_MT2712,
>   	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.iova_region  = single_domain,
> +	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
>   };
>   
> @@ -929,6 +935,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
>   	.m4u_plat      = M4U_MT6779,
>   	.flags         = HAS_SUB_COMM | OUT_ORDER_WR_EN | WR_THROT_EN,
>   	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
> +	.iova_region   = single_domain,
> +	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
>   };
>   
> @@ -944,6 +952,8 @@ static const struct mtk_iommu_plat_data mt8173_data = {
>   	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
>   			HAS_LEGACY_IVRP_PADDR,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.iova_region  = single_domain,
> +	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
>   };
>   
> @@ -951,6 +961,8 @@ static const struct mtk_iommu_plat_data mt8183_data = {
>   	.m4u_plat     = M4U_MT8183,
>   	.flags        = RESET_AXI,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.iova_region  = single_domain,
> +	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
>   };
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
