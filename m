Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF73815F9
	for <iommu@lists.linux.dev>; Tue,  6 Oct 2026 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791277416; cv=none; b=OvXU9/CSrv1kwBYU5FMmWQOG0VOhjbNwrBZTZCSu+5wGA4BRFVjElYISQVO/NRY0PCbdnDRMjQppzavhgxVp0RtwYrOXzzuA352Pbw5cr46gXGikNeWfoURBs/vUShFJ3CIse1ZTbnABC+lgN7QXoJ6Rka2nm/rZzlY73ligoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791277416; c=relaxed/simple;
	bh=e+QKcLiLR9aQM1GsNc5nTTQt3/CAZ42yLj3LSmwDoJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1Qg2tdNJVzal7hnYVdIug7Hw+HJsed/rxCRWFZmErvEbydlMKpn5oclaEgt5IHh+80sYmA0IZzZzx6hcqvqJVRfXe3jYtBAIq01d2bwqya9ec2ixeUfRwUpwbL+vzFFOZ9apOyKVUILEK6VxoW9DZ2pt4KWDCEm65FjVdNZqg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GitJNBXg; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GitJNBXg"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-154e9d2d979so1046022c88.1
        for <iommu@lists.linux.dev>; Tue, 06 Oct 2026 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1791277412; x=1791882212; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9sHs8q4lscucI4vPZxD+59Nx1PieeXin2JvWxO3G7Kw=;
        b=GitJNBXgxw9NARckis5O1ithheBU6KNzwhOZ8xt/7sw5DpqLQ04+SpLzZ5pX/mmAHC
         JpBholPuxkIEgcE1FErhzJtWm0eTa1LxhL9iXZiLq9mcnv15BWnb79GPUBBkNVvpT1AH
         Jzui1PxHni74ZHC8FbV+MrI/aeiek22Ullab46FkwL7BWdQNYVsJjpxQ9R4QrQssr2hL
         Pz+Ayd/x1Q+W28FWaQebCgN2A4jVkqwyPjshVc68p3BfCH4LJRu4R0qONejJRdmWIPUX
         fpGQRq2xWusGw+rEIQ3v7xGALKfYVHz04V7dUcFO5XeDuNrh3sz3wQTbLqKFuhPBpzYM
         znPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791277412; x=1791882212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9sHs8q4lscucI4vPZxD+59Nx1PieeXin2JvWxO3G7Kw=;
        b=IebT+KlztkkBE68wBdejN7seTaUswgm+rfRzO0YlvwIdWOJJcWsP7fuu6BR4pCs7WU
         pzZx+qsC+fqWYfUvuccSxmw/PpF6nDEBYKdNk1Qf+SpWYU14z48ifqS9Iz/17Iuz2XAH
         dXeY1c0ccpiiT+2pV03toObxIFgAvivXF7jGDXp6mb4zVokAHvZco7Te49FbANYAtTFy
         lwfopF0EgnZeW+EWFzXMF/QAD2mKs44f3yLy5hmq6EkFdRwxAjfseKA8weYSvopk3Kvs
         /gFCTgnpNQwQ4gQAUhjEiSVszehuHH5QXvMtUntCTw50zHUo5erbPaimUuVVFxU0u0O7
         +WfQ==
X-Forwarded-Encrypted: i=1; AKwUvBzC5UCo2yuTTpWKp62cgtj67ZiV7vTnKgyWoV0gj+hy+b3/Hz73FKesTbi+WKloasccadV/Gw==@lists.linux.dev
X-Gm-Message-State: AFuF++n+KUcv9Uq5guUAaMVE37MP742o2HfAtSm/4bdg2QW77AkNlsOc
	g8C4rh2TERz3NMXPzuyagAgssGj8J9kYJVXHOpp9z7mzOWcbL//ZIB7jlk31MoB8fv8=
