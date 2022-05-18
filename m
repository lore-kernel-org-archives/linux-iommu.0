Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A177C433EF
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 10:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF59841A16;
	Wed, 18 May 2022 10:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lW04oHjIeToC; Wed, 18 May 2022 10:17:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B56A404B6;
	Wed, 18 May 2022 10:17:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA2EC0032;
	Wed, 18 May 2022 10:17:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B87FEC002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8FFDD4012E
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tzWOlaH1Z5I4 for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 10:17:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B753840003
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:17:08 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id w4so1976003wrg.12
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=JDEZhGlxX3q41z2Qv8MwS9G1+Y1QFJKsUDzF/L6uQHk=;
 b=DqcZNdspyaqBHAVNilMYjZm+kFa4AMru817n+8jVHzW0BElL+LDpTda3Ji5Il/FCJM
 fQqtZPPjgg0bMjYCtLO/3GJPHY4BTrSKAU9RoaC9ooJhO4j7tXIhRZdCjv80NDNCpbB0
 cdPTa3dTI5LBOcj9Niid+ZBPaDJ/I2UuyCrgB9IpqklOOdEW7z5J4WSVOdS+l3aQL8ts
 Aur2p3ho/eYy0hogD3YUmsvTJMPJJVIfV5v/BiYxCVi2nfRriicrZ0u3xtMB4/+9ZeLh
 MDSzCEQ9M1kqpJf53btb2mwnoLmY5UMjyS6abKAV33bjU13/gjjRWR+Tdt63KjaR6ro1
 QPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JDEZhGlxX3q41z2Qv8MwS9G1+Y1QFJKsUDzF/L6uQHk=;
 b=NkYXu4s0BeI7q7kAxt6PCKst20Xy1uk8V9TfC2lAZ8XixhG1JsAkNgVUzCwawAoKGJ
 7LmNHIYv1+TGYaACPd9dFOUgsXTO2mg53RPXp0yT9Q5iskK08aN4JEC/8JzJq1PZ6jzq
 MD8Erd1no9YvSWMBnx8514ScCkz6rb8xsHvyZwxOID7an0SOgSsW6vhnbnStXA0awnDi
 WWpFcV3lkMbvyj1qJOrIlp+y/a4FkflI8HmgIKviOzBe/U9awefjVAhz8Mt60jYygqiw
 2NKmUwXFsgnVbcsvN0F8zbNjUpzpkH1AA2+JOK4Lltqy6LqULjI5//5mv3uRufNJ7Rma
 GvwQ==
X-Gm-Message-State: AOAM533ksFdL8nAAwtWFIsqPwPkP0p6t8YTkBmYjNTgKK8lUcJrjPzLo
 AeTvnR8jm89S3xb26EZ5p38=
X-Google-Smtp-Source: ABdhPJz50zZNy75WZIl5SLAdw28vWdjTJPUizP3Z3rcoOxsGrTac4hDC7TuNeWeo0hTCukYSkqg5zA==
X-Received: by 2002:adf:a3c2:0:b0:20c:fecc:8885 with SMTP id
 m2-20020adfa3c2000000b0020cfecc8885mr16733860wrb.463.1652869026824; 
 Wed, 18 May 2022 03:17:06 -0700 (PDT)
Received: from [192.168.0.36] ([5.225.216.194])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a05600c479300b003942a244edbsm1525822wmo.32.2022.05.18.03.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 May 2022 03:17:06 -0700 (PDT)
Message-ID: <33ef032c-8233-6f01-a064-e0564df0258d@gmail.com>
Date: Wed, 18 May 2022 12:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/8] iommu: mtk_iommu: Lookup phandle to retrieve syscon
 to pericfg
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 yong.wu@mediatek.com
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-5-angelogioacchino.delregno@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220517132107.195932-5-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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



On 17/05/2022 15:21, AngeloGioacchino Del Regno wrote:
> On some SoCs (of which only MT8195 is supported at the time of writing),
> the "R" and "W" (I/O) enable bits for the IOMMUs are in the pericfg_ao
> register space and not in the IOMMU space: as it happened already with
> infracfg, it is expected that this list will grow.
> 
> Instead of specifying pericfg compatibles on a per-SoC basis, following
> what was done with infracfg, let's lookup the syscon by phandle instead.
> Also following the previous infracfg change, add a warning for outdated
> devicetrees, in hope that the user will take action.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index cfaaa98d2b50..c7e2d836199e 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -138,6 +138,8 @@
>   /* PM and clock always on. e.g. infra iommu */
>   #define PM_CLK_AO			BIT(15)
>   #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
> +/* IOMMU I/O (r/w) is enabled using PERICFG_IOMMU_1 register */
> +#define HAS_PERI_IOMMU1_REG		BIT(17)
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
> @@ -1214,14 +1215,19 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			goto out_runtime_disable;
>   		}
>   	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
> -		   data->plat_data->pericfg_comp_str) {
> -		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
> -		if (IS_ERR(infracfg)) {
> -			ret = PTR_ERR(infracfg);
> -			goto out_runtime_disable;
> -		}
> +		   MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_PERI_IOMMU1_REG)) {
> +		data->pericfg = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,pericfg");
> +		if (IS_ERR(data->pericfg)) {
> +			dev_warn(dev, "Cannot find phandle to mediatek,pericfg:"
> +				      " Please update your devicetree.\n");
>   
> -		data->pericfg = infracfg;
> +			p = "mediatek,mt8195-pericfg_ao";
> +			data->pericfg = syscon_regmap_lookup_by_compatible(p);
> +			if (IS_ERR(data->pericfg)) {
> +				ret = PTR_ERR(data->pericfg);
> +				goto out_runtime_disable;
> +			}
> +		}
>   	}
>   
>   	platform_set_drvdata(pdev, data);
> @@ -1480,8 +1486,8 @@ static const struct mtk_iommu_plat_data mt8192_data = {
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
