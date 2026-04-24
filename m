Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB3F3BF689
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031459; cv=none; b=Bt7FQBGX0HZlXlMyd+wHT6VXmkAjVzAIY1IJyQoA77QlCrm67yp6AOQllcf0APpcly8SnQLjmspUHwqQMkD8P2SUmswaL6A1YJHO/lbNNgdeHiLkV7y97W7cbmoKRMNtIAf5O3L1vlIcHYNV6lKgytIe3Z8VEWCtlxpCJhgTwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031459; c=relaxed/simple;
	bh=gXDiGCFgU9yPd3l6Mb4B1sNe97uiBVDDnnXvLu2QRKA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UASu7Zd9JYZgp2AcU1LRHpgLBDqjPECayYmS4xMglL0UH5MtXbJpSV2e+lZCXFFQURDZRtubcUk7kLBJBcTLGB7x2NoPBf7DGkc5RSwX6qdG2EyL/HSW05t0iTRAzgyLExbLBj/zLtBkMjND9f6BwcogTqVJ/x365tTJx342b/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1hLVlwt; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1hLVlwt"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b9c5f899463so499975066b.1
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777031457; x=1777636257; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SWrPyM9GmNoDHKDhuqATorLaXifk2WZJVD6FV45FxQE=;
        b=U1hLVlwtUqS4NEMsHfdq47EVP8G8RFSMvu0gJRNbklmi6fZ/zFii9+a1NvUrjCoMsp
         dExP/A8RMV/L+17UqhzXfuU54f1RtCU3j+t8fws6GoDOJZ+0AgfXMNYmG4dErxLijyqD
         oOpj4Bbr/x2njAZerIRbU28SqwHE65dLGYPAfs3fSNxQkKufw3VHRWx+SG75NcskQchq
         VO5/ZLPY/lfZN9w7cCG/sfJzlEFcdLP4kqLgaJ/uOt6MbAAgIplCUcK/B/CQjtZb64D2
         8v3M0i2IX9ZZSU2es5r1c0rMOZiDcZeJEZShyO9wKqN3oyd3I7tqt4Nzuw4taCwnJuYG
         aGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777031457; x=1777636257;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWrPyM9GmNoDHKDhuqATorLaXifk2WZJVD6FV45FxQE=;
        b=WDwJBD/xJ3cMmt0KOXGEdy0Bv9e1EmP/hWTYB8i3VMFysMnzH/odQvQpb2ptD+yLBD
         49fsPofGXkd+aiBdYxeGW5aonQRM7dOTvLjMBVhE6+mPwPZ8nCwDevRaI0A6c0vp5n5f
         XqU+XiQXErtyZ+JaZ31bMMzjbtwg+RimPjbc9XLkB3eYg1yMiO3m0JvgyVt0F9nW6riZ
         vWNQ3amMna61KRZZ59K5xYvLT6xLozNnJOMW2x2YKfr+GZTk7L1BQYXGl1vAUtwzuqK8
         DEWcZCkWqhojHjoqXNk0AqqwlwzePXbEGTJVHNSJANoKq5RqZRzzibnWtgYUFiPo7sbI
         7XAg==
X-Gm-Message-State: AOJu0YzaIH6HS7EQhr7FWlFuX9ogKQ+huIilW3DgUCCcFA87pQBNMQKZ
	Bv8C3AXxqtWGJEV7FEwb9s2E2PnsWlnkp483ICWaSkIY6AGfUHySCprIR6OwoMzCEd8lYDXJwgs
	2ldtt3uCzEa0gYcZ7NhOd74br/GwXhIt27FDsYDdFgRh2nGdpfyeQo3z5xvtuQylZd+Z/SeIoKg
	fytb71yP24vQdYkAuMy77RShL7db38q65zjyYeG8qD7kD5+w==
X-Received: from ejchr41.prod.google.com ([2002:a17:907:3fa9:b0:ba2:21d4:d581])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:fe45:b0:bad:820:65b4 with SMTP id a640c23a62f3a-bad08207055mr237495066b.16.1777031455343;
 Fri, 24 Apr 2026 04:50:55 -0700 (PDT)
Date: Fri, 24 Apr 2026 11:50:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260424115051.2082174-1-smostafa@google.com>
Subject: [PATCH] iommu/pages: Fix iommu_pages_flush_incoherent() for non-x86
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, robin.murphy@arm.com, will@kernel.org, jgg@ziepe.ca, 
	baolu.lu@linux.intel.com, kevin.tian@intel.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

The dma_sync_single_for_device() function expects a dma_addr_t, but
iommu_pages_flush_incoherent() was incorrectly passing a virtual
address.

Since iommu_pages_start_incoherent() enforces a 1:1 mapping between
DMA addresses and physical addresses (checked via WARN_ON), we can
convert the virtual address to a physical address before passing it to
the DMA API.

This also  matches the behaviour of the other non-x86 in
iommu_pages_free_incoherent(), which uses virt_to_phys(virt);

Fixes: 36ae67b13976 ("iommu/pages: Add support for incoherent IOMMU page table walkers")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-pages.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index ae9da4f571f6..e9e605b5fa3a 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -137,7 +137,7 @@ static inline void iommu_pages_flush_incoherent(struct device *dma_dev,
 						void *virt, size_t offset,
 						size_t len)
 {
-	dma_sync_single_for_device(dma_dev, (uintptr_t)virt + offset, len,
+	dma_sync_single_for_device(dma_dev, virt_to_phys(virt) + offset, len,
 				   DMA_TO_DEVICE);
 }
 void iommu_pages_stop_incoherent_list(struct iommu_pages_list *list,
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog

