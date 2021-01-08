Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA68C433DB
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 11:34:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2F4239FC
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 11:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2F4239FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 67D0A2E12A;
	Fri,  8 Jan 2021 11:34:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdW3PsGvCSLh; Fri,  8 Jan 2021 11:34:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D2368204FC;
	Fri,  8 Jan 2021 11:34:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0CD3C088B;
	Fri,  8 Jan 2021 11:34:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB33FC013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 11:34:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B117B8730B
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 11:34:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 59-5xSc2n+3x for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 11:34:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 10746872F3
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 11:34:02 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id d26so8638877wrb.12
 for <iommu@lists.linux-foundation.org>; Fri, 08 Jan 2021 03:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nEc5wG3dILAGk32bL1jujPzJlzS0QKkC1c/kQMfY5N8=;
 b=hIFrMTB3S+rVuuFdrk8zk/CaNWPHJfeNY7BFvbSSacGai+bOhV7u6eN3HpUjKSV127
 iBBmZipZMLFv0uk96RlbxHnSqrGgR4vDmowkKeHwD3Q+BN4nvNrVaGMCncTjK+b4OK7z
 gl09CRyJ6oCv0zdGqkPx+na5S0dR0YoWaZrgfwWj7fDjnMES7OF8E13zV505q0IyRlwy
 tNyI8+P/Dwylvr92HvYe6+tIIt0WPIM5OEf9k9Nspok89WAZpA3ZZ1S5CxK8c3x6gRjr
 c0P7AghE0+VK/I9JDCCsakvYJgTTqpo4CdzCuBGr2Qbc8DWzrSrD3GS4vOrSNi3ircrt
 Tv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nEc5wG3dILAGk32bL1jujPzJlzS0QKkC1c/kQMfY5N8=;
 b=memzxjytDtpjx7XZcYCLqe9L/OhUxSfCVvvEOZMZdxvRQEx/TGhXxY130V3IPWycdE
 VW7PzkSxzxPCw+hB8tZHkEwZLG3lX7L9R/5RiVKH6DePlicR+iub+WZ5cchn11h6H/bz
 LrA4tBIqh5QjG+rPEHVd+rCeprmyuEPmUPlYDeoiYyD+mMCrZWUQoNuWCQX4lOxaYovk
 ESk6/7h2p/mimiCqPDe25zei2rNZ/D2vu74sU9NWHVOzKAKaOxEZ5U6fB2WsPUH0H12i
 huT4ZOLv4ZCrfDBk0ar5YuQ4coe6mikfobQxynpCihZ7d+v+3hPwNtcVkrsQDKHJGaTn
 hiMQ==
X-Gm-Message-State: AOAM533opOmOB83hEtlXVNO9+rbfTABJFjogoAGsYB78VzfGvDZTt699
 udrdKUhSVgdsztRhijjxuqqcTlegYTXbbJwr4sc=
X-Google-Smtp-Source: ABdhPJxoWjNkep0c2aYKAL7kFh3Z7DoXzlAjVZ7GuVFKaPKYi0xepL6M9O6IiOMlXmnqZPyeYImKYuC4797dnlCDJ60=
X-Received: by 2002:a5d:60c1:: with SMTP id x1mr3214644wrt.271.1610105640518; 
 Fri, 08 Jan 2021 03:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20201223111633.1711477-1-zhang.lyra@gmail.com>
 <20210108022545.GA1744725@robh.at.kernel.org>
In-Reply-To: <20210108022545.GA1744725@robh.at.kernel.org>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 8 Jan 2021 19:33:24 +0800
Message-ID: <CAAfSe-svn4ACvhk3McO7APLLSKdC=9ei7bvmD9ZhnSosnLQ1AA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iommu: add bindings for sprd iommu
To: Rob Herring <robh@kernel.org>
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sheng Xu <sheng.xu@unisoc.com>, iommu@lists.linux-foundation.org,
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

On Fri, 8 Jan 2021 at 10:25, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Dec 23, 2020 at 07:16:32PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > This patch only adds bindings to support display iommu, support for others
> > would be added once finished tests with those devices, such as Image
> > codec(jpeg) processor, a few signal processors, including VSP(video),
> > GSP(graphic), ISP(image), and camera CPP, etc.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../devicetree/bindings/iommu/sprd,iommu.yaml | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > new file mode 100644
> > index 000000000000..4d9a578a7cc9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2020 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Unisoc IOMMU and Multi-media MMU
> > +
> > +maintainers:
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sprd,iommu-disp
>
> Needs to be Soc specific.

All SoCs so far use the same iommu IP, there's a little different
among different iommu users.

> Is this block specific to display subsys or
> that just happens to be where the instance is?

This iommu driver can serve many subsystem devices, such as Video,
Camera, Image, etc., but they have their own iommu module which looks
like a subdevice embedded in the master devices.
I will add more compatible strings for those devices when needed.
For now, only this one was listed here because I just tested this
iommu driver with DPU only.

Thanks for the review.

Chunyan

>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#iommu-cells":
> > +    const: 0
> > +    description:
> > +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> > +      additional information needs to associate with its master device.
> > +      Please refer to the generic bindings document for more details,
> > +      Documentation/devicetree/bindings/iommu/iommu.txt
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#iommu-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    iommu_disp: iommu@63000000 {
> > +      compatible = "sprd,iommu-disp";
> > +      reg = <0x63000000 0x880>;
> > +      #iommu-cells = <0>;
> > +    };
> > +
> > +...
> > --
> > 2.25.1
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
