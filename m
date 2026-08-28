Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE73BED18
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900872; cv=none; b=VdtPfd2O8mZ7eOLFcphl3WIFJg7RO+wChk+6kyyMWTfRas4K1EgvWohO7DO54wINBDW4iNehJIgn0nXd6JaX6mJoOAejbJACnpDfYy4xs0nneEZ0izi0FO35OBOqiuLHodfHgAJA+ncyvbHKO5nLxnU8EQhqQ+9TJd3rhf7f1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900872; c=relaxed/simple;
	bh=JfTyLPMvv3/RCFowH8dDuEVfOTZFfPC/h2ynAKfCOfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8OII7HFf0NPYb73wuGHo6YATCvHJIcQZ2YD4nE9TRQWEOgITVKRpP5zoRVZCy+TqCDduGcU+rgPd6pwLkiizgv+2Fjt4ENmdBMTSO7pYjqPDZ+rij85oj2aSC8kDUnPo6kG8htoaGyet14Wpur/QR6eTJFqF1E/QoZerkypclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=U9ym3oxx; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U9ym3oxx"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so833819a12.3
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787900870; x=1788505670; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZRXFOZFial7txsdAx7JQk2q/tHsDJDeYpiV+eFKuNdk=;
        b=U9ym3oxx5y539zcG+1izUQS86sHUi2tH8482ocUXRtbvHQ/1n4Q5aM5xNzgXTLIBNt
         dI2XgIz/UsY6KbHpQcMIWtMcMvD38QGbEYCIf0ZTa8cZr93p0xEGaYOsyEnMICt2iisZ
         Lpd7YSbIL+uUDmDMkGAUqDO8WA1TlpUsFBuJhskTKO1xBfu9MfpsiU7IUOvH8k1pJf8j
         nbzjs7GDx4K1HtbkZm3RtU3j+WkMy8+FtWyttS86T/c6BgjqVwFl410Ed0TtZOpRKqgK
         RMGVbyNIJYb5NmdYrlKXJXIwLa9f1pWSCbx3Af8q9H7pYOJGoaX9l/Bl8mQraGZm2eev
         JYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787900870; x=1788505670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZRXFOZFial7txsdAx7JQk2q/tHsDJDeYpiV+eFKuNdk=;
        b=PUX1Sd4cs2FO6sc0OdcdZpRjhEGK3ldUGYYo8K5/wU6soJmVIRCPmCU2odxYL/ClbK
         bArhNbkcbgZVB+2FeeayZf+b7BXgSlz7Ss6+2jULCIxZTBrLmG4Gb9XLeyRv88RlkA0L
         Nl5Ox3u1aanUYJKkCkPKtTGg/y9n7gj0ahFlXNeWbUrpbY2roVl0lc7c4GekEMD6hdky
         EE691bjlZoKGDL649fVY9okBqNaqT0/OAHHGfCYAjX7ZxHkVywMmXJAC4iDXs3PDfCju
         62avlFsBHqcIXpdwEglTfVjOd3laD0/Wg3dPyJ7u+5D+NSVMxmYYwxVRH9EV4e4uxJFy
         PwpQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPEUS6Zku0oN/Pbil9UqMLxhqGAsxhiibjrrHXldeeBLc6+TSrAGzw2HeQ+YG8g8yNQpCVCw==@lists.linux.dev
X-Gm-Message-State: AFuF++mvHp6+hPYhCnfo3QeKB+95zAmjqYDDDw9jk56PwBN/Gf5MR7au
	LhskKMSB+OKr26Jf6ED75D88ppWKvQa3ANG2j3CTBJCTmfGg6oHm4Egq7AUyqipXyG4=
X-Gm-Gg: AR+sD10Ai8iFCqDGwzYFZG/w5yCtT2ogxbj4Sy9ZGoHE9xMtk1JM7CqVCHepRNmjp2l
	8nEwY295xuI4sH6W/oCj+oe3IqWDkZcztCEUTN/rFhqN32wt3G8nBtXN09Ftc8egYvzSCB+W/lT
	5P3mS/cmtqXM51daDHomaeRtRE9d2fiVtQDPR5U61Cl0Ioc89p/C3wPjjtrBVja3WBKpFCknR0N
	V/6TQwTDDAhdkDNU6z88l/BE9w5bBHHYQTxYdQBXMUMV3NP02P/l1NXChGwjVklvbABWu+e7uIE
	CUOMw/PQpNlb6OoGB3RkOyZabjeY2XKzHncZEIS3rJagVNCzfaYPTKBBJ9JsZkaMxZtkkV57Lia
	wQMdbQyNfbQO6DJem4RtDP7UUfsMWGNuF+jlhX/SME6S015BBzx0hJ+Asyc/ZcO49nM09wyMem8
	iyM5TP9Y3vB2AniStbJhNz73zeIY2bfQuVPsDjXw/h+zmXXrfdta8QrT0m+6WV5NBSPeUYCfKe
X-Received: by 2002:a17:90b:3ec3:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-396d0e37613mr9125343a91.1.1787900870554;
        Fri, 28 Aug 2026 00:07:50 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d1b38esm3156610c88.3.2026.08.28.00.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:07:49 -0700 (PDT)
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
Subject: [PATCH v7 0/2] RISC-V IOMMU HPM support
Date: Fri, 28 Aug 2026 00:07:45 -0700
Message-ID: <20260828070747.4009519-1-zong.li@sifive.com>
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

The thrid commit adds raw spinlock for race condition when PCI MSI/MSI-X
on IMSIC. As the commit message mentioned:
Events are bound to one CPU and the interrupt is affine to it, so the
perf callbacks running with interrupts disabled would be enough to
exclude the handler. But PCI MSI/MSI-X on IMSIC breaks that:
The irqchip sets IRQCHIP_MOVE_DEFERRED, so irq_set_affinity() reports
success while only recording the request, and the move is applied in
interrupt context upon the next device interrupt. Until then the
interrupt is still routed to the CPU IMSIC picked initially, so the
first overflow interrupt can run concurrently with the perf callbacks
on the CPU the events are bound to.

I noticed that xgene_pmu and arm-cci have similar implementation, so add
it in riscv_iommu_pmu should be accepted.

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
  iommu/riscv: create a auxiliary device for HPM
  drivers/perf: riscv-iommu: protect shared state with a raw spinlock

 drivers/iommu/riscv/Kconfig    |  1 +
 drivers/iommu/riscv/iommu.c    | 37 +++++++++++++++++++
 drivers/perf/riscv_iommu_pmu.c | 66 ++++++++++++++++++++++++++++++----
 3 files changed, 98 insertions(+), 6 deletions(-)

-- 
2.43.7

