Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232222F74D
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 07:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766128017; cv=none; b=JVeDrXmQloVs7lWfdV9y58TRN24XG/JiVX9P8KVXoT0OY+i+Xr6nEZ8JmJrHfoKKnbrvxU3btYlC8Ppeyigqk+FMi2giw3lZwOylvAstkmxOSXlxeDXVr57ZJ8Bwd4GHavVD7VNLFXMXC09pt4bwWu4jhtAQItcF+9aEygIChbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766128017; c=relaxed/simple;
	bh=YQ3au/aXlp6Ee/qf++6Le97lb1zDUx3Yf3J8W5OoIWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YrIQfQWxFcX9pjhofvf6e3rktkTjcDECUvHEg1ag+M4JHlAQ08jCBE67xJqSaiNhXg561Ry65xch5Zx2Bpo1ocQtyHaiX1cfrWUdQ868ZG2U7z6jPrIwpVxMkQ+oy49sq/84LwCPMNLTApEUzfDN7GXiXVlV1guq8iOFRUWNRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmnYoMc8; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmnYoMc8"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b22d3b2a6so889492e0c.1
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 23:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766128014; x=1766732814; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1IrJKg16n0r0CIEBnXbT8hq0ulnTBn4qAKgmCelXFeU=;
        b=CmnYoMc84sNO2Acep/+u8sxNFcctHW/+jErV1vEZ3psKWAxx0zLSjz2rk4Yh+HxbKn
         a9qfhe+HeOq62haT6fjUGEaNUAy4vjI/grLFFHH8gUfYd+F0YbmHjl4vhCAICdG1iUOA
         krYD+7akh2ADotpGpfDgKrIbP/jitAznLQi68hR7C+nf7PGWDRFkJeL91ZXtp4bJcETj
         J31Llq5m1KzFz345L064HOrEw4YQV4bYvvYwwgk40sn7jdx/npz1G5AxLuj1tcbDkL5S
         GsfnxhupFDk22YZwKATqsBq8kLki+y1msOjg+112KVBSR4yc9nNMcXZ4WuNRZFZK8V90
         VccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766128014; x=1766732814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IrJKg16n0r0CIEBnXbT8hq0ulnTBn4qAKgmCelXFeU=;
        b=vvubDHEMAlbvQY6jowL7KakJqQkbOoda5UhcNDTJJv6IJF6r/Lw7kgRUj5Ac0qdHa8
         YzWqKYCl+3Hif9qt8GOMjO2TUOQAd8yvkDNwfGNAWqQ5Voo9F7E6yP/vzRi6gkO997r1
         Uoiy//4CotLd1IpZN0aQkoN3OOFjN/Q11yHyU6nA25sXa5GyaSQnZTJji+ZEM7ukc0xb
         zdJANxp27yBmbRzlaAnt9q4NEj7hqPNtdzkCKa3nRRNoO3tIuja2uePuj2VwZrvV1dlD
         /glAelB8ulrGYM4SuAcDAltkwti32Gg66eeU6AmNHu1RMVPTfUkJqcURUtd/G39+ZIWY
         rA2w==
X-Forwarded-Encrypted: i=1; AJvYcCXrzpnYpzDHWXNdxOYL3AhTl2VyFIQjVGdk6i9KmavJzlC6j3qEDo7H++PilmJt7hTvUxaqTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOz/lShTb7j4iBgIYtHzwzoPmRi6/yxipieH3TqdIQu+IYk3ZB
	EmGC7DitgQuFpyAFFJSdtqTBDOwBIGNGKl1yzPMm5YVNRj7Fxpf8MaZazpKAAA==
X-Gm-Gg: AY/fxX4y+CQDmFDOpbdyKBPteXYt1WzQjZFL3dxP6gV5wY0iyQC+YuUitwFzN+FW2ly
	Xuy21d2/x+1vZ6BEMXph6k9bfatb5EJkqPvzAX5qBt2j7BvahtKpgVhDgbZB9/rzg9QeeY+oZdJ
	J4mzuVVgxu4VEmn2nujEEj4o6uXSqaxcpikBYWHqsPQdTdYy2u/RKxv9xV/3Hf8W3zoifJCPNPD
	3WDfHD2iZn+l7it5tGI4ZN2rCsXJDRLnBE2C2WcLAOr8FW7pXaojOer5b2f9Q90L2wn1FwxMwCB
	PpXMQGCrasW6ZOJ9KVd77klcmZt6n+LsQZDi7hhyMQHh8bDQ4Enp91iJCvV5c8C4lxxFjH2OLJJ
	yB8HG3P9/swWL6k+2mXrWMxP3Izm8LDQ4ejDxJTtjAxXXcAwRAKAByB0867rZXYbp/DL7O+i96I
	vV8QsC4VunvMzBmqvc04dliwd0HnWQpg==
X-Google-Smtp-Source: AGHT+IEkWsdLvc7hzxOYBMMAqCPp3sEUnqVWT1X9Dvfup3Q7yPR3CDi//lUU3Iv0eyLEQk9EdacVTg==
X-Received: by 2002:a17:902:cccd:b0:2a0:9238:881d with SMTP id d9443c01a7336-2a2cab15ebdmr56821655ad.15.1766122630230;
        Thu, 18 Dec 2025 21:37:10 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d895sm9930215ad.54.2025.12.18.21.37.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 21:37:09 -0800 (PST)
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
Date: Fri, 19 Dec 2025 13:36:52 +0800
Message-Id: <20251219053658.84978-1-21cnbao@gmail.com>
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

