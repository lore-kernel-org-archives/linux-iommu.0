Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C062D0C92
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122669; cv=none; b=iQFD/CNQiyyBvssq80oBCHzVCAPjw2AgqPJtYbMN/pAgtBbVXXRJyohIf7VQUQXSIgjUpTq7UfZniKwG3wP8ox2pWFqOoBLXyboBdXc/MYRconqv5nyJ5GWwNPhHLqdzBAMfI4BjMNAOUtIg3IaW8AH8L+zAsONanjbCIISb8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122669; c=relaxed/simple;
	bh=+jyi5gd3AIMhjz4J7lVMgs4zhdEBtbx6wjVxjxON7rU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKMibFWy8kdkgIpi/eLucH8z8qP+b1ADvtGByRjH0nbajMv3G9QEA/N5l3Wv5HH1YMtqOhQgMe4XT5aGlGp2CW/E0xeFY8Ru8a8FTYnq2jwNZnPiyQq5/sSAzu6azsL0ht2NDGHdMAb8NcxFceCOfCuanKEIx7HYbt8Up8IZv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLGYB+kY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLGYB+kY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a07fac8aa1so14576305ad.1
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766122667; x=1766727467; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJO21xU2H+bRt1oLrdkCFshk8QlbaOYxvZtIbsr9n2g=;
        b=FLGYB+kYT7AOQKN27bfCd65pIa2Vh9lWX3MoG85XgNOg/xunazb913svM0UZIp4q8n
         Qq9qYn1qfv5Z0mDPaip31A1Lrdq1aQH1skPRjpm3E4yt/V1KrBVVP1jmhYJAVjD4HXPG
         /9hhA9Fn3jySWY7PFsqkbi0SzoKli9t+884/yXYCObkH9VSllHTKO3BSjVG/l+hEqLu9
         63TOpZpYC6ZMroWPvFS1v2wHBBA9EtcekWyay6MzvS2g+PrNIM2EQqUxIVtm98+myx2i
         Dfhk2fiGcFHzvHzctojL+4bMLjQNkpx3QbqM8BMiw0xO1MDORsDbJdKamfu4jUPMW5e8
         d4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122667; x=1766727467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJO21xU2H+bRt1oLrdkCFshk8QlbaOYxvZtIbsr9n2g=;
        b=Co9Zug//K610SGVScWPcSJFn71fJIeuv6r86uJTmWUUWRQmfCrOejfFGclVqmdHgpN
         93hgFh0p5w+Wpsq2fxexLffY+D6WDZrYKYLV03K95uCu8/GD5g11QoXh+d5wWTVMxXWG
         hjgXhrSXyua2X0z2yElWaCjpCe1Fa4sYiOW9IbQnn4xVnwqfPGOhiGk79LGZO+Qc6pRR
         D5y+VWq5QPiV3uy7j14nTCn41pE9sgw9eDc+cvUAulE/oArkVevzZW8Ukpqx/srjr9VJ
         t0OJ51QqtSOpGcRWxrm5DD0JXTR8svhO2X+PLKrsALaRrpxe0JdXhk7Evr7E+C42PanK
         qHpg==
X-Forwarded-Encrypted: i=1; AJvYcCWkulkuHCeVp/gT9EroDFjqaZQ/aO2UWdTBWEc5q0HuwaD27DvZ/DEtZJKaeb7iGw9dxG0oHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwM/NGdGnbBlVTgUnagCFWS14Lw43gf2Fcp6SAVGevwpAy9o/ji
	XEwQ9m5vgFoxvpcY7tGDdeNGVydxzRCSQIMnPH849SLfEomDasMkn8q4
