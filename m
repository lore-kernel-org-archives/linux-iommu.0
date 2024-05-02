Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92417BB7
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618074; cv=none; b=GXjJHTjsvSS+oepSyQYEM7HkthMKbhwh7yhRPALO66wU+njnSkoIOaSjc0azZhTuYrQSIpEOHwoOEuA9dXV0tNWeOtSJ7G5ycI9rB2IC/neCrRhU/fgqQIewKCbfmJfjnUm1l7Mk02b1joxyFDiDLBbT4xETg3N7rdEOwpt0Oho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618074; c=relaxed/simple;
	bh=c5/18npna7cokPg+GlZCRxk0qeKrdo9en7tP0btN8aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIUcLvj7br23t+e6iELw4j55aqAmVVtTchlBST8/lLtMYoFRypg21n6pLl9JfysLdipeHoZq6tyLmh62vUOJdpObZg8V1Zz2yaEMFp29w/S1Cml8QOawXTE2w+LuZbFGji/QpRQmVqUKSk78+cVaWGCBK8GmfC/X8JwT++ZK6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=glC3roxN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="glC3roxN"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso4203117a12.3
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714618073; x=1715222873; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP/KuZI0POfhWHmoq8SYkLEP+ldgdnvaDs+rwf+L5m8=;
        b=glC3roxN3ipCFg26OXt9OeWSuXzb+yXXh7y6fFcpxqDUYvfkRorxkoQo6LTG3DH/r3
         irsA2T3Ph58JhFFPOfkrzbYeGrzLqcT48yhhW8RQXkGXKJ/PT+ZxVD3sI1QTy4qnGm/c
         Q4TRLDInRuzNSRMKX74MHQPLIiqvW+e5THgi8Co7vfrqdRzflcoKjdm0gVvzx0SebG2e
         w4GT7IvnY0cWHjJBCg0q6sFyBwNxrKiX2U3Npu9VmJtB/PnQM3Dj4NpToMde8aRQ8NQT
         7k1fS+Noe8FCcmO796SRsb7pNsokhGlrq464Y0YlQ07OHL1zTHQgYXJ2B+/miv21LyDP
         KDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714618073; x=1715222873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GP/KuZI0POfhWHmoq8SYkLEP+ldgdnvaDs+rwf+L5m8=;
        b=E3GgR8WdFEygrRwYZ9vKPY2HDmYGOF4kLkvcgmJPen9abXj66mKunIbNC8YpP0EIXO
         GMN2S0+62jY2DxPQLIAy9wa8Cep8pPb2jxQ/ay5FZFJPbgL6B0MUcypD5gYoRKhHqcaG
         CI8bh/qWcWMJoFNSvZhFIiHdV5mAFPOaH5d6t2TTZiIe+ff6sWGJwkfWSFUxf87d4v4H
         a3DPRUzDS1CLTYhD9SIemGeMeQwS8bigoClt5VzuseLIoDumjVcM2UkZv/WkNjvGoGGR
         pQpEw1oD9PIHRbznnWmHklHhZl5erhxILWkiUQ9xsZ0Ia1Zr9kYR+z2cN/F/HHvnNV+D
         qfyg==
X-Forwarded-Encrypted: i=1; AJvYcCW+Yw/5hwOAPiijapcm4qFsvht8XoAnhe1PFES+Et5kAohZxv+xn7e7kOR7voW69ASEoBwP8rZOYHpxTFRidV8fz8TsgWY=
X-Gm-Message-State: AOJu0YxNFOjbnZJjLuu+ONtRDJUqzgNy6dspvUuI9lvuAESsb0XLwhE7
	j8R2cHJMr8VPZl1do7Gq5gDxp0Uv5NUKylzCNaqD+jQhG5pL9fcOc7KD8/YWKYO2HuB3Lf8NUCj
	QC4aa8T1W9kPPv8LcE3QquiNMphSeUDsWq9lJqg==
X-Google-Smtp-Source: AGHT+IGDVdnxqTVaQkb/pOpymWWe0UOa43wgrfW0rd/E5LTOtvSXNJNdnJ7NqzGxYYZGqy1DnbogUq5s7kkVFpk2kmI=
X-Received: by 2002:a05:6a21:4983:b0:1a3:bdd5:41f6 with SMTP id
 ax3-20020a056a21498300b001a3bdd541f6mr4378224pzc.61.1714618072706; Wed, 01
 May 2024 19:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1714494653.git.tjeznach@rivosinc.com> <ef946892252b18f541986a461fc4d37957cc805e.1714494653.git.tjeznach@rivosinc.com>
 <20240501131556.GA2931109-robh@kernel.org>
In-Reply-To: <20240501131556.GA2931109-robh@kernel.org>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 1 May 2024 19:47:41 -0700
Message-ID: <CAH2o1u5OYORHNuBC17DHkRFm6D6b8qaQVep8vX4kVzJAkk36HA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
To: Rob Herring <robh@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 6:16=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 30, 2024 at 01:01:51PM -0700, Tomasz Jeznach wrote:
> > Add bindings for the RISC-V IOMMU device drivers.
> >
> > Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >  .../bindings/iommu/riscv,iommu.yaml           | 150 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 157 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu=
.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b=
/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > new file mode 100644
> > index 000000000000..16817525e157
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > @@ -0,0 +1,150 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/riscv,iommu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V IOMMU Architecture Implementation
> > +
> > +maintainers:
> > +  - Tomasz Jeznach <tjeznach@rivosinc.com>
> > +
> > +description: |
> > +  The RISC-V IOMMU provides memory address translation and isolation f=
or
> > +  input and output devices, supporting per-device translation context,
> > +  shared process address spaces including the ATS and PRI components o=
f
> > +  the PCIe specification, two stage address translation and MSI remapp=
ing.
> > +  It supports identical translation table format to the RISC-V address
> > +  translation tables with page level access and protection attributes.
> > +  Hardware uses in-memory command and fault reporting queues with wire=
d
> > +  interrupt or MSI notifications.
> > +
> > +  Visit https://github.com/riscv-non-isa/riscv-iommu for more details.
> > +
> > +  For information on assigning RISC-V IOMMU to its peripheral devices,
> > +  see generic IOMMU bindings.
> > +
> > +properties:
> > +  # For PCIe IOMMU hardware compatible property should contain the ven=
dor
> > +  # and device ID according to the PCI Bus Binding specification.
> > +  # Since PCI provides built-in identification methods, compatible is =
not
> > +  # actually required. For non-PCIe hardware implementations 'riscv,io=
mmu'
> > +  # should be specified along with 'reg' property providing MMIO locat=
ion.
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - qemu,iommu

