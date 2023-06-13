Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8685CB0
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 10:37:23 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-56d304ef801so21334977b3.0
        for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 03:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686652642; x=1689244642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6v7bAOnlXSpxwVByNrc2wz3YyV0QI4pSQ1WAf4/fwQ=;
        b=XYe7DUHMvGV7y2bk4ogTIjbkVzcgzUmWBbBgPF1keLUauqwTFso2aU41gu9FLKluKu
         E6nipZ8KQrqhbgbP6eMpWe5q3qri0rXk+bWJv7HFMOae77UL2k7/845wYD8x9kH+wNhx
         2ayxk0svBQENhTEER+t6TCNp+pXvad9K+spGe2yTQkmbk6i65MNaoFDRMaipn2r+vOs7
         x4QiwKtfa8Nq7oCB+Ww4EJZ1Q/O9awqHQe7KlpLCHo2YOarsxYOHwh6vY05YXxDT0Bvl
         72eaNF/Qm9LlPOuKgjVC0dQCkvOx2bLPW2eUO86Uha9sWk6PcHEICRBnAqRlVbMJr8TW
         bUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686652642; x=1689244642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6v7bAOnlXSpxwVByNrc2wz3YyV0QI4pSQ1WAf4/fwQ=;
        b=cPxOsTK8CbgJnolQvmHTq5BsrIUYArGb7eefOB0C5CZ/9+kzl6pJ8TXU8ppgrxtaY2
         8L8cNoE57UJjEMZOWP31r+/Fttk9cY4+saKI82SOAWdYwE85+DSa3tuFMUkY5xreBi5e
         EblT4be/KJW2WovSHcv0P4XdPw8RGXyZOAEP9QGs4taErHKR8NIyR+MCyf8vggF9ybev
         uBmkHG21jLzZdnYyu/KF8BXUFmOqLqFhxcQYcJFVXjd7RMN3t8QIchrKGS5CKb6cjxDi
         +56DoI5zBAOceOOo6OKAsaR/S4xpTleWAXV5XCA6Dt+uAjOqumv1cV/gsh8FsI/0++YC
         XITQ==
X-Gm-Message-State: AC+VfDxw11dtvLtS7McM8HRPxYWpLbvdQVFDeq0mKXy53r7iIUUU4S+r
	DjYG2psi5ZA4SUTAhcrMBPUFkMx5z5+F745vALtnELzuZVsV3LOt
X-Google-Smtp-Source: ACHHUZ5/Qvp7DqZ5pP3PN3ixTFHH2JNuoNmRb0aB0KXX5cNFjw0dq25o+ZtOjcjIGQZHYqGbkftMsLProALMoOCNzLk=
X-Received: by 2002:a25:b901:0:b0:bc6:9e29:f2c2 with SMTP id
 x1-20020a25b901000000b00bc69e29f2c2mr1018625ybj.44.1686652642636; Tue, 13 Jun
 2023 03:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-9-apatel@ventanamicro.com> <20230510-retry-paced-644f5a95ba3f@spud>
In-Reply-To: <20230510-retry-paced-644f5a95ba3f@spud>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 13 Jun 2023 16:07:11 +0530
Message-ID: <CAK9=C2W1=DAME7uYKu82qcpfn=V5N=4tZ4NTa2EygR+HDQCsmQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
To: Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 9:11=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Hey Anup,
>
> On Mon, May 08, 2023 at 07:58:39PM +0530, Anup Patel wrote:
> > +  interrupts-extended:
> > +    minItems: 1
> > +    maxItems: 16384
> > +    description:
> > +      Given APLIC domain directly injects external interrupts to a set=
 of
> > +      RISC-V HARTS (or CPUs). Each node pointed to should be a riscv,c=
pu-intc
> > +      node, which has a riscv node (i.e. RISC-V HART) as parent.
>
> Same nit here, s/riscv node/cpu node/?

Okay, I will update.

>
> > +
> > +  msi-parent:
> > +    description:
> > +      Given APLIC domain forwards wired interrupts as MSIs to a AIA in=
coming
> > +      message signaled interrupt controller (IMSIC). If both "msi-pare=
nt" and
> > +      "interrupts-extended" properties are present then it means the A=
PLIC
> > +      domain supports both MSI mode and Direct mode in HW. In this cas=
e, the
> > +      APLIC driver has to choose between MSI mode or Direct mode.
> > +
> > +  riscv,num-sources:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 1
> > +    maximum: 1023
> > +    description:
> > +      Specifies the number of wired interrupt sources supported by thi=
s
> > +      APLIC domain.
>
> Rob asked:
> | We don't normally need to how many interrupts, why here?
>
> But I do not see an answer to that on lore.

The APLIC spec defines maximum interrupt sources to be 1023.

>
> > +
> > +  riscv,children:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    maxItems: 1024
> > +    items:
> > +      maxItems: 1
> > +    description:
> > +      A list of child APLIC domains for the given APLIC domain. Each c=
hild
> > +      APLIC domain is assigned a child index in increasing order, with=
 the
> > +      first child APLIC domain assigned child index 0. The APLIC domai=
n child
> > +      index is used by firmware to delegate interrupts from the given =
APLIC
> > +      domain to a particular child APLIC domain.
> > +
> > +  riscv,delegate:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    maxItems: 1024
> > +    items:
> > +      items:
> > +        - description: child APLIC domain phandle
> > +        - description: first interrupt number of this APLIC domain (in=
clusive)
> > +        - description: last interrupt number of this APLIC domain (inc=
lusive)
> > +    description:
> > +      A interrupt delegation list where each entry is a triple consist=
ing of
> > +      child APLIC domain phandle, first interrupt number of this APLIC=
 domain,
> > +      and last interrupt number of this APLIC domain. Firmware must co=
nfigure
> > +      interrupt delegation registers based on interrupt delegation lis=
t.
>
> I read back Rob's comments on this from last time. He said:
> | The node's domain it delegating its interrupts to the child domain or
> | the other way around? The interrupt numbers here are this domain's or
> | the child's?

The node's domain is delegating its interrupts to the child domain.

>
> IMO it's ambiguous from the binding description whether the numbers
> refer to the "first interrupt in the parent domain that is delegated
> to the child" or to numbering of the interrupts within the child domain.
> "This" can be quite an ambiguous word, and it's not totally obvious
> whether the "this" refers to the "child domain" earlier in the sentence.
>
> I also do not not think you have answered his question about the
> directionality of the delegation either (it should just be a copy-paste
> from riscv,children, no?).

For APLIC, the interrupt delegation is always from parent domain
to the child domain.

I will add a statement about this in the description.

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +  - riscv,num-sources
>
> btw, do we need something like:
>
> anyOf:
>   - required:
>       - interrupts-extended
>   - required:
>       - msi-parent

Okay, I will update.

>
> & hopefully I didn't previously ask this one:
> dependencies:
>   riscv,delegate: [ riscv,children ]
>
> As an aside, I still think "riscv,delegate" looks strange here alongside
> "riscv,children" since "delegate" is singular and "children" is plural.
> The plural would be "delegates", but "delegation" would also fit better
> than "delegate".

Okay, I will rename it to "riscv,delegation".

>
> Cheers,
> Conor.

Regards,
Anup
