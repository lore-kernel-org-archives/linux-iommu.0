Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234BA22F03
	for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 23:04:52 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-26598fc0825so956494a91.0
        for <iommu@lists.linux.dev>; Wed, 19 Jul 2023 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689807892; x=1690412692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wFr2A7e5EWp+82eThYDiZpPT27i18/NTWE7QU00Iwo=;
        b=slUMxadFiLxH+NNFI2NDyiI0rQr8f9NpvfLLOhGsjG3O87r0bcZpvKpTPwrunBBgix
         s/cmHJkDCRHbplL0GzIVCbuqXlBFs039EcAQnx/flZ5Gi3JAt3TD2pmwnkRjudretQiH
         rf8DuUSwKLwPAf7m42dHVlr5ByBa/4G2j8KhQXtOVRYJi4VOuqhwjMJmXrdnuY/vUCg6
         IJvX1PACNIQsf2fy+lpfsr/+zhR0OBdjb7pFzsHns2AkYah12SDiIGpNSUaoZRF/ZfF7
         y7f7lA8GAqyp8kfSzHTLXKliOVE+L8A6yKVC/BCLClsl7shxYfGKJKgP1iCRG5ps0bPw
         qp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689807892; x=1690412692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wFr2A7e5EWp+82eThYDiZpPT27i18/NTWE7QU00Iwo=;
        b=Tb/tEb4hShvV6xZvAapZZiX8Lb0tKdCPWD431XmNu6TeTpmroaSrUXSBSzablxtGHH
         jhB9YTqM3HQ6HXys32T/TczYefYzUKTVYplp6v/oUGzaUU4gSUOol15F6wxqZEQYCR/z
         yHFO9ZUS4Wfc/J7v8E8hdgYRQwaF30I6kJHOMOjmsoBNsMrdjnrIOlKJApHF/OHT2UiM
         Aw/kmthDzwRysai74daautkHN7zPJC5eVr1tz0jr1LCuFlSULp+LuVDg9WBc+TG8TD2J
         Rf1/03hNHNhUslmmSzAeTD+FARW9Jw/bKGl6Y+UHTjRflEC9X3epXvUDzx/NCANYv4Ye
         PF/A==
X-Gm-Message-State: ABy/qLbJQLNZ6udabcWy//E7QKLz44PUJay7NQsIKDo6gAe7oHA1BUSg
	55VTGSA7r96MJXSE/LDu9D1TfArID2h4VhaETzth+g==
X-Google-Smtp-Source: APBJJlGO9EDGVzmVIbzDbaW4q/7xWmaTWhlijEvEV5ktsCXxLMGAAqX7MC+JIcF9coSbnKNUULA6G0T3b0h/46L1VCU=
X-Received: by 2002:a17:90a:72c8:b0:261:326d:99e8 with SMTP id
 l8-20020a17090a72c800b00261326d99e8mr4688870pjk.2.1689807892181; Wed, 19 Jul
 2023 16:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <20230719-unnoticed-scion-744fdf509151@spud> <CAL_JsqLsb801Z4H7+ViboBSGwd+XidcpYcJMHgw+6fofsXB=9Q@mail.gmail.com>
In-Reply-To: <CAL_JsqLsb801Z4H7+ViboBSGwd+XidcpYcJMHgw+6fofsXB=9Q@mail.gmail.com>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 19 Jul 2023 16:04:41 -0700
Message-ID: <CAH2o1u5VdOx+MgQFyjEr1__DZmsxLGGqf8v1pDvTHoPJ4OGfGA@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To: Rob Herring <robh+dt@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Anup Patel <apatel@ventanamicro.com>, Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, 
	linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, linux-riscv@lists.infradead.org, 
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 2:37=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Wed, Jul 19, 2023 at 2:19=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > Hey Tomasz,
> >
> > On Wed, Jul 19, 2023 at 12:33:47PM -0700, Tomasz Jeznach wrote:
> > > From: Anup Patel <apatel@ventanamicro.com>
> > >
> > > We add DT bindings document for RISC-V IOMMU platform and PCI devices
> > > defined by the RISC-V IOMMU specification.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >
> > Your signoff is missing from here.
> >
> > Secondly, as get_maintainer.pl would have told you, dt-bindings patches
> > need to be sent to the dt-binding maintainers and list.
> > +CC maintainers & list.
> >
> > Thirdly, dt-binding patches should come before their users.
> >
> > > ---
> > >  .../bindings/iommu/riscv,iommu.yaml           | 146 ++++++++++++++++=
++
> > >  1 file changed, 146 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iom=
mu.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml=
 b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > new file mode 100644
