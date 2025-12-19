Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE532BDC3E
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122644; cv=none; b=SQhmp+S7RrUZOZk/iUAFD1avFoOEKiCZ7z3WujWpRUXB1p9qf724RXaTiLgYEFvaiktxP3FUodEMN4r/K9keOythGvATinOzyz+HLHrNgesDk8LtY5HjEM11t1Pga0o/gqZPFVfROsbAsMdsl1w149UWVVLU9yy5Svp/iIiSmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122644; c=relaxed/simple;
	bh=xKWaFiF4Stck1c6IC9qPKTLGzX1CaZt20WVNbuWFfjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pj8Dkonx1fy9So3WNRwg/vFVIsKRagqATHfGyfZPB7lAcy69cal/dTOTALQiwwSHGSJRp+pkxH4Bw200aTeYT1kaEXZ7MhYV3T+4ITZdUXWEEuMsnzoPNWO7z5qOiSEF9Ow4LPx6vRdEPuHxSemamHB9OGukO6EYJK+66/ULWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6acZcnY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6acZcnY"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29f0f875bc5so19074875ad.3
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766122643; x=1766727443; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDodzdvyFbknC8FIp1mljLdhQ9A1IRI/HhNeyykhxII=;
        b=H6acZcnY5StM50Cs5JLiqiUsTjqk8UPUi/EAiO+PQnTLQu9HpCKzZfchJO9asl6ikC
         8upXp6t1FumiloftmBtDSmeY0LMrU9AQPUxjEAbYXtUzx+tF6kd0OgRQ1F6TdGxReI3d
         L6MltZgH+rRu5ktjJPyHn+Vmw7pfJTvvNsWSW/5dYAN91wKv72awXJjW2li7TCR2JRTY
         Uxg+9GT53VeHpQI8KMkS3TNzndq9EmaUHJ1MLgaDXhgUGDqr1SIBlLd3Or9uMLj+WSR2
         L1561ejgvg++HivbfJzEnVcUvtqm69xsPrEqkIy15qSCKc6XxKjd1ckniaMQYxKV6Gr4
         fS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122643; x=1766727443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cDodzdvyFbknC8FIp1mljLdhQ9A1IRI/HhNeyykhxII=;
        b=DfzmidhC7Wq7RTXEiDBML8gZqbsUuZXlgNQnROnvsRYMzTVBVsSWbmEyZyaD7gff7w
         xpOaxAaWxc+E9Cw+tk7xQKFp00OCrYNgbgvgzQ0+DqE9BfiEY4sEB+6XyR/pYvnjmgEQ
         2BfmOp/SuevRKbgKZa7HqdhsqS4SH4lkAWGWkeR0wi5GiJEqrO+Jo3XiD9QzgRgxg43j
         RxaEH0pULZtpk7p4ndtdFyL9xvwyVwI/MHe6VR7sWm5O5xeM91gE0BM/LV8Oc4Vr+UHP
         tgZug2ySxK/V33xdvxWszAZXpBd3rjvkvs8/jDeFbC/19ZusTMkvAJUCxmNEZ8n9wZMX
         f8vA==
X-Forwarded-Encrypted: i=1; AJvYcCXOpmOOBe/o79iJgowB+fukg3nrGL0ExQ+kcoP46DJdYWjhAqwLh/E37rWvvkng9tb0LysQgw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJu1lGPV0cEutmo8jbUlSkiXXVuUSx4y6SbVjgpu2Ha2utRdBU
	HqrO19D29B0DGQoRkCiUNaRjghi3fFdzIOowo9K9v4tZJlXG8KA5PBkY
X-Gm-Gg: AY/fxX5eHShPs/tMZXFTM7ADVN83Rgx+WfO/jsSJqtiseao4dKuNCCuRPQ3d8aXwuXg
	ys9sgUaf3dlrOUVA4SjcrOdpZ4XAeT7xo2qfxxqT+jcx5TOZLn/REXvuR76M4Ks01rgrHO5etyA
	/7rhq23yt7g82frgVz7hVw57U8OVv7r10gTz+JJAM7pTrL1QY6xiYXhvweabto2D6GKpDWiRAvq
	Gy7jFswMYcIdc+nMQFrFEIz2rn5zjWgdfNuX2RFZu4gKMHlq9cFyE9iims+GaiGdyieIF8Vcd5m
	Ba/fR2RtbUQU67TuysrWr4xosU/bzSjrKvNcTr8u3YExetiRDajDzdoMzRem+sp/YMgXEGPHdGj
	0IlJofp9lIFCOTf4Xixl/SH7/pzyCkJNRsyhdwMaCIPhD7XuWYJHs1O5iyeyyPmfmEy7DYnuvrN
	nV7oBa/SQsfyDZKAohYcs=
X-Google-Smtp-Source: AGHT+IGzuZJ82GUInMpHHsz5Jh8P3tFch3LI3d67HGTpBsqXEpuwzDvEBW/+nSfCKMrEedniTwbWSg==
X-Received: by 2002:a17:903:1a67:b0:29d:9755:9bd8 with SMTP id d9443c01a7336-2a2f23265b7mr14068335ad.22.1766122642560;
        Thu, 18 Dec 2025 21:37:22 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d895sm9930215ad.54.2025.12.18.21.37.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 21:37:21 -0800 (PST)
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
Subject: [PATCH 2/6] arm64: Provide dcache_clean_poc_nosync helper
Date: Fri, 19 Dec 2025 13:36:54 +0800
Message-Id: <20251219053658.84978-3-21cnbao@gmail.com>
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

dcache_clean_poc_nosync does not wait for the data cache clean to
complete. Later, we wait for completion of all scatter-gather entries
together.

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

