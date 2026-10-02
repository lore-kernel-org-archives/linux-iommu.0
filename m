Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948E3EA97E
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790922801; cv=none; b=aa5nYFbbpevDX5VE9MZtAdp5VdtZ5YLRk5je3Aps11T4saGMzxGDwp6cv9aKe1o7mrpRUczsvgAab04J9KJqijttkKlcavXNgeyRWZQTHCRAZgxPgkut42fltYLuAirZz9V7U5mc2OtKVNAXSE689HkG8vi6HE0z9s9vkSMQxJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790922801; c=relaxed/simple;
	bh=FCZ6sIAIFfPswMpdAnsl3++lstKHkX6vjPLQMQ5mWXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MN9H2Re2DimehmSUnk3fxiV4w/HiDeJq7vZfPDcMWzLnZwpsyi51HwPopHOo32ROM1hx9rWDt+Qh4CkKBEAH0D9zaUFH75uCfjsmrKx5GtZjMkVeNFY0+/Iz2WSzHN2/ILEsGoLNNGU3MfBy94m2V7tM1+7/l3z/kgdZYSu4LBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=QukcalLT; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QukcalLT"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-144f79153f5so296162c88.0
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 23:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790922798; x=1791527598; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d7cgR6ZneSf8y5V7zAIslHSi/tYxEvm4mPs702VSwro=;
        b=QukcalLTMklefI/TFP6023y0a+9ynPK8iRSODSpXfHPrNBzP4eZEp6Vq0U/AHWTcdW
         SapcuvraW+sleujU0xq2JnO9WLvBpfblW6wdg8kJPF4bQD/hW9TFL/9GpgmXSWCCm7X6
         U62RP6MOBUCYRfyihHIXln/KNmzV0+bSNjko6RFAPu4FYNbO22KX9EEl+n10guFeHVmO
         TdweNGyQYFPXm61zF+LNu7nvWpFO6tjRZ7LJY/byc98OHCabaYGNrz92ji2FwXMA3ejZ
         4D2r92mYMbfAOUGSMA8GVoNuxBap0FBzht9DbNc79vbj1IMS6JAwOt2bWqzx2b4Kozqu
         kspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790922798; x=1791527598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d7cgR6ZneSf8y5V7zAIslHSi/tYxEvm4mPs702VSwro=;
        b=c3e1RWsPIfFR+oR4Cj1nP4iB+cyyXbo0CWOWvye9386sZA4Z9X3Q279gdt0s0F4gHM
         zbC1Ej/WDpXDOfAktUK39SNut3HlpsTtef4wbRS4FR1d5dqNg6OQSTimJEALAIoMkepv
         HdZzllXGTHI7Bur3SKzfCLh2DkbShPtfqICKbg3V12DfhiGr1rFAPedkrfOq5sPMWQW0
         nPuBy0/g84at1rkauSza/OC4pxfHHrTGMdF0d3Z0lIRpFleCQE8yf3f6J+7PPK1yyW7G
         dVzm8LPkvr08lMH/YUvfyja9Ywm41ocN2Vi7vXLR3iZZFFBFNCT9L36PS1DCZ1alLWJL
         TAvw==
X-Forwarded-Encrypted: i=1; AKwUvBxQlALsX1Omw2Xq4bHy2qVg/Dfmoa40WFElcyDrrvZSyNsMo45VXC0WMK35nf8lpH22qC6H0w==@lists.linux.dev
X-Gm-Message-State: AFuF++l5wJIW3rnqI7y7tqzfPD2ISfw3dlUy7+1hBsohLIvaqoEZVZ3N
	RiAg+sZuFXEqsZo2ofjvPcReMc/LgB9LJY/08a1h9+0ab1lyXY8acClCKBXFltfyBZ0=
X-Gm-Gg: AYBFou1SXctcGAHBmBACYU7drh+Nc/wc0mr+aOBXcydVVGgqFljVI6XZo0fxfAvBjga
	6DAkJdjpyaGc9zOwshFiHctjBREb7uzHLzocELZH4zICEP38wL6+4agP3+WEiAzQ3KdhzEjFgb1
	aB0oK0QPWWzxABPMleA0ozdVlCtR+hwcbpzbGk1SFDFCbyvtcoRVigW9YLfONE3xVPJ0FY/AIFq
	HJHKXeYZZYbUpcL0PhhNXIgRO/tHfwKfmdptnJfdy8ZKpaPKzFlXKr/5+Hgr4CShlKTbEgCJrb1
	IJuyN7rG+vhAwCyMso/Z6X5xnHALOP+W/MjYOaHJTJM6HkMElNO29IBmhCqN9JB13kywFVVBDiI
	TYyOtinUb2jCut1ndTJKm6DbgXYfNsI6egjS62xLygmCl85enxKpmra9BpIwSNMebN4v1MD3Wjs
	uOGNB0NGWz00VNVPKox9M/A+ecQ34gJb+auXMmZc3QxkE8CjFHmt4cKvi7082zudmHVMKEaTOFJ
	wyEhD4Pni8=
X-Received: by 2002:a05:7022:7e82:b0:149:f2b3:efcb with SMTP id a92af1059eb24-14dd10af1famr6118991c88.14.1790922797740;
        Thu, 01 Oct 2026 23:33:17 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fedd43sm6315754c88.4.2026.10.01.23.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 23:33:17 -0700 (PDT)
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
Subject: [PATCH v15 0/2] RISC-V IOMMU HPM support
Date: Thu,  1 Oct 2026 23:33:10 -0700
Message-ID: <20261002063315.1535817-1-zong.li@sifive.com>
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

Thank Joreg for reporting some differences with the spec.
One issue is that the spec does not say if the counters must be
continuous, or if the mask must be the same for all counters.
Since non-continuous counters and different widths are very rare, the
original driver assumed that all counters were continuous and had the
same width. However, this does not follow the spec. I also fixed this
problem in this version

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
 drivers/perf/riscv_iommu_pmu.c   | 1081 ++++++++++++++++++++++++++++++
 7 files changed, 1157 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

