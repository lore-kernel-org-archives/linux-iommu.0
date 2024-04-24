Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52C16D9B2
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998247; cv=none; b=QQy8obNYT1ajeaZ/hZVUl7bx4XSeed00CFDVkIZqHk7Z3JXxNbCVdznXtmjACINBWdvOO3UfeOMCB2md9QAr9HCtytqD7JSdsFS5GRzXvqyzCoUD4+GprEQ5bmpnXBAad98aJ7lTZ98bMxsG2f6RhFajOHhZ3pj6GTMOnCTMTH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998247; c=relaxed/simple;
	bh=qVRTzUA+MWdKY71cY09kaWnQVDV6+oWl0Dkhha0WLr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2cKtm/WNu2+nfhbE3dCoEhu6Ztd3U3/PUD16mA2yDLmTf8WI639rlsI9WJg7z3Nn4y8QmSEqgBKG9Ag9lX+i6y1YTKsdx5xkcYnlKT6IgWoeZ+KDZgfcRczmhjAhgihbOzYvbo3Rc39wzTrOlzErZT28YP6BauQOzi/YTtL6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MHdiMSEY; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MHdiMSEY"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so334191a91.0
        for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713998245; x=1714603045; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO8Rp7JUgS7Xhpz5uMrLG4WHnD0bm/FTRd8cK1NaJfI=;
        b=MHdiMSEYyb8LmXQP/uhj/TYhcvlqPzJ/USXdZWfXkm5HjMzVQ6/DobxKyQAeB1IQtB
         nznE6uZIvZLPcvlRNk20enqw3adMitw+Zyb/v6oL1p30WPGzBi/eorKE0ARmdMRYuuxS
         X9fWw93GSWuiLtfFKMdx68fkZSx7baX67yO2RF4742hGOz0b9GE5CD3XrekQ737lz6pe
         O8r9OKWBHEMzaKcYeV+C0i8pbCqM1jNiPs2saqTIQKudKL9KHAcrnUqRnsnu3nxv40/G
         DHaFpBy3QtoUwuusAJiIQ3/hIaqgxZXKxi+cE54WMM7kLOAm8hdJDCvVL+N8e/iGXcmO
         N+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713998245; x=1714603045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aO8Rp7JUgS7Xhpz5uMrLG4WHnD0bm/FTRd8cK1NaJfI=;
        b=a2RVKOnGHBdCjIKtS8oLaV+JQlICm3tEPa7UrCutDHJeUMv8nkxhVdKf+suaC6B3Bz
         vX1OXZwrRiDwrb9u41QYGRop6gfvafBLCWOvep6C4IKIBe0tL+tF1SGM/Owu9uekxdem
         jyUh++Rg7CAZ6itxAbemTG48vHM0ltwkOCGzohUGRt66u1MNplqudMMg8B3IpDgPW08D
         u3IVuGa+/Mses/JDKzLWpCEA0nstkxAD0hIBic3sHvaGMF2tON4so5zhN5sJNbO1zGWb
         V7OHV98rtwIjoFZ4aF2QeqdUtMaXDEl7m0dBTehbQ2kO2BidinqjlLt/f3QDWJ03L77N
         6cAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ0fWo5XONcu+lxcQ0tspdrei6GyGL1TcAiFQP/DYM5yeBnurkpWhbXXM5gg1Io0lJrL2zaM7AHVf+9dOHwqYWZfABZhM=
X-Gm-Message-State: AOJu0YxpvyFftvhNh3vjZtaHC/YWNCJyQ6oG4XjRrhtSj3plv/M9yjxV
	vK6BKo/ZAe2OWQzWDopHK/HZsyo0mUWUDHiqzVtytfxavXViOTcSXCGNFack3p8a8nlRxuXwp88
	JNxBmCOxHB5vBgdDj7pKEUJGBw3209MtdW0FbAA==
X-Google-Smtp-Source: AGHT+IGBdslP8DSVdWf46pAwH3oTFPa/IfzzcphPEMB4ixOB3ZSquD8oJqVuF7a4MYQGJ/zf/PV3za+kxLsvBdn4cjU=
X-Received: by 2002:a17:90b:4d8d:b0:2af:c3ea:8122 with SMTP id
 oj13-20020a17090b4d8d00b002afc3ea8122mr338008pjb.7.1713998245527; Wed, 24 Apr
 2024 15:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1713456597.git.tjeznach@rivosinc.com> <c37cb93e7baa7042a3f82130bf30be6831b558dc.1713456598.git.tjeznach@rivosinc.com>
 <20240418-approach-liquefy-04551ddefbc4@spud>
In-Reply-To: <20240418-approach-liquefy-04551ddefbc4@spud>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 24 Apr 2024 15:37:14 -0700
Message-ID: <CAH2o1u7_v=_GX5cnV5X14jggTycRTvGEJ1r_9tqtb-xgk=LEkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
To: Conor Dooley <conor@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 10:04=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Apr 18, 2024 at 09:32:19AM -0700, Tomasz Jeznach wrote:
> > Add bindings for the RISC-V IOMMU device drivers.
> >
> > Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >  .../bindings/iommu/riscv,iommu.yaml           | 149 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 156 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu=
.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml b=
/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > new file mode 100644
> > index 000000000000..d6522ddd43fa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
> > @@ -0,0 +1,149 @@
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
> > +description: |+
>
> FYI, the + here is probably not needed.
>
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
>
> I dunno, I'd like to see soc-specific compatibles for implementations of
> the RISC-V IOMMU. If you need a DT compatible for use in QEMU, I'd
> suggest doing what was done for the aplic and having a dedicated
> compatible for that and disallow having "riscv,iommu" in isolation.
>

Makes sense.  Will update to something like below:
  compatible:
    oneOf:
      - items:
          - enum:
              - qemu,iommu
          - const: riscv,iommu
      - items:
          - enum:
              - pci1efd,edf1
          - const: riscv,pci-iommu

> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: riscv,pci-iommu
> > +          - const: pci1efd,edf1
> > +      - items:
> > +          - const: pci1efd,edf1
>
> Why are both versions allowed? If the former is more understandable,
> can't we just go with that?
>
> > +      - items:
> > +          - const: riscv,iommu
>
> Other than the compatible setup I think this is pretty decent though,
> Conor.

ACK to other comments,

Thanks for the review,
- Tomasz
