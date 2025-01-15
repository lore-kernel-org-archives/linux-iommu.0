Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119C79C8
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 03:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736910202; cv=none; b=kulhb9ARLCDq2/m/lLl23tFEnYLPJhJahPL5llutzsw7KlzhBD6KF6Ttx8h+n1Ji52wB7PFQQfh3YQx/dfksgVkCCE226imkY4Ewa++YUuPYFZixYR2XM7dencftUyyqlp6xGIfokgtpFa2pOF2nQPlsJEeqrBLjGwnhf+QW8pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736910202; c=relaxed/simple;
	bh=J+7jtsKu2tRuRVS3tA6yBe9xNlaXO9pu3YDC6oDVjOo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OkB6ZyocogquJYSL4pUs096yuZArRkGnYdaosWQGzbOIlfjUFGvjh1mUl6552Z8qOdpL/Tm7IE8YgXbrgCtWgsrDTr2IXfGIMLvibUsk/QSc3uFin1mVIzXxIUzeusdFuRsbUhdgoTn7/+bZGXa1r7UDNlI1cCFFsnCxtyd+gLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kLuDZWBb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kLuDZWBb"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163b0c09afso114207665ad.0
        for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 19:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1736910199; x=1737514999; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pFOsksjub0O6BKOG2DctEoxnB4foUbo5c3Iev//NN8=;
        b=kLuDZWBbeOgQ79XCQAGCjwPU0dVqeK1XCiiEXOn2uGQ/g6fXgsRc4pQpt+yF/zrkct
         6HH0NI0lE4u7Ej+Lfz5v8eYTmjhY7oG4NfvELMkK/mUqv1h816wFY/LQ5fuL7k0XX/QR
         JjWlZbIWvy+cbmcLkxL/ud3kTXOLFihvvTG33thpyT/INMXi/jBfgsGe6GEhGBAnkjLP
         Ifgtr0rxp9n9EhU8SLby2MyFYt27Pt2Jl9ovzrDmJGJtV+RLu6EaDxiWu6do87/6b86K
         i8B/svO4hzvK8MsRP1tca6ZtTvkdqARWYhPVTlaa6Fe3oTibUKAy2eZRu4QUPuWXEUpT
         YuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736910199; x=1737514999;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pFOsksjub0O6BKOG2DctEoxnB4foUbo5c3Iev//NN8=;
        b=k9uFwBSfdC1iUx3p5NnULuTy+Ew+XwRvTtNijRMNqmW/4NL3oTAc/N3qnHpEGgiis3
         UUg2xaf8hPFFxWfX7XWZyISdtsi1JE/m0Jp1jUNVPpSTYkvLXH3INprCPn8O//DE51Sd
         EEZ0ZyqIJE3ZYYqM/UDALXRWzdAK7m0oUvv9WBDBTRH8rTbayR9NtdZ2OLXxewBjZ184
         qzaU7GsFX301YQscV9cgFdMqo4McTaFh7HEFG1dKcX7RKuISsgIo/AOb6GdVUkr7AoNt
         QNaDAO90fp13GtZFh+LmMemA9vyNN7B4jmJ/C3VAprTXrmmy3nkORvGLqeIXxvrCorVi
         y4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXfT+ha+XhsBeP745UxWkkDdCJFM8MAGjco2cvzm1FQst515l21l2sVkU6xj6ttgD5Rwlx/qg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/IBiRSGEvbx4yHrJJvsBRQIJuBZ7ANV4hmjbmWgjB1WCtobGF
	gJdRuHRax/QzCIwNreNJNRVpcmNarAxz0MED+GjsAcelAlHVZRiQB435CJUupb4=
X-Gm-Gg: ASbGnctihjS6lASX39XySyoMZ1H6stcovGtSX7iMJ2XfGC+O3LvEY3MoyPlAgqV0M3h
	1pLSodp1wFnHuGn4xPzDei1WaLw1ObMpXz1/919ngK6sK5qzRJnZbCRPsB2+BUuIaVvUbR3JFB2
	s9MNxP4QGHwQJBYETYy9oLOJ6H8t4gHa1IzWP+/I1mhpX1oTBv7bR/UmJihS9kvGgnKLalF7AOw
	Mii9Y+ZwptwcCTbWcjyvVC6YaFQFV3xKt8pGYSDfzYd92BQRyStryW8KBG8+M/Gjyuw3xPEGHmf
	ujE=
X-Google-Smtp-Source: AGHT+IHW/OudNH8nKEGYTcmbRjkDHNnTx51q5XxoGDRShfAUh9zNbosxSEMnJSoL54yuXDXA3J9w9g==
X-Received: by 2002:a05:6a20:c799:b0:1e1:72ce:fefc with SMTP id adf61e73a8af0-1e88d11cb13mr49342319637.22.1736910199248;
        Tue, 14 Jan 2025 19:03:19 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40568dccsm8123668b3a.47.2025.01.14.19.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:03:18 -0800 (PST)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	luxu.kernel@bytedance.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/2] RISC-V IOMMU HPM support
Date: Wed, 15 Jan 2025 11:03:04 +0800
Message-Id: <20250115030306.29735-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This serie implements the RISC-V IOMMU hardware performance monitor
includes both counting and sampling modes.

The specification does not define an event ID for counting the number of
clock cycles, meaning there is no associated `iohpmevt0`. However, we
need an event for counting cycle, so we reserve the maximum event ID for
it.

The interrupt handler needs to be a primary handler instead of a
threaded function because 'pt_regs` is empty when threading the IRQ.
However `pt_regs` is required by perf_event_overflow()

Changed in RFC:
- Rebase onto v6.13-rc7
- Clear interrupt pending before handling interrupt
- Fix the counter value issue caused by OF bit in the cycle counter.
- Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
  in riscv_iommu_remove()

Zong Li (2):
  iommu/riscv: add RISC-V IOMMU PMU support
  iommu/riscv: support HPM and interrupt handling

 drivers/iommu/riscv/Makefile     |   2 +-
 drivers/iommu/riscv/iommu-bits.h |  16 +
 drivers/iommu/riscv/iommu-pmu.c  | 486 +++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c      |  65 +++++
 drivers/iommu/riscv/iommu.h      |   8 +
 5 files changed, 576 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/riscv/iommu-pmu.c

-- 
2.17.1

