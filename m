Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C64373BEF
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772316791; cv=none; b=uu3KwbFHh/be7AaFyfUmYEoK1EgYcSIMQAZa1O0+4VPlFopSZaoITxBT8ZYojDZCdAry1EYjA2kKB+ZDdnPYkVmXxi6SFyHXWfBIpeOKbTy6w/TyIHsCTaw/PtKBBhLMCSbMeUS2dN7PLYIf9Hm4WJntqpz3siUjwOiegjXt9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772316791; c=relaxed/simple;
	bh=l/SlMpQjR5Nv6Fda2YgvqOCKjewWa+qb2DjTKMxnKz0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jayvnIiRIn4RMq2UN8wFxQpTPVGB2RWFRoc6pYJMALtXog7VGNtlxzQjmwvEueFU8gtmV/BMgVedBRJH/QNP5PqMzr4wq+EqiapYB1NX3syHKDH2IH5wDhXJsbL9vjyMbPZbBhRy4w847xp/diDtiY0LZicgREloj+2BRrzInyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGLa2pls; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGLa2pls"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab077e3f32so14130545ad.3
        for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 14:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772316790; x=1772921590; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b6WpdJ1Uj/mNRIGGoUCingnccNT1bUYjuIwJgJ29my4=;
        b=RGLa2plsCNTBnzTtUyTlUzvY+iJXwPPV/ioWE9IaVHt1DlDSM44loj1dleUSfGCGAe
         6mc67+N9eJsywItK4iLqhd9NsG1Ox6h/owERKHh2U4XdszIVE3KusPvLMhfCOPohtxQg
         IYdXyzVxuBjpsDLLtDz/nP4DOOgiUDCDjD6zY0ZSu8C2CYv/9VfCFM6BCb9oRWbl2rFS
         vugYOSQDDFc5yGn+sRclf5FumPMKofnNQhNk4DgUHpxDb957ZyNWXy62jfUbc1oR0dlD
         fUMUB5zvBSRBsTKzESxRB9eSM3ig498KBR77CP2mwiYvL+DPe1vyCVq6BvDAizreKVDo
         0XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772316790; x=1772921590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6WpdJ1Uj/mNRIGGoUCingnccNT1bUYjuIwJgJ29my4=;
        b=Euivtx5JFsVek5PouTopT8v0dZTe0BQpL8DeWR9LPfx67kB8x890lBifIjOCNhOlAP
         To0OUzVyHM0C1m6zljQwYJAL0DARafxAZM65gsPuFjNvLNPID04T7O2RgoIPAxOCINUe
         ly5OHMiP5+TcRg9Z4TdNRrqu0D9rgWMxIj0FN/KTSXJRRQZnPi65Ph9l5VmZYRUmU5jN
         r3O3Yv9bSdhsTzv7ITHRbRX9JnmKlrrpgyQzdmLz8z/WGRthh5ywqdNPn8rK2yqEsTid
         r2wiy6abLRq03iuDqZM3xiUcF/0fzG1wky0JRm9s/efQV3wtI29NDlGRWnzBuxRlTrjE
         NR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFT9AJYkVBmbNYEnqT4e5uOl5BledEl6nR1Rmx+NBaBbCtuFvr5UxOOwV5Pmaoxzs6rwMv6A==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywce8tC3oE+aG1dN8rRaJARdT6RmZmv/+eqoeGVT2+OZ/S1TK1j
	JYmDsTLGD4lTaIVzpiTWBRpmpVdIXrNnoGCQhwrwEf3Mj0ZBh+YtKanT
X-Gm-Gg: ATEYQzwk7HTGRqqPJc9R56FK+kIFGHvf6R/2LCR2Q7iNlgNMDmcr9EEpKgdZmNBIiU9
	hQabFEF5+0oNkJokqk6NpM7maWKFZjepqIf8A9XPw5fhfeZLh+XzIMrYkr4uUpo4ngZGdb57yuW
	n/YoFg+Y4mRzlihm/YjWYcJU+F6D2BanMJfMmjMa6JuCewIMUr1M6kP8PdK9aK4GQoTUPZAxHm4
	ZM0YnAjEYO9d9Hzi9NYQA5vlKSsdaUxgiA8UwkOc4SFG1nAK+SsqTTfhVEuYSpRAeA+ylb8L6gu
	h3+eWARGgJK89aWYbEVl36+EXaGug8bTU1z4FKBHDQSjRFyo0HXKpDIlpL0WMA/If2a9curk68b
	ap/N4fF0OAIwwco3Bqw4t62icOOjMN0hAptYvT5Ego3VsYSP8W4/hE1v0Mm7aUi3ibb5TIbEnDo
	oi3P4janG+HQi6Okp2tywrKdBpHqmR659Gz8zX
X-Received: by 2002:a17:902:e88a:b0:2a9:649:6f5 with SMTP id d9443c01a7336-2ae2e3e5abcmr80828365ad.12.1772316789684;
        Sat, 28 Feb 2026 14:13:09 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm2927925ad.8.2026.02.28.14.13.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:13:09 -0800 (PST)
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
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [PATCH v3 3/5] arm64: Provide dcache_inval_poc_nosync helper
Date: Sun,  1 Mar 2026 06:12:58 +0800
Message-Id: <20260228221258.59918-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
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
index 4a7c7e03785d..ab75c050f559 100644
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
+.macro __dcache_inval_poc_nosync
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
+	__dcache_inval_poc_nosync
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
+	__dcache_inval_poc_nosync
+	ret
+SYM_FUNC_END(__pi_dcache_inval_poc_nosync)
+SYM_FUNC_ALIAS(dcache_inval_poc_nosync, __pi_dcache_inval_poc_nosync)
+
 /*
  *	dcache_clean_poc(start, end)
  *
-- 
2.39.3 (Apple Git-146)

