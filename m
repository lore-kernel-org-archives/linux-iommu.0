Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CF91E1A3D
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737081992; cv=none; b=UJjYEnKQ7GZBFIbzBkX+nlPJo3IezHJEr8dsITwkaYZLKQonj9T8CXCXXpZvQerTwR/LPfWSN4trvWRZwgM8MF/ZUrSA6U3eobbVs3GROw2+4pc9FKMHXIxRpoxrwVyuVIYnqqTzJb7szh43zd9m3WwfuytU/r0N3kfTm5DBg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737081992; c=relaxed/simple;
	bh=a/DGZcs5Z5wels8kRuWkuRNWdImjVsAsnemtzH0xRhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSY1eIDev8EXPcohtQMuqR1E9S+BPylATWfnaSazm0GNERKaTgykV2txzvHP3+H0rZ4kEkjS/x7zfFEnv/Ixi4SoiWNUFyNsYbXmDwmbRKYIwyFEuTQ3bj0eX5kbadkEoAUYtKEO+JxcOmBBDW3OkoDFUlgpFVqtbckG7zYpCfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JcXn37Or; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JcXn37Or"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-844ce213af6so57019839f.1
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 18:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1737081990; x=1737686790; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBE352h6xTV11ZbHwFwrhAF11sH/L9EG9p9m7t9k9EA=;
        b=JcXn37OrwfFFsnsaPfH0Oowh1GctW3cmKgA21SFPZzJmOo0rjneN4epOZ/gN8wlQCF
         r/RvujHlkHvSle/JvoUTnC0wIsqo4vxWf/CydyXTAtW0ZIQe/9dD+p7JR9BrmanSObhG
         GQbyWM3Htx2VHW20AHi+xH3HS0Aavz7o+4XX47GG+cuZAks6pJg3bjZKfXP3+QwXXC7N
         WYHSVup38T5QpOBldH96Y1RWmwdQTTW1QoMVtrdd5b/6YXPbVAMNM1OfLWrEvEAJz2Ls
         tp6Z79oIJmG3Swz5DFOCIbQWGwIx9VjQrsJ5xUxt/phMS4bbmrFE9hxlyq3lY57Jc6KN
         QLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737081990; x=1737686790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBE352h6xTV11ZbHwFwrhAF11sH/L9EG9p9m7t9k9EA=;
        b=RZq/Ifqk9kL9tSF+xyHsyfEYEo5AqiM+yziwRyiKstYzP8RspWMLO1PJKybo3uMEc4
         /pk2ULXPTdE+Q3xeokjeFXTHaNK7ME0+s8u3wqUX1VXeS+mFcozeTCZcLK54gPKUn+LQ
         vE/QKT33lPnfpds+9fvtYyQereJ2YJBBtUmsx3OCuYNNeIaX8u5GQ5PrnaD7dGT6EXfM
         e9kmRrHY00pKzZGmUv3FnrlW7gCJqF9XObL0mWMStd0P1qpJDmx1xFR8Xc+I39WLkZM+
         Yd506n1pHstYAkQfHuvuhpkbx+C6bcfSm13ig4JLGFEciyCjGby1NfXL3M8oM7SbRhoQ
         mVsw==
X-Forwarded-Encrypted: i=1; AJvYcCWLZ8W7ywAwR1Y6SHM/nvhvq6fAK1H0ZvJXxVxp+QTy1riJuBVVSfZ+nmsdBu8RS+hCWcCrdQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHs4FRpuwYU88KrS4OGfqU4HbCNWc3ou1TWAjS/2pde7+f7bh9
	3udGcCssTHdBkV4UL2FnZGEmIAAarIa27FEPbMsbiXGxCPaGqvoqf3GiUqnX/MFkQ5URcHWmt9N
	45CEpXj1fOXrK/P17fPHp441k8c3okFXCFZmStw==
X-Gm-Gg: ASbGnctWn1QGIRYzkgTziApcO81+KX9cS17J4ZSgx86dQbdMsM6fzY+roMGv16HJkJd
	kLQBQ61bo/HAWLHtgdDNIkLVxADPqpz5+hglTOt7u
X-Google-Smtp-Source: AGHT+IHCygSg9QotfBTDuFvRaNFXV46S7C6ifwjSRyMAhO+Cv0MABWpr/8EfOwFa+ddOP11+8pIFIUp31Vd6zCzKD10=
X-Received: by 2002:a05:6602:14cc:b0:844:cf31:622f with SMTP id
 ca18e2360f4ac-851b619f802mr56258439f.2.1737081989766; Thu, 16 Jan 2025
 18:46:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250115030306.29735-1-zong.li@sifive.com> <20250115030306.29735-3-zong.li@sifive.com>
 <6301d20b-d51d-4f96-94ea-134e065d398e@arm.com>
