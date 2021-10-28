Return-Path: <SRS0=iLkC=PQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E1FC433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Oct 2021 06:14:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE7061056
	for <iommu@archiver.kernel.org>; Thu, 28 Oct 2021 06:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BBE7061056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 821D140583;
	Thu, 28 Oct 2021 06:14:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yg249ogydFRc; Thu, 28 Oct 2021 06:14:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E856404EF;
	Thu, 28 Oct 2021 06:14:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 212D8C0019;
	Thu, 28 Oct 2021 06:14:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C62CC000E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 06:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4386440132
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 06:14:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uvMh8os52SjS for <iommu@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 06:14:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28DD6400F7
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 06:14:10 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id i14so6602480ioa.13
 for <iommu@lists.linux-foundation.org>; Wed, 27 Oct 2021 23:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q/CaYgRMivi6E5IrdJQN3VhID0wrYip2MBmQLj5bzn8=;
 b=Aq2N80QZqWuk5rhmqD7SlSuHwXw7X5Xj9MYYbX+VkHfnnnJufBOqYb9gJF4OaEiYOR
 JuqCgXZnsw56MasCxD1UCPwBEADYf4FTAWs1ucK/j7eyDg4KLsC9VDX8pUg2LrTvIBMu
 LluBL6cpWjDIFC5cHIlQBEAbj2544NrYdVLsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q/CaYgRMivi6E5IrdJQN3VhID0wrYip2MBmQLj5bzn8=;
 b=EwHqghjjuwi1SPWZk6+M0qL/jGcTRuBY9KguZX4Dq+1pUujK0gY4bCaxrcRAJzGFb8
 fr85toOElc7qMeG7UiBzRqN1lKdvGRNvHKXdg2uQ0o7sQYodimoSu/QtWHFFICzNltJG
 fzBpelTt7Nwan2Dbe5lET7cfJqIbEKXQkN1cOO/JH6monmdfCF2BzAmeurLFcodJOsTi
 ku5AFuhn8vGYUhNeD17noOk9OgpZ1QenzMgSXJKsIJgvj6ZopK7LVqnRwD1YZ8poAa4T
 BhGKj5jnn5UFuH9W8+TBRJNjBureVQmym7hpOLfX7Ul9oEB3mBl+SOmLRPshM40z8DYx
 opLw==
X-Gm-Message-State: AOAM533+VwOzn1SauYYAsrTo3mwakkCLq+waW7tE+5QAdm9jN6zR+jKb
 J9qIBiqkHBnS7jCSXLD/xs7pXCJSjh29PWcTL0eBWg==
X-Google-Smtp-Source: ABdhPJzC5EHSvYTWsmMZor72KBYkv+zsEBX+bmiCWVqdyiTSd1OU5sPmnEltvdTsr6xsiuVNtLUjnZF8GSWmTewNAHQ=
X-Received: by 2002:a02:954d:: with SMTP id y71mr1680582jah.83.1635401649146; 
 Wed, 27 Oct 2021 23:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211028055056.26378-1-yong.wu@mediatek.com>
In-Reply-To: <20211028055056.26378-1-yong.wu@mediatek.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Thu, 28 Oct 2021 14:13:43 +0800
Message-ID: <CAJMQK-jCuH-EKd1snhtrkFEz0bFN1t8EvsF3Kjua-HVFa_3J9A@mail.gmail.com>
Subject: Re: [PATCH] memory: mtk-smi: Fix a null dereference for the ostd
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, yi.kuo@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Ikjoon Jang <ikjn@chromium.org>,
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

On Thu, Oct 28, 2021 at 1:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> We add the ostd setting for mt8195. It introduces a abort for the
> previous SoC which doesn't have ostd setting. This is the log:
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000080
> ...
> pc : mtk_smi_larb_config_port_gen2_general+0x64/0x130
> lr : mtk_smi_larb_resume+0x54/0x98
> ...
> Call trace:
>  mtk_smi_larb_config_port_gen2_general+0x64/0x130
>  pm_generic_runtime_resume+0x2c/0x48
>  __genpd_runtime_resume+0x30/0xa8
>  genpd_runtime_resume+0x94/0x2c8
>  __rpm_callback+0x44/0x150
>  rpm_callback+0x6c/0x78
>  rpm_resume+0x310/0x558
>  __pm_runtime_resume+0x3c/0x88
>
> In the code: larbostd = larb->larb_gen->ostd[larb->larbid],
> if "larb->larb_gen->ostd" is null, the "larbostd" is the offset, it is
> also a valid value, thus, use the larb->larb_gen->ostd as the condition
> inside the "for" loop.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

After applying this patch, mt8183 is no longer crashing.

> ---
> Hi Krzysztof,
> Could you help review and conside this as a fix for the mt8195 patchset?
> The mt8195 patchset are not in mainline, thus, I don't know its sha-id,
> and don't add Fixes tag.
> Thanks
> ---
>  drivers/memory/mtk-smi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..0262a59a2d6e 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -257,7 +257,7 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
>         if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_SW_FLAG))
>                 writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
>
> -       for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
> +       for (i = 0; i < SMI_LARB_PORT_NR_MAX && larb->larb_gen->ostd && !!larbostd[i]; i++)
>                 writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));
>
>         for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> --
> 2.18.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