X-Gm-Gg: AYBFou12yDXCHjqSXuyEOAcTssnRDJwHJTBmoj5urjbbgP30RyNoj8Y9mFA59kx3CrD
	qMje8U6XkYLRT3b+tVN/3XuxutIIZ+laJmGuELvVkgMLzWjpT7vQU4HqdZEaioI3ahhWiJEIfjn
	CEtvsjpjWJ0VbK+DPHOSwyFmnIMFv2rHIc11/7kz82WKFPg0kOqt3aCYxqDz7TehDqqI4vDhOLq
	5WsyOHTxzIqOGq2FEDI3Sly7SD5UpzuR8m3LHH6lCSSn6p7wHhM/MiHz75KzwXl8uVDRTCB/QBd
	hh/jV7ZdrVUZuGOBHZf8LiKTSoS5iVXsHG1aiM3SvQ/CSFKnichrBufAVyY5Op83LlVtifVtUnm
	2EXOEug3jKap8ZxmRTL9urlzs4TEJKtamwKHwVywycbs+sXd2Q3+Z45lhqt7tL4eKFVd5KQffvB
	q2Nm8QBTmj7qZ3gAHspm/QnzgkdDOpSAvTkxkqDLLScrXC6w3Bx3VtwIMLeZZlwQwPrvmtLumxp
	EoByZPAabw=
X-Received: by 2002:a05:7022:4086:b0:151:7831:e403 with SMTP id a92af1059eb24-15ec7727b08mr1026954c88.13.1791277412387;
        Tue, 06 Oct 2026 02:03:32 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-15d82d04c31sm5891353c88.7.2026.10.06.02.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 02:03:31 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	andrew.jones@oss.qualcomm.com,
	guoren@kernel.org,
	david.laight.linux@gmail.com,
	zhangzhanpeng.jasper@bytedance.com,
	yang.yicong@picoheart.com,
	nutty.liu@hotmail.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v16 0/2] RISC-V IOMMU HPM support
Date: Tue,  6 Oct 2026 02:03:23 -0700
Message-ID: <20261006090327.309550-1-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements support for the RISC-V IOMMU hardware performance
monitor.

The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
created by the parent RISC-V IOMMU driver. Therefore, the child driver
can obtain resources and information from the parent device, such as
the MMIO base address and IRQ number.

It seems sashiko-bot is giving conflicting advice about whether to add
a lock to ->read(). No matter if we add it or not, the sashiko-bot always
suggests the opposite. Looking at no lock case again, sashiko-bot
concerns about a BPF program calling bpf_perf_event_read() from NMI
context and self-deadlocking against the IRQ handler, but that scenario
cannot occur here:

  - bpf_perf_event_read() goes through perf_event_read_local(), which
    refuses to call ->read() unless event_cpu == smp_processor_id()
    (kernel/events/core.c). All events on this PMU are CPU-bound and
    non-task-bound (->event_init() forces event->cpu = pmu->on_cpu and
    rejects sampling events), so PERF_ATTACH_TASK is never set.
  - More fundamentally, perf overflow interrupts are not NMIs on RISC-V,
    and every pmu->lock critical section in this driver is held under
    raw_spin_lock_irqsave(). There is no context that can interrupt them
    and re-enter ->read().

No other driver under drivers/perf/ uses a trylock or in_nmi() check in
its ->read() callback, so dropping it also brings this driver in line
with the rest.

sashiko-bot also reported that migration calling trigger a NULL pointer
dereference. I don't think this can happen on current mainline.
perf_pmu_migrate_context() does not touch pmu->cpu_pmu_context unless it
actually finds events to migrate. This used to be a real hazard: before
commit bd2756811766 ("perf: Rewrite core context handling", v6.2-rc1)
the first two lines were per_cpu_ptr(pmu->pmu_cpu_context, ...), which
did dereference a pmu-owned pointer unconditionally. That is also why
several in-tree drivers pre-seed thier ->cpu field with a real CPU number
rather than a sentinel, and so do call perf_pmu_migrate_context() in
this window, without any reported oops.

Changed in v15:
- Rebasd onto v7.3-rc6
- Use devm_add_action() instead of devm_add_action_or_reset() for pmu
  unregister. Reported by sashiko-bot
- Move local64_set() before riscv_iommu_pmu_set_counter() in
  set_period(). Reported by sashiko-bot

Changed in v14:
- Rebased onto v7.3-rc5
- Support sparse counters and the different width of each counter
- Accecpt custom event ranges
- Verify IDT supported in event
- Add warning message if riscv_iommu_hpm_enable is failure
- Remove raw_spin_lock for ->read() flow

Changed in v13:
- Reorder the registration of cpuhp action

