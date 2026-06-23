Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0437BE7F
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179705; cv=none; b=u1cu82PvOyyqGa6kHFlWuoX34eSX3aMlHB3kH/V2mVy4oHsiT9lq8nHq5CipfxL4NBuqk7wReAJEE0fFQrA2w92eTmBNFvKMm7QAKYxCzIR7A46N4c3fikJjcfMTScT9gsZrcSUtjHznDpDrGsALdckbd96ciswIuxs0/c6JxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179705; c=relaxed/simple;
	bh=bBWRORv7RUc8uRHv6zCGgvNd/JG4DiLB/oASlXLOQPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L7DK3rX4sWWu+nKEBqVOjo55feVDlQjvjRZweleQgCoIf6VrtKxHssSLAR1/cl5l50x7Xtwxvj4SoK1lFqbiM8WSfD9ysE5OgVSjC4knuIhDLzU/DtpHVrlJzAaXpW1lARCp/8+JNvRWcZ4TrCOuRyJUaZqrB8MgB1gE2J4LEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3EuR6qM; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3EuR6qM"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-519899abab8so100955001cf.2
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 18:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782179702; x=1782784502; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lkITz2dGNs54nij5ccY4KCvNRYJG4BpFQmrxgUXzmOc=;
        b=d3EuR6qMYv8J3mL4S+IeSGk3d53FSZi9dECorPskzm0pV3iuI61zvxf/KkPOw+TR8e
         RC8tC4CyZyKbyVUeNibbnD8LDZzNhvr5UKdCpsPkLDRD19OKYvP9Dk5yKARFXrpEmC7f
         WcHp+J3fBa4E3M0sgOMPeFAUkAdHXZEcwSseCuKLl0Zw297cp9xyy/agPYf/AgNBnD2K
         cYtmkZP6t6Cv4G/Exo+JFmesTGvwwGqZNc09nT85kUx+oe3RUcZCCKB7dpSgsOgHMRyp
         ham4cLy/aNrSw+5FsURQR/qVZvGTb1C3EtIPXCrMfQatMUJF87yDFZcrxccFwP7wiDnt
         7dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782179702; x=1782784502;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lkITz2dGNs54nij5ccY4KCvNRYJG4BpFQmrxgUXzmOc=;
        b=pZyj1vXE6qKCxteT8Ph/eXokJvDQ2JTG8lwSCwjRib51trSo8KVT0kdwwwbWWjQ7t0
         doAMe74z7zsua8vvUj5M9TQYhyThMdiNDR9G2kg3d+mTPMiaQj1I5oZx8B1RB3xQcN6z
         cwxGRc5DBg34kjNMBLH/QdKyMyfLDBuUOnw5quuGyBO6B0zb/yCYYg+5i278S2zYs2/1
         RYSZHiCg1MeYDcvfUeh1P8vw9t+AwUujykiu8WAoLL/GMuijXKgFBcq6dx2cUNxJ7/GD
         FhwM+HUeWT7g/v0etsjBlhWFEpvsteVgU0IeiEMvA3mSmVb1Q2Qt8snu0H0WhVT3SObt
         Lm5A==
X-Forwarded-Encrypted: i=1; AFNElJ9JlNdxNqm1Wj8sdVKS36o/XTebdC5MPf9nRPP900qNgaSRMblWRoU6901j5L5Q7BuZNizing==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh++c3UHKJD3VKldatZ2hJH4pweDLQdQZ3aRWqm1+vKpeTXsO2
	0ZO/WF0xEcTVMEiC00zqMUocGKQju3ZiFZ1MsdJakt0I1UePQaWSg5QveYfa9f1LD27bMxkWdG4
	jujoK3eT2unfN
X-Received: from qtxx9-n2.prod.google.com ([2002:a05:622a:aac9:20b0:517:96a4:99ea])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2609:b0:519:89f6:6ed4 with SMTP id d75a77b69052e-51a548b6418mr13414611cf.47.1782179701475;
 Mon, 22 Jun 2026 18:55:01 -0700 (PDT)
Date: Tue, 23 Jun 2026 01:54:59 +0000
In-Reply-To: <20260621222130.1667453-1-xuehaohu@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260623015459.1153884-1-xuehaohu@google.com>
Subject: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: David Laight <david.laight.linux@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, kpberry@google.com, chriscli@google.com, 
	sashiko-bot@kernel.org, stable@vger.kernel.org, 
	David Hu <xuehaohu@google.com>
Content-Type: text/plain; charset="UTF-8"

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

Fix this by splitting the scatterlist into 2G chunks. An alternative
previously considered was to use the largest page aligned chunk within
`UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`) to satisfy page
alignment. A 2G chunk is better as it naturally aligns with most known
hardware boundaries, while also allowing compiler optimizations with
simple bit shifts. This ensures all scatterlist DMA addresses and
lengths remain page aligned and satisfy hardware constraints.

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

 drivers/dma-buf/dma-buf-mapping.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..2d88e08c5ebf 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,16 +5,17 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/sizes.h>
+
+#define MAX_SG_ENT_SZ ((size_t)SZ_2G)
 
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
@@ -24,11 +25,12 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
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
-
 	return sgl;
 }
 
@@ -41,14 +43,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
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
2.55.0.rc0.799.gd6f94ed593-goog

