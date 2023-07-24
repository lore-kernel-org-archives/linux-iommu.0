Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD388495
	for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 10:02:49 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a5ac84718dso1188898b6e.0
        for <iommu@lists.linux.dev>; Mon, 24 Jul 2023 03:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690192969; x=1690797769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glVgMOBlk6krRKDVqM4t7+coA/DHkZd+9V/dSVyWnGo=;
        b=l5l0a99CuOkvst2jU9QH4Jpm8sBKzJv0FA8cwZ2kPlWH3WNJmX5VhkdLTqcOolAUjM
         +sR2UFKroTDhbM0LRQW5oEgCbtZ0VMfuLsYdOSCMirxav6A9qMzIDpqm1Awlw/uHFhXO
         XWmbDzAm6B168eaktYXCsnv0De8Wl+HdpqUp2N+Zo923C758eTL+FegCOJw7Sy0dIF14
         JtZ/JYYpm5AX98+rn3xugBTsiM2RWIjfkiOyyqXat5lhJXYPG5wXm+3iIcoF+5anF5Wb
         h6LawNDLLO/i4sogE5CMV2aaEGd6p4zSq/whjGa+FqG0YmoG2D8OPqqEMsJAdjeLXTCR
         yGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192969; x=1690797769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glVgMOBlk6krRKDVqM4t7+coA/DHkZd+9V/dSVyWnGo=;
        b=drPne1P1YaR0/OWuZEjCAtDyMPWV2rmq42IGap0MnqkdQ2r9eOibevhRfaca6niaxJ
         GIpEmUaRl9fVVbLZhYwfd+JR62S+4WzeXTWjUtsQABEWWK+NIo5Sl83p0zJtObWOLCD5
         ZffpxbjWUtDA6Mcdg7NQUyxabF3VP09BdopsoWYylH78GrqDlYhoOOvXQ8PjySFoZc4K
         C6CWxfrhJQ+9fUKfHvq/w/f8gEngRIBOfIpFw9Lm7S7JfOQIaGmHQJdf49SOoRgx0S5Y
         ZNa2pqKKP2VgK6l+7XEg6x8CHV71kMOMxlWGXuou97Mv4qm1ZcUZQqdRCGTQwLEZ54xQ
         dT8w==
X-Gm-Message-State: ABy/qLbiPGvTUNc/bDZ1i+r0BnodGm1N369P7/87/9JrCvc0Deq1H4LF
	fuXwYxQ1Ma3TOHcWFebuR8aPXtjQbjnddbRRkIeoJw==
X-Google-Smtp-Source: APBJJlGMwBbCN+hzml/lDlMjr2BaVefXkabAhTDi52ikxDjY5+i5FlaMC2k35YN3XGKxpSaIzDpqMl94fo/GoJTRJ24=
X-Received: by 2002:a05:6808:2082:b0:39e:940c:2a58 with SMTP id
 s2-20020a056808208200b0039e940c2a58mr11531190oiw.5.1690192969018; Mon, 24 Jul
 2023 03:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
In-Reply-To: <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 24 Jul 2023 15:32:36 +0530
Message-ID: <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To: Zong Li <zong.li@sifive.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com, 
	linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev, 
	Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 1:33=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Thu, Jul 20, 2023 at 3:35=E2=80=AFAM Tomasz Jeznach <tjeznach@rivosinc=
.com> wrote:
> >
> > From: Anup Patel <apatel@ventanamicro.com>
> >
> > We add DT bindings document for RISC-V IOMMU platform and PCI devices
> > defined by the RISC-V IOMMU specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../bindings/iommu/riscv,iommu.yaml           | 146 ++++++++++++++++++
> >  1 file changed, 146 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu=
.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b=
/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > new file mode 100644
> > index 000000000000..8a9aedb61768
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > @@ -0,0 +1,146 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V IOMMU Implementation
> > +
> > +maintainers:
> > +  - Tomasz Jeznach <tjeznach@rivosinc.com>
> > +
> > +description:
> > +  The RISC-V IOMMU specificaiton defines an IOMMU for RISC-V platforms
> > +  which can be a regular platform device or a PCI device connected to
> > +  the host root port.
> > +
> > +  The RISC-V IOMMU provides two stage translation, device directory ta=
ble,
> > +  command queue and fault reporting as wired interrupt or MSIx event f=
or
> > +  both PCI and platform devices.
> > +
> > +  Visit https://github.com/riscv-non-isa/riscv-iommu for more details.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - description: RISC-V IOMMU as a platform device
> > +        items:
> > +          - enum:
> > +              - vendor,chip-iommu
> > +          - const: riscv,iommu
> > +
> > +      - description: RISC-V IOMMU as a PCI device connected to root po=
rt
> > +        items:
> > +          - enum:
> > +              - vendor,chip-pci-iommu
> > +          - const: riscv,pci-iommu
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      For RISC-V IOMMU as a platform device, this represents the MMIO =
base
> > +      address of registers.
> > +
> > +      For RISC-V IOMMU as a PCI device, this represents the PCI-PCI br=
idge
> > +      details as described in Documentation/devicetree/bindings/pci/pc=
i.txt
> > +
> > +  '#iommu-cells':
> > +    const: 2
> > +    description: |
> > +      Each IOMMU specifier represents the base device ID and number of
> > +      device IDs.
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 16
> > +    description:
> > +      The presence of this property implies that given RISC-V IOMMU us=
es
> > +      wired interrupts to notify the RISC-V HARTS (or CPUs).
> > +
> > +  msi-parent:
> > +    description:
> > +      The presence of this property implies that given RISC-V IOMMU us=
es
> > +      MSIx to notify the RISC-V HARTs (or CPUs). This property should =
be
> > +      considered only when the interrupts property is absent.
> > +
> > +  dma-coherent:
> > +    description:
> > +      Present if page table walks and DMA accessed made by the RISC-V =
IOMMU
> > +      are cache coherent with the CPU.
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
>
> In RISC-V IOMMU, certain devices can be set to bypass mode when the
> IOMMU is in translation mode. To identify the devices that require
> bypass mode by default, does it be sensible to add a property to
> indicate this behavior?

