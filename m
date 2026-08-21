Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55012853F3
	for <iommu@lists.linux.dev>; Fri, 21 Aug 2026 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279940; cv=none; b=pwtUZuniR6jnVD3UrFla5NsrY5ez1IWn5CJFhwlENeI+WIcai67XbEJtNiT8DsB2RRujzUQ/eAyBiGpdMwPGQf0iIYXEkgRGwkdsP1ZVc3rlh8EF2qBeT9N4Dha0lf08bLgkHH4gkLEKamvyspV4kNkI8qbSludGxhSKjUv1BwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279940; c=relaxed/simple;
	bh=UCt0vQwPC2jc9+Bcb0bUDcj93+uNUIs5VJCsC2vcVqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n0DYVP75N7ylkmcwFul59h1UzJYd9a6OFObtpGRqna6++4pV7wybnD8dHZ2Yv/Z8u0p3YpI/NzInNQiKdHX8sSMfeULWVER2zB2N3ZYfGJKryu3x8ZfzIIBTFd4da4M55LQcnDtkJrYxqPVmWrxgeTA9dQAlLMFs9yJfNkI7FXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Zbz4Bi20; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Zbz4Bi20"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cee9b74ee1so4198215ad.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 19:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787279938; x=1787884738; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0XQisBlmr2bHAob1EYT/0m2uyrfjgMQQJZM+u5d629A=;
        b=Zbz4Bi20n+vmV9AxvF1/oPnwGinC34IiFYp15553TjlcB/FRB4HpdseZlILZM/bsfE
         VfdzcAP+4nX2OVldUkieNp9wfgNhPqscbUeJlygib9VBYUa/SxIX5yyCzG2dU7Txqe3+
         15qrmtmP84oXOpbG8ycNtDSrihKS3jsbDN54hSWcc+6Fnzk4b7XyPtZTjWYCgdz7fx8X
         8Y0d1/gAOGfYlJDkjAT2zz5+nIoCB5D7IC08VFoW88QRnHmz0SbIsbEWpmTx35mVJ18u
         5pLgJLzFQNTxhHfFLKpKEQXZOL9YpPCBjsYwEWyVCVKtPxhB0M45pE4g8F+pvk3dVY05
         TPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787279938; x=1787884738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XQisBlmr2bHAob1EYT/0m2uyrfjgMQQJZM+u5d629A=;
        b=rmDhl8RkPmAY8wY+1rwcvmQo2z0aEv9+0rAsMZtznOBOL66ORQTX+7LD9AqKec7S7G
         YNSdEEOIZIgGa79cli01Z3/5OgdWIn5a7skUvduCBTUnxCneg9gIaP4oFrMZvEmr8F/X
         U1FWnEJuuy8wbPUwjFpmS8TlAWtzRbacvI9VPFbJ1HIq6Wk3l/ZNVFf4nd9zhLQiiRkP
         XA1DLQzdPV4N0LCF4uD8a/sWc6gYZbYNGbc9Jmhh4hvnXVdcE9SlFc5jMnvIUrBkLzV1
         j/t837F1KXV4/smJ5Ud4rD088ucymn6cxUUKOeTKOPkIIu4BD9sXIJZ+pHKUZn06t+9F
         Yc6A==
X-Forwarded-Encrypted: i=1; AHgh+Rr4AFxbGXFDP1KaEcks6KuzeaBz5Yo6HUaxU5zlD6nvLA/wZE9AJlLjOC7q33RKa+3gsfsgSg==@lists.linux.dev
X-Gm-Message-State: AFuF++n4tQ0Z6W09d8YNrXkVxv+VSzbHV0lkJ8rCLvXJOs5el60bJP3T
	VjrF84HL5btRgKxypRbFzbPj2PydtBbRvaOZt0OvUYQhDnR+L1NsxQAQo6Liwqq7Mhg=
X-Gm-Gg: AR+sD13iOO2ijkAWaO7Jmao6CLtuD3084+6ixx9lWYxmQSJijvIOet55PyJ1af/z9pS
	RJR4UryRbRXAbwK5SjhhKSxuO1kh5O8HsBxlsmlpZT3nBuseQB5rQqABBxBY1hapSsKRb8r/J26
	WBpi+mFNcBhp06VJyvCzceV+y5gZ0WPp6V+DYXhbBDP3yQXIV1l+Mar1ol2mZ3fo4FYSIUM8ZrJ
	S5mIWFeI4gqknJK9AGQjYET+lgCgl8LKXqrnrNydEQEijwxmlR77jzNH7w2z7RlGJ+6wZrykbNV
	M8XwHnRLhMWc9lmCj5YfiWvRVQKOqyePtWiIzO2vFFFlFpf/8Wuadnzjf9GT3sE6l27FP0/kLvT
	vKb0aAAan24iwliHIRQQpSf42b9Oh00y7NaIt8IefO8OzMayg6OrnzRvjrFp6ZJKFBM1YNS7vky
	JBCgTEVG1eWYEIwd80eS+QnA4QaNjIcO2mrrtCDzeSlfCG5E1ufZQuPYhWdiPY92BJ2Q4GmG8L
X-Received: by 2002:a17:903:22d0:b0:2d5:cb05:49d9 with SMTP id d9443c01a7336-2d64ade785fmr48981615ad.5.1787279938105;
        Thu, 20 Aug 2026 19:38:58 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10b584sm35370427eec.16.2026.08.20.19.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 19:38:57 -0700 (PDT)
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
Subject: [PATCH v5 0/2] RISC-V IOMMU HPM support
Date: Thu, 20 Aug 2026 19:38:51 -0700
Message-ID: <20260821023854.2746349-1-zong.li@sifive.com>
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
 drivers/perf/riscv_iommu_pmu.c   | 758 +++++++++++++++++++++++++++++++
 6 files changed, 809 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

