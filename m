Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD48C433DB
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 06:12:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFEB64E38
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 06:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFEB64E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9C974336D;
	Fri, 26 Feb 2021 06:12:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yH7cePxsnH29; Fri, 26 Feb 2021 06:12:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8490843226;
	Fri, 26 Feb 2021 06:12:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A98FC000A;
	Fri, 26 Feb 2021 06:12:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 078FCC0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 06:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCC43432AA
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 06:12:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ckgluEaPSFd for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 06:12:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5200043226
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 06:12:23 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id e10so7223164wro.12
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 22:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9zo55mBo3m4Uke2mk+X1npLwGmzEk63Firuv6qer8Fw=;
 b=mWSpZYZCWd7pJFziAgN9srzEloyViWSX8sX0gWYeY3XOzLdp4BeOL0ae4hFzdTUUse
 Kv+UW1r3lwO8wYCXDHBoizeshtps2BJN1tEqE8PpOKWNN7AKffmNagOs/NQtTnZSJS6Z
 rfuMMDszkeVe+sw2PFVc5sA7RKWfzHiTYpdoqCEVc2bK//A+NTWS5h9bH7M15YGRna9P
 3uUiWbHR386Xt8fuEqPXDLrvkyL414K6rxE9rIuQyzTpfp74XgdCIOpJv0NVcvhaO8QS
 Edvn/uocBRNM7AU2YcMklKhJHDUDVb5W2FTEFhtcgVad4kbphAp01+DRPt5BZ/clwSUm
 rr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9zo55mBo3m4Uke2mk+X1npLwGmzEk63Firuv6qer8Fw=;
 b=osSa3RVR9um3lDR0/K87fZU52jgjhdVt1NLYaeU9Iopqa4moTMzQ5vv7VDjzw6hzUJ
 2q3S7H64NXZXmcSYSei5zL4yee6LKc37PGblWNu8d+6oeIYexiscpMykaeFqUsucmVL2
 Rf+5DddIOMs52x2E619EeTmFxNAIrtJWKf1t3+XPq+ZhiZFEHtlizM7i8ZxCVKk357hv
 gOd403h3GMjCT48z6q0799bsxTUALpTVnCGsJ5y0WA4/ax7AWYLd2Yu8hNex2B19MKj5
 rbiW8LuuMZrXOIJAEs7X9KLoEpRzAFJPA9WimX4eXJw+SlXT7qQPmf8E2ot/OKa4LCqj
 A5gg==
X-Gm-Message-State: AOAM530AziriKhjxSwZtAmSnYz3aVnCmHJob0c+G/z4zU2oS3yG10wLu
 Y8Dg4WpzAwR8S2YjRcFrCVAaQZkPya/sKE9vxKk=
X-Google-Smtp-Source: ABdhPJxKzLEZ3xO/S2BzR5WJV668wwfXYZulkobX79JcXqbCAN5gDzPqlzOC3EGbvgC8deMTZ3JQPvzq3sO3C68B5wE=
X-Received: by 2002:a5d:4905:: with SMTP id x5mr1365250wrq.201.1614319941250; 
 Thu, 25 Feb 2021 22:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20210203090727.789939-1-zhang.lyra@gmail.com>
 <20210203090727.789939-2-zhang.lyra@gmail.com>
 <20210204232549.GA1305874@robh.at.kernel.org>
 <CAAfSe-tQ+7GuO1PgYa=9wqrpVf3N4br=bn8gJcaEJmnYpc1sxA@mail.gmail.com>
 <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
