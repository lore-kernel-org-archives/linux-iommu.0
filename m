Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5A537ED
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="g20Nn9gN"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67a894ccb4eso4343236d6.3
        for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 12:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701375308; x=1701980108; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=X5AMqGJYt6SEyyaxLyp7JmYGeHIyK2cLcP93CB0xsAo=;
        b=g20Nn9gNKCvhzWpvF7IIoayJU0dS+Pu7iksh2f/CZCWUgxawHi8Wrd/cT4rJeWywJW
         GaAnjcwwdK3yeflRLQgAh1l0xGev/h3kZj8lnBM1SbMOEDVRyFxx6hlIttkufC4dWo2Y
         L/XnyaOvE6uebCaMyWYlAZG6qJR6Fe2ouGrIFU9ld5K8WoKMqMOU/nMi8Cy9XeezSX+P
         8GQL68SmhYeoXqnm8Qjyhkez7KM1lgG4p6bM13vHauJfSwhojagcY9Fgx9Y7hUmUjeY8
         D9PqHEXGSV20QJfnJXnfq1sTJQH43qlr0r7FOYnWLIb8ehSS5EbvfGDXumX+jNczGGbZ
         ssPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375308; x=1701980108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5AMqGJYt6SEyyaxLyp7JmYGeHIyK2cLcP93CB0xsAo=;
        b=UdXVCOGn3JDyMrgwuTSZNJxsuOedWsKdULgXrNzQ6Hln4Q1R1CDKvD3spX40fv+7XW
         V5REjJdedDnvI6ehZPlvCHQHwv0f2Ga/5O2PsWZf1NcPYBf6Xp9mUmChROgQzSRHqPn8
         Nt8rAjkRRM8sdeVRjJZECSa2teKUrVSxIz1LrjGXu5BHFYjHW8hMeh4K9WmGhjQqAxYl
         QB052NViWMC7igludwdHLRAXS1FOkhjBhTnC6FIia+WP2H1PwBA7NQAsKwVXJ5DDnFXS
         2Ns956fB2LdGFK3eOKnbV1zWQYMiV8hkRziI9W93Dc3Nrsk8jGxKNjIqD+fUOJg/bO06
         IU8Q==
X-Gm-Message-State: AOJu0Yw0TPsAmOLMuR5gskTahC+YrP8q51uyuNIKObKmrQ93/HETXx9A
	SzxW4gdhJeRFratiyi5ykPcYzA==
X-Google-Smtp-Source: AGHT+IEJXctu9WcvSzFXt39rV8QEM3y7T1pFE0WiGQYLYtGfkA61KyCWh7Z0c00L3koHxXYwUBpejQ==
X-Received: by 2002:ad4:41c8:0:b0:67a:45e5:4aed with SMTP id a8-20020ad441c8000000b0067a45e54aedmr13542036qvq.21.1701375307954;
        Thu, 30 Nov 2023 12:15:07 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id e1-20020a0cb441000000b0067a35608186sm795252qvf.28.2023.11.30.12.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:15:07 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jernej.skrabec@gmail.com,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	krzysztof.kozlowski@linaro.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	m.szyprowski@samsung.com,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com
Subject: [PATCH v2 00/10] IOMMU memory observability
Date: Thu, 30 Nov 2023 20:14:54 +0000
Message-ID: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pasha Tatashin <tatashin@google.com>

----------------------------------------------------------------------
Changelog
----------------------------------------------------------------------
v2:
- Added Reviewed-by Janne Grunau
- Sync with 6.7.0-rc3, 3b47bc037bd44f142ac09848e8d3ecccc726be99
- Separated form the series patches:
vhost-vdpa: account iommu allocations
https://lore.kernel.org/all/20231130200447.2319543-1-pasha.tatashin@soleen.com
vfio: account iommu allocations
https://lore.kernel.org/all/20231130200900.2320829-1-pasha.tatashin@soleen.com
as suggested by Jason Gunthorpe
- Fixed SPARC build issue detected by kernel test robot
- Drop the following patches as they do account iommu page tables:
iommu/dma: use page allocation function provided by iommu-pages.h
iommu/fsl: use page allocation function provided by iommu-pages.h
iommu/iommufd: use page allocation function provided by iommu-pages.h
as suggested by Robin Murphy. These patches are not related to IOMMU
page tables. We might need to do a separate work to support DMA
observability.
- Remove support iommu/io-pgtable-arm-v7s as the 2nd level pages are
under a page size, thanks Robin Murphy for pointing this out.

