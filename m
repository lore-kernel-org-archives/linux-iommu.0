Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418AC199FB0
	for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 22:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766789607; cv=none; b=bOADN63Owd6jXqccvbg8WlLUyl7Do4hRMMn4wdnxw3j4UkTmHblO4vQRTLst9soWle0o/QqofaW0xw5R5U5mVPadq6g/Uq8Qm2+0ZQDm0pUbcjKUsyPP5sOHgKI0l5humF1ombCP1goBoUP4AYUH6WODjTHvL9IxFyLxlfJybfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766789607; c=relaxed/simple;
	bh=H9oEURFppzzQh4ad5CY+gHDo/cE8xRpGzvsht30sTGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JO1EkYBLO0TnVwlYIUCIdaEBdz+thR/3IqP1bpszFiKDmmOb4ZEVG/gBWX8fY/z1tzPtwkJF6qx65AGwIXYlwHSQHigW7/WsipQKAbwxRQXuJmuHG/xWHWXrz73f0XMh/BHZJ/JowvpVPsS0cXUabjuespp/9Dp7t4lXAkfjbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DShZttX9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DShZttX9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d0788adaso67078695ad.3
        for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 14:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766789605; x=1767394405; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YZZU/iwW88zjNDDGdCYX7IlRTUynqMqN8pEJHwT790=;
        b=DShZttX9ioNcfsipaD3q+z6QSg6gWWFpCcU3LkKbs8scewRuHaZ5mcGLnFWjSEJPTC
         dtAaCIADT0tFQDPalbrewDqH4Isg7NiOUs1G/Ctqvv5IsCqxJYLMTnLN1LDvBYbPa8ZS
         QDkNlClu0ALup7SAskfAmac9VrM8Ia2Mao0iA3tvWDqYWGxHWgLxhs+/VjU4Rvw8Armt
         7JwzsW5+rE8u5iyIMnT3qSIkDWLmKLPSISmnYV4Q82eNIHacGhaSVLIa1nw89zQslgfQ
         V0CnrSdwIp9Hzg58Kz72IKDxNFKBHb4kVgSJBkm60VfJt4RsAzbd2k/Y9J1j5OkIjcng
         UOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766789605; x=1767394405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6YZZU/iwW88zjNDDGdCYX7IlRTUynqMqN8pEJHwT790=;
        b=dD4cm4n1urDpxsoH1DEOzPeWqIdlcBPeajD3ixFWbjPZvHAiJXY4KCwyeOuROre8uI
         OqiGuqSwgV8Qxp21iljVtLIugTAdTls1K2ZVMKZdmbuBZ0UHK4hMupoYupzS5MoA1H6d
         WKlAXD/FHwW8Ons2aNi4o8+VTHMuhWmYuvppr5CQn/vr6StN/TmJmHMGW+wwUNggpf7o
         0YrYG2UdF8Dn8YDwk0OJSKcPJnyKmPW0Hdehs6Pz6boVvgISYfDK3TvIQjy3/YGapCvv
         T8q8aJVuJx4Dtj846zzzhbv1sMMIy4cJ/JcBfciF8VMbKM1C3VYn4P23oVmj3o7PAMVe
         2lfg==
X-Forwarded-Encrypted: i=1; AJvYcCWe5+zavxClOcQdG8O2P/ceM/rK9bQRZuvBdKzCF9neg62q8gTgnzP89Hz06eoJZNHvjuNyRA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yza5yBX7DVw/oA1zB+CZQsmV4ZE/Uw3Jsi07ImZliQQXVyS3m4l
	5+I1DHIFHkJ7PWuJH2Ukl0pKzfOgCy+PwBAjgeR+BldRlvx3Mp7rFxqg
