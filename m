Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F293BB134
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 23:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784763512; cv=none; b=hkdviKqwse4P70dtoxhJHRBr9odu7vK9GIKsGqWsAt0Doecmisw/mYqVl9b6yOWk7zyRdxjVMTSrqDCrGk0nqI3c8BHIce/KAY8yIM+JapS1AK5eJF/XiucuoHfxtQU7Z7aqSW+mrQ6W4+Cwh9OrORe4MMZx7uC8+s47qbJ7QxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784763512; c=relaxed/simple;
	bh=482j/rlGL/MyUIfK5vi1HCJAff/SkFOJEYzr2v72u54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJL7RL+xwMQkl7Xf0CqS9J0WQm5osXFl5y4v8DsHwtbklJ/gDxkpGT663/SgUS2d5KvLnF8Cb3V7JFLKKBKCHkDSuvy+h03lNHUNUQhtaggkDv2FAV8CQ5ZGcu1En2lcZgXy7xKwrr/qaG5Mc5/U9AubHUeQIArUk/YNxcHb8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co; spf=pass smtp.mailfrom=x6u.co; dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b=dXYIarEg; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x6u.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b="dXYIarEg"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6688a2dceb8so4931d50.3
        for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 16:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x6u.co; s=google; t=1784763508; x=1785368308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=czUeoqytFwl2f4wSjedp4ua+inBVMuooqHyWYibjU+0=;
        b=dXYIarEgTmVO1sqQ/CFPQZFAQdCPctyeJKNwcgu116xTT6hfaI4TceL1UCSRDZWKgi
         F1ulYYocSYSbmZptW41HJZt55jK3bGUaUm93YdD2nF/l3IRwkQX5ssZ6dvn/GODNKypy
         kadUKrmxfhEJFx5cpxsxV3phIW/sPLjYfLaLUL2zQ8rREIbXKZw4ObtjHx1kYAMPbIQs
         CbxdtxXk3xnKRf0/LW/PT93PaNxxs8xS3KPdsNpzPBX9RL4yWxyaoYRHq82/7wj7SlDf
         qt4Mf3hYW2JCRCuAyr5owX632rig1+VDEGv45ijhxJrTIkWJNsftw4eUVXQvC9lhGr0P
         AhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784763508; x=1785368308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=czUeoqytFwl2f4wSjedp4ua+inBVMuooqHyWYibjU+0=;
        b=YGH8Xw5M3oCbr5arCIIEMtBRJrOAnQhQ9s55aGHssJO1Xxp+tWJjeCyfhywvkSun5o
         p+JTTkK7fbvLsaIdUersiobVqpy5NU/jtJ5jztqoDClAXyJKDjc8Lu3/d4uF+4jeJHk6
         Ronm1BleDo6HN4KZCSHtMnVDyvmcxSrqDm2sSZys/CPaLhcfJSHxsrSD7y67U+F/wM/m
         va2X/OkHBAmHIpuTuah5Cpw+oF6PnO3/56Ca+M52ZxDQIRborNOMIFZkBbLRTi7lzndP
         mhM/jr5utJ3BfOnTjG6h4bk8FyhoH8jYHuppAKCdBskI4BEWLonkHsTL5yn5Uq0YNCKN
         bp5w==
X-Forwarded-Encrypted: i=1; AHgh+Rr+hX1MRIk3IReDVMx/Xxg9d+pMxIBLhUUx3FdcJeR1rEDpD7B/FeVcPjrVwEfFqJPTPjPKmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXKsmAdKzoOtXJ4ukIU+K06+e8HOrHPMt0z8GkNuUaFgfN7g6Z
	VLjFcUcebCa3Ff1wYcUIrQYnBOxBREHYBwxzTqJsUArBd0u/Ojb98f97dkXyuPerzj6k
X-Gm-Gg: AR+sD13tR0kM+6Xjilc1fDG/61hNcpcrpjgUkE5Rmxpt2ShejFga1acE6O9jjfuTuqD
	vbnnRBwON/FFXpSBcxZlwNX3yrxHKpT0xhRL1eTE/t6Ui7uAOyo7U7imrRJz0IhSXjYxU1mw3Xv
	ZjYlPCBG0GEvvXRT6HZbO+lZO+FAiyAdQnn70sRD+DugBNsvwmwwRGxzgcBUl/Fs10RVXGNCYK4
	LeKs57kXZy64Afx0+AtzopqlO5hB+cvam/D9RZokGm8e83L1A/shEEbpmjRbg8etATTg/ueSbmX
	i8n5mmG0RFk/WVWtRZYW3rDTN1a5EtAel22TXYldNsKJDf1oKGoe72VKJCvWW/PNKR1nAesWAaz
	U/wDUmeW9e3UFLgn2ib9bFMB8PzDXJOfOcNOkNv33N5rqlg4n3rIp/pd8jDr+im1jluxvf0idZ9
	C4xBkzJFopcwlDdVQAnLvRHWoJfeM0eKFrogfEOksXgZKkMA0O74CETpX0
