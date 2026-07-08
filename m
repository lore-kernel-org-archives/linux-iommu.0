Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387C379C42
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554537; cv=none; b=mHhINOX9n618BlE4bIxGeRU2LFrnl1cR0rw4tJfc7Aft5uCkgfmxfB9n8JXGJvpm6AKYohw3zZcb41TZM0yknGxBe1uIXHLl3Bs1K5QB0zexRWoL9NVppoIoaVWUt42XkFQtd7BZG98X13bzINQDSnM6O6kJh7zNvPnvgMaMHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554537; c=relaxed/simple;
	bh=h9Dc4kDhlbGcQOLn0GzNWJ4d2rERceO8OMxpaRiUedg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NlMkrWd8VaU+53Lld1pzIsFjaHgrsC2P52Qr+e/q6y4tqgbEBSYs4aTAA7Dyezmy4t+BlzeKlQElLvhXCinkP68uhOeEAPjarM+BTP5aKyiRKjWJ55dZC5UlfiKI9wjvbNonAqKQsOl1kzh+WwXZ8hg0Md7flpwAkvXThRCuW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FW80qO91; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FW80qO91"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845bc2e658aso1365040b3a.3
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554536; x=1784159336; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JfihMOdYGKLErlZtxkO4c74/sv22I0BBbL2ChDUSts=;
        b=FW80qO91z7ouO2wImNPawkkudPs/T1i/CDth72dkK6LTy1t1zhQc6KilXKnQXw35Lt
         ds/cTQbvAif4HAI2smMqwa/DGz3Rqop4mcCJwkIVvaieL9AXLQY9AKNnpT85O9CJS3OY
         AIB1eC3xG0/sSmjucauDrr1WYVXVlTnW4JE6FrTUr3NdNg96fC/84fNlVIErx/blVWnW
         zNqdqhQgoJhHiAqzV9T0O/V29P3uleDijN737Mgsz46Adk/8MRZknDyuIzARzu6OpuYf
         823eRMJGRmAh+9hPmWAxDmmTUFJVrE1X5I71XY99KvoAbQ3yhQkqX7w35jpgSQIJ+80m
         OSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554536; x=1784159336;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JfihMOdYGKLErlZtxkO4c74/sv22I0BBbL2ChDUSts=;
        b=IjgLPciXOqqcvzHwHVSSipDhicwONdx0YPxJY+e5QQKcPAEPSTQPxtJVrSix59bFSG
         wFcZmlFCsrWBKwCgGiPD2ZxIlv3+uhjNgo2evApmsINQaHNyfxjrFB0aoAbn6/V5p+oZ
         utX0R4LiWApO8xqElU0hndtO2yKEVkcRILInTLcrKDhDE7D4nSBrCBSPhByXrfcivBEF
         yJyzh+h189eRAqO3W+C4SxOVfGk7IkLwY3c4u1M0ey4ovCzaDOfhTrqWcHzoN3B/ocFJ
         fSAg3KbJJKn43g3DOg78OISb9ttkPhP5nD9aXwYvJULyZVuzEp/OxC+6OiWmM/BUAOM4
         gYog==
X-Forwarded-Encrypted: i=1; AHgh+RoUIdWfwSfvAj+EFOIbtZEZQBKYWHjhNVdD7HqGSoe1P8M8XaFKxaxQyT9WJtUTDZuzNS/1kA==@lists.linux.dev
X-Gm-Message-State: AOJu0YysXGFi+B0vJKB47QlgVr31INa9OBe34wDYwhHbn1uo+/O9UJ/l
	rinAHoWhYMnkRZNXg+ofjZTpz+gP4oPqzfHbitidXJ3XmJ4zDhbNPTc+TCTKEHRFhElv8m2louo
	lpOaisgy/duyc2g==
X-Received: from pgcc16.prod.google.com ([2002:a63:1c10:0:b0:c8b:2706:11a7])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1144:b0:845:ec31:26cd with SMTP id d2e1a72fcca58-84843436d38mr4585247b3a.46.1783554535737;
 Wed, 08 Jul 2026 16:48:55 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:45 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-2-skhawaja@google.com>
Subject: [RFC PATCH v2 01/10] dma: Add DMA allocation preservation KHO ABI
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
 include/linux/kho/abi/dma_alloc.h | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 include/linux/kho/abi/dma_alloc.h

diff --git a/include/linux/kho/abi/dma_alloc.h b/include/linux/kho/abi/dma_alloc.h
new file mode 100644
index 000000000000..ae38cf1a1fc9
--- /dev/null
+++ b/include/linux/kho/abi/dma_alloc.h
@@ -0,0 +1,32 @@
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
+ * @attrs: DMA allocation attributes
+ * @force_decrypted: Whether the memory is force decrypted in previous kernel
+ */
+struct dma_alloc_ser {
+	u64 page_phys;
+	u64 size;
+	u64 attrs;
+	u8 force_decrypted;
+	u8 padding[7];
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_DMA_ALLOC_H */
-- 
2.55.0.795.g602f6c329a-goog

