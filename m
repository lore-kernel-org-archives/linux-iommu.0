Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62C372661
	for <iommu@lists.linux.dev>; Sun, 21 Jun 2026 22:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080494; cv=none; b=X9FyhGjcUT1i3bpbFFjKMnl/i2HwQfgF9oy0eWYBD82ERs+w9ymVJEsBCIXrvusGNleDXFVoF5XRbZO119VANwlHDKyDYbso2h+aFyTwhmCjnJxt216yID+7zJTPr6IV3yu+R5KT7dDKQLgYBQakbqXqWEmmh16f2bJJKpZ6Ic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080494; c=relaxed/simple;
	bh=W6+v4i11Ax13kL48F/Y+SlQUTA6m8gwuQWrL0d08Rj4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FmwSC1Cxe9Dd0tS1dmFr9eG4YIlOvYCb/OXh0naC2eYqXmtIgI81WZI+UoPLRp/Fhyi9wTcFWM3NkhQiWi1b67UwcqBi9Fi1/RcXcX0ILYz34KO5dpPIqS2A0hENexmCSlCs7akbFT4L/4mVMIBQXhkZablFjv2Ru+4NN1zkDxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1XCMbHW; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--xuehaohu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1XCMbHW"
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8db90457124so38756716d6.1
        for <iommu@lists.linux.dev>; Sun, 21 Jun 2026 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782080492; x=1782685292; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E/rPiB1Qh/2nTPaKmpZPHKT5hQGs3BX51WUl0ayz+VA=;
        b=H1XCMbHWvu/Tgihg3gEC/n7zMO+StuuD27MlN9yuIz3YxnFGmNo3lwL36y/8QQv3gC
         h2A6W6u5LCIMh735BKS4EJtx+yssS0fxanD2teCKtukXZnot+ZVbhOpvH794bSzKl4Vs
         NOnBioy3zKENkjDGZn+duiXilQq+IghdZPyVojXYKRHPqr+GiYICU8YQSNa7VXgC3Na8
         fs7Hg5yPylijyimKrlbue+m7MeOgBIXKif+64NgNR3Qd70yzn184a9jIjkAC1tn6uYq2
         3FK17ht/KrMDN6e4+MAcK+pAWudeifkphIoUOtbD6o68WafSCbGAs1b7K394HaYUJYtX
         3zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782080492; x=1782685292;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/rPiB1Qh/2nTPaKmpZPHKT5hQGs3BX51WUl0ayz+VA=;
        b=X29BOfw0oiLc6V5lS9wM+ng8CyfLqqeIIgzFrluID0ggbnZP+w4ii7TPHwIAL+ADNC
         apkWgv/H+/fS6cRg3S3eji0wOsnEZePF3dH1Kn6Y79aOUaIE1+oMYg2pEQ/poyIQorZy
         SbIkarEnq9jIs/IjZiE/aLuRF2FXVVp6rzY+DasE4msAEpv0v1m082wmDJuNWaqbNFIb
         0wcK5mbt2S9RftrehoKV1OXnm/yqZzjZmv0oa9OIjlm64fNmM+LK2xgAXT5XhOEci0uX
         EG/fPITMM82pfwIQQCZTdueSHoOvnSi7O4Wi8LBm3mbewa48wBxJA2FHhGD98LoRjoLV
         ws4g==
X-Forwarded-Encrypted: i=1; AHgh+RpGgYp661eGNqfidpQY1E5RMQN57f+0uH28L9TVb6cCKlNFAMZNjZuzzo+TbnV0cpulh4CSHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcqandcBgICfbq5nQDvh8yWkq8TuHDOEmCPQpOU/G2abNIj3PW
	AmDw/71cEJwEdfbqHuJ+CVB70a5m/E+m6xO8TfBUJ2BPgnEsj8RjeOtfNSE8DLbAqelEfQl96pB
	YqKvx+MctQ9zl
X-Received: from qvbld29.prod.google.com ([2002:a05:6214:419d:b0:8db:f5ff:e5e9])
 (user=xuehaohu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3f82:b0:8cc:6aa6:7035 with SMTP id 6a1803df08f44-8de4c97e03amr175835356d6.19.1782080492419;
 Sun, 21 Jun 2026 15:21:32 -0700 (PDT)
Date: Sun, 21 Jun 2026 22:21:30 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260621222130.1667453-1-xuehaohu@google.com>
Subject: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
From: David Hu <xuehaohu@google.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
	praan@google.com, kpberry@google.com, David Hu <xuehaohu@google.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
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

Fix this by splitting the scatterlist by the largest possible page
aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
This ensures all scatterlist DMA addresses and lengths remain page
aligned and satisfy hardware constraints.

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
 drivers/dma-buf/dma-buf-mapping.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a..f2bde38fdb1f 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -5,6 +5,9 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
+#include <linux/align.h>
+
+#define MAX_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
 
 static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 					 dma_addr_t addr)
@@ -12,9 +15,9 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 	unsigned int len, nents;
 	int i;
 
-	nents = DIV_ROUND_UP(length, UINT_MAX);
+	nents = DIV_ROUND_UP(length, MAX_ENT_SZ);
 	for (i = 0; i < nents; i++) {
-		len = min_t(size_t, length, UINT_MAX);
+		len = min_t(size_t, length, MAX_ENT_SZ);
 		length -= len;
 		/*
 		 * DMABUF abuses scatterlist to create a scatterlist
@@ -24,7 +27,7 @@ static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size_t length,
 		 * does not require the CPU list for mapping or unmapping.
 		 */
 		sg_set_page(sgl, NULL, 0, 0);
-		sg_dma_address(sgl) = addr + (dma_addr_t)i * UINT_MAX;
+		sg_dma_address(sgl) = addr + (dma_addr_t)i * MAX_ENT_SZ;
 		sg_dma_len(sgl) = len;
 		sgl = sg_next(sgl);
 	}
@@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_state *state,
 
 	if (!state || !dma_use_iova(state)) {
 		for (i = 0; i < nr_ranges; i++)
-			nents += DIV_ROUND_UP(phys_vec[i].len, UINT_MAX);
+			nents += DIV_ROUND_UP(phys_vec[i].len, MAX_ENT_SZ);
 	} else {
 		/*
 		 * In IOVA case, there is only one SG entry which spans
 		 * for whole IOVA address space, but we need to make sure
 		 * that it fits sg->length, maybe we need more.
 		 */
-		nents = DIV_ROUND_UP(size, UINT_MAX);
+		nents = DIV_ROUND_UP(size, MAX_ENT_SZ);
 	}
 
 	return nents;
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

