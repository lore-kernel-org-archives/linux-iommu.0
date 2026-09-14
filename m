Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DAA31E83D
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 03:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789358249; cv=none; b=AqPJnyWC7vOTTee+m7YryaxsHgbbDIW6qbWS5FzKErd6mybu5Wa6ElUChW8rSOSRE4L0XQs+SvI6oEl/eR9rl7VHGYk32OZZKlG4UxyxyxnN90ayxc7gstUfIUFLNawHEPxLDwIgoYa5OmCDGaXHAJaUc+VbhFPIac6p6Y1JQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789358249; c=relaxed/simple;
	bh=+iNutv/S17PT3USDFpaVr1iXUPHcJUOSKJaHj4M9+aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/pZv9pdHrxwaHJAl1Z1Dc+gQLW9IENvu02OCr+f1qnyHuYfVkQWNVjexQZXC0M0gKWXdLywCDbU5cm/mOstXXDgWDYouVgHfgJOEwaGRRnanL2oZIm+F3//Q8t5xea0l/h7kT0gaREERAPwAEOUHMa4koxYa2Peo84MlGSB+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Lv4mkgW+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Lv4mkgW+"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc147d86bebso3201799a12.0
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 20:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789358247; x=1789963047; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3K9L+6nxd8BbOVzEqV6s1z3C44XoF9Mo5LgjNFUvJLM=;
        b=Lv4mkgW+ZwAeKEA0cO1xfsgLNHiUhMX2TiBy5OTKgWOi8GzDBFHouVe7SBSzNexQ9y
         pFyjdVKfyS8QK6kAmqIVtKIs0zrZLg/Da0r0paE25v6XsNLs64w/Bs/tWi7bcU9O5q+8
         cuKW4JucwTtdtVL8uuxk3gAQ7jx/YvwxltEoXuJNu/Gww8Rn+dFG/358ZbSITQQxvGn4
         +ZppKnumI88jQU/505ToOrfEgt+h9NhSz5+p2UBOVid3QtIo/Zz70/PR+ugsLumWjLwL
         OhpXtjrmCmNSNkbLftDyZ5RO+uMCaZbv3XPXqCiu+lXsNL54Ar7LWhLem7S1sA71KRW/
         W9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789358247; x=1789963047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3K9L+6nxd8BbOVzEqV6s1z3C44XoF9Mo5LgjNFUvJLM=;
        b=QSUwgdGIv2xvZRjVeEZOEy2lzkI9NL99m6C8VDOj48TMKC7rPROzjzIB6i7ht0JydD
         KTQopO6qBW/ABMF+y3aVj5FjYXdt/WSchoSd258jledjutpZMmt9EZmGAF1BPsaNpyKX
         V5MuH+tbvYGa0XjrpzHsL8fvTPvh9id7XSGVes5vidLsNYv4g40Bna2QkU5LKx5c8IvW
         NM13E52ioG3pL817HmwlcJL6NACLRAfT18tp9xBzLXIR30nPOXF0gXeYhqqA8MHh33f+
         ZDSt/4K7A0ZfM2Oy6ZLHQzCpIU3zLeJcdJeZijr59eZa3FqOvqAUbYeq5Ph9iMNIom8a
         tJQg==
X-Forwarded-Encrypted: i=1; AKwUvBx4tbGLbzKB3ntVY7C3CGJG630o8zDHPMBAwfvMWzj6USLifOqGMIp3yh6F9IION2auv32ugw==@lists.linux.dev
X-Gm-Message-State: AFuF++nV7F7iUP/XSWN7Orn6Z4H5ORLjzSpA9EKF+tu4L7PN19/nOylr
	b2mrYft6X5hZiUkU4/efBGnFjK2EqBYPUfoI+qZWFEYJPRldowoW+8MB/Cfnggo7A08=
X-Gm-Gg: AYBFou1JY180QBik6shT6NU0lXGSY2ikervgIUJPhdJacCGwxvnHWjiH2MpcXKYA4A5
	6eDk36lzq4njVWVkTVGftATIVcDYM+W37DEFAUjL8G+an6ff6oJiXfNdv6ScCNpma+/IUMHRd7l
	W/PWb6vifYGuAcMYst4xoyJNPrAcGr1dgwFgZtWsfV/dn9qNxwF342n7HhXwSjlEkjNFQ+MUZHY
	gRIUxyb8vAkxWXuT55psCueswe7etpuCt7i1kH8lyI1bUrAlIFyYAkwVLEU3XmLe5vhAG+3+Yae
	59WTtLSkpX/MKIa62bq9peMM6Z1TfH4YB6TtjNoXpFa/NL2ceIKLLIJUAmQPrL92sCJcbz04+Aa
	m5WcvgIw4K52yN6nkqj5EyYDRsc2HMAene/wSpxhCPF91fVaAkJNBUeC0FozI8Bcr6u2puK9m42
	/UTT4dbbxdfu0mPbPzzLxz9dOsdZgW7kCqNbXFr9+zyxzWjcLFEKt4LhUD9HXBwlHNDgVeGyRnc
	31LHWbRgq7w
X-Received: by 2002:a05:6a20:2455:b0:3da:eff0:c162 with SMTP id adf61e73a8af0-3db26cc13e7mr5962189637.6.1789358246992;
        Sun, 13 Sep 2026 20:57:26 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm22862554eec.12.2026.09.13.20.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 20:57:26 -0700 (PDT)
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
Subject: [PATCH v11 0/2] RISC-V IOMMU HPM support
Date: Sun, 13 Sep 2026 20:57:20 -0700
Message-ID: <20260914035723.2922057-1-zong.li@sifive.com>
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

In v7, we added raw spinlocks to some paths to fix IRQCHIP_MOVE_DEFERRED
issue. Later, we improved this by using irq_work to make it lockless.
However, Sashiko AI pointed out that there are some CPU hotplug race
conditions. To fix this, we are adding the raw spinlocks back in this
version. This will solve both the IRQCHIP_MOVE_DEFERRED issue and the
CPU hotplug race condition.

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

 drivers/iommu/riscv/Kconfig      |   1 +
 drivers/iommu/riscv/iommu-bits.h |  61 --
 drivers/iommu/riscv/iommu.c      |  37 ++
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 987 +++++++++++++++++++++++++++++++
 6 files changed, 1038 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

