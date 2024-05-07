Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8414EC64
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090865; cv=none; b=glvpOgSiLcZ3Cyygcbaw0PCV7OQ5NLKlsht/3WEixYdPNTvxRtyMRQ1GRmiE5cCwTFsZwXBLMe8y7ijWu2kbOzBpH0npb0MUwFqToicVUsTBq7C4mtd+kQ1lQg40FSp81gkNbl66yox7ICLebPI6sNuqqD/4cbJgcMsmidq65jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090865; c=relaxed/simple;
	bh=3kMEdbIdgG0v4HUHY9kiHl86gb8P0atzgdn4djrB8b0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cU52Lp/1/EqV00/5ptw0GJAr0nKiUL2kwRIYc32NE3UEE77ZRpeY47QK2o6IJxzL+IoltSDidDn+eu5g+BNG7iaZa70WoHMuBTOmopVv55eCPoTIa1M4AyatXfPrcrTIYyPEcTDkeBLyO7emofx2NyO5MBRGjbNh4sVITzW/nmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VdRg/1+t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VdRg/1+t"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e65a1370b7so28728945ad.3
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715090862; x=1715695662; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkGvtX4jUwYRJLbDOy4RLI6M69O2g7lMQEi2Kh6V+XU=;
        b=VdRg/1+tYAYtkvR0iIo4LX9yH2ZN71XSRxiHSZvyJRzv6YEz2fhYuwW3z1GFubi+uW
         lJy8GaPPHx/FfnZVsHZGeFFXVs8FCHGBSchHu6EsQF8UXMW8o67mtmasoW4mVndZLEUU
         bxT8jnwx2eTGQj/yQkBkHHX3xL6YgCjSYFFsVlQJ+qPLXjVmMKqUuIzqk7wiflUwNJrM
         v1RzvZCzqioJjegujdbrE+4gu8oxSj3Qu7XeqCB1tRsJJust7ic17B7LtaMMuOo6fqDM
         YWGamo5N27Iv7GTEQJckQOl4ISPRDFswUvTm3c8M9ESQuZ17QVZoI9Eoh1wd+O4ppZCp
         Q1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715090862; x=1715695662;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkGvtX4jUwYRJLbDOy4RLI6M69O2g7lMQEi2Kh6V+XU=;
        b=YABJoCLW/r9K4oc7WXm3znuBRhA/tVQY/KnL1fMlc6o1ue3gl6xZ9iNikGKimwtlFM
         89gfRZ5/Pcm8TK0MnbSuos5qwbH6okxv4TeUOcGC0AwgBLhDthmw7pvL9Gq4MQNwPkfb
         Em+lVnhJhqZrPH8/JbtERvXn1494ClznBuZKHCXw4QzUIJx9ga0tk7lqxY9mJaNw9me3
         QoECdFXYZgclxwblI49GPUtb+F5Cb2Ntm+s/kjoBMm1tc3irVdXec9S3bwvbTArWGCy1
         9Qasn9WCOyctGu0xI9SLxW82kJs/7BtaRF5u3lSd4hi/RDXLOgF8bPLGNLKX9OoBXWV7
         ofeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxGE2vhWc3/SnI5oDxaW/6xYsmz5nSPtBwZxTbgAHF4TXxJhOoitkLG+ylLaNt4QGERbVwZ89w+SbUIDq6V8/NoYmBpYM=
X-Gm-Message-State: AOJu0YzdhG9sKUkKNUBn2Y1jFlLTGclSqe9+m40rms+ICjtPmA/hmgeL
	YX6p+bq/Uh0oD9SUepxrrIys/lvulPm9vhJQ1xvQ3Idfca8LN6SNWVhWwTV6/q8=
X-Google-Smtp-Source: AGHT+IEZquwWePQ2daUPDLBtKy+IdyRf8hFqcaeC1wV3eDUCTRzWsQMIJUGo2E2KSkbpK4Iiw+UIPw==
X-Received: by 2002:a17:902:e947:b0:1e2:8841:8d67 with SMTP id b7-20020a170902e94700b001e288418d67mr18129070pll.32.1715090862451;
        Tue, 07 May 2024 07:07:42 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001ecf8659bd7sm10061883plh.257.2024.05.07.07.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:07:42 -0700 (PDT)
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
Subject: [RFC 0/6] RISC-V IOMMU HPM and nested IOMMU support
Date: Tue,  7 May 2024 22:07:31 +0800
Message-Id: <cover.1715072254.git.zong.li@sifive.com>
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

