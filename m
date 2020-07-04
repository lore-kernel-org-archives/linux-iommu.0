Return-Path: <SRS0=9BbX=AP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42914C433E1
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 01:16:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2122075D
	for <iommu@archiver.kernel.org>; Sat,  4 Jul 2020 01:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WH5S/C2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2122075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B2BE227205;
	Sat,  4 Jul 2020 01:16:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mJ5L8A+z7piL; Sat,  4 Jul 2020 01:16:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B7CC427191;
	Sat,  4 Jul 2020 01:16:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE25C088E;
	Sat,  4 Jul 2020 01:16:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C03BC0733
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 01:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 298D1884BF
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 01:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vREWA76VKwmx for <iommu@lists.linux-foundation.org>;
 Sat,  4 Jul 2020 01:16:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id EE70688491
 for <iommu@lists.linux-foundation.org>; Sat,  4 Jul 2020 01:16:48 +0000 (UTC)
X-UUID: 412854032bf64e50bdfb8009928ded50-20200704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=T1Dk7nQlgGGkbfMonA3Q9alxa/t5hffgX9wAPRQoUoI=; 
 b=WH5S/C2amh/rSe5qc+nFhFAD8yCxiYi+gHuMLW7UhoE2PkrBDacdIBXv1zhIjhfoXKBivSmqItCDWz7bx0zObf+tKXlTNHLBcg++Jm9ajgVFiydgGhQrWqGPSZ6VCWOczCK+sb8SpWXNJ/cIN7+kD2dSJrin8gjpzces9qUDn70=;
X-UUID: 412854032bf64e50bdfb8009928ded50-20200704
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <yingjoe.chen@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 77149489; Sat, 04 Jul 2020 09:16:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 4 Jul 2020 09:16:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 4 Jul 2020 09:16:38 +0800
Message-ID: <1593825398.4355.1.camel@mtksdaap41>
Subject: Re: [PATCH v6 03/10] iommu/mediatek: Use a u32 flags to describe
 different HW features
From: Yingjoe Chen <yingjoe.chen@mediatek.com>
To: Chao Hao <chao.hao@mediatek.com>
Date: Sat, 4 Jul 2020 09:16:38 +0800
In-Reply-To: <20200703044127.27438-4-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
 <20200703044127.27438-4-chao.hao@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, TH Yang <th.yang@mediatek.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>
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

On Fri, 2020-07-03 at 12:41 +0800, Chao Hao wrote:
> Given the fact that we are adding more and more plat_data bool values,
> it would make sense to use a u32 flags register and add the appropriate
> macro definitions to set and check for a flag present.
> No functional change.
> 
> Cc: Yong Wu <yong.wu@mediatek.com>
> Suggested-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/iommu/mtk_iommu.c | 28 +++++++++++++++++-----------
>  drivers/iommu/mtk_iommu.h |  7 +------
>  2 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 88d3df5b91c2..40ca564d97af 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -100,6 +100,15 @@
>  #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0xf)
>  #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
>  
> +#define HAS_4GB_MODE			BIT(0)
> +/* HW will use the EMI clock if there isn't the "bclk". */
> +#define HAS_BCLK			BIT(1)
> +#define HAS_VLD_PA_RNG			BIT(2)
> +#define RESET_AXI			BIT(3)
> +
> +#define MTK_IOMMU_HAS_FLAG(pdata, _x) \
> +		((((pdata)->flags) & (_x)) == (_x))
> +
>  struct mtk_iommu_domain {
>  	struct io_pgtable_cfg		cfg;
>  	struct io_pgtable_ops		*iop;
> @@ -563,7 +572,8 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  			 upper_32_bits(data->protect_base);
>  	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
>  
> -	if (data->enable_4GB && data->plat_data->has_vld_pa_rng) {
> +	if (data->enable_4GB &&
> +	    MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_VLD_PA_RNG)) {
>  		/*
>  		 * If 4GB mode is enabled, the validate PA range is from
>  		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
> @@ -573,7 +583,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  	}
>  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>  
> -	if (data->plat_data->reset_axi) {
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
>  		/* The register is called STANDARD_AXI_MODE in this case */
>  		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
>  	}
> @@ -618,7 +628,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  
>  	/* Whether the current dram is over 4GB */
>  	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
> -	if (!data->plat_data->has_4gb_mode)
> +	if (!MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
>  		data->enable_4GB = false;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -631,7 +641,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	if (data->irq < 0)
>  		return data->irq;
>  
> -	if (data->plat_data->has_bclk) {
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_BCLK)) {
>  		data->bclk = devm_clk_get(dev, "bclk");
>  		if (IS_ERR(data->bclk))
>  			return PTR_ERR(data->bclk);
> @@ -763,23 +773,19 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
>  
>  static const struct mtk_iommu_plat_data mt2712_data = {
>  	.m4u_plat     = M4U_MT2712,
> -	.has_4gb_mode = true,
> -	.has_bclk     = true,
> -	.has_vld_pa_rng   = true,
> +	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG,
>  	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
>  };
>  
>  static const struct mtk_iommu_plat_data mt8173_data = {
>  	.m4u_plat     = M4U_MT8173,
> -	.has_4gb_mode = true,
> -	.has_bclk     = true,
> -	.reset_axi    = true,
> +	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI,
>  	.larbid_remap = {0, 1, 2, 3, 4, 5}, /* Linear mapping. */
>  };
>  
>  static const struct mtk_iommu_plat_data mt8183_data = {
>  	.m4u_plat     = M4U_MT8183,
> -	.reset_axi    = true,
> +	.flags        = RESET_AXI,
>  	.larbid_remap = {0, 4, 5, 6, 7, 2, 3, 1},
>  };
>  
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 7212e6fcf982..5225a9170aaa 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -39,12 +39,7 @@ enum mtk_iommu_plat {
>  
>  struct mtk_iommu_plat_data {
>  	enum mtk_iommu_plat m4u_plat;
> -	bool                has_4gb_mode;
> -
> -	/* HW will use the EMI clock if there isn't the "bclk". */
> -	bool                has_bclk;
> -	bool                has_vld_pa_rng;
> -	bool                reset_axi;
> +	u32                 flags;


How about using bit field instead? eg

  u32 has_bclk:1;

In this way, we don't need to change code.

Joe.C


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
