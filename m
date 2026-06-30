Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4F28C037
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808720; cv=none; b=egfue23iaJ+i00QzcDmz4an097rBalGHRpvV+7rWICxKTgH7X4ksvPynEFvSJhQndr+mQ2cc/fBEpnrrBrltgd+JEoFbWupMCb+UBeLbVX5cTnmkTeVGTB9Z+b2x9g6AlD3Hw5DIv4T6PRYBShivKWPAz8OkSjcSfH7TNe+GiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808720; c=relaxed/simple;
	bh=9AiGGaUHOh2C6AJyqb34e8YM2g4s5YiIRtvd0EhU/V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDFIiRcVKso5KDz1vFiWrlBvE2jxuZf5gLSySah1gIrUW7KHfqWWduInxuDXwTmk18hrp3xtnAw1Ki4HiavS+zBYONmtym3jYSOVxlDtHsOKURhpav62NwcxwvZuW4fYNBNRb3A9ql59ABCtON4pYmW1zwVbA9Qed0GFbfycQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=W6+6+hkL; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W6+6+hkL"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30c944aacbaso4601090eec.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782808718; x=1783413518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pcbh2hH4jKecepaLWhXNqv0o5ONWwPeeMm+RS/NEOcE=;
        b=W6+6+hkL8pnnuNbtUdfb6a2ZUUd416ModpDib0VvcO+yJq/aYzLDKVLvJQhwqqxjeM
         R7RMr5Ix4JHQYWcKIMg6NLNGS1k6O9Kj/9qWyaTokOw0vyDcAsCInAZrul5cI4UqHscS
         kMr5wc8O7szCkSqoSSfFvvoF3SZH9p8purzyreFO9FE2zdekprZxj374qi306wo14Mxl
         tGwWFekitn37LzrtMsPEJXoAf5/vG5D8KmTtlVFLIxLzbOZSgfM2j4vQrP1F96jA8LLz
         b89Me6ZDlW72zgNFxBSe7vlMa7ROfWw/HcB8npidwaHJbloI+K5stvKczQmllstzJVES
         ljYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782808718; x=1783413518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcbh2hH4jKecepaLWhXNqv0o5ONWwPeeMm+RS/NEOcE=;
        b=HF9cWhrkZDDAZRNCscYrWwFRApQWtT8ZioFzfofZvxmfbN83Bg2t5qaVGj3iXhsNqi
         DZUAdp7GljQh3qNYidbeiqO7s57jQGjvyPf1jDNobFYGekc+l7U7DPyfjP7IkNm1lCNH
         TvF6svzgo8FkbMzm0y8BgfLtTEVrjikDDUODptTreLn5tUJLywwwHsggSkcaLduxPANL
         ghSaOiEIqXuJqtjsEsFkDAtNiYqcltERjHvGdoRbCwLZwPw1EdAt5IPbUR912hG2DVEP
         DoyuKDWsG3svqismoqQFlUm51BtAwGiwYpk8OuYM+fpEFFr2hVi3UhzuHVA0jVzHbo76
         e8lQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIUvQ+zbWO/6tqeS+IdblLYtxkGj2kKOMAA2h0PxknOy2txgGoxdGhV49PM/waG0SVXH/E2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyutM1CrZeXU66UVHTLlzbqEX8UhnaHgV4VP6uKZjxK7grlmwMa
	Jj73AhxaUr24GkiNWBMLz6yZ0VnT99niJnLbT9xcxoXRNm299PRWlFZ+KGunt8KcwJk=
X-Gm-Gg: AfdE7clJQAaBWF6+EqbaG8HZvfz335CjISPi1mBZaf0PAbWm6iNDqVHhar1O+tKdcnR
	wtNvjxmKi8nFh+39FYcX4UvsjeVeLzMlx6wQiTTswIoqr5WYfoAhNUYlut+F0x+uDSujyWzK1YO
	7tEe6n7QtVJLp0otDRmK8l7SxTAXNIvZa5kiunyE8rirIEI3rnLxs8wBnkXS7Giw2A7juCLOswM
	/tdINlzgCQ9Msqp+XE3bTGJYpjnDCbPEiXMcp7AEh2lsiUtyLFdcao9ryq4GD9EN/29T8w2SELF
	yY0IApBvxjtXShT7MFfwaWTiajKVlR2AwCzYWtcwSqwsSOfcpPq/QROhOIOA5cdpaKap7UhN9J9
	2Bd9kBUq/8y3Lbl1qPQY5UhQoUmDGs6TKrYh3xjtyuDJnLMdiWwoxsdqoAkSVYlzU542L1zo9NI
	DWkm+j07sIg0d7sJNjnieJV1kIAoLuUrzRCQ0=
X-Received: by 2002:a05:7300:1824:b0:30e:da5b:2725 with SMTP id 5a478bee46e88-30ee12c0a42mr2097408eec.6.1782808717684;
        Tue, 30 Jun 2026 01:38:37 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5aeb0sm6756444eec.3.2026.06.30.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 01:38:37 -0700 (PDT)
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 0/2] RISC-V IOMMU HPM support
Date: Tue, 30 Jun 2026 01:38:05 -0700
Message-ID: <20260630083833.1275837-1-zong.li@sifive.com>
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

 drivers/iommu/riscv/iommu-bits.h |  61 ---
 drivers/iommu/riscv/iommu.c      |  19 +
 drivers/perf/Kconfig             |  12 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/riscv_iommu_pmu.c   | 703 +++++++++++++++++++++++++++++++
 5 files changed, 735 insertions(+), 61 deletions(-)
 create mode 100644 drivers/perf/riscv_iommu_pmu.c

-- 
2.43.7

