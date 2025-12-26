Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4D7081E
	for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766789623; cv=none; b=SIzCLq4iONRcBONk9ZSTTNLRyfq9vM2I/wdhpxh//QXMeE+REKFaBhcVPb7/9x+/J1ablw9ZefeqkGO/DgnXHOzEMci63ueeJIgPtZJfdc4JYXR95tMP9aGkLCHs5tQp4mtrr98mfgJrgAZBUUTHTfF7WDlxuWpfRt66ngXfqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766789623; c=relaxed/simple;
	bh=5FIlQ7B2g8aH8yOFAn3F/4ED5Pk7hQam/ZJDBiZWQVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wip2r9lUmvHhPBC1f7BBEqgE+O2NmCx7g6rcDYYkrtBnQhVsVB27ONMZqMj9swu2TX6gXO31P47OkoFlzKD04NIEAx/3rh/X7XYSJID35pW7KP9B4ZUSavaPi4bW94VHWyfsKMpppjEA6cMcSKGS+GqM6Iz4NS+6AYPzpGmsXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISw92kgc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISw92kgc"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c3cb504efso8663767a91.2
        for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 14:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766789620; x=1767394420; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrpYuFgGuOqDarimfgNWi+H5QYEBWUzUVIbcnmljV6w=;
        b=ISw92kgc1NfEwpVVRrkX3slxZYElf11B3+SOtrY1VT2ADEg8MwbJqeUjkDdZVh4ayl
         Mqsgks56dbzVeF4BZNW+Rv+P9ZfTZxCYASK6zplwQ+Nh72pnXKWTIueqGA6zM8i5d8wh
         ECEXtJ4Ja9vDte8eEK+NlXeDo6Kbwwm7tiVrxc20WuR2X7cCVeY07GnLZa9DGn3unscg
         DDcLSlqt5xcN1HWGDbOELgul7KJwl+3G1I4o3cf1PJp9yIsqh82wr5rsGiAIQdxRXRm4
         yVViuqZ9ArUUcZAk59g87UtfsENpNsONmRsS8s9UnqNWVHqM/ZC6ruYqamX5c+tjIAGm
         AyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766789620; x=1767394420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XrpYuFgGuOqDarimfgNWi+H5QYEBWUzUVIbcnmljV6w=;
        b=ZPvSLl4M2Wpt4jTETxTiWsU2sRExUj6H+mHBNptm2c2GlLzSI8fmrFtsCRSaW3WcaG
         XX0ufbRyejjFvmVfrVnuS2zh4HiXKGDlVNbHfkoO6sUFZr6lkA6sBy/LyTmToZGcHXCy
         UNPX4ru187OA4R952UKrxjIF6jvZGbg0R0u56PVaDYynN9DjBPhvGbU7yCmEgvmYubt+
         XGHChvAUMVKL9czUPe1y3TdFHyMTmUSrhBO/tv6ET2HsNJ1VwN50UoMav58KDPZzR65G
         /Fc/BNcjQPnKdlqSfOyCR3jxJg7EVlKyHwwS3bCKZYBwHrdauUbySoXmTziuKiW+cPpf
         /dow==
X-Forwarded-Encrypted: i=1; AJvYcCWK153IVukb3Ono7fCz4sjItavB/ccyNn9lpXYtEpTI5Ut2AAvPt7Ezb//mXcwxg4Iy1NEgCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpDJqIZx6u6kr43kmruJTATJuqawJOFVYGJx8RCK86AfXDiv+j
	4CXXStn5KoPggnsBpvjz4A/+AECE2rLPJMtt4Wn0HryptEGJz1QyXtMu
X-Gm-Gg: AY/fxX48iqpTVKdM4a8hyiDA1uG0L+4cEwkhhpxqRJGe0PaSOTOAHWtxvF5PlQO0eYg
	JBEseUMEHwmEkgL9ZdvNz6rtEM1fo+ILMJOlqAYN2ekCBDb9koP0K34eyrU0UMmbdoxFnS8aCUy
	Pxk45nP9DhiQMJFxzxuuWUo5KHLmpY9WA12i8iAQHIGoJQQ6O9QZpG+6W14IqxcMK4v4bL19c7W
	o+MOTn1x6pYuTQfjNNUpIs709Yo+606WNJQwWA4dm+UksheeN1/CpUx1Gx2AqFx+b16jcA4Zqy7
	3BoV4ubnIL4MtAm/4V8o8I+6xbzKSk56aFrwJTKMpg+axc73+IqjZdNt8v2z52H9cPC0QUHUt+y
	97dHkSsvhbO5MIkQ3zjOrFW3PmLXVaLl6v9UU0L+EvS+f8KRO8IBns7faMBFPAp5HrgoxNtWxES
	dHAglxvSosSwvC
X-Google-Smtp-Source: AGHT+IGZAwVjw6Q14Ldbj2NnyfuDwpis8NstpDAoaBbm3hUZYJbQhE2SG8A3iUeExaHFKxkFLgGP9A==
X-Received: by 2002:a17:90b:528a:b0:330:6d5e:f174 with SMTP id 98e67ed59e1d1-34e921b05f6mr21341646a91.20.1766789620383;
        Fri, 26 Dec 2025 14:53:40 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm9981428a91.9.2025.12.26.14.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 14:53:39 -0800 (PST)
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
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: [PATCH v2 3/8] arm64: Provide dcache_inval_poc_nosync helper
Date: Sat, 27 Dec 2025 11:52:43 +1300
Message-ID: <20251226225254.46197-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251226225254.46197-1-21cnbao@gmail.com>
References: <20251226225254.46197-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <baohua@kernel.org>

dcache_inval_poc_nosync does not wait for the data cache invalidation to
complete. Later, we defer the synchronization so we can wait for all SG
entries together.

Cc: Leon Romanovsky <leon@kernel.org>
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
Signed-off-by: Barry Song <baohua@kernel.org>
---
 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/arm64/mm/cache.S               | 42 +++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 11 deletions(-)

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
index 4a7c7e03785d..99a093d3aecb 100644
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
+.macro raw_dcache_inval_poc_macro
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	tst	x1, x3				// end cache line aligned?
@@ -158,11 +148,41 @@ SYM_FUNC_START(__pi_dcache_inval_poc)
 3:	add	x0, x0, x2
 	cmp	x0, x1
 	b.lo	2b
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
+	raw_dcache_inval_poc_macro
 	dsb	sy
 	ret
 SYM_FUNC_END(__pi_dcache_inval_poc)
 SYM_FUNC_ALIAS(dcache_inval_poc, __pi_dcache_inval_poc)
 
+/*
+ *	dcache_inval_poc_nosync(start, end)
+ *
+ * 	Issue the instructions of D-cache lines for the interval [start, end)
+ * 	for invalidation. Not necessarily cleaned to PoC till an explicit dsb
+ *	sy is issued later
+ *
+ *	- start   - kernel start address of region
+ *	- end     - kernel end address of region
+ */
+SYM_FUNC_START(__pi_dcache_inval_poc_nosync)
+	raw_dcache_inval_poc_macro
+	ret
+SYM_FUNC_END(__pi_dcache_inval_poc_nosync)
+SYM_FUNC_ALIAS(dcache_inval_poc_nosync, __pi_dcache_inval_poc_nosync)
+
 /*
  *	dcache_clean_poc(start, end)
  *
-- 
2.43.0

