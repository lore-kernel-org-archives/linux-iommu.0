Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C06218AAB
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122639; cv=none; b=BLJy/+0j03Hv2hbCjZAO1Do15aj3/IQm2r5Dxq4iDgEMyZ7XhqzbQ3ieAypgpAkTJighpvHSHN35EQIiQCzrPVJOjfQEnMryqJukHsMov2Qah0jG224iuZfp4NLdS3/5/XTSEjB9Q5qsbSJ6gE+PCtZRLZWqKaLQQzQ9Czu97TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122639; c=relaxed/simple;
	bh=oXHMuHXV30gXK0zo04y1oVqzgP5bQsiQpukq82bkvqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBedxYxETXD5hrGpDQ7kThyBbfnqkoX+BCE03fYlZh+9FObgoM7i+tVl6AKBbQNHTgpHMjIWkYUtO6nJwwJPuSGS9ygyIqulo8xoqiPsaGkahW3y0Xu3CfvmCzSO2HoN28531uHeQq5O/rerektkrw7VydPVfljrRj7dKwaxIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY2VVbLS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY2VVbLS"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29efd139227so17772815ad.1
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766122636; x=1766727436; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NkbhnSjmQqWyentKViHSvnUd2t4Anb4J6Vl3+26IzI=;
        b=WY2VVbLS0s9/MOjIJ3d1zgOR0HLNtvYT0/76OXdVkuQ4XF03mwBEq/RUg92h0BVQkS
         bk1zcVB6TZfX6h/l+wZDM3eLXIuOBZWIvOa4VBY/5NwcY12J+KTYJ6eXkvCSB1/WHT22
         iRGckHkUwgDwh6unFu3UnrCyxVx+n6+WxJY68vOaXKk6jrIj7J5ifsM70VhyhaV4EsA3
         lZdUMBbw0labBsZpfCNrSjDhqsEspS7hEJMRXSIgiZ/V3sjW2L0uGSgQsN5kJkY6y5W3
         yzDQSyY4c6pf4UhyY03TE7NVOe13yK/9DvQPeP3Ijuw2+/R5WPsjOE9FIE790eP/1AP0
         /9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122636; x=1766727436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/NkbhnSjmQqWyentKViHSvnUd2t4Anb4J6Vl3+26IzI=;
        b=bn+EZvkUWnW7ium7HofEhoD/3eqbTPdXGFIhVQK7BD+iB9dnixTc9waO9gNKASM8Ls
         ZZjpsNX/dxKGPe87fnNBrlQr68CHtFH+CBsO5iIoJBNaGKAjC+w6uz3ymqjqRU30EYYw
         G4G0QUZPt7F/fpfq8/wCFmQIBzQ44zHj5eA1onwlMFUSKumBwLDNB6cGHD8vA+tZYeVc
         13U1+XKpWP1NU/Yw6qeG93m9Am6AcV1H/Z7uKotXaTRHNelWeudcyuDAjjre8lQtQMve
         edablevl7zh2dtWoyBVnTcobAZXzOKPqmSIfHCfj7cJTGUDTNJJ2H5mczi8e0e4ODG16
         +FHw==
X-Forwarded-Encrypted: i=1; AJvYcCW39nBqPnVdNs/geHVAnFbkvFqA8mAd8d3xhMYhdiu95B9FzQttVMxHN/t5OPj+Mfyw5kAWvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqgCW0vlfx2q7P0vXr/9KzBSYZk4/t+m4JcMoJGE5GoM7OEb2j
	6zwRqFDATEQJculgsWqQpK3ltbCaVBCuc9dvoYCi0JQHcQcBEmcpiY44
X-Gm-Gg: AY/fxX5O8BNSb/6v2jCrWF2VMotKsUEkwRZVpikVbdndt1m5If1D36Uzm8cV1VMufxU
	s2yjaIxJG9tfB6cR77ABYkPOKoPz/K4ZPSnBpZ9whyURV56M3URJ4z75d9LOfzTVruK0rQFvj5V
	UuRoVJHvNaq3Dp6GKfPuEqVeuT/Gu9oGw3KlXHlWwbEUBw0N3ZrAqczZ2dOWpCVcPG5tmvPS5xD
	8mWObG+rB+DmxQLv4HZ2X7bg9oxpFhQvKKl8jTVP4WGIOg3kEJSB1fGza7oFCTAEfKYJiuef09B
	ba1t2ZMfB5nb0GuZwplX5fUXfbpqhWsgsgc8IFImeiQp29eI8MkAGlbKGbTUoIEmTYv5MWr9a4b
	hu9VBqDXKNktYoEmspT4sL9g/TTJjpTPmP8pCBDIhbrLWainrCjjPYdltBFJWijD6j5j2/Syoh6
	st7omWEXA0EEOAnOnpa+hUWahYhB2cGw==