X-Received: by 2002:a53:ce84:0:b0:667:af05:2e8d with SMTP id 956f58d0204a3-668a4fbd261mr142804d50.79.1784763507854;
        Wed, 22 Jul 2026 16:38:27 -0700 (PDT)
Received: from worldpeace10.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66890521188sm2193219d50.1.2026.07.22.16.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 16:38:27 -0700 (PDT)
From: dhu@x6u.co
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	David Laight <david.laight.linux@gmail.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Pranjal Shrivastava <praan@google.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	stable@vger.kernel.org,
	jmoroni@google.com,
	kpberry@google.com,
	chriscli@google.com,
	viursachi@google.com,
	xuehaohu@google.com,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk
Date: Wed, 22 Jul 2026 23:38:06 +0000
Message-ID: <20260722233806.3922093-1-dhu@x6u.co>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260623015459.1153884-1-xuehaohu@google.com>
References: <20260623015459.1153884-1-xuehaohu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Hu <xuehaohu@google.com>

Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
first entry, resulting in non-page-aligned DMA addresses for all
subsequent entries.

While the underlying IOMMU mapping may be contiguous, hardware
DMA engines often require explicit address alignment (e.g., page,
cacheline, or storage sector boundaries). Passing unaligned
addresses and lengths can cause explicit failures in DMA descriptor
creation or silent data corruption if lower unaligned bits are
truncated.

In addition, a non-page-aligned sgl length will trigger an edge case
in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
buffers, we will have a `va` with lowest bit set to 1. That will lead
to `ib_umem_find_best_pgsz()` always return 0, and break the promise
to find best page size for the mapping on the NIC side.

Fix this by splitting the scatterlist by the largest possible page
aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
This ensures all scatterlist DMA addresses and lengths remain page
aligned, while minimizing the total number of sgl entries.

Page-aligned entries allow the system to cleanly chunk payloads into
PCIe MaxPayloadSize (MPS) (e.g., 128 bytes, 256 bytes, 512 bytes).
As a result, this may help reduce TLP fragmentation in P2P transfers
and alleviate potential congestion within a logical PCIe switch
partition, especially when Relaxed Ordering is not possible due to
hardware constraints.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.kernel.org/
Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mapping routine")
Cc: stable@vger.kernel.org
Signed-off-by: David Hu <xuehaohu@google.com>
---
 Changes in v3:
 - Removed the type cast for `min` (David Laight)
 - Reverted max ent size to be `ALIGN_DOWN(UINT_MAX, PAGE_SIZE)` and
   updated commit message to reflect that (Jason Gunthorpe)
 - Updated commit message to reflect that this also fixes an edge case
   in `ib_umem_find_best_pgsz()`

 Changes in v2:
 - Updated commit title and message to reflect the switch to 2G chunks
 - Switch to using 2G as the max sg entry size as it naturally aligns
   with most hardware boundaries, while allowing compiler optimizations
   with bit shifts (David Laight)
 - Optimized away division calculation for `nent`, and multiplication
   calculation for sgl address, by dropping the `for` loop in favor of a
   `while (length)` loop (David Laight)
 - Dropped `min_t` in favor of `min()` to maintain a strict type
   checking safety net (David Laight)

 drivers/dma-buf/dma-buf-mapping.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..50ded9daf5fb 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,16 +5,17 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/align.h>
+
+#define MAX_SG_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
 {
-	unsigned int len, nents;
-	int i;
+	size_t len;
 
-	nents = DIV_ROUND_UP(length, UINT_MAX);
-	for (i = 0; i < nents; i++) {
-		len = min_t(size_t, length, UINT_MAX);
+	while (length) {
+		len = min(length, MAX_SG_ENT_SZ);
 		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
@@ -24,8 +25,10 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 		 * does not require the CPU list for mapping or unmapping.
 		 */
 		sg_set_page(sgl, NULL, 0, 0);
-		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
+		sg_dma_address(sgl) = addr;
 		sg_dma_len(sgl) = len;
+		addr += len;
+		/* Unconditionally advance. On last segment, this becomes NULL */
 		sgl = sg_next(sgl);
 	}
 
@@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
 	if (!state || !dma_use_iova(state)) {
 		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			nents += DIV_ROUND_UP(phys_vec[i].len, MAX_SG_ENT_SZ);
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
 		 * for whole IOVA address space, but we need to make sure
 		 * that it fits sg->length, maybe we need more.
 		 */
-		nents = DIV_ROUND_UP(size, UINT_MAX);
+		nents = DIV_ROUND_UP(size, MAX_SG_ENT_SZ);
 	}
 
 	return nents;
-- 
2.55.0.229.g6434b31f56-goog

