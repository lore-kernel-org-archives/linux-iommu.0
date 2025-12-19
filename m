Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD86218AAB
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122651; cv=none; b=LzdUzat/8y4EioYkBJThDPxbZ5fxyWSafVAqjH+Ta7B+ILrJxLBO1szyGbR1tzkCyDNSrXJmd7Ld16LJ/3/XQkCvtZhjwP5LIbbVz0FkBzdECZgf8x3gy+X/kazcULJmGLDPgjSCncC4tTQ4zKkUJoeaR2uB1vbGJeD11dmKghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122651; c=relaxed/simple;
	bh=hlJGkag1/m+BajHKxwSoDZk8vWfVJUTYJ+ASwnoAf04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLJtFipGoCzuJHGgStIgWIErxHXGPMi0T247vlUVklFY6+MmMLmo/hlVBE2COsOj2OEIoc1saN81J1DgJL8qh7FinidUguI30c5fdivwRbef0igWy4JkX3PrZZvGvdVdP6YS1BLUC56/FVszklAzyYDgegLWppDpWQNrDrA+IZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnNsxWL7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnNsxWL7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a2ea96930cso12636465ad.2
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766122649; x=1766727449; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BUB05Xw0z/21o0FdpEbUVLloFvEcORujjQKbT7R+Vg=;
        b=nnNsxWL7GDuQmeVOpAwi91ald8vbvLG+1SzW2UDHciI1/krVEGMybctZDpfDp78yO9
         CM7ClOfW+RL9fby3vmUg8cWlNfD8HLMFhOq6I4fLGbOYCsqBXaZWnOVQ/CzLwdqexFqa
         f0DBC7L0p3f6PlfLVLZyKGY1yl0xg1iSl3g0w7x/jqAOACrs+jiOUlMccMwVrKFAqKtx
         rBnKopBNfV9rw5xkykXQSVSy41MDvh6NcbkSLfkNW0qVusA8QDAb49PfszrSje4wGK+5
         WwErXeDo38ubZvxk+4GauQY+vjmOxKhkaDzhWrDxXby7tgZMxWSpHRzxom7d4PhvDr2p
         L8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122649; x=1766727449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+BUB05Xw0z/21o0FdpEbUVLloFvEcORujjQKbT7R+Vg=;
        b=Kjc5PK801nDAfLVCjzVt9ykj48tE2pwJ5vj98kC9jbaPHzOxKTBtf6HyVn+qZP2Gmw
         6DyRbG/+XElbrGbg1UMUJz30MzEmCjFtKbkq6ExadZPKe+V43C4CtKB2RcBGO35FyVI1
         ZUKYftFlIxKTK+MOy4UAJXCD5fPnr2vrqksj3jEqDWSRL3sSCGzH0ve78sy59r9bquKx
         L9ZTZ63jmybWQfaiVfUYwEQCXGEpr8BPYfRsFjx3T+uSDDYsy3HNP8KVt7DZeg8c4VvX
         xupuof2UKduyn4UPMoLg3vER7WuCmBI++PD/jhYWDnZbbBBfUgkLLx7yd5PM+9yJlEJD
         u+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSfgGhjZ1aicLKJREi6hgIiUvs+GFuxJmdeJGImvjxYFA7ALhRAuVU6INukNqIkhO/w5vhtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YydQ+foRmhNuLb/uYiXL2uLuN8Gnayp3vYhcw+leXzd10q1T6dx
	N0Bgt+XYg4dxdQKnTVb22SRY8KEfDl8k5iyJIKHLrII10Rk5GRI8T+Oc
X-Gm-Gg: AY/fxX61azTCaF5T/mseVuQp+B7QU6btklEqdn8GaQ5bl6KIAcTRyXbRRx3bAf2RKwz
	fx6bUax1eqw+RsR7m3Un/THr/bmCnq419mxZKIbQfP1eYK8NPbqxzSPpUPVU8tENaPvpPMo+h+s
	6LOv/Xmo6TLy6Ppy6L1fLylnTouE9L44SzaryxPzDQwqlcTLRVn6uMAL1bHIhGxXWLxtXB8fQ69
	GUAgO/++s7CqzYxsHS//gbKOCSNp5lS09OuzDQJOTCSdzFxa7VpLqbaTyiz3nfwF+adKqkH+7Gh
	8z1oFMaKf0UzparJbwEtTJkcOvanjfWz2cf0AnSVCmV9v9LPob4QO+SakXqkkUknn+ZXYmezZLF
	K6AsXj1/55sp37isV9+55mOjs00eR4S69palD4cwQ2KPnhdSLPQ94LgQIo8OFSlVFoJ4U2c8Km7
	uMwB7A3GP/0EZItx8aIRc=
