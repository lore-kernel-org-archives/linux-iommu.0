Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927861DF736
	for <iommu@lists.linux.dev>; Thu, 25 Dec 2025 05:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766641522; cv=none; b=YYaLd+YDIWR2og20/3krX+L81h2/QP7hBu/hOFGIErBGVUJCncRIijMJu971ScQNKaFJqAfJD/4IfByTLpQcMg81JfgvO1F+9ARmgnfU6l0nTeUiJTTHMQrWrUFtlRgPthM4tSVwskbmEFslhqrCT4vdy+rdgtVwDhuQPgl5wss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766641522; c=relaxed/simple;
	bh=kBUpURs3pGOQdFiZ9Dk0mRzCg9JjMr0p4w906V1sjKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZL7fm6GEXJKOo1ZLcryLtotTJQebOh6cYN/5aOAgJM8wEaUHCil7oMEGPnBPS9yUx4MlzGvmLYtPpwEAGkCBnu4TCrNzHhhKYPwkC3TwQjgnKnFOuY0UhaSOS6UmJECsdDqK4WX/uHw+4h2qw9WXV0ceaOHtJU+D3/dqSgvsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frZmKwiM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frZmKwiM"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so7869339b3a.3
        for <iommu@lists.linux.dev>; Wed, 24 Dec 2025 21:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766641520; x=1767246320; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awLWGoGgdpXkNXwkBZeX3hqOx9uYLiEWuERrTaaxVGg=;
        b=frZmKwiMF0yNTKDD3g8FgcFkIZWJxxd/juxZSFWyprRlOWadV+JhtqNQ/iZ/AjLex/
         LtK36xU1SKQR7f1rKBHiN6zv5Nju+Z4bMFnime7K5sTEfq2nSVsi6D9cmNfB+esara3r
         pBK/eYTd4g2chltHQOQ+Nl0Oigc1ZxU/xukH+hDcEkOpFkn5jBq+BzYorMTeBWSzJYuj
         p3t42mLTqR4/1OdVRNFgGtkVScaAJ4WFvTxyEJcPJsjXZVw3/IXFxCumwoUbSMqjF/Sa
         1KB9lL5tMVSlFOhxhv7wc+p+soQdtwEFXJMB/amSQWf8BMPGrpjGmrrfDKMgE4PR0bua
         cf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766641520; x=1767246320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=awLWGoGgdpXkNXwkBZeX3hqOx9uYLiEWuERrTaaxVGg=;
        b=H1lRa1Wm+lXxryWDaX72J621cvNiuHgLsMHvZIoXEJnUu+BgDib6KFiM7kLJmis0Op
         uIYZ8hhXF1ZhmiuXh5P7MncsihwrQJKvIerHQsPpcLXr1WZlKTRLfMn4x2aRLrG3Gj3u
         sD3KYhGd259ezs7TRK5n/Scw6AzIXcXYKdoR5FSVEIA23WdVfmtJcMosP9Uu3f00pTDI
         SC7QGjJqUnYUoIs1XXnhlUm5HtnFQ5EVNc3nncqniTSJNfYBwhnfavryPPh68uMIu3Kt
         IqMDTcShAi8WIVODw4Z0kqeCJpjwOJ8rEwDRABw2dHFeC9kSvregRsc0bqNU7MvDB9aw
         TBtA==
X-Forwarded-Encrypted: i=1; AJvYcCWZWZtzvKp3AwX3m5iYE+heKUwift4emnHPSC5YjKd3dt6Vmwvlwr3Wn6nnfwRt+WKaicGVAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJp3oEcwJX87jvJC+aBSEKNNJbVuM9CbRPpKt2CbhWBFTc98h0
	+w0GO/mSmbLqDHbaxDXA4bKFOAn/ueruI6x1qCQFVDdyebo/z2ciIQLU
