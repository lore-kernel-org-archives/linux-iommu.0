Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034E438023
	for <iommu@lists.linux.dev>; Fri,  4 Sep 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513707; cv=none; b=e1YGKVJ7xXT+OY9p67dbmpOJwAygJmMDf1HsGXy2NN65S6RdGqbBf6SBGzRHqXBRMHITGBZX9wDKILKmx5R/ibgl1Cf/qxHM4Esh5GPJLNCPGaXaZbwWBS2oK0Uarnwr4aX6N7bZ3X7xz2u4nSvPCxJi0pMnmmHOFcn/XqyUBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513707; c=relaxed/simple;
	bh=66UZqVClFVVA1O7tD4q6NQPzk7bNbkSIzh/ikTXNEQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLyaWcjNYsTjBcrBDNxyh4nNhkiLsdsX8wZAx6AYpMizjbGZ2WlNCv5uy4TUxz8ch+ItSyoqG+Ar1N9bS5zU3zJgzT+NCYqDsOQtmIZr2TrodZUgrcNh10MmdZANwQga+CvSPOH3woUYsZ6kodhLVy6AnaZ4QaIYrpDwpg7YVNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Xxgov3cS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Xxgov3cS"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398b3c37877so771451a91.0
        for <iommu@lists.linux.dev>; Fri, 04 Sep 2026 02:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788513701; x=1789118501; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q9+T08Ol1yj/MMF/M6cDqb87S/P26Yho6EBQQNhwINA=;
        b=Xxgov3cSNltu+CcTkKPqWZMbNoZ21B3388R8G2AxzmvL4VPIGJpsU7HwT3J9V109Rg
         IDfVE2n/mKseEw7K3G/rDNHCza8Ohjk2e3K1/PUJzqv68OUby8+ad5G9ZhrmRQ10JTd7
         vixeu2s8UBSGcQn+ZFJfZEKluzDwh7OtVaMNLU9yE0osWBtKeFlgcgv/VR7QuMl4Kj3B
         VMcZXHppNLhnq5pUUqIwNBStNm+4pexbWQenCKJgsgwLRh18zRvBZLDsGohbbnJW1u1E
         XejIJGcTIBFYnOL7lbYFB37JzCmLGZOAzJfxKDsRTABHM0qygYWjU2NDnvbVw3JQ3GQW
         PVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513701; x=1789118501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q9+T08Ol1yj/MMF/M6cDqb87S/P26Yho6EBQQNhwINA=;
        b=G5IIov2KjJtIeczC6I7PM9Ug0DV8GhmOzIw3oZ4RpyxNaU7xfpLJWTLCLMGCOAsH4L
         aJnMKV1SSb7QVYdttf+bj/imZiOGrJaMp2WpS+yicFtC97VoJlnu+c3n49F70Rs9tt1W
         2Q6nJJCeBM4ykejeV1O20GSbAUsDyOaoFHfOeXLaWwLebR2ZXAh/4ByPUyr8jCrw8+4i
         nRmUl+IKUwah2XvQiIIUg1s9PQ6s5mBn3Dwx0jw+O9H/5pO/x531DVKnWPKe0IyZGuR2
         cYfqbOwEfhTIzZwoiEtdRRwUknxZ6csQBmpKSe7GOCXhGe1uD7C1gkNbDa/yCePCwXaG
         6J7w==
X-Forwarded-Encrypted: i=1; AKwUvByV9jFzctg/N3lpdFO4Nz5ZVaPHgrSlRKUiavhcjflnvqRASxC/n0mLdSktjlRmrGG23LvHBw==@lists.linux.dev
X-Gm-Message-State: AFuF++mcaxSBKo3+IarF8LSG8XYLfxwRBU3XAjVp+0+oe6UVmLryDdUM
	zsV8YOPjrrXKwUz4mga6buRxm3fdmOXaITGTQ2ToZeR6Pa44RWJzcHgePziFuOEeK9g=
X-Gm-Gg: AYBFou2Ydt7JtrGKjdvwB6y1vhYUVSsBnXDd+z77Dwh8lTgmVc8MUr/s1aNSTSp5SpR
	GCwmkNxb20iY9TZf+PgyxryYpfLDjiBpyrV6uQIrJAo+frB1AHPhy7Bm2QV88geh47wl0QKfwW3
	yDkfALb3YIMU9sXMGf90IgWc2pO2M3pVGD4pun3z+q2M8aEYMyDFxF82a4l2cu/y3UNePH9JXIn
	YBvtq5H6HCWugotPkRVww92Hw5UpCSRjLDC7Tr4h5QuInD/oyRTRz094g1upPwC4Iq43541oJL8
	CLCc0E1Os8K1Jp6vb89QsoEWBC2CJdJWBnff7lT5kQ03K+ZnqqE7Vroj6NL2pGEOSlKSIrnrcCb
	z5jFoS7CixyI8ZemuFaRqhNm516bsCk/EVyR/duSAf+f28Os15pP14E0sg/RVL5N+x5P5PtofjB
	tfTGahjNjldfkidbuZKF4l00/I3yA1BRzTt8+7RuvSsMSuao2kC7mBDqHlNmIxXpkk9B5AoD+hv
	wMI/mIPS8s=
X-Received: by 2002:a17:90b:1dc3:b0:398:d6f4:c61a with SMTP id 98e67ed59e1d1-39b26207ee4mr7536728a91.17.1788513700711;
        Fri, 04 Sep 2026 02:21:40 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432438497csm5275575c88.8.2026.09.04.02.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:21:39 -0700 (PDT)
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v8 0/2] RISC-V IOMMU HPM support
Date: Fri,  4 Sep 2026 02:21:31 -0700
Message-ID: <20260904092136.113321-1-zong.li@sifive.com>
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
 drivers/perf/riscv_iommu_pmu.c   | 941 +++++++++++++++++++++++++++++++
 6 files changed, 992 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

