Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987D5C433DF
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 07:04:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D402075D
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 07:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oBSA29ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D402075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4236F88367;
	Mon, 13 Jul 2020 07:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cTOu0hGida4i; Mon, 13 Jul 2020 07:04:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 936DA8821D;
	Mon, 13 Jul 2020 07:04:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74403C0894;
	Mon, 13 Jul 2020 07:04:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4EB7C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 07:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B40F5886DA
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 07:04:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qu698n0mB5lJ for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 07:04:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9EB2C886C5
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 07:04:10 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id y18so7949852lfh.11
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9He2Y/cj2b1yofJp3r0tciWRU0GFm0a2fXfgV5d2ZsM=;
 b=oBSA29ZRXnyX5uNrdKdKimE/m7zWdZXNnhrXmKWKgnyN/SH230LhrcwzyL4D5IYCjQ
 q+j9awO4n+F2erswVyiQg/WMcIkxFh/IgNX4JZT8Q8aB3qp0IaeT4wjmr6f/xn1O58TX
 4LtOfoBBudGY9551aEhRNWgZVLL5lJSfEBVd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9He2Y/cj2b1yofJp3r0tciWRU0GFm0a2fXfgV5d2ZsM=;
 b=dzcxA+BdMsc5yVI0kgioJ9Py/inhu2a9XqSpsoBu38WXi2BxbtgByhuwjPzGP5Cqlu
 JFiYpXJO+Sj4vsTTmJgCoKFcEa5CBPoj4l4xpZT9IfRupMFuRHr8E2B4/H9oIeFqnZq+
 7HQPDy6lk727DzH26EnghWgTrjQ7GaM+ClNxvExDl6F4CclwinaLcKeDwm53LxvlDiXC
 ApmGCopnmXVx0kLa0X6gbYyvl3jOFjaZaJ5DDp+G7/ZLWD2vEim4IJVUlOGXxuZStGjX
 JOQHVM7IgUNtSnPXXlIbCsl46IXibynSwA8v/8p2tt4Dtg5PIhzaW16CTt5CyqSkvWzm
 FiYA==
X-Gm-Message-State: AOAM53190MReZYgYosmNIbkBDCE3SgScVOk3U+svKU67l2pfvxfVyt5d
 CxF8+0E/GMGlwOYEWaIHsmsr1oOnwT6n5bOv1dEU87Ed6ankCQ==
X-Google-Smtp-Source: ABdhPJxgek6wFGTNWYGWXYoVuA91A7Bl2JN7v5ipfo4T7zContyupAUFj7BG3ePmDatYcqA77vTV3vhHfoLVelT2s64=
X-Received: by 2002:a17:906:f117:: with SMTP id
 gv23mr43961935ejb.528.1594623847288; 
 Mon, 13 Jul 2020 00:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-12-yong.wu@mediatek.com>
In-Reply-To: <20200711064846.16007-12-yong.wu@mediatek.com>
From: Pi-Hsun Shih <pihsun@chromium.org>
Date: Mon, 13 Jul 2020 15:03:31 +0800
Message-ID: <CANdKZ0e3=AeCxpSHVk7daUE01L7AgJYmZ7jeOQDT169SaowL-g@mail.gmail.com>
Subject: Re: [PATCH 11/21] iommu/mediatek: Add power-domain operation
To: Yong Wu <yong.wu@mediatek.com>
Cc: =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= <youlin.pei@mediatek.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Nicolas Boichat <drinkcat@chromium.org>,
 cui.zhang@mediatek.com, srv_heupstream@mediatek.com, chao.hao@mediatek.com,
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
> In the previous SoC, the M4U HW is in the EMI power domain which is
> always on. the latest M4U is in the display power domain which may be
> turned on/off, thus we have to add pm_runtime interface for it.
>
> we should enable its power before M4U hw initial. and disable it after HW
> initialize.
>
> When the engine work, the engine always enable the power and clocks for
> smi-larb/smi-common, then the M4U's power will always be powered on
> automatically via the device link with smi-common.
>
> Note: we don't enable the M4U power in iommu_map/unmap for tlb flush.
> If its power already is on, of course it is ok. if the power is off,
> the main tlb will be reset while M4U power on, thus the tlb flush while
> m4u power off is unnecessary, just skip it.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 54 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 7 deletions(-)
> ...
>         for_each_m4u(data) {
> +               /* skip tlb flush when pm is not active */
> +               if (pm_runtime_enabled(data->dev) &&
> +                   !pm_runtime_active(data->dev))
> +                       continue;
> +

pm_runtime_active(dev) == false implies dev->power.disable_depth == 0,
which implies pm_runtime_enabled(dev) == true, so the
pm_runtime_enabled(data->dev) can be omitted here.

>                 spin_lock_irqsave(&data->tlb_lock, flags);
>                 writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>                                data->base + data->plat_data->inv_sel_reg);
> ...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
