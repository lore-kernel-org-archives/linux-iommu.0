Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7942FA0C6
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746079; cv=pass; b=kxYk3sJzMKIP/U2kIv/zq7z1OHksK9tDgXoGERf9ok6U8aDdcabodUkhRE2eTcKBDyD0TislM/6cv/qfzPaUPjLPnrYdz3Tlu5p15hIAGN8vv6jAjgyo8AQEqcvFaWm57MmjUDhpQn1h1YaGJatl9WrhdBY6c1ID6BNkJpawdqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746079; c=relaxed/simple;
	bh=HsGjhU3uBTpHPuq4JphTd+S+S3oIGE294X2u5LK4rnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MafXMsDR7VX7484WckPvyfpTpWkBgBsiijG2DK7DQSODwsxB6B2MgCG/q04CtGF8wPJsGMftUgshOwUOkFzMsE75rccd4hndwWch9xR4kD4XKQIgrz1DKe6J4HJiEgTwui/X8ZYGnJfgkoAcFxS5QIgbX6I3BG8vedAlPQYS95g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nIG6sbB3; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nIG6sbB3"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso3637881a12.3
        for <iommu@lists.linux.dev>; Sun, 06 Sep 2026 18:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788746072; cv=none;
        d=google.com; s=arc-20260327;
        b=TfTdEifEVhjxv/k7nb/GlBUcLalIl8o6tcuftFxqaezRmyyGWvbkMInYjxrj4pyVy+
         ky8T0EPI1LqrT9UDe/ERzTpU/neMQsEHSR0eI8cxSZFDn+8fn+88e66SIf8zAD83nytd
         OifJDuY29ABF96tyFUTFPz10NQni42+wQbQ8auq6zcVK13t6HVOhtY0TYJYNfBl2oGlU
         Cu6aoPHjS147dSg61f+CoKmNqQZnGSN+5I75pQdqY2afasi32ZpbRas8i+EN9GLpPmdL
         FP9s+dnY/84AC3CtFMY5i+tFkrsjdCN+OWTbcDjDx2CVRAucxH1sZKY95AWpVaIjB3v3
         1PJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=deuBYUmBSWla/VSTwOIDmtGNAoeBNifbTvyqlKPlcA0=;
        fh=4rrLzIE1Vm2/QcirhJ1P7odnNTu/3mYWoBVUOEuVM5M=;
        b=eJ4HYckwAJDNwzXTiCHWBOkvgDvcW//BZT+83Mq9UZgQLzTOSvrJKko8a+4H0/QZId
         WrapUgaAm5QK6bEGHFNy6cctmlhWEWHviwplrInHg3Ky6oUyyUYWI3c8k53i1qs4MCOP
         lcWuqktPGTk9e/RDIQ3ybba8w2e/i+3imun90wTCN7sZGvUd1Ppnvamnq6/xO1iMVi6G
         WNknKlcv++2oPlZObgoMsPXxOJ/4beJhDLS8UZtJYdKebEU2Nl3W69LsusD41EIiaAqc
         Iga+D3iAHcvxicSdIauxwn8Bo4lkL3plw+NTCNcx2hvv5FtnN60L5t4n+Yfi43PdRlpy
         hmhg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788746072; x=1789350872; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=deuBYUmBSWla/VSTwOIDmtGNAoeBNifbTvyqlKPlcA0=;
        b=nIG6sbB30Bd693bqdYPyINVZ5jKB4jhjTPO5Be5PfFKvixLkdyOKsSTBWTnAYjAOGi
         reVbLH/zeLnIzzBtk5h4fHQEVBS+aTg5ihHvHfKjsLH/BM1lAY467G1qt1VuqXAZk0Fx
         onpyF6eNVn7zrAChjx5UbvTDCy6CjIzNYkx83gurAR+Mr/IlhiN3EDasyGKhFhRCwrun
         K5ohdp+qbM0OoV9jGw9v4Qj+E9x9QE/ZC/AC2Yy0IrpY6d64oSyHXQ1sZeFJls1h9wrC
         jcZ2x6gs2LC2UqVdirOwjw/jT360xob5mmUmSgSf9dGOt6hRhqSvabrwNNG4VuurakQN
         kzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788746072; x=1789350872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=deuBYUmBSWla/VSTwOIDmtGNAoeBNifbTvyqlKPlcA0=;
        b=FtQmOaj24t58f/4tbenQ1IQdGYpvbDktAqKKlK+7GfkMaA7UpmaqzEcoT+Uv2jawMg
         7qxE9Dxtg/2GLGnagnLag27r3+XuNXJMHIzusfAOe6EVJbK5DlENgHriIFiurPXSopQs
         XgJZ/Tkm5IpjmcS8kNSWBjI+/8bGjWZACRGaC97gMaZ++PAElEO8GhNvj81kMWvwT1gs
         zLpa7huPXYzrsHTcbJy2eVBRitaQVtCAA6QIB0bS6Vkoh2w7Q1MB5K2YnnSsEOxACweJ
         H9u7JcgxkzR9+mT7UVO+wOXPmeDcLkdnIlc3jnHZdHP1S8/o0ThQKRXDpBxC+KYXS4Bm
         aNRw==
