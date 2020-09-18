Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83007C43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 16:08:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1990E23888
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 16:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="emUrEqNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1990E23888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B816A20405;
	Fri, 18 Sep 2020 16:08:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id acvlJEaRGJQR; Fri, 18 Sep 2020 16:08:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A382420334;
	Fri, 18 Sep 2020 16:08:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 927BDC0888;
	Fri, 18 Sep 2020 16:08:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CECDC0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 16:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 49E9820334
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 16:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bpW3OX+AfNYW for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 16:08:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 8292C1FD16
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 16:08:04 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F2D9B2389F
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600445284;
 bh=HsD1zmlNgcDp2ntiGGXDt1Iu4ADx6rxNh/Bto2esBP8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=emUrEqNiAaIypaaqR0DFyojY3bKTuLzedv4LJNpN6r92gOZux9m/t+i1gDj1JpGUw
 XdzfnJhSce31jn8yRunVP1TffGoAH3jyT3yCKqPfFryCodyr5Ku1NvsvKOnpWwHFs+
 9mXeIHyvZEiaP3nGp2V20W14pf9i4HBfMJMoBQV8=
Received: by mail-ot1-f45.google.com with SMTP id e23so5850568otk.7
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 09:08:03 -0700 (PDT)
X-Gm-Message-State: AOAM533mXtmBtlTG0G3ne0fh7D6nOV5ITuza5uhV2qDGUD6TpYbvOwq2
 ++tcrHpFKeRfnAuLBDgE1Q0sRAgc/YP8ZsWPyA==
X-Google-Smtp-Source: ABdhPJwgdQQ94kk1CAJVTaLgyAzK5jSLiZzPbGFE5cSpTlp+14Bb87D1OUAiLGeIZ3x+kwKNZ39GOoJ1D5VzhOMWVEw=
X-Received: by 2002:a05:6830:1008:: with SMTP id
 a8mr21705872otp.107.1600445283255; 
 Fri, 18 Sep 2020 09:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200905080920.13396-1-yong.wu@mediatek.com>
 <20200905080920.13396-2-yong.wu@mediatek.com>
 <20200914232204.GA457962@bogus> <1600148980.25043.11.camel@mhfsdcap03>
In-Reply-To: <1600148980.25043.11.camel@mhfsdcap03>
From: Rob Herring <robh@kernel.org>
Date: Fri, 18 Sep 2020 10:07:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKj+-_vvZfoLiJ-ox255cFaAD4SPmrk2qCusGWAs-b+XQ@mail.gmail.com>
Message-ID: <CAL_JsqKj+-_vvZfoLiJ-ox255cFaAD4SPmrk2qCusGWAs-b+XQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/23] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
To: Yong Wu <yong.wu@mediatek.com>
Cc: Youlin Pei <youlin.pei@mediatek.com>, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream <srv_heupstream@mediatek.com>, Chao Hao <chao.hao@mediatek.com>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Ming-Fan Chen <ming-fan.chen@mediatek.com>, Anan Sun <anan.sun@mediatek.com>,
 Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Mon, Sep 14, 2020 at 11:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Mon, 2020-09-14 at 17:22 -0600, Rob Herring wrote:
> > On Sat, Sep 05, 2020 at 04:08:58PM +0800, Yong Wu wrote:
> > > Convert MediaTek IOMMU to DT schema.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
>
> [...]
>
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mediatek,mt2701-m4u #mt2701 generation one HW
> > > +      - mediatek,mt2712-m4u #mt2712 generation two HW
> > > +      - mediatek,mt6779-m4u #mt6779 generation two HW
> > > +      - mediatek,mt7623-m4u, mediatek,mt2701-m4u #mt7623 generation one HW
> >
> > This is not right.
> >
> > items:
> >   - const: mediatek,mt7623-m4u
> >   - const: mediatek,mt2701-m4u
> >
> > And that has to be under a 'oneOf' with the rest of this.
>
> Thanks for the review. Is this OK?
>
>   compatible:
>     oneOf:
>       - const: mediatek,mt2701-m4u # mt2701 generation one HW
>       - const: mediatek,mt2712-m4u # mt2712 generation two HW
>       - const: mediatek,mt6779-m4u # mt6779 generation two HW
>       - const: mediatek,mt8173-m4u # mt8173 generation two HW
>       - const: mediatek,mt8183-m4u # mt8183 generation two HW
>       - const: mediatek,mt8192-m4u # mt8192 generation two HW

It is correct, but I prefer all these to be a single enum. So 'oneOf'
would have 2 entries.

>       - description: mt7623 generation one HW
>         items:
>           - const: mediatek,mt7623-m4u
>           - const: mediatek,mt2701-m4u
>
> >
> > > +      - mediatek,mt8173-m4u #mt8173 generation two HW
> > > +      - mediatek,mt8183-m4u #mt8183 generation two HW
> > > +
> > > +  reg:
> > > +    maxItems: 1
>
> [snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