Changed in v12:
- Rebased onto v7.3-rc4
- Add raw_spin_trylock_irqsave for ->read() flow

Changed in v11:
- Rebased onto v7.3-rc3
- Add riscv_iommu_hpm_disaable to destroy aux dev before MSI is freed
- Fix CPU hotplug race risks reported by sashiko-bot as follows
- Re-validate pre_count after reading hw counter
- Move hwc-state into atomic critical section (pmu->lock)

Changed in v10:
- Optimize hi-lo-hi by do while for hypervisor case
- Add raw spinlock for cpu hotplug race and IRQCHIP_MOVE_DEFERRED
- Remove irq work mechanism for IRQCHIP_MOVE_DEFERRED

Changed in v9:
- Clear PMIP in irq handler on wrong CPU for re-triggering IRQ
- Add a lock in offline_cpu to avoid cpu hotplug race condition

Changed in v8:
- Rebased onto v7.3-rc2
- Add irq work mechanism for IRQCHIP_MOVE_DEFERRED case
- Filter multiple cycle event case

Changed in v7:
- Rebased onto the v7.3-rc1
- Remove raw spinlock
- Check CPU matching at the beginning of irq handler
- Add PERF_HES_STOPPED check before overflow handling

Changed in v6:
- Rebased onto the latest v7.3-rc
- Use sysfs_emit instead of cpumap_print_to_pagebuf
- Set up on_cpu and irq affinity by cpuhp callbacks
- Change type of on_cpu from unsigned int to int
- Reject filter operands of cycle event in event_init
- Check return value of counter number and  masks in probe
- Add raw spinlock for race condition (third commit)

Changed in v5:
- Pick up suggestions from sashiko-bot as follows
- Fix event group validation for sw event
- Bind IRQ to aux PMU dev instead of parent IOMMU dev
- Clear OF bit when event is NULL
- Improve hi-lo-hi patten
- Add back IRQF_SHARED flag due to mismatch
- Manage cpuhp and pmu register by devre

Changed in v4:
- Rebased onto v7.3-rc
- Use is_sampling_event() instead of accessing vairable directly
- Rename the matching name from "iommu.pmu" to "riscv-iommu.pmu"
- Change the naming of PMU device for avoid ":" in PCIe case
- Add suppress_bind_attrs attribute
- Remove IRQF_SHARED flag
- Set irq affinity to local CPU of IOMMU
- Allocate ID by IDA for auxiliary device
- Pick up suggestions from sashiko-bot

Changed in v3:
- Rebased onto v7.2-rc3
- Use hi_lo_writeq/readq to access register
- Pick comments from sashiko-bot as follows
- Set IRQ CPU affinity
- Remove IRQF_ONESHOT flag when request irq
- Adjust cycle event check by checking event_id field only
- Fix bug for group events verificaiton
- Fix KASAN issue about casting 32-bit variable to unsigned long pointer
- Clear IPSR pending bit before starting counter
- Clear OF bit in event selector register in irq handler
- Release irq by devm instead of explicit free_irq

Changed in v2:
- Rebased onto v7.2-rc1
- Use hi-lo-hi mechanism to read counter.
  Suggested by Guo Ren and David Laight

Changed in v1:
- Rebased onto v6.19-rc8
- Pick all suggestions and feedbacks from v1 series
- Add cpu hotplug implementation to avoid race enablement
- Move PMU-related definition from header to c file
- Change PMU driver to auxiliary device driver

Changed in RFC:
- Rebase onto v6.13-rc7
- Clear interrupt pending before handling interrupt
- Fix the counter value issue caused by OF bit in the cycle counter.
- Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
  in riscv_iommu_remove()

Zong Li (2):
  drivers/perf: riscv-iommu: add risc-v iommu pmu driver
  iommu/riscv: create a auxiliary device for HPM

 drivers/iommu/riscv/Kconfig      |    1 +
 drivers/iommu/riscv/iommu-bits.h |   61 --
 drivers/iommu/riscv/iommu.c      |   58 ++
 drivers/iommu/riscv/iommu.h      |    4 +
 drivers/perf/Kconfig             |   12 +
 drivers/perf/Makefile            |    1 +
 drivers/perf/riscv_iommu_pmu.c   | 1102 ++++++++++++++++++++++++++++++
 7 files changed, 1178 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

