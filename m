Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3C2ED17B
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772316752; cv=none; b=pFy8pkmeAeB3sFZXRouRqzn+5T91dNVvqYZlIJKISIrHc/rMVGGnrJqhMiZEClBM1YrdYRGDznMmLYA6o3UnAuNcwhrQmnl+H7Tw8BPvyFuKo0hr1PqwpF+Gue+KWcLFMyqHkpJbgoFz0C+MG+fKwkoZBKK0lCTBFc1NDvNOtto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772316752; c=relaxed/simple;
	bh=95QUKWKyJpuoNGDweisKORZ5zdH04uqtK0SxRHMAmQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fjPT+bIksOyN0HrS9mgmIGV6C2Tp2k/AtqWKlJs9diiVgnGWQsAv5IF17tjPkWG65lkQPtRlne7uE95xD/Kxc/et3jTbUhxw32ookFLgl27Yi0cuHks0oMEljlRnui8VfTOgUnSbIj4rOMja041Z9v0ELSIoM0zhccda6YCAhxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB6vGze+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB6vGze+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad9f2ee29aso19336245ad.1
        for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 14:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772316751; x=1772921551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b1vxRCPG0GEyJG0dLWnSAzn6wjV232WVUDRNGvKP04U=;
        b=GB6vGze+UxXPxRuLClJYjzbOJYXL39zkF8u2IC52DXYqvBuScFxzSUMwHxTMYE5zwG
         ObXfB82TZQbtJ+fIO4RJxzoLD8fh96SGjbdkoOoNh+F/blZ5ZqIjpWBK3ZTwOkwBEcWt
         0l+k9gm9+59ULPFRuAxJHXmzzQtkI3ijaGNiIkrXP+2qH26Tz2AsjTHCsP1iHFGjqWka
         02t/PiFKgYOezNztnLngsYt0OnzXdLEly3+J4/O9P/Mf4lCgo5WTs9UH2Lt8okEOn2Uw
         hUrTwm7rTrZOt+VYwxKk19jaPdeBteK9B5t9AFKX7Ljy0f7SIQkSpm9f194e/dkb+Pvq
         lcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772316751; x=1772921551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1vxRCPG0GEyJG0dLWnSAzn6wjV232WVUDRNGvKP04U=;
        b=xCpoPM+s2sLaBq4W1n10XqdUXrB754pnS549/A9zCvqaXk7t3Jdye8Sj3Qrg1tzwZ3
         jl3qqzeFSglfnek7mwRLbG8v89fDQQ3MZ1KnZGpd9/YP3q8NrweKLgwFq6eQ0aMs0Vir
         +X/qQ/IhC/rHkVgRVWMj5hjB0TKNd/D8SjHb5vaE5+HqaeQWYRK5GiGACOT37NvhdZHx
         t9K9lJo40cLt+yu5Z6fGF2zGrmBPaGRmUEudfKMcSCXvqfLcjAoc6k+rAvRLSE8UdTrc
         OlvuXLUeCw5vE2rzmS0KzEHjY9SkFB9WxD4InBiiqrZrACVFVGx6TqtadtqAdBFDLT3Q
         t51w==
X-Forwarded-Encrypted: i=1; AJvYcCU00JFOG75WVyf0yjUy1f5zyyZr7D3SIjClfXNlklkXP4qJlLhPqTkd22WemGyQ1OsBN5iBwg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTLKmN5bcA2yGtUJr+XJ4nCWTp0yeSnMElwgE3GgVgbYGcN9gn
	fXW2pSTUdNGLSZC5Ha6aEbB/Jee0WCex5r9EHC0mKIn02FSERVM8YMKX
X-Gm-Gg: ATEYQzwVM/LrBD0sKI/ROW81J6znqUJYzMUg52AYHUMFJycI1SwNpaIbsCfd53rzmTn
	m6vyEBvzWXKj4KNqPj30UssE7fTYRnzGN7TDVKsqyytaD9pm6NV1uw457c1LkuTHRteAs1yLItu
	sQFHafwptCoCpa/tRNKD9swRHQVa2GiYyWAAbsg9f5vvn7Fx212kF65A/u5vj87U7K26POOiOsi
	YocRn9josFcpMhJ1E1cXHoFQqnwuL8Rq3CkI2OGBcjf6faQ7tef4BB9LuNBqyha60adIBh5M2xq
	3j1uI5xeabx97yrBzmrVJgaLuCpwe9DjLsSZ0JtTuUXzOQuCPcy7JBI6J1BSggXy6nnEGFCuVgh
	4Y7BUfZ+BdxjIlvZ3byPU2HH4Ie2sc8BSakUipPKa98dxqmCGn80VZCWA1L4ULGzMshlMwLqLjq
	1EkCrLe9luhsfzA7L7wymRL4Yrfd/j3Ml7WAof
