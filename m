Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794055024;
	b=RvJnMTFyR8LEzYEK0TQNkcDXk9IX8u8P6kOZ6Mlr6cmWyhpD9szNN7F0b+t9JKGT5RYE
	 pvMMSaWPG/OF6bH5vBHG6YxmLkxJL+MemOX7VNLYPB0SF+1jb4bvYEjD9sKoNeuja5otZ
	 m/nVX/H8znL4TZaImxonaAFBQLW8PB8QCD/oiTzWwJEq1pU3idelNLUQOuebhThAocuQM
	 4jbKaZeJxG4+Asy2rkN/uDakDKAYA6qCfePZ7Ebtba4uGGy6zti2kURHLYuoclmzgjMRy
	 njkXCXEoxlidHZdLNWs0gF+paEC3bU4jgqo7oV1yR6Z4eT1ZooGAvlKYAs6uawWqfqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055024;
	h=DMARC-Filter:DKIM-Signature:Received:X-Original-From:References:To:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Lms-Return-Path:
	 From:User-Agent:Content-Language:Message-Id:In-Reply-To:Cc:Subject:
	 Date;
	bh=sQy3bhcu2VAVvwJsFj+jecqFvhu2MsAOUpqilRVw/hI=;
	b=iqmKc+HdS4n/1Ha4y8XgQXpPXqNAWpgO8KSVAkhaP19UmTIArzq6LDzM/WGBm2V/ve8D
	 eMvRYYTTCGfhxkrtrvbXnjF4hi68oJctVonrIrtF05H9Qo8fZhMurkc6cDINzroEEJuwj
	 EYeUIdpv7lOWnPxK2gyi/JZQ/2VTnNmAGfUCUuh6id34mX88zvmQBrZL/IvjpjceA/3xf
	 NrH9PpBrc/QKCi/VCxhuHPVBSpQ2oqU3g4/wmdy4gdwmaOhrghpPtdBaKCEXt77tm29Dc
	 xZxjcDrmuugDYTgijo9WPqtYs817lUGiqJFseMjz8JbwHn2Gl+m4abvJNZb3+ELEdmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=picoheart.com;
	spf=pass smtp.mailfrom=picoheart.com;
	dkim=pass header.d=picoheart.com header.i=@picoheart.com header.a=rsa-sha256 header.s=feishu2604151535 header.b=iuBkxLA9;
	arc=none smtp.remote-ip=209.127.231.53
