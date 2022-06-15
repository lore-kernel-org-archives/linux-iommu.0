Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3BACCA473
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 12:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B561481026;
	Wed, 15 Jun 2022 12:09:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oDtx9aEUwVK4; Wed, 15 Jun 2022 12:09:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 85A3D80A6E;
	Wed, 15 Jun 2022 12:09:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D871C0032;
	Wed, 15 Jun 2022 12:09:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03DD9C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 12:09:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E785280DCB
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 12:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U_jLXLW3EtnL for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 12:09:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1275080A6E
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 12:09:54 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id o16so15103812wra.4
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:content-language:to:cc
 :references:from:subject:in-reply-to:content-transfer-encoding;
 bh=ufqEIhQJLn0a1lP22CtHnxpKmABhqIWqQFeboCEBeR8=;
 b=NNQJ/jGhKFi3TLolVvv6p5vDCUgaeZ2UDfX5QF22P23d0rNi2IA+3xgJlttCAlAbei
 rk6ebUX23qsziqFBje19orA87/iwUKsvIIxT1/tuq/V/zfiyuLMDGAhmMekYevaKip0L
 VFsqyo2qSHzhQaaVho66mGEdQ0v3EV+MXT2CiOUY0RceDlRJUVuTteYygqy1hEhOnhDy
 bDFcEuM9bSkckbpuY7bJcxBHX7aiGwNDqqmpKOCokXagegSOK3ZOIf+WH/TR6GhgAGAE
 JXb9yVmULvi4y4ygg6OY6k3egdNzz9CQUgXR20nHtdlWgf58B33lpzamh5904JHegno4
 8d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:subject:in-reply-to
 :content-transfer-encoding;
 bh=ufqEIhQJLn0a1lP22CtHnxpKmABhqIWqQFeboCEBeR8=;
 b=FygC8huEA9wiSGmEo83BSiGVQG9kkIGbf1Oh+rG/xBOnG4NJ2NmvcpHThh9RbSVuY7
 fDbrE/XAJEUgl0/LzE3xr/HdFM1jYU7DPKAmfvVVm1zpwKznM2aEWDbluPHgaXSesSqF
 Kuv5rI2SMWm3fEOgwxBKx8IvxcpiS4dpn7dwwDeQsLFagSy6dDE4QCSRlmba4Sp00NkG
 nxqWSPY5tt5nE5g8X3rK0cT4vVT/KB83Lu/Yn5Y5n0+xbvhw0egCEg3Zop0AQnFlrovq
 Y0oV5xBW4T703196eXDHOQKonsdlobfJF1tC8Ggz0yU9u8l1p20Va7iG7V7oHBKdzl3a
 /BmA==
X-Gm-Message-State: AJIora80XOrTiJH/UfKEN0Mo4OUciQk1KKiqslw5g7Iq1p/SGhaUb116
 tI1a0i5nY5DYJ9mWoHg0vfs=
X-Google-Smtp-Source: AGRyM1spOOsJofsOCL+iHFbSiA5IRU/CCTL1EBYYpqTyOZwOes1IVw6CJtdit0i26miabw44PN2cEg==
X-Received: by 2002:a05:6000:1542:b0:218:549a:2a8e with SMTP id
 2-20020a056000154200b00218549a2a8emr9738727wry.314.1655294992184; 
 Wed, 15 Jun 2022 05:09:52 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
 by smtp.gmail.com with ESMTPSA id
 64-20020a1c1943000000b0039c6390730bsm2249993wmz.29.2022.06.15.05.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jun 2022 05:09:51 -0700 (PDT)
Message-ID: <8b31b1d2-4ed7-11a1-2124-4641c8f3abcd@gmail.com>
Date: Wed, 15 Jun 2022 14:09:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 yong.wu@mediatek.com
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
In-Reply-To: <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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



On 09/06/2022 12:08, AngeloGioacchino Del Regno wrote:
> On some SoCs (of which only MT8195 is supported at the time of writing),
> the "R" and "W" (I/O) enable bits for the IOMMUs are in the pericfg_ao
> register space and not in the IOMMU space: as it happened already with
> infracfg, it is expected that this list will grow.
> 
> Instead of specifying pericfg compatibles on a per-SoC basis, following
> what was done with infracfg, let's lookup the syscon by phandle instead.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/mtk_iommu.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 90685946fcbe..0ea0848581e9 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -138,6 +138,8 @@
>   /* PM and clock always on. e.g. infra iommu */
>   #define PM_CLK_AO			BIT(15)
>   #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
> +/* IOMMU I/O (r/w) is enabled using PERICFG_IOMMU_1 register */
> +#define HAS_PERI_IOMMU1_REG		BIT(17)

 From what I can see MTK_IOMMU_TYPE_INFRA is only set in MT8195 which uses 
pericfg. So we don't need a new flag here. For me the flag name 
MTK_IOMMU_TYPE_INFRA was confusing as it has nothing to do with the use of 
infracfg. I'll hijack this patch to provide some feedback on the actual code, 
please see below.

>   
>   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>   				((((pdata)->flags) & (mask)) == (_x))
> @@ -187,7 +189,6 @@ struct mtk_iommu_plat_data {
>   	u32			flags;
>   	u32			inv_sel_reg;
>   
> -	char			*pericfg_comp_str;
>   	struct list_head	*hw_list;
>   	unsigned int		iova_region_nr;
>   	const struct mtk_iommu_iova_region	*iova_region;
> @@ -1218,14 +1219,16 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			goto out_runtime_disable;
>   		}
>   	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> -		   data->plat_data->pericfg_comp_str) {

Check for pericfg_comp_str is not needed, we only have one platform that uses 
MTK_IOMMU_TYPE_INFRA.

> -		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);

We can do something like this to make the code clearer:
data->pericfg = 
syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
		if (IS_ERR(data->pericfg)) {

Using infracfg variable here is confusing as it has nothing to do with infracfg 
used with HAS_4GB_MODE flag.

Regards,
Matthias

> -		if (IS_ERR(infracfg)) {
> -			ret = PTR_ERR(infracfg);
> -			goto out_runtime_disable;
> +		   MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_PERI_IOMMU1_REG)) {
> +		data->pericfg = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,pericfg");
> +		if (IS_ERR(data->pericfg)) {
> +			p = "mediatek,mt8195-pericfg_ao";
> +			data->pericfg = syscon_regmap_lookup_by_compatible(p);
> +			if (IS_ERR(data->pericfg)) {
> +				ret = PTR_ERR(data->pericfg);
> +				goto out_runtime_disable;
> +			}
>   		}
> -
> -		data->pericfg = infracfg;
>   	}
>   
>   	platform_set_drvdata(pdev, data);
> @@ -1484,8 +1487,8 @@ static const struct mtk_iommu_plat_data mt8192_data = {
>   static const struct mtk_iommu_plat_data mt8195_data_infra = {
>   	.m4u_plat	  = M4U_MT8195,
>   	.flags            = WR_THROT_EN | DCM_DISABLE | STD_AXI_MODE | PM_CLK_AO |
> -			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT,
> -	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
> +			    HAS_PERI_IOMMU1_REG | MTK_IOMMU_TYPE_INFRA |
> +			    IFA_IOMMU_PCIE_SUPPORT,
>   	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
>   	.banks_num	  = 5,
>   	.banks_enable     = {true, false, false, false, true},
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
