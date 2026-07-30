Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B4352C35
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435180; cv=none; b=VrKRyt2mpoOrGpxxuvYwIMisSmGLjHyhpdHG0lOOvOA1b68kMNPQtSUknivXxRSH7hLns7zbYzKAh9XhvHtN5/Qp+wzJDpI9k/0YRp0vkbU9iPmQassgx8prcKpV09pYs8iiyA7kns68CA65bqo8RME3DTEwgPAFSTB0d0LB5wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435180; c=relaxed/simple;
	bh=y9MroAw4PAQFoJrfupQbQystlETO9uOntwqhTg2iyao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuMVPMbo7PAivdRfAAvQ57oHFHzEnuaV1IBwE6mgK7R/hXSY9P6aeP/22mXDps9Yep2MXDkOb+rrGmVH7T7zLYcz8+VxZHHy5Xl7kC0p/uYPIlEv3fc2KUp24lY+NFMErqOtGIlTn83BZsO7jwSlJXoUXks/Bh6vNSoxl1Edn84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFYI+51K; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFYI+51K"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso65180a12.1
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785435174; x=1786039974; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cNanfJS2VAokGlGAjWn3IsZqHmLvq5n2BcQ0vWSl7Jc=;
        b=EFYI+51KVuKDF/QBUyu8Js+DVwrSh9ZHsoKz3P4DRN7xd9r8COf6UtvHM5A2Qz8aW2
         Svy7zxRR9H9uy5uj1uY94cTXwELdpQrqSNMBZVE7YmlYeu5uvN7PVLf5GI9+EMgMlDQr
         /z6rgZc1YHB3AJz2ZA6zzmAx72hJW02drUXNfGVgrv42b5lz+tBhnJcb0y7nxEPmd+QA
         3hVWgEi+XwWhQIpKlCLB8/p5fgVkGIjP7xfFUWlgFrnf1Mh7W2Q9xwZFk6dmxmon5707
         lTJ0AuCUG/l5RUROVaCFev5TJ1aEWAvwF2U+OoF3v1+ALfBiThSZEKeGzB6UOrWMMRKg
         kZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435174; x=1786039974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cNanfJS2VAokGlGAjWn3IsZqHmLvq5n2BcQ0vWSl7Jc=;
        b=a+zXtJw2iA7gwfzLgGntf4847IHUIWrakVaEilArC9+djq3E3oY+DsTydXtqnDRS0r
         xxZLEXTc2CZURDpnQZmpJLT4mvpgFesFVb60YbOg79MTVyfacVKQU2UjvHFZsFcGnYdp
         cbt6OuB432jHvN2uqVm+67kLFv9X3Z5mFXf6s8nGKKfpP1ENMvPzHgiDv9xsyd4IRHLX
         kci6Mao8XFlP3dTJeQS8cm1oRL8zSw65D1821aLel+2XG5H63DWXSFV7shCeRTekYnID
         Bt+Sf0mZ3rQ3MbEWVNZtrOa+0JyNxOs1j2ccWM/wp6OsNNpAudbtlbAJkjHiXQVZ4iyG
         EDQg==
X-Forwarded-Encrypted: i=1; AHgh+RqH7wj0kNWJhhRr1UvOTfp6mNtnaqqia1eRl1lKJSs9LhTHPXSmTzmOAN8jG6DQo7y7MSXANw==@lists.linux.dev
X-Gm-Message-State: AOJu0YybliFy7HGKXCZ33Xs5whB/ilEAt89AFRdTjpzaUZb8fw+BJVhK
	ACuvBIV+7LE9jy1v9qfxpdobaLS42yXfzX41F59KQaQb1m1SDxXPRmBG
X-Gm-Gg: AR+sD12wwaS1/bgsneg9aFJv8NcirKBpi/W1FnG3UsUm87gu8VVWrSJW83qRPzogI5F
	BwsYjzJF3GG8UYJiXyeh4Kqr+lY4nAnimJRPRtvEaypK9Dg2pcsL8kTTh0hVbuFul4AkpmTvPrn
	SHKrKnUoA5aXhI6FgIJrt3PKJVPNXloTZzVMWCNyFQkO11733bLcbjoS/Q6sAlW1ImbfDo5IuWc
	w53gNKcCx1O2MuuXLEGWPCOzQATbbfxG5NytZmxVAYmxlLOZx5+HlKqIigjGLubeigaOwltUcE4
	DylIhHP1PtazsKy/wDesh874tLmmIbDjlcu2wL0ni3e3qR1qedRiW2HTTVCwgiDOp7S4+D5hZK4
	dj0zIkdG608jQAsu4B8M59DGaP+zBV5JR7mQUbj+pqfH9y1t2m+0t/gcNMWj36cV2zBe9LKVqIw
	XGsXSvKSrOp1OeA2nV4KzIs9LdxF08s59aAud1Pu57vBWOW7c3YTL66KFG/iMRZODKms8i26XUx
	qaKZtBnRNQVSgM1C3SRQqvKz85pnpMLCDQJExETFO2Ru7ygQfu2AmhfNSewrs52awstMcyYJpk=
