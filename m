Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7E7C433E2
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 07:34:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B541F206F0
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 07:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mn5gncYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B541F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6EF57873EB;
	Mon, 13 Jul 2020 07:34:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U_15H6mh8QM6; Mon, 13 Jul 2020 07:34:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10E9787560;
	Mon, 13 Jul 2020 07:34:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3DA3C0888;
	Mon, 13 Jul 2020 07:34:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D6A3C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 07:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F0F8823455
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 07:34:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NA-LmbgdTiP5 for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 07:34:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 28180227E1
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 07:34:28 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id p20so15204955ejd.13
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Mv5WdsbJHcmRfr1CWAqVLgCzyD2WDHyCcH3cW9CT870=;
 b=mn5gncYvlT0Ikasjdu4y+nGbhp8qf0g/S/fJiCGf6woiq1WyBZiFigDT3Qp1D2tYTI
 pmW6YdaDNjwHR3PrL+IiKlbCPjioM14hSjLWkaH1Hv6Cac70Zw6Oxga2x9v5s8SMy/5x
 GmsD0Ru1j+a4thlGopDDg3e8+Sd1/EIjJPBh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Mv5WdsbJHcmRfr1CWAqVLgCzyD2WDHyCcH3cW9CT870=;
 b=gHd8NvKToxervs2aR99sMu7IwarcttJfEImYQHHbZ6teFCtbiFIoSl2ZniWwoCvUNC
 Cg3z3+UT6Hag3wHA4MQyPj2ToT1nQyA8wuLSdf0PxH6P/A19tPcVf2rpVfuuzgynvxxC
 ix7SF0egRC8my4NcA/Ba5BuXbK682MvVL1MiZV3kVfyL6VcK1eZSs3CGfH0yR2I4mkV+
 gzGmPlQTBUF9qR5geQjLupBAIssbhbMx4pTfACaEv27WU0rdyLSFjU0oXlS4iegVeltl
 SEpUHGsHjBCFWxB7RGriy8Lz+oF1IRNK8PvDs9mtj2lHxhQryBV/UgZiMgPUk0e8ssc1
 6BHA==
X-Gm-Message-State: AOAM533F5ubC0dh7oyJ0SMx36nYefGEXGr1wj95hvQ0sHcOHsYQTQKIh
 7wu2N3TLrs/DrJyfeIMEr3vcowwEPHlkwRKgtsUYiA==
X-Google-Smtp-Source: ABdhPJz7YORADPzpZtFVoxEClRzjUf3OF/9u0ANmR6SeAWwU4pfqH4KGc+q797K0VN2/NzCee6zahEJc92V4Gk3su/c=
X-Received: by 2002:a17:906:1db1:: with SMTP id
 u17mr64544271ejh.72.1594625666473; 
 Mon, 13 Jul 2020 00:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-13-yong.wu@mediatek.com>
In-Reply-To: <20200711064846.16007-13-yong.wu@mediatek.com>
From: Pi-Hsun Shih <pihsun@chromium.org>
Date: Mon, 13 Jul 2020 15:33:50 +0800
Message-ID: <CANdKZ0d8CSWQepCj9RFFxrvYq8K8G=oZCnskRiA3aY3gY-DD=w@mail.gmail.com>
Subject: Re: [PATCH 12/21] iommu/mediatek: Add iova reserved function
To: Yong Wu <yong.wu@mediatek.com>
Cc: =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= <youlin.pei@mediatek.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 cui.zhang@mediatek.com, Hao Chao <hao.chao@mediatek.com>,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

On Sat, Jul 11, 2020 at 2:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> For multiple iommu_domains, we need to reserve some iova regions, so we
> will add mtk_iommu_iova_region structure. It includes the base address
> and size of the range.
> This is a preparing patch for supporting multi-domain.
>
> Signed-off-by: Anan sun<anan.sun@mediatek.com>
> Signed-off-by: Hao Chao<hao.chao@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/mtk_iommu.h |  5 +++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 03a6d66f4bef..fdfdb75706e0 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -151,6 +151,11 @@ static LIST_HEAD(m4ulist); /* List all the M4U HWs */
> ...
> +
> +static void mtk_iommu_put_resv_regions(struct device *dev,
> +                                      struct list_head *head)
> +{
> +       struct iommu_resv_region *entry, *next;
> +
> +       list_for_each_entry_safe(entry, next, head, list)
> +               kfree(entry);
> +}
> +

This is the same as generic_iommu_put_resv_regions, use that as the
.put_resv_regions callback instead?

> ...
> --
> 2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
