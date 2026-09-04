Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5BB3515D5
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511154; cv=pass; b=pn9eYyXKJ+zO8L6XuSLqNWpdXoYP6ZLgb5YXBhWaAGa2x8a0wWJsPdIFO3luUI7JYMWcuaR2AvPnVB52/oK1LwlVDtPepBM9apt8Q06Sr+ugPNSYAD8D7GhkOWN8biDbJk7lGNql3FtTArcLN2a2p5D556qp8o+A92vi3BCGj7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511154; c=relaxed/simple;
	bh=GQed7CqsS3QleH5pIiv9aPt0TZqyTnZ/ZD+IeeOLgiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1D2jLa8Hc/5oZPz5wiMXmBAuvJFCqNCQ6Qbk5FHbPdzR0eNKnZ6GrTHDG18TG8qdAIJ4p8IpTfJciRwoECn2AwU5ZK8KBwdFK3F21+0jqvzWltqeBKIr0GFM6mXrQvFKFP1qNq6oWTwC7sAKyqKYeC5opqbcT3pua8k4WM6MxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DtoAw1eL; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DtoAw1eL"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a68aaf4840so1700830a12.0
        for <iommu@lists.linux.dev>; Fri, 04 Sep 2026 01:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788511149; cv=none;
        d=google.com; s=arc-20260327;
        b=Krcld+k5owzF5FNm6c69nBaEWp/gq3LmY8sgUrWbDZuvP0VxFe8PQTt6aGD6WasWxj
         /pRK02hGPF3qzEVFa34WJFDczU1ur0rmswM/aWghAz1rTfQshnQwNVHwFIbJOrAjc0rY
         zs2JT/HTiAUWTDltsEhAde3zW30nSYgtGslx04yGEaVU6pe1/lBN9kjqAScrcITq8E/+
         1vHPI1Eq555A32mhXhKFLZ3aD+TpOH6gRbNCATO6ZR1Cff7ho6R9RZrdwPfA8bve2uXk
         9OfRqgJ4E9eS27S1VKyrRhQXDwmQsCxzS+m30k/8JYfcMIc46vLHpa1LN32sjMFC8qQ3
         Vlxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EzvphpTn3Z6bxsTKUhE7ieqFjf3qSKtb7ZjdbCXHmpM=;
        fh=NFKkV0t2cXWniYJGTZ8h7KYHy4w6k6sSIoG/PTbUiZs=;
        b=NxC8Xb8NsXnBBk2Jj6qR1oG5WzRM/2u1KMxK6N73GRC/1+wbhKXBfSs+sX2CBmanpl
         hf+rIH8x8oDswKXlFNFixk+DCY08Zqz9KpaZeP1tbhEZmPoZGIbQxVTfBSrkRpcp7kH2
         dXZqCqXLBNElGIEXPWlTNW5r7pmKHDDINCWjhogOGTpJxjyIeupcNnp+RhuNcX76EAVV
         6C7JoHrWNp0phugtPGJ4hCekwrLvnG36mUH77m7Avghcr8JZfg2ot1tvFSompX5Vmt25
         JUOkqlPqhCKNYgnKdpL2hESrMp8n2rWwDZWxeETz2Wd0oJIDzMqB0h4sMhWpoOvZMrYZ
         UB8A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788511149; x=1789115949; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EzvphpTn3Z6bxsTKUhE7ieqFjf3qSKtb7ZjdbCXHmpM=;
        b=DtoAw1eLIR/wZVNLuZLHdl5s/QgByoNv2kfmVmgRDKLPxIT+7pbfbv2U++xHW8PHxp
         wdgtE8dedNicoamknfbpwwY3tpSyeSPm1eg8yWcveYH1ApX404v5giOvHnjw26/KvMAf
         iw7iFw31SCXhrYJE6F/bsI5dZxk9Zo95GGEeRMakcV4cflDvf2okS6ItxkQVjJGfwTkC
         ZGCpW4Qvlg53LvrfVFjkEYd+ByGfhHAUALUeJkKI4MQp36n7BbfYzwJtILB/Ggr3I38j
         KVE6vl8jgipmq0bKG8aACoYixaomejtQqblL2IeXm2VvP6Zow1KkCFazMyba97lE5oJ9
         okRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511149; x=1789115949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EzvphpTn3Z6bxsTKUhE7ieqFjf3qSKtb7ZjdbCXHmpM=;
        b=kTCfNDILmRIqUkJ82RMQ+4Xj2xRCNRbUVHTY8C9eyDtFnGuzc9qd+zf/4LONDDrrUW
         a+RrTUCJvxWrDoJ0lQwRi6+vNLctDLOs3wSS4WI9ftRyiWRxpb2KEXOO5tId8p0p0DCu
         8YyogofTm36dsDb54S2JULbbXaoK4HRRCkjaPvL3R7Zk5r45zIWDLgYK1Fhsmiaa2xwa
         YWAydoE4f4bl/TSVS8i89IgmghwoSbMqSQXCOC0ucu49R5ts9h3otBnS4kspQYd9F5e1
         YyQT1l9PCuOe0TgM8qsESSISeNdKzDZ6NJy3ov1LnxYWUWMsa0JwMrpoo7JY2pPlTT6S
         IXeg==
