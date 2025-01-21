Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8F1714A5
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737448657; cv=none; b=eMHHfAlI6XS1I6PwtbelU5SzV/MNQCRpRWj8k9XyOTLdC6zcs6hNhV4yMpnUvgstlYNFHlMU0AA3AlobpDQhFBwRdZlgxDHWNmf9P9HECC+XDkPdtjIkIVCLPKcl3GGqZE7XMXpehg0FcoX0s7l4Nhi6dmVIqZ40sKMuJWaECms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737448657; c=relaxed/simple;
	bh=q/YXcPkP6j9/JtYuCKtpB16EjGGLnClWx3lp0QegbYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTXi9ZoR/LlFtECBdkzjPIGw2YphamcbrN1vql5t4CSdRL5Y0dmKwEm6XX6i0Lx/SGsNVTp63pTAghuQTleL2pWRIgcwhw1mL8Fqws7k/I5+VQG2GeQEqeKplwfVc/l8x1GIJwrXPp3h/UMlRMxrhWrYsyYPP3kA6FeJS6PlNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=d7ZVtUFI; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d7ZVtUFI"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cfa9272c14so911055ab.3
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 00:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1737448654; x=1738053454; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EErsvLFUMtwyIbJnbfERrawyL1tVSt57dS6Who8TTyY=;
        b=d7ZVtUFIR2iQp/QI3ZBBruVu2zwGfDz3duQDx7qCSzqzEFgEtqA7KbO2THyPshLPr8
         WCds9BoSMZDZDw/P2YcYCIw8qa07iaAqVAwCZKQGiKics6ld7GblsPYILBSqBQWaoJj5
         i/uE9kOn5wNMpggtpo+URG/wfXN+wGHckLgSR29oKm19k38zeWjY4cOooG8z7qMfixts
         KlWjGtOml7KqH7glvk0omi9lztn18Ujbk22ARldegXhu4IsP6WrOxtFYPrLen1JDgPRu
         kgy1ySL75Hkn2Ag9BLWDpNX7++EmWm7E3r28dgF8LvTjQJczv7F4QFniCqHvVKZEfeYU
         Hg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737448654; x=1738053454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EErsvLFUMtwyIbJnbfERrawyL1tVSt57dS6Who8TTyY=;
        b=kOtoCBy79iRJA+jJFiIzH/qcTWvACX3+yWYgeDF7c00uYsvgVktuXZNiJOVytDqzV2
         FJ0V4cJKij7pm1UbgGD8p/sBUX+tephK/FTKvxFA816JnvilQoWjZIHqO3f00Nrp2x2H
         eMpQuJkVzfZ+DuTo8Hn5wTYudNmgNs1dzYkBUOkXISlWMrOSY18Z/fwBNItLu/4IWXON
         Fg+xMay5IfHURw1ypFi6VtcT4eFJGiZDoDo7roIuXBpVX5i7uarNXi3UGUvX8QuMNdXh
         mzIXg4EEZxx+4GCw93PqNUYFZiDZfvxTiLUbLP6CvuKHPFyo5cW5V5ORWInJW1Eft9RC
         uJAg==
X-Forwarded-Encrypted: i=1; AJvYcCV0NjYlTTyy8cI+UeO0VQqLkVTIYQ1xA0OXuVD0IGlbhOm2cHAT8d3anizQerWGl/+Rjm0dXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxSS4ywMEAqP32AIA3ZL4vW8Lb2cuwUI4epoMVIPLtZtQePuiL3
	DkZ7Oz0I9YHitU5ktq+brZfgvF1V8fhPk7d0G8rrVKo2G5hSuoJrFHM2QU8cVLYuP0e+/q1ySCA
	qvtSrfSZ+KeplKVzNphx5V0wdhPb8oBJpJC8D1Q==
X-Gm-Gg: ASbGncv/JBaJmCJmOAUuYm/E1jOLsAYAlzKzo4rmpzZSWe6HPy64HuWZjTpFJ39Otp6
	Fto+mT18zpqiaaonN+gj5X7qxrZvf30Z8jgN/DiZcGb1VRic62SGe2A==
