Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50368C433DB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 13:47:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6644233FB
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 13:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6644233FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 259222D3FC;
	Wed, 13 Jan 2021 13:47:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qhdBEImLSWvq; Wed, 13 Jan 2021 13:47:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1626127233;
	Wed, 13 Jan 2021 13:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB0F5C0893;
	Wed, 13 Jan 2021 13:47:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4167C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 13:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A90FE27428
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 13:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RLn9MZjDaNvk for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 13:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id C9BE127233
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 13:47:40 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9695233FB
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610545660;
 bh=c9ZEmZC+OGzOHSTlleqwkNhpgxSo3+qwJ9ptpSoPBMY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=FYu658AOWNtizhfGOXbNeL8NnWsMtHC+dTrt2yedfVOtoG8JKtBG1y0MjODTu7GW+
 740oAJD+fJqb5Ts7VVV3U0RQNlu6RbHic5mtnopKPl5jioiqWOOkaKbt2dcLn/u+s7
 rtGUDgKHYO2vy3z9WftyjNDrcEPDtYydLA3YzkWaUcPIt82pnUA9FwbgpXRQXjsmcB
 W0vRdNUQjbeEwzz3seUsYoyKP0i2R+Fd0JWpH/RrqeAmXPff4JzKQiknxZ1BCcrRAj
 IIhLhSyZ2S1JQDGgRP4Zv3xbeB/GUxEAOljYrPV9vib4zsFj0Ixwzj+Ay81CUJHG6E
 IqT8rXjjuXBfA==
Received: by mail-ed1-f47.google.com with SMTP id i24so1955284edj.8
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 05:47:39 -0800 (PST)
X-Gm-Message-State: AOAM531UJLNx7kr3q4qUalNsg5Mzg1uTYipPjmo+TwjRUOei9DfAtqzI
 l4vzkeWZJMx7ungBBE/Nakrl1HczStQZiYWhug==
X-Google-Smtp-Source: ABdhPJwFnnxsacTgDF7sATccpJCIWFohXy1lChGnPrWia0Dd45sGfr2h+/uzWLycVLhW0t1rfVN+jlHpRT5er6uxUkA=
X-Received: by 2002:a50:e78b:: with SMTP id b11mr1817862edn.165.1610545658364; 
 Wed, 13 Jan 2021 05:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20201223111633.1711477-1-zhang.lyra@gmail.com>
 <20210108022545.GA1744725@robh.at.kernel.org>
 <CAAfSe-svn4ACvhk3McO7APLLSKdC=9ei7bvmD9ZhnSosnLQ1AA@mail.gmail.com>
In-Reply-To: <CAAfSe-svn4ACvhk3McO7APLLSKdC=9ei7bvmD9ZhnSosnLQ1AA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 13 Jan 2021 07:47:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKqi_tngaR0nHpjbQz2Q8QnwJ+Ea=DghT6xqR9U8o-5CQ@mail.gmail.com>
Message-ID: <CAL_JsqKqi_tngaR0nHpjbQz2Q8QnwJ+Ea=DghT6xqR9U8o-5CQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iommu: add bindings for sprd iommu
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sheng Xu <sheng.xu@unisoc.com>, Linux IOMMU <iommu@lists.linux-foundation.org>,
 Kevin Tang <kevin.tang@unisoc.com>, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>
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

On Fri, Jan 8, 2021 at 5:34 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Fri, 8 Jan 2021 at 10:25, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Dec 23, 2020 at 07:16:32PM +0800, Chunyan Zhang wrote:
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > This patch only adds bindings to support display iommu, support for others
> > > would be added once finished tests with those devices, such as Image
> > > codec(jpeg) processor, a few signal processors, including VSP(video),
> > > GSP(graphic), ISP(image), and camera CPP, etc.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > >  .../devicetree/bindings/iommu/sprd,iommu.yaml | 44 +++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > new file mode 100644
> > > index 000000000000..4d9a578a7cc9
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright 2020 Unisoc Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Unisoc IOMMU and Multi-media MMU
> > > +
> > > +maintainers:
> > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - sprd,iommu-disp
> >
> > Needs to be Soc specific.
>
> All SoCs so far use the same iommu IP, there's a little different
> among different iommu users.

That's what everyone says. Be warned that you cannot add properties
for any differences that come up whether features or errata.

> > Is this block specific to display subsys or
> > that just happens to be where the instance is?
>
> This iommu driver can serve many subsystem devices, such as Video,
> Camera, Image, etc., but they have their own iommu module which looks
> like a subdevice embedded in the master devices.
> I will add more compatible strings for those devices when needed.
> For now, only this one was listed here because I just tested this
> iommu driver with DPU only.

The iommu binding takes care of what each one is connected to. Is each
instance different in terms of features or programming model? If not,
then you shouldn't have different compatible strings for each
instance.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
