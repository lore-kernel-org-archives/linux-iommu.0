Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794062813;
	b=2w+sw6QM6MDVlYco3bxPPEjsxj1157fcGsqoc/9gtt53kKRyZ65eqjruY53M665b+WT5
	 Zdnf476zuHCvhlwxKf4JMbP4AuJ2HS+xfyYzCOXImFHqm9EDzsEqp5RH0LMfY7v1mOAlU
	 D17udcJrFHFcmEgCItHickE5edcWL/UIEQ9AGQg23kbsBZ551lmnx33yUUOtrmFDppLCP
	 CJyuxBAq3QM/bfZ0vvlByPONR3KfMD/5IOalDwtOm/XEH8xDHTHItUDWf1iWCGUCS8Okg
	 Exp63PHMWhr6v+Vselcqsen1hdBS/JJznyb/faxV6dUhxAOrSjfW9HzrOFmlp3RPJ5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pxitTAYlT4aTP/HIST+A7fiKG52u+ZyWvKldQ+tSMQk=;
	b=GwsQ+plCIYC7dX/K85eDaWXXEZPh8jE2Yo2v96h5Ei8bp4kp1VfPAqEJZdcW+JODEmwL
	 +YxvnCMqkTu3gRn6vzhhoudBpOh5m148xAF7lhzz0CPngDiSCRdARM9YbYka/VFG63Fv7
	 f7hUcP3H6916DEQE4m+pMW2FKj02JqiyJ2v0ST90y4F7yiJVrBkA9KmOMQY3xeKWrX6nb
	 Yoq3RwRxijCUum8BrFQb0ZH4cNfXI2Ng+nBfgaSOf0MlnikRFukMfANdRP1zfv+hNdQ22
	 lGqd8zQquitllhM5bqe0IpEnXVz1Ao1Vf1gYINvGODZalMH0OVKH0OXhDKTPfnqiLkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sifive.com;
	spf=pass smtp.mailfrom=sifive.com;
	dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=VNAiZsgE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92C606D806
	for <iommu@lists.linux.dev>; Sat,  7 Nov 2026 14:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE92C606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=VNAiZsgE
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b56c428212so1694882a12.2
        for <iommu@lists.linux.dev>; Sat, 07 Nov 2026 06:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794062811; cv=none;
        d=google.com; s=arc-20260327;
        b=gH2iTjCr+Un9fLZ80WZ4EHBs0dMfyIpFT+GslIwJ2KJNlKH/kai/S7WDqIJPwt18bV
         VxSdADdWFNqkxcbISs3LA3Xj5tybFhzfZtq4b+ITFCxfuyRgWZ8/WFE7IunW0Ne9emvZ
         k4WmYCqY5jyQhFmH5arG8VF8yfG0yZFPZHlZcdTWdZwmmVjK9RCr7+AhN/UPOyTeB2kT
         DUhYjMIq9H48+sVTe64LPufvJWpg5ppcOKSa/P4ZZIiYNHcSeH1VqzD62awIGOmWMqF4
         iq4khHUs0oRTsguQUIcLSaQUTxSexrC6lxaRdjczu3mU23GcdJpmXH5EdTDoMhtuvhC1
         +RNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxitTAYlT4aTP/HIST+A7fiKG52u+ZyWvKldQ+tSMQk=;
        fh=LHqCH+QPbEOsTY8k6Oui6GF3nGWDBrqRVBXjrQZ+A48=;
        b=apHuYePTS6JRcF7i2IH01kltNA6w82TH2QFDVcH4/fmIWLSolc+meTlNNsNHIi0DAT
         2jTpNgaeI9w4/EgIa5fr5lNMNWDem1P6pihoiS9AnVyDg3P+rmxuXKeLPzyAKvX8+bcJ
         Go8v2z8oer/I5nOQWhg6fMRsWtwmlVoAL2HQNM2YPvLUrznisHTEtY/BGf0CSM7KjxaM
         PU7GhjmQbpNSr6hj6aksdOFDrsUpjagbBd2pBE+NjsDY/b8Re3pFTIukCERVWWKbGg8W
         f7WScrht8tzGTkSrR/MSx/Xpa+2wd9fgO0+wnpXgFWWshWPeId+tWr0FAWKYCT+EXBF0
         lBUQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1794062811; x=1794667611; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pxitTAYlT4aTP/HIST+A7fiKG52u+ZyWvKldQ+tSMQk=;
        b=VNAiZsgE9FtP4fSpkHyfSkySRA27CwHKqzRUkNFPx5KEKzZiWWozQZZIsVLO2L9lpS
         ndy7wQmxQAj804ppMPrwNRcwm7j/a4yCaB8GnS7l3JxzSzOs1MUE/TvOvlQfp2xPHd2/
         uIQGLmpP7/M/iAhit5T9Br0tkwvkLe4k95s79rWrH5lt3abb8kIhY8CcFATThvTOBIMw
         NGRyiwSUlix5vempNt52e7CaBDNfZMdxrLD2IZ2HQIfsOMGRscJjoJYxFtqhTjVLe4aU
         6PZaiyaHb7oUP8hMy+1Az0PsHQV7iHqY6TIvTqGct2HKqnWcIR6QuLu07vELaEaqTqAd
         zg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062811; x=1794667611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pxitTAYlT4aTP/HIST+A7fiKG52u+ZyWvKldQ+tSMQk=;
        b=OcGu0ZfUXtwf1iJOZFsOAMau2WD4vX+YohX5s/at4BePWpY8NOwH0qeqrIsa0dE9M6
         9mx3A3a3E+HrFf5w7jmUluQugJphNL92rVr9MqKwzK386zcdV7+9LMY8caDBl2l10Pkg
         PXhBpp2GLQiGCaZDtN+9DMVPGatFpajJFRkna0si9i+RqbQ6BT1IW2KBONE+I9nDgS0I
         opoHqbsuJAl8EsDav1Fpeog7Z3KggRTPZQ7UaCJLI0NC0EXf11TxckqW3+w4Ael6qXFk
         IB3MKqTWW/nwfY4/p7j7Owuq1HLYp79bKntX5vxPKZ321MT/LXGkt+r+Df8ylj22CJoD
         oxNQ==