X-Gm-Gg: AY/fxX4DZP+V3Vvkyzi8mbB+qQlL6PcBKdAQb73tiP912lADOBfS/s/25k7nh2j9ex0
	oLmtITakqLmW9sfNyHPhRW4PjdrHunbY1R2MkuxZ8TvcfZRxKktrxdE/1d85HfpEfU2R1bzpa5+
	RGjFNodTL1nfpTmK+B35Mbqpgd+BdhiDEOSG1oraLVZXfeDGX9w5UWsmT7oebSCckpHXVVHyuqn
	X45t1aT2JPXkBWmenMknXq4hQT+XctMghCgtEg1oW99amNcmGmqOs0zZn3LPHOsLH27N445sZvL
	RAIN0cY+TAaNpagKam4mtbZVAGX+ptlEWPV//JcDiWeeLURUvPWnolRbgMrMll12Q08Qd2h+z/j
	mrlW9zgoNyHwyPjX+peq4+XUJnnA9lVN78+pXXvUm0RWhDu8DH8/sTzw1ASGYl4sBGeBv0NjSTM
	jL5hhKxAHFLME7
X-Google-Smtp-Source: AGHT+IEPpw6k3H5B3GfQJ5gfoJrvfI68uwFervPMjcjEQdlc2KG+bnnPwgqGQJuYg9SuR5JsgGZOMA==
X-Received: by 2002:a17:902:da81:b0:2a1:c72:a41d with SMTP id d9443c01a7336-2a2f2940678mr262079485ad.40.1766789605397;
        Fri, 26 Dec 2025 14:53:25 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm9981428a91.9.2025.12.26.14.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 14:53:24 -0800 (PST)
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
Subject: [PATCH v2 1/8] arm64: Provide dcache_by_myline_op_nosync helper
Date: Sat, 27 Dec 2025 11:52:41 +1300
Message-ID: <20251226225254.46197-2-21cnbao@gmail.com>
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
Signed-off-by: Barry Song <baohua@kernel.org>
---
 arch/arm64/include/asm/assembler.h  | 24 +++++++++++++++++++-----
 arch/arm64/kernel/relocate_kernel.S |  3 ++-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index f0ca7196f6fa..b408ed61866f 100644
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
+	.macro raw_dcache_by_myline_op op, start, end, linesz, tmp, fixup
 	sub	\tmp, \linesz, #1
 	bic	\start, \start, \tmp
 .Ldcache_op\@:
@@ -402,14 +401,13 @@ alternative_endif
 	add	\start, \start, \linesz
 	cmp	\start, \end
 	b.lo	.Ldcache_op\@
-	dsb	\domain
 
 	_cond_uaccess_extable .Ldcache_op\@, \fixup
 	.endm
 
 /*
  * Macro to perform a data cache maintenance for the interval
- * [start, end)
+ * [start, end) and wait for completion
  *
  * 	op:		operation passed to dc instruction
  * 	domain:		domain used in dsb instruction
@@ -420,7 +418,23 @@ alternative_endif
  */
 	.macro dcache_by_line_op op, domain, start, end, tmp1, tmp2, fixup
 	dcache_line_size \tmp1, \tmp2
-	dcache_by_myline_op \op, \domain, \start, \end, \tmp1, \tmp2, \fixup
+	raw_dcache_by_myline_op \op, \start, \end, \tmp1, \tmp2, \fixup
+	dsb \domain
+	.endm
+
+/*
+ * Macro to perform a data cache maintenance for the interval
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
+	raw_dcache_by_myline_op \op, \start, \end, \tmp1, \tmp2, \fixup
 	.endm
 
 /*
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 413f899e4ac6..71938eb3a3a3 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -64,7 +64,8 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	mov	x19, x13
 	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
 	add	x1, x19, #PAGE_SIZE
-	dcache_by_myline_op civac, sy, x19, x1, x15, x20
+	raw_dcache_by_myline_op civac, x19, x1, x15, x20
+	dsb	sy
 	b	.Lnext
 .Ltest_indirection:
 	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
-- 
2.43.0

