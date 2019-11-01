Return-Path: <SRS0=gESx=YZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA91DCA9ED1
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 20:14:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800A3217D9
	for <iommu@archiver.kernel.org>; Fri,  1 Nov 2019 20:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlmgLXRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800A3217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4360AF05;
	Fri,  1 Nov 2019 20:14:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4829AEFE
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 20:14:19 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 400F4466
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 20:14:18 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
	[209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id EA25F217D9
	for <iommu@lists.linux-foundation.org>;
	Fri,  1 Nov 2019 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572639258;
	bh=lunQWXbwftcs+7yMIfaidOHeL/YqBSClHBky0SgR7wE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SlmgLXRPl8uHE7aS8/mxIJwrV+QM8AjbfFFjnKWsVER1NKG6OJUlmsyMlqS2j5/03
	Yz+VihHaTAxeZ64FLgSxIc1CQAc8zZ1QDs/DnDFMC0LVmWctfLquTW8WOv3axVgF2i
	KhAsk5JpmjV+3MYt7lIc/QWUSJeALIDLrsTjGILQ=
Received: by mail-qt1-f172.google.com with SMTP id h2so1298845qto.1
	for <iommu@lists.linux-foundation.org>;
	Fri, 01 Nov 2019 13:14:17 -0700 (PDT)
X-Gm-Message-State: APjAAAV81vKyaCHEKpvhfTy33TDsDsXZRZePfyQ3qEvU9NimwOxsiqJh
	a274Ig7r/lrZwf7FcMsDd6qVXhKvusw1yj1t8g==
X-Google-Smtp-Source: APXvYqz/2b6NY6NgvOJ9O/tsdBnbptM389ZP3WBQKZTSQtyeLNhU2JaoDSnbvE3OXtxsWr0M+t1QxgR/42oqb66jKSw=
X-Received: by 2002:ac8:7612:: with SMTP id t18mr1236558qtq.143.1572639257156; 
	Fri, 01 Nov 2019 13:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191014191256.12697-1-robh@kernel.org>
	<20191101170822.GE3603@willie-the-truck>
In-Reply-To: <20191101170822.GE3603@willie-the-truck>
From: Rob Herring <robh@kernel.org>
Date: Fri, 1 Nov 2019 15:14:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLd52KfOc62b6Lg0nwy=xYqyJvM5Nqu5QR_2tYVvZbWOA@mail.gmail.com>
Message-ID: <CAL_JsqLd52KfOc62b6Lg0nwy=xYqyJvM5Nqu5QR_2tYVvZbWOA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iommu: Convert Arm SMMUv3 to DT schema
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Robin Murphy <Robin.Murphy@arm.com>
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

On Fri, Nov 1, 2019 at 12:08 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Rob,
>
> On Mon, Oct 14, 2019 at 02:12:56PM -0500, Rob Herring wrote:
> > Convert the Arm SMMv3 binding to the DT schema format.
> >
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <Robin.Murphy@arm.com>
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> > - Refine interrupt definition based on Robin's comments
> >
> >  .../devicetree/bindings/iommu/arm,smmu-v3.txt |  77 --------------
> >  .../bindings/iommu/arm,smmu-v3.yaml           | 100 ++++++++++++++++++
> >  2 files changed, 100 insertions(+), 77 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> >  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>
> [...]
>
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> > new file mode 100644
> > index 000000000000..662cbc4592c9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> > @@ -0,0 +1,100 @@
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
> > +          - const: eventq     # Event Queue not empt
> > +          - const: priq       # PRI Queue not empty
> > +          - const: cmdq-sync  # CMD_SYNC complete
> > +          - const: gerror     # Global Error activated
> > +      - minItems: 2
> > +        maxItems: 4
> > +        items:
> > +          - const: eventq
> > +          - const: gerror
> > +          - const: priq
> > +          - const: cmdq-sync
>
> I find it a bit odd to say "minItems: 2" here since, for example, if you
> have an SMMU that supports PRI then you really want the PRIQ interrupt
> hooked up. The only one never care about in the current driver is cmdq-sync,
> but that's just a driver quirk.

I don't know. I'm just documenting what exists and doesn't seem like
an outright error. The one case is TI:

arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:
interrupt-names = "eventq", "gerror";

If we want to make priq conditionally required, then I need to know
which compatibles would imply supporting PRI. If that's discoverable,
then we can't really enforce the interrupt being present in the
schema.

> Also, if the thing supports MSIs then it might not have any wired interrupts
> at all. Hmm.

That would be why 'interrupts' is optional. The schema only applies if
a property is present.

> > +  '#iommu-cells':
> > +    const: 1
> > +
> > +  dma-coherent:
> > +    description: |
> > +      Present if page table walks made by the SMMU are cache coherent with the
> > +      CPU.
>
> This looks like you've taken the text from SMMUv2 by accident. For SMMUv3,
> it's not just about page table walks, but *any* DMA operations made by the
> SMMU (e.g. STE lookup). I don't see the need to change the current text tbh.

Indeed. I'll do a follow-up as I've already applied these 2 patches.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
