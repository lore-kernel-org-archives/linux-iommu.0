Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76DEEBD
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757042846; cv=none; b=UpxVCchjv2HxB+4J1oAocJyImBRZQpeR6JYPRgzBUcwSrkNIqfXwC6o3KkwumSVUAFyc4DawGg1XqYt41OLXVR3KsYRQvm6lFd8Dgv9iVCU/GlM/WCs8XLpTZHFLGqpz05Chto86RwAEtmaHpGVRdDS2jSZui82at5jhmJNqTIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757042846; c=relaxed/simple;
	bh=+VXSgIhRAwZIGPzIQ9jTQLIynfEbotiIyagnLddr+s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZXjdegXKJfxFbWFfDp5Z2ZOGAglBQlkdo3Jswb79cF4RS+6rYsWU6yOQe3oLGoE278HK93OARHlfyc6Sr+CoMl65VPTgHxbIDGvyegG/VofacqS7Kc2wCENOIxOQ8G13ybaLCInDDg4iK+Bx2zinxBoPx0NYi4buqLACEf5LyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AewI7XKN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AewI7XKN"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cbfa1d820so1084776a12.3
        for <iommu@lists.linux.dev>; Thu, 04 Sep 2025 20:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1757042843; x=1757647643; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os04syBpjRUYrOuY5Z5ul0OnAt1kwR5e6GPJHPTZohI=;
        b=AewI7XKNhofXTTvMUxOKJb4yAbAxM6vWsUP2Zo68pWNTSYAJl/MxtmncNd5xa6PmIt
         UQvRYTMmNBhBOc2dW7czDViK4wbWZYbZXr7i8UuqbUA/ynJ3MR84F5ss6+j80CjjUAEO
         8l2joMrHwwc8kuS84nOmCXSJBkAILxdxIrvRdeV5TVLzBfVgvLgOKjzS0Nhg2rvSxqVW
         nWeVQXjwTQmsGT9SYM7T/IuLNiAPkGKpvvA8LkNbMhTTS34vr6SYQphBWgzy49gYCUKK
         HNOM72cWqEkClagt+TsyJcYnyaPCsxFtnqDwvE0DVeZMcrsJ8oWyyquuHmkVYiEgo0CJ
         EZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757042843; x=1757647643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os04syBpjRUYrOuY5Z5ul0OnAt1kwR5e6GPJHPTZohI=;
        b=sqcyJqS4FoCzo4GHNQp86E0PU/NZ2LjXjIIcJVxBOMnwlcSDbrJEEIuCrZr3vuYFxg
         VeH1Rb8vjFjCdz+insYq6GThzfYzjzFhUIXEU+SOTbUexGFnLaoq450Fras7J5vfbqXu
         lUuErC2SN0fLpXOhNbrJ0G7ieG7mXkAqL/yYSxTZKWblOoIO7iGXmQzMnxQ5A1xkziDT
         SfJsiB6NrUufgPx5ml8rNZO6B4ynF4h/C5GXfDX/1KlNW9ukoFUarlB53dj7heTMITVs
         bSJXSbi9KHabw8HH6lO1QjUUcetEDd+wdR1VFImBJPAEXKR6cbZ0dpd6PLjKJDgexrmY
         HRGA==
X-Forwarded-Encrypted: i=1; AJvYcCUC/nJdkQpue+4Z6Y7cyCU6RkOBtwZqkwieZNO2gUsOk10gZAO+ylchC+Es6tGUX3s5ITHOgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQ096yDEnYiEevQ17Zm+lPZy0br6ZBGq/EQWRWpC5sZLpIqajz
	U8cdVSMwL8iGgSTdbmuQIQh8iu26TONzqfPv3UPKta3YT8fajRYlXxpv9iNhjNisRv0mFgxEeF4
	CJA6bXzG469DSrUNoLS6rhnOICbw/mp+lzYFE+YWdPQ==
X-Gm-Gg: ASbGncufg0tn+pv7bG9eCv2mMoo2cRrlTiRvfB5JC4xTH3SyVV4eG6lT8NdyPAwvmAW
	Cd7wrRJv0m5ot+zuG36PnVvg2xPnWx/dow95c+0ze6dayW0AzElCxMLwKkf7dSvloHiV3/JoB0d
	icKgyhHe/v7ZLeoRgTjWs9WvM0PPIV7lpnFKFy8QDsk5SHLzAVQQnSfwCARS5pUsd14RaEQ8dUy
	F/pxOCt2qmHKoOS5wEX
X-Google-Smtp-Source: AGHT+IFTBZLssAj4YEI3yGO9zckI6NIStV+ozblxy5fjUOhfU+lQN15HDXjbRdJYZmz9vJUW1Pms6o2MHeVJKPYWHtY=
X-Received: by 2002:a05:6402:5cd:b0:61d:1443:8599 with SMTP id
 4fb4d7f45d1cf-61d26ec6264mr18308728a12.32.1757042843053; Thu, 04 Sep 2025
 20:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-3-zong.li@sifive.com> <20250901133629.87310-1-ni_liqiang@126.com>
 <CANXhq0ra+yv-Wt_vKTN3+c4StsPQB1vR+=Kp3RVSh0g10Oogqw@mail.gmail.com>
