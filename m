Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E129AC4338F
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 05:37:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8114260EBD
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 05:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8114260EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 36CC24016F;
	Tue,  3 Aug 2021 05:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 90bRPqZQUvuO; Tue,  3 Aug 2021 05:37:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C617E40197;
	Tue,  3 Aug 2021 05:37:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A0E3C0010;
	Tue,  3 Aug 2021 05:37:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7543FC000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 05:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 547B540187
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 05:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 13WzFTzqfcPj for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 05:37:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 782AD4016F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 05:37:12 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id c16so22327196plh.7
 for <iommu@lists.linux-foundation.org>; Mon, 02 Aug 2021 22:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TzgmYchbci/zhvlgXLAGmYsl7UzG8nnyQecH+/1YGbQ=;
 b=ES55ynagZ88pg0GPjV6f9YmdPOu1QNR8D/oRa8bNQ/T4u9Nxk+qPpJ5UcbEoQilUyZ
 u3+F/HwsLgeupDpIDbgs1unBMYXyLlltf0CudKw6Ac1QXWjntXx+kNos74b2LiMtNEcv
 es9C9D3nxwbVWjEvI1IPePrzDYu2Oqq5AJMmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TzgmYchbci/zhvlgXLAGmYsl7UzG8nnyQecH+/1YGbQ=;
 b=lCzJwSBArGZbsaNLojo2VFNtORg2r+ve3riQk7yt95YgHBvhivC8xBzVBKdkjnkDhW
 WYeQNCJflml0M2j4wLt1GkK3mKg7LgT6yW5vrIVr3NhlGeEuvvDdikI6O2+0c8h2RFDv
 +npRxOgdI7c2aLcDG8sWe/EAl+pya6bu///zHuIhqbUTcm8W+VOF5Ce4rICnZmN6lJnZ
 VcSQ11zk8NqLuXRbnswtMeMequum8+57C2BGrmYcSjWmmfuO463tBY/AbTTclSnJMfMm
 omntoyJ+/aWlGIZInJkvM0zX9aRMdN7lnFzm/+DMWzwHRzJblAIyaKBn+BLDJuHFkxM+
 N8uA==
X-Gm-Message-State: AOAM532rVLJPFYGGXxGDAZQnmTrojChWSHc2i7Ci9z5oV/Red7nNEPQU
 8iM78wIW/pcRmGyvDS2791kkdNCZPtsQDu/6Xl/l/A==
X-Google-Smtp-Source: ABdhPJwy22hM/0nLperLTs7oqlOkW3eLaO6jLCVztbfyp37svS9AhfV/dPAYrDNKRL8a0yAc2zvp451Ro7v8cSdVagE=
X-Received: by 2002:a17:902:b788:b029:12c:2888:9589 with SMTP id
 e8-20020a170902b788b029012c28889589mr17319543pls.60.1627969031860; Mon, 02
 Aug 2021 22:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-12-yong.wu@mediatek.com>
 <CAATdQgAfo9oNR5=ogEottHajODngi1ahvKUnEOUczzjreYpPcQ@mail.gmail.com>
 <1626935902.27875.7.camel@mhfsdcap03> <1627540902.13818.3.camel@mhfsdcap03>
In-Reply-To: <1627540902.13818.3.camel@mhfsdcap03>
From: Ikjoon Jang <ikjn@chromium.org>
Date: Tue, 3 Aug 2021 13:37:01 +0800
Message-ID: <CAATdQgCf2sNwZWBKOC=HJU7Ur+7J6+uc75UD6xjfMF71Dxr18Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] memory: mtk-smi: mt8195: Add initial setting for
 smi-larb
To: Yong Wu <yong.wu@mediatek.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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

Hi,

On Thu, Jul 29, 2021 at 2:41 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Hi Ikjoon,
>
> Just a ping.
>
> On Thu, 2021-07-22 at 14:38 +0800, Yong Wu wrote:
> > On Wed, 2021-07-21 at 21:40 +0800, Ikjoon Jang wrote:
> > > On Thu, Jul 15, 2021 at 8:23 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > > >
> > > > To improve the performance, We add some initial setting for smi larbs.
> > > > there are two part:
> > > > 1), Each port has the special ostd(outstanding) value in each larb.
> > > > 2), Two general setting for each larb.

Honestly, I think nobody outside Mediatek will understand this.
Can you please update this to be more generic?
Like "Apply default bus settings for mt8195, without this, XXX
problems can happen.. "?

Or for example, adding brief descriptions on what
MTK_SMI_FLAG_LARB_THRT_EN, MTK_SMI_FLAG_LARB_SW_FLAG,
and MTK_SMI_FLAG_LARB_SW_FLAG[] are for would be better if it's available.

> > > >
> > > > In some SoC, this setting maybe changed dynamically for some special case
> > > > like 4K, and this initial setting is enough in mt8195.
> > > >
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > [...]
> > > >  struct mtk_smi {
> > > > @@ -213,12 +228,22 @@ static void mtk_smi_larb_config_port_mt8173(struct device *dev)
> > > >  static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> > > >  {
> > > >         struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > > > -       u32 reg;
> > > > +       u32 reg, flags_general = larb->larb_gen->flags_general;
> > > > +       const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
> > > >         int i;
> > > >
> > > >         if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
> > > >                 return;
> > > >
> > > > +       if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_LARB_THRT_EN))
> > > > +               writel_relaxed(SMI_LARB_THRT_EN, larb->base + SMI_LARB_CMD_THRT_CON);
> > > > +
> > > > +       if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_LARB_SW_FLAG))
> > > > +               writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
> > > > +
> > > > +       for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
> > > > +               writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));
> > >
> > > All other mtk platform's larbs have the same format for SMI_LARB_OSTDL_PORTx()
> > > registers at the same offset? or is this unique feature for mt8195?
> >
> > All the other Platform's larbs have the same format at the same offset.
>
> In this case, Do you have some other further comment? If no, I will keep
> the current solution for this.

Sorry for the late response,
I have no further comments or any objections on here. Please go ahead for v3.
I just had no idea on the register definitions and wanted to be sure that
newly added register definitions are common to all MTK platforms.

Thanks!

>
> Thanks.
>
> >
> > >
> > > > +
> > > >         for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> > > >                 reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
> > > >                 reg |= F_MMU_EN;
> > > > @@ -227,6 +252,51 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> > > >         }
> > > >  }
> > > >
> >
> > [...]
> >
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