X-Google-Smtp-Source: AGHT+IFcyO2/N6WJqTTUC8Xpz+F+HK73QiRxiWGBBRL+WIr6e3loB6zfy831gEjAtlMYHTHv9HUDPQ==
X-Received: by 2002:a17:903:2290:b0:2a1:3cd9:a739 with SMTP id d9443c01a7336-2a2f2830ba1mr17129295ad.43.1766122636315;
        Thu, 18 Dec 2025 21:37:16 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d895sm9930215ad.54.2025.12.18.21.37.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 21:37:15 -0800 (PST)
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
Subject: [PATCH 1/6] arm64: Provide dcache_by_myline_op_nosync helper
Date: Fri, 19 Dec 2025 13:36:53 +0800
Message-Id: <20251219053658.84978-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251219053658.84978-1-21cnbao@gmail.com>
References: <20251219053658.84978-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

dcache_by_myline_op ensures completion of the data cache operations for a
region, while dcache_by_myline_op_nosync only issues them without waiting.
This enables deferred synchronization so completion for multiple regions
can be handled together later.

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
 arch/arm64/include/asm/assembler.h | 79 ++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index f0ca7196f6fa..7d84a9ca7880 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -366,22 +366,7 @@ alternative_else
 alternative_endif
 	.endm
 
-/*
- * Macro to perform a data cache maintenance for the interval
- * [start, end) with dcache line size explicitly provided.
- *
- * 	op:		operation passed to dc instruction
- * 	domain:		domain used in dsb instruction
- * 	start:          starting virtual address of the region
- * 	end:            end virtual address of the region
- *	linesz:		dcache line size
- * 	fixup:		optional label to branch to on user fault
- * 	Corrupts:       start, end, tmp
- */
-	.macro dcache_by_myline_op op, domain, start, end, linesz, tmp, fixup
-	sub	\tmp, \linesz, #1
-	bic	\start, \start, \tmp
-.Ldcache_op\@:
+	.macro __dcache_op_line op, start
 	.ifc	\op, cvau
 	__dcache_op_workaround_clean_cache \op, \start
 	.else
@@ -399,14 +384,54 @@ alternative_endif
 	.endif
 	.endif
 	.endif
-	add	\start, \start, \linesz
-	cmp	\start, \end
-	b.lo	.Ldcache_op\@
-	dsb	\domain
+	.endm
+
+/*
+ * Macro to perform a data cache maintenance for the interval
+ * [start, end) with dcache line size explicitly provided.
+ *
+ * 	op:		operation passed to dc instruction
+ * 	domain:		domain used in dsb instruction
+ * 	start:          starting virtual address of the region
+ * 	end:            end virtual address of the region
+ *	linesz:		dcache line size
+ * 	fixup:		optional label to branch to on user fault
+ * 	Corrupts:       start, end, tmp
+ */
+	.macro dcache_by_myline_op op, domain, start, end, linesz, tmp, fixup
+	sub	\tmp, \linesz, #1
+	bic	\start, \start, \tmp
+.Ldcache_op\@:
+	__dcache_op_line \op, \start
+	add     \start, \start, \linesz
+	cmp     \start, \end
+	b.lo    .Ldcache_op\@
 
+	dsb	\domain
 	_cond_uaccess_extable .Ldcache_op\@, \fixup
 	.endm
 
+/*
+ * Macro to perform a data cache maintenance for the interval
+ * [start, end) with dcache line size explicitly provided.
+ * It won't wait for the completion of the dc operation.
+ *
+ * 	op:		operation passed to dc instruction
+ * 	start:          starting virtual address of the region
+ * 	end:            end virtual address of the region
+ *	linesz:		dcache line size
+ * 	Corrupts:       start, end, tmp
+ */
+	.macro dcache_by_myline_op_nosync op, start, end, linesz, tmp
+	sub	\tmp, \linesz, #1
+	bic	\start, \start, \tmp
+.Ldcache_op\@:
+	__dcache_op_line \op, \start
+	add     \start, \start, \linesz
+	cmp     \start, \end
+	b.lo    .Ldcache_op\@
+	.endm
+
 /*
  * Macro to perform a data cache maintenance for the interval
  * [start, end)
@@ -423,6 +448,20 @@ alternative_endif
 	dcache_by_myline_op \op, \domain, \start, \end, \tmp1, \tmp2, \fixup
 	.endm
 
+/*
+ * Macro to perform a data cache maintenance for the interval
+ * [start, end). It won’t wait for the dc operation to complete.
+ *
+ * 	op:		operation passed to dc instruction
+ * 	start:          starting virtual address of the region
+ * 	end:            end virtual address of the region
+ * 	Corrupts:       start, end, tmp1, tmp2
+ */
+	.macro dcache_by_line_op_nosync op, start, end, tmp1, tmp2
+	dcache_line_size \tmp1, \tmp2
+	dcache_by_myline_op_nosync \op, \start, \end, \tmp1, \tmp2
+	.endm
+
 /*
  * Macro to perform an instruction cache maintenance for the interval
  * [start, end)
-- 
2.39.3 (Apple Git-146)