X-Google-Smtp-Source: AGHT+IEC2oPzCFfgCD9zHXuJFglchxr8YhWRFH5WN/dbnSoPI76AiG7cPO+FnSUDX0oL8rjqJZtBboWg3N3DPymAVwM=
X-Received: by 2002:a05:6e02:1aa8:b0:3cf:6d33:d40d with SMTP id
 e9e14a558f8ab-3cf742812e4mr123041605ab.0.1737448654288; Tue, 21 Jan 2025
 00:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250115030306.29735-1-zong.li@sifive.com> <20250115030306.29735-3-zong.li@sifive.com>
 <6301d20b-d51d-4f96-94ea-134e065d398e@arm.com> <CANXhq0oDv0b_S=6EmETAUkjQxo3Zz5fZ-yeP-9hHSMW9Ak5=sg@mail.gmail.com>
 <b0dadc40-638e-4f14-8a5c-70c306bc4650@arm.com>
In-Reply-To: <b0dadc40-638e-4f14-8a5c-70c306bc4650@arm.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 21 Jan 2025 16:37:23 +0800
X-Gm-Features: AbW1kvZ71HK_s4sWjLIFCatGdv6WaJXav0vR9gPNHa6MZdgG5R3zyOGc7TZo4Rc
Message-ID: <CANXhq0oqeTJfSsDy0VKhfdeOssO7JVtz=XjZcFiLCbgkxK4zqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/riscv: support HPM and interrupt handling
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, tjeznach@rivosinc.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	luxu.kernel@bytedance.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 8:45=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2025-01-17 2:46 am, Zong Li wrote:
> > On Thu, Jan 16, 2025 at 5:56=E2=80=AFAM Robin Murphy <robin.murphy@arm.=
com> wrote:
> >>
> >> On 2025-01-15 3:03 am, Zong Li wrote:
> >>> Initialize the PMU and uninitialize it when driver is removed.
> >>> Interrupt handling is also implemented, and the handler needs
> >>> to be a primary handler instead of a threaded function because
> >>> pt_regs is empty when threading the IRQ. However, pt_regs is
> >>> required by perf_event_overflow.
> >>>
> >>> Signed-off-by: Zong Li <zong.li@sifive.com>
> >>> Tested-by: Xu Lu <luxu.kernel@bytedance.com>
> >>> ---
> >>>    drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++=
++++
> >>>    1 file changed, 65 insertions(+)
> >>>
> >>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.=
c
> >>> index 8a05def774bd..20ae90471484 100644
> >>> --- a/drivers/iommu/riscv/iommu.c
> >>> +++ b/drivers/iommu/riscv/iommu.c
> >>> @@ -552,6 +552,62 @@ static irqreturn_t riscv_iommu_fltq_process(int =
irq, void *data)
> >>>        return IRQ_HANDLED;
> >>>    }
> >>>
> >>> +/*
> >>> + * IOMMU Hardware performance monitor
> >>> + */
> >>> +
> >>> +/* HPM interrupt primary handler */
> >>> +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id=
)
> >>> +{
> >>> +     struct riscv_iommu_device *iommu =3D (struct riscv_iommu_device=
 *)dev_id;
> >>> +
> >>> +     /* Clear performance monitoring interrupt pending */
> >>> +     riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPS=
R_PMIP);
> >>> +
> >>> +     /* Process pmu irq */
> >>> +     riscv_iommu_pmu_handle_irq(&iommu->pmu);
> >>> +
> >>> +     return IRQ_HANDLED;
> >>> +}
> >>> +
> >>> +/* HPM initialization */
> >>> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> >>> +{
> >>> +     int rc;
> >>> +
> >>> +     if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> >>> +             return 0;
> >>> +
> >>> +     /*
> >>> +      * pt_regs is empty when threading the IRQ, but pt_regs is nece=
ssary
> >>> +      * by perf_event_overflow. Use primary handler instead of threa=
d
> >>> +      * function for PM IRQ.
> >>> +      *
> >>> +      * Set the IRQF_ONESHOT flag because this IRQ might be shared w=
ith
> >>> +      * other threaded IRQs by other queues.
> >>> +      */
> >>> +     rc =3D devm_request_irq(iommu->dev,
> >>> +                           iommu->irqs[riscv_iommu_queue_vec(iommu, =
RISCV_IOMMU_IPSR_PMIP)],
> >>> +                           riscv_iommu_hpm_irq_handler, IRQF_ONESHOT=
 | IRQF_SHARED, NULL, iommu);
> >>
> >> Hmm, shared interrupts are tricky for PMUs, since perf requires any IR=
Q
> >> handler touching a PMU is running on pmu->cpu, so you have to be very
> >> careful about maintaining affinity and not letting anyone else change =
it
> >> behind your back.
> >>
> >> The other thing is that if it really is shared, at this point you coul=
d
> >> now be in riscv_iommu_pmu_handle_irq() dereferencing NULL.
> >
> > Yes, the PMU IRQ line could be shared with the command queue, fault
> > queue, and page-request queue.
> > Could you please provide more tips on what is meant by "dereferencing
> > NULL in riscv_iommu_pmu_handle_irq()"?
> > I don't complete understand what needs to be done there.
> > Thanks
>
> In general it's not a great idea to register an IRQ handler before the
> data passed to that handler is initialised. What is pointed to by
> (&iommu->pmu)->reg + RISCV_IOMMU_REG_IOCOUNTOVF if the IRQ fires right
> now (and/or if CONFIG_DEBUG_SHIRQ ever gets fixed)? ;)

