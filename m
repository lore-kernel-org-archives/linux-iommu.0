Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10A282F1B
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940864; cv=none; b=GEF6bgTHnp8RjczxIZqtxfo433KfvBa2grEoo0nA+kGxSrjLY8CiiGv9D6sXbyRzXNOke29ukHx3SDa059CeZEDDtGoEYWJ+jtd0mglcVHMTLVMsrvN7PO56jETI9F/ISaOCLCiD3aG9aAtlzyWdHkOBPT8utI35MaV09Y9eREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940864; c=relaxed/simple;
	bh=CCcGBBN0jmPI/uNBfL2Btoc6e31bbEmFkyduYlT94ZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D4OWWeNq32+Uk60J1C8JkiHCTk9uYAor1Z7rxyOwndz71A6BBsQLqLvormxHPGMHhqT/qzi4oVDNYeXGed5KJKoYuYnewdVfgOH2O9gX94A9OlW5LyGtfJ+1QiLnKAb5u6lZoZoYIVcABmqgRTdGkYD7Jg8Wxv6FQGbINh16/rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WY5NVdMT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WY5NVdMT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-836cfd84728so745772b3a.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 17:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940862; x=1778545662; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPL/zEjIbq1+/WxDxvRlbVhXmcB0wkR7Z2KUt1rRxnY=;
        b=WY5NVdMTzMrOSdQCzCdUJzHjkU2nG6iVqjuZfzQlPWKdzK4WZgQc9mVllhn2EY0ePp
         UIwj12YDvfHbhr2lxbM9HLBTU1ItJKiP4Alebi5Fwl6PI83qoU5J3IGIe08KDVJv7Atc
         8UVfJvYLRYaZ5ybcZXbtTR4QPRYhZV6b/jk3xlGiAAjUsneEBhOyRPe5chxHxoZ1+IP1
         nLGXf99kiyZtiB+AP8QmghHVeO8xFDnx8JbiNcIysk/RKjioLclCDBmV8zSYA4W17tpF
         iG4T3GKpHMO3y1W7JLEnu0nO+zddgaNeY0qKMjr/5+FLwwSuE66PqBZfgOcWagK5IOgn
         OFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940862; x=1778545662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPL/zEjIbq1+/WxDxvRlbVhXmcB0wkR7Z2KUt1rRxnY=;
        b=Vtcww2Y5njo8klaXFL0vcnELUTzrMvlCqNy6X83uzyv196ldNZplNWSfbnx1mVws1n
         lzt8lH6udSJSfipV+P3OQUL1c5AB37cDYXCxjRPMaPgV2x1XBsIfH2HsYF+27O0Up9pM
         mdhLlkBvRTBJeF34lZdb4hOfM4f0Mv8O4asRP3UbjBmwOmq/SF3QASFd4dZlsQmIXR8S
         nTbfYxmwZZ1Eg+XRrROqSxt3IxJtRfXA9N06gU1TP0fJlFz2AUJXEL8C/xVhdx/lV0Yn
         7rn2T5zH8C3RySFpICQ5CRwuU9/akHWkRnnpGB3O2D0Ys/k4iZ+QwCpfwR9hzqYTJlby
         AFiw==
X-Forwarded-Encrypted: i=1; AFNElJ8PV8gJOS97LN9QrhMQ9zRXz0BPrixPaiZ+9WGm8sW6/CRnIY0oe3+Rk6mT4xB9ZN7f2lh1Qw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+sgdh3GoUkgZnNxJsq5MY8UDNiy/7ivS9bKvrTHyPMWdeScht
	6LXBNE26B45ixRNQqezeO5h/IODb/DyKw+9tyhpWAcE4YmlWs71I0whNQ+Puci3o1adul7U8No9
	PeHNaqtBB7weTNg==
X-Received: from pfbgj10.prod.google.com ([2002:a05:6a00:840a:b0:82f:d8c0:fef8])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:340e:b0:837:8a0c:8f70 with SMTP id d2e1a72fcca58-838fe8703c4mr1212855b3a.28.1777940861986;
 Mon, 04 May 2026 17:27:41 -0700 (PDT)
Date: Tue,  5 May 2026 00:27:35 +0000
In-Reply-To: <20260505002737.2213734-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260505002737.2213734-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002737.2213734-3-skhawaja@google.com>
Subject: [RFC PATCH 2/4] dma/pool: Add an API to check if DMA allocation is
 from pool
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

DMA allocations can be done through DMA pools, add an API that can be
used to check if an allocation is done from a pool. This will be used in
the later commit during preservation of DMA allocation.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-map-ops.h |  1 +
 kernel/dma/pool.c           | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 6a1832a73cad..6a0bc4ea2467 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -216,6 +216,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
+bool dma_is_from_pool(struct device *dev, void *start, size_t size);
 int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 		dma_addr_t dma_start, u64 size);
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 2b2fbb709242..32ce4d6d7683 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -307,3 +307,16 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 
 	return false;
 }
+
+bool dma_is_from_pool(struct device *dev, void *start, size_t size)
+{
+	struct gen_pool *pool = NULL;
+
+	while ((pool = dma_guess_pool(pool, 0))) {
+		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
+			continue;
+		return true;
+	}
+
+	return false;
+}
-- 
2.54.0.545.g6539524ca2-goog

