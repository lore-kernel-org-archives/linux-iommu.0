Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34620C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:20:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C9060720
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6C9060720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7ACC340105;
	Fri, 30 Jul 2021 09:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xUpx46XfjL0l; Fri, 30 Jul 2021 09:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1387340104;
	Fri, 30 Jul 2021 09:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8FDDC001A;
	Fri, 30 Jul 2021 09:20:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45236C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F5B340105
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 75YzcHSd37BI for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 09:20:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8DF0E40104
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:20:50 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id go31so15604962ejc.6
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yScgO+5K8kMvLXSdgAzUDbgBygVn2oY3p7co+ejC8RY=;
 b=uyMWYyaeqqDhutMdu8v6DlYLjabZMV/k588QHhkknUzmU0ef6XiKJGZUjdSB9McEjG
 UxMPoRZTxUmiVR3QmfCAQT7DTXR4ine1XyMgl3TWEygtL5mWPaczA25AkqXZ9MKHjPm7
 BXh2sVGR3V7IAMJ1zBfSeyiVJ1kZUnV/tRAyP0A0RETO60FXQb9s+utY77i+iOGBcEWi
 EbZ4102Ds71YqzCfnk98PsMuxZCKL8NtXPcuxnCdwwRjylKJkFWFYbJA7FyWFp+Hsyuj
 MUA1J6wN21nMVcVAvsmEYTAANme/cKhG9/aACc2p6v2tq+T7UhlVPNzMx/lO7wv9LmCG
 v/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yScgO+5K8kMvLXSdgAzUDbgBygVn2oY3p7co+ejC8RY=;
 b=ANBfHiziKRSwSVLNlzIKE7Ld059t5jJdzucO4RB2U8AKcvbdKUg+TW4BBa5pm0J/Nl
 2aNfPPvRDxWAKQRCDB/zQZAWYBIFUab/rQGmkDCsnyPnMlC/LXsvZ3lNFfSr01/5lCab
 nzYpAb0+Uy+p8UcOLX55A5qFXfAiK52D8CDgQIblhgA8g8M8/6hbzMOpw627ACmg1wHq
 S8nn0lwaODSaQLfX03jkW884pecWBhg8XTqdbLO63xO9GpufOowdiBwmEHhleZkAubHo
 q7vuDDxlnr7i+JgWwjKeYUHarnuGbtygz0+/fMuyh+FQz5XF1I8VcQ+hE3wnD6kGLDqr
 cGvA==
X-Gm-Message-State: AOAM532x59EBRhUWYnJ5JHINp/tv4hInEUqbd6YM9hi3xsdXhFoZ9k6x
 VcvHilI/eIKBhOSbPCB3P0fmfA==
X-Google-Smtp-Source: ABdhPJyvE+/FXDDFFPKn2vjWz2vToufjMHW31XnzNuOnMPZO+Nf9/mHtMwMoKC91LEbUZQzAEhlPaQ==
X-Received: by 2002:a17:906:2497:: with SMTP id
 e23mr1696642ejb.194.1627636848490; 
 Fri, 30 Jul 2021 02:20:48 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id f20sm355006ejz.30.2021.07.30.02.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 02:20:47 -0700 (PDT)
Date: Fri, 30 Jul 2021 11:20:27 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 11/24] iommu/virtio: Drop IOVA cookie management
Message-ID: <YQPEWzJq+7Jfu9+/@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <d9f524e29a580d094c7f9a7322e1bea6f3637c19.1627468309.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d9f524e29a580d094c7f9a7322e1bea6f3637c19.1627468309.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, will@kernel.org,
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

On Wed, Jul 28, 2021 at 04:58:32PM +0100, Robin Murphy wrote:
> The core code bakes its own cookies now.
> 
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Also tested on the Seattle (vsmmuv3/viommu with lazy/strict, still need to
test the runtime switch).

> ---
>  drivers/iommu/virtio-iommu.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 6abdcab7273b..80930ce04a16 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -598,12 +598,6 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
>  	spin_lock_init(&vdomain->mappings_lock);
>  	vdomain->mappings = RB_ROOT_CACHED;
>  
> -	if (type == IOMMU_DOMAIN_DMA &&
> -	    iommu_get_dma_cookie(&vdomain->domain)) {
> -		kfree(vdomain);
> -		return NULL;
> -	}
> -
>  	return &vdomain->domain;
>  }
>  
> @@ -643,8 +637,6 @@ static void viommu_domain_free(struct iommu_domain *domain)
>  {
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> -	iommu_put_dma_cookie(domain);
> -
>  	/* Free all remaining mappings (size 2^64) */
>  	viommu_del_mappings(vdomain, 0, 0);
>  
> -- 
> 2.25.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