In-Reply-To: <6301d20b-d51d-4f96-94ea-134e065d398e@arm.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 17 Jan 2025 10:46:18 +0800
X-Gm-Features: AbW1kvYifw2ZNiWhXRw7ovhPDr3eXKvGZSuGineouUgzPowzaGn_tXhdSKAMjE8
Message-ID: <CANXhq0oDv0b_S=6EmETAUkjQxo3Zz5fZ-yeP-9hHSMW9Ak5=sg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/riscv: support HPM and interrupt handling
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, tjeznach@rivosinc.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	luxu.kernel@bytedance.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:56=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2025-01-15 3:03 am, Zong Li wrote:
> > Initialize the PMU and uninitialize it when driver is removed.
> > Interrupt handling is also implemented, and the handler needs
> > to be a primary handler instead of a threaded function because
> > pt_regs is empty when threading the IRQ. However, pt_regs is
> > required by perf_event_overflow.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Tested-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >   drivers/iommu/riscv/iommu.c | 65 ++++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 65 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 8a05def774bd..20ae90471484 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -552,6 +552,62 @@ static irqreturn_t riscv_iommu_fltq_process(int ir=
q, void *data)
> >       return IRQ_HANDLED;
> >   }
> >
> > +/*
> > + * IOMMU Hardware performance monitor
> > + */
> > +
> > +/* HPM interrupt primary handler */
> > +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
> > +{
> > +     struct riscv_iommu_device *iommu =3D (struct riscv_iommu_device *=
)dev_id;
> > +
> > +     /* Clear performance monitoring interrupt pending */
> > +     riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_=
PMIP);
> > +
> > +     /* Process pmu irq */
> > +     riscv_iommu_pmu_handle_irq(&iommu->pmu);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +/* HPM initialization */
> > +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> > +{
> > +     int rc;
> > +
> > +     if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > +             return 0;
> > +
> > +     /*
> > +      * pt_regs is empty when threading the IRQ, but pt_regs is necess=
ary
> > +      * by perf_event_overflow. Use primary handler instead of thread
> > +      * function for PM IRQ.
> > +      *
> > +      * Set the IRQF_ONESHOT flag because this IRQ might be shared wit=
h
> > +      * other threaded IRQs by other queues.
> > +      */
> > +     rc =3D devm_request_irq(iommu->dev,
> > +                           iommu->irqs[riscv_iommu_queue_vec(iommu, RI=
SCV_IOMMU_IPSR_PMIP)],
> > +                           riscv_iommu_hpm_irq_handler, IRQF_ONESHOT |=
 IRQF_SHARED, NULL, iommu);
>
> Hmm, shared interrupts are tricky for PMUs, since perf requires any IRQ
> handler touching a PMU is running on pmu->cpu, so you have to be very
> careful about maintaining affinity and not letting anyone else change it
> behind your back.
>
> The other thing is that if it really is shared, at this point you could
> now be in riscv_iommu_pmu_handle_irq() dereferencing NULL.

Yes, the PMU IRQ line could be shared with the command queue, fault
queue, and page-request queue.
Could you please provide more tips on what is meant by "dereferencing
NULL in riscv_iommu_pmu_handle_irq()"?
I don't complete understand what needs to be done there.
Thanks

>
> > +     if (rc)
> > +             return rc;
> > +
> > +     return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iom=
mu->dev));
> > +}
> > +
> > +/* HPM uninitialization */
> > +static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
> > +{
> > +     if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > +             return;
> > +
> > +     devm_free_irq(iommu->dev,
> > +                   iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMM=
U_IPSR_PMIP)],
> > +                   iommu);
> > +
> > +     riscv_iommu_pmu_uninit(&iommu->pmu);
> > +}
> > +
> >   /* Lookup and initialize device context info structure. */
> >   static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_d=
evice *iommu,
> >                                                unsigned int devid)
> > @@ -1596,6 +1652,9 @@ void riscv_iommu_remove(struct riscv_iommu_device=
 *iommu)
> >       riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF=
);
> >       riscv_iommu_queue_disable(&iommu->cmdq);
> >       riscv_iommu_queue_disable(&iommu->fltq);
> > +
> > +     if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> > +             riscv_iommu_pmu_uninit(&iommu->pmu);
> >   }
> >
> >   int riscv_iommu_init(struct riscv_iommu_device *iommu)
> > @@ -1635,6 +1694,10 @@ int riscv_iommu_init(struct riscv_iommu_device *=
iommu)
> >       if (rc)
> >               goto err_queue_disable;
> >
> > +     rc =3D riscv_iommu_hpm_enable(iommu);
> > +     if (rc)
> > +             goto err_hpm_disable;
> > +
>
> I would leave this until after the whole IOMMU setup has succeeded. The
> PMU is not critical to IOMMU operation, so at that point an error is not
> fatal, it just means you don't get a PMU, thus there shouldn't need to
> be any cleanup outside riscv_iommu_hpm_enable() itself.

Thanks for pointing this out. PMU failure shouldn't cause the entire
IOMMU to fail, let me modify it in the next version.

>
> Thanks,
> Robin.
>
> >       rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-i=
ommu@%s",
> >                                   dev_name(iommu->dev));
> >       if (rc) {
> > @@ -1653,6 +1716,8 @@ int riscv_iommu_init(struct riscv_iommu_device *i=
ommu)
> >   err_remove_sysfs:
> >       iommu_device_sysfs_remove(&iommu->iommu);
> >   err_iodir_off:
> > +     riscv_iommu_hpm_disable(iommu);
> > +err_hpm_disable:
> >       riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF=
);
> >   err_queue_disable:
> >       riscv_iommu_queue_disable(&iommu->fltq);
>
