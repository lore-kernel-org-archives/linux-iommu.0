Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB1022E3F8
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820528; cv=none; b=URJDznzqd0Wzi9MdvhBHcfS8DP15bze4kANFTXg7lqNNnVM9698sWyT2f/EjmDrfDps1q0v9nqZY43LFiHuigWU2tpQSzR1TYGYKTrAoKoYBGMICVngKVbuvm8wwFDVTBtsC1ORCIMyo75VmmFYtYpd5XXGY8pTZBQ3/K/7YUlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820528; c=relaxed/simple;
	bh=v6xc/l4hD48lWm3gti8CMAmjAPPSWSN9XeL2cEIB4hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfeuzNg9ySaSNs0mv8IQMoebGRBQoWaZFaAoiPBo0wISK+lT5zl7rj3b5mdoe/iOxHEOCwh1Z6kAAR3Gffo6yf0oxOzluk8TBzD8zykVg4DXhWDwJpTKnRqIl7eIHg63juIYCeX5dBIRX0fGKUv707wEN2Mj2EtwjUWbbtu6M8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PdeuQf2I; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PdeuQf2I"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725f4623df7so1574953b3a.2
        for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 00:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733820525; x=1734425325; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xdi3z9/CNbVcJitr9EduQ8bN9iyAWrkkGNI8Z3BdOU=;
        b=PdeuQf2I6mABj7O6Sf4zi3HZQe0Q6oNO6+imorMTtUYaw7YBawdMQIMWnVUF8mW2t1
         Govqr0z/8rKASA5iz3o1wKe6YXMjSCoPqjLmsK6ipTMzTlJb8zItWIu7uIllEab5fJ9q
         l6izliPxk0S+HHPopodBgTWwYH3/bgys140eHBBRYbJGhxTyWabA9Hs6tpssMLUsr8wk
         4i4OHcA6PBBkHHcR16LJZELCyFHkiQEDiGB1B3e2lqCRqFAT0Ayo99vnV7hURgR7d+Lt
         Zl3L5HGjK5ZJoTPWO2InoLloXLPnAidRduzcimeiIGDWGAWOgV4+DP1bNCATjlEtr6VC
         LpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820525; x=1734425325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xdi3z9/CNbVcJitr9EduQ8bN9iyAWrkkGNI8Z3BdOU=;
        b=U0fKvQVNLoOx2xWrJXnhR+c/gUoWOhmtrG4t+gNK2LbxIxpd5YruRlPJuCoWeD56MF
         v4invd+3f58dduq4pZIc9wMTRMJhXv9NuidML10NXg6wQFlLRcz/tOFdEkwRsMF5L8t6
         L7xJqScmblHHmgmIfBTujHdHsYZmnYUbWENERrq1286j34sQN7NtlOLzkqgL8HxFn2SS
         LnTzld3PXY/+krYrkxqTCSI3dahBzNvUfjhQc4/LyYpmnvhS8HvDGrg83yHT6TUG16a5
         HSuH5AJ5cUquZDn40Bb9/c8F8KsfO9wdn3aXkkSGrJ7WSdIAkv1ua1UFK4ocGMuIHWoS
         wuBA==
X-Forwarded-Encrypted: i=1; AJvYcCUgqynAt+nBe2HKJOjW31wtBBiKu59nJn2MJs8pDKKeFkNs+WceDx0eMr7CP3aF/jQqz8un4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ3ac7HguKgIN/5QCKP2XSERhNJ5KQeQja7fys2QGu1S69QHKX
	5DZbXywDCJDizhpCHiOkU3/WSJ8JnQVN2uZ4V4nBz8uOm2sUkKfPFh9wpOWsqKI8xek3sj6h7qO
	83YYdRC7Zl5pzzdqmzDEz9viJMwLv02OUHeI6Ww==
X-Gm-Gg: ASbGncuFi0m5swJz06a0DQQ1En5KfGZkQdXapl+BmAokGSpMjSJo/ZuuKZmmps3FWTa
	QaL5r44o3vovgYfOWVbRDEc52dy2q8IOyDRkTnB7KAlLa6+ls
X-Google-Smtp-Source: AGHT+IEeuMu8uXi3ZE16bp1ukXRs8K6CpNq5yl10CKIHFHI15DQEAFvQNF0rRvfgKbd84KwQSI2khPon70vuDsQN4WY=
X-Received: by 2002:a05:6a20:b598:b0:1e1:afa9:d38b with SMTP id
 adf61e73a8af0-1e1b1a79bf7mr6372667637.8.1733820525586; Tue, 10 Dec 2024
 00:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-3-zong.li@sifive.com>
 <CAEEQ3wmccVW0ApAxeGM97XS7BH3khuzRK=wAhg5En3BjEKNnvw@mail.gmail.com>
In-Reply-To: <CAEEQ3wmccVW0ApAxeGM97XS7BH3khuzRK=wAhg5En3BjEKNnvw@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Tue, 10 Dec 2024 16:48:34 +0800
Message-ID: <CAPYmKFtHn+ggujCWeQoSaWPK-2G=-Om0DuCpFyf+ha+OXQfsnw@mail.gmail.com>
Subject: Re: [External] [RFC PATCH v2 02/10] iommu/riscv: support HPM and
 interrupt handling
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Zong Li <zong.li@sifive.com>, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, jgg@ziepe.ca, kevin.tian@intel.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zong Li,

Thanks for your job. We have tested your iommu pmu driver and have
some feedbacks.

