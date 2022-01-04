Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C98C433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05CE0827A1;
	Tue,  4 Jan 2022 15:53:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1dBx9AdIp1ng; Tue,  4 Jan 2022 15:53:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DBAA0826C1;
	Tue,  4 Jan 2022 15:53:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA5B2C002F;
	Tue,  4 Jan 2022 15:53:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0926EC002F
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB3EF60BCD
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3gN7Lql0w8D for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:53:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0BE5E60D4B
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:53:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 685021F43357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641311613;
 bh=etlSM6VB5MxHbZTJd9UvJfLL4RdTyNPoiYPo1cTbATg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=J6a6ulZPvPKM2N8IbrLr0WJIO8mDGduTQ1BGF+bMHMLw8T0ajFGaeE2dGrLzrIzOy
 UJMwkLj090B++b67Ar3nMQ1BRv6I7CWmS0uM/Qb4k5xKzFF0DdHpPIR53Nmy0tc3Ir
 UyGt8/F56U0kYGWLPecGx1dQNuGqqUtYYwyD23Y2mDlwvoKgvHFWYg5fd79iZRxAk0
 8gmA/OxGdXRvTduNPHdc0FjUf/OD/HhNUgD+bt5foLznN8C5vbyszWX0d7xdYnkk2O
 I/GyN0/316Kg1/1TtUgbA/Oz/j9hH2f3gzCE6CC1mRP8KCBVx0m4E71tLxjXCjMP46
 4Z66TRPXq4zzQ==
Subject: Re: [PATCH v3 32/33] iommu/mediatek: Backup/restore regsiters for
 multi banks
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-33-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <aa3bdf14-582c-2636-cdd4-cec2013d2b10@collabora.com>
Date: Tue, 4 Jan 2022 16:53:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-33-yong.wu@mediatek.com>
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
> Each bank has some independent registers. thus backup/restore them for
> each a bank when suspend and resume.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 39 +++++++++++++++++++++++++++------------
>   drivers/iommu/mtk_iommu.h | 14 +++++++++++---
>   2 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 3925d1d4f2cf..3cb18ed28132 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1114,16 +1114,23 @@ static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
>   {
>   	struct mtk_iommu_data *data = dev_get_drvdata(dev);
>   	struct mtk_iommu_suspend_reg *reg = &data->reg;
> -	void __iomem *base = data->bank[0].base;
> +	void __iomem *base;
> +	int i = 0;
>   
> +	base = data->bank[i].base;
>   	reg->wr_len_ctrl = readl_relaxed(base + REG_MMU_WR_LEN_CTRL);
>   	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
>   	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM_DIS);
>   	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
> -	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
> -	reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
> -	reg->ivrp_paddr = readl_relaxed(base + REG_MMU_IVRP_PADDR);
>   	reg->vld_pa_rng = readl_relaxed(base + REG_MMU_VLD_PA_RNG);
> +	do {
> +		if (!data->plat_data->bank_enable[i])
> +			continue;
> +		base = data->bank[i].base;
> +		reg->int_control[i] = readl_relaxed(base + REG_MMU_INT_CONTROL0);
> +		reg->int_main_control[i] = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
> +		reg->ivrp_paddr[i] = readl_relaxed(base + REG_MMU_IVRP_PADDR);
> +	} while (++i < data->plat_data->bank_nr);
>   	clk_disable_unprepare(data->bclk);
>   	return 0;
>   }
> @@ -1132,9 +1139,9 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>   {
>   	struct mtk_iommu_data *data = dev_get_drvdata(dev);
>   	struct mtk_iommu_suspend_reg *reg = &data->reg;
> -	struct mtk_iommu_domain *m4u_dom = data->bank[0].m4u_dom;
> -	void __iomem *base = data->bank[0].base;
> -	int ret;
> +	struct mtk_iommu_domain *m4u_dom;
> +	void __iomem *base;
> +	int ret, i = 0;
>   
>   	ret = clk_prepare_enable(data->bclk);
>   	if (ret) {
> @@ -1157,18 +1164,26 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>   	 * Uppon first resume, only enable the clk and return, since the values of the
>   	 * registers are not yet set.
>   	 */
> -	if (!m4u_dom)
> +	if (!reg->wr_len_ctrl)
>   		return 0;
>   
> +	base = data->bank[i].base;
>   	writel_relaxed(reg->wr_len_ctrl, base + REG_MMU_WR_LEN_CTRL);
>   	writel_relaxed(reg->misc_ctrl, base + REG_MMU_MISC_CTRL);
>   	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
>   	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
> -	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
> -	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
> -	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
>   	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
> -	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base + REG_MMU_PT_BASE_ADDR);
> +	do {
> +		m4u_dom = data->bank[i].m4u_dom;
> +		if (!data->plat_data->bank_enable[i] || !m4u_dom)
> +			continue;
> +		base = data->bank[i].base;
> +		writel_relaxed(reg->int_control[i], base + REG_MMU_INT_CONTROL0);
> +		writel_relaxed(reg->int_main_control[i], base + REG_MMU_INT_MAIN_CONTROL);
> +		writel_relaxed(reg->ivrp_paddr[i], base + REG_MMU_IVRP_PADDR);
> +		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> +		       base + REG_MMU_PT_BASE_ADDR);
> +	} while (++i < data->plat_data->bank_nr);
>   	return 0;
>   }
>   
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index cf4b3d10cf2c..e781ad583131 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -33,11 +33,19 @@ struct mtk_iommu_suspend_reg {
>   	};
>   	u32				dcm_dis;
>   	u32				ctrl_reg;
> -	u32				int_control0;
> -	u32				int_main_control;
> -	u32				ivrp_paddr;
>   	u32				vld_pa_rng;
>   	u32				wr_len_ctrl;
> +	union {
> +		struct { /* only for gen1 */
> +			u32		int_control0;
> +		};
> +
> +		struct { /* only for gen2 that support multi-banks */
> +			u32		int_control[MTK_IOMMU_BANK_MAX];
> +			u32		int_main_control[MTK_IOMMU_BANK_MAX];
> +			u32		ivrp_paddr[MTK_IOMMU_BANK_MAX];
> +		};
> +	};

There's no need for yet another union... just update mtk_iommu_v1.c to use
int_control[0] instead of int_control0.

>   };
>   
>   enum mtk_iommu_plat {
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