X-Received: by 2002:a05:6a21:6b8c:b0:3c6:82ab:ed81 with SMTP id adf61e73a8af0-3c90d5d1e91mr1200355637.48.1785435174529;
        Thu, 30 Jul 2026 11:12:54 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (131.197.81.34.bc.googleusercontent.com. [34.81.197.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm21998197eec.6.2026.07.30.11.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:12:54 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: will@kernel.org,
	joro@8bytes.org,
	akpm@linux-foundation.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	cychu@google.com,
	hhchung@google.com,
	amitamishra@google.com,
	marscheng@google.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/2] Revert "lib/sort.c: add _nonatomic() variants with cond_resched()"
Date: Thu, 30 Jul 2026 18:12:16 +0000
Message-ID: <20260730181216.2709088-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260730181216.2709088-1-visitorckw@gmail.com>
References: <20260730181216.2709088-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit e2a33a2a3258794891cdd6ca4b1318da6594d157.

After replacing the only in-tree user of sort_nonatomic() in the
arm-smmu-v3 driver with the standard sort(), the _nonatomic() variants
are no longer used anywhere in the kernel.

Remove sort_nonatomic() and sort_r_nonatomic() to clean up dead code.
This effectively drops the wrapper function __sort_r() and eliminates
the may_schedule branch and cond_resched() call from the inner loop of
the core sorting routine, slightly simplifying and optimizing the code.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/sort.h |  11 -----
 lib/sort.c           | 110 ++++++++++++-------------------------------
 2 files changed, 31 insertions(+), 90 deletions(-)

diff --git a/include/linux/sort.h b/include/linux/sort.h
index c01ef804a0eb..871775978af0 100644
--- a/include/linux/sort.h
+++ b/include/linux/sort.h
@@ -23,15 +23,4 @@ void sort(void *base, size_t num, size_t size,
 	  cmp_func_t cmp_func,
 	  swap_func_t swap_func);
 
-/* Versions that periodically call cond_resched(): */
-
-void sort_r_nonatomic(void *base, size_t num, size_t size,
-		      cmp_r_func_t cmp_func,
-		      swap_r_func_t swap_func,
-		      const void *priv);
-
-void sort_nonatomic(void *base, size_t num, size_t size,
-		    cmp_func_t cmp_func,
-		    swap_func_t swap_func);
-
 #endif
diff --git a/lib/sort.c b/lib/sort.c
index 52363995ccc5..8e73dc55476b 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -186,13 +186,36 @@ static size_t parent(size_t i, unsigned int lsbit, size_t size)
 	return i / 2;
 }
 
-#include <linux/sched.h>
-
-static void __sort_r(void *base, size_t num, size_t size,
-		     cmp_r_func_t cmp_func,
-		     swap_r_func_t swap_func,
-		     const void *priv,
-		     bool may_schedule)
+/**
+ * sort_r - sort an array of elements
+ * @base: pointer to data to sort
+ * @num: number of elements
+ * @size: size of each element
+ * @cmp_func: pointer to comparison function
+ * @swap_func: pointer to swap function or NULL
+ * @priv: third argument passed to comparison function
+ *
+ * This function does a heapsort on the given array.  You may provide
+ * a swap_func function if you need to do something more than a memory
+ * copy (e.g. fix up pointers or auxiliary data), but the built-in swap
+ * avoids a slow retpoline and so is significantly faster.
+ *
+ * The comparison function must adhere to specific mathematical
+ * properties to ensure correct and stable sorting:
+ * - Antisymmetry: cmp_func(a, b) must return the opposite sign of
+ * cmp_func(b, a).
+ * - Transitivity: if cmp_func(a, b) <= 0 and cmp_func(b, c) <= 0, then
+ * cmp_func(a, c) <= 0.
+ *
+ * Sorting time is O(n log n) both on average and worst-case. While
+ * quicksort is slightly faster on average, it suffers from exploitable
+ * O(n*n) worst-case behavior and extra memory requirements that make
+ * it less suitable for kernel use.
+ */
+void sort_r(void *base, size_t num, size_t size,
+	    cmp_r_func_t cmp_func,
+	    swap_r_func_t swap_func,
+	    const void *priv)
 {
 	/* pre-scale counters for performance */
 	size_t n = num * size, a = (num/2) * size;
@@ -263,9 +286,6 @@ static void __sort_r(void *base, size_t num, size_t size,
 			b = parent(b, lsbit, size);
 			do_swap(base + b, base + c, size, swap_func, priv);
 		}
-
-		if (may_schedule)
-			cond_resched();
 	}
 
 	n -= size;
