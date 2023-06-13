Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C7323C
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 07:55:53 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bc49318aa64so2059913276.3
        for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686642953; x=1689234953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqkMTpZSPTrtiBwrlg2HB9jORG0uNI2X+Q54yKxHyHA=;
        b=X1lH0zTSm/2trYaS1XeQ55Q9hA/9/r0gKILDhIP3BM1V9j/9FcNnlTg8C6eqes6MhY
         kEEujrjfs/bXMw2MXXaDIEhSffQ3ZxmyyehIWQMaGdQ83t9lijLU+cai3uaF5ZNQ3hJ1
         U4h+mNKlmJ4enUA0b9qIy8BcA850nZF9q8DNphIsqHIDVsbimRdE1m2LdXqy6pRLVSor
         CuNaeb3ZHWvaqWp2UlX8SxpNaeTb54BL1Y6A72HUI8F4MxEPteEgE7OxPWAGRl2KwREW
         FSjlxEtmon50dMqJgkzch8RTCiRJz+wMgeMWSkqDFbH4doZHuoKH0L9GHXdRo8TV+x0S
         4DDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686642953; x=1689234953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqkMTpZSPTrtiBwrlg2HB9jORG0uNI2X+Q54yKxHyHA=;
        b=dBEmGiN9tKLvydPJ7a8msiZhsHGpFy0AkrmafJC1h+MoL8aIAW7IL/gjR1NUvlaX5H
         o6aqojY1nVre3OHOqdM3p2UYm3jbjpQTalRwZt8BJzU63t/U/NwbSe5GRFqkzhzzrT22
         YbYfnIba/FkZx8lotPkFHZB1EqHSTf4Pf6xzQ0JcA4ZftKwezYsu8FQXR6hsqWBjcV14
         HerSXvGMmkwQB4vUc40T/tIoM3Q5RjLCExq9ZMvqKMHFtJKMzV9jgVilXUEnGlQiJZLa
         cmJQRW11eTWFuGH9CYU8Aq1aq9J8jDVRwq9z8qQRsImF8p0mTMtCk1wUGKE7WjpZ3Ze6
         3Q4A==
X-Gm-Message-State: AC+VfDyVJA2YJpZ/bemtJXP56IV7zziHuQNqJHo6cFxas+wSw4jsZ4hM
	/DYlP92YmPOXZyq2EEUEE25TKDPLa6JJd0T13lFofw==
X-Google-Smtp-Source: ACHHUZ7O4IuL4c5Qy6TEcv499ftciQaYRXdKcvbuS5ivN5I0ThoFAm05aH64SAu17/J52IMOAeGVAiqoO7kjJSXAUJs=
X-Received: by 2002:a0d:fd83:0:b0:56d:4014:dd20 with SMTP id
 n125-20020a0dfd83000000b0056d4014dd20mr982407ywf.30.1686642952928; Tue, 13
 Jun 2023 00:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-8-apatel@ventanamicro.com> <ZGIrOKIT8uHcNqbQ@nvidia.com>
In-Reply-To: <ZGIrOKIT8uHcNqbQ@nvidia.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 13 Jun 2023 13:25:41 +0530
Message-ID: <CAK9=C2V9o4FsFXAfRHLGSuJaDubwM_HSL7keTYeWb_vFDNLd7g@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] irqchip/riscv-imsic: Improve IOMMU DMA support
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 6:23=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, May 08, 2023 at 07:58:38PM +0530, Anup Patel wrote:
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
> >
> > To address above issue, we do the following:
> > 1) Map MSI pages for all CPUs in imsic_irq_domain_alloc()
> >    using iommu_dma_prepare_msi().
> > 2) Add a new iommu_dma_select_msi() API to select a specific
> >    MSI page from a set of already mapped MSI pages.
> > 3) Use iommu_dma_select_msi() to select a specific MSI page
> >    before calling iommu_dma_compose_msi_msg() in
> >    imsic_irq_compose_msi_msg().
>
> Is there an iommu driver somewhere in all this? I don't obviously see
> one?

Sorry for the delayed response.

The RISC-V IOMMU specification is frozen and will be ratified/released
anytime this month or next.
https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0-rc6/ris=
cv-iommu.pdf

The RISC-V IOMMU driver will be send-out on LKML pretty soon
https://github.com/tjeznach/linux/tree/tjeznach/riscv-iommu
which can be tested on QEMU
https://github.com/tjeznach/qemu/tree/tjeznach/riscv-iommu

>
> There should be no reason to use the dma-iommu.c stuff just to make
> interrupts work, that is only necessary if there is an iommu, and the
> platform architecture requires the iommu to have the MSI region
> programmed into IOPTEs.
>
> And I'd be much happier if we could clean this design up before risc-v
> starts using it too :\
>

Sure, I will send-out v4 in the next few days.

Regards,
Anup
