Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16C22FE0A
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772316773; cv=none; b=IOoK/5TqSfOnenjeJV1HzEugyteUs9+8hQGpKFG1GgoI2vuX6S92rAmOmNOlBq6ycCCAvsB0Fo/wi19/e2Jb9aaQcjhiDJVeL62A8U8t/Ee9jHn6Im1r4czHlujYWbg+zKQ/H3P9Z84hxyD5JgQm8/lWR5u6F7ni9/cG6OEvJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772316773; c=relaxed/simple;
	bh=R4Z0bQdXHozMo7rEHrMh916hG7Ghsvzonic9nrpWi1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sk1ewACQYR2Qu0Dgq0SXNZiyL0qiYd1i4pA8yB6J7gWoCy6ziGXc4TGhy1Z9F0bC1jD0TqzHniIJaAeFdNhlEGPfsIq+zEOGMwT5OYtBDnIxaQpL4cWMvXxVbdCbegnfNrr/2pVYDg9phAGHYDmYNw7vbhNmNLbITkA0mn/xClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6MkdLVh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6MkdLVh"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so1727773a91.0
        for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 14:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772316772; x=1772921572; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvx8E7qiB01vJhqM9saSuJdmjeUVy74XGiStAmL658I=;
        b=k6MkdLVhSiBYaZoogro/4b1kHdwRHDiNFzgskxSwj+Jt4anvXFHtCBbHBY/ioLttLO
         8ymqeUqcvpwWuEGNOJ1Vl/IthuDWj2+WPSmIfmm+BGRUWkfvUYfS1ecY8pDIuWvkBA3Y
         k+EnT1D4+L1TOuQ6F5r1WZ960NnpWg4nPDPe0kCUPx+pCLg7T14OAkdU70CjdZdiJz90
         4zn1zNwccVhLx5NxOF+oqyZ+8azm5omQfG3qexDKb/2TidBoLTYQyGkfPbwwL14VxRRa
         ovwtty9ZEImXANMw2V9o8iM5v9CU6jOwXAao07zI/5wNWY080XLP9PZN10bOz5NV7UGX
         gfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772316772; x=1772921572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvx8E7qiB01vJhqM9saSuJdmjeUVy74XGiStAmL658I=;
        b=L9q61DOUllXQEn7qFwS6e7pn6wB/89c9IBlISpn+eqBXWsuwBEg03TE0EJ2G3d9DMZ
         g/7AHBbLod56LRYff+8ENb7PeqFcYmY5ZveK6PL2hZYA9KRFPxPYkLS3Lct43GqbFP/t
         ph8hX+DaY2vE3KZcEf+VmrRs1K/l4/a7GAONSnByMirnf6uAX4vZWxIC3JNr+lkpciFF
         agPPGwfWrBcdqDuenyiYLrHbCMmZIC0KhFUhYRmP0hWcZsjuURK93PNSUlGkRmyWqWlZ
         8Ze6VPiOGj01wcPs3TvkA89+tCd92WAGP/0XRtsqfNi3t5fSFwx396N5ioY92ippUpqM
         nLHw==
X-Forwarded-Encrypted: i=1; AJvYcCW2+bZcJBh4g7Q8+4Sf+4suurugM3cl4mflKpdRGfhp1EJ0CdrARkwH5W6gCGOniheLT8V7hA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc9AGEr5Pv7CMn6kAHhLTK6Mmc0HvwuEOb4nYeBK7UY17OgebK
	MfwJWbfrlRt39v63XCxiG1vCdEHVaPWueu/SrSKF6kXUAizQgBXnROiT
X-Gm-Gg: ATEYQzx0j84QXT05IG8cmVslBVOUbOp1w7Voz2/cZcntHGLmQret1s74p/P2kTTV/ml
	t2OfqfJUnsaLMgT4zpTImJfN69cvjigO2HUL7eZt+CqiLfFoJiZ8jgYcpv5rPLXi3JlUoumMlR+
	ZwcaI5b8FJX9CLTMZkZXxSA1fi8C43XNEdZ1qh+2bdahOaDBSGOMdjGQ9Nma6lIjUru1raqyCNc
	jcCaK/nvdQnMPWCt+hn8HjFiyKCI+avoBncKL2/+pZDmsgW6AMK+TtsN9paNgEbF0ecSBd6rn9f
	dzO8+Oo6dTvZzp4Po2UKn7ej/YaqMTTm8JI2v0Kaehb2y2uTHSK3uk6Z4HF+8AJ3ujD3eikCYTx
	78tyoSdAaziLTNSmpmdn4K8AgVRE33gqbFbHYQ1sSBwiwKBy1zV5ZZVtc3jha24QnUZYfvrdTj4
	ilOg6m4QkOx5HIOaTzCwtcnYMcwHrvjO/NH/c+
X-Received: by 2002:a17:90b:4a89:b0:354:bf10:e6a4 with SMTP id 98e67ed59e1d1-35965c4d062mr6628977a91.9.1772316771396;
        Sat, 28 Feb 2026 14:12:51 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ea0dcsm7349601a12.3.2026.02.28.14.12.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:12:50 -0800 (PST)
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
Subject: [PATCH v3 2/5] arm64: Provide dcache_clean_poc_nosync helper
Date: Sun,  1 Mar 2026 06:12:39 +0800
Message-Id: <20260228221239.59903-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <baohua@kernel.org>

dcache_clean_poc_nosync does not wait for the data cache clean to
complete. Later, we wait for completion of all scatter-gather entries
together.

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
 arch/arm64/mm/cache.S               | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 28ab96e808ef..9b6d0a62cf3d 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -74,6 +74,7 @@ extern void icache_inval_pou(unsigned long start, unsigned long end);
 extern void dcache_clean_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_clean_poc(unsigned long start, unsigned long end);
+extern void dcache_clean_poc_nosync(unsigned long start, unsigned long end);
 extern void dcache_clean_pop(unsigned long start, unsigned long end);
 extern void dcache_clean_pou(unsigned long start, unsigned long end);
 extern long caches_clean_inval_user_pou(unsigned long start, unsigned long end);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 503567c864fd..4a7c7e03785d 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -178,6 +178,21 @@ SYM_FUNC_START(__pi_dcache_clean_poc)
 SYM_FUNC_END(__pi_dcache_clean_poc)
 SYM_FUNC_ALIAS(dcache_clean_poc, __pi_dcache_clean_poc)
 
+/*
+ *	dcache_clean_poc_nosync(start, end)
+ *
+ * 	Issue the instructions of D-cache lines for the interval [start, end).
+ * 	not necessarily cleaned to the PoC till an explicit dsb sy afterward.
+ *
+ *	- start   - virtual start address of region
+ *	- end     - virtual end address of region
+ */
+SYM_FUNC_START(__pi_dcache_clean_poc_nosync)
+	dcache_by_line_op_nosync cvac, x0, x1, x2, x3
+	ret
+SYM_FUNC_END(__pi_dcache_clean_poc_nosync)
+SYM_FUNC_ALIAS(dcache_clean_poc_nosync, __pi_dcache_clean_poc_nosync)
+
 /*
  *	dcache_clean_pop(start, end)
  *
-- 
2.39.3 (Apple Git-146)