----------------------------------------------------------------------
Description
----------------------------------------------------------------------
IOMMU subsystem may contain state that is in gigabytes. Majority of that
state is iommu page tables. Yet, there is currently, no way to observe
how much memory is actually used by the iommu subsystem.

This patch series solves this problem by adding both observability to
all pages that are allocated by IOMMU, and also accountability, so
admins can limit the amount if via cgroups.

The system-wide observability is using /proc/meminfo:
SecPageTables:    438176 kB

Contains IOMMU and KVM memory.

Per-node observability:
/sys/devices/system/node/nodeN/meminfo
Node N SecPageTables:    422204 kB

Contains IOMMU and KVM memory memory in the given NUMA node.

Per-node IOMMU only observability:
/sys/devices/system/node/nodeN/vmstat
nr_iommu_pages 105555

Contains number of pages IOMMU allocated in the given node.

Accountability: using sec_pagetables cgroup-v2 memory.stat entry.

With the change, iova_stress[1] stops as limit is reached:

# ./iova_stress
iova space:     0T      free memory:   497G
iova space:     1T      free memory:   495G
iova space:     2T      free memory:   493G
iova space:     3T      free memory:   491G

stops as limit is reached.

This series encorporates suggestions that came from the discussion
at LPC [2].
----------------------------------------------------------------------
[1] https://github.com/soleen/iova_stress
[2] https://lpc.events/event/17/contributions/1466
----------------------------------------------------------------------
Previous versions
v1: https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com
----------------------------------------------------------------------

Pasha Tatashin (10):
  iommu/vt-d: add wrapper functions for page allocations
  iommu/amd: use page allocation function provided by iommu-pages.h
  iommu/io-pgtable-arm: use page allocation function provided by
    iommu-pages.h
  iommu/io-pgtable-dart: use page allocation function provided by
    iommu-pages.h
  iommu/exynos: use page allocation function provided by iommu-pages.h
  iommu/rockchip: use page allocation function provided by iommu-pages.h
  iommu/sun50i: use page allocation function provided by iommu-pages.h
  iommu/tegra-smmu: use page allocation function provided by
    iommu-pages.h
  iommu: observability of the IOMMU allocations
  iommu: account IOMMU allocated memory

 Documentation/admin-guide/cgroup-v2.rst |   2 +-
 Documentation/filesystems/proc.rst      |   4 +-
 drivers/iommu/amd/amd_iommu.h           |   8 -
 drivers/iommu/amd/init.c                |  91 +++++-----
 drivers/iommu/amd/io_pgtable.c          |  13 +-
 drivers/iommu/amd/io_pgtable_v2.c       |  20 +-
 drivers/iommu/amd/iommu.c               |  13 +-
 drivers/iommu/exynos-iommu.c            |  14 +-
 drivers/iommu/intel/dmar.c              |  10 +-
 drivers/iommu/intel/iommu.c             |  47 ++---
 drivers/iommu/intel/iommu.h             |   2 -
 drivers/iommu/intel/irq_remapping.c     |  10 +-
 drivers/iommu/intel/pasid.c             |  12 +-
 drivers/iommu/intel/svm.c               |   7 +-
 drivers/iommu/io-pgtable-arm.c          |   7 +-
 drivers/iommu/io-pgtable-dart.c         |  37 ++--
 drivers/iommu/iommu-pages.h             | 231 ++++++++++++++++++++++++
 drivers/iommu/rockchip-iommu.c          |  14 +-
 drivers/iommu/sun50i-iommu.c            |   7 +-
 drivers/iommu/tegra-smmu.c              |  18 +-
 include/linux/mmzone.h                  |   5 +-
 mm/vmstat.c                             |   3 +
 22 files changed, 390 insertions(+), 185 deletions(-)
 create mode 100644 drivers/iommu/iommu-pages.h

-- 
2.43.0.rc2.451.g8631bc7472-goog