X-Gm-Gg: AY/fxX7yBjcOL93m/l1abaOSaMaK57XEXixykqyXZP/DPpd6SC6KS8uTQcrxF6851zZ
	cCJoqwR3ZShPFB6fzeV8UCGp7GHUiBi4zHVx9rEoeGjyYEx805DmjWx7bV6ZSmHSfbdYmGs5sg8
	0WHUrLYq2dSLV3Hc0fCQ+H14YH0FGTevM5R4x8cVSVM3LKKeWPfyvcTNbvsZCQJZ24U8BxsRpWd
	PzVciVGibdKomOXxkYgYbuCcBbpGOpZtFyaM0qwoERFcZ/ffnuAKzFjHWRj+0cMVlRyBEfi03hn
	z3P0Ssru8E8+HhxuRfe3El3SvAHKaUDlWeMVi4by1zA2hwZIqxDU5Wh8R7VxdUUEqwkwl8rYnwr
	NLILmPrNL419aGjrn9JYxhNdv5w6F4+rw9DeSWyYUqC+OKn4F9Ix8PyD/lc6RAJKjZT/IE+XQCF
	1m4GydZ285SCU+KBgSgrs=
X-Google-Smtp-Source: AGHT+IGDMYqEG2oDqA96bVWjmxK1/Wde940fAntilRs7/x6PwBG31jTbdPi/FUUfggX13zuKgo2NiQ==
X-Received: by 2002:a17:903:230c:b0:29d:a26c:34b6 with SMTP id d9443c01a7336-2a2f293d4f7mr14844825ad.50.1766122667279;
        Thu, 18 Dec 2025 21:37:47 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d895sm9930215ad.54.2025.12.18.21.37.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 21:37:46 -0800 (PST)
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
	zhengtangquan@oppo.com,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH RFC 6/6] dma-iommu: Allow DMA sync batching for IOVA link/unlink
Date: Fri, 19 Dec 2025 13:36:58 +0800
Message-Id: <20251219053658.84978-7-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251219053658.84978-1-21cnbao@gmail.com>
References: <20251219053658.84978-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Apply batched DMA synchronization to __dma_iova_link() and
iommu_dma_iova_unlink_range_slow(). For multiple
sync_dma_for_device() and sync_dma_for_cpu() calls, we only
need to wait once for the completion of all sync operations,
rather than waiting for each one individually.

I do not have the hardware to test this, so it is marked as
RFC. I would greatly appreciate it if someone could test it.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 drivers/iommu/dma-iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c92088855450..95432bdc364f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1837,7 +1837,7 @@ static int __dma_iova_link(struct device *dev, dma_addr_t addr,
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 
 	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
-		arch_sync_dma_for_device(phys, size, dir);
+		arch_sync_dma_for_device_batch_add(phys, size, dir);
 
 	return iommu_map_nosync(iommu_get_dma_domain(dev), addr, phys, size,
 			prot, GFP_ATOMIC);
@@ -1980,6 +1980,8 @@ int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
 	dma_addr_t addr = state->addr + offset;
 	size_t iova_start_pad = iova_offset(iovad, addr);
 
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_batch_flush();
 	return iommu_sync_map(domain, addr - iova_start_pad,
 		      iova_align(iovad, size + iova_start_pad));
 }
@@ -1993,6 +1995,8 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_start_pad = iova_offset(iovad, addr);
+	bool need_sync_dma = !dev_is_dma_coherent(dev) &&
+			!(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO));
 	dma_addr_t end = addr + size;
 
 	do {
@@ -2007,8 +2011,7 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 		len = min_t(size_t,
 			end - addr, iovad->granule - iova_start_pad);
 
-		if (!dev_is_dma_coherent(dev) &&
-		    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
+		if (need_sync_dma)
 			arch_sync_dma_for_cpu(phys, len, dir);
 
 		swiotlb_tbl_unmap_single(dev, phys, len, dir, attrs);
@@ -2016,6 +2019,9 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 		addr += len;
 		iova_start_pad = 0;
 	} while (addr < end);
+
+	if (need_sync_dma)
+		arch_sync_dma_batch_flush();
 }
 
 static void __iommu_dma_iova_unlink(struct device *dev,
-- 
2.39.3 (Apple Git-146)

