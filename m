Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA38725A620
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 02:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737081207; cv=none; b=ISui0edPm0KMZktdPSqvXMw6nSY+534o7FFE4ErfUAFY73DUDd0h0MN1PQq8yKC43+XeUpmB1kKEwMKFOHdrPYYRYQwjyf4RUkrXwWDs+lXayz3XFDQlN6q75eSpyWzVjDLY2pOGRJHv67wctKC/bMklsnDe3XQHL8XYU0cBqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737081207; c=relaxed/simple;
	bh=VU8M2uSyib6SyzpZDgGLZGCuF/N2Bv3R5S5KrPTQnc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKsA210H15iQguv/3XElvmIcd0GsF7xlSHUCGcWdPf8BJ1N5Y/8Oa90t4So86ZEXUIQ5bC00uWWb7gUvERuGXuwRXDmZE7UNCtG2BWc7VrwXHuzkyFoZg0WLrUj10ExO8TiRwDOXlgF+fnlaEjszKd1u2RgLVozF6ksj70Jpq/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OGd4REdC; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OGd4REdC"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844e9b83aaaso134768939f.3
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 18:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1737081205; x=1737686005; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgN1JAAtC4ZDvNdaRKOUkJRyhW7/k4x9pgbFwnsVLtM=;
        b=OGd4REdC/y3fa0LdoaBn5YsV5gtlZPDeMucXQw2S556eR/peWgl8Ti3QQC3/JaWGnA
         tkoyuUN21EQ7xfkntoTE7PdPpj7mjGTGjR1Migrm0aTN6SToLjZ4ChfVc1GT8dWIQyCT
         8MvS+M93s70IrsNxRBrfotqlQ+18/14GcJPLhvos7i53BGmIHQvkLXXhTMrxRVJh6X2Y
         Dme4c3A96bvQENrQgXWlXHk4X1QoeM0SJT1sCj8MXR5C7HYmISShXMsIsuobJDozJmbc
         BtNmJhSRkLsGQB5gLpbxQmJVl7IQYaO4sbsrBPnr4DFIvWqKYOYlD6N30z26b24lgd1s
         8dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737081205; x=1737686005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgN1JAAtC4ZDvNdaRKOUkJRyhW7/k4x9pgbFwnsVLtM=;
        b=hVVtpKiTw8f2VDq6aMQul+Rbh4ul+yrEV0xkvHBhSudvfzd+ixp8kas69gJnBn0Aa+
         J3v/718NHROodcaP5hSgJXLZk5ysxS4si1w0Yo+rKfaBf7BogHhNGkl29LrkNMIsf2dF
         jq4ZGjJegmZX89sAhUdXR3+Mx5MZl6qO8ZMQmVlrPXJeKNhId2LT3cSLvaA0hDL2By4Y
         KbdU0Zm9PUfA6ILQYq+96Q84wiJb7Oxs8r83cePAdJ6ScvKfWxI1pNnuI5MXLxds+MdC
         gmLHmP5oj3etYwGH35PHRzrtjKkHsPodrhonnJ/fLt4sboyW0jDBrfo4biwRZnX9ZNYa
         UFOA==
X-Forwarded-Encrypted: i=1; AJvYcCWN21v/1GWauarhLPfK4NAlilftvRlXJxHa5TeRVWOnLlB/dy0oNTS6TsaT4zQOiqopQVLhCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxti9GDx0mkbGQDwCr3eOGJ0f6el5+rZzMuhK7i5m+AS4pKT1ym
	/MNr3M9IL7UVRC1Xyd4BDVLTj+1nEsbbJWWNnjaRq8H8eCbADhDWLq/1waeTF8trWaivM0FlD6o
	emCQ13CxwwqrYA0wTYEPi5uae5RzPZvcaFI1ZZw==