>
> 'qemu,iommu' is too broad. Could be other QEMU implementations of an
> IOMMU. So 'qemu,riscv-iommu'.
>
I'm ok with that. Any objections from others?


> > +          - const: riscv,iommu
> > +      - items:
> > +          - enum:
> > +              - pci1efd,edf1
> > +          - const: riscv,pci-iommu
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      For non-PCI devices this represents base address and size of for=
 the
> > +      IOMMU memory mapped registers interface.
> > +      For PCI IOMMU hardware implementation this should represent an a=
ddress
> > +      of the IOMMU, as defined in the PCI Bus Binding reference. The r=
eg
> > +      property is a five-cell address encoded as (phys.hi phys.mid phy=
s.lo
> > +      size.hi size.lo), where phys.hi should contain the device's BDF =
as
> > +      0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be=
 zero.
>
> No need to describe what the PCI address looks like.
>
> > +
> > +  '#iommu-cells':
> > +    const: 1
> > +    description:
> > +      Has to be one. The single cell describes the requester id emitte=
d
>
> Drop 'Has to be one'. You already said that with the schema.
>
> > +      by a master to the IOMMU.
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 4
> > +    description:
> > +      Wired interrupt vectors available for RISC-V IOMMU to notify the
> > +      RISC-V HARTS. The cause to interrupt vector is software defined
> > +      using IVEC IOMMU register.
> > +
> > +  msi-parent: true
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#iommu-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |+
> > +    /* Example 1 (IOMMU device with wired interrupts) */
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    iommu1: iommu@1bccd000 {
> > +        compatible =3D "qemu,iommu", "riscv,iommu";
> > +        reg =3D <0x1bccd000 0x1000>;
> > +        interrupt-parent =3D <&aplic_smode>;
> > +        interrupts =3D <32 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <33 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <34 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <35 IRQ_TYPE_LEVEL_HIGH>;
> > +        #iommu-cells =3D <1>;
> > +    };
> > +
> > +    /* Device with two IOMMU device IDs, 0 and 7 */
> > +    master1 {
> > +        iommus =3D <&iommu1 0>, <&iommu1 7>;
> > +    };
> > +
> > +  - |+
> > +    /* Example 2 (IOMMU device with shared wired interrupt) */
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    iommu2: iommu@1bccd000 {
> > +        compatible =3D "qemu,iommu", "riscv,iommu";
> > +        reg =3D <0x1bccd000 0x1000>;
> > +        interrupt-parent =3D <&aplic_smode>;
> > +        interrupts =3D <32 IRQ_TYPE_LEVEL_HIGH>;
> > +        #iommu-cells =3D <1>;
> > +    };
> > +
> > +  - |+
> > +    /* Example 3 (IOMMU device with MSIs) */
> > +    iommu3: iommu@1bcdd000 {
> > +        compatible =3D "qemu,iommu", "riscv,iommu";
> > +        reg =3D <0x1bccd000 0x1000>;
> > +        msi-parent =3D <&imsics_smode>;
> > +        #iommu-cells =3D <1>;
> > +    };
> > +
> > +  - |+
> > +    /* Example 4 (IOMMU PCIe device with MSIs) */
> > +    bus {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        pcie@30000000 {
> > +            device_type =3D "pci";
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            reg =3D <0x0 0x30000000  0x0 0x1000000>;
> > +            ranges =3D <0x02000000 0x0 0x41000000  0x0 0x41000000  0x0=
 0x0f000000>;
> > +
> > +            /*
> > +             * The IOMMU manages all functions in this PCI domain exce=
pt
> > +             * itself. Omit BDF 00:01.0.
> > +             */
> > +            iommu-map =3D <0x0 &iommu0 0x0 0x8
> > +                         0x9 &iommu0 0x9 0xfff7>;
>
> Bracket each entry.
>
> > +
> > +            /* The IOMMU programming interface uses slot 00:01.0 */
> > +            iommu0: iommu@1,0 {
> > +               compatible =3D "pci1efd,edf1", "riscv,pci-iommu";
> > +               reg =3D <0x800 0 0 0 0>;
> > +               #iommu-cells =3D <1>;
> > +            };
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f6dc90559341..7fcf7c27ef6b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18958,6 +18958,13 @@ F:   arch/riscv/
> >  N:   riscv
> >  K:   riscv
> >
> > +RISC-V IOMMU
> > +M:   Tomasz Jeznach <tjeznach@rivosinc.com>
> > +L:   iommu@lists.linux.dev
> > +L:   linux-riscv@lists.infradead.org
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > +
> >  RISC-V MICROCHIP FPGA SUPPORT
> >  M:   Conor Dooley <conor.dooley@microchip.com>
> >  M:   Daire McNamara <daire.mcnamara@microchip.com>
> > --
> > 2.34.1
> >

ack to other comments.

Thank you for review,
- Tomasz