X-Forwarded-Encrypted: i=1; AKwUvBz2FTZcHueQuJ2kw21eENCKGw4/AsQY/8uy0LfcsazobgQnheSNtfCUxcA3Te7O9cNbKPo2ng==@lists.linux.dev
X-Gm-Message-State: AFuF++nd5Ensnab5ticAMFIfwTQCJCq9lVCF18zVNk2IDUFNNGdONhKt
	cWxKZCXe3wlP0KkWa+2H2MgwUqyMSyUvGDmaoJxLBQ+cw54xvSiHQ9fpC9ih6EqDapPJBNwahEs
	Gg6T2WsJGlLCsDvmh4CHxSuvabRCf3GPyHQc2aGJXfw==
X-Gm-Gg: AYBFou3MNtzpDW/HPDh4SLV9LYasa9hyVrjgqobJ+kyjrL0sbl3Rm6pGplTJjSIWNHR
	yHG5cee7+pPss/ynmdlDOVTBj/g42a7bH/sKx2GLPW7eSiMz/uOjAGpW0IEgduE/lt0B5BRpDbM
	SklCEC2IFVQDLGIfSkmvl2YraIA6UPVtKBRu5qR6iDMocdhvEbcOVkdb/z3Q/faiGKa6fsb5W/R
	efYdnfx6zQu4wHrcTKNM0NpsjxdXZrvKzNn+VtEuQaRMgZPJ9PQZP5okYcKBilP7wM7qW22eEZI
	xMmBIMijYBrH8W1tn31ohyV+qV7lwLiebjQm1Ku6VsRA5+U=
X-Received: by 2002:a05:6402:424d:10b0:6a6:b9eb:e20 with SMTP id
 4fb4d7f45d1cf-6a6b9eb0f5cmr2529416a12.2.1788511149397; Fri, 04 Sep 2026
 01:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260828085819.4076449-1-zong.li@sifive.com> <20260828085819.4076449-4-zong.li@sifive.com>
 <8267ee7a-98b7-42a5-b479-648d2bec8ade@picoheart.com>
