Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FC3976B8
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716035; cv=none; b=Ybdgvp0f1pYjTdKFH1IOFqt3sUsCEdvd14YU9Ms35y3ODaPhiblV89VxFMpzzeEx+QIgaG1A0LkbUw8IDjbpulXcUbMI8oRVMUxexaqm4jmgr7JdiiWitzSwYZNDAgte8zJNbDK3/odrNQfnDg8t97rXXHfGpWakmHs2iapR62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716035; c=relaxed/simple;
	bh=lmr05mhnnK+lOO1jE+gAQDYyz+gLXcxDKtIoIuO+PWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hr97MhCQwbd8cuc0lugtOLUl1fome2MqRoW+tsTnOi2i5wJtboVcjPR0kz2Z28+muXp3FB8aiEngNd0qjQzKZz9R374ACL1EEG2NvuWMyjnCjPXXQss0F3SLUJUin/tQ8e6C+VVWPdCvWTylZxyRkjp2ZjWqHW1lsVLDvyFu5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kFkny0Vs; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kFkny0Vs"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so413216a91.2
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 00:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789716033; x=1790320833; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ey2Q/vsiZe0TmezjSQD1jn0tWr1spPz2HHVIhZhd4Uw=;
        b=kFkny0VsdNyk6vC23fWkEzaZS6T3CK0rlrqMR0dBCNWOyCQcpVhGMStj+MMlIA6DkA
         hMPvXajGDSUwhFjgMkKFzRqCYnP1g+U3h9q/5mHhoDEaqUkR5U7wQDCRnJfu552Oc488
         oh57YQuAQ644fdZaJGtOWCnca03YnZoAMIPNlVkESnA+yLZ+KKcbndiVtPVK/tGIsyFc
         hm5IVJZC/FyZQVlybJVllMWT+n5FK8p4xALefmRPGVb9czCVlF2Pw9gdK132MoJ3pJA6
         W02Xze9qs4I/cO7zKrkjunAJa3fr71sEzBLv0H5//YZ85oBAOwBKCnmIUeLfDcVZU9dW
         4NGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789716033; x=1790320833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ey2Q/vsiZe0TmezjSQD1jn0tWr1spPz2HHVIhZhd4Uw=;
        b=TdlYv5mqwRuDiY3jLQSN7BhDJ2DkGvRpfXQZxV82EmuL+vc0wB3h4l/sqvqIt67Ace
         CNQQiXaYeQDuqgeztkg8XPOBcDL5yKfGuW6qLcX9VZc0CIuPyX8Xkg/DQ3TanUMLXtr6
         f+1w+NeJMOmXYBfge1W2r0EYT0YV8PMQVWV25RLbmZlp6H8drg1pwNvbCDdjSwHMQ4z7
         19Zpup9mZekEf4iV2I9iGxPeItXj7VgW/ZC6qc9chHp7WwcaSDV/73rKU+bU47lr439y
         pD2zR2bQ7ZnRllwuescb2kTlmLRjp5s49uiGUI7zxO/C4MmTcq8ScEQ1TitfZGhMAhjK
         poEg==
X-Forwarded-Encrypted: i=1; AKwUvBzgQaYopW5lVNQuNK4cTmQ92gzG/QILoQ3/rp2LeTk2G7vhBf60eMiy59M9R9MXNWLYSV7R9g==@lists.linux.dev
X-Gm-Message-State: AFuF++kVh1+8Y/n3CyUil+hr9Xbgocnb5pU8HorUnINlWJ6OFNzqF5v2
	HiVub/1pjd4ePA1WADaTlU/8ROveuu/msRbpGji7xxKMpfVes8GHP3jl97davZz/ZSA=
X-Gm-Gg: AYBFou3nFUBTGRSWGPAHoR8im3zk+BDHv0UKdiAgnQuVbMX+dDe2yfmRWoOpSj2SCgd
	OzsOqo4pXyaYjg0KWylAWC4M3+YExierLFAx5nkGqjYwrRI2FkCLuQSsPxmtFxZnfLk2G9ZplGB
	2RpHDe+vIqkwx+RF16VJFvev/typLomO+V/ezK2oL+K77HaLuG5G+fddymbebzqP6L0t29xyVjm
	2uII0m7MvEHWybWeWXasY6477rXbrK7yHuxYDrTkNJIHMXuUL2BBS/6HcBZd1KaWFYobFJudUq4
	qnBVY9acJ/AXUmyNiTfTU7Dx2yJVxaAKhh7/V71g9T3UJN/NWGEyYFIU3hZE4LtH6X8rA2Hj3JX
	SuWtYAUvQmboyBRHDCSUbzIC8g2JpwLuHOPuuxXem9qGyvyCmqWmVVuRED5filCrEUgxl8FoI2V
	LpRvDAhYENjimKYPds4NjNCDxbQ8GF2ckG2J18QNqC6g1ve4dD4CJXgaqb+/sHBP0AAZSeFcXO7
	w74yiFjd7M=
X-Received: by 2002:a17:90b:398c:b0:39e:35e4:d31b with SMTP id 98e67ed59e1d1-39e54ce1651mr5897094a91.5.1789716032935;
        Fri, 18 Sep 2026 00:20:32 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce03c682sm4416046c88.10.2026.09.18.00.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 00:20:32 -0700 (PDT)
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
Subject: [PATCH v12 0/2] RISC-V IOMMU HPM support
Date: Fri, 18 Sep 2026 00:20:24 -0700
Message-ID: <20260918072027.639239-1-zong.li@sifive.com>
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

 drivers/iommu/riscv/Kconfig      |   1 +
 drivers/iommu/riscv/iommu-bits.h |  61 --
 drivers/iommu/riscv/iommu.c      |  48 ++
 drivers/iommu/riscv/iommu.h      |   4 +
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 994 +++++++++++++++++++++++++++++++
 7 files changed, 1060 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

