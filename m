Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8B2DF158
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705107; cv=none; b=StnMIdZesEVWSoAZxT0rAxDgBL01QY87IRpPcg5elrOQjsrKfIkqa733mgFRwfErT4pbtbWPOJoikZT9p56HnE0zPnzQSecC8w81v6yxsagSt62uUn9/shzKTFjNpajPFZ6p3ZAKDQcNwRL/MQUfyns2sqxCsz6KY6visI+EHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705107; c=relaxed/simple;
	bh=08YTXj9mOsdd//EznP6ZHWbSRLCqtaFI6qDk4G3Bc7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qyXCsycOimkTf/f3tSM4C0a3EtQ+A+a9bhddhvHfDJ0OteDMqG/KylzdA906a/hNjHtFogs8TZ5L8nqFUCizVsllh88lUhjHlDWk2kIR7Ni7ZHURgVs3BXZnLWTczV5xh+rEqM+c/LXIpYBLRULPynvCykVpFO/fhzI/k8VtMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CB7gniik; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB7gniik"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so6273333a91.0
        for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 19:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705105; x=1762309905; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgNes+rqtOn5I2bD84BLzzymTajy8GTlzB0Zxoozedc=;
        b=CB7gniik95/T9srEqLi/b3aXglY2N5cA+FZBvWGuxGfo6Y7/9BfU1vTjp6DktI4Cuv
         nU8wTjwCPwZusr/H27cvW4H66ql676kSekxQ2TyrScwjWfEPIJSmskVQ+0F21+YegkBd
         a6JFd3YCp4d9l7UCg3MkrarBxOnX5nxLbig+RJjtKxAHJYW17WV7zc9yhENnETIMjbqS
         tsurJsWrhaVEhhUYaWbdLn+9UC4oxYJpEF6moWYEDByHVKv1VyGLnP2KN6SyANWbr6PC
         qoghlmxNBxY5RyGX5sWxRWW1vIoTq5NFr4W1RLLjCFUOJFvoHAivMdvBHDpcPrOYj9HN
         HtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705105; x=1762309905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgNes+rqtOn5I2bD84BLzzymTajy8GTlzB0Zxoozedc=;
        b=SNNzw0/RzM27tQFOKxqiFfam5yjhnFj0zcfYuI2+8AlCgRS/RHljvPfTbx1ypOHal9
         5dDZcjttzW32aSC7RaaF4fkYiZj04oQ6n7kulOzbrSZnTC0Ttjz/lAzaQlByuO1IEgPy
         yL1niimagZrTR8hdVmd5Pd5YghOgqt3bAKsKYIDnO78kK8s9/FvVW7PZIc41Ef7e7cQI
         lkK7IONeOqJrPv3HyXsy/SQip85BJ4/TIiNdyW427scyIdR2w52LqnYZKnjc9w7I5ZO2
         xQFRihsuB7HfQu3TvqfvGd9Yqakn+A/5hP7A9iMIsdqwgZYCyllXI5BEZIwYoYLaWcHw
         JqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYrFGEJgj6ZI6BDIcgjdxO0IZGWi3NxRa/jl4UeiQtUjBDErqzZqI1aVlozRf8l8SaFWJVPw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxji1/JnYGIaaoVbEXHQ95hhnvAOzTZDJu+dv/RicfNWGQPh0UE
	vPM4UWgI5fxkpnrYjmgK4E3Dk9Ev34u6wVtfy6S7eVkbhDED0C9G2zTn
X-Gm-Gg: ASbGnctwp2/QB31DcQ5ijPLJMVPi5Ng4j8Q9YnPfUVyA2SZPTwPWR19+08rkydgZkID
	s7tJ6fTyum3s+Cci+dD/ZMkCz3bP7QZCmqYuj6kdnSqOtXvnFejlA3B2UbxRHor8B43rlYUBv00
	T+YDujwz00LoXEeLBN+O8pfh3la77VeahIOJN1fwPoG4PiTUOSIC1HhnLq/TGzc2IqKL+D3nmBA
	iaP7U434ZTxaHT6sYfySxAIJjY7JJkoXLr14/NyjyWDtbK4HKUuN3Lug2HD3+qCxYjN7IRMZnMz
	NI+gcGpCiz5Gv1GH4TY6ipxUg8nljTdy+qODF2EtAkTOmnXJMTmnwGcYT7B4g5EE80BxtHHO+X1
	liUOED02wNGGlTwvPj9X2qm4/2EyoVTP87UB2VJnHTI1ADTRW0YHFkXry4tPQIA8GLsaMmCXnkn
	2u0AaRarcEiDXXJKmBeK6sV65q+G/BqIi22PWWm1BOyzAX0RuEqI1nQzjXs8Wm3J/Prw60
X-Google-Smtp-Source: AGHT+IFLYcFzOLyMWt1s97dTAlOlW5cqBgpRGPsdw/0wrh7IMH63MrfiPstec7cpC1SUbgQjmoUXXA==
X-Received: by 2002:a17:90b:1c8a:b0:330:797a:f504 with SMTP id 98e67ed59e1d1-3403a15d128mr1207767a91.3.1761705105142;
        Tue, 28 Oct 2025 19:31:45 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.31.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:31:44 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [RFC PATCH 0/5] dma-mapping: arm64: support batched cache sync
Date: Wed, 29 Oct 2025 10:31:10 +0800
Message-Id: <20251029023115.22809-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Many embedded ARM64 SoCs still lack hardware cache coherency support, which
causes DMA mapping operations to appear as hotspots in on-CPU flame graphs.

For an SG list with *nents* entries, the current dma_map/unmap_sg() and DMA
sync APIs perform cache maintenance one entry at a time. After each entry,
the implementation synchronously waits for the corresponding region’s
D-cache operations to complete. On architectures like arm64, efficiency can
be improved by issuing all entries’ operations first and then performing a
single batched wait for completion.

Tangquan's initial results show that batched synchronization can reduce
dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
phone platform (MediaTek Dimensity 9500). The tests were performed by
pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
sg entries per buffer) for 200 iterations and then averaging the
results.

Barry Song (5):
  arm64: Provide dcache_by_myline_op_nosync helper
  arm64: Provide dcache_clean_poc_nosync helper
  arm64: Provide dcache_inval_poc_nosync helper
  arm64: Provide arch_sync_dma_ batched helpers
  dma-mapping: Allow batched DMA sync operations if supported by the
    arch

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/assembler.h  | 79 +++++++++++++++++++-------
 arch/arm64/include/asm/cacheflush.h |  2 +
 arch/arm64/mm/cache.S               | 58 +++++++++++++++----
 arch/arm64/mm/dma-mapping.c         | 24 ++++++++
 include/linux/dma-map-ops.h         |  8 +++
 kernel/dma/Kconfig                  |  3 +
 kernel/dma/direct.c                 | 53 ++++++++++++++++--
 kernel/dma/direct.h                 | 86 +++++++++++++++++++++++++----
 9 files changed, 267 insertions(+), 47 deletions(-)

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev

-- 
2.39.3 (Apple Git-146)

