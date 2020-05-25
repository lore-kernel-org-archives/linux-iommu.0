Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875CFC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 06:16:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B408207DA
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 06:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sUT1dbhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B408207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 13A8586113;
	Mon, 25 May 2020 06:16:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TDPTTUZux7dE; Mon, 25 May 2020 06:16:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 97D6085F18;
	Mon, 25 May 2020 06:16:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D3D6C088D;
	Mon, 25 May 2020 06:16:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF20C016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 06:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3775F87FEA
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 06:16:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dminzxW1f4ub for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 06:16:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by hemlock.osuosl.org (Postfix) with ESMTP id CC01A87FE7
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 06:16:25 +0000 (UTC)
X-UUID: ad783735897a4deb96e9fc9d60047f63-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=3hx+xuZwk+qJ8HxGZOVEgrk/RUaXq486bK4HGdRWFOY=; 
 b=sUT1dbhdCwbCGa9wcevmxjH949p1825aQBiHBRQINul9aBnQfP+tLrzQmokyAad1O0JD8NmjAcPvTY5stKeK7ji0X704MhlSCBY7opEnfnHsM1qV04W8e8fKAKdGUZr+I0nd6HugKsWa0h1vyD9sNPNUtynrqAhMD3T0GcHSXZo=;
X-UUID: ad783735897a4deb96e9fc9d60047f63-20200525
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1685404416; Mon, 25 May 2020 14:16:19 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Mon, 25 May 2020 14:16:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 14:16:16 +0800
Message-ID: <1590387275.13912.7.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/7] iommu/mediatek: Disable STANDARD_AXI_MODE in
 MISC_CTRL
From: Yong Wu <yong.wu@mediatek.com>
To: Chao Hao <chao.hao@mediatek.com>
Date: Mon, 25 May 2020 14:14:35 +0800
In-Reply-To: <20200509083654.5178-4-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
 <20200509083654.5178-4-chao.hao@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A8DD666DEB4BBAC87549C627945CC7E41AC0342C681DB12F322F811B674E33472000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Jun Yan <jun.yan@mediatek.com>, linux-arm-kernel@lists.infradead.org
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

On Sat, 2020-05-09 at 16:36 +0800, Chao Hao wrote:
> In order to improve performance, we always disable STANDARD_AXI_MODE in
> MISC_CTRL.
> 
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 8 +++++++-
>  drivers/iommu/mtk_iommu.h | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index e7e7c7695ed1..9ede327a418d 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -42,6 +42,8 @@
>  #define F_INVLD_EN1				BIT(1)
>  
>  #define REG_MMU_MISC_CTRL			0x048
> +#define F_MMU_STANDARD_AXI_MODE_BIT		(BIT(3) | BIT(19))
> +
>  #define REG_MMU_DCM_DIS				0x050
>  
>  #define REG_MMU_CTRL_REG			0x110
> @@ -585,7 +587,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>  	}
>  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>  
> -	if (data->plat_data->reset_axi) {
> +	if (data->plat_data->has_misc_ctrl) {
> +		regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
> +		regval &= ~F_MMU_STANDARD_AXI_MODE_BIT;
> +		writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
> +	} else if (data->plat_data->reset_axi) {
>  		/* The register is called STANDARD_AXI_MODE in this case */
>  		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
>  	}


0x48 is either STANDARD_AXI_MODE or MISC_CTRL.

Thus, 

if (data->plat_data->reset_axi) {
   xxx
} else {  /* MISC_CTRL */
   xxx
}

No need add "has_misc_ctrl".


> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 1b6ea839b92c..d711ac630037 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -40,6 +40,7 @@ struct mtk_iommu_plat_data {
>  
>  	/* HW will use the EMI clock if there isn't the "bclk". */
>  	bool                has_bclk;
> +	bool		    has_misc_ctrl;
>  	bool                has_vld_pa_rng;
>  	bool                reset_axi;
>  	unsigned char       larbid_remap[MTK_LARB_NR_MAX];

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
