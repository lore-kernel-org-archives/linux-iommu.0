Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241E41D62C
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108255; cv=none; b=fzAOQQ+SLT7UqoTkoLQH0ZH6SZlU2Ooiu6XwIzZdyoBRr1/y+M5XA/vnA0/ZT2+QksZea0gqjU+ewx/l88m+a3YcrD0wZrVPah6+Y6fEwJL4LfsxxXduEw7VjAxOrwjkOou/KaRRfM6FodzxkId7linMsxIe5O/0WqeHdcFxBIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108255; c=relaxed/simple;
	bh=RQnl9JsCyLlas2wqU9XhaI0GPuGEC5V7ikoHzldSR9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mfeUw35yeF+hZm5Ap3MBjHHDUxMOZOM3M5YnBRue2NaFdRnJ5p5H5buJQ69Lerof6WLWwdciRABwlQAcx9bHW11Ijb26MzaBj7AF3S/FhczOCmpgwCRv3Z76ivs/C0/3k58P7BJf78WdXtOFnT+iqmUfrgIGw0u8sO8KU3lH3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Yr6UVW14; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Yr6UVW14"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3964e480f76so789568a91.1
        for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789108246; x=1789713046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m6fEOf/IOiBj0LrijFeZ/8VfHCADIoPG1CxdjXEq88Q=;
        b=Yr6UVW14+DbIc1Vmnjwo2UukBPpO2zjDy2Dzn+jWBRNeLQRgL9u18s84KcpX8d/ZPR
         EBVbGEn/nZ3fxoud4FHmYb7cnKfUJrsvDRhBf4sRO9mAn2fY6TzD/FpWQEYNtVCoStEg
         RQKkc/yWnPWbQAWoLM8bEFcxx+Ho5hdAQMMnyhQdS5MXRDtbtA6pCh3giyeaigCqV0vs
         1us5U8npBEcNlqeiun4Ek1zSiVvpDT5l77/xlpaEobifaXzMWwhshJ8E4y7h0+FxCyXQ
         FrcqKE1xeQWSbu7nRbbmT+/W7X1WSAFb35TzQZ+XSpqJFbBRxDRnx6hy7auDfEoEDruB
         03MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789108246; x=1789713046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m6fEOf/IOiBj0LrijFeZ/8VfHCADIoPG1CxdjXEq88Q=;
        b=OLNrpmsxA1lpNFbzGHO4/N1XrGidROoMTqvwjTu9PuDx/cYsJZ1oQux/MUOLlqOHLa
         H0edFf3dNhubASZURTXpdcTJDTHJOjcISDMYxqph4w+rWhwQSOKy5CznO9cz3G56a/+j
         nJCUOFwcfuY2JbZiqYj047MOvY/mfOsd9HMxSPIVAEAu/roJghp3sGXlyxyTDsBxjLiE
         bt2c5s1lN7Vsov9hBNOVwhWkiu58gzeUYlclevV7de1CJwtU1RblPELsoy9ab8t6optS
         xSj9VP5buSDx069h9x4rPmLoGMal6oY14BS6Efw9gWNJJiENRnUulTRC7uiL+A+l3aLH
         wGrA==
X-Forwarded-Encrypted: i=1; AKwUvByre1AuN8yEUX9ha/aQ5wMN+ArztWPCWUWd7OenPPP/0Id7xPMSXauYKWmnV9fVWwNALZtkUw==@lists.linux.dev
X-Gm-Message-State: AFuF++mIkUzZyw/HTNY0vQZsIveah09CVyXWV68Z4Fcfm78+tS11Annk
	UKEDng1A42lxIVRjMPJjU3ZO6h1rTROHSv3dRDmcg1Ry2cio2cATCpOaghGUka2QPt0=
X-Gm-Gg: AYBFou0yyuy7rK2v6GqLC98SBogGJxK6X5usgYYzot94nVxWxLAzCYAqZawg2rYPGjE
	d5igmkziUgTJY7lNsEpJAh1NiIxVSo/VnexptZvqXuqj2T+IRXtNwIXu57gJAWPo0OKyZ6FNsPo
	Gl7qa/njC2ZCGgCxMBc5yp3BOUbMpM03bYHkWQFRK5twZascRgKrHXFvQNEPiShe3YNNgA+7Us9
	OGn2QnQM4LGacCz3cDOHmDF3b7lO73M4XxwnnMqGfimE4zunCV2h0W/q+A4Gfhz472+bmtctU5p
	oPQay4xJQ9MC/9dYjE+P4W/CoALF5v8MANyjJgrnooN/pgQqt8sP+MPg/G9rKA07fTcr9q5sENV
	W4WU7g1SxxUK1P+7/9/bfbcYzcUreaHMJqnXoGjxuNJ9xqP/Dp75XjwITBy/a+Za7qx6oejOUi7
	B+ub6O4DIJuBql8Na0w3/8sUMHlJvbnL6dJmLzZH2g2ajXQ6PnEgrPw3nLKW/dovxE3UhRni4tG
	wK35HwuE16PqvNztmhAww==
X-Received: by 2002:a17:90b:1650:b0:398:d8eb:cb2a with SMTP id 98e67ed59e1d1-39d9c34266dmr4534758a91.23.1789108245853;
        Thu, 10 Sep 2026 23:30:45 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm331152eec.8.2026.09.10.23.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 23:30:45 -0700 (PDT)
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
Subject: [PATCH v10 0/2] RISC-V IOMMU HPM support
Date: Thu, 10 Sep 2026 23:30:40 -0700
Message-ID: <20260911063043.916844-1-zong.li@sifive.com>
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
 drivers/iommu/riscv/iommu.c      |   37 ++
 drivers/perf/Kconfig             |   12 +
 drivers/perf/Makefile            |    1 +
 drivers/perf/riscv_iommu_pmu.c   | 1042 ++++++++++++++++++++++++++++++
 6 files changed, 1093 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

