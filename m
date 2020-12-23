Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD24C433E0
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:25:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8007220857
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 08:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8007220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3974D8723B;
	Wed, 23 Dec 2020 08:25:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AudtDNUfJiOR; Wed, 23 Dec 2020 08:25:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9F24C87164;
	Wed, 23 Dec 2020 08:25:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B375C1787;
	Wed, 23 Dec 2020 08:25:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38632C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1E8C120422
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YRW1pMeiVF14 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 08:25:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by silver.osuosl.org (Postfix) with ESMTPS id DABCC20334
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 08:25:33 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id p18so10152884pgm.11
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 00:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WThy4tT62F3b3zf0PgQRiQWDvTgvmZESA9P7XUtvIQc=;
 b=lm/gAASMc8UZvLfJCPhTrygCJnvjXm/AgIJtR846gqbmtV/Z9xMScDs4z2klDYCZXa
 xitLyUpJQ7GhOJ4B/3K9Bn/OGgr46nwQda0iPJyr/MPDZ/E4Jlfcgu5f3ieDmOgniDjp
 VYvE8Ofugj7cXljMRJQzCHIZhclSCNeJ4ktpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WThy4tT62F3b3zf0PgQRiQWDvTgvmZESA9P7XUtvIQc=;
 b=j9WhdZB+WfLA/0Ov9ulwCGXvbWPWDKW0TJg/Vw7bGyZgp48cKP7EiztG3av3svfnRz
 HNt+QF5OSzG8Du68YwRzhE3Im/a0jXNd0MVbYS52KqCr1H3sF204JzvEuXz9lNny4MMp
 Wp0POByBxLKt7M8uotxvM9amCCMT37UfGk2KBKVG01QLBX4qeLb9EZyYiKtppMTApS+K
 o37aKhniR0hudHQLt8PqxHsT6JB8Zmm6Mv7MDv4D/WK/VE/r+W3Vgxi9w+5EQViJWlo4
 tV5nQLAxT7QZ1Wle1YMq+anComAeC82p0JeblNwM7pns+qGSuB1z2hIbMtFk8aySWizZ
 /r4w==
X-Gm-Message-State: AOAM532hEOA/1k/U+UVkAQjz0gl4wbD4/tUZvpamt18mS2ywXcBh7TDL
 glc6eyaeHaACIBb7GUUc5za5vQ==
X-Google-Smtp-Source: ABdhPJypg4hGOlyNgx6/zOot9YXwUix2EbRuZvx1p0wnv9B3ytcx7t9ecSD2W9nXEkM/rMgQwZKs4w==
X-Received: by 2002:a05:6a00:1392:b029:1a3:c284:521f with SMTP id
 t18-20020a056a001392b02901a3c284521fmr23329507pfg.81.1608711933463; 
 Wed, 23 Dec 2020 00:25:33 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
 by smtp.gmail.com with ESMTPSA id p9sm22298444pjb.3.2020.12.23.00.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Dec 2020 00:25:32 -0800 (PST)
Date: Wed, 23 Dec 2020 17:25:27 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v5 15/27] iommu/mediatek: Add fail handle for sysfs_add
 and device_register
Message-ID: <X+L+97OBxC6I5pUv@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-16-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-16-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
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

On Wed, Dec 09, 2020 at 04:00:50PM +0800, Yong Wu wrote:
> Add fail handle for iommu_device_sysfs_add and iommu_device_register.
> 
> Fixes: b16c0170b53c ("iommu/mediatek: Make use of iommu_device_register interface")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 39478cfbe0f1..09c8c58feb78 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -746,7 +746,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  
>  	ret = iommu_device_register(&data->iommu);
>  	if (ret)
> -		return ret;
> +		goto out_sysfs_remove;
>  
>  	spin_lock_init(&data->tlb_lock);
>  	list_add_tail(&data->list, &m4ulist);
> @@ -754,7 +754,16 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>  	if (!iommu_present(&platform_bus_type))
>  		bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
>  
> -	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> +	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> +	if (ret)
> +		goto out_dev_unreg;
> +	return ret;
> +
> +out_dev_unreg:

Shouldn't other operations be undone as well? I can see that above
bus_set_iommu() is set and an entry is added to m4ulist.

> +	iommu_device_unregister(&data->iommu);
> +out_sysfs_remove:
> +	iommu_device_sysfs_remove(&data->iommu);
> +	return ret;
>  }
>  
>  static int mtk_iommu_remove(struct platform_device *pdev)
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
