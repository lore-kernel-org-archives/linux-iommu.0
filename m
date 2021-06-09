Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64667C48BCF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 14:42:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EF5613AD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 14:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EF5613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDBF783C92;
	Wed,  9 Jun 2021 14:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1iX-DMrEyKKv; Wed,  9 Jun 2021 14:42:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C3CCE83C7B;
	Wed,  9 Jun 2021 14:42:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D7EAC000D;
	Wed,  9 Jun 2021 14:42:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33CBBC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 14:42:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DE714017B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 14:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0d_HJ_jQP7n0 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 14:42:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E856540137
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 14:42:12 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id c9so17100622wrt.5
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IhyCu8H5WSS/E4CDjMhpArM4pXXOj0TlzCRvDB9JWNs=;
 b=FylaupbFDFZrMhi3SvSNnIe8tPXxK9fI1FeBkscPkU7HbplyXTi5mjeQl4ajeZUMjF
 3u9Y9nVjGb2t0Jl/1yP6vkekD7tk4+/juEZuLQPMu++PeIg4Rz0q+Y3HoLTPRvxlNgwm
 d/saSwDWPCECKQPpWi/mJ6GbyjOEuY9BOFCwwHxkr9bLFyuLqWhYP8LZvaPQ1YYCIL6s
 waetdHEa2R04ypG6be8Vd7k+j9eqjmmhbEldq2TdqRkoUscclY5BLVAkfx/5Dreyal2u
 gb5v7pguPCe4uVY8/JkG6lEj0nXgYj6jMz7m0CFQZbala5Oq81d+LQmqbKQOnnBaf50D
 O/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IhyCu8H5WSS/E4CDjMhpArM4pXXOj0TlzCRvDB9JWNs=;
 b=dKIuW53KhmVwirb/wVbzFI4ADauRiz9SvuDyxmGOSCmruS7yjhhLz1Yl+Rcri8SGcJ
 5UoaLakFD6hxt6ZNubvHE/lMNYKpyU+sZwRlN9n++P5byPAJKcrRDvpBgOu61ZCLB1sG
 dbDbAMzq85Q0TreZdDoGmYD4n4G8bON4YFbNwv3CbzFGW6Wfu/hPJsTfUSvOD9qmacfq
 +ogp8pOP5NMUe2y5PNRZ4LWO/vAG5iH+NLcQRoP31hgSpNo/NNLHGRjezKvnuw423wux
 YV7ANXR/2r0NTYe6X8jmAUiMOkIe3jaUN+oIW55LvzYISDA8idNJDBvpglGQi0MmnM5B
 624w==
X-Gm-Message-State: AOAM533AlSeOQM8ObFRKYVFCKOgdHjGpmxnu9mov3HVuOzBVBy9YeumK
 lyx06GG6d8osPPaE109JwE0=
X-Google-Smtp-Source: ABdhPJxs1AUnYHyns8XqNWnre7Ubl2p5jpkkdqatFTbqbgJrQpW3L64xpTz6S+pkS0t8gqgaaORBHg==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr171709wrr.292.1623249731120; 
 Wed, 09 Jun 2021 07:42:11 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
 by smtp.gmail.com with ESMTPSA id v7sm129321wru.66.2021.06.09.07.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 07:42:10 -0700 (PDT)
Subject: Re: [PATCH v5 14/16] memory: mtk-smi: Get rid of mtk_smi_larb_get/put
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-15-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <1755fd87-a724-508f-92a8-d09b627d58ca@gmail.com>
Date: Wed, 9 Jun 2021 16:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210410091128.31823-15-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, acourbot@chromium.org,
 srv_heupstream@mediatek.com, eizan@chromium.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
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



On 10/04/2021 11:11, Yong Wu wrote:
> After adding device_link between the iommu consumer and smi-larb,
> the pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. we can get rid of mtk_smi_larb_get/put.
> 
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/memory/mtk-smi.c   | 14 --------------
>  include/soc/mediatek/smi.h | 20 --------------------
>  2 files changed, 34 deletions(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index c5fb51f73b34..7c61c924e220 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -134,20 +134,6 @@ static void mtk_smi_clk_disable(const struct mtk_smi *smi)
>  	clk_disable_unprepare(smi->clk_apb);
>  }
>  
> -int mtk_smi_larb_get(struct device *larbdev)
> -{
> -	int ret = pm_runtime_resume_and_get(larbdev);
> -
> -	return (ret < 0) ? ret : 0;
> -}
> -EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
> -
> -void mtk_smi_larb_put(struct device *larbdev)
> -{
> -	pm_runtime_put_sync(larbdev);
> -}
> -EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
> -
>  static int
>  mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
>  {
> diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> index 15e3397cec58..11f7d6b59642 100644
> --- a/include/soc/mediatek/smi.h
> +++ b/include/soc/mediatek/smi.h
> @@ -19,26 +19,6 @@ struct mtk_smi_larb_iommu {
>  	unsigned char  bank[32];
>  };
>  
> -/*
> - * mtk_smi_larb_get: Enable the power domain and clocks for this local arbiter.
> - *                   It also initialize some basic setting(like iommu).
> - * mtk_smi_larb_put: Disable the power domain and clocks for this local arbiter.
> - * Both should be called in non-atomic context.
> - *
> - * Returns 0 if successful, negative on failure.
> - */
> -int mtk_smi_larb_get(struct device *larbdev);
> -void mtk_smi_larb_put(struct device *larbdev);
> -
> -#else
> -
> -static inline int mtk_smi_larb_get(struct device *larbdev)
> -{
> -	return 0;
> -}
> -
> -static inline void mtk_smi_larb_put(struct device *larbdev) { }
> -
>  #endif
>  
>  #endif
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
