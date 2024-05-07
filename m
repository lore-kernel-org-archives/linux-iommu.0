Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2A15EFB8
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091968; cv=none; b=GZVxMgh6+lujEis5542OJmNFnexxzuSw4zrazS80ld+iY9MNJTWPh/Fm8x9FHG1T47mhFvjrKIKngT+cOt2FKecU8I8gOpC+tgpfKzOE25rGjSkdWbdEOpWwTH5bc+C+zUtjtQ/fmqaWf/DMLOxbRpiGly+F2vwH3iKduE1/7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091968; c=relaxed/simple;
	bh=3kMEdbIdgG0v4HUHY9kiHl86gb8P0atzgdn4djrB8b0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZvHBAICsOlOXlGniL+JAImsQ6RjgQ/OrE3TBaqs5LcIV7p1tUHXEK3oYztLo9xTBLTB+VbEeMc+iiIhPgjkXct7jLabEzr0KlnjkYcIV65hp1jFf6znrsauj5Eo2Pxw+9UQfWTyJ2Z3w2jdBjzYhirSeWwlXVsnhlY/RXdhdQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AAUf00FB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AAUf00FB"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso2008234a12.3
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715091965; x=1715696765; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkGvtX4jUwYRJLbDOy4RLI6M69O2g7lMQEi2Kh6V+XU=;
        b=AAUf00FBEuXgqs6vMZgC2cZQN3+DV538bZoU2Gxry+1HU1U5NjBfx64ASTshj5YWtu
         TyxDrcfxWbju+q8/bE68bmjg51Le2M6WZ+YQfex3zsEUWeXwviXnFU8RoiNQ92/IfYnU
         O2ctT0YY7RnL6WW8imeb4w4K57D5IPS9arIm0Q/Mk+1vO0+YB0n1/Di+9QvoRcE9eE93
         m2dqG6EFrqHlb+uyDY+55Os8GRVSTDYb5n4HbfnI0NCELahMZn3s8rfC/8xNN7BusFwV
         EYpdvYY1Bx5Z+HYu3AxkelTF1c8+DzZ8IrOFvE/dPk+lq8/+27S+DUwp+EzJp6KkEvcc
         72ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715091965; x=1715696765;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkGvtX4jUwYRJLbDOy4RLI6M69O2g7lMQEi2Kh6V+XU=;
        b=A41ysNiiCh1A4svtYoejlZT7QImlVTdrw/6qPtmS9xICxGaCOlKsy8tmscW/96mMyt
         Aj6trIkee7BBj3rQ3S5LMjUe1kS9dEt4DLSky6aKDbDSF3HWjkuoVQSY2uTIRNF7xn7h
         fXPHWaqq1IprnUi1GgKsL8XoX1WRzCn7zUF4JdbaxEkt851Fp736jTnkH9UJscWbmTiU
         dDmvsyDqarxZz+wsIm6LLqirokHAB4tSYD92qdD/aWc9WSdKNC6ZBr5O8xC7HMRhr7gZ
         bPEi0ZsH9m9gsZ92tfw015Q47hJVSokD+hRvZ9xeB5ltDi4TRd/a2TvDTl5ApREGdAXL
         5O9g==
X-Forwarded-Encrypted: i=1; AJvYcCVte+HLOyxfg5mR30mla0rA01B7bM7weCvOo7C7Oltl+824l+CPkjLYdow28SXxzevCBJ99bPh/V+SMoXoOW5fRrLa/y6c=
X-Gm-Message-State: AOJu0YyA3NAjZexYiGsC/HWGzsfczndacZbSf2otbkOi2MUT9iKYMCKW
	XWKUuja1fsGgSaWGHCmyPdC6XdUu9e3TA1ekZdpLxNTcStr7hI+cPKfnaIUpb7w=
X-Google-Smtp-Source: AGHT+IHfG907D2ZaVYbVRAYvbH+/piHHBre+FsyAhb2B6a1VTqojpliLbTmA9dXHy0VdebudgPk6cA==
X-Received: by 2002:a05:6a20:914c:b0:1af:a4d0:1614 with SMTP id x12-20020a056a20914c00b001afa4d01614mr7766162pzc.6.1715091965553;
        Tue, 07 May 2024 07:26:05 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id i22-20020aa79096000000b006f44bcbe7e3sm7687554pfa.201.2024.05.07.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:26:05 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH RFC RESEND 0/6] RISC-V IOMMU HPM and nested IOMMU support
Date: Tue,  7 May 2024 22:25:54 +0800
Message-Id: <20240507142600.23844-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This series includes RISC-V IOMMU hardware performance monitor and
nested IOMMU support. It also introduces operations for the g-stage
table, which are required for nested IOMMU.

This patch set is implemented on top of the RISC-V IOMMU v4 series [1],
and it will be submitted as an RFC until the RISC-V IOMMU has been
merged. Additionally, it will be updated as needed when a new version
of the RISC-V IOMMU series is posted.

[1] link: https://lists.infradead.org/pipermail/linux-riscv/2024-May/053708.html

Zong Li (6):
  iommu/riscv: Add RISC-V IOMMU PMU support
  iommu/riscv: Support HPM and interrupt handling
  iommu/riscv: support GSCID
  iommu/riscv: support nested iommu for getting iommu hardware
    information
  iommu/riscv: support nested iommu for creating domains owned by
    userspace
  iommu/riscv: support nested iommu for flushing cache

 drivers/iommu/riscv/Makefile     |   4 +-
 drivers/iommu/riscv/iommu-bits.h |  22 ++
 drivers/iommu/riscv/iommu-pmu.c  | 477 ++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c      | 481 +++++++++++++++++++++++++++++--
 drivers/iommu/riscv/iommu.h      |   8 +
 include/uapi/linux/iommufd.h     |  39 +++
 6 files changed, 1002 insertions(+), 29 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-pmu.c

-- 
2.17.1

