Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59032B99F
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538040; cv=none; b=ZPEuUHyRACHhULbUl7quIvUU/Ppn9N8S/aYV0AT+9zUGyHe8M65oO4IwHbA2uaGE1ORZYDWOadjL0MTz0ixxz19SzWa+FwU2oiQJQZ7fOe+5z63uoZx3QymGkbtGbJ0qo2oQDJezAvaEzqpvbmlZpXpkOGqI8M6URYe/31XE3As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538040; c=relaxed/simple;
	bh=USG8kUY4fnqDkyeEZeBeSM+PImoZzodWQxrfboaUfXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6E9H1gdL4Z5u1SZ6w7dsRk7AUDnYGVf73xMtca+mL89QNXcZINH+BMnqHHO3IwOvR/JqCz4pX8MtWj6OknNNVtddWHyDgFq5Um9xt4ZfXr7zMOHqguBCAtqDrkUcW8LCIr6sZzWD33qUxe8mrOg8A0U6egfLqwX6IVaX1SiQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WGzyRRe2; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WGzyRRe2"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc149372c14so2029893a12.1
        for <iommu@lists.linux.dev>; Sun, 23 Aug 2026 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787538037; x=1788142837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EM7lljqiPKnFmEvR8seE5KmzQ2mD6+J09RR+VPh3RxA=;
        b=WGzyRRe2yLRuGbySPUWSw7ycS4QTG20sddp0ka55CuxaUgoXcKRwbTXyAl9wdUC48m
         6p2KyvMqMWPBLvh90u2FW9rzC17+/HSVRxy2fzJH3trcbvN+1WuzXEf4qJQxy5XdQjrZ
         QOYHVBfRMfsdj8DazPAzoTy2ixvVxDARurIIIeVqVqwJT/nJR0fTOwUH1OGYpuKsjcBD
         w3AAHFtq9WAblDetxj5GtjCHi0KMBHb4kZu/xcKfY43C5zaNCCBxg7V/T3WXVBBYb39b
         s/s55gasDiVzUzzpEIZmS6lPrawKgunit1neriEpH2YU9rtCIsh/GPjpeCImmGP1NBUT
         fnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538037; x=1788142837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EM7lljqiPKnFmEvR8seE5KmzQ2mD6+J09RR+VPh3RxA=;
        b=p3USDXQP5ziXNmTnt4Utk5KpOj4JQG3flusqIA+SwHFb7pZgAd3rGMDK2ce321g8XG
         FAEsJ6kSDfHbONG4D+g8+5qSBC/ZN+1LEEADiUIIuSXgi6sBfSmxKh2io94C8jLUVM6y
         LgcVAyWmXxo+g4A0NeJW2ZJmGFaQu009eRSPU7L412yLcMqsq55lZ1sz5EncHN9+jrbd
         gPOphA7V79T6woXIU1L7fIXian0m/5xv95rQ11rb1c5oV/IzFKdqsgGILyp9E+Mcc6Ct
         nmv4JyazrcxPsZrF/Q+EXPWLimnFK8kOygLuRFh9Xyj6gAgrWhgxTqUYagi0oi90ahkl
         Cy+g==
X-Forwarded-Encrypted: i=1; AHgh+RotPzrnyfwazxbvqr/wTHSvGvrcXoDTe2w/9zPp97snBhdXw+JJj/5W71X08tA8ARsC95coqA==@lists.linux.dev
X-Gm-Message-State: AFuF++n4h0ZHacKZRAel0+VPFBe2AyHt52+DrHrgmOoywvt1FhuEcM4D
	bRyaLCoZ9ClzK3gcj+vVNwQl3sfw8gmGiaGyRpOpn5MeuDQb61Ln+P6jdWAGuNqS4pU=
X-Gm-Gg: AR+sD13HOKJjmrghirkGCLWSMqLinRdvPcT2uISRu1ofCnWnwgTSjcELOACDDxS2zw1
	iBwB6I92775Kx5gltNUG0A61E44d4CI3EptF22fHRUuFMvCTF0znj/i5qr79DCL8WJh3SSpb+6X
	gOBYeNXZBKTug6IHFCyoex7aMjlPFnDaqSvVx+sLh8fbmNGDhv3UJhDGvjLCAPgIq69o3cP4eb5
	57rx/C4kfzRwgGZRefpMvr53oQIuFG/jdCEdG7KA1Pjiqw5v3np5HouvZC6COjUB67CJSXJriQx
	Cdk+J7UVt6BFH4X1k6XI1CZkzo0XXlxlGDwvB0KsC+b0oe0gwqzWCBqau1kpjrdQf8NKbTN3wsz
	GLRgNSGRYnZTcFO3rG5EacNgDWxIZDTJ7UnBGfyGw6KeyLDeH3cXLC+2sysKyLq94r/6k0cvyf/
	64c33E3JlCVcMlboHtUDj1i7j7/0RW/nD9MKsKssVA26eA1kvqdD6Cqdl5+G2tR4m9j5bq84d7
X-Received: by 2002:a17:90b:53c3:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-395c39cbc42mr41491359a91.11.1787538037613;
        Sun, 23 Aug 2026 19:20:37 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183c0esm31175869c88.12.2026.08.23.19.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:20:37 -0700 (PDT)
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
Subject: [PATCH v6 0/2] RISC-V IOMMU HPM support
Date: Sun, 23 Aug 2026 19:20:27 -0700
Message-ID: <20260824022034.3916570-1-zong.li@sifive.com>
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
 drivers/iommu/riscv/iommu-bits.h |  61 ---
 drivers/iommu/riscv/iommu.c      |  37 ++
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 813 +++++++++++++++++++++++++++++++
 6 files changed, 864 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

