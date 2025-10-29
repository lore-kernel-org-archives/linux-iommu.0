Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E127F00A
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705120; cv=none; b=lDZ7Q9PxIhCGZoT08B+ll0HTJ9mwsAYFoL9azgIiUzoQkggiG52ZTEXHh9FyVpTaDzKjAAXD/K4D3TvPV0wnjoXOxdUeqUs5kbchzaiIbRWujUWsgBYr6I9rOafb7xv/9xTtNYeOUQQ9OBU8dfge40vTUNYLXGdNQqnRWDUmteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705120; c=relaxed/simple;
	bh=xAcUDyR46r3eyTpxz6DzBXXtrvoA66g03wdR/Ic7OY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sd/waB1v0er2DK/ARiheS+P6Lzjs6Dhx6K3iBFBHySmE+t8xsuvZkK7LfVnRxzW702uNPWQ8Mdgnjm7hXulMabtt7adOLW4g71tjicKxY/SY9c1UCDxbm69YfJickuWOZ3LMS0JY7VeGVJryy6G5DZ+1gMIZfl5B61NVvSJS6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx5986jC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx5986jC"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a27c67cdc4so5360683b3a.3
        for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705118; x=1762309918; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8IHS5hbKcNzc4xX1pj2JUqHqgY0jEt1+7hP5OgmCMs=;
        b=cx5986jCs8OBZkp0elgGAVLiSbXxVGeWjOelmC71CWWbSzRXs60Cwa4K5XjrAtm45k
         Y7IhsCD5NW2d5bkNvc9UFWveLBO0wIBGyJSBHmZLuXZVHJUlICUEmgSnfZqnH1aLqasy
         OZklkUsNHDbQmKVNF9HvKj9xANBDGxcdHUWwiLc0pXTuJHpYj5ZkGCy7YfC1YDaHqZGO
         akeC+zR4ntN/StI7/pAztTC2gzCQlUJdAphpf5mrC12jv74G39LZqelii7eTTCVBIrP4
         SXc41zgLAdX9LSGWlmBeHOTbZLjqwSOI7vWsAI5J4Zgn/ISldO80LJjWsqcv2BlIhWU6
         giWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705118; x=1762309918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8IHS5hbKcNzc4xX1pj2JUqHqgY0jEt1+7hP5OgmCMs=;
        b=egJyp31aJkdsY1SKMN4XYdmbJWfrgY/yMcFf6cFJSRBu4sQ2giJc9hBUyw5qanVzu8
         yztTYXU/cMYRqByyLadJM8xRItn47p1PoYtH5KVYfoej4tn/nt29x7d4GOcIujxy5wQB
         2Ve86t9woUeEn/+uk7/RkxaBPjcow/bQJSuGYPJFi7AJZmiRMNu1CjRp6fDyobdYIQS1
         qBXOSSRz5279aLI5qiaeWoVlYVbgkJBGzzvsPBipOqmswnXpkwcjguTJITxnMDtS9VAL
         qW0zU81cUudd+3xzTvAiYIWQn/v8JhzFzmLSvIKSweig8Oqz3YYbdV1jDJ0k5P13T/bv
         ZjNw==
X-Forwarded-Encrypted: i=1; AJvYcCXhcf7UO9JUmVFl/v7TTsfrl+z338gI5ZsEalI/BA0wLUamXBU1np+sriH+Ngb6L66ofa67aA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzlKDGX7PoID22MECQgJYfHk7lZOcaRUL9L/bIRJgXS3bD4Ws8t
	irdrEOPZwuxM2kG7sHcp2AKI6fz8Xo3h4gkHbpoXlfYPFxi+CFvDOPvR
X-Gm-Gg: ASbGncvA+kGZeD754sfQaykW8xqg2WmspUraEqkCLoRgc1MCqye86GarfnmywUP/FSL
	pYBJ1ilxa6jB0czCJjwMecN563nw475EPcpcRdlbvCX+5+DDkkQxIJEGNshoZ2he3s2DXm0bSRM
	auzNVFLE/o/CnoscQazq7txEmxz/mqyNI6PzTJkDo/HMnrbmGUoPcPrz6tv/MaP8kWC9kWXoNpg
	ntWEvQdygNRL812Vm33m7Mptpo1YwKnYbWfzXObbQJeLZj0xMwhFWj0+cfXJnExp2ZbLtIwSuZd
	W5UiIGlrusipX5BpS/wEqQByxUHPsavqBIcriCNo+nW9lPfYmGx62D+OnEYkvSnz43Y3FM+bzCa
	KXRXoVyey4RniQYuKZ2baTyp//LyPagURSahoMz6lfxPWILLpwum/sU2rGX7PP0tJTwGqfWm33X
	bugpohNpBYmC4Vq6m+QxQvDl7mA6Evs77eGmfbxF9vMgbr7GijWlmjW9YE4w==
X-Google-Smtp-Source: AGHT+IG+neopqqpPz8pE4OPY5Yo0pVr1dn6PvUKKBu7rSRz5cLkoZ3c+NU5U1HLhCN7SM0Z/zmD0cg==
X-Received: by 2002:a05:6a20:3ca7:b0:344:97a7:8c60 with SMTP id adf61e73a8af0-34651b39327mr1494729637.17.1761705117917;
        Tue, 28 Oct 2025 19:31:57 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.31.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:31:57 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [RFC PATCH 1/5] arm64: Provide dcache_by_myline_op_nosync helper
Date: Wed, 29 Oct 2025 10:31:11 +0800
Message-Id: <20251029023115.22809-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251029023115.22809-1-21cnbao@gmail.com>
References: <20251029023115.22809-1-21cnbao@gmail.com>
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
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/include/asm/assembler.h | 79 ++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 23be85d93348..115196ce4800 100644
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
- * 	domain:		domain used in dsb instruciton
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
+ * 	domain:		domain used in dsb instruciton
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

