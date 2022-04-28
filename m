Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6E2C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7199D81B7B;
	Thu, 28 Apr 2022 14:18:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kv1YASAY4M0Q; Thu, 28 Apr 2022 14:18:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3D08781B01;
	Thu, 28 Apr 2022 14:18:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B834C0032;
	Thu, 28 Apr 2022 14:18:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39DEBC002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 26F0181B69
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3WGcmiM6QINU for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:18:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 069C681B01
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:18:06 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id v12so6974997wrv.10
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=5XdPKzrNuCW9Uls4djg9CnJPr0HfyWEzzX13gHvuT9s=;
 b=WYm5siW9NgsC3mcU0a3rvvmjzgshlYltbHF/8MkclQWoK+UeqblajvhIEXxxYve1Hw
 ArzFVVgI0LhX+EQQMKgsLRnxr1l6oRxDxasL6i16yusWP0qQO05kK2pUFQ9rwO2PU7CV
 g/I+91SHjrw6N2nVnNSpIvSq/6Q2axMNSjt8G+cn8jFEaCbdNXqLDCTe+qYh+tyImRcs
 2C2UQopBi/UqDb8Z7mJP93le0PX8NtFtxYQqKo5iDqjqEk8jhUY5Mz9CaPTNwW+JgW6O
 iYGgtDnGkNWHOvHntQd/+h4c+Y7dY/FegmQSsb4AbzllTJvmfkKOktoV7v9L5Gg3S71D
 XaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=5XdPKzrNuCW9Uls4djg9CnJPr0HfyWEzzX13gHvuT9s=;
 b=b3AU9h7sGEroEdEiy1CXvsKU66uLcluQfDgRlt1XxWDo4yB2+qurkP3D5Z2iLEvKR9
 ayCt+sIEB1pd7e8ygHFTmBh/D9kQ1qig+gpSNtn5PizTvokGp+PJVhxi1sIAUg+2JTqD
 iAtx1zPeFDv64yJ9WQn920lT7hfuUf/fa+38Z7LCLy7ltTivGduhPwe9wwbAP54NtuGM
 pKH5KzWRy0a7PTHYTBdO7p9ApuZod3wRTdNbggB+Kb2upnmYONMS3G7Mitb9YzmOXYhV
 kwOpRal+/mi4pGqfkPvASeCUsMrRWyHhk6rvo0kh4zNpNAzzoNdIPPJtb8HZS8AswGir
 XALw==
X-Gm-Message-State: AOAM530WkflSji0WgWinSk3jHX39Xmh0GqUT1mmvvZhG42tfFbk87BZC
 CbaxratJJAmXz6WM5cSS9b8=
X-Google-Smtp-Source: ABdhPJx0D91qDY3rAHXrUKYpJ6EndFNu0vi5Ze7REIXxyW9yTMg00OwkJnpjgHzk30D5LZMqwVL8fA==
X-Received: by 2002:a5d:47ab:0:b0:20a:7f8a:ec69 with SMTP id
 11-20020a5d47ab000000b0020a7f8aec69mr26826607wrb.504.1651155485199; 
 Thu, 28 Apr 2022 07:18:05 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net.
 [188.85.180.35]) by smtp.gmail.com with ESMTPSA id
 s10-20020adf978a000000b0020ae0154f1esm12625wrb.5.2022.04.28.07.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Apr 2022 07:18:03 -0700 (PDT)
Message-ID: <661261a7-45be-230b-b0b2-5837d2139030@gmail.com>
Date: Thu, 28 Apr 2022 16:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 15/34] iommu/mediatek: Add IOMMU_TYPE flag
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
References: <20220407075726.17771-1-yong.wu@mediatek.com>
 <20220407075726.17771-16-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220407075726.17771-16-yong.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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



On 07/04/2022 09:57, Yong Wu wrote:
> Add IOMMU_TYPE definition. In the mt8195, we have another IOMMU_TYPE:
> infra iommu, also there will be another APU_IOMMU, thus, use 2bits for the
> IOMMU_TYPE.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/mtk_iommu.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 84d661e0b371..642949aad47e 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -126,9 +126,17 @@
>   #define SHARE_PGTABLE			BIT(10) /* 2 HW share pgtable */
>   #define DCM_DISABLE			BIT(11)
>   #define NOT_STD_AXI_MODE		BIT(12)
> +/* 2 bits: iommu type */
> +#define MTK_IOMMU_TYPE_MM		(0x0 << 13)
> +#define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
> +#define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
>   
> -#define MTK_IOMMU_HAS_FLAG(pdata, _x) \
> -		((((pdata)->flags) & (_x)) == (_x))
> +#define MTK_IOMMU_HAS_FLAG(pdata, _x)	(!!(((pdata)->flags) & (_x)))

That could be:
MTK_IOMMU_HAS_FLAG(pdata, _x) \
                 MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, _x)

> +
> +#define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
> +				((((pdata)->flags) & (mask)) == (_x))
> +#define MTK_IOMMU_IS_TYPE(pdata, _x)	MTK_IOMMU_HAS_FLAG_MASK(pdata, _x,\
> +							MTK_IOMMU_TYPE_MASK)
>   
>   struct mtk_iommu_domain {
>   	struct io_pgtable_cfg		cfg;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