X-Forwarded-Encrypted: i=1; AKwUvBzoKhgKBLLp9C8pf2e7vECcuxE16s+IJMu9glMlXJE7+mnCBoMiPj7HYKdrS4cEBRGtd+iVXg==@lists.linux.dev
X-Gm-Message-State: AFuF++nJxfKuTEDwQuWu97jn81NfkB4Cb2/52DebjvsbXpHdeif6hGBG
	mJ9p14jFNEopOHHA8x8Phz3F0DhY1gPHk/p8emsi+3jws+WvKRJz6nBk59ASFgBhYtZ+3ZQ1l4g
	mLwfmM+9mdKfzTD77QVCX+Y5G3uu12+AnOClY2IIWaA==
X-Gm-Gg: AYBFou1Idmmj8Gw4NiWVjzvWVyK0CcU4lnx0GcqIXz4kmnlDNdTrUxps853HXfyCXTE
	6/wf6y/OpSr/VXI6C4nDEd8wmpxKlqyGWqwsljoO7paN3IpotzMPkeDaUDQOZIbPrAJ8MurTFxc
	ix05a7bYEJUs22K66yW7YO41N9rqHzINE45XlrTLc14l8W5kV0sjVmiZhx1rbgNhZCF+ABfuNcZ
	Ycw+x/4HE1DlbuQTCwZ4iTXXel1L8g8LeZalyfs/eXaOQWoeWEzvh7r08oT+5nko3qEhVYN9//6
	Dguxyoor/ti8nv/qujhFUchpusr25DJDYKEoDL5u7Ha3GjQ=
X-Received: by 2002:a05:6402:305c:10b0:6a7:ea54:399 with SMTP id
 4fb4d7f45d1cf-6a7ea5426d4mr4258443a12.42.1788746072194; Sun, 06 Sep 2026
 18:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260828085819.4076449-1-zong.li@sifive.com> <20260828085819.4076449-4-zong.li@sifive.com>
 <8267ee7a-98b7-42a5-b479-648d2bec8ade@picoheart.com> <CANXhq0ogpMSEdjycnz0HCO15q_gYA1hwFU98u09tYL0X8PMtoA@mail.gmail.com>
In-Reply-To: <CANXhq0ogpMSEdjycnz0HCO15q_gYA1hwFU98u09tYL0X8PMtoA@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 7 Sep 2026 09:54:19 +0800
X-Gm-Features: AcwNN1UqYHffd6ZBPh96YDoJNjnRCCNlysDBXVVYQF3Pt6h68uGWSGmk51VjT04
Message-ID: <CANXhq0oBHPFAmANKyt91mKn7_cm2bfZYpcMyO47==GA_WD6fQQ@mail.gmail.com>
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