1. Maybe it is better to clear ipsr.PMIP first and then handle the pmu
ovf irq in riscv_iommu_hpm_irq_handler(). Otherwise, if a new overflow
happens after the riscv_iommu_pmu_handle_irq() and before pmip clear,
we will drop it.

2. The period_left can be messed in riscv_iommu_pmu_update() as
riscv_iommu_pmu_get_counter() always return the whole register value
while bit 63 in hpmcycle actually indicates whether overflow happens
instead of current value. Maybe these two functions should be
implemented as:

static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu, u32 id=
x,
                                        u64 value)
{
        void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;

        if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
                return;

        if (idx =3D=3D 0)
                value =3D (value & ~RISCV_IOMMU_IOHPMCYCLES_OF) |
                        (readq(addr) & RISCV_IOMMU_IOHPMCYCLES_OF);

        writeq(FIELD_PREP(RISCV_IOMMU_IOHPMCTR_COUNTER, value), addr + idx =
* 8);
}

static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u32 idx=
)
{
        void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
        u64 value;

        if (WARN_ON_ONCE(idx < 0 || idx > pmu->num_counters))
                return -EINVAL;

        value =3D readq(addr + idx * 8);

        if (idx =3D=3D 0)
                return FIELD_GET(RISCV_IOMMU_IOHPMCYCLES_COUNTER, value);

        return FIELD_GET(RISCV_IOMMU_IOHPMCTR_COUNTER, value);
}

Please ignore me if these issues have already been discussed.

Best regards,

Xu Lu

On Tue, Dec 10, 2024 at 3:55=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Add Luxu in the loop.
>
> On Fri, Jun 14, 2024 at 10:22=E2=80=AFPM Zong Li <zong.li@sifive.com> wro=
te:
> >
> > This patch initialize the pmu stuff and uninitialize it when driver
> > removing. The interrupt handling is also provided, this handler need to
> > be primary handler instead of thread function, because pt_regs is empty
> > when threading the IRQ, but pt_regs is necessary by perf_event_overflow=
.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 8b6a64c1ad8d..1716b2251f38 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int ir=
q, void *data)
> >         return IRQ_HANDLED;
> >  }
> >
> > +/*
> > + * IOMMU Hardware performance monitor
> > + */
> > +
> > +/* HPM interrupt primary handler */
> > +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
> > +{
> > +       struct riscv_iommu_device *iommu =3D (struct riscv_iommu_device=
 *)dev_id;
> > +
> > +       /* Process pmu irq */
> > +       riscv_iommu_pmu_handle_irq(&iommu->pmu);
> > +
> > +       /* Clear performance monitoring interrupt pending */
> > +       riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPS=
R_PMIP);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +/* HPM initialization */
> > +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> > +{
> > +       int rc;
> > +
> > +       if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > +               return 0;
> > +
> > +       /*
> > +        * pt_regs is empty when threading the IRQ, but pt_regs is nece=
ssary
> > +        * by perf_event_overflow. Use primary handler instead of threa=
d
> > +        * function for PM IRQ.
> > +        *
> > +        * Set the IRQF_ONESHOT flag because this IRQ might be shared w=
ith
> > +        * other threaded IRQs by other queues.
> > +        */
> > +       rc =3D devm_request_irq(iommu->dev,
> > +                             iommu->irqs[riscv_iommu_queue_vec(iommu, =
RISCV_IOMMU_IPSR_PMIP)],
> > +                             riscv_iommu_hpm_irq_handler, IRQF_ONESHOT=
 | IRQF_SHARED, NULL, iommu);
> > +       if (rc)
> > +               return rc;
> > +
> > +       return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(i=
ommu->dev));
> > +}
> > +
> > +/* HPM uninitialization */
> > +static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
> > +{
> > +       if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > +               return;
> > +
> > +       devm_free_irq(iommu->dev,
> > +                     iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IO=
MMU_IPSR_PMIP)],
> > +                     iommu);
> > +
> > +       riscv_iommu_pmu_uninit(&iommu->pmu);
> > +}
> > +
> >  /* Lookup and initialize device context info structure. */
> >  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_de=
vice *iommu,
> >                                                  unsigned int devid)
> > @@ -1612,6 +1668,9 @@ void riscv_iommu_remove(struct riscv_iommu_device=
 *iommu)
> >         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_O=
FF);
> >         riscv_iommu_queue_disable(&iommu->cmdq);
> >         riscv_iommu_queue_disable(&iommu->fltq);
> > +
> > +       if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> > +               riscv_iommu_pmu_uninit(&iommu->pmu);
> >  }
> >
> >  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> > @@ -1651,6 +1710,10 @@ int riscv_iommu_init(struct riscv_iommu_device *=
iommu)
> >         if (rc)
> >                 goto err_queue_disable;
> >
> > +       rc =3D riscv_iommu_hpm_enable(iommu);
> > +       if (rc)
> > +               goto err_hpm_disable;
> > +
> >         rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv=
-iommu@%s",
> >                                     dev_name(iommu->dev));
> >         if (rc) {
> > @@ -1669,6 +1732,8 @@ int riscv_iommu_init(struct riscv_iommu_device *i=
ommu)
> >  err_remove_sysfs:
> >         iommu_device_sysfs_remove(&iommu->iommu);
> >  err_iodir_off:
> > +       riscv_iommu_hpm_disable(iommu);
> > +err_hpm_disable:
> >         riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_O=
FF);
> >  err_queue_disable:
> >         riscv_iommu_queue_disable(&iommu->fltq);
> > --
> > 2.17.1
> >
> >
>
> Thanks,
> Yunhui
