Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE2C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 08:59:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8E664F1E
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 08:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8E664F1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 01D42431CD;
	Thu,  4 Mar 2021 08:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhUsGKZnFOyq; Thu,  4 Mar 2021 08:59:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C860242FC4;
	Thu,  4 Mar 2021 08:59:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97304C000A;
	Thu,  4 Mar 2021 08:59:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5A68C0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 08:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 863CB6F5B7
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 08:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ywnqbLAchru for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 08:59:22 +0000 (UTC)
X-Greylist: delayed 01:39:27 by SQLgrey-1.8.0
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F4C76F5B6
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 08:59:22 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id o2so8318948wme.5
 for <iommu@lists.linux-foundation.org>; Thu, 04 Mar 2021 00:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e4pM5UzwJCaSA1xipkCauFzjQ9OrQvbh3Krxwlg6A34=;
 b=Td5CtP2JXZs3/z+onUhusDaS/j80xOxhLLTBHnmC2rlv7gQbVZaoasHlCAihJpjy3f
 1pn43gUjayYEoX2t50IEoWfDWvSM8yNa1lJKXDRVn3A9XIKqwS21w2G9f/XVkvcBfvB1
 sgcrIpMNzLP+UKxP4w3TkoUg5MrBmbdI03BIqawDkqvjhyTYLihP9ZOIH9sYUX38PwqG
 7YucHosRHqBc+uLsycdLK9PkJSoHCErCYTvEzxvfZR/uBEApK+X5iqsI44QqHz6fm0nF
 d/UsWBaKW8wkdfERPQCu0ifMUC8uvblyosKkaNHT4o4Ul3YSuBGxDQYuQtLPIZzXY7Gc
 8K5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e4pM5UzwJCaSA1xipkCauFzjQ9OrQvbh3Krxwlg6A34=;
 b=dH0NuFXN5hvHgooH4T55uz6hjNZQWP2W6f6NsGoMcj59mjGfS9appV+p6vo6I8cLxY
 SZBDji+yny7/sReWkF6tCosLhenNnfsDHaczVSKOp/c3TZ5du72d2IIQudmDcbRH1WfD
 GDqPcstoJdvotDusUMOOs3+kMrVc3KomU5iAKzCRCrEzOkB1qM1vF+PMEQTKBha/t2ql
 OlFh+0IxA9lVrUuIMIfjAPKqaW7/VQIz397gG8VwJsEq8QTaz1qvkxqW4+cR4+LcXgvM
 ib/srlsGtIeEtOeid6PpKmIl8JmHRFm41B/a8Hy/d6GMidA9NKC/5uzqI9k7wSwWXTfN
 YwJg==
X-Gm-Message-State: AOAM531cszasO2Fo2xzCMCtcyCdsWuiBnWQtnAQtVUW6GVvB49JjvzbW
 XiX6xFJwPBfFGwuQL3REiyYeH6xAvnXgYG7c5ayEClTv
X-Google-Smtp-Source: ABdhPJwYVUlui2AC7T6vQ81NWLGM2vgiDSy9t8fSLesvFTqaLJWz7p/s8gl+y3QYqTdSrvhjt4vWn78UHbdhRAPCeqE=
X-Received: by 2002:a1c:7402:: with SMTP id p2mr2286514wmc.43.1614841948026;
 Wed, 03 Mar 2021 23:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20210203090727.789939-1-zhang.lyra@gmail.com>
 <20210203090727.789939-2-zhang.lyra@gmail.com>
 <20210204232549.GA1305874@robh.at.kernel.org>
 <CAAfSe-tQ+7GuO1PgYa=9wqrpVf3N4br=bn8gJcaEJmnYpc1sxA@mail.gmail.com>
 <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
 <4b88182c-f3fb-20d5-de6f-7fd6eddbcba7@arm.com>
In-Reply-To: <4b88182c-f3fb-20d5-de6f-7fd6eddbcba7@arm.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 4 Mar 2021 15:11:51 +0800
Message-ID: <CAAfSe-t1+v6549K0==EcFgU3ghC=yEZ73e70QoJz_J3MXxWBxQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
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

Hi Robin,

On Tue, 16 Feb 2021 at 23:10, Robin Murphy <robin.murphy@arm.com> wrote:
>
> >>>
> >>> On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
> >>>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>>>
> >>>> This iommu module can be used by Unisoc's multimedia devices, such as
> >>>> display, Image codec(jpeg) and a few signal processors, including
> >>>> VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
> >>>>
> >>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>>> ---
> >>>>   .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
> >>>>   1 file changed, 72 insertions(+)
> >>>>   create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..4fc99e81fa66
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >>>> @@ -0,0 +1,72 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +# Copyright 2020 Unisoc Inc.
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Unisoc IOMMU and Multi-media MMU
> >>>> +
> >>>> +maintainers:
> >>>> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    enum:
> >>>> +      - sprd,iommu-v1
> >>>> +
> >>>> +  "#iommu-cells":
> >>>> +    const: 0
> >>>> +    description:
> >>>> +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> >>>> +      additional information needs to associate with its master device.
> >>>> +      Please refer to the generic bindings document for more details,
> >>>> +      Documentation/devicetree/bindings/iommu/iommu.txt
> >>>> +
> >>>> +  reg:
> >>>> +    maxItems: 1
> >>>> +    description:
> >>>> +      Not required if 'sprd,iommu-regs' is defined.
> >>>> +
> >>>> +  clocks:
> >>>> +    description:
> >>>> +      Reference to a gate clock phandle, since access to some of IOMMUs are
> >>>> +      controlled by gate clock, but this is not required.
> >>>> +
> >>>> +  sprd,iommu-regs:
> >>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>>> +    description:
> >>>> +      Reference to a syscon phandle plus 1 cell, the syscon defines the
> >>>> +      register range used by the iommu and the media device, the cell
> >>>> +      defines the offset for iommu registers. Since iommu module shares
> >>>> +      the same register range with the media device which uses it.
> >>>> +
> >>>> +required:
> >>>> +  - compatible
> >>>> +  - "#iommu-cells"
>
> OK, so apparently the hardware is not quite as trivial as my initial
> impression, and you should have interrupts as well.

I've checked with my colleagues for this issue. And like I explained
before, one sprd IOMMU serves one master device only, so interrupts
are handled by master devices rather than IOMMUs.

Chunyan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
