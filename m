Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5C27FB05
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018201; cv=none; b=d57EQQdiOCk9MKBvb7AgRO2JWZBeqRIy0DZuD6lmPJOTGVf4FERvTjLLwubQiR25cMS7hKqrPA8rS4SrU++R4cJoAptgxBvdz01Gwe4XdoFEbufwvb9xhXpu9RUFTx+GYrhnYJh3JCkQcEecHIpV6gfbbM96RpnNr4pm4u8bGTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018201; c=relaxed/simple;
	bh=B3IgVYrO3/tbVSQm0A+Mct3fqIkcnhLDq0eqR5lzYNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uahhz1iQaXbmHC6ueLi44yM3RPmTaWk0DhbsN3uKWpb08AmS3T/sCmUMljKnVZGHn5ifHNpxNm/layHUt/73djLvNCDIBRJ69Q8Utsw6753NG/ShF4CSwN7zhR+fH9mMHfyNtEJQjPw8Ad9+nxtAlc3aGkUpj8nBY3qhEfKOs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bug2HEaW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bug2HEaW"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3902067a91.2
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 01:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784018189; x=1784622989; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jn0RkqkJtLXr9ENR5GursZsBgfA51fWj50aI39fixhE=;
        b=bug2HEaWST5lh8cGyaYcxaXMjV2Ooc8ocGs5h6b0ry5geKtvTKb97dqdRbBMqVD9CE
         gdNN8IWMmt/KsobeRkoO5es9I1n0VqKNTPmZsDHQWJoV0wNp5J4ZOqiP0lGrU6dW9lmN
         0D2HJAm6mJWCHIqLAl/s+gxuMAlC2LK+dd1g0D/CCN1NVh2n7ibdnJPlphjcNgPSAfa7
         DgJJgvZbBrUgC3jj1ElWITHp1SgMWtyhmD3ZlgwYAV9qsWSnTL4kCidLP/XXoLp6t3E7
         6k2+TBV/drIySW3AFKQkcS2UXk8SfTP2up6pNfh+NvM/NJDOYvGbJ4/DEPz+RjJ+c42Z
         EUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784018189; x=1784622989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jn0RkqkJtLXr9ENR5GursZsBgfA51fWj50aI39fixhE=;
        b=Tt62yNDN1gNd4IkU2dQ0Oz8izAlURdc99i+VVx5LcHtq8cnlMtNpdhmbf+xC8h3SOS
         /H4r+XmyUeWg3RUNQG1XM7QBPgjMGTDT6SJhY3TZVXAuu40Z0M3j4pbx51DFZRswmCbB
         AYQYFdEt7wX/pcdlKe+qdGdaLKkToXE41RAEKjAPgPsOOqlMoHnYgwpGXVWEAIZe1MOX
         9yg4136I/jAvABfQHyoXksRn8mcTgKJSoSM5h+RjEWmY7WS/2jpQkCCX6pGbsJG6szGb
         KJRizsyK+VHZx6afKPSeP1PIrSJsk5p80pLKtFFeK6HZ/iujVfC9X4U6KTu5g81U2Y8x
         NnDA==
X-Forwarded-Encrypted: i=1; AHgh+RrxbI1UWBXq1xcZquWBRMKyBzbpN8gKRjezVG3foLCniG812wYCjn+fo8tYx6Gx6zlODxtXdg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+9nnkpNPWxaVBcvxf/vqbvcirdbUQOxf0TviG767HlK2UCKPa
	J5dniR5s/KtLQZpeEKFbbmv1ClcY6Fbl0aVEJxLSE72SJ+KA9gPVQv7ISqiY7enLmD8=
X-Gm-Gg: AfdE7cl/R5VMw6VocMBMT254zWv8Y5N/c4gUcnW5e5Wtv50jsz0Wz+SlhidG7mDIZIf
	DRMHNWRUjDp3yBZH1wnGqQ0NCg0budnXg8w65sUldwsux701pYCVKDkha9Lrfuqv+sLHnKld0Bs
	Sg7quS/ICEzMtI2L+p5TASiPM0jHgx3M1XSX8xRt9aoMdI1z7Bp45UHnKq9Ly+JdNmKKAe4JyQ4
	UojwtS9FJP5/JMMItel8cESUqQLQVOuPZx/vE1e4ayKw7gStTitjfMTOQTefxFliKM7UW23v1Qi
	xfZxKR0mKevCnJCYmf1bxhkWom08tOsisv3I84iP3/3TdvSs5T00MKXKsH+HLD5Zm4ukiaCF1Ue
	rkXM7pcbCge6a+ED+fxXh36hSMRPQyCpysEGzOg8wPwMFMZHMjFaOEo1lpuAbIruJAhfYvmcE3N
	4MRcjzYL+KtTor85dP68GQZjnl6F+7kZe/kg4=
X-Received: by 2002:a05:6a21:9f17:b0:3c0:9c19:65c4 with SMTP id adf61e73a8af0-3c110aaff03mr15644136637.76.1784018188774;
        Tue, 14 Jul 2026 01:36:28 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311950eb930sm55932938eec.8.2026.07.14.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:36:28 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 0/2] RISC-V IOMMU HPM support
Date: Tue, 14 Jul 2026 01:36:20 -0700
Message-ID: <20260714083625.1083606-1-zong.li@sifive.com>
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

Changed in v3:
- Rebased oto v7.2-rc3
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
 drivers/iommu/riscv/iommu-bits.h |  61 ---
 drivers/iommu/riscv/iommu.c      |  19 +
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 722 +++++++++++++++++++++++++++++++
 6 files changed, 755 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

