Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6130CD81
	for <iommu@lists.linux.dev>; Mon,  3 Nov 2025 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173247; cv=none; b=nxVldOzGQqcaX50qBTvlN72tPxMIMdAi+RZwIHjwUCGQlhPvSEtI4RyJGVBRkItmw9qbD7JfiQOzGAB9YyGMqehUI582mGVCtvBrd9u+PnCWmJRMXNPEINIn9T5COnUru4WYGbZ03eyLL4hyiKr4AEZxv3yBVix57IvqqfuWGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173247; c=relaxed/simple;
	bh=vjkrYPoAZlHM7oLJ+7JDcEL1NOqCh0147DxJfPx6SrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n8cyyVuY5ASG7elzR4zhp58FnSpyQgeDbb/k6s6ukX4wERP1plCLC+50M3yHKbqOCyUcoQbxY51tyH10MeJ6hlD2pw0beR9LhNlYErC43IUZnoM4JxicwpVKTOKfcITMhCahEulbW/9p4ttV9x8gBneW23PaamBJ1NbjbSWngbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPy5lB9m; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPy5lB9m"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso1705835f8f.0
        for <iommu@lists.linux.dev>; Mon, 03 Nov 2025 04:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762173242; x=1762778042; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ux05tU7+D0B7IZxmyew0p2paYr4GUNmlb17Kgdor7nc=;
        b=XPy5lB9mp0t1XiqPGpOqgXf8RDYPixTt5Ifx/iIGUOVnkK4sEK+yQCRy+lLliea5qV
         pnhkpp7pNYa2q1TxdGYrj9fAGuSVH8K6TfaW6HzAUJZ0Yj33pLC2D28s19re4mGiGIzu
         6WwiSo6E556V3nc1/fdr3K8lnF9qZA/AX/uTxtezDU/rpYy5ef8Pu63VwH7lpCnawRRk
         SPe+GnaqLMaV0KId06ggI5/bXy4v13aQKIu0UTSFrdid0/Q7qkwG6qR2PvffUwEpJJ/C
         9oIa2dPGAWc5yoFn63b46UrUHaxqtGTePBUhUUH7HiCA2PTs52NLV9b5m+ED+5yHPK+9
         aLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173242; x=1762778042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ux05tU7+D0B7IZxmyew0p2paYr4GUNmlb17Kgdor7nc=;
        b=VEJ9nldAbU35iG2k6w5BLta/kOinOziT+Wo2FRq8NtjliJoYNW3bwykcn0KuFn0Eil
         0uyvx5hzjIE8lM2cQzlOcpQItAXqHQcbgHiUy5Zmc4AbmOnDwEHaO7/g52E8AM4FrORC
         8VpmuTr15oDXXI1FILRNX+qsh3dD3w2y6kmGMfhaUeZWCk2msq8gy+slseLJWyIYq2Ro
         MUE6zxa+ngXXW3p+58Hwt/l1AC4LhqhtOml+2oMZp/TFzVy7w4O2Hotd54wGW96C44fR
         wqH/69h6JueTLK1sS+m9HYHtd46/+xfVA3NncYQWr+GIpiMEPVwDjde7mysHuXoY7WOq
         cSGw==
X-Gm-Message-State: AOJu0YwMMJMiuMCl3jtDO6wuhYeRhQfgKWiCnop1UulixrKbpx66hCLX
	PSGbeLnymCznCKZ1EJKNmrT4UkUvIQ/Zj4cVksZw6CDlnlsbrx7CIT32XxPzlnbyPrvrDQLYjv1
	v7653ShnWbwXiQOJMO6SlNowubTwBPnQ4rsVP4ExL5cKJG/SmyV3uLqMpUoQ+91r63ahDZagEbu
	HhGPx8qSdKsh1XGzy2HQOQYr0nkpqsgFegKgdBK1kW6eHyTw==
X-Google-Smtp-Source: AGHT+IGrApuZXSqW3lxjcwRKlTmVFlztNd2Jc9n1hjMR+iMt6HX4Z1G6N1X7IymUPj+PYiV5MnuQog6Tf7KgIg==
X-Received: from wmfv2.prod.google.com ([2002:a05:600c:15c2:b0:475:d804:bfd2])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2301:b0:429:bcd7:ac9f with SMTP id ffacd0b85a97d-429bd6ac60fmr10501171f8f.53.1762173242489;
 Mon, 03 Nov 2025 04:34:02 -0800 (PST)
Date: Mon,  3 Nov 2025 12:33:49 +0000
In-Reply-To: <20251103123355.1769093-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251103123355.1769093-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103123355.1769093-2-smostafa@google.com>
Subject: [PATCH v6 1/4] iommu/io-pgtable-arm: Remove arm_lpae_dump_ops()
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

At the moment, if the selftest fails it prints a lot of information
about the page table (size, levels...) this requires access to many
internals, which has to be exposed in the next patch moving the
tests out.

Instead, we can simplify the print to only print the fmt and
for each test ias, oas and pgsize_bitmap are already printed.
That is enough to identify the failed case, and the rest can
be deduced from the code.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 41 ++++++++++++----------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7e8e2216c294..7d6d7221f540 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1297,21 +1297,8 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
 	.tlb_add_page	= dummy_tlb_add_page,
 };
 
-static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
-{
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
-
-	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
-		cfg->pgsize_bitmap, cfg->ias);
-	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
-		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
-		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
-}
-
-#define __FAIL(ops, i)	({						\
+#define __FAIL(i) ({							\
 		WARN(1, "selftest: test failed for fmt idx %d\n", (i));	\
-		arm_lpae_dump_ops(ops);					\
 		-EFAULT;						\
 })
 
@@ -1340,13 +1327,13 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 		 * Empty page tables shouldn't provide any translations.
 		 */
 		if (ops->iova_to_phys(ops, 42))
-			return __FAIL(ops, i);
+			return __FAIL(i);
 
 		if (ops->iova_to_phys(ops, SZ_1G + 42))
-			return __FAIL(ops, i);
+			return __FAIL(i);
 
 		if (ops->iova_to_phys(ops, SZ_2G + 42))
-			return __FAIL(ops, i);
+			return __FAIL(i);
 
 		/*
 		 * Distinct mappings of different granule sizes.
@@ -1359,16 +1346,16 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 					   IOMMU_READ | IOMMU_WRITE |
 					   IOMMU_NOEXEC | IOMMU_CACHE,
 					   GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			/* Overlapping mappings */
 			if (!ops->map_pages(ops, iova, iova + size, size, 1,
 					    IOMMU_READ | IOMMU_NOEXEC,
 					    GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			iova += SZ_1G;
 		}
@@ -1379,18 +1366,18 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 			size = 1UL << j;
 
 			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			if (ops->iova_to_phys(ops, iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			/* Remap full block */
 			if (ops->map_pages(ops, iova, iova, size, 1,
 					   IOMMU_WRITE, GFP_KERNEL, &mapped))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
-				return __FAIL(ops, i);
+				return __FAIL(i);
 
 			iova += SZ_1G;
 		}
@@ -1406,11 +1393,11 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 				   IOMMU_READ | IOMMU_WRITE |
 				   IOMMU_NOEXEC | IOMMU_CACHE,
 				   GFP_KERNEL, &mapped))
-			return __FAIL(ops, i);
+			return __FAIL(i);
 		if (mapped != size)
-			return __FAIL(ops, i);
+			return __FAIL(i);
 		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
-			return __FAIL(ops, i);
+			return __FAIL(i);
 
 		free_io_pgtable_ops(ops);
 	}
-- 
2.51.1.930.gacf6e81ea2-goog

