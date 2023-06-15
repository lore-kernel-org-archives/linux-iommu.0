Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02180E
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 05:47:30 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5700e993f37so6876447b3.0
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 22:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686808049; x=1689400049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vDiV6UeFt2Sno0zSEPfAoE+c0aIDiDuPDDc3lI/OiI=;
        b=NnXGhiSIhqovytwTJdiQfnf5eovw73VQ87w+m9529YHgbOMhDe7l4LCL5NtOB6593B
         o90sc0F6F9c09Iv0yyo0gUhUtyFvhyXuclonV56OHBilEhgzNLnNA+mQBnM5tEm08uX1
         E+B3T2gkNTeMf5GZ4CeYbmNSoiMrxj8FjlDU4jDDz3/8wzn5i6yXoUy/FOoMQHKwWlFQ
         lMlEbhsKnb88uhsz/UH/OEAnb4OKRp1J6+phEMcdLTzi6PJNQm+XYWetoWUHArEEdu2p
         S8sVkzseIZByhGC+iZEq3fFyIlChqUaRGD9VkoATiH9Z8PQiOVakQk4O8KHlEYkLk6OX
         J+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808049; x=1689400049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vDiV6UeFt2Sno0zSEPfAoE+c0aIDiDuPDDc3lI/OiI=;
        b=UmYgISPtlNq/OQ7PAaI2XmMoxViM2kZ4tEpyFIS9AlDjlPnvggGyZGqR8ZdEzZrS5b
         5LKskPgwksQIsV3CA99UOfBjx/sYGq+n+nvyMNCR3CGzaeox797HZIHBcPlVfduMdWiI
         WV/+UL/J2QvvDNYWIT2xUTQ39qIVIPrwDycZ+1triQARuU1uvGZhoQzL+22HO/pZ58ZW
         5liTaIVGniUtVAFZMYcovmxExLYL2U9DA35CU0jhj9BOUFvtt6cqVjnaFUCorJAn87JX
         jQe1yRmJq985YNSTu4WC751YxwJjS7X1jnuMORLjey9nCZsgy2B0z6qdfW4bD1muMxdJ
         yzTw==
X-Gm-Message-State: AC+VfDyik5J7OHaig7NTk7Y8jOOdesiMzYAlEpwbR80v0A7TURMREbsW
	RqAuydyRla2pfm2AEPFfC0M7Zq8IgWb/7Vzm54DbsQ==
X-Google-Smtp-Source: ACHHUZ6aKGXwe4EbTAHJQ5c1CR4NVyX6sBaLo3x4BgIGK1ahNs5xjRNtb+Y/FJFgCgD+L1CXMRjT+B82WtWhsEiWxk0=
X-Received: by 2002:a0d:ea51:0:b0:570:2a0:6c18 with SMTP id
 t78-20020a0dea51000000b0057002a06c18mr4459993ywe.2.1686808049229; Wed, 14 Jun
 2023 22:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-8-apatel@ventanamicro.com> <20230614-devotee-repave-37d670dbfb7c@spud>
In-Reply-To: <20230614-devotee-repave-37d670dbfb7c@spud>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 15 Jun 2023 11:17:16 +0530
Message-ID: <CAK9=C2X35L3STKu954euRp3gsWb3uxzVbW+i+ddor4Hff9snXg@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
To: Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Saravana Kannan <saravanak@google.com>, Anup Patel <anup@brainfault.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:57=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> Hey Anup,
>
> Mostly looks good, once minor comment.
>
> On Tue, Jun 13, 2023 at 09:04:12PM +0530, Anup Patel wrote:
>
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
> > +  riscv,delegation:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    maxItems: 1024
> > +    items:
> > +      items:
> > +        - description: child APLIC domain phandle
> > +        - description: first interrupt number of the parent APLIC doma=
in (inclusive)
> > +        - description: last interrupt number of the parent APLIC domai=
n (inclusive)
> > +    description:
> > +      A interrupt delegation list where each entry is a triple consist=
ing
> > +      of child APLIC domain phandle, first interrupt number of the par=
ent
> > +      APLIC domain, and last interrupt number of the parent APLIC doma=
in.
> > +      Firmware must configure interrupt delegation registers based on
> > +      interrupt delegation list.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +  - riscv,num-sources
> > +
> > +anyOf:
> > +  - required:
> > +      - interrupts-extended
> > +  - required:
> > +      - msi-parent
>
> Not sure if you missed this from the last version, but I asked if we
> needed a
>         dependencies:
>           riscv,delegate: [ riscv,children ]
>
> IOW, I don't think it is valid to have a delegation without having
> children?

Ahh, yes. I missed this one. I will update in the next revision.

>
> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.

Regards,
Anup
