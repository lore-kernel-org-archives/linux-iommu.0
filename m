Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971C2ED17B
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 22:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772316701; cv=none; b=SAuFuzgTYUmAOOGcXExVeuJSTiwYij6RSWIY6IJSkypGiN2rjyREM9FOJxotReV5H4t+Eb31A6T+NiPo0pnZABmSfApdw6CYavXLF88P6X+ZoIayIwblSZbSnHkzb37HNOzoeoRlYXDHyqEzlF58mlOIs350ifqfM91GntPvYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772316701; c=relaxed/simple;
	bh=9fS3XpJF4I+7zLavVivs358QdKzqf1ld0o55YjNR+4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=nV1aMmdcWedrUl2Od8vHsiwLMTCm3nveK7JfDq9Kghgc/v1oYWvmFRxfmwFekz9w978q267SHdBD9KgaT7o69Z7TNT7Rq6STtZe4HHO7IyulAfFaNV57/iDU8y+sQonYYT4a6Lu+SYNiGU8PmUNGBmlvsBOX/3Zzp7efLYB/iO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsdCeigB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsdCeigB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad21f437eeso24119525ad.0
        for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 14:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772316699; x=1772921499; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xviIpIkstRNT9sPfU0zk0oRcwgO9vdYQGOA0hVgSiDQ=;
        b=TsdCeigB0evYcnC75yYHvS6hrSThEtMCbx/RnFDOW4tXd1oSHSfsC71WNYV0DT/cEE
         PMKunCLYc6Y4X9oMoyQ//uZK3GP7V8m3k0pPZLuSR3JKD/Lh3qY3U8kqpeW3mUf1CjKs
         Wtad2+5nttiBYEv/HqXZHsqmBMPLtgLbY5eeeaMzk0F8p7gAuOsab88BZAMnlkT4YkS4
         OGaaYilzPy8iBSHcPJZrW+rj0Rgvzb8i3iIBNyHzIKVBj85ojTlm/UGmGb5XBm6fmtwT
         VRJHAWaLCBypJOg50lFCQM5o61GXts6nB3M/ObwGfqg/sX4PqecArcu3JBTPNds+0xWN
         O3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772316699; x=1772921499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xviIpIkstRNT9sPfU0zk0oRcwgO9vdYQGOA0hVgSiDQ=;
        b=EbOGdsAzBq56KkYi8kX9zsNxkYDBbcXgeHns0YTUY2GpqtDB10QgUtQ/PK4ppLg5fY
         eRULGcElj98EVcByn8L/Gs6ggWbpjQODyaoZjEkG9hd6IbAf9pSjjdOn8pL+K1ZLBTOg
         XsCMgihVGjrIpS41icO95tgTXHxnWQdTb7LiDgSazhu2657XZV+x/mH6Wg25oWzUcj9a
         oaC19hti7Jvk80grbs3IR/6NmGKK7yFGHK28o1mSuWK1zprL0U7Sp6Arn+3zXiJNab4i
         vRWwHI9tb3FmkCxcuGqrxZFpWjDGFA/VeXbnvORvlixWM24TzOLWgdPEI7/rhQchP6f+
         Z2+g==
X-Forwarded-Encrypted: i=1; AJvYcCWvoe1oV/zN/9KLJ9F1Dr8xjwpSQRcM4Ap1jFn4B7pxZUP9b8330JJoHarUf0sJ0OMk3ZN40Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZLZPYXegmuXFEd/ZPFVVBt4PC8WtQlOROI2qUv8pM3M0I2r5J
	T+VxUTYBeKWrftWjGFd+SSvvtCsktY4bi/ZOE8+Pu1w2/HlfN4DNbZ03
X-Gm-Gg: ATEYQzwkHAT54NOocLLJUa3ZI90ev7vvzsbtcQoPn08N655xRYYsNMqgfP8SkBPkY97
	2WRCdukxq01s26p2DMvx/91nrHLBcgkfqZiOlRjq4GCmz6xvXMDSz9GQjPKY99efdjCO+kq/Cvr
	9wyTSRJWUVuG8MvrNGoKUfWpu8PJyfzpM5q22pFhUai3/lxJa0r8Nw6hIiMvH4+EGNAaF3dQaxm
	6kvelLKB22rZo3aE37UJdk6EOYVmYaZ7jwl+ZL1Z08OsYXPa1GrO3gzt5a+KeoUw2E4k1kVByc/
	JBhMElxrPZpmIChp3GtKLK+Em1zFy+OERyxRI/IXcjKr85Jdy09H1i3MowLtuJFhomYSYOXwlc8
	YW4Prpo6qNR2kb+o+0Lt+q20RxKAKO4aud12SPllcDzd/dbU8u887QzPrAsiDpoTuhIONYYSkNK
	NMbE/etFZLx/HURnkIiHua/g8egPSxe3/fD8C0
