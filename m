Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976AFC48BCF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 13:38:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B29D613AD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 13:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B29D613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDCAF40515;
	Wed,  9 Jun 2021 13:38:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2q5JeSagjTcT; Wed,  9 Jun 2021 13:38:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9CED4404EF;
	Wed,  9 Jun 2021 13:38:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 712A0C000E;
	Wed,  9 Jun 2021 13:38:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99067C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 756AD60A3D
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:38:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bs1zTEstSjpf for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 13:38:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1BAD60A39
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:38:17 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 l7-20020a05600c1d07b02901b0e2ebd6deso4242800wms.1
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2XtC26dDQI+8z2NBND3LcVHi35tPI4TG6eO9es29Zac=;
 b=DzJMNm+3h04RwqPbHWExMNYCF+kaN1b1pLrOfQW7uU+gGHoukXnx3AUoHcpShlEZO0
 G71QT3Yq2vT78oEWlHeQbmVZbe6WM94LtTSdjT/VxIglyPKyK3Q2T/JDNndT0yPXJsLv
 dzSJJGkGwPqQfbRaTULkHwERsRxu0yYuZnTzhu1Xntt4qzZgrVQnNR77xZGHBK9l9stF
 BXbE4iv+o0YLeRS2xXM1E2//e2UMHJyrgFdOtBoiyUlO/bQ62I9kCR/NdZq1THpFdIzK
 9DCO2qzA06o/FOLDmZ7BKKEoefE45EM+fOjGHTirVfQMUhogaiE+NoMOAtVlA0BO8b+B
 FG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2XtC26dDQI+8z2NBND3LcVHi35tPI4TG6eO9es29Zac=;
 b=j2uQWzP0v2YkExmbs+OKW3iBEqohjsVCBHV9dZEVVtmVyX3n/0geevAN6mQw5HFm+F
 hkSWd/zfQwRzxWwIouLQA8PiQVc8Y8/ii/aRFk3MRSdPY5iNY6hapy542bIqgZXhquUM
 CiN3jh9XuUfaDTQDwV3XZpsMPhHbDCaKTJU5O+O4Ya9KxgWob3SZ5Lv4OqoNKx/L6pq9
 CWeGl402C7EFkjzFN1BqIpmUiCX+BOwUJnuFqXeMFp+cSXe/VOpkGfpPRfSpxZL+1ify
 JckaVPikY8NHwjUozsHLWwhVe8ZNpbdEuMQCv1+3yJkxvFXcdaBVIQgR8mqIhjnSc3mV
 XdZw==
X-Gm-Message-State: AOAM533IWUFgnLXJsjZtVRmYU/LtHB2fKiciX4NNFPQvDh3lTL2wQfl8
 meMdhiaTHRCKWQ+n22beg50=
X-Google-Smtp-Source: ABdhPJwRn7xOH9cpkumSJykpQHFyX0W4qhaLI33hiASlySCZeUqCvFm4zsH9ez6+Ei9TmMDVCfoy+Q==
X-Received: by 2002:a05:600c:190f:: with SMTP id
 j15mr10147185wmq.4.1623245895818; 
 Wed, 09 Jun 2021 06:38:15 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
 by smtp.gmail.com with ESMTPSA id u12sm2793979wrr.40.2021.06.09.06.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 06:38:15 -0700 (PDT)
Subject: Re: [PATCH v5 05/16] media: mtk-jpeg: Use pm_runtime_resume_and_get
 for PM get_sync
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-6-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <82aea4aa-0007-369d-9c0d-db0077471b80@gmail.com>
Date: Wed, 9 Jun 2021 15:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210410091128.31823-6-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, acourbot@chromium.org,
 srv_heupstream@mediatek.com, eizan@chromium.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-mediatek@lists.infradead.org, Xia Jiang <xia.jiang@mediatek.com>,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 10/04/2021 11:11, Yong Wu wrote:
> pm_runtime_get_sync will increment pm usage counter even it failed.
> This patch use pm_runtime_resume_and_get instead of pm_runtime_get
> to keep usage counter balanced.
> 
> CC: Xia Jiang <xia.jiang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> index 88a23bce569d..a89c7b206eef 100644
> --- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
> @@ -920,7 +920,7 @@ static void mtk_jpeg_enc_device_run(void *priv)
>  	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
>  	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
>  
> -	ret = pm_runtime_get_sync(jpeg->dev);
> +	ret = pm_runtime_resume_and_get(jpeg->dev);
>  	if (ret < 0)
>  		goto enc_end;
>  
> @@ -973,7 +973,7 @@ static void mtk_jpeg_dec_device_run(void *priv)
>  		return;
>  	}
>  
> -	ret = pm_runtime_get_sync(jpeg->dev);
> +	ret = pm_runtime_resume_and_get(jpeg->dev);
>  	if (ret < 0)
>  		goto dec_end;
>  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
