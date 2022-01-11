Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB4C433F5
	for <iommu@archiver.kernel.org>; Tue, 11 Jan 2022 09:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 428C883E2A;
	Tue, 11 Jan 2022 09:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o73DPpGztbiN; Tue, 11 Jan 2022 09:11:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3141B83E28;
	Tue, 11 Jan 2022 09:11:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4BE7C0030;
	Tue, 11 Jan 2022 09:11:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 241C5C001E
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 09:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F1BA783E29
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 09:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8chjm7E5drlm for <iommu@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 09:11:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E8BB83E28
 for <iommu@lists.linux-foundation.org>; Tue, 11 Jan 2022 09:11:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 7A11E1F41347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641892258;
 bh=ZY19t3su5uLFe0/PG24UiwL7zoDt4pgnUUQFZmfGa94=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=fOeZ71A/jtYIdNLUxiVtNnk0hRxeRY1SYP/9rTYI0dnR3ZKcVeYbk3V5xd0mjkPJJ
 ThDZn5u2JOuWTTAwOxojoTeKFPcdX+cwWgitnl7E04FvKTjzKBm1mJo4YzLupMSJep
 LPDiXVnn7Uu4HpYPzNcv3TNoQWnQoq6x13j1kr3sqir2Y34Y+hpNcZtk+ipOCYW5vY
 RrH2kSurnPai+jGenY38etsNX2y4HS+zvF7BGqlNB1Ggwg61LXm3PBFn7UkiSgBMM2
 51nTWWtPvivLlugdNcvQYq2QYEAOcbjHL92N0imWkW7EgnKru59pBrld4YBPP/moS9
 HRdnBCXYw5PlQ==
Subject: Re: [PATCH v2 4/6] memory: mtk-smi: Fix the return value for
 clk_bulk_prepare_enable
To: Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-5-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <00efa277-6475-4f20-f045-443a0706e9e2@collabora.com>
Date: Tue, 11 Jan 2022 10:10:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111063904.7583-5-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, anthony.huang@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Il 11/01/22 07:39, Yong Wu ha scritto:
> The successful return value for clk_bulk_prepare_enable is 0, rather than
> "< 0". Fix this.
> 

Hello! Thanks for this commit!
However, there are a few comments...

This description is a bit confusing, please reword it, something like...

"Function clk_bulk_prepare_enable() returns 0 for success or a negative
number for error. Fix this code style issue."

In any case, you're not fixing any bad logic issue here, as the function
will never return anything > 0.

What you're fixing is a common pattern usage issue, so the Fixes tag can be
removed since it's not really useful to schedule this commit for backport
over older stable versions.


After the requested changes:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Fixes: 0e14917c57f9 ("memory: mtk-smi: Use clk_bulk clock ops")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/memory/mtk-smi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..e7b1a22b12ea 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -480,7 +480,7 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
>   	int ret;
>   
>   	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
> -	if (ret < 0)
> +	if (ret)
>   		return ret;
>   
>   	/* Configure the basic setting for this larb */
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