On Fri, Sep 4, 2026 at 4:38=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Wed, Sep 2, 2026 at 4:07=E2=80=AFPM Yicong Yang <yang.yicong@picoheart=
.com> wrote:
> >
> > On 8/28/26 4:58 PM, Zong Li wrote:
> > > Events are bound to one CPU and the interrupt is affine to it, so the
> > > perf callbacks running with interrupts disabled would be enough to
> > > exclude the handler.
> > >
> > > PCI MSI/MSI-X on IMSIC breaks that: the irqchip sets
> > > IRQCHIP_MOVE_DEFERRED, so irq_set_affinity() reports success while on=
ly
> > > recording the request, and the move is applied in interrupt context u=
pon
> > > the next device interrupt. Until then the interrupt is still routed t=
o
> > > the CPU IMSIC picked initially, so the first overflow interrupt can r=
un
> > > concurrently with the perf callbacks on the CPU the events are bound =
to.
> > >
> > > Take a raw spinlock, with interrupts disabled so that the handler can
> > > never interrupt a holder on the same CPU, rather than depending on th=
at
> > > irqchip behaviour. It covers the state which is reachable from both
> > > sides:
> > >
> > >  - IOCOUNTINH is read-modify-written by ->start()/->stop() and is sav=
ed
> > >    and restored around the whole handler.
> > >  - pmu->events[] is written by ->del() and read by the handler.
> > >  - hw_perf_event::prev_count is updated by both.
> > >
> > > ->add() and ->del() call the unlocked __riscv_iommu_pmu_start() and
> > > __riscv_iommu_pmu_stop() so the lock is taken once per callback.
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > ---
> > >  drivers/perf/riscv_iommu_pmu.c | 66 ++++++++++++++++++++++++++++++--=
--
> > >  1 file changed, 60 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iomm=
u_pmu.c
> > > index f6acd56f2f61..ee2f6d1fbece 100644
> > > --- a/drivers/perf/riscv_iommu_pmu.c
> > > +++ b/drivers/perf/riscv_iommu_pmu.c
> > > @@ -101,6 +101,7 @@ struct riscv_iommu_pmu {
> > >       u64 event_cntr_mask;
> > >       struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
> > >       DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
> > > +     raw_spinlock_t lock;
> > >  };
> > >
> > >  #define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pm=
u, pmu))
> > > @@ -485,7 +486,8 @@ static void riscv_iommu_pmu_update(struct perf_ev=
ent *event)
> > >       local64_add(delta, &event->count);
> > >  }
> > >
> > > -static void riscv_iommu_pmu_start(struct perf_event *event, int flag=
s)
> > > +/* Called with pmu->lock held */
> > > +static void __riscv_iommu_pmu_start(struct perf_event *event, int fl=
ags)
> > >  {
> > >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > >       struct hw_perf_event *hwc =3D &event->hw;
> > > @@ -500,11 +502,22 @@ static void riscv_iommu_pmu_start(struct perf_e=
vent *event, int flags)
> > >       riscv_iommu_pmu_set_period(event);
> > >       riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
> > >       riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_start(struct perf_event *event, int flag=
s)
> > > +{
> > > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > > +     unsigned long irqflags;
> > > +
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > > +     __riscv_iommu_pmu_start(event, flags);
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> >
> > could use guard(raw_spinlock_irqsave)() to help handle the lock release=
.
> >
> > I'm considering if it'll better to use irq_work or function call to han=
dle the
> > counts update from the interrupt handler, e.g. in the irq handler first=
 check
> > if current cpu is the pmu->on_cpu, if so update the counts, otherwise q=
ueue
> > the update work to pmu->on_cpu by irq work or smp_call_function_single_=
async.
> > In this way we can use pmu's original synchronization mechanism without
> > extra spin locks since the callbacks will always run and synchronized b=
y
> > the same cpu, and the shared interrupt doesn't matter at all.
> >
> > any thoughts on this?
> >
>
> Thank you for your suggestion. It really helped me re-think the impact
> of IRQCHIP_MOVE_DEFERRED.
>
> When an IRQ goes to the wrong CPU, handle_edge_irq() already changes
> the affinity to the correct CPU via irq_ack at this time. Because of
> this, we might only need a simple check at the beginning of the IRQ
> handler. We can just check if the current CPU is the correct one. If
> it is not, we can simply return and do nothing. Since PMIP is still
> asserted, the IRQ will trigger again and go to the correct CPU.

I apologize, I missed one detail. The interrupt won't re-trigger if
the PMIP and OF bits are not cleared.
I will follow your suggestion and use the irq_work mechanism. I will
add this to the updated version.
Thank you for your help

>
> I will drop this patch and make a new, simpler fix.
>
> Thanks again for your help!
>
> > thanks.
> >
> > >
> > >       perf_event_update_userpage(event);
> > >  }
> > >
> > > -static void riscv_iommu_pmu_stop(struct perf_event *event, int flags=
)
> > > +/* Called with pmu->lock held */
> > > +static void __riscv_iommu_pmu_stop(struct perf_event *event, int fla=
gs)
> > >  {
> > >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > >       struct hw_perf_event *hwc =3D &event->hw;
> > > @@ -521,13 +534,26 @@ static void riscv_iommu_pmu_stop(struct perf_ev=
ent *event, int flags)
> > >       hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > >  }
> > >
> > > +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags=
)
> > > +{
> > > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > > +     unsigned long irqflags;
> > > +
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > > +     __riscv_iommu_pmu_stop(event, flags);
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > > +}
> > > +
> > >  static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> > >  {
> > >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > >       struct hw_perf_event *hwc =3D &event->hw;
> > >       unsigned int num_counters =3D pmu->num_counters;
> > > +     unsigned long irqflags;
> > >       unsigned int idx;
> > >
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > > +
> > >       /* Reserve index zero for iohpmcycles */
> > >       if (is_cycle_event(event->attr.config))
> > >               idx =3D RISCV_IOMMU_HPM_CYCLE_IDX;
> > > @@ -535,8 +561,10 @@ static int riscv_iommu_pmu_add(struct perf_event=
 *event, int flags)
> > >               idx =3D find_next_zero_bit(pmu->used_counters, num_coun=
ters, 1);
> > >
> > >       /* All event counters or cycle counter are in use */
> > > -     if (idx =3D=3D num_counters || pmu->events[idx])
> > > +     if (idx =3D=3D num_counters || pmu->events[idx]) {
> > > +             raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > >               return -EAGAIN;
> > > +     }
> > >
> > >       set_bit(idx, pmu->used_counters);
> > >
> > > @@ -546,7 +574,9 @@ static int riscv_iommu_pmu_add(struct perf_event =
*event, int flags)
> > >       local64_set(&hwc->prev_count, 0);
> > >
> > >       if (flags & PERF_EF_START)
> > > -             riscv_iommu_pmu_start(event, flags);
> > > +             __riscv_iommu_pmu_start(event, flags);
> > > +
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > >
> > >       /* Propagate changes to the userspace mapping. */
> > >       perf_event_update_userpage(event);
> > > @@ -556,18 +586,26 @@ static int riscv_iommu_pmu_add(struct perf_even=
t *event, int flags)
> > >
> > >  static void riscv_iommu_pmu_read(struct perf_event *event)
> > >  {
> > > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > > +     unsigned long irqflags;
> > > +
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > >       riscv_iommu_pmu_update(event);
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > >  }
> > >
> > >  static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> > >  {
> > >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > >       struct hw_perf_event *hwc =3D &event->hw;
> > > +     unsigned long irqflags;
> > >       int idx =3D hwc->idx;
> > >
> > > -     riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > > +     __riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> > >       pmu->events[idx] =3D NULL;
> > >       clear_bit(idx, pmu->used_counters);
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > >
> > >       perf_event_update_userpage(event);
> > >  }
> > > @@ -635,12 +673,24 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(=
int irq, void *dev_id)
> > >  {
> > >       struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_i=
d;
> > >       DECLARE_BITMAP(ovf_bitmap, BITS_PER_TYPE(u64));
> > > +     unsigned long irqflags;
> > >       u32 ovf, idx, inhibit;
> > >
> > > -     /* Check whether this interrupt is for PMU */
> > > +     /*
> > > +      * Check whether this interrupt is for PMU. Done outside the lo=
ck so
> > > +      * that a shared interrupt line is left alone as cheaply as pos=
sible.
> > > +      */
> > >       if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IO=
MMU_IPSR_PMIP))
> > >               return IRQ_NONE;
> > >
> > > +     /*
> > > +      * Hold the lock across the whole sequence below. Stopping the
> > > +      * counters, processing them and restoring the previous inhibit=
 state
> > > +      * has to be atomic against ->start()/->stop(), otherwise a cou=
nter
> > > +      * enabled in between would be inhibited again by the restore.
> > > +      */
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > > +
> > >       /* Process PMU IRQ */
> > >       inhibit =3D riscv_iommu_pmu_stop_all(pmu);
> > >
> > > @@ -672,6 +722,8 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(in=
t irq, void *dev_id)
> > >
> > >       riscv_iommu_pmu_start_all(pmu, inhibit);
> > >
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > > +
> > >       return IRQ_HANDLED;
> > >  }
> > >
> > > @@ -735,6 +787,8 @@ static int riscv_iommu_pmu_probe(struct auxiliary=
_device *auxdev,
> > >
> > >       iommu_pmu->reg =3D iommu_dev->reg;
> > >
> > > +     raw_spin_lock_init(&iommu_pmu->lock);
> > > +
> > >       /*
> > >        * Counter number and width are hardware-implemented, detect th=
em by
> > >        * writing 1s and reading back which bits stuck.