In-Reply-To: <CANXhq0ra+yv-Wt_vKTN3+c4StsPQB1vR+=Kp3RVSh0g10Oogqw@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 5 Sep 2025 11:27:10 +0800
X-Gm-Features: Ac12FXxCOomRzLnISI4mSuIvWFVx9HD9ac2cyQivUPSI8ky_l1yBqci4E2RqAio
Message-ID: <CANXhq0oeUZb7161eJ2z-9aRXSDSmt8P9RpC7QSH4DZ0YvNp_7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/10] RISC-V IOMMU HPM and nested IOMMU support
To: niliqiang <ni_liqiang@126.com>
Cc: aou@eecs.berkeley.edu, iommu@lists.linux.dev, jgg@ziepe.ca, 
	joro@8bytes.org, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org, 
	chenruisust@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:01=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Sep 1, 2025 at 9:37=E2=80=AFPM niliqiang <ni_liqiang@126.com> wro=
te:
> >
> > Hi Zong
> >
> > Fri, 14 Jun 2024 22:21:48 +0800, Zong Li <zong.li@sifive.com> wrote:
> >
> > > This patch initialize the pmu stuff and uninitialize it when driver
> > > removing. The interrupt handling is also provided, this handler need =
to
> > > be primary handler instead of thread function, because pt_regs is emp=
ty
> > > when threading the IRQ, but pt_regs is necessary by perf_event_overfl=
ow.
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > ---
> > >  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 65 insertions(+)
> > >
> > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.=
c
> > > index 8b6a64c1ad8d..1716b2251f38 100644
> > > --- a/drivers/iommu/riscv/iommu.c
> > > +++ b/drivers/iommu/riscv/iommu.c
> > > @@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int =
irq, void *data)
> > >   return IRQ_HANDLED;
> > >  }
> > >
> > > +/*
> > > + * IOMMU Hardware performance monitor
> > > + */
> > > +
> > > +/* HPM interrupt primary handler */
> > > +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id=
)
> > > +{
> > > + struct riscv_iommu_device *iommu =3D (struct riscv_iommu_device *)d=
ev_id;
> > > +
> > > + /* Process pmu irq */
> > > + riscv_iommu_pmu_handle_irq(&iommu->pmu);
> > > +
> > > + /* Clear performance monitoring interrupt pending */
> > > + riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PM=
IP);
> > > +
> > > + return IRQ_HANDLED;
> > > +}
> > > +
> > > +/* HPM initialization */
> > > +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> > > +{
> > > + int rc;
> > > +
> > > + if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > > +     return 0;
> > > +
> > > + /*
> > > +  * pt_regs is empty when threading the IRQ, but pt_regs is necessar=
y
> > > +  * by perf_event_overflow. Use primary handler instead of thread
> > > +  * function for PM IRQ.
> > > +  *
> > > +  * Set the IRQF_ONESHOT flag because this IRQ might be shared with
> > > +  * other threaded IRQs by other queues.
> > > +  */
> > > + rc =3D devm_request_irq(iommu->dev,
> > > +               iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_=
IPSR_PMIP)],
> > > +               riscv_iommu_hpm_irq_handler, IRQF_ONESHOT | IRQF_SHAR=
ED, NULL, iommu);
> > > + if (rc)
> > > +     return rc;
> > > +
> > > + return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu=
->dev));
> > > +}
> > > +
> >
> > What are the benefits of initializing the iommu-pmu driver in the iommu=
 driver?
> >
> > It might be better for the RISC-V IOMMU PMU driver to be loaded as a se=
parate module, as this would allow greater flexibility since different vend=
ors may need to add custom events.
> >
> > Also, I'm not quite clear on how custom events should be added if the R=
ISC-V iommu-pmu is placed within the iommu driver.
>
> Hi Liqiang,
> My original idea is that, since the IOMMU HPM is not always present,
> it depends on the capability.HPM bit, if we separate HPM into an
> individual module, I assume that the PMU driver may not have access to
> the IOMMU's complete MMIO region. I=E2=80=99m not sure how we would check=
 the
> capability register in the PMU driver and avoid the following
> situation: capability.HPM is zero, but the IOMMU-PMU driver is still
> loaded because the PMU node is present in the DTS. It will be helpful
> if you have any suggestions on this.
>
> Regarding custom events, since we don=E2=80=99t have the driver data, my
> current rough idea is to add a vendor event map table to list the
> vendor events and use Kconfig to define them respectively. This is
> just an initial thought and may not be the good solution, so feel free
> to share any recommendations. Of course, if we eventually decide to
> move it to drivers/perf as an individual module, then we could use the
> driver data for custom events, similar to what ARM does.

Maybe let's try auxiliary driver framework to resolve this topic in
the next version.

>
> Thanks
>
> >
> >
> > Best regards,
> > Liqiang
> >
