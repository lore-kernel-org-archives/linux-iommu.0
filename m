Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B86CC433DF
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 20:22:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0092E2075D
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 20:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXB05T+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0092E2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE25F88BCF;
	Mon, 13 Jul 2020 20:22:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ghf6U1GswEB8; Mon, 13 Jul 2020 20:22:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 53B0788C30;
	Mon, 13 Jul 2020 20:22:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FAE2C088E;
	Mon, 13 Jul 2020 20:22:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D36FC088E
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 20:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3D9978A06A
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 20:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IqLUxejiPRQ9 for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 20:22:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 81AC88A04F
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 20:22:15 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id o2so1149050wmh.2
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Un7dCCnkxcZsvwr/aTPovVdtJrLxmvJRKWCcD5TCwew=;
 b=lXB05T+wtWcVmb/ToU2CDb7Jolp2Phtrkp863Dkj50ce4afhbb2DtrWXSd5dr/XFRq
 6HlKu2bvqEwgfLU17lzzcRQTDW/YGm7udhfknmHh7XM5KM1yfQgFF7S8V4BDeVOY4rX5
 uVwyQCLgcU6NojcJ8v9hq0eljOvV6jXz9bs863Acsp/S7slXIwt17eJm4Raw0KacFweq
 t+CCbHbnXXQ9uC/a5l/Xjl6lIYAWeKgSEFwuCRIbL/l33ANQ6BFbfgqHlf0uovajE5Yk
 WhNxww3SS9gsftVAA2xX5NB3UIkh5rza4YLB0xwxKF6Fc8QYl2YHRrE09hE7tIAuEUOb
 FP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Un7dCCnkxcZsvwr/aTPovVdtJrLxmvJRKWCcD5TCwew=;
 b=Ro78R3tj29TCbLniX50iMZ7QFJZ0t0nmu9YYea1W9AWk9DQHvXUjp+B5sW2qsNAhKF
 9UNpYHEIobOROAkbnbQ07q7lWzfWp3m0iBOZjvQz3iiO71mr6lLYvbqUTAhCyLCNv5n5
 +IQrPNf2LDd82WhDb2q10jA+AXllbDg9FvZ5PXdcFitSvt2PG+ci6L9gnT1P/NUImuik
 Ifvh35N5a6tmv7oSMz2iQA9/2/xgpRsb6ykVYI0XD8Iok9TZzg7AoKopirwryxaTOsRo
 GfZ8i9vl958SbtuFklj+cbPvTf48FdKMyCU+l4hXgUv/gIAIk7POgrOoo2oulKJgpuDs
 TgEQ==
X-Gm-Message-State: AOAM530J39hkUpOvT3IzupR2TUas/PxmssRongmcDb9E9mr3J3Ipef7m
 xBK6w1Yb5OANmByDG+PlaVA=
X-Google-Smtp-Source: ABdhPJwb4tLfgGCNFfgqcCjcbJr/U2aVoM5vrdZp/oSZZm+oTjo0hS+XhLTRGDICUWQLSdI57bQ8cQ==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr1092698wmj.20.1594671733950; 
 Mon, 13 Jul 2020 13:22:13 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
 by smtp.gmail.com with ESMTPSA id f17sm1076862wme.14.2020.07.13.13.22.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 13:22:13 -0700 (PDT)
Subject: Re: [PATCH] iommu/mediatek: Include liunx/dma-mapping.h
To: Joerg Roedel <joro@8bytes.org>
References: <20200713101648.32056-1-joro@8bytes.org>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <151352ff-d518-174a-9601-1cffc212d008@gmail.com>
Date: Mon, 13 Jul 2020 22:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713101648.32056-1-joro@8bytes.org>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
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



On 13/07/2020 12:16, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This fixes a compile error when cross-compiling the driver
> on x86-32.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 6ff62452bbf9..122925dbe547 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -15,6 +15,7 @@
>   #include <linux/iommu.h>
>   #include <linux/list.h>
>   #include <linux/spinlock.h>
> +#include <linux/dma-mapping.h>
>   #include <soc/mediatek/smi.h>
>   
>   #define MTK_LARB_COM_MAX	8
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