@@ -273,63 +293,8 @@ static void __sort_r(void *base, size_t num, size_t size,
 	if (n == size * 2 && do_cmp(base, base + size, cmp_func, priv) > 0)
 		do_swap(base, base + size, size, swap_func, priv);
 }
-
-/**
- * sort_r - sort an array of elements
- * @base: pointer to data to sort
- * @num: number of elements
- * @size: size of each element
- * @cmp_func: pointer to comparison function
- * @swap_func: pointer to swap function or NULL
- * @priv: third argument passed to comparison function
- *
- * This function does a heapsort on the given array.  You may provide
- * a swap_func function if you need to do something more than a memory
- * copy (e.g. fix up pointers or auxiliary data), but the built-in swap
- * avoids a slow retpoline and so is significantly faster.
- *
- * The comparison function must adhere to specific mathematical
- * properties to ensure correct and stable sorting:
- * - Antisymmetry: cmp_func(a, b) must return the opposite sign of
- * cmp_func(b, a).
- * - Transitivity: if cmp_func(a, b) <= 0 and cmp_func(b, c) <= 0, then
- * cmp_func(a, c) <= 0.
- *
- * Sorting time is O(n log n) both on average and worst-case. While
- * quicksort is slightly faster on average, it suffers from exploitable
- * O(n*n) worst-case behavior and extra memory requirements that make
- * it less suitable for kernel use.
- */
-void sort_r(void *base, size_t num, size_t size,
-	    cmp_r_func_t cmp_func,
-	    swap_r_func_t swap_func,
-	    const void *priv)
-{
-	__sort_r(base, num, size, cmp_func, swap_func, priv, false);
-}
 EXPORT_SYMBOL(sort_r);
 
-/**
- * sort_r_nonatomic - sort an array of elements, with cond_resched
- * @base: pointer to data to sort
- * @num: number of elements
- * @size: size of each element
- * @cmp_func: pointer to comparison function
- * @swap_func: pointer to swap function or NULL
- * @priv: third argument passed to comparison function
- *
- * Same as sort_r, but preferred for larger arrays as it does a periodic
- * cond_resched().
- */
-void sort_r_nonatomic(void *base, size_t num, size_t size,
-		      cmp_r_func_t cmp_func,
-		      swap_r_func_t swap_func,
-		      const void *priv)
-{
-	__sort_r(base, num, size, cmp_func, swap_func, priv, true);
-}
-EXPORT_SYMBOL(sort_r_nonatomic);
-
 void sort(void *base, size_t num, size_t size,
 	  cmp_func_t cmp_func,
 	  swap_func_t swap_func)
@@ -339,19 +304,6 @@ void sort(void *base, size_t num, size_t size,
 		.swap = swap_func,
 	};
 
-	return __sort_r(base, num, size, _CMP_WRAPPER, SWAP_WRAPPER, &w, false);
+	return sort_r(base, num, size, _CMP_WRAPPER, SWAP_WRAPPER, &w);
 }
 EXPORT_SYMBOL(sort);
-
-void sort_nonatomic(void *base, size_t num, size_t size,
-		    cmp_func_t cmp_func,
-		    swap_func_t swap_func)
-{
-	struct wrapper w = {
-		.cmp  = cmp_func,
-		.swap = swap_func,
-	};
-
-	return __sort_r(base, num, size, _CMP_WRAPPER, SWAP_WRAPPER, &w, true);
-}
-EXPORT_SYMBOL(sort_nonatomic);
-- 
2.55.0.508.g3f0d502094-goog

