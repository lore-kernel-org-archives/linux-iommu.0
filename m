Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8733120E
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788833032; cv=none; b=E4hQcwOvohRAOSL8v6LENSv6hKICyy4SxfXyxnRe56WYa/E+bmZYxNMEczn1LknPjt4b/JEfCiovTSXDi6EHA6qEUs/I6ki63HvidQUKRQvn+FYU1gPXhJ3gcILDWkm5TUZa8AEFecw8wclXftTFOt0fkBozaawGV/zoJUe8sU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788833032; c=relaxed/simple;
	bh=hkNBN9MPkujzZCQBNuREYqDEx5xQUO+uRRcICqKbhAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZWVcDcH5KROIdOS5z8infEp2H/EXDrVCei6L8HA31JXg16/+tJCOwOGhYj72MMqj7Uq9L/iJd/pmf44QxV8evJYGZB058fD8ZfhWx3B1b/RUiF/CNORKBpDiJ+rHPy55enErPeRX32VjYqaT8+8Q+uGt2/tIV30I02MIau8Ch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KaChMG/y; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KaChMG/y"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso3256039a12.1
        for <iommu@lists.linux.dev>; Mon, 07 Sep 2026 19:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788833030; x=1789437830; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E3sMw9iwve27Y2nH1ScSWttLx8rW++NN1zuHxfgNDdI=;
        b=KaChMG/yZ51Ghodl7+52SoLT8oZrmAr5CJR66iCp36uThpt5K3VWv9bGG5o8sW00Be
         o+ORMAZM/N6F1/5M1tHujSBiHMQRF6Nfl+DiTiNXjyzqA1jVH/ySaqDXhdnHuCrCWKu6
         guw3BcoTHwJgmaaAO24mvfR8d8EYfp1j4Ah7khYbSAsDrawGcua3mL1NWr410HQNDx7G
         JLChX70GtV/gtA99BLPudIM5CZTIYSr7vs38zkRNiWLOiAwq/+LUOafkAwZ2kZ+Q3U08
         ZmZvmet3HGm5XXuVmmKHBPCCm0C380To/yYvgjiHge3waO7fPNAJ4Y6ydSSgYQB7LBjZ
         j5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788833030; x=1789437830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E3sMw9iwve27Y2nH1ScSWttLx8rW++NN1zuHxfgNDdI=;
        b=VTyCjnsGc9cAR53+vly45G2zkQ2XhArWSVYXYgFHNn0JBR+SHdbt/Zqdv4OFeNT6sn
         lh+muH3G/Am3ia1Jjfl4MdkWAnCWsFMJyyC/eQKjmotmebd07mRbdHqRq9mX4cYMg4pv
         pfRzANBB1bsnUbdpxZUbAxAI8DBQD48oTGACl5B/8AwZCeqtPfmK6h6+V/2eRV8e+bqB
         M3FEV0Ef16Td28YUrqSnu/tq3XMz/bSk8Ynfuk8KG+a2YfszueUcGjpZxIlu7OhiRUEI
         CsNsjE6MKVEk1B4ww+cn8Vhy2c7d1Wh4QBTa3gQX18TYaioYtEmjuglsezvAiSU8ILUy
         Tjgw==
X-Forwarded-Encrypted: i=1; AKwUvBy2VVSGqAiq8S040OfNRTocuIYtDhndmqge5lfebupmeGFwu/6opcEQPPDX9IHfFvFJlZHFxg==@lists.linux.dev
X-Gm-Message-State: AFuF++n61lSGOorwwVaB8Vfjf8ArALCAiM0GU3cZwwT8DtUEyusqxsyy
	2RrkjMi5F4MjutqOPD4OMiroHV9gcd/5k72gf9l/MdSwXqkVmGcvUEyJU8nj3pUYjYw=
X-Gm-Gg: AYBFou0UKHeu/SZixkXV2ZRp6J+vMziJue36z4XjD6an3RddVLOzyNT3HCPOJpKgdHI
	iP6iQIcf60uVzpslWs/oYl/zBA8DfOaILQeydGzx7xXFEVyOkdP5jVNiK46iJxnAv1UYaW/apj2
	HZr5TPAWniWDEtIU3+HQ3fi8JfpD8cEtzjWMtcxMZXX1TgQ2GIg/NKM4EivWE0LrO34k9/y+jxc
	/bNqgAV5Wco47DmSl7GssiwA74JnxWKpZUzRy2QHiyRcg/mnbcBoIArvs7YYLQFK3bXhT6o5vlO
	isfWC1nmIpt7hG2e9PedBTe6ba+GjkbIXsgB1GssvfwESwd2BidZ1m2ZVU/9kiVFfBkk3/BGigr
	6kMojYR2G1sNLYsECcHxNkgPi4KNzFckkQT32iNFxqo2FIxkPIPqHBBlm8mbARbmKnBecRj7dMG
	I2gE3+Xoi+HcSVVsckS16mwsCyYZfoHtxjSRUpjh/g4XGPjKytCiw2ihL9JRMWa28MN2DS4ahPC
	u/rW2KKHWw=
X-Received: by 2002:a17:90b:3944:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-39b261b19d9mr43841330a91.14.1788833030494;
        Mon, 07 Sep 2026 19:03:50 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1434c745a09sm893671c88.7.2026.09.07.19.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 19:03:49 -0700 (PDT)
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
Subject: [PATCH v9 0/2] RISC-V IOMMU HPM support
Date: Mon,  7 Sep 2026 19:03:43 -0700
Message-ID: <20260908020347.1836653-1-zong.li@sifive.com>
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
 drivers/perf/riscv_iommu_pmu.c   | 1020 ++++++++++++++++++++++++++++++
 6 files changed, 1071 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