X-Gm-Gg: ASbGnctfjiWl0l9F+z8A2tnxXpIVZqui1N2I10jWK5BXT1Drr+oSd7GBImUKE0BQYf6
	/gT9jBiPoiBU9zcURn9b3EDNcOgm7mcdQGbrWHy9/
X-Google-Smtp-Source: AGHT+IGWfjqzCcQGmdJQgnejUEiIp4GF3vXSpB00+Ht74BX8hKjtjnJTq/Q1I0aCcP43JfYNmc9RNWihsqSG+ffcTI4=
X-Received: by 2002:a05:6602:340c:b0:843:e9c0:8290 with SMTP id
 ca18e2360f4ac-851b61ff66emr68747539f.6.1737081204825; Thu, 16 Jan 2025
 18:33:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250115030306.29735-1-zong.li@sifive.com> <20250115030306.29735-3-zong.li@sifive.com>
 <20250115-9d8193b7c67eeee41d18a7dd@orel>
In-Reply-To: <20250115-9d8193b7c67eeee41d18a7dd@orel>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 17 Jan 2025 10:33:13 +0800
X-Gm-Features: AbW1kvbfpckKPbF4z3KmoHMJumhbeq9b8zbKXcCqdM0bd6xdghkg01ZcJTMVGgA
Message-ID: <CANXhq0qc7G8aDYiZ55_=4RQLcB5tLV8Hq8J+8FBaboCt5pp=AQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/riscv: support HPM and interrupt handling
To: Andrew Jones <ajones@ventanamicro.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, luxu.kernel@bytedance.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 5:44=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Jan 15, 2025 at 11:03:06AM +0800, Zong Li wrote:
> > Initialize the PMU and uninitialize it when driver is removed.
> > Interrupt handling is also implemented, and the handler needs
> > to be a primary handler instead of a threaded function because
> > pt_regs is empty when threading the IRQ. However, pt_regs is
> > required by perf_event_overflow.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Tested-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 8a05def774bd..20ae90471484 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -552,6 +552,62 @@ static irqreturn_t riscv_iommu_fltq_process(int ir=
q, void *data)
> >       return IRQ_HANDLED;
> >  }
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
> >  /* Lookup and initialize device context info structure. */
> >  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_de=
vice *iommu,
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
>
> This should be
>
>    riscv_iommu_hpm_disable(iommu);
>
> as the cover letter said it would be.

Yes, I guess I messed that up. Thanks

>
> >  }
> >
> >  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> > @@ -1635,6 +1694,10 @@ int riscv_iommu_init(struct riscv_iommu_device *=
iommu)
> >       if (rc)
> >               goto err_queue_disable;
> >
> > +     rc =3D riscv_iommu_hpm_enable(iommu);
> > +     if (rc)
> > +             goto err_hpm_disable;
>
> This should be
>
>   goto err_iodir_off;
>
> And the next goto (under sysfs add) should be
>
>   goto err_hpm_disable;
>

Yes, thanks for catching that.

> > +
> >       rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-i=
ommu@%s",
> >                                   dev_name(iommu->dev));
> >       if (rc) {
> > @@ -1653,6 +1716,8 @@ int riscv_iommu_init(struct riscv_iommu_device *i=
ommu)
> >  err_remove_sysfs:
> >       iommu_device_sysfs_remove(&iommu->iommu);
> >  err_iodir_off:
> > +     riscv_iommu_hpm_disable(iommu);
> > +err_hpm_disable:
> >       riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF=
);
> >  err_queue_disable:
> >       riscv_iommu_queue_disable(&iommu->fltq);
>
> This should be
>
>  err_remove_sysfs:
>    ...
>  err_hpm_disable:
>    ...
>  err_iodir_off:
>    ...
>  err_queue_disable:
>    ...
>

Let me try to fix them in the next version if necessary. As Robin
mentioned, we might not need the HPM cleaner and can simply enable HPM
at the end. Thanks you for the review and catching these.

>
> Thanks,
> drew
