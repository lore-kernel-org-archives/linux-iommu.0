Return-Path: <SRS0=4al/=PD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFDC433FE
	for <iommu@archiver.kernel.org>; Fri, 15 Oct 2021 14:58:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA124610E8
	for <iommu@archiver.kernel.org>; Fri, 15 Oct 2021 14:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA124610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 812F7607C8;
	Fri, 15 Oct 2021 14:58:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EU-uXEbv54ud; Fri, 15 Oct 2021 14:58:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02C1E60794;
	Fri, 15 Oct 2021 14:58:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCE0FC000F;
	Fri, 15 Oct 2021 14:58:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8282BC000D
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 13:38:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 53EE6404C1
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 13:38:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ReKcbH1mVF7t for <iommu@lists.linux-foundation.org>;
 Fri, 15 Oct 2021 13:38:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49BC7401F4
 for <iommu@lists.linux-foundation.org>; Fri, 15 Oct 2021 13:38:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 92E011F4536E
Subject: Re: [PATCH v4 03/13] memory: mtk-smi: Use clk_bulk clock ops
To: Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
 <20210914113703.31466-4-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <e466b3fb-d9fe-bb20-23c2-f9766a35f120@collabora.com>
Date: Fri, 15 Oct 2021 15:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914113703.31466-4-yong.wu@mediatek.com>
Content-Language: en-US
X-Mailman-Approved-At: Fri, 15 Oct 2021 14:58:02 +0000
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Ikjoon Jang <ikjn@chromium.org>,
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

> Use clk_bulk interface instead of the orginal one to simplify the code.
> 
> For SMI larbs: Require apb/smi clocks while gals is optional.
> For SMI common: Require apb/smi/gals0/gal1 in has_gals case. Otherwise,
>                  also only require apb/smi, No optional clk here.
> 
> About the "has_gals" flag, for smi larbs, the gals clock also may be
> optional even this platform support it. thus it always use
> *_bulk_get_optional, then the flag has_gals is unnecessary. Remove it.
> The smi_common's has_gals still keep it.
> 
> Also remove clk fail logs since bulk interface already output fail log.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Hello Yong,
thanks for the patch! However, I have an improvement to point out:

> ---
>   drivers/memory/mtk-smi.c | 143 +++++++++++++++------------------------
>   1 file changed, 55 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index c5fb51f73b34..f91eaf5c3ab0 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -60,6 +60,20 @@ enum mtk_smi_gen {
>   	MTK_SMI_GEN2
>   };
>   
> +#define MTK_SMI_CLK_NR_MAX			4

This refers to mtk_smi_common_clks[] and should be probably moved after that.
In any case, I don't think that there's any need to manually define this as 4,
as you can simply use the macro ARRAY_SIZE(mtk_smi_common_clks).
Using that will make you able to not update this definition everytime an update
occurs to the mtk_smi_common_clks array.

> +
> +/* larbs: Require apb/smi clocks while gals is optional. */
> +static const char * const mtk_smi_larb_clks[] = {"apb", "smi", "gals"};
> +#define MTK_SMI_LARB_REQ_CLK_NR		2
> +#define MTK_SMI_LARB_OPT_CLK_NR		1
> +
> +/*
> + * common: Require these four clocks in has_gals case. Otherwise, only apb/smi are required.
> + */
> +static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1"};
> +#define MTK_SMI_COM_REQ_CLK_NR		2
> +#define MTK_SMI_COM_GALS_REQ_CLK_NR	MTK_SMI_CLK_NR_MAX
> +

Apart from that,
Acked-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Regards,
- Angelo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