X-Received: by 2002:a17:903:94e:b0:295:55fc:67a0 with SMTP id d9443c01a7336-2adf78db0ebmr119480805ad.2.1772316698623;
        Sat, 28 Feb 2026 14:11:38 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b9b32sm129494295ad.66.2026.02.28.14.11.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:11:38 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Huacai Zhou <zhouhuacai@oppo.com>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [PATCH v3 0/5] dma-mapping: arm64: support batched cache sync
Date: Sun,  1 Mar 2026 06:11:25 +0800
Message-Id: <20260228221125.59863-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <baohua@kernel.org>

Many embedded ARM64 SoCs still lack hardware cache coherency support, which
causes DMA mapping operations to appear as hotspots in on-CPU flame graphs.

For an SG list with *nents* entries, the current dma_map/unmap_sg() and DMA
sync APIs perform cache maintenance one entry at a time. After each entry,
the implementation synchronously waits for the corresponding region’s
D-cache operations to complete. On architectures like arm64, efficiency can
be improved by issuing all entries’ operations first and then performing a
single batched wait for completion.

Tangquan's results show that batched synchronization can reduce
dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
phone platform (MediaTek Dimensity 9500). The tests were performed by
pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
sg entries per buffer) for 200 iterations and then averaging the
results.

Thanks to Xueyuan for volunteering to take on the testing tasks. He
put significant effort into validating paths such as IOVA link/unlink
and SWIOTLB on RK3588 boards with NVMe.

v3:
 * Fold patches 5/8, 7/8, and 8/8 into patch 4/8 as suggested by Leon,
   reducing the series from 8 patches to 5;
 * Fix the SWIOTLB path by ensuring a sync is issued before memcpy;
 * Add ARCH_HAS_BATCHED_DMA_SYNC Kconfig as suggested by Leon;
 * Collect Reviewed-by tags from Leon and Juergen. Leon's tag is not
   added to patch 4 since it has changed significantly since v2 and
   requires re-review;
 * Rename some asm macros and functions as suggested by Will;
 * Add Xueyuan's Tested-by. His help is greatly appreciated!
 v2 link:
 https://lore.kernel.org/lkml/20251226225254.46197-1-21cnbao@gmail.com/

v2:
 * Refine a large amount of arm64 asm code based on feedback from
   Robin, thanks!
 * Drop batch_add APIs and always use arch_sync_dma_for_* + flush,
   even for a single buffer, based on Leon’s suggestion, thanks!
 * Refine a large amount of code based on feedback from Leon, thanks!
 * Also add batch support for iommu_dma_sync_sg_for_{cpu,device}
v1 link:
 https://lore.kernel.org/lkml/20251219053658.84978-1-21cnbao@gmail.com/

v1, diff with RFC:
 * Drop a large number of #ifdef/#else/#endif blocks based on feedback
   from Catalin and Marek, thanks!
 * Also add batched iova link/unlink support, marked as RFC since I lack
   the required hardware. This was suggested by Marek, thanks!
RFC link:
 https://lore.kernel.org/lkml/20251029023115.22809-1-21cnbao@gmail.com/

Barry Song (5):
  arm64: Provide dcache_by_myline_op_nosync helper
  arm64: Provide dcache_clean_poc_nosync helper
  arm64: Provide dcache_inval_poc_nosync helper
  dma-mapping: Separate DMA sync issuing and completion waiting
  dma-mapping: Support batch mode for dma_direct_{map,unmap}_sg

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/assembler.h  | 25 ++++++++++---
 arch/arm64/include/asm/cache.h      |  5 +++
 arch/arm64/include/asm/cacheflush.h |  2 +
 arch/arm64/kernel/relocate_kernel.S |  3 +-
 arch/arm64/mm/cache.S               | 57 +++++++++++++++++++++++------
 arch/arm64/mm/dma-mapping.c         |  4 +-
 drivers/iommu/dma-iommu.c           | 35 ++++++++++++++----
 drivers/xen/swiotlb-xen.c           | 24 ++++++++----
 include/linux/dma-map-ops.h         |  6 +++
 kernel/dma/Kconfig                  |  3 ++
 kernel/dma/direct.c                 | 23 +++++++++---
 kernel/dma/direct.h                 | 21 ++++++++---
 kernel/dma/mapping.c                |  6 +--
 kernel/dma/swiotlb.c                |  7 +++-
 15 files changed, 171 insertions(+), 51 deletions(-)

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: Huacai Zhou <zhouhuacai@oppo.com>
Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>
-- 
2.39.3 (Apple Git-146)