Received: from va-2-53.ptr.blmpb.com (va-2-53.ptr.blmpb.com [209.127.231.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D73606A32D
	for <iommu@lists.linux.dev>; Sat,  7 Nov 2026 12:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D73606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.a=rsa-sha256 header.s=feishu2604151535 header.b=iuBkxLA9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1794055018; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sQy3bhcu2VAVvwJsFj+jecqFvhu2MsAOUpqilRVw/hI=;
 b=iuBkxLA937Blp6eHXcX7ebzh/dhzrmoacIr4msgRjrdPsHTEqbPk15+r2MQnNN4ytnNaCb
 JZCPQCJrCqenfTz4tMukD73KlBk1bJMCh1EMUSudIwLBTP7/V/Troo7Zs4hqTHynj46omE
 v1IrzupcB0foKvtyEA2+dMMN5xetNnIYcaHwk7d0wMyNtNcGYQOsBjaicduHOHAc8ZdOOC
 3bGFWYeHq0LxSuf1TiGPY1NOkVJ7lIGO+5wyupEjw5YgTtFEs2aovzwoScHHjjjzTCHW/A
 dXBl4x+Svw52qJdaE+S1vzR0PMMToqOXvfI9/BLMiDpX4UllPLddJuc0luKzsA==
Received: from [100.86.223.207] ([61.141.241.116]) by smtp.feishu.cn with ESMTPS; Sat, 07 Nov 2026 20:36:55 +0800
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
References: <20261006090327.309550-1-zong.li@sifive.com> <CANXhq0qPxywpTmw=mAspYgfXivAyyoBN-r8iPpwYVXmJ3AmXyQ@mail.gmail.com>
To: "Zong Li" <zong.li@sifive.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26aef1b68+52f3fa+lists.linux.dev+yang.yicong@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Message-Id: <7f7a6f3a-de8b-4ca2-8fc7-ea7586cbb270@picoheart.com>
In-Reply-To: <CANXhq0qPxywpTmw=mAspYgfXivAyyoBN-r8iPpwYVXmJ3AmXyQ@mail.gmail.com>
Cc: <tomasz.jeznach@linux.dev>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <pjw@kernel.org>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <mark.rutland@arm.com>, 
	<andrew.jones@oss.qualcomm.com>, <guoren@kernel.org>, 
	<david.laight.linux@gmail.com>, <zhangzhanpeng.jasper@bytedance.com>, 
	<nutty.liu@hotmail.com>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<linux-perf-users@vger.kernel.org>, <yang.yicong@picoheart.com>
Subject: Re: [PATCH v16 0/2] RISC-V IOMMU HPM support
Date: Sat, 7 Nov 2026 20:36:52 +0800

On 10/7/26 3:30 PM, Zong Li wrote:
> On Tue, Oct 6, 2026 at 5:03=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote=
:
>>
>> This series implements support for the RISC-V IOMMU hardware performance
>> monitor.
>>
>> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
>> created by the parent RISC-V IOMMU driver. Therefore, the child driver
>> can obtain resources and information from the parent device, such as
>> the MMIO base address and IRQ number.
>>
>> It seems sashiko-bot is giving conflicting advice about whether to add
>> a lock to ->read(). No matter if we add it or not, the sashiko-bot alway=
s
>> suggests the opposite. Looking at no lock case again, sashiko-bot
>> concerns about a BPF program calling bpf_perf_event_read() from NMI
>> context and self-deadlocking against the IRQ handler, but that scenario
>> cannot occur here:
>>
>>   - bpf_perf_event_read() goes through perf_event_read_local(), which
>>     refuses to call ->read() unless event_cpu =3D=3D smp_processor_id()
>>     (kernel/events/core.c). All events on this PMU are CPU-bound and
>>     non-task-bound (->event_init() forces event->cpu =3D pmu->on_cpu and
>>     rejects sampling events), so PERF_ATTACH_TASK is never set.
>>   - More fundamentally, perf overflow interrupts are not NMIs on RISC-V,
>>     and every pmu->lock critical section in this driver is held under
>>     raw_spin_lock_irqsave(). There is no context that can interrupt them
>>     and re-enter ->read().
>>
>> No other driver under drivers/perf/ uses a trylock or in_nmi() check in
>> its ->read() callback, so dropping it also brings this driver in line
>> with the rest.
>>
>> sashiko-bot also reported that migration calling trigger a NULL pointer
>> dereference. I don't think this can happen on current mainline.
>> perf_pmu_migrate_context() does not touch pmu->cpu_pmu_context unless it
>> actually finds events to migrate. This used to be a real hazard: before
>> commit bd2756811766 ("perf: Rewrite core context handling", v6.2-rc1)
>> the first two lines were per_cpu_ptr(pmu->pmu_cpu_context, ...), which
>> did dereference a pmu-owned pointer unconditionally. That is also why
>> several in-tree drivers pre-seed thier ->cpu field with a real CPU numbe=
r
>> rather than a sentinel, and so do call perf_pmu_migrate_context() in
>> this window, without any reported oops.
>>

[...]

>=20
> Hi all
>=20
> In the v16, sashiko-bot suggested to add a pmu->lock in ->read()
> again, let me address this, and explain why I would prefer to leave it
> as a documented limitation in this series rather than respin.
>=20
> What I would like to push back on is the suggested fix, because every
> point fix in this area has already been reviewed and rejected in an
> earlier round of this series:
>=20
>   - Taking pmu->lock in ->read() (which is literally the diff
> suggested here) was in v7-resend. It was rejected: a BPF program
> reading an IOMMU PMU event from NMI context via bpf_perf_event_read()
> invokes pmu->read(), and if that NMI lands on a CPU already holding
> pmu->lock in the IRQ handler or in ->add(), the read callback spins
> forever.
>   - raw_spin_trylock_irqsave() in ->read() was the v13 answer to that.
> It was rejected in v14: on cross-CPU contention the trylock fails,
> ->read() returns without updating, and userspace silently gets a stale
> count.
>   - The current lockless form is what v15 and v16 are objecting to.
>=20
> So the three obvious shapes for ->read() have each been rejected, in
> each case for a valid reason. That is a strong hint that ->read() is
> the wrong place to fix this: the actual root cause is that the
> overflow handler may run off the bound CPU at all.
>=20
> Worth noting that no PMU driver under drivers/perf/ (including all the
> hisilicon ones) or arch/x86/events/intel/uncore.c takes a spinlock in
> its ->read() callback -- not even on x86, which does have NMI-context
> perf events. They don't need to, because they pin the overflow
> interrupt to on_cpu with irq_set_affinity(), so the handler and the
> perf callbacks all run on the same CPU, and ->read() is already
> invoked there with interrupts disabled (smp_call_function_single()
> from perf_event_read(), or the event_cpu =3D=3D smp_processor_id() check
> in perf_event_read_local()). Same-CPU plus interrupts-disabled is the
> entire synchronisation mechanism, and it is why the
> prev_count/hardware pair cannot be observed half-updated.

that's how the event core's synchronization is designed and expect the
PMU drivers to follow. so the race is true if pmu::read() is not protected
in the current implementation.
>=20
> RISC-V IOMMU PMU driver does the same irq_set_affinity() call, but on
> IMSIC the move can be deferred, so the guarantee is weaker. Hence the
> race. On the scope of the impact, to explain why I think this can
> wait:
>   - The consequence is confined to a reported count. prev_count and
> event->count are local64_t and the cmpxchg cannot tear, so there is no
> memory-safety issue, no oops, and no effect on IOMMU operation itself.
>   - The window requires an affinity change to be in flight.
> riscv_iommu_pmu_bind_cpu() is only called from the CPU hotplug online
> and offline callbacks, so a deferred move is only pending during CPU
> hotplug. In steady state the interrupt is already on on_cpu, ->read()
> runs on that same CPU with interrupts disabled, and the window does
> not exist. This is a transient during hotplug, not the common case.

so the problematic part is that the counter update from the overflow
interrupt is not guaranteed to run on the event->cpu for the first
even if the affinity is set to event->cpu, due to IMSIC's affinity
move deferral. this should only affect IOMMU implemented as PCIe
device, not platform device with either wired interrupt or MSI.

what was the problem of using irq work to queue the counter update
on the event->cpu? I see it was removed in v10 due to IRQCHIP_MOVE_DEFERRED
which confused me. with irq work we can ensure the counter update
on event->cpu no matter which cpu take the interrupt. was there
other issues with the irq work?

thanks.

>=20
> That is a structural change to the interrupt path with several
> interacting constraints, each of which has already caused a regression
> in this series once. I would rather not fold it into this series at
> this point, both because it deserves review on its own and because
> getting it wrong again in a hurry is worse than a documented
> counter-accuracy limitation during hotplug. So my proposal is: leave
> the code as-is for this series, add a comment on
> riscv_iommu_pmu_read() recording the limitation and why the three
> obvious fixes are not used, and address it in a follow-up patchset.
>=20
> Please let me know if you want me to do more for this series.
> Thanks!
>=20
>> Zong Li (2):
>>   drivers/perf: riscv-iommu: add risc-v iommu pmu driver
>>   iommu/riscv: create a auxiliary device for HPM
>>
>>  drivers/iommu/riscv/Kconfig      |    1 +
>>  drivers/iommu/riscv/iommu-bits.h |   61 --
>>  drivers/iommu/riscv/iommu.c      |   58 ++
>>  drivers/iommu/riscv/iommu.h      |    4 +
>>  drivers/perf/Kconfig             |   12 +
>>  drivers/perf/Makefile            |    1 +
>>  drivers/perf/riscv_iommu_pmu.c   | 1102 ++++++++++++++++++++++++++++++
>>  7 files changed, 1178 insertions(+), 61 deletions(-)
>>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
>>
>> --
>> 2.43.7
>>
