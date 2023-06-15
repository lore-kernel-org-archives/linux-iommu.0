Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EC80E
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 05:46:48 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so691938276.1
        for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 22:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686808008; x=1689400008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4BBZdcwV53I4/SexLSk4m4e3GYSRd1uRKWHBlB/d9A=;
        b=UCpwqoTDu/DROrJquC1iaX7jIAVfquVUK6sURGuKJtxmN9g4RKtD00nto+vvsS8bNp
         oKbK8Y+RXJKKxH4f6u6caNxlKAG/AeQYQTFTIE75tNmOhPEd9IMFwtSOaoPgEfwZtAFP
         0jQj9J/BXTtj7MHcewu/5cBMRHZzzI2y+9/jGHd6knT98/9bBKLBsMO0LOZmRQjvFkfM
         UJ3CFb7GECyuOK7+34bZMWwtncdS6fZ0xfPvc8zd+4V22sN1LESqOE0EfWkHBkt5HF85
         xqcEhQa87H/PJxBncJy+DmQvK0yhYTj4LMeZw45Hk2jZsgiu92DYgaR+FrH5BTywvV3C
         mHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808008; x=1689400008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4BBZdcwV53I4/SexLSk4m4e3GYSRd1uRKWHBlB/d9A=;
        b=eqW6zX5cj6tQ8RmsdLeYSOIOOiiOGySufIh6PpJa6hzdTJ4N6F1pKVPKx8/dz2O8Mq
         9vjRAbWLwMGHQXeQRpTs7yydn2wGhEN4QJPfhan44/XDKjxFT5f+0PkgaJiTsaNFl9d0
         h4FXMskN8BczpL2gaF5ai5pKv0CGAA/mEJMdRG5IO/AIv6EHMtziyKqfnQf/ovHcQqIR
         jc+w/77uIozeZJHWU7JTKHgpCfj0v3feQNXojsnOX6LenpWPtCHCbk8wh8aeHOHIIKs7
         WhEYETt4mz+DCcdAzkTEouPTXMQc+nF2bCpoiwF1CKciXwmreWFaHOnVuwDxDFwxKkR8
         GqQA==
X-Gm-Message-State: AC+VfDw/5yyF8tPDXMpQLyjtyKRzlF9/aznk4KzGY6Coyh2f2bk/4eSQ
	0ikjdP4W4iIChDn3/8O17IB45KLzBY3yMo6acKHTHQ==
X-Google-Smtp-Source: ACHHUZ672iNfzCBweTy9QLV/i/rzr5Vs6Tq41Zax9L7mWUr9BNqjo0vzLUUxM2G49aQFlhWghyl53s3wEwbXOODugyU=
X-Received: by 2002:a25:da84:0:b0:ba9:b304:107b with SMTP id
 n126-20020a25da84000000b00ba9b304107bmr4885752ybf.27.1686808007846; Wed, 14
 Jun 2023 22:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230613153415.350528-1-apatel@ventanamicro.com>
 <20230613153415.350528-7-apatel@ventanamicro.com> <ZInSqC6b7RPD1nzX@ziepe.ca>
 <CAK9=C2XBObBGh2R2pxVgM0E1gFPBn4m7DKzoTxEmDdZ9V1QLrA@mail.gmail.com> <ZInvvMZvrP4U/LL+@ziepe.ca>
In-Reply-To: <ZInvvMZvrP4U/LL+@ziepe.ca>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 15 Jun 2023 11:16:35 +0530
Message-ID: <CAK9=C2XKg5jBxBtrWMvQP--8Yb4ACFZFyX4wrtLy1efH7hO9ow@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 10:20=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Wed, Jun 14, 2023 at 09:47:53PM +0530, Anup Patel wrote:
> > On Wed, Jun 14, 2023 at 8:16=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Tue, Jun 13, 2023 at 09:04:11PM +0530, Anup Patel wrote:
> > > > We have a separate RISC-V IMSIC MSI address for each CPU so changin=
g
> > > > MSI (or IRQ) affinity results in re-programming of MSI address in
> > > > the PCIe (or platform) device.
> > > >
> > > > Currently, the iommu_dma_prepare_msi() is called only once at the
> > > > time of IRQ allocation so IOMMU DMA domain will only have mapping
> > > > for one MSI page. This means iommu_dma_compose_msi_msg() called
> > > > by imsic_irq_compose_msi_msg() will always use the same MSI page
> > > > irrespective to target CPU MSI address. In other words, changing
> > > > MSI (or IRQ) affinity for device using IOMMU DMA domain will not
> > > > work.
> > >
> > > You didn't answer my question from last time - there seems to be no
> > > iommu driver here so why are you messing with iommu_dma_prepare_msi()=
?
> > >
> > > This path is only for platforms that have IOMMU drivers that translat=
e
> > > the MSI window. You should add this code to link the interrupt
> > > controller to the iommu driver when you introduce the iommu driver,
> > > not in this series?
> > >
> > > And, as I said before, I'd like to NOT see new users of
> > > iommu_dma_prepare_msi() since it is a very problematic API.
> > >
> > > This hacking of it here is not making it better :(
> >
> > I misunderstood your previous comments.
> >
> > We can certainly deal with this later when the IOMMU
> > driver is available for RISC-V. I will drop this patch in the
> > next revision.
>
> Not only just this patch but the calls to iommu_dma_prepare_msi() and
> related APIs in the prior patch too. Assume the MSI window is directly
> visible to DMA without translation.

Okay, I will remove iommu_dma_xyz() usage from IMSIC driver in the
next revision.

>
> When you come with an iommu driver we can discuss how best to proceed.

Yes, that's better.

Regards,
Anup
