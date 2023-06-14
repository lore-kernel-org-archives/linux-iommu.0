Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6111184
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 16:18:06 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7872d7b79e1so987096241.0
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686759486; x=1689351486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqZ5IpvvmpQbJ1zzadm9lsilhVlagwH9wED8wa6qKyk=;
        b=XOfu1eYFWRpySp+RiCt0aA1jZbJR83Le9ctjs32cZySjS+GuH51iRYEtWpVlMPTqW9
         U5gItI0/rvhDWXWBSa0SMZNqwdysynD6LhqX84SvnNkBk+zWvV8ArIMnrYWTWVyqDojM
         GtdYN+TehUP1b9mwBeN1snu5Rk6tHA0eq6V1W4DblADlIddcAJllqCWZaW34CZUeoP5S
         TTglt7Hz5thFncRnDsOg0zxzAcyov99SLxk0pbhPTP4R5jh19C1aNmE1wcx93UxEx6fJ
         7K37K/Da6eQVnx2tYotE/7pD43Rj1+5vBMOVTKvvPIr20KNj1FRJUOceFPeUhutwO5X7
         qovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686759486; x=1689351486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqZ5IpvvmpQbJ1zzadm9lsilhVlagwH9wED8wa6qKyk=;
        b=dOWRidcpMmpL30GfZQOQ4DdaDgYhuXUO2308jFBiqj/aNJid06b5NFIEznS7wpvLwt
         2X9lqLpdg3aS0yaU4cQutZOpPt5lxYQuG3ASRmaCNlA81uLXa/YJJJoNMd8lbIleokJy
         A3+rQwA2Vu1a5UCaLBAQ8nHd0X/KQCFIkERNKFyy6LVTo67w5O+0VvxKHa6Wpkrkv5KC
         LIQgQ6F/7SkWKHZkP0JHpXSD6jof90JyKoqtsy1upCgNa6GOlr5SWnPky7993izmsuzR
         syvEc9S6Ru6zyZtnp2GhbFYpHrcH7aqSxZhtUbYDtOeD7ZisiIheoKbtkAXfQBx9ufJ3
         5ppA==
X-Gm-Message-State: AC+VfDzwa1epcgoZz2N9zojvT1w60VeiF0onPwaqu1U+Qk0/AdhbEnEU
	yscHaFA7QPTSBu56STbS6Wk7sO9jE0vIiGc1HUdhyQ==
X-Google-Smtp-Source: ACHHUZ4T7QMUba26lRFayVBzKQdCxI1brJ81aRWNBFfCUqmdZDfLVwDazHkjAEg8Z171WQ5oQkD4ady8X/LpgmJXumY=
X-Received: by 2002:a67:d088:0:b0:43b:2f4d:2467 with SMTP id
 s8-20020a67d088000000b0043b2f4d2467mr7412759vsi.29.1686759485808; Wed, 14 Jun
 2023 09:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-7-apatel@ventanamicro.com> <ZInSqC6b7RPD1nzX@ziepe.ca>
In-Reply-To: <ZInSqC6b7RPD1nzX@ziepe.ca>
From: Anup Patel <apatel@ventanamicro.com>
Date: Wed, 14 Jun 2023 21:47:53 +0530
Message-ID: <CAK9=C2XBObBGh2R2pxVgM0E1gFPBn4m7DKzoTxEmDdZ9V1QLrA@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] irqchip/riscv-imsic: Improve IOMMU DMA support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Conor Dooley <conor@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2023 at 8:16=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Jun 13, 2023 at 09:04:11PM +0530, Anup Patel wrote:
> > We have a separate RISC-V IMSIC MSI address for each CPU so changing
> > MSI (or IRQ) affinity results in re-programming of MSI address in
> > the PCIe (or platform) device.
> >
> > Currently, the iommu_dma_prepare_msi() is called only once at the
> > time of IRQ allocation so IOMMU DMA domain will only have mapping
> > for one MSI page. This means iommu_dma_compose_msi_msg() called
> > by imsic_irq_compose_msi_msg() will always use the same MSI page
> > irrespective to target CPU MSI address. In other words, changing
> > MSI (or IRQ) affinity for device using IOMMU DMA domain will not
> > work.
>
> You didn't answer my question from last time - there seems to be no
> iommu driver here so why are you messing with iommu_dma_prepare_msi()?
>
> This path is only for platforms that have IOMMU drivers that translate
> the MSI window. You should add this code to link the interrupt
> controller to the iommu driver when you introduce the iommu driver,
> not in this series?
>
> And, as I said before, I'd like to NOT see new users of
> iommu_dma_prepare_msi() since it is a very problematic API.
>
> This hacking of it here is not making it better :(

I misunderstood your previous comments.

We can certainly deal with this later when the IOMMU
driver is available for RISC-V. I will drop this patch in the
next revision.

Regards,
Anup
