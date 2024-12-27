Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65E13B58F
	for <iommu@lists.linux.dev>; Fri, 27 Dec 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735288675; cv=none; b=l+hseWyCeYRL2Joz1V90MW286PlLTiqzZ4VVb/Fu8/q+kLJ2IV5Qhj3fsPCQIhzT79R8Jytyten5Vl60wFuhxLwOfNfqnQdIvoLKfADB2pe0zJkc9uDa0mJR2aWtE4M349ae5v6Z08KqLINM5ejYF+OrCJTfDLbgMmJ6YUKUnoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735288675; c=relaxed/simple;
	bh=E5XpsxsAehxwwveYea2HrjGPTiwyMIJR57dEiIRTeDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMoHwonSbG0wDZ72TbymFFcoM0m+io/Gcv4qI/b9Ql9Xolpqp0tiDvffg9idC2dUa4v80ErctWV7CIwk/scCgiFOlKXhFYzqW29MCb4YU0yb+97bR8cKnKd7xf9+YM8kD5LEgJTxV6mWzjZifNFFKG+J5Nx/81mMHO2ce6nhqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TZ43yEG7; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TZ43yEG7"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844eac51429so588158339f.2
        for <iommu@lists.linux.dev>; Fri, 27 Dec 2024 00:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1735288673; x=1735893473; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSZdTXx1oWeAD96ChZR/AxHkCGEYuuBJCiYM9eU7Hho=;
        b=TZ43yEG76DtR5FybDQlT7ppmcvZZWy9EKjlpfUwL3z9nV2ZKAXOrQiCXuFlairb/VI
         akEb7cTcExbAUSsD3zOAJcLb5gaURO2V/pNfeK0wCDl2WutYlQy33cSuIkNUfk6o4isB
         kBrR2i0Aw5P346dEJmNcGEj50M9yG2l6yrt3nN13sjRfjH+j8ghMHGk+9PhqRpK+qO13
         Gzo12b7RhL9w8kKjtd1PliB3hdfLfWrjx54uUJtXBDDmCHOI1zJuxggz41mxN1CDuv5k
         VAmwcIMXU34DbIwqHoPnX3jSwDBYhmC1couDZcBNkFKykeV55PUgIgZU/7XXEqLKz+5i
         ANlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735288673; x=1735893473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSZdTXx1oWeAD96ChZR/AxHkCGEYuuBJCiYM9eU7Hho=;
        b=k602mKWASuWnvW0LK/KIZTJAmKJYdjRZvgpnT3wi4o+oqnP5PnqN6Vk1NfYnQgux/v
         nJnD+Y7xY1tIp+KHrJP42ukMysztIK8sVT6JxZjvwto8RvkzgXBxBUG74CAEhIgudk4n
         mizXlclWXxqPH7qDUj25W4+gmfG2wSStb3fyTyvhnJ4xdaqHhzkQqQqXrjOrksNosFWg
         AgszL6vHabMAaIeDTq9opSeDjDf+aftUIu5z/fMW3L4CZhN1o3+coiQ08VgbvV2Ruynv
         flCfihTE770G6p/5QZc2qH5rMeoy5Ppn4v9cPh3c/vlGfNNB8vGf18o9a29jCw5RQeQ4
         4vIA==
X-Forwarded-Encrypted: i=1; AJvYcCU7YiJMQmPxriTT6WsvblrS5YaRRiIFBZJLb8pZAkZIi6E6Lo/0z0wkWWuwYBdTUD7IXcBjVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhIL1cLhx4DYNaDyJ23gtY4PToX33qpnz9Md4r2o/cXIltInER
	HdF7oeql/8c5DspEGHxjlZ40EphVp1Ja22cS3HcmcdCIJzIYsfMuC2qgyzSy/0H4a02MrnqZy1O
	c6GfzJLE75vASZi99GLZlD9WDhHVV9n6gnAspUg==
X-Gm-Gg: ASbGncv5za3GRnkR3XxZqi+wOvXrNI7vKefZrsZ8WZIaEj2kM3gskHZ4Hyi/Yc5zTot
	o2dfd2Cv0G0KBt1YDGr34hQ5faJAYroTHUQ62eiHA
X-Google-Smtp-Source: AGHT+IF90MNCmZOGukHpWTbUxyha7YkUKCqLcQ50bedAQaFq1n4y6BkEM/676ICpqo7GYQyEkbuSs6cWm/+EFcva0PE=
X-Received: by 2002:a05:6602:1511:b0:844:b6bd:4b35 with SMTP id
 ca18e2360f4ac-8499e2ac0e5mr2763403339f.0.1735288672940; Fri, 27 Dec 2024
 00:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-3-zong.li@sifive.com>
 <CAEEQ3wmccVW0ApAxeGM97XS7BH3khuzRK=wAhg5En3BjEKNnvw@mail.gmail.com> <CAPYmKFtHn+ggujCWeQoSaWPK-2G=-Om0DuCpFyf+ha+OXQfsnw@mail.gmail.com>
In-Reply-To: <CAPYmKFtHn+ggujCWeQoSaWPK-2G=-Om0DuCpFyf+ha+OXQfsnw@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 27 Dec 2024 16:37:42 +0800
Message-ID: <CANXhq0qo2=ztcv8CT8Qu4hk_wZpCnmupSknaGLB+mhxN3vqN8Q@mail.gmail.com>
Subject: Re: [External] [RFC PATCH v2 02/10] iommu/riscv: support HPM and
 interrupt handling
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: yunhui cui <cuiyunhui@bytedance.com>, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 4:48=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> w=
rote:
>
> Hi Zong Li,
>
> Thanks for your job. We have tested your iommu pmu driver and have
> some feedbacks.
>
> 1. Maybe it is better to clear ipsr.PMIP first and then handle the pmu
> ovf irq in riscv_iommu_hpm_irq_handler(). Otherwise, if a new overflow
> happens after the riscv_iommu_pmu_handle_irq() and before pmip clear,
> we will drop it.

