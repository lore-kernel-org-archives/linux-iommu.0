Return-Path: <SRS0=4dF3=NP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0976C4338F
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 07:35:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75ADD6120A
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 07:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75ADD6120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E8CA400E7;
	Tue, 24 Aug 2021 07:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ibKKrmxP70df; Tue, 24 Aug 2021 07:35:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A8472400BA;
	Tue, 24 Aug 2021 07:35:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73CCEC0010;
	Tue, 24 Aug 2021 07:35:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF4FCC000E
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 07:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C78A040494
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 07:35:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T2RPBm3QFMWa for <iommu@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 07:35:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 022404047E
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 07:35:31 +0000 (UTC)
Received: by mail-io1-xd35.google.com with SMTP id b7so25163629iob.4
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kdn/xtZAvZYiwKwxxhtoDSWZxutSGdv9Zf0EjwepvWk=;
 b=dFmqKGM4M8xwkez/7hO/m5icTM2376t5o0aNOCOsIxs5i4hiT5sr79kQdXWQq4TEDQ
 J/MeqGYzCjKUF5OToXwp6ZB4LNLWm37WAs1DA2MsvaACyMGlWLQz+RR81Uv9YdjMjoG2
 JqhbsZ+4S6XyrncPUOCD08O7+s+aOQbEB5RHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kdn/xtZAvZYiwKwxxhtoDSWZxutSGdv9Zf0EjwepvWk=;
 b=j6WnEdCIxbzNdWatHOVbWBHtnKaaFoclct0IS6zrDDe//80ORwdkkmxQ44sN1Sbxls
 knNd0KzaEytUqXjRjDQhigrPb+wuPjozcgRMhj+yjgBqSxyjt7klHLBbDqJGdvUYHMFj
 lD5qQOt7GKbVLz7MH4zu4HFUW3dM+/cJRwsyR2DQmgwP8HAIYgC5yjfSjRaXFwpnkaCc
 Xon4Fp/vmlvNz2wCszH152CVqQifD7Xv2YlWxxF93cmydoJgIQl4HfVcUGhEJyWslihp
 FV5ccsbR7wv6THSODX/E4Ocg2iMBxs41isXUo+slmqFLdScsk8uw7NRnjjgx3Oh4MMX6
 vXPw==
X-Gm-Message-State: AOAM532M/cXykXWy6VMibDqImZ6DugSvqoAHohy9BOL9Re2XAJbsy27k
 E/wC9oLy+7Gz62UD9CeQrgHnZGFR3mqVWF7ir2nocQ==
X-Google-Smtp-Source: ABdhPJzCaKQQqFiKu2GYGl51DjDrCHWW0khxqU+TJuIKD2Qiaa6IC9r0Xva1qe+ermS6tmqpaGovvcP+MP7vZ5pGN64=
X-Received: by 2002:a6b:6319:: with SMTP id p25mr30729776iog.100.1629790531099; 
 Tue, 24 Aug 2021 00:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210813065324.29220-1-yong.wu@mediatek.com>
 <20210813065324.29220-17-yong.wu@mediatek.com>
In-Reply-To: <20210813065324.29220-17-yong.wu@mediatek.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 24 Aug 2021 15:35:05 +0800
Message-ID: <CAJMQK-ir-wLy4OHkWEWZf=CZcURMhRvHnOjBLWXaezhukJh2JA@mail.gmail.com>
Subject: Re: [PATCH v2 16/29] iommu/mediatek: Adjust device link when it is
 sub-common
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, Devicetree List <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 chao.hao@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
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

On Fri, Aug 13, 2021 at 3:03 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> For MM IOMMU, We always add device link between smi-common and IOMMU HW.
> In mt8195, we add smi-sub-common. Thus, if the node is sub-common, we still
> need find again to get smi-common, then do device link.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index a4479916ad33..a72241724adb 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -845,6 +845,17 @@ static int mtk_iommu_mm_dts_parse(struct device *dev,
>         if (!smicomm_node)
>                 return -EINVAL;
>
> +       /* Find smi-common again if this is smi-sub-common */
> +       if (of_property_read_bool(smicomm_node, "mediatek,smi_sub_common")) {
> +               of_node_put(smicomm_node); /* put the sub common */
> +
> +               smicomm_node = of_parse_phandle(smicomm_node, "mediatek,smi", 0);

This only checks 1 level here, and does not check if the mediatek,smi
of a sub-common node is not another sub-common node.
So maybe add a check that the updated node here doesn't have
mediatek,smi_sub_common property.

> +               if (!smicomm_node) {
> +                       dev_err(dev, "sub-comm has no common.\n");
> +                       return -EINVAL;
> +               }
> +       }
> +
>         plarbdev = of_find_device_by_node(smicomm_node);
>         of_node_put(smicomm_node);
>         data->smicomm_dev = &plarbdev->dev;
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
