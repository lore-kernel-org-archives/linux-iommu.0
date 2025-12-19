Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E651EAE7
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131242; cv=none; b=GE0QQ9c8mfNE5+0w/nARDJIxhZtQheQNVZEuUjAsbbl8mawCpCtVNe02J3Oyb/WrC/HLercS5AxZxOnn+vO4nW8p46aiszTgpuxD2eg5IgSEVwW64EtXrgzaiuhr7Jr/esMrbguh240q2Y5JmuzYSv4oLhF2sz5TKi70teN3zkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131242; c=relaxed/simple;
	bh=6i7Lhre/JCY8yLJrOjxAnnD3DEoR4wlXovF0Nmi6pMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWfXlCGvKJhdA8Fe3Ehge2P1y9iOeYczPF/TAUKQGVdb4K3VsGe+QCdChMT9f2NH9cYXJzr4fXYGj9pPyg1bGVd2ZOlb25Mvws46q+U8bm55zBu8LwJS2HsY2aVQ/38xjQhhPx5H8ePgbiJin7TuJfrhiKEP+WUPq2athB5nkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab17Hiqs; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab17Hiqs"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4557f0e5ed2so825419b6e.1
        for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 00:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766131240; x=1766736040; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41Gw+CNEv8JCYmTFPHgaksUdYbCOdfOME9GmEPP9m4k=;
        b=ab17HiqsGonqOklglEsVWTeEKb+WzlZT3aHV8RQ5nRKymu1CDCieSwYe+EWDQX5Q1G
         oHB5hWhpsu5fqYJUjxMLd0/20m8TxoxVozPlWVP59U2gUBOpBoy7w3FkTeFbKaN1TLwz
         xgr0wKv16H0PUGAl5jqG3ul4ZkfDJ1HRyd3a0lxiG3GLmHWyhGh7siRJuscqRf30mHQU
         m/l80pmMUMeFRZZNNXZvr28SLvxiNeU11a357LBjKNjSXGZhZYJG17zu2ZcMfbxBSEst
         6cvgpW1Vffnil9w326TDilP38h675xDBFuvi4iQEw/KX1W4OwhNIwfIMs4WqhaK6gtnO
         eY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131240; x=1766736040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=41Gw+CNEv8JCYmTFPHgaksUdYbCOdfOME9GmEPP9m4k=;
        b=f+o0/1h8DXK2Q/wk9j/IQq07AK2H6hwyOY+SEupBvQReO/2cGjF2TCijEHpgvYlrwJ
         Ct68O28P55+JiLX12PX52OMDEhmwODlpZl2Yc6UB7U04H00Zo8yLtKuLEHiKJtRCdJIT
         WPkQtRy0oCCbPBdNMoloqfSmK97GQ3zh9RY2uDE0LlfpZhRoCmPQduNjiZNv/CSRfV6U
         jQRZfgoWHIfLNdnAOkHplT7xS6ZdKIRp4re51ESOCChFalMt4fOEaG6G24wew1amKQfn
         KbxwbzJ1evHYouWIbOhutGwiNvBW7bMnQCFGFocIYDz2X+5/AvrpSOJ1kLWq45/51/Ts
         iNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmGAWhAow1BHm+YcS0C9vrAK2mNqw6A7cl6K0o4wkmBjBYQncyHRArQmtMNTzy71tM7LAOfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/KVnLgMuWeGa/jeRzlj9RsQAUuvS0QG8RI0S1tF9fYGfB1L3K
	stI8KYRKEqujGRVjibMyw2XuucEMtdPFptBXtfhsni+917aHMLDWwdhpO/S3xw==
X-Gm-Gg: AY/fxX5O4aDQlv+7tz72RzzpUer+Hjf20Ta1DvyOFa85RLSaWm80dCkCucoYBT/QXEz
	sWGvzcyAQR97JwYG/lZNfN0Yx1ZDVsDIiJbTCeTJ+lll6+VwETJoFQu7Xs/GFAJXVC4PtROpzSY
	88C2RGFvtAP0XAMjdEZlvuC72hk1R0g/T2v//wv8P/8Ex1IIh7TShKurjlQv2OgQJwMuyo3ZLXH
	JRsuT0R+CjUy+s0HNtawTbnO/T4h0Ze+5UH/L2NA5ygEfqaKHKfx7b8fjZrGLbZntUmzzcXwxYU
	5iRVInL8ddjm8Lw76pvW0BB422sEWA8ip+hlZbzJ//vQ/W/cvK20qE2RxDacAw+srdHYhwN/sqy
	zrtv5KCDQ+OAw2FIJ2K0myMKHhNuKEQhfN4yP9FjfEOa//tmDLHsngfAFxxOmI4MVCegXOl8mgD
	aH7xapcKo0vKDmmbZJZDns
X-Google-Smtp-Source: AGHT+IG3BJRPOOEZ0WvlC5Z+hTnZkugL77JSmHKLal4jtBj7IefF9CMWnN7OGgSRa9VvlcJ7gNULnA==
X-Received: by 2002:a17:902:e78c:b0:2a0:d0ae:454d with SMTP id d9443c01a7336-2a2cab4335fmr41005055ad.22.1766124302656;
        Thu, 18 Dec 2025 22:05:02 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c65d66sm10810765ad.20.2025.12.18.22.04.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 22:05:01 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org
Cc: ada.coupriediaz@arm.com,
	anshuman.khandual@arm.com,
	ardb@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maz@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	zhengtangquan@oppo.com
Subject: [PATCH 0/6] dma-mapping: arm64: support batched cache sync
Date: Fri, 19 Dec 2025 14:04:52 +0800
Message-Id: <20251219060452.85288-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251219053658.84978-1-21cnbao@gmail.com>
References: <20251219053658.84978-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

For reasons unclear, the cover letter was omitted from the
initial posting, despite Gmail indicating it was sent. This
is a resend. Apologies for the noise.

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

diff with RFC:
 * Dropped lots of #ifdef/#else/#endif according to Catalin and Marek,
  thanks!
 * Also add iova link/unlink batches, which is marked as RFC as i lack
   hardware. This is suggested by Marek, thanks!

RFC link:
 https://lore.kernel.org/lkml/20251029023115.22809-1-21cnbao@gmail.com/

Barry Song (6):
  arm64: Provide dcache_by_myline_op_nosync helper
  arm64: Provide dcache_clean_poc_nosync helper
  arm64: Provide dcache_inval_poc_nosync helper
  arm64: Provide arch_sync_dma_ batched helpers
  dma-mapping: Allow batched DMA sync operations if supported by the
    arch
  dma-iommu: Allow DMA sync batching for IOVA link/unlink

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/assembler.h  | 79 +++++++++++++++++++-------
 arch/arm64/include/asm/cacheflush.h |  2 +
 arch/arm64/mm/cache.S               | 58 +++++++++++++++----
 arch/arm64/mm/dma-mapping.c         | 24 ++++++++
 drivers/iommu/dma-iommu.c           | 12 +++-
 include/linux/dma-map-ops.h         | 22 ++++++++
 kernel/dma/Kconfig                  |  3 +
 kernel/dma/direct.c                 | 28 +++++++---
 kernel/dma/direct.h                 | 86 +++++++++++++++++++++++++----
 10 files changed, 262 insertions(+), 53 deletions(-)

-- 
2.39.3 (Apple Git-146)