In-Reply-To: <8267ee7a-98b7-42a5-b479-648d2bec8ade@picoheart.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 4 Sep 2026 16:38:58 +0800
X-Gm-Features: AcwNN1WRMTwypdAaHYFPNb0pSuReY3IdEEBJ4QNibyPzSTaAHRt107IZJ6oSt6Y
Message-ID: <CANXhq0ogpMSEdjycnz0HCO15q_gYA1hwFU98u09tYL0X8PMtoA@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 3/3] drivers/perf: riscv-iommu: protect shared
 state with a raw spinlock
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:07=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.c=
om> wrote:
>
> On 8/28/26 4:58 PM, Zong Li wrote:
> > Events are bound to one CPU and the interrupt is affine to it, so the
> > perf callbacks running with interrupts disabled would be enough to
> > exclude the handler.
> >
> > PCI MSI/MSI-X on IMSIC breaks that: the irqchip sets
> > IRQCHIP_MOVE_DEFERRED, so irq_set_affinity() reports success while only
> > recording the request, and the move is applied in interrupt context upo=
n
> > the next device interrupt. Until then the interrupt is still routed to
> > the CPU IMSIC picked initially, so the first overflow interrupt can run
> > concurrently with the perf callbacks on the CPU the events are bound to=
.
> >
> > Take a raw spinlock, with interrupts disabled so that the handler can
> > never interrupt a holder on the same CPU, rather than depending on that
> > irqchip behaviour. It covers the state which is reachable from both
> > sides:
> >
> >  - IOCOUNTINH is read-modify-written by ->start()/->stop() and is saved
> >    and restored around the whole handler.
> >  - pmu->events[] is written by ->del() and read by the handler.
> >  - hw_perf_event::prev_count is updated by both.
> >
> > ->add() and ->del() call the unlocked __riscv_iommu_pmu_start() and
> > __riscv_iommu_pmu_stop() so the lock is taken once per callback.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/perf/riscv_iommu_pmu.c | 66 ++++++++++++++++++++++++++++++----
> >  1 file changed, 60 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_=
pmu.c
> > index f6acd56f2f61..ee2f6d1fbece 100644
> > --- a/drivers/perf/riscv_iommu_pmu.c
> > +++ b/drivers/perf/riscv_iommu_pmu.c
> > @@ -101,6 +101,7 @@ struct riscv_iommu_pmu {
> >       u64 event_cntr_mask;
> >       struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
> >       DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
> > +     raw_spinlock_t lock;
> >  };
> >
> >  #define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu,=
 pmu))
> > @@ -485,7 +486,8 @@ static void riscv_iommu_pmu_update(struct perf_even=
t *event)
> >       local64_add(delta, &event->count);
> >  }
> >
> > -static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> > +/* Called with pmu->lock held */
> > +static void __riscv_iommu_pmu_start(struct perf_event *event, int flag=
s)
> >  {
> >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> >       struct hw_perf_event *hwc =3D &event->hw;
> > @@ -500,11 +502,22 @@ static void riscv_iommu_pmu_start(struct perf_eve=
nt *event, int flags)
> >       riscv_iommu_pmu_set_period(event);
> >       riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
> >       riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> > +}
> > +
> > +static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     unsigned long irqflags;
> > +
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > +     __riscv_iommu_pmu_start(event, flags);
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
>
> could use guard(raw_spinlock_irqsave)() to help handle the lock release.
>
> I'm considering if it'll better to use irq_work or function call to handl=
e the
> counts update from the interrupt handler, e.g. in the irq handler first c=
heck
> if current cpu is the pmu->on_cpu, if so update the counts, otherwise que=
ue
> the update work to pmu->on_cpu by irq work or smp_call_function_single_as=
ync.
> In this way we can use pmu's original synchronization mechanism without
> extra spin locks since the callbacks will always run and synchronized by
> the same cpu, and the shared interrupt doesn't matter at all.
>
> any thoughts on this?
>

Thank you for your suggestion. It really helped me re-think the impact
of IRQCHIP_MOVE_DEFERRED.

When an IRQ goes to the wrong CPU, handle_edge_irq() already changes
the affinity to the correct CPU via irq_ack at this time. Because of
this, we might only need a simple check at the beginning of the IRQ
handler. We can just check if the current CPU is the correct one. If
it is not, we can simply return and do nothing. Since PMIP is still
asserted, the IRQ will trigger again and go to the correct CPU.

I will drop this patch and make a new, simpler fix.

Thanks again for your help!