> > > index 000000000000..8a9aedb61768
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > > @@ -0,0 +1,146 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RISC-V IOMMU Implementation
> > > +
> > > +maintainers:
> > > +  - Tomasz Jeznach <tjeznach@rivosinc.com>
> >
> > What about Anup, who seems to have written this?
> > Or your co-authors of the drivers?
> >
> > > +
> > > +description:
> > > +  The RISC-V IOMMU specificaiton defines an IOMMU for RISC-V platfor=
ms
>
> typo
>

ack

> > > +  which can be a regular platform device or a PCI device connected t=
o
> > > +  the host root port.
> > > +
> > > +  The RISC-V IOMMU provides two stage translation, device directory =
table,
> > > +  command queue and fault reporting as wired interrupt or MSIx event=
 for
> > > +  both PCI and platform devices.
>
> TBC, you want a PCI device that's an IOMMU and the IOMMU serves
> (provides translation for) PCI devices?
>

Yes, IOMMU as a PCIe device providing address translation services for
connect PCIe root complex.

> > > +
> > > +  Visit https://github.com/riscv-non-isa/riscv-iommu for more detail=
s.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - description: RISC-V IOMMU as a platform device
>
> "platform device" is a Linux term. Don't use Linux terms in bindings.
>

ack.


> > > +        items:
> > > +          - enum:
> > > +              - vendor,chip-iommu
> >
> > These dummy compatibles are not valid, as was pointed out to Anup on
> > the AIA series. Please go look at what was done there instead:
> > https://lore.kernel.org/all/20230719113542.2293295-7-apatel@ventanamicr=
o.com/
> >
> > > +          - const: riscv,iommu
> > > +
> > > +      - description: RISC-V IOMMU as a PCI device connected to root =
port
> > > +        items:
> > > +          - enum:
> > > +              - vendor,chip-pci-iommu
> > > +          - const: riscv,pci-iommu
> >
> > I'm not really au fait with the arm smmu stuff, but do any of its
> > versions support being connected to a root port?
>
> PCI devices have a defined format for the compatible string based on
> VID/PID. For PCI, also usually don't need to be described in DT
> because they are discoverable. The exception is when there's parts
> which aren't. Which parts aren't?
>

We've put 'riscv,pci-iommu' node here to describe relationship between PCIe
devices and IOMMU(s), needed for the pcie root complex description (iommu-m=
ap).
If there is a better way to reference PCI-IOMMU without adding
pci-iommu definition
that would solve the problem. Every other property of pci-iommu should
be discoverable.

> > > +  reg:
> > > +    maxItems: 1
> > > +    description:
> > > +      For RISC-V IOMMU as a platform device, this represents the MMI=
O base
> > > +      address of registers.
> > > +
> > > +      For RISC-V IOMMU as a PCI device, this represents the PCI-PCI =
bridge
>
> Your IOMMU is also a PCI-PCI bridge? Is that a normal PCI thing?
>

It's allowed to be integrated with root complex / IO bridge, but it is
as a separate PCIe device.
I'll clarify the description.

>
> > > +      details as described in Documentation/devicetree/bindings/pci/=
pci.txt
>
> Don't refer to pci.txt. It is going to be removed.
>

ack.

