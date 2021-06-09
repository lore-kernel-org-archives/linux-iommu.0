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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE987C48BCF
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 13:53:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DAF61364
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 13:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DAF61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F48060A52;
	Wed,  9 Jun 2021 13:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gNpVK9oyPlfg; Wed,  9 Jun 2021 13:53:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 194E4608E3;
	Wed,  9 Jun 2021 13:53:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0183C000E;
	Wed,  9 Jun 2021 13:53:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22ED7C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08C0860A3D
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:53:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oih55JkksiqG for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 13:53:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FBF7608E3
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 13:53:01 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id y7so20946734wrh.7
 for <iommu@lists.linux-foundation.org>; Wed, 09 Jun 2021 06:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0acANAgz0MlP9hPrB8I/frs/iBRqhU+q6XEBhj3gv8Q=;
 b=Cb4nEUXmhZvh1I1hdtpEsgGzcI8hqQQrc7hh7BmIb/NX9p0nBm+QjwFq9gL6Ze2N9k
 5/kF/QBn0UJ0x7F6q/wS/GIekJmnYYdLBYYwnYGSwRI8T1fFvnS0Vt3wj9kG6zU0uN0H
 ZFPOXyzQVSXJJbyAkKMZ/rIMtRGWVYMRDbH30IuOvtdrAUkcjtlT+BNnp+toj6YK68x+
 SW+2wbaS6w12L2ph1J9OfxsbLKm6oQc0N4ZXjcenr30sAKY3LkKYddG/44vFeDVCwMyZ
 s+hkxsGE2LffD4jYDQDPDULTxBaqYCM1nxoPITOvQOymZOUkwmXNOGqH6G9uQtQPxHqg
 NrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0acANAgz0MlP9hPrB8I/frs/iBRqhU+q6XEBhj3gv8Q=;
 b=GADMWHatXGQ9BW07IckUpRvNczGbzLZkDnBl8jLvvxM305s/YgJFZWUcokBq/Z5Ds/
 E+0y7wVR+fjk+mYZPJuS3eG/LDhqjrS4qLCFZDNM36FnySZ/r9JWkZhE4Mch7Bbw2v64
 mMTJ67BQprl1ReVqqb7g7ofOcvEnHD/9FCam+M1NKDaAj3S8OH+fBBXIecxt347rnYJA
 Cw4xYDKuVWOXeTBQVJZRICi3kQmGub1rwS2CZOhSPLr7i4Inc3nSG2y/lmuucHM1O8Cy
 EyrHqAd5Ld+Kuh8ZiRi5EEdoqN1rU0U098wpo4GwLLQy+ZUqw7p7R60S8Jzm/xmA9zAF
 MDKw==
X-Gm-Message-State: AOAM533RvSfa4eFBSGpTrRgxuAFDTkpDHMSJadr6cbIzirxihkszqfFl
 mQQaDSNzo9dHYLbsC1Rr0uw=
X-Google-Smtp-Source: ABdhPJwdmtEhrw/I6sV9OLtji5VUn/ZbC7buSNEwtJICXxu0yAJLmTXM7NFYTrhsWxKQQG1r2WrGig==
X-Received: by 2002:adf:9d81:: with SMTP id p1mr27685928wre.287.1623246779787; 
 Wed, 09 Jun 2021 06:52:59 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
 by smtp.gmail.com with ESMTPSA id v16sm10195wrr.6.2021.06.09.06.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 06:52:59 -0700 (PDT)
Subject: Re: [PATCH v5 09/16] drm/mediatek: Use pm_runtime_resume_and_get for
 PM get_sync
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
 <20210410091128.31823-10-yong.wu@mediatek.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <299857fd-533d-5e6e-0744-92ee56078638@gmail.com>
Date: Wed, 9 Jun 2021 15:52:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210410091128.31823-10-yong.wu@mediatek.com>
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
> pm_runtime_get_sync will increment pm usage counter even it failed.
> This patch use pm_runtime_resume_and_get instead of pm_runtime_get
> to keep usage counter balanced.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 8b0de90156c6..69d23ce56d2c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -259,7 +259,7 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *mtk_crtc)
>  		drm_connector_list_iter_end(&conn_iter);
>  	}
>  
> -	ret = pm_runtime_get_sync(crtc->dev->dev);
> +	ret = pm_runtime_resume_and_get(crtc->dev->dev);
>  	if (ret < 0) {
>  		DRM_ERROR("Failed to enable power domain: %d\n", ret);
>  		return ret;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
