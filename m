Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A727FD4F
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940862; cv=none; b=BIY+khZU1Rrl2Tpjr0/588LIAlSljomNLH/v/esgnV5/IDohCCp/w5ZfCtT0uozz3nou+G4PiZ+T1LGxzKAvnGFm0FgW8Onri+wtfuAs6GBE1OTVWycm8lfR8/xTzr3KtwdxDxqwwJn64RbTJooJc6gqYHP45WGvqR+u7Vpcq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940862; c=relaxed/simple;
	bh=6vPJz5FklGOmRIlTlxNWv/NMzXGEFSNYxGd2jakuq1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DDmFVDXX4fdaeY4R0iJxZqjYtVBWCzT03eg7ytsk6ZOXEQpSXKrJN9jJ7CUSdoyFBAdMUrgEhKxoGYf8b2vkxET739FQ6DMnbL4AQThfwOJYTrNNPaO0WgrwEyc76JxXebZiU+tirWkiiK9mXgbIyT//x/EcwK1TdBPHSBCjTaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlbsoua6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlbsoua6"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa860e71eso2397736b3a.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 17:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940860; x=1778545660; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+FOv1S5jZxTI8xiOq/TIFYAKVGB2GSKJ5eXMG7ksgc=;
        b=vlbsoua6+ndmr9orj+Lw9B06+RslDqtc/AWQfflUucq8kkvV+Kvn+Sb6GlpBpOjC+D
         it90Q0zy5aJ1FrJuLA6bE5GK3WUlCYaz9rq0UG8qygrlIVKbPdbk/lUHybl4HPPTAvcS
         3kvkSPwPR/kiCsjgfg9IoxOjBzGq0+/xspipf6ETuHen3E7ZmBJjBpMTHC0y7BJIKCP/
         2i0pKi0qKPuJbXTkM7LvXSyFyEvusaI5kwEZ4hnbYq/2Q6Ge3NtzA/y+SVUWFqWUEReN
         Njm9zxjfUCz2QFML+EbKdv1kpawfC/LD8qU1vKuzquOeDV2hZcMTFIk/aDmq1IOn6ztP
         fyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940860; x=1778545660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+FOv1S5jZxTI8xiOq/TIFYAKVGB2GSKJ5eXMG7ksgc=;
        b=h5HHTyoo5URzc12nMoZPIIMfZvFq0hmQJNaKsEwEli0oMzQnRt8AKkQ0kiQHX1WEwM
         zwlRUXNQnzUDUfq49vthnGfRTOUkwuXYLHAC3xB8KBPRIPAj6ehp9wOelwYlKJtbgqJ6
         x7QjIO29bqZmuFTJY44yIcfOP+OveQFIC4pnGFk+Gq+Cmfj06SSocAKFVS2EyTJQCPlN
         kGyDcR1U5qRPuiNsWtWZ+FWtZcIzF1gObvGZsyMpEKNhQDWGrJW232a4VuzNowdu9gDg
         Spvp1mBYIYIFlgFTvghyb9DZ+vgbfV9cJJ/PdqdhEVejyLJGpDIBjI6kESro0zRMZ3k4
         QbbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Q5C0WjEGSQUGfGsIoJCXVlFDIRlc89w/8tq3gwLb9KO0Kaa1LGNOLp12tfGE9dxFbBppo5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNF6Zp0VvgnPcQxudlbJlt5j2AUoUJqZwH2DSP0NU+piIPIxRG
	TaMi/m2COyWnPWK2ZoyvyXaiATvGrCgn0ReZCQPdDf7zusdO/jbqNzBzMTM1DWzrvVxMrGJHP/8
	g1V4eTnSaFUsSwA==
X-Received: from pfnj5.prod.google.com ([2002:aa7:83c5:0:b0:82f:8a3b:87f0])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1f04:b0:836:5c3c:2051 with SMTP id d2e1a72fcca58-83923d96a31mr1009427b3a.23.1777940860319;
 Mon, 04 May 2026 17:27:40 -0700 (PDT)
Date: Tue,  5 May 2026 00:27:34 +0000
In-Reply-To: <20260505002737.2213734-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260505002737.2213734-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002737.2213734-2-skhawaja@google.com>
Subject: [RFC PATCH 1/4] dma: Add DMA allocation preservation KHO ABI
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

The DMA allocations can be backed by a variety of allocators. Add KHO
ABI for the preservation of contiguous allocations that are done through
dma-direct.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/kho/abi/dma_alloc.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 include/linux/kho/abi/dma_alloc.h

diff --git a/include/linux/kho/abi/dma_alloc.h b/include/linux/kho/abi/dma_alloc.h
new file mode 100644
index 000000000000..46e61db81abe
--- /dev/null
+++ b/include/linux/kho/abi/dma_alloc.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KHO_ABI_DMA_ALLOC_H
+#define _LINUX_KHO_ABI_DMA_ALLOC_H
+
+#include <linux/types.h>
+
+/**
+ * DOC: DMA Alloc ABI
+ *
+ * This header defines the structures used to serialize the state of DMA
+ * allocations, done by device driver, across a Live Update.
+ *
+ * Only DMA allocations done through dma-direct that are contiguous and
+ * allocated using alloc_page are supported.
+ */
+
+/**
+ * struct dma_alloc_ser - Serialized state of a single DMA allocation
+ * @page_phys: Physical address of the preserved pages
+ * @size: Size of the DMA allocation
+ * @force_decrypted: Whether the memory is force decrypted in previous kernel
+ */
+struct dma_alloc_ser {
+	u64 page_phys;
+	u64 size;
+	u8 force_decrypted;
+	u8 padding[7];
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_DMA_ALLOC_H */
-- 
2.54.0.545.g6539524ca2-goog