> > > +
> > > +  '#iommu-cells':
> > > +    const: 2
> > > +    description: |
> >
> > |s are only needed where formatting needs to be preserved.
> >
> > > +      Each IOMMU specifier represents the base device ID and number =
of
> > > +      device IDs.
>
> Doesn't that assume device IDs are contiguous? Generally not a safe assum=
ption.
>

ack.

> > > +
> > > +  interrupts:
> > > +    minItems: 1
> > > +    maxItems: 16
> >
> > What are any of these interrupts?
> >
> > > +    description:
> > > +      The presence of this property implies that given RISC-V IOMMU =
uses
> > > +      wired interrupts to notify the RISC-V HARTS (or CPUs).
> > > +
> > > +  msi-parent:
> > > +    description:
> > > +      The presence of this property implies that given RISC-V IOMMU =
uses
> > > +      MSIx to notify the RISC-V HARTs (or CPUs). This property shoul=
d be
> > > +      considered only when the interrupts property is absent.
>
> This doesn't make sense for a PCI device. PCI defines its own way to
> describe MSI support.
>

Agree, this is for IOMMU as a non-PCI device, capable of sending MSI.
Follows 'MSI clients' notes from
devicetree/bindings/interrupt-controller/msi.txt
Is this a proper way to describe this relationship?

> > > +
> > > +  dma-coherent:
> >
> > RISC-V is dma-coherent by default, should this not be dma-noncoherent
> > instead?
> >
> > > +    description:
> > > +      Present if page table walks and DMA accessed made by the RISC-=
V IOMMU
> > > +      are cache coherent with the CPU.
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - '#iommu-cells'
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    /* Example 1 (IOMMU platform device with wired interrupts) */
> > > +    immu1: iommu@1bccd000 {
> >
> > Why is this "immu"? typo or intentional?
> >
> > > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > > +        reg =3D <0x1bccd000 0x1000>;
> > > +        interrupt-parent =3D <&aplic_smode>;
> > > +        interrupts =3D <32 4>, <33 4>, <34 4>, <35 4>;
> > > +        #iommu-cells =3D <2>;
> > > +    };
> > > +
> > > +    /* Device with two IOMMU device IDs, 0 and 7 */
> > > +    master1 {
> > > +        iommus =3D <&immu1 0 1>, <&immu1 7 1>;
> > > +    };
> > > +
> > > +  - |
> > > +    /* Example 2 (IOMMU platform device with MSIs) */
> > > +    immu2: iommu@1bcdd000 {
> > > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > > +        reg =3D <0x1bccd000 0x1000>;
> > > +        msi-parent =3D <&imsics_smode>;
> > > +        #iommu-cells =3D <2>;
> > > +    };
> > > +
> > > +    bus {
> > > +        #address-cells =3D <2>;
> > > +        #size-cells =3D <2>;
> > > +
> > > +        /* Device with IOMMU device IDs ranging from 32 to 64 */
> > > +        master1 {
> > > +                iommus =3D <&immu2 32 32>;
> > > +        };
> > > +
> > > +        pcie@40000000 {
> > > +            compatible =3D "pci-host-cam-generic";
> > > +            device_type =3D "pci";
> > > +            #address-cells =3D <3>;
> > > +            #size-cells =3D <2>;
> > > +            bus-range =3D <0x0 0x1>;
> > > +
> > > +            /* CPU_PHYSICAL(2)  SIZE(2) */
>
> I'm guessing there was more after this, but I don't have it...

Complete patch 3 is at:
https://lore.kernel.org/linux-iommu/cover.1689792825.git.tjeznach@rivosinc.=
com/T/#mbf8dc4098fb09b87b2618c5c545ae882f11b114b

>
> Guessing, immu2 is a PCI device, but it translates for master1 which
> is not a PCI device? Weird. Why would anyone build such a thing?
>

In this example immu2 is a non-PCI device. Agree, otherwise would be weird.

>
> Rob

Thank you,
- Tomasz