Bypass mode for a device is a property of that device (similar to dma-coher=
ent)
and not of the IOMMU. Other architectures (ARM and x86) never added such
a device property for bypass mode so I guess it is NOT ADVISABLE to do it.

If this is REALLY required then we can do something similar to the QCOM
SMMU driver where they have a whitelist of devices which are allowed to
be in bypass mode (i.e. IOMMU_DOMAIN_IDENTITY) based their device
compatible string and any device outside this whitelist is blocked by defau=
lt.

Regards,
Anup

>
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#iommu-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    /* Example 1 (IOMMU platform device with wired interrupts) */
> > +    immu1: iommu@1bccd000 {
> > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > +        reg =3D <0x1bccd000 0x1000>;
> > +        interrupt-parent =3D <&aplic_smode>;
> > +        interrupts =3D <32 4>, <33 4>, <34 4>, <35 4>;
> > +        #iommu-cells =3D <2>;
> > +    };
> > +
> > +    /* Device with two IOMMU device IDs, 0 and 7 */
> > +    master1 {
> > +        iommus =3D <&immu1 0 1>, <&immu1 7 1>;
> > +    };
> > +
> > +  - |
> > +    /* Example 2 (IOMMU platform device with MSIs) */
> > +    immu2: iommu@1bcdd000 {
> > +        compatible =3D "vendor,chip-iommu", "riscv,iommu";
> > +        reg =3D <0x1bccd000 0x1000>;
> > +        msi-parent =3D <&imsics_smode>;
> > +        #iommu-cells =3D <2>;
> > +    };
> > +
> > +    bus {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        /* Device with IOMMU device IDs ranging from 32 to 64 */
> > +        master1 {
> > +                iommus =3D <&immu2 32 32>;
> > +        };
> > +
> > +        pcie@40000000 {
> > +            compatible =3D "pci-host-cam-generic";
> > +            device_type =3D "pci";
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            bus-range =3D <0x0 0x1>;
> > +
> > +            /* CPU_PHYSICAL(2)  SIZE(2) */
> > +            reg =3D <0x0 0x40000000 0x0 0x1000000>;
> > +
> > +            /* BUS_ADDRESS(3)  CPU_PHYSICAL(2)  SIZE(2) */
> > +            ranges =3D <0x01000000 0x0 0x01000000  0x0 0x01000000  0x0=
 0x00010000>,
> > +                     <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0 0=
x3f000000>;
> > +
> > +            #interrupt-cells =3D <0x1>;
> > +
> > +            /* PCI_DEVICE(3)  INT#(1)  CONTROLLER(PHANDLE)  CONTROLLER=
_DATA(2) */
> > +            interrupt-map =3D <   0x0 0x0 0x0  0x1  &aplic_smode  0x4 =
0x1>,
> > +                            < 0x800 0x0 0x0  0x1  &aplic_smode  0x5 0x=
1>,
> > +                            <0x1000 0x0 0x0  0x1  &aplic_smode  0x6 0x=
1>,
> > +                            <0x1800 0x0 0x0  0x1  &aplic_smode  0x7 0x=
1>;
> > +
> > +            /* PCI_DEVICE(3)  INT#(1) */
> > +            interrupt-map-mask =3D <0xf800 0x0 0x0  0x7>;
> > +
> > +            msi-parent =3D <&imsics_smode>;
> > +
> > +            /* Devices with bus number 0-127 are mastered via immu2 */
> > +            iommu-map =3D <0x0000 &immu2 0x0000 0x8000>;
> > +        };
> > +    };
> > +...
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
