Received: from mail-dy2-f31.google.com (mail-dy2-f31.google.com [74.125.229.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D108745C700
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244087; cv=none; b=eyqdq9BgOKYvsW8y63dSDhGfX1X3/ld4EMa6yTv2oxeziR5guaB7OA1aD2Cx2xYq5QEv453NiiHBmN6oE0XEZxf//pTLaNoCFMuodrJv1RS0FfPYjuG72jnbGRNgsnknrtSz4mHyNbDTnDErmggWy2IsKWbje8Y03gn4rXYT6w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244087; c=relaxed/simple;
	bh=jodBbkvPA0Tk/y9h6SJNWm6ZLaJKUz5cCBJdy8OssNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OuH2yl0NFmk0/62KmEh6mCc5EGDIoMXVqZrgmM5izt2iUd7p2oJ/xnuNyCQTVCXjhUAnPNN28UBZTTkccTLCelRap7OP2yEr3K0w5PYK2QikEKlUgz+46QV79/BFft8J5KuyKS1FaSBjNL5OmB/nA7VrkN6wmDOcptSR8NDcUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=iSODEkj4; arc=none smtp.client-ip=74.125.229.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iSODEkj4"
Received: by mail-dy2-f31.google.com with SMTP id 5a478bee46e88-33c11ef641aso2152466eec.1
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790244070; x=1790848870; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T7LuCKXGDjbZFiX4G8+riT24rAGxjFj+z2Uy0TMvuv8=;
        b=iSODEkj4q11816sVc17QeUCFuzB4tz1xaWLUipHjTCGeDoNeOAQyiyyOCwQTXkeM/t
         SWuz7N0TgZAxjSeC0+7AJFuNA8hGnQ8V9qAr1lkCAlbhX/iO9g4zKa2gEokmQW7KndgS
         ONVDy+Vfm6h2/1//TIZo4KYtu6JbtKR4zht4PPXWZIWC2Zq16KXwe819CuqDpN+VaSWK
         xAFEMzJQPMh5tODJ7XlwWBmnAJhJOnWpmJXZkEM4nxyyoIjfu8/MNyko5eMHJVgmHKUm
         DZkLjigQeVWtg21rxH+Nivw7JR+PUBjkMh+CJ85h7RlxT4xHzSzrwjWUgqT0hmYgJqOY
         yB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244070; x=1790848870;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T7LuCKXGDjbZFiX4G8+riT24rAGxjFj+z2Uy0TMvuv8=;
        b=FFfHIKhGufAhMwRurhSxrenEBQ5kzylGl5GHV1Gm92zYRTBaAUYgx4JGRE+P2SIKJZ
         og41fYgutB09BHu2mdtTSpgcqZCn1fr8sKirYRQl2Ob6BTE0W+Ty3tOu95eyLW1mtssb
         emEivFQkgUcjFr1+AgrqQxvoxszFkAOWYCVrN9AdKc5BZFRy19WFFHabWQ0dj8E4G9JW
         ElylF5/D059H6RrOg24xYkbWII3PhcXtSAUguHKm2b6ym+3XfNzWQh1n8ThEDFD6OdwM
         W21ibypGAWdhO/VMGHJay4AjuZGh094mlTqBYYj+1WIgqEGQ3BV1fvyqIwgUL64Ognr9
         yu4g==
X-Forwarded-Encrypted: i=1; AKwUvBypkPqG4jpURM0zDaQyvhVuy4Mc3lLll1C45h4Y7d1wWvCDeZm2a3U24vftD3fYN+r8Y6IttQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n+Ovo+Zanu9NiZ9jcIAW2o3lmH0b1vIsy8EO1xY5Swou7BVxtV
	7+JGZnvYOUjf3/FQVie1zyFvHDHachg3Cw4BpiGK634PFwa2P+GC0LDYBqcVO6vv6wA=
X-Gm-Gg: AYBFou1QvPnbj5WavMgwyAYm3RQVxBlpFU/XVHalJVKIeo93lceWLYOyV5/uWiA3Kqx
	KxnEcN+WTTJIwFQTSfdiv02I/7/FWzMeI9qgNfTTQo3zYKCSw7zqXYJTOaZXCMCgJG5bC9iALJd
	RRoF+ypbEcFf9c3X40AlRassQWglgOkmHyF9BOMMG7O6xCeeeDWRlZJTyA6PPogk9/YuqAFF+WL
	x9rlt/m86RlO6CRKk8kdcJ85f2GS3bw05cxR5MUYI6FR1pEsspiBUAeKslId0xtTzxR/rj6LmqL
	T2UCgp7H8sWjDhlUC4UbDCGjs4yPxFDxs4GMVkjIrKIBUEIssJ1eHIuZosqSWgpvdaut9+6yncF
	LuKF8igO6nFdZIWS48r8GFVzjszUdyo2AHXDk4Z/LXCdd914RETt97zze4WAx70I6FnfedsDxBz
	C4wmWjtMTEOE5SH4C8mPiHIXiIhyYZY+cY4v2cnPwsz1bBBdh9AWl4dLoopW7nc3WcOuUQ3pFuR
	PnomriFFYQ=
X-Received: by 2002:a05:693c:829b:10b0:33f:3ad7:fe5b with SMTP id 5a478bee46e88-34004592b23mr1653984eec.3.1790244069709;
        Thu, 24 Sep 2026 03:01:09 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96e498f0sm11649975eec.27.2026.09.24.03.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:01:09 -0700 (PDT)
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
Subject: [PATCH v14 0/2] RISC-V IOMMU HPM support
Date: Thu, 24 Sep 2026 03:01:03 -0700
Message-ID: <20260924100106.2054127-1-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series implements support for the RISC-V IOMMU hardware performance
monitor.

The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
created by the parent RISC-V IOMMU driver. Therefore, the child driver
can obtain resources and information from the parent device, such as
the MMIO base address and IRQ number.

Sashiko-bot reported that writing RISCV_IOMMU_IPSR_PMIP will trigger a
bus access fault on strict hardware implementations in v13 series.
But this follows the exact same pattern already used elsewhere in
drivers/iommu/riscv/iommu.c for the other three interrupt causes (CQ, FQ,
PQ), all of which write their own bit to this same IPSR register to clear
the pending flag.

In each of these existing call sites, the IPSR write is performed as an
explicit, separate step from clearing the underlying per-queue CSR
error/status bits (CQCSR/FQCSR/PQCSR). If IPSR were purely a read-only,
combinatorial mirror of those CSR bits, these writes would be
unnecessary — clearing the CSR would be sufficient on its own. The fact
that the driver has always written IPSR independently at every one of
these sites indicates each IPSR bit has its own write-1-to-clear latch,
not a live combinatorial output.
Given that, the PMIP write in the PMU handler is consistent with an
established, already-in-tree convention for this same register rather
than a new pattern introduced by this series.

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
 drivers/iommu/riscv/iommu.c      |   48 ++
 drivers/iommu/riscv/iommu.h      |    4 +
 drivers/perf/Kconfig             |   12 +
 drivers/perf/Makefile            |    1 +
 drivers/perf/riscv_iommu_pmu.c   | 1012 ++++++++++++++++++++++++++++++
 7 files changed, 1078 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