X-Forwarded-Encrypted: i=1; AL+hErF0kD3U5K5hI3eZpQBC4roCb0vDU17OqkoNfAoX8/Kx6sNnIhOzpLxKVvE3ExZMaUzrTKDM4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8LsQJfDqGa6Httv2MdjxtJL1sK5AQYPLxwakA3apklRcmCOdF3
	jOd8uk60qxmwEPbIdFiNjX+9SUpCnZv9Fk5lJbXWDKmaU/VLi2L0W2IYEVW6pWpLVeZtqIdtaBA
	pP/ybFMfCuMnt1LtKSRGp5BzizSDiKsUEFE/zv6/Ovg==
X-Gm-Gg: AYBFou326ggSvnXWtJQSd2B8X1aTCjR2dk7n4rIN12Oy1xGxR6eYCnNAAjfWnmwiuT4
	YCTUBHEP1RUkp+h4ul6z3c8PyZkHrpOFAb/5XvXobJOjd+998S4qi1hqYuLyKHco7J9taJWWSyS
	UrOjB1fYw7xdCFiQA4HDroTjdfImJhLbTpZHgee8m9VTWluDOKKwekcKOVmaRFvTexvOyDLqqAh
	tXxtENNdHzWvItOGHQ0Fw2hoIBJR+47DnxykXAJW/9t6qc9XBIkrv5LJJj72nV/kQ+JqnzgmvX3
	ThLEx1h6d5w3IJyK+ITZQO9nEopsm52LmX1L2Mv9hidSwlw7mshI4SC33eVkCF7FdUNT/S3+upr
	IQPyOkZBpY2F9KiRyJUi8P/QoGyzGQoyYuv6SrfU=
X-Received: by 2002:a05:6402:d05:b0:6b5:9156:4e9b with SMTP id
 4fb4d7f45d1cf-6b5977a301emr3803850a12.8.1794062811145; Sat, 07 Nov 2026
 06:46:51 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261006090327.309550-1-zong.li@sifive.com> <CANXhq0qPxywpTmw=mAspYgfXivAyyoBN-r8iPpwYVXmJ3AmXyQ@mail.gmail.com>
 <7f7a6f3a-de8b-4ca2-8fc7-ea7586cbb270@picoheart.com>