Yes, you are right. Let me change the order in the next version.

>
> 2. The period_left can be messed in riscv_iommu_pmu_update() as
> riscv_iommu_pmu_get_counter() always return the whole register value
> while bit 63 in hpmcycle actually indicates whether overflow happens
> instead of current value. Maybe these two functions should be
> implemented as:

Thanks for catch that. I will fix them in the next version.

>
> static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu, u32 =
idx,
>                                         u64 value)
> {
>         void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
>
>         if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
>                 return;
>
>         if (idx =3D=3D 0)
>                 value =3D (value & ~RISCV_IOMMU_IOHPMCYCLES_OF) |
>                         (readq(addr) & RISCV_IOMMU_IOHPMCYCLES_OF);
>
>         writeq(FIELD_PREP(RISCV_IOMMU_IOHPMCTR_COUNTER, value), addr + id=
x * 8);
> }
>
> static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u32 i=
dx)
> {
>         void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
>         u64 value;
>
>         if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
>                 return -EINVAL;
>
>         value =3D readq(addr + idx * 8);
>
>         if (idx =3D=3D 0)
>                 return FIELD_GET(RISCV_IOMMU_IOHPMCYCLES_COUNTER, value);
>
>         return FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, value);
> }
>
> Please ignore me if these issues have already been discussed.
>
> Best regards,
>
> Xu Lu
>
> On Tue, Dec 10, 2024 at 3:55=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Add Luxu in the loop.
> >
> > On Fri, Jun 14, 2024 at 10:22=E2=80=AFPM Zong Li <zong.li@sifive.com> w=
rote:
> > >
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
> > >         return IRQ_HANDLED;
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
> > > +       struct riscv_iommu_device *iommu =3D (struct riscv_iommu_devi=
ce *)dev_id;
> > > +
> > > +       /* Process pmu irq */
> > > +       riscv_iommu_pmu_handle_irq(&iommu->pmu);
> > > +
> > > +       /* Clear performance monitoring interrupt pending */
> > > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_I=
PSR_PMIP);
> > > +
> > > +       return IRQ_HANDLED;
> > > +}
> > > +
> > > +/* HPM initialization */
> > > +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> > > +{
> > > +       int rc;
> > > +
> > > +       if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > > +               return 0;
> > > +
> > > +       /*
> > > +        * pt_regs is empty when threading the IRQ, but pt_regs is ne=
cessary
> > > +        * by perf_event_overflow. Use primary handler instead of thr=
ead
> > > +        * function for PM IRQ.
> > > +        *
> > > +        * Set the IRQF_ONESHOT flag because this IRQ might be shared=
 with
> > > +        * other threaded IRQs by other queues.
> > > +        */
> > > +       rc =3D devm_request_irq(iommu->dev,
> > > +                             iommu->irqs[riscv_iommu_queue_vec(iommu=
, RISCV_IOMMU_IPSR_PMIP)],
> > > +                             riscv_iommu_hpm_irq_handler, IRQF_ONESH=
OT | IRQF_SHARED, NULL, iommu);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > > +       return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name=
(iommu->dev));
> > > +}
> > > +
> > > +/* HPM uninitialization */
> > > +static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu=
)
> > > +{
> > > +       if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > > +               return;
> > > +
> > > +       devm_free_irq(iommu->dev,
> > > +                     iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_=
IOMMU_IPSR_PMIP)],
> > > +                     iommu);
> > > +
> > > +       riscv_iommu_pmu_uninit(&iommu->pmu);
> > > +}
> > > +
> > >  /* Lookup and initialize device context info structure. */
> > >  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_=
device *iommu,
> > >                                                  unsigned int devid)
> > > @@ -1612,6 +1668,9 @@ void riscv_iommu_remove(struct riscv_iommu_devi=
ce *iommu)
> > >         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE=
_OFF);
> > >         riscv_iommu_queue_disable(&iommu->cmdq);
> > >         riscv_iommu_queue_disable(&iommu->fltq);
> > > +
> > > +       if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> > > +               riscv_iommu_pmu_uninit(&iommu->pmu);
> > >  }
> > >
> > >  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> > > @@ -1651,6 +1710,10 @@ int riscv_iommu_init(struct riscv_iommu_device=
 *iommu)
> > >         if (rc)
> > >                 goto err_queue_disable;
> > >
> > > +       rc =3D riscv_iommu_hpm_enable(iommu);
> > > +       if (rc)
> > > +               goto err_hpm_disable;
> > > +
> > >         rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "ris=
cv-iommu@%s",
> > >                                     dev_name(iommu->dev));
> > >         if (rc) {
> > > @@ -1669,6 +1732,8 @@ int riscv_iommu_init(struct riscv_iommu_device =
*iommu)
> > >  err_remove_sysfs:
> > >         iommu_device_sysfs_remove(&iommu->iommu);
> > >  err_iodir_off:
> > > +       riscv_iommu_hpm_disable(iommu);
> > > +err_hpm_disable:
> > >         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE=
_OFF);
> > >  err_queue_disable:
> > >         riscv_iommu_queue_disable(&iommu->fltq);
> > > --
> > > 2.17.1
> > >
> > >
> >
> > Thanks,
> > Yunhui