In-Reply-To: <CAL_JsqLi3vJ2tDrwa3YL1rdxtAYWnA72rxCRNPtz_EzvWhTn7w@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 26 Feb 2021 14:11:44 +0800
Message-ID: <CAAfSe-sDgrpzL+yo7KAXFeEfEh+9F22cbiUv8BqQTG7gtO5bzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
To: Rob Herring <robh@kernel.org>
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Thu, 11 Feb 2021 at 03:21, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Feb 5, 2021 at 1:21 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, 5 Feb 2021 at 07:25, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > This iommu module can be used by Unisoc's multimedia devices, such as
> > > > display, Image codec(jpeg) and a few signal processors, including
> > > > VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > >  .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
> > > >  1 file changed, 72 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > > new file mode 100644
> > > > index 000000000000..4fc99e81fa66
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > > @@ -0,0 +1,72 @@
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
> > > > +      - sprd,iommu-v1
> > > > +
> > > > +  "#iommu-cells":
> > > > +    const: 0
> > > > +    description:
> > > > +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> > > > +      additional information needs to associate with its master device.
> > > > +      Please refer to the generic bindings document for more details,
> > > > +      Documentation/devicetree/bindings/iommu/iommu.txt
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      Not required if 'sprd,iommu-regs' is defined.
> > > > +
> > > > +  clocks:
> > > > +    description:
> > > > +      Reference to a gate clock phandle, since access to some of IOMMUs are
> > > > +      controlled by gate clock, but this is not required.
> > > > +
> > > > +  sprd,iommu-regs:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +    description:
> > > > +      Reference to a syscon phandle plus 1 cell, the syscon defines the
> > > > +      register range used by the iommu and the media device, the cell
> > > > +      defines the offset for iommu registers. Since iommu module shares
> > > > +      the same register range with the media device which uses it.
> > > > +
> > > > +required:
> > > > +  - compatible
> > > > +  - "#iommu-cells"
> > > > +
> > > > +oneOf:
> > > > +  - required:
> > > > +      - reg
> > > > +  - required:
> > > > +      - sprd,iommu-regs
> > > > +
> > > > +additionalProperties: false
> > > > +
> > > > +examples:
> > > > +  - |
> > > > +    iommu_disp: iommu-disp {
> > > > +      compatible = "sprd,iommu-v1";
> > > > +      sprd,iommu-regs = <&dpu_regs 0x800>;
> > >
> > > If the IOMMU is contained within another device, then it should just be
> > > a child node of that device.
> >
> > Yes, actually IOMMU can be seen as a child of multimedia devices, I
> > considered moving IOMMU under into multimedia device node, but
> > multimedia devices need IOMMU when probe[1], so I dropped that idea.
>
> Don't design your binding around working-around linux issues.
>
> > And they share the same register base, e.g.
> >
> > +               mm {
> > +                       compatible = "simple-bus";
> > +                       #address-cells = <2>;
> > +                       #size-cells = <2>;
> > +                       ranges;
> > +
> > +                       dpu_regs: syscon@63000000 {
>
> Drop this node.
>
> > +                               compatible = "sprd,sc9863a-dpuregs", "syscon";
> > +                               reg = <0 0x63000000 0 0x1000>;
> > +                       };
> > +
> > +                       dpu: dpu@63000000 {
> > +                               compatible = "sprd,sharkl3-dpu";
> > +                               sprd,disp-regs = <&dpu_regs>;
>
> reg = <0 0x63000000 0 0x800>;
>
> > +                               iommus = <&iommu_dispc>;
> > +                       };
> > +
> > +                       iommu_dispc: iommu@63000000 {
> > +                               compatible = "sprd,iommu-v1";
> > +                               sprd,iommu-regs = <&dpu_regs 0x800>;
>
> reg = <0 0x63000800 0 0x800>;

Alright, considering you deprecate using syscon to map registers here,
I will drop that.
But that would cause the same physical address to be mapped two times at least.
And this is not a single case, since there are a few media devices and
their IOMMUs which all have this issue.

Thanks,
Chunyan

>
> > +                               #iommu-cells = <0>;
>
> Though given it seems there is only 1 client and this might really be
> just 1 h/w block, you don't really need to use the iommu binding at
> all. The DPU should be able to instantiate it's own IOMMU device.
> There's other examples of this such as mali GPU though that is all one
> driver, but that's a Linux implementation detail.
>
> Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
