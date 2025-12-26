Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500281586C2
	for <iommu@lists.linux.dev>; Sat, 27 Dec 2025 00:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766795664; cv=none; b=qdNqj64fV6aAbwlU6L9UhBwqkQcTkmn9wF7gvE1BblPZFW4jRsPuKO16XqQ3nFlESTnGVmc0KJ8hmgDxpayN0FVKQaLbzxHMpe9CAMXVv/KM2RTinAfHwu7o6RNXu4WNulpyrchhrfMt8GRYK81nMfubKpnpPJMWl6+fq712Hr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766795664; c=relaxed/simple;
	bh=FYq5m/cre8Va9uIZfDVuD0yX85YIHbjbORD+rvMdAOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJxgZ1sIuy7nUG00bI5kPmANVY9lRtuUQuPxWxRpY5mqo2uaePZP7VJETMrpt5mQFPMf/5wpbLm/B0ZdSzEosnIdrGWuJMbUfU0cnVygARfcL7w67MjbcOlwIwkLhiPL5OzNx5xj7gvM9Hh5S/+JlQqn0Cr54TCDJVTnVQcpo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT/ci0BS; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT/ci0BS"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so70446171cf.1
        for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 16:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766795662; x=1767400462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/r7srQmiwZEhg1qAC5GzWj8afC3w1hmN+Jy3ezOc8f0=;
        b=JT/ci0BSrE2qqow5kTI7irNJsGOqBHESfp58ap40gmfzKH9QjOHP2Wy/7j4ZrxCeqp
         CEbxIKQzPdfn+2brIlkO9MIDoBrHYtGz4NXxyKu1/lSDsEuCD5A/NjQdJrGlqCURzj0N
         f4TTja4Xb1588dBL2AuhQ+wxF6T4Mkh52HO8WPc5RiBQfN6vtfe/L8JUUyT8mbcWi3yr
         CtE7F105Xzg9kSh45H7iI43+zHoWtubxFoGQx4W/ky8hvGLMFn3ims8aSZ01CppzFV2s
         hag2koyMtHWNaGIbXh8Z1IrxFr/ti8U8ps2vtWdh1/92E6r3Kl/xTphOXhaLmD2dbm2J
         tRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766795662; x=1767400462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r7srQmiwZEhg1qAC5GzWj8afC3w1hmN+Jy3ezOc8f0=;
        b=EZgPXYQa0ArOkQdYpDZ4j4mjWdZMp89FkuALb1UpyBH1xWSxlM6SUoHgi8Dd2SVxyx
         xup9zYHRzwC8nHB1c6QwWC1l+N7PgzRgnq/n9Qetb47BSaTWfw64YW87dewhFH0IHOP3
         r7D4WSaPIRqQXdEIZILHvERstq3LQLc4oaiScxrb8HiUypfK6Kuj6p/1kM41+p8C345g
         FFRSfCzjwZgIoQuC3/MpM8TPrE26PeaaS+jjeu3XJd6Q2OgvcUdm8D1M2UyJDBLrOylP
         Vp6iDLIRNxMrqtXM+PDMXcKiuPVDUGwQVZLsxz24oEuN0QcnC4qWhWGonNGng4PKi2yp
         /2lg==
X-Forwarded-Encrypted: i=1; AJvYcCUM3LEFg1AC4cMj4zbtpRcuVgQns1WupKlknWnYFUvM+zwHLr9frVt4eLKILAKeFHenq/kL6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjIV9knjTl51l5OvH/Nmc4KlBh/DN8QsqDC2RzU+x9+lgZ2vbn
	m2uQ4DMUbwUHuCkg/ZzZwJFa+awfrXgnmVRUIpflhbZYZjcQ+JfIJ3qwEkqYkVj4
X-Gm-Gg: AY/fxX7RZC9S+1+JRltLbwoUwZa6PUcGFup6osVvwXZXOHLAQl7CChhDnM+97sGk04f
	tRFWbCSWbO1qNgv+Oj4ztEseD/4zqRO+JYyHJMUPUzJapuJXyU+N2NunmzuhUQXIaci2m5ksdX1
	VqeqqFIH3zLDPcaQVCnOnWiBbtMXcZBVRtzo2PTOiIqGUOGo7QcJ/xbhmCEX3W1oWRtwyDo2YqE
	iByucsSiHLSCk9q4w+gbJASCJ35UbVzBjmZKzrNKCJ8iXqQldU8csQ764FjB7R8JyuJQWy3bvjU
	VZjrr7580GED8Fs8xFxCar08cRMGAp1Kl1PFPbwZM++hhj/BRrrSsEbWbdsALHRO+9fbp9juQCR
	w6LhW33g/zu8BqMmhgtGrAARet+YHhyVILlEIW5xTD3ooCaXfqbiKl6pEiWJjz1pW3krrZA5Yhx
	N4QpfhaeHBONXy2dzDduADWHU=
X-Google-Smtp-Source: AGHT+IGRk72ichKRcHInGwm03WbYMZHXhydzrv/dBjOlD3Ki0dbJk2IiVKSqfCl2HL9XczgL6zklJg==
X-Received: by 2002:a17:90a:e7c9:b0:32e:7340:a7f7 with SMTP id 98e67ed59e1d1-34e921131admr17034959a91.2.1766789597799;
        Fri, 26 Dec 2025 14:53:17 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm9981428a91.9.2025.12.26.14.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 14:53:16 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
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
	Huacai Zhou <zhouhuacai@oppo.com>
Subject: [PATCH v2 0/8] dma-mapping: arm64: support batched cache sync
Date: Sat, 27 Dec 2025 11:52:40 +1300
Message-ID: <20251226225254.46197-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.48.1
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

I also ran this patch set on an RK3588 Rock5B+ board and
observed that millions of DMA sync operations were batched.

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

Barry Song (8):
  arm64: Provide dcache_by_myline_op_nosync helper
  arm64: Provide dcache_clean_poc_nosync helper
  arm64: Provide dcache_inval_poc_nosync helper
  dma-mapping: Separate DMA sync issuing and completion waiting
  dma-mapping: Support batch mode for dma_direct_sync_sg_for_*
  dma-mapping: Support batch mode for dma_direct_{map,unmap}_sg
  dma-iommu: Support DMA sync batch mode for IOVA link and unlink
  dma-iommu: Support DMA sync batch mode for iommu_dma_sync_sg_for_{cpu,
    device}

 arch/arm64/include/asm/assembler.h  | 24 +++++++++---
 arch/arm64/include/asm/cache.h      |  6 +++
 arch/arm64/include/asm/cacheflush.h |  2 +
 arch/arm64/kernel/relocate_kernel.S |  3 +-
 arch/arm64/mm/cache.S               | 57 +++++++++++++++++++++++------
 arch/arm64/mm/dma-mapping.c         |  4 +-
 drivers/iommu/dma-iommu.c           | 35 ++++++++++++++----
 drivers/xen/swiotlb-xen.c           | 24 ++++++++----
 include/linux/dma-map-ops.h         |  6 +++
 kernel/dma/direct.c                 | 23 +++++++++---
 kernel/dma/direct.h                 | 21 ++++++++---
 kernel/dma/mapping.c                |  6 +--
 kernel/dma/swiotlb.c                |  4 +-
 13 files changed, 165 insertions(+), 50 deletions(-)

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
--
2.43.0