X-Google-Smtp-Source: AGHT+IGkQWfCACbqbbuCCFNQ2qKU8A9EFKMEKsAn+SUo7Bb1nABCAXucZJ/1Sbvypne34EZsM9fjtA==
X-Received: by 2002:a17:902:f552:b0:297:c71d:851c with SMTP id d9443c01a7336-2a2f2736bc0mr15326595ad.36.1766122648538;
        Thu, 18 Dec 2025 21:37:28 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d895sm9930215ad.54.2025.12.18.21.37.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 21:37:28 -0800 (PST)
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
Subject: [PATCH 3/6] arm64: Provide dcache_inval_poc_nosync helper
Date: Fri, 19 Dec 2025 13:36:55 +0800
Message-Id: <20251219053658.84978-4-21cnbao@gmail.com>
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

dcache_inval_poc_nosync does not wait for the data cache invalidation to
complete. Later, we defer the synchronization so we can wait for all SG
entries together.

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
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/arm64/mm/cache.S               | 43 +++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 9b6d0a62cf3d..382b4ac3734d 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -74,6 +74,7 @@ extern void icache_inval_pou(unsigned long start, unsigned long end);
 extern void dcache_clean_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_clean_poc(unsigned long start, unsigned long end);
+extern void dcache_inval_poc_nosync(unsigned long start, unsigned long end);
 extern void dcache_clean_poc_nosync(unsigned long start, unsigned long end);
 extern void dcache_clean_pop(unsigned long start, unsigned long end);
 extern void dcache_clean_pou(unsigned long start, unsigned long end);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 4a7c7e03785d..8c1043c9b9e5 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -132,17 +132,7 @@ alternative_else_nop_endif
 	ret
 SYM_FUNC_END(dcache_clean_pou)
 
-/*
- *	dcache_inval_poc(start, end)
- *
- * 	Ensure that any D-cache lines for the interval [start, end)
- * 	are invalidated. Any partial lines at the ends of the interval are
- *	also cleaned to PoC to prevent data loss.
- *
- *	- start   - kernel start address of region
- *	- end     - kernel end address of region
- */
-SYM_FUNC_START(__pi_dcache_inval_poc)
+.macro _dcache_inval_poc_impl, do_sync
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	tst	x1, x3				// end cache line aligned?
@@ -158,11 +148,42 @@ SYM_FUNC_START(__pi_dcache_inval_poc)
 3:	add	x0, x0, x2
 	cmp	x0, x1
 	b.lo	2b
+.if \do_sync
 	dsb	sy
+.endif
 	ret
+.endm
+
+/*
+ *	dcache_inval_poc(start, end)
+ *
+ * 	Ensure that any D-cache lines for the interval [start, end)
+ * 	are invalidated. Any partial lines at the ends of the interval are
+ *	also cleaned to PoC to prevent data loss.
+ *
+ *	- start   - kernel start address of region
+ *	- end     - kernel end address of region
+ */
+SYM_FUNC_START(__pi_dcache_inval_poc)
+	_dcache_inval_poc_impl 1
 SYM_FUNC_END(__pi_dcache_inval_poc)
 SYM_FUNC_ALIAS(dcache_inval_poc, __pi_dcache_inval_poc)
 
+/*
+ *	dcache_inval_poc_nosync(start, end)
+ *
+ * 	Issue the instructions of D-cache lines for the interval [start, end)
+ * 	for invalidation. Not necessarily cleaned to PoC till an explicit dsb
+ *	sy later
+ *
+ *	- start   - kernel start address of region
+ *	- end     - kernel end address of region
+ */
+SYM_FUNC_START(__pi_dcache_inval_poc_nosync)
+	_dcache_inval_poc_impl 0
+SYM_FUNC_END(__pi_dcache_inval_poc_nosync)
+SYM_FUNC_ALIAS(dcache_inval_poc_nosync, __pi_dcache_inval_poc_nosync)
+
 /*
  *	dcache_clean_poc(start, end)
  *
-- 
2.39.3 (Apple Git-146)