X-Gm-Gg: AY/fxX5De9/zy2ImLCDproWKZQHhfffmM7cfByv22nVSGhFZm4alavDdrjOChulSZAK
	ubAkCQxO6YowxyIel6bpNkZzOqXRpdDKgMTQQIYyM1SYs+MN9DJNWYzM4IVCAk9SYOb9b665L1F
	7Tj0HWeM7aqx9ngcMVmWTmO4REvE7wIHvrLpJwFEO+vvjOAjyPMn3xQl/lMu3/DuIHJxiwPxoIy
	5veLuZIyXMBjiaZiDzXpPdSR3gBxKiaktbu39z/3kzHBP5RZJRFIoJdG8mnsmcYAncYWTHz+PWS
	0ySXbFyGnFSAVrImTIxnD+ci80LzkNGBhVn+AkIcqiiP2zatI0yPG4CVOEAdOiN0JBRdwHZ0Tla
	TctYXD+96/mfYByz1czJ+w7ETThlXxL2Muk5PjmojbwiF0RiuiOGm5fqwTGYxPSJb0PbQTb/p0F
	cwD0MEh168v5q2
X-Google-Smtp-Source: AGHT+IFjiH0lz0LAVTw+YGN3qXPK1250UhDPFxtbuSuejwFf6Kj2hl7RPgmOjGUptvke7p9I5vERZg==
X-Received: by 2002:a05:6a00:35cf:b0:7fd:f3e9:5a03 with SMTP id d2e1a72fcca58-7ff66f591a2mr17677975b3a.40.1766641519773;
        Wed, 24 Dec 2025 21:45:19 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f300sm18385848b3a.54.2025.12.24.21.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 21:45:19 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: leon@kernel.org
Cc: 21cnbao@gmail.com,
	ada.coupriediaz@arm.com,
	anshuman.khandual@arm.com,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com,
	maz@kernel.org,
	robin.murphy@arm.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	will@kernel.org,
	zhengtangquan@oppo.com
Subject: Re: [PATCH 5/6] dma-mapping: Allow batched DMA sync operations if supported by the arch
Date: Thu, 25 Dec 2025 18:45:09 +1300
Message-ID: <20251225054509.39917-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251224085145.GF11869@unreal>
References: <20251224085145.GF11869@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > >
> >
> > OK. Could you take a look at [1] and see if any further
> > improvements are needed before I send v2?
>
> Everything looks ok, except these renames:
> -                       arch_sync_dma_for_cpu(paddr, sg->length, dir);
> +                       arch_sync_dma_for_cpu_batch_add(paddr, sg->length, dir);

Thanks!
I'm happy to drop the rename as outlined below-feedback welcome :-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index dd2c8586a725..487fb7c355ed 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -87,6 +87,12 @@ int cache_line_size(void);
 
 #define dma_get_cache_alignment	cache_line_size
 
+static inline void arch_sync_dma_flush(void)
+{
+	dsb(sy);
+}
+#define arch_sync_dma_flush arch_sync_dma_flush
+
 /* Compress a u64 MPIDR value into 32 bits. */
 static inline u64 arch_compact_of_hwid(u64 id)
 {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index b2b5792b2caa..ae1ae0280eef 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -17,7 +17,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 {
 	unsigned long start = (unsigned long)phys_to_virt(paddr);
 
-	dcache_clean_poc(start, start + size);
+	dcache_clean_poc_nosync(start, start + size);
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
@@ -28,7 +28,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 	if (dir == DMA_TO_DEVICE)
 		return;
 
-	dcache_inval_poc(start, start + size);
+	dcache_inval_poc_nosync(start, start + size);
 }
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 4809204c674c..e7dd8a63b40e 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -361,6 +361,12 @@ static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 }
 #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
 
+#ifndef arch_sync_dma_flush
+static inline void arch_sync_dma_flush(void)
+{
+}
+#endif
+
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 void arch_sync_dma_for_cpu_all(void);
 #else
