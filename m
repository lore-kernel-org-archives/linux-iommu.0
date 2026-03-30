Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4C03264E9
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 14:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882287; cv=none; b=EgqMQI+HPG/OAUDaZ1lKL1wm4I+IqN0chX37XF2s/g5xmjtxCIoumOpN3AgtiEdYhtdthEnp9VFJ6x/z+3TWUhtUG8/p1aOg9W5+K7hZOKg+5CtZ44cXTSv1nwf/NrmMm4RNbcOk0Q0mraYiF+bjLfCJXH+VfbjXL6x+od89x0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882287; c=relaxed/simple;
	bh=FXMPltbZcZ5fueDOME6tu6lHCg7hLrz8WRDK2s/pB8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NvLsOH6DunMPnzvUzVZLF6XYBFO84GDejYZJz7NOZc8iGh6FEH1/UiQ5pR1hAUNCH8vGhpwaYn7HacSzRPciQxkkojl8oXZmTUc4xers75WDs+7ju9xRx/PQax8XJWog8u1Wnr3p9yOQdubfoKExv2W4WhCHDrlqcuA/w2kKc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/6odsXn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/6odsXn"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48542d5aa9eso41527335e9.0
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 07:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774882284; x=1775487084; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J65BpbTDZfVi4pM0t9Ln1+SAYufEj40Do3q1lK1k0LY=;
        b=j/6odsXnao3non0L0viVmFKmz7nACE6JkYgo2gJuXBXjwHhrnpP+fIxP7qhniSBbxQ
         w4fMrAINsZmbEiAZO8H/Y4oix4zdivt1p5TbkrMocp8SIMGk5KSSDZvjkXhKHxWCyhpz
         K1jhDw9SCjxh3iRCLY8x7sEKyzoa41ySEOvLF8zN43zWH1aMnEGZVRJ/RptrYVc8rZ7t
         36U3LqZxmVynWV6gNKz0sBD5rLzhFIfgMxAfkGpseN5Uf+mCgONJTRzQQxPU3MOF6grP
         q2XGuKELRGiA8kdfxjlYd9Eqwhz9MwuYabzwSrdRFjrsmD4OBpbZcx2VI1SElOAe0rXn
         zUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882284; x=1775487084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J65BpbTDZfVi4pM0t9Ln1+SAYufEj40Do3q1lK1k0LY=;
        b=NqjKy2h/kBghjQ6YL5euNSHs1frpFbhra4goravDIV6uZE/v8o835itVdnaInPCY56
         iXj4rGsYn04r+MlXY11POKR4XhNuxuwVEVZ6p/wM0mHRDKNoWfuM97fxQwM9r5SlSJce
         OQpob1SqBAmZE1dZVqvUHFOI6Tm238aNTRjwaNP2kFUcLwNlBt4/R8t4C2MIVMNLRqL+
         JVyeswmey0uH5qbqWjiDSs/UwiXcxX8ErG90KcNz9sdmZeQ5QOHcQK8/QKxabqTWWWc8
         7RaQA1lZxdJZa4cI+rw82OAZAqf3jxWedjbTS16i4ELaItI+d2Y6DhhSTq2fIQdo+6Cs
         bzYw==
X-Gm-Message-State: AOJu0YwrOlmJJq8zvEh1qaul67rgB78vLDo4711iepHXUjpHBP3eBr4T
	n4SRBBZpWN7GCCGEXWh1C0GUn1Cq5JD7d1R0oL2RdM3wm3OsLxSNYAWXlw++fBa5+81gOBdXbp3
	aXhqorzbA89oz40WsgDQ3YgUodwJxgZddRpP0+AQlsy9mpuzeuSGMPHJ4alSWyfGuh0LXXCj+rc
	T4AyFxKvqWqTs/Rh+6nIDmEOf6Zxwr5wGIfW1X1tuK2dwqXw==
X-Received: from wmpd21.prod.google.com ([2002:a05:600c:4c15:b0:485:3890:399c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1e:b0:486:fe46:b647 with SMTP id 5b1f17b1804b1-48727f00d8fmr210293035e9.10.1774882283962;
 Mon, 30 Mar 2026 07:51:23 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:50:39 +0000
In-Reply-To: <20260330145043.1586623-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330145043.1586623-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260330145043.1586623-2-smostafa@google.com>
Subject: [RFC PATCH v2 1/5] dma-mapping: Avoid double decrypting with DMA_RESTRICTED_POOL
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

In case a device have a restricted DMA pool, it will be decrypted
by default.

However, in the path of dma_direct_alloc() memory can be allocated
from this pool using, __dma_direct_alloc_pages() =>
dma_direct_alloc_swiotlb()

After that from the same function, it will attempt to decrypt it
using dma_set_decrypted() if force_dma_unencrypted().

Which results in the memory being decrypted twice.

It's not clear how the does realm world/hypervisors deal with that,
for example:
- CCA: Clear a bit in the page table and call realm IPA_STATE_SET.
- TDX: Issue a hypercall.
- pKVM: Which doesn't implement force_dma_unencrypted() at the moment,
  uses a share hypercall.

Change that to only encrypt/decrypt memory that are not allocated
from the restricted dma pools.

Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/dma/direct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8f43a930716d..27d804f0473f 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -79,7 +79,7 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 
 static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
 {
-	if (!force_dma_unencrypted(dev))
+	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
 		return 0;
 	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
 }
@@ -88,7 +88,7 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 {
 	int ret;
 
-	if (!force_dma_unencrypted(dev))
+	if (!force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
 		return 0;
 	ret = set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
 	if (ret)
-- 
2.53.0.1185.g05d4b7b318-goog

