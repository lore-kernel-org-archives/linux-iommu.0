Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC626C433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 10:57:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CEC207E8
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 10:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GwdTNCVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CEC207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 77B072202C;
	Tue, 30 Jun 2020 10:57:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iQ1ItxnhF5cW; Tue, 30 Jun 2020 10:57:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 624102107F;
	Tue, 30 Jun 2020 10:57:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54A2EC088F;
	Tue, 30 Jun 2020 10:57:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4044AC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 28CEE8841A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q0gRuQfPTxTz for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 10:57:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [1.203.163.78])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1056C8833E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:57:11 +0000 (UTC)
X-UUID: 6fbe4a790cc44e3facaeb035874a41e4-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=dyBf/FOqBOKM8w25J19ReW9jhDIjCt4TCH41lbsQigU=; 
 b=GwdTNCVDrzvcWIsIQhFKt0D9lvK8U3eiFw+ANGTRuHBpRYpPcxYalBKe/PE6vSMNQvFEh6vf6HCX+1seZHoXJtidGk1nhzgkWD8pkBq33VVNqRzW+JLJmk4MhEb84XHa5HPEEbM2KzE5+KOqVA9A0s9k81T19um+ZAK4mbuVhfQ=;
X-UUID: 6fbe4a790cc44e3facaeb035874a41e4-20200630
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 640312049; Tue, 30 Jun 2020 18:57:03 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 30 Jun 2020 18:57:01 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 18:56:58 +0800
Message-ID: <1593514600.24171.26.camel@mhfsdcap03>
Subject: Re: [PATCH v5 03/10] iommu/mediatek: Modify the usage of
 mtk_iommu_plat_data structure
From: Yong Wu <yong.wu@mediatek.com>
To: Chao Hao <chao.hao@mediatek.com>
Date: Tue, 30 Jun 2020 18:56:40 +0800
In-Reply-To: <20200629071310.1557-4-chao.hao@mediatek.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
 <20200629071310.1557-4-chao.hao@mediatek.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E569C367CB152C27234DE089D55991412047532CEA7DCF42A63DDE8E08E5260F2000:8
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Chao,

This is also ok for me. Only two format nitpick.

On Mon, 2020-06-29 at 15:13 +0800, Chao Hao wrote:
> Given the fact that we are adding more and more plat_data bool values,
> it would make sense to use a u32 flags register and add the appropriate
> macro definitions to set and check for a flag present.
> No functional change.
> 
> Suggested-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
> ---

[snip]

>  static const struct mtk_iommu_plat_data mt2712_data = {
>  	.m4u_plat     = M4U_MT2712,
> -	.has_4gb_mode = true,
> -	.has_bclk     = true,
> -	.has_vld_pa_rng   = true,
> +	.flags        = HAS_4GB_MODE |
> +			HAS_BCLK |
> +			HAS_VLD_PA_RNG,

short enough. we can put it in one line?

>  	.larbid_remap = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9},
>  };
>  
>  static const struct mtk_iommu_plat_data mt8173_data = {
>  	.m4u_plat     = M4U_MT8173,
> -	.has_4gb_mode = true,
> -	.has_bclk     = true,
> -	.reset_axi    = true,
> +	.flags	      = HAS_4GB_MODE |
> +			HAS_BCLK |
> +			RESET_AXI,
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
> index 1b6ea839b92c..7cc39f729263 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -17,6 +17,15 @@
>  #include <linux/spinlock.h>
>  #include <soc/mediatek/smi.h>
>  
> +#define HAS_4GB_MODE			BIT(0)
> +/* HW will use the EMI clock if there isn't the "bclk". */
> +#define HAS_BCLK			BIT(1)
> +#define HAS_VLD_PA_RNG			BIT(2)
> +#define RESET_AXI			BIT(3)
> +
> +#define MTK_IOMMU_HAS_FLAG(pdata, _x) \
> +		((((pdata)->flags) & (_x)) == (_x))

If these definitions are not used in mtk_iommu_v1.c(also no this plan),
then we can put them in the mtk_iommu.c.


BTW, the patch title "modify the usage of mtk_iommu_plat_data structure"
isn't so clear, we could write what the detailed modification is.
something like:
iommu/mediatek: Use a u32 flags to describe different HW features

> +
>  struct mtk_iommu_suspend_reg {
>  	u32				misc_ctrl;
>  	u32				dcm_dis;
> @@ -36,12 +45,7 @@ enum mtk_iommu_plat {
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
>  	unsigned char       larbid_remap[MTK_LARB_NR_MAX];
>  };
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
