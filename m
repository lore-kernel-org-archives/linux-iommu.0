Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D8C433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 05:23:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FE922B37
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 05:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FE922B37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DD65487126;
	Wed, 13 Jan 2021 05:23:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M62o9HFKAXdJ; Wed, 13 Jan 2021 05:23:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A4AE786D92;
	Wed, 13 Jan 2021 05:23:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 892DCC0893;
	Wed, 13 Jan 2021 05:23:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7F60C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 05:23:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ABC4687126
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 05:23:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IBHlfeBnG1Vq for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 05:23:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D66DF86D92
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 05:23:09 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id e18so1235518ejt.12
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 21:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2NaZcbwSAFQ15OW65EbbMjqTmOC5Pf2iFjcyvx6UbnA=;
 b=SkyiyzJ28uSjHS90XLoXBBlIMxeQbmNuAEQ8qW3qG/lEq4KSFJGvKCe2uo6om+eCht
 oHNmuAbEj1wylSDgYYohrZowWD1TI2mPSkvtOcj1vM82/8Tsr+ruktT1iu//pIsXdvzB
 +NLLMVs4Ps2w7DhXFnSO9Nbs5cVRzog+Vam+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2NaZcbwSAFQ15OW65EbbMjqTmOC5Pf2iFjcyvx6UbnA=;
 b=NQC0Pezj/4y4XPti9aT/vysZt8BQntIi7Dn15CNXGEI0bM+nESDvGGo2IKy9VbgXp4
 kteXuIFk/MCYLHweiqEOnvX9l2KsHkmfOc93Tow25fgOrQbAS5CDUfXqalSthDt94FWc
 oJfyb4Gq4c7al9GHNl2JAaRurgSWnEXg6RW4ZKaXLoJg92+PGwfecSKIC1z6QxtLi36I
 yWetu+Zw9gTUO02fLMno1eEdNyo60/kd1xgwPd89+BSqHHHXelnPEZyYgOWv1W+Kct7l
 XgpzEbiKOhBPAhcCAlwFKURHuFMvsBuxXjrsZJCLWQWDfj86q9tyvfZu5Sy0GBT5kQUt
 hsRg==
X-Gm-Message-State: AOAM533bdt9apwLdNhYkcarDLNBzSH3As/zzvcA4bbQPcG8aDOGsr9J+
 LeG+Em/a8piVvBpUxj3dt6QMn/QUISi/StKD
X-Google-Smtp-Source: ABdhPJyHZmHjo/biOTN5VxSubs33qhWm6J5NJrRy2WcTHSCsS6x1fGk6rDr5knyeRlroP4N4buYjcQ==
X-Received: by 2002:a17:907:700c:: with SMTP id
 wr12mr315265ejb.398.1610515387903; 
 Tue, 12 Jan 2021 21:23:07 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com.
 [209.85.128.48])
 by smtp.gmail.com with ESMTPSA id x17sm312271edd.76.2021.01.12.21.23.03
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jan 2021 21:23:04 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id y187so424750wmd.3
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 21:23:03 -0800 (PST)
X-Received: by 2002:a1c:c308:: with SMTP id t8mr409738wmf.22.1610515383125;
 Tue, 12 Jan 2021 21:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-5-yong.wu@mediatek.com>
 <X+L8qpO+T7+U2s5r@chromium.org> <1608809212.26323.258.camel@mhfsdcap03>
In-Reply-To: <1608809212.26323.258.camel@mhfsdcap03>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 13 Jan 2021 14:22:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CnnHwCUioH52VRWZW=f7V7Q=xBSfbhMM+qJVtaqSf8Pw@mail.gmail.com>
Message-ID: <CAAFQd5CnnHwCUioH52VRWZW=f7V7Q=xBSfbhMM+qJVtaqSf8Pw@mail.gmail.com>
Subject: Re: [PATCH v5 04/27] dt-bindings: memory: mediatek: Add domain
 definition
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, linux-devicetree <devicetree@vger.kernel.org>,
 Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>, Will Deacon <will@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>
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

On Thu, Dec 24, 2020 at 8:27 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2020-12-23 at 17:15 +0900, Tomasz Figa wrote:
> > Hi Yong,
> >
> > On Wed, Dec 09, 2020 at 04:00:39PM +0800, Yong Wu wrote:
> > > In the latest SoC, there are several HW IP require a sepecial iova
> > > range, mainly CCU and VPU has this requirement. Take CCU as a example,
> > > CCU require its iova locate in the range(0x4000_0000 ~ 0x43ff_ffff).
> >
> > Is this really a domain? Does the address range come from the design of
> > the IOMMU?
>
> It is not a really a domain. The address range comes from CCU HW
> requirement. That HW can only access this iova range. thus I create a
> special iommu domain for it.
>

I guess it's the IOMMU/DT maintainers who have the last word here, but
shouldn't DT just specify the hardware characteristics and then the
kernel configure the hardware appropriately, possibly based on some
other configuration interface (e.g. command line parameters or sysfs)?

How I'd do this is rather than enforcing those arbitrary decisions
onto the DT bindings, I'd add properties to the master devices (e.g.
CCU) that specify which IOVA range they can operate on. Then, the
exact split of the complete address space would be done at runtime,
based on kernel configuration, command line parameters and possibly
sysfs attributes if things could be reconfigured dynamically.

Best regards,
Tomasz

> >
> > Best regards,
> > Tomasz
> >
> > >
> > > In this patch we add a domain definition for the special port. In the
> > > example of CCU, If we preassign CCU port in domain1, then iommu driver
> > > will prepare a independent iommu domain of the special iova range for it,
> > > then the iova got from dma_alloc_attrs(ccu-dev) will locate in its special
> > > range.
> > >
> > > This is a preparing patch for multi-domain support.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  include/dt-bindings/memory/mtk-smi-larb-port.h | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/dt-bindings/memory/mtk-smi-larb-port.h b/include/dt-bindings/memory/mtk-smi-larb-port.h
> > > index 7d64103209af..2d4c973c174f 100644
> > > --- a/include/dt-bindings/memory/mtk-smi-larb-port.h
> > > +++ b/include/dt-bindings/memory/mtk-smi-larb-port.h
> > > @@ -7,9 +7,16 @@
> > >  #define __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
> > >
> > >  #define MTK_LARB_NR_MAX                    32
> > > +#define MTK_M4U_DOM_NR_MAX         8
> > > +
> > > +#define MTK_M4U_DOM_ID(domid, larb, port)  \
> > > +   (((domid) & 0x7) << 16 | (((larb) & 0x1f) << 5) | ((port) & 0x1f))
> > > +
> > > +/* The default dom id is 0. */
> > > +#define MTK_M4U_ID(larb, port)             MTK_M4U_DOM_ID(0, larb, port)
> > >
> > > -#define MTK_M4U_ID(larb, port)             (((larb) << 5) | (port))
> > >  #define MTK_M4U_TO_LARB(id)                (((id) >> 5) & 0x1f)
> > >  #define MTK_M4U_TO_PORT(id)                ((id) & 0x1f)
> > > +#define MTK_M4U_TO_DOM(id)         (((id) >> 16) & 0x7)
> > >
> > >  #endif
> > > --
> > > 2.18.0
> > >
> > > _______________________________________________
> > > iommu mailing list
> > > iommu@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