Sorry for the misunderstanding earlier; I understand now. I think I
might need to exchange the IRQ request and PMU initialization,
ensuring that the PMU instance is initialized before a PMU interrupt
arrives. Thanks!

>
> (OK, it's not *literally* NULL, but hey...)
>
> Thanks,
> Robin.
>
> >>
> >>> +     if (rc)
> >>> +             return rc;
> >>> +
> >>> +     return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(i=
ommu->dev));
> >>> +}
> >>> +
> >>> +/* HPM uninitialization */
> >>> +static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu=
)
> >>> +{
> >>> +     if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> >>> +             return;
> >>> +
> >>> +     devm_free_irq(iommu->dev,
> >>> +                   iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IO=
MMU_IPSR_PMIP)],
> >>> +                   iommu);
> >>> +
> >>> +     riscv_iommu_pmu_uninit(&iommu->pmu);
> >>> +}
> >>> +
> >>>    /* Lookup and initialize device context info structure. */
> >>>    static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iomm=
u_device *iommu,
> >>>                                                 unsigned int devid)
> >>> @@ -1596,6 +1652,9 @@ void riscv_iommu_remove(struct riscv_iommu_devi=
ce *iommu)
> >>>        riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_=
OFF);
> >>>        riscv_iommu_queue_disable(&iommu->cmdq);
> >>>        riscv_iommu_queue_disable(&iommu->fltq);
> >>> +
> >>> +     if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> >>> +             riscv_iommu_pmu_uninit(&iommu->pmu);
> >>>    }
> >>>
> >>>    int riscv_iommu_init(struct riscv_iommu_device *iommu)
> >>> @@ -1635,6 +1694,10 @@ int riscv_iommu_init(struct riscv_iommu_device=
 *iommu)
> >>>        if (rc)
> >>>                goto err_queue_disable;
> >>>
> >>> +     rc =3D riscv_iommu_hpm_enable(iommu);
> >>> +     if (rc)
> >>> +             goto err_hpm_disable;
> >>> +
> >>
> >> I would leave this until after the whole IOMMU setup has succeeded. Th=
e
> >> PMU is not critical to IOMMU operation, so at that point an error is n=
ot
> >> fatal, it just means you don't get a PMU, thus there shouldn't need to
> >> be any cleanup outside riscv_iommu_hpm_enable() itself.
> >
> > Thanks for pointing this out. PMU failure shouldn't cause the entire
> > IOMMU to fail, let me modify it in the next version.
> >
> >>
> >> Thanks,
> >> Robin.
> >>
> >>>        rc =3D iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "risc=
v-iommu@%s",
> >>>                                    dev_name(iommu->dev));
> >>>        if (rc) {
> >>> @@ -1653,6 +1716,8 @@ int riscv_iommu_init(struct riscv_iommu_device =
*iommu)
> >>>    err_remove_sysfs:
> >>>        iommu_device_sysfs_remove(&iommu->iommu);
> >>>    err_iodir_off:
> >>> +     riscv_iommu_hpm_disable(iommu);
> >>> +err_hpm_disable:
> >>>        riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_=
OFF);
> >>>    err_queue_disable:
> >>>        riscv_iommu_queue_disable(&iommu->fltq);
> >>
>