> thanks.
>
> >
> >       perf_event_update_userpage(event);
> >  }
> >
> > -static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> > +/* Called with pmu->lock held */
> > +static void __riscv_iommu_pmu_stop(struct perf_event *event, int flags=
)
> >  {
> >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> >       struct hw_perf_event *hwc =3D &event->hw;
> > @@ -521,13 +534,26 @@ static void riscv_iommu_pmu_stop(struct perf_even=
t *event, int flags)
> >       hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> >  }
> >
> > +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     unsigned long irqflags;
> > +
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > +     __riscv_iommu_pmu_stop(event, flags);
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > +}
> > +
> >  static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> >  {
> >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> >       struct hw_perf_event *hwc =3D &event->hw;
> >       unsigned int num_counters =3D pmu->num_counters;
> > +     unsigned long irqflags;
> >       unsigned int idx;
> >
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > +
> >       /* Reserve index zero for iohpmcycles */
> >       if (is_cycle_event(event->attr.config))
> >               idx =3D RISCV_IOMMU_HPM_CYCLE_IDX;
> > @@ -535,8 +561,10 @@ static int riscv_iommu_pmu_add(struct perf_event *=
event, int flags)
> >               idx =3D find_next_zero_bit(pmu->used_counters, num_counte=
rs, 1);
> >
> >       /* All event counters or cycle counter are in use */
> > -     if (idx =3D=3D num_counters || pmu->events[idx])
> > +     if (idx =3D=3D num_counters || pmu->events[idx]) {
> > +             raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> >               return -EAGAIN;
> > +     }
> >
> >       set_bit(idx, pmu->used_counters);
> >
> > @@ -546,7 +574,9 @@ static int riscv_iommu_pmu_add(struct perf_event *e=
vent, int flags)
> >       local64_set(&hwc->prev_count, 0);
> >
> >       if (flags & PERF_EF_START)
> > -             riscv_iommu_pmu_start(event, flags);
> > +             __riscv_iommu_pmu_start(event, flags);
> > +
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> >
> >       /* Propagate changes to the userspace mapping. */
> >       perf_event_update_userpage(event);
> > @@ -556,18 +586,26 @@ static int riscv_iommu_pmu_add(struct perf_event =
*event, int flags)
> >
> >  static void riscv_iommu_pmu_read(struct perf_event *event)
> >  {
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     unsigned long irqflags;
> > +
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> >       riscv_iommu_pmu_update(event);
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> >  }
> >
> >  static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> >  {
> >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> >       struct hw_perf_event *hwc =3D &event->hw;
> > +     unsigned long irqflags;
> >       int idx =3D hwc->idx;
> >
> > -     riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > +     __riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> >       pmu->events[idx] =3D NULL;
> >       clear_bit(idx, pmu->used_counters);
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> >
> >       perf_event_update_userpage(event);
> >  }
> > @@ -635,12 +673,24 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(in=
t irq, void *dev_id)
> >  {
> >       struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_id;
> >       DECLARE_BITMAP(ovf_bitmap, BITS_PER_TYPE(u64));
> > +     unsigned long irqflags;
> >       u32 ovf, idx, inhibit;
> >
> > -     /* Check whether this interrupt is for PMU */
> > +     /*
> > +      * Check whether this interrupt is for PMU. Done outside the lock=
 so
> > +      * that a shared interrupt line is left alone as cheaply as possi=
ble.
> > +      */
> >       if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMM=
U_IPSR_PMIP))
> >               return IRQ_NONE;
> >
> > +     /*
> > +      * Hold the lock across the whole sequence below. Stopping the
> > +      * counters, processing them and restoring the previous inhibit s=
tate
> > +      * has to be atomic against ->start()/->stop(), otherwise a count=
er
> > +      * enabled in between would be inhibited again by the restore.
> > +      */
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > +
> >       /* Process PMU IRQ */
> >       inhibit =3D riscv_iommu_pmu_stop_all(pmu);
> >
> > @@ -672,6 +722,8 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(int =
irq, void *dev_id)
> >
> >       riscv_iommu_pmu_start_all(pmu, inhibit);
> >
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > +
> >       return IRQ_HANDLED;
> >  }
> >
> > @@ -735,6 +787,8 @@ static int riscv_iommu_pmu_probe(struct auxiliary_d=
evice *auxdev,
> >
> >       iommu_pmu->reg =3D iommu_dev->reg;
> >
> > +     raw_spin_lock_init(&iommu_pmu->lock);
> > +
> >       /*
> >        * Counter number and width are hardware-implemented, detect them=
 by
> >        * writing 1s and reading back which bits stuck.
