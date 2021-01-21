Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AE7C433E0
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 07:52:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F355C23356
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 07:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F355C23356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1882B858D4;
	Thu, 21 Jan 2021 07:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SRhgbKaNK6Cz; Thu, 21 Jan 2021 07:52:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C3B485516;
	Thu, 21 Jan 2021 07:52:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C922C088B;
	Thu, 21 Jan 2021 07:52:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE4CC013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 07:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 31B0D8560E
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 07:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NHie-fv28qxI for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 07:52:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9C71E85516
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 07:52:05 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id m1so71035wrq.12
 for <iommu@lists.linux-foundation.org>; Wed, 20 Jan 2021 23:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8oRMVgXTTtZZl0t+edBJix5UUYLc6dLj900da8EQmuk=;
 b=G55vCALv8HZuSXjR6w5mk5061SvQLWids/qXihhGmJ3EiU+cWG204AmSAari+vlK9G
 hwQrAc3zhnu4MdfWqvQoe0pZm9zW5RqEJtQiIU43lVH83Lp5fkOVBwdSqg0rUitA3jWX
 nxkj0Z/OKkUGaWDChzM7byFm9Lv7FBiEgIFNF2kmEI3fcwuHpVCxdFMtZA6ZIf8wUh9j
 /gQehFw+Vxgoel92e6O5vmFJMXm3m91SPcNw7l6By+Hu4fGAHQUepdIBYoAuDXkDP4Wu
 R+L+0zxviiyaIluotT8zMRptqqZCg5cDzA1bLqPQZAwuVghY0qBgYE1ckvPOwsW9hUhL
 yBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8oRMVgXTTtZZl0t+edBJix5UUYLc6dLj900da8EQmuk=;
 b=rRyYpvMun9VqO+43pjGhu8Kf6kg2Q/1KE22URlDM9XrD4FiNbWdmx32L20fO+zkI56
 3IsWsCyfPJEW6AXXD+kSnegFmSNAeBns1FUzqEUsXxoB6IXYdcVZjLkvggcdkWaE5R87
 uZ3neyLPLXdEeDEOGnEpKVsXO1q3Q+PFitWIhVHPR8rMIQRP1DLrWngIQczx6WE6MJV/
 ONynKBWUatIwMK7b95MYUfdPjOSnw+pde6B24/S68SXN+77pXi+oJCTLnDCFc8ZmHLKM
 Btc90P6tqIgYAK8XzmmI9IMNTKnlI0xHgKHvuLfh+bALADaFd0kC5COjcxtmacnmvXo8
 HZ5w==
X-Gm-Message-State: AOAM530PR4vIhvuO3NntDl2TI6sJ8b8QZxpPoGMPiAbgvhyolrggOMYM
 9zqgyUMD0gKLKrLJ/fpjzN4SLc2F/fZn8pO+FEE=
X-Google-Smtp-Source: ABdhPJwD87R3jYKAxjc1cN8PtBV0u9ziqbJf5lJT4+qMB0LSpMtCa5lHXnxg5FFoaDXZq0JeoPao7VnAoAQN4bkmn/w=
X-Received: by 2002:adf:9427:: with SMTP id 36mr12865530wrq.271.1611215524060; 
 Wed, 20 Jan 2021 23:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20201223111633.1711477-1-zhang.lyra@gmail.com>
 <20210108022545.GA1744725@robh.at.kernel.org>
 <CAAfSe-svn4ACvhk3McO7APLLSKdC=9ei7bvmD9ZhnSosnLQ1AA@mail.gmail.com>
 <CAL_JsqKqi_tngaR0nHpjbQz2Q8QnwJ+Ea=DghT6xqR9U8o-5CQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKqi_tngaR0nHpjbQz2Q8QnwJ+Ea=DghT6xqR9U8o-5CQ@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 21 Jan 2021 15:51:27 +0800
Message-ID: <CAAfSe-vxkbmubYMbP+mvj9wUrrfjcoOCXyzo2VSVn4eanK1niA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iommu: add bindings for sprd iommu
To: Rob Herring <robh@kernel.org>
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

On Wed, 13 Jan 2021 at 21:47, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 8, 2021 at 5:34 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > On Fri, 8 Jan 2021 at 10:25, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Dec 23, 2020 at 07:16:32PM +0800, Chunyan Zhang wrote:
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > This patch only adds bindings to support display iommu, support for others
> > > > would be added once finished tests with those devices, such as Image
> > > > codec(jpeg) processor, a few signal processors, including VSP(video),
> > > > GSP(graphic), ISP(image), and camera CPP, etc.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > >  .../devicetree/bindings/iommu/sprd,iommu.yaml | 44 +++++++++++++++++++
> > > >  1 file changed, 44 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > > new file mode 100644
> > > > index 000000000000..4d9a578a7cc9
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > > @@ -0,0 +1,44 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +# Copyright 2020 Unisoc Inc.
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Unisoc IOMMU and Multi-media MMU
> > > > +
> > > > +maintainers:
> > > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - sprd,iommu-disp
> > >
> > > Needs to be Soc specific.
> >
> > All SoCs so far use the same iommu IP, there's a little different
> > among different iommu users.
>
> That's what everyone says. Be warned that you cannot add properties
> for any differences that come up whether features or errata.

Ok, I will use a version specific compatible string.

>
> > > Is this block specific to display subsys or
> > > that just happens to be where the instance is?
> >
> > This iommu driver can serve many subsystem devices, such as Video,
> > Camera, Image, etc., but they have their own iommu module which looks
> > like a subdevice embedded in the master devices.
> > I will add more compatible strings for those devices when needed.
> > For now, only this one was listed here because I just tested this
> > iommu driver with DPU only.
>
> The iommu binding takes care of what each one is connected to. Is each
> instance different in terms of features or programming model? If not,

The one difference so far is the register offset which is not the same
for different instances.

Thanks for the review.
Chunyan

> then you shouldn't have different compatible strings for each
> instance.
>
> Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