X-Received: by 2002:a17:902:ce91:b0:2a0:c58c:fdd2 with SMTP id d9443c01a7336-2ae2e4b0e92mr83742325ad.26.1772316750783;
        Sat, 28 Feb 2026 14:12:30 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b4160sm89495125ad.64.2026.02.28.14.12.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:12:30 -0800 (PST)
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
Subject: [PATCH v3 1/5] arm64: Provide dcache_by_myline_op_nosync helper
Date: Sun,  1 Mar 2026 06:12:16 +0800
Message-Id: <20260228221216.59886-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <baohua@kernel.org>

dcache_by_myline_op ensures completion of the data cache operations for a
region, while dcache_by_myline_op_nosync only issues them without waiting.
This enables deferred synchronization so completion for multiple regions
can be handled together later.

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
 arch/arm64/include/asm/assembler.h  | 25 +++++++++++++++++++------
 arch/arm64/kernel/relocate_kernel.S |  3 ++-
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index d3d46e5f7188..cdbaad41bddb 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -371,14 +371,13 @@ alternative_endif
  * [start, end) with dcache line size explicitly provided.
  *
  * 	op:		operation passed to dc instruction
- * 	domain:		domain used in dsb instruction
  * 	start:          starting virtual address of the region
  * 	end:            end virtual address of the region
  *	linesz:		dcache line size
  * 	fixup:		optional label to branch to on user fault
  * 	Corrupts:       start, end, tmp
  */
-	.macro dcache_by_myline_op op, domain, start, end, linesz, tmp, fixup
+	.macro dcache_by_myline_op_nosync op, start, end, linesz, tmp, fixup
 	sub	\tmp, \linesz, #1
 	bic	\start, \start, \tmp
 alternative_if ARM64_WORKAROUND_4311569
@@ -412,14 +411,28 @@ alternative_if ARM64_WORKAROUND_4311569
 	cbnz	\start, .Ldcache_op\@
 	.endif
 alternative_else_nop_endif
-	dsb	\domain
 
 	_cond_uaccess_extable .Ldcache_op\@, \fixup
 	.endm
 
 /*
  * Macro to perform a data cache maintenance for the interval
- * [start, end)
+ * [start, end) without waiting for completion
+ *
+ * 	op:		operation passed to dc instruction
+ * 	start:          starting virtual address of the region
+ * 	end:            end virtual address of the region
+ * 	fixup:		optional label to branch to on user fault
+ * 	Corrupts:       start, end, tmp1, tmp2
+ */
+	.macro dcache_by_line_op_nosync op, start, end, tmp1, tmp2, fixup
+	dcache_line_size \tmp1, \tmp2
+	dcache_by_myline_op_nosync \op, \start, \end, \tmp1, \tmp2, \fixup
+	.endm
+
+/*
+ * Macro to perform a data cache maintenance for the interval
+ * [start, end) and wait for completion
  *
  * 	op:		operation passed to dc instruction
  * 	domain:		domain used in dsb instruction
@@ -429,8 +442,8 @@ alternative_else_nop_endif
  * 	Corrupts:       start, end, tmp1, tmp2
  */
 	.macro dcache_by_line_op op, domain, start, end, tmp1, tmp2, fixup
-	dcache_line_size \tmp1, \tmp2
-	dcache_by_myline_op \op, \domain, \start, \end, \tmp1, \tmp2, \fixup
+	dcache_by_line_op_nosync \op, \start, \end, \tmp1, \tmp2, \fixup
+	dsb \domain
 	.endm
 
 /*
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 413f899e4ac6..6cb4209f5dab 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -64,7 +64,8 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	mov	x19, x13
 	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
 	add	x1, x19, #PAGE_SIZE
-	dcache_by_myline_op civac, sy, x19, x1, x15, x20
+	dcache_by_myline_op_nosync civac, x19, x1, x15, x20
+	dsb	sy
 	b	.Lnext
 .Ltest_indirection:
 	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
-- 
2.39.3 (Apple Git-146)

