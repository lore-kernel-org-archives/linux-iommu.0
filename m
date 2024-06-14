Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E76DDAA
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374927; cv=none; b=YG/YJm5/Jv6gaYMNDqqFsFi+midisbONJZK4pZhO5P4n5/DjdQKbD/KpxtYyC3CjQBaepCBhcBMkJFaP+G6Adri0kyJakiqu7Z6RYM4PMAkhlKsL511K9XTsL9F+zl9k2yeAantlYO3yk4hL2Y9u493yHzXqzKGJs3wK1J42G1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374927; c=relaxed/simple;
	bh=kB0azTgKkuVGVw33hGW1rnAxLMPrkox5uErZehXfzkA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YZkZH7Ri96pP3FGZLWNM9V52CBp6CPgn0pDtkVmxReeJH3OHx3nOvdooW080lRCdlmGL9QYpuLPzsrcmOWPKAttzI6etkxQzxQULWeVhtHhvI5RTUy01rKS59W6rOnagFA/rnC1pkFCvcccXWsqIfQwfujJ0deffPAiPPU0Qrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nk5sAJxN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nk5sAJxN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f70fdc9644so25403965ad.0
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374925; x=1718979725; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIgry4ZlTdfYnxRdys2JHwePBLV3NAUgUfJMeam51TU=;
        b=nk5sAJxN79DYY5qINJ0JQ2+W03F87GX4FI2ina5Ukn6ofGQYyGV7f1RNuD43dselqo
         9xnb3/9715UKAZzCW3g7hH/qVtTAvQT3JRuqaPJpILmoeA19IsA3ak9hT35c73diC1Ex
         8v0yUgd2Qvlj4i22JePYjt1LqiomU56MVecW1RY8AB667V81E/eZcyqdHcny5xbMssNo
         E42ABzdauSo+lUoKukEhFRvL+stIMmj/LIxjsgV9pPj46SQgg2bFtud9hno9vsT5J5Ze
         WkFz4kUqOPzpww+ZqDWabcYxkaXjOLulrAN7oxd+U8qeeNPUIlhK780f7LPo7ywCFMQu
         V6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374925; x=1718979725;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIgry4ZlTdfYnxRdys2JHwePBLV3NAUgUfJMeam51TU=;
        b=uLYkH/kACGWVm/5XkQ8RlZkk1DhG3bghsVvHVEbok52zK2muG4L9JYp0AbjMIBCDYN
         qNjjA6PQSlBHWI97I8Ie9zHHu1WWGkojAqaZpfyvhKx+lW0UCYbJcRZ9tswo5BHIwCA3
         +wfQukdmROs7Tpwdv8qYCkfU2uGwRS6KGW/KdOcVu0bNDF3wXy8JtsawBnq8o+zZD5fb
         UOS9+pUHU10eSPUpPAQ/lFdwVUTuwExdcYrnTTe3EO8QncLsO7mNkCclzQLH+M8y/AA4
         KBiAWe6mkPParoVHGaNd7HHKXghHbh4Zbo6bd++EIc1KMqz7Lw6fWeyC0g+XICB1NPBc
         3aGw==
X-Forwarded-Encrypted: i=1; AJvYcCVD6Kd6P6TY63jZq57tIxx21258nJrAyOAnRcii5byfxwfvzQJuVZDqEkuJXXIyqVcJGUdHhUXDYNkwDESaTYO9dlq9PyU=
X-Gm-Message-State: AOJu0Yy3wWqCH/mi5hg2/u451KbyOw3J3H4TAGBe7RNIPbnb7JVrIKlz
	hf68MyHamyy1EzKEwIOYUqLchvELk535cUMC1OSquT2mcv/6fYDciuvjYq9ZU/4=
X-Google-Smtp-Source: AGHT+IEVsMcS6+7wufPf6Z6lst2MBU5R+h9CJE7+OjLz9j0eS8xJzhCtKfTAGpUKzPFSFcnOw3bIlw==
X-Received: by 2002:a17:902:ec92:b0:1f7:9a7:cd33 with SMTP id d9443c01a7336-1f84df9b5admr85978835ad.3.1718374925217;
        Fri, 14 Jun 2024 07:22:05 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:04 -0700 (PDT)
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
Subject: [RFC PATCH v2 00/10] RISC-V IOMMU HPM and nested IOMMU support
Date: Fri, 14 Jun 2024 22:21:46 +0800
Message-Id: <20240614142156.29420-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This series includes RISC-V IOMMU hardware performance monitor and
nested IOMMU support. It also introduces more operations, which are
required for nested IOMMU, such as g-stage flush and iotlb_sync_map.

This patch needs an additional patch from Robin Murphy to support
MSIs through nested domains (e.g., patch 09/10).

This patch set is implemented on top of the RISC-V IOMMU v7 series [1],
and tested on top of more features support [2] with some suggestions
[3]. This patch serie will be submitted as an RFC until the RISC-V
IOMMU has been merged.

Changes from v1:
- Rebase on RISC-V IOMMU v7 series
- Include patch for supporting MSIs through nested domains
- Iterate bond list for g-stage flush
- Use data structure instead of passing individual parameters
- PMU: adds IRQ_ONESHOT and SHARED flags for shared wired interrupt
- PMU: add mask of counter
- hw_info: remove unused check
- hw_info: add padding in data structure
- hw_info: add more comments for data structure
- cache_invalidate_user: remove warning message from userspace
- cache_invalidate_user: lock a riscv iommu device in riscv iommu domain
- cache_invalidate_user: link pass through device to s2 domain's bond
  list

[1] link: https://lists.infradead.org/pipermail/linux-riscv/2024-June/055413.html
[2] link: https://github.com/tjeznach/linux/tree/riscv_iommu_v7-rc2
[3] link: https://lists.infradead.org/pipermail/linux-riscv/2024-June/055426.html

Robin Murphy (1):
  iommu/dma: Support MSIs through nested domains

Zong Li (9):
  iommu/riscv: add RISC-V IOMMU PMU support
  iommu/riscv: support HPM and interrupt handling
  iommu/riscv: use data structure instead of individual values
  iommu/riscv: add iotlb_sync_map operation support
  iommu/riscv: support GSCID and GVMA invalidation command
  iommu/riscv: support nested iommu for getting iommu hardware
    information
  iommu/riscv: support nested iommu for creating domains owned by
    userspace
  iommu/riscv: support nested iommu for flushing cache
  iommu:riscv: support nested iommu for get_msi_mapping_domain operation

 drivers/iommu/dma-iommu.c        |  18 +-
 drivers/iommu/riscv/Makefile     |   3 +-
 drivers/iommu/riscv/iommu-bits.h |  23 ++
 drivers/iommu/riscv/iommu-pmu.c  | 479 ++++++++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c      | 492 ++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.h      |   8 +
 include/linux/iommu.h            |   4 +
 include/uapi/linux/iommufd.h     |  46 +++
 8 files changed, 1054 insertions(+), 19 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-pmu.c

-- 
2.17.1

