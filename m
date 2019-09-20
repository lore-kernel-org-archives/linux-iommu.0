Return-Path: <SRS0=xPYy=XP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D15C4CEC9
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 14:40:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033982086A
	for <iommu@archiver.kernel.org>; Fri, 20 Sep 2019 14:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+ckRcOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033982086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CA11BCB1;
	Fri, 20 Sep 2019 14:40:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5C07DC8B
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 14:40:20 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39AB0108
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 14:40:19 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
	[209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C94902086A
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568990418;
	bh=w5tYeug1R2mxVT3RRStiSka22psHpZ2y2hQYY5KJCsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r+ckRcOdeGwSquI3pIgU+xFw2oMG4K0h9EvrGEN0nU4+xoJg4F/KwkhlAfJuTK4nd
	hUKoP2QESAumEOuWCSOeP40e+bertyTlmh2nEl3Cs8ny0jvqGamgztAvj7Cb7idZup
	MjX4FgQBDctKRCyj4S9+m4GFYRo1X6A8ISMKvG5w=
Received: by mail-qt1-f173.google.com with SMTP id j31so8928774qta.5
	for <iommu@lists.linux-foundation.org>;
	Fri, 20 Sep 2019 07:40:18 -0700 (PDT)
X-Gm-Message-State: APjAAAUOVErcH+0p6s6eMIOu0IWM7WN4RaJv9E9miMpDVVZpu+IPPYGt
	ysHMSZn6HEimGjFQs8nNzYp5sXKZH5ByuQVzXw==
X-Google-Smtp-Source: APXvYqyVo5dyO/cVk4f8RdytA/CVTD1Ln+9JQR1Sut4HCLTGqsiKBfT/NQQfR68qW4LY93kib5+j6RMgXLDcgp933gs=
X-Received: by 2002:ac8:6982:: with SMTP id o2mr3622618qtq.143.1568990417965; 
	Fri, 20 Sep 2019 07:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190920134829.16432-1-robh@kernel.org>
	<20190920134829.16432-2-robh@kernel.org>
	<8e9f4a42-defa-8dfe-2547-174395ef8b5d@arm.com>
In-Reply-To: <8e9f4a42-defa-8dfe-2547-174395ef8b5d@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 20 Sep 2019 09:40:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJCZDb_C-fHm6KfDQAZ=Gek8pbJfBHMv=6xaf74-h9aYA@mail.gmail.com>
Message-ID: <CAL_JsqJCZDb_C-fHm6KfDQAZ=Gek8pbJfBHMv=6xaf74-h9aYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iommu: Convert Arm SMMUv3 to DT schema
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Sep 20, 2019 at 9:17 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 20/09/2019 14:48, Rob Herring wrote:
> > Convert the Arm SMMv3 binding to the DT schema format.
> >
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <Robin.Murphy@arm.com>
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../devicetree/bindings/iommu/arm,smmu-v3.txt |  77 -------------
> >   .../bindings/iommu/arm,smmu-v3.yaml           | 103 ++++++++++++++++++
> >   2 files changed, 103 insertions(+), 77 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> >   create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml

> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> > new file mode 100644
> > index 000000000000..1c97bcfbf82b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/arm,smmu-v3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM SMMUv3 Architecture Implementation
> > +
> > +maintainers:
> > +  - Will Deacon <will@kernel.org>
> > +  - Robin Murphy <Robin.Murphy@arm.com>
> > +
> > +description: |+
> > +  The SMMUv3 architecture is a significant departure from previous
> > +  revisions, replacing the MMIO register interface with in-memory command
> > +  and event queues and adding support for the ATS and PRI components of
> > +  the PCIe specification.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^iommu@[0-9a-f]*"
> > +  compatible:
> > +    const: arm,smmu-v3
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 4
> > +
> > +  interrupt-names:
> > +    oneOf:
> > +      - const: combined
> > +        description:
> > +          The combined interrupt is optional, and should only be provided if the
> > +          hardware supports just a single, combined interrupt line.
> > +          If provided, then the combined interrupt will be used in preference to
> > +          any others.
> > +      - items:
> > +          - const: eventq     # Event Queue not empty
> > +          - const: priq       # PRI Queue not empty
> > +          - const: cmdq-sync  # CMD_SYNC complete
> > +          - const: gerror     # Global Error activated
> > +      - items:
> > +          - const: eventq
> > +          - const: gerror
> > +          - const: priq
> > +      - items:
> > +          - const: eventq
> > +          - const: gerror
> > +      - items:
> > +          - const: eventq
> > +          - const: priq
>
> This looks a bit off - in the absence of MSIs, at least "gerror" and
> "eventq" should be mandatory; "cmdq-sync" should probably also be from a
> binding perspective, but Linux doesn't care about it. PRI is an optional
> feature of the architecture, so that IRQ should always be optional. If
> we do have MSIs, then technically the implementation is allowed to not
> support wired IRQs at all, although in practice is likely to have at
> least "gerror" to signal the double-fault condition of a GERROR MSI
> write aborting.

Well, now I'm not sure where I came up with the last case, it can be
dropped. These are the cases we have:

arch/arm64/boot/dts/arm/fvp-base-revc.dts:
interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
arch/arm64/boot/dts/hisilicon/hip07.dtsi:
interrupt-names = "eventq", "gerror", "priq";
arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:
interrupt-names = "eventq", "gerror";

I'm fine if we leave warnings and expect dts files to be fixed.

In an ideal world we'd have this with optional irq on the end:

      - minItems: 3
        maxItems: 4
        items:
          - const: eventq     # Event Queue not empty
          - const: cmdq-sync  # CMD_SYNC complete
          - const: gerror     # Global Error activated
          - const: priq       # PRI Queue not empty


A less invasive approach would be:

      - items:
          - const: eventq     # Event Queue not empty
          - const: priq       # PRI Queue not empty
          - const: cmdq-sync  # CMD_SYNC complete
          - const: gerror     # Global Error activated
      - minItems: 2
        maxItems: 4
        items:
          - const: eventq
          - const: gerror
          - const: priq
          - const: cmdq-sync

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