In-Reply-To: <7f7a6f3a-de8b-4ca2-8fc7-ea7586cbb270@picoheart.com>
From: Zong Li <zong.li@sifive.com>
Date: Sat, 7 Nov 2026 22:46:37 +0800
X-Gm-Features: AclHuK8qfSlihFNyI0xS7KkPURkTjEgxqr80EjCjuJaTqfla2V-ZszF9QGRBUYA
Message-ID: <CANXhq0oMmqeDkMLu1L7+vBGXQ+_N2ANfBV9EbbQ+19BGiBR8OA@mail.gmail.com>
Subject: Re: [PATCH v16 0/2] RISC-V IOMMU HPM support
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, 
	nutty.liu@hotmail.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 8:37=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.c=
om> wrote:
>
> On 10/7/26 3:30 PM, Zong Li wrote:
> > On Tue, Oct 6, 2026 at 5:03=E2=80=AFPM Zong Li <zong.li@sifive.com> wro=
te:
> >>
> >> This series implements support for the RISC-V IOMMU hardware performan=
ce
> >> monitor.
> >>
> >> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driv=
er
> >> created by the parent RISC-V IOMMU driver. Therefore, the child driver
> >> can obtain resources and information from the parent device, such as
> >> the MMIO base address and IRQ number.
> >>
> >> It seems sashiko-bot is giving conflicting advice about whether to add
> >> a lock to ->read(). No matter if we add it or not, the sashiko-bot alw=
ays
> >> suggests the opposite. Looking at no lock case again, sashiko-bot
> >> concerns about a BPF program calling bpf_perf_event_read() from NMI
> >> context and self-deadlocking against the IRQ handler, but that scenari=
o
> >> cannot occur here:
> >>
> >>   - bpf_perf_event_read() goes through perf_event_read_local(), which
> >>     refuses to call ->read() unless event_cpu =3D=3D smp_processor_id(=
)
> >>     (kernel/events/core.c). All events on this PMU are CPU-bound and
> >>     non-task-bound (->event_init() forces event->cpu =3D pmu->on_cpu a=
nd
> >>     rejects sampling events), so PERF_ATTACH_TASK is never set.
> >>   - More fundamentally, perf overflow interrupts are not NMIs on RISC-=
V,
> >>     and every pmu->lock critical section in this driver is held under
> >>     raw_spin_lock_irqsave(). There is no context that can interrupt th=
em
> >>     and re-enter ->read().
> >>
> >> No other driver under drivers/perf/ uses a trylock or in_nmi() check i=
n
> >> its ->read() callback, so dropping it also brings this driver in line
> >> with the rest.
> >>
> >> sashiko-bot also reported that migration calling trigger a NULL pointe=
r
> >> dereference. I don't think this can happen on current mainline.
> >> perf_pmu_migrate_context() does not touch pmu->cpu_pmu_context unless =
it
> >> actually finds events to migrate. This used to be a real hazard: befor=
e
> >> commit bd2756811766 ("perf: Rewrite core context handling", v6.2-rc1)
> >> the first two lines were per_cpu_ptr(pmu->pmu_cpu_context, ...), which
> >> did dereference a pmu-owned pointer unconditionally. That is also why
> >> several in-tree drivers pre-seed thier ->cpu field with a real CPU num=
ber
> >> rather than a sentinel, and so do call perf_pmu_migrate_context() in
> >> this window, without any reported oops.
> >>
>
> [...]
>
> >
> > Hi all
> >
> > In the v16, sashiko-bot suggested to add a pmu->lock in ->read()
> > again, let me address this, and explain why I would prefer to leave it
> > as a documented limitation in this series rather than respin.
> >
> > What I would like to push back on is the suggested fix, because every
> > point fix in this area has already been reviewed and rejected in an
> > earlier round of this series:
> >
> >   - Taking pmu->lock in ->read() (which is literally the diff
> > suggested here) was in v7-resend. It was rejected: a BPF program
> > reading an IOMMU PMU event from NMI context via bpf_perf_event_read()
> > invokes pmu->read(), and if that NMI lands on a CPU already holding
> > pmu->lock in the IRQ handler or in ->add(), the read callback spins
> > forever.
> >   - raw_spin_trylock_irqsave() in ->read() was the v13 answer to that.
> > It was rejected in v14: on cross-CPU contention the trylock fails,
> > ->read() returns without updating, and userspace silently gets a stale
> > count.
> >   - The current lockless form is what v15 and v16 are objecting to.
> >
> > So the three obvious shapes for ->read() have each been rejected, in
> > each case for a valid reason. That is a strong hint that ->read() is
> > the wrong place to fix this: the actual root cause is that the
> > overflow handler may run off the bound CPU at all.
> >
> > Worth noting that no PMU driver under drivers/perf/ (including all the
> > hisilicon ones) or arch/x86/events/intel/uncore.c takes a spinlock in
> > its ->read() callback -- not even on x86, which does have NMI-context
> > perf events. They don't need to, because they pin the overflow
> > interrupt to on_cpu with irq_set_affinity(), so the handler and the
> > perf callbacks all run on the same CPU, and ->read() is already
> > invoked there with interrupts disabled (smp_call_function_single()
> > from perf_event_read(), or the event_cpu =3D=3D smp_processor_id() chec=
k
> > in perf_event_read_local()). Same-CPU plus interrupts-disabled is the
> > entire synchronisation mechanism, and it is why the
> > prev_count/hardware pair cannot be observed half-updated.
>
> that's how the event core's synchronization is designed and expect the
> PMU drivers to follow. so the race is true if pmu::read() is not protecte=
d
> in the current implementation.
> >
> > RISC-V IOMMU PMU driver does the same irq_set_affinity() call, but on
> > IMSIC the move can be deferred, so the guarantee is weaker. Hence the
> > race. On the scope of the impact, to explain why I think this can
> > wait:
> >   - The consequence is confined to a reported count. prev_count and
> > event->count are local64_t and the cmpxchg cannot tear, so there is no
> > memory-safety issue, no oops, and no effect on IOMMU operation itself.
> >   - The window requires an affinity change to be in flight.
> > riscv_iommu_pmu_bind_cpu() is only called from the CPU hotplug online
> > and offline callbacks, so a deferred move is only pending during CPU
> > hotplug. In steady state the interrupt is already on on_cpu, ->read()
> > runs on that same CPU with interrupts disabled, and the window does
> > not exist. This is a transient during hotplug, not the common case.
>
> so the problematic part is that the counter update from the overflow
> interrupt is not guaranteed to run on the event->cpu for the first
> even if the affinity is set to event->cpu, due to IMSIC's affinity
> move deferral. this should only affect IOMMU implemented as PCIe
> device, not platform device with either wired interrupt or MSI.
>
> what was the problem of using irq work to queue the counter update
> on the event->cpu? I see it was removed in v10 due to IRQCHIP_MOVE_DEFERR=
ED
> which confused me. with irq work we can ensure the counter update
> on event->cpu no matter which cpu take the interrupt. was there
> other issues with the irq work?

Yes, as I mentioned at the end of the cover letter, I might prefer to
send a separate patch to address this issue. In that new patch, I am
trying to use irq_work to solve it. The main difference from the
irq_work implementation in v9 is that the previous approach was too
simplistic. The new patch will take more scenarios and corner cases
into consideration and address them properly.

>
> thanks.
>
> >
> > That is a structural change to the interrupt path with several
> > interacting constraints, each of which has already caused a regression
> > in this series once. I would rather not fold it into this series at
> > this point, both because it deserves review on its own and because
> > getting it wrong again in a hurry is worse than a documented
> > counter-accuracy limitation during hotplug. So my proposal is: leave
> > the code as-is for this series, add a comment on
> > riscv_iommu_pmu_read() recording the limitation and why the three
> > obvious fixes are not used, and address it in a follow-up patchset.
> >
> > Please let me know if you want me to do more for this series.
> > Thanks!
> >
> >> Zong Li (2):
> >>   drivers/perf: riscv-iommu: add risc-v iommu pmu driver
> >>   iommu/riscv: create a auxiliary device for HPM
> >>
> >>  drivers/iommu/riscv/Kconfig      |    1 +
> >>  drivers/iommu/riscv/iommu-bits.h |   61 --
> >>  drivers/iommu/riscv/iommu.c      |   58 ++
> >>  drivers/iommu/riscv/iommu.h      |    4 +
> >>  drivers/perf/Kconfig             |   12 +
> >>  drivers/perf/Makefile            |    1 +
> >>  drivers/perf/riscv_iommu_pmu.c   | 1102 +++++++++++++++++++++++++++++=
+
> >>  7 files changed, 1178 insertions(+), 61 deletions(-)
> >>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> >>
> >> --
> >> 2.43.7
> >>
