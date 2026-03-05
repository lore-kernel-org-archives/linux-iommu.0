Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3633E7
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730235; cv=none; b=JwYgHUkTnGVbpcsVh/Fy1oxGaQqzr9CzHLUkvhs3IjW3rsABQahnlV8ITiDY/f6jZgLW+gd00ABmDedooq5tMnw2CwoDgoI8u1DCoIivj+ZUHjLdOz93fL7YE+3Ruh/1kFLoH9b38igO3cyvheVqFRtNipNUz72tSC8miEF/7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730235; c=relaxed/simple;
	bh=JDueDHhsxXmc1y6n5S4DYcGj2eQqYmuSsuhRKPpQiKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G4wgffqWLj81+zO1KBXASM6g1ky00dtDiodOpgw4Pm7IlI/R/2r21G+nkmM0kkc9zXQop3YSZuCPv0oaeWnTParoxT5YsrE95xtBIAedv4/TZ7IB6ZsTUgNDEtJxcTSG9uPRa736rYlZPAB7f+r/Wra0l34bvRBYIU00buSROTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W+Vl9tjf; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W+Vl9tjf"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b9419d9d0d6so73165966b.3
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730232; x=1773335032; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0p6wM34Mfv4MrdThZ0NuNbl/BQ6PjSinfQE/9xPBxo=;
        b=W+Vl9tjf0WEbzXt7ps5V3xWQILzEkJCFDcobUyuD/fSTl8XgYR+DoKBtZSBndvYP1v
         qyBGDiFDqKWTqAjVIjN4cdg52UroeTBAvFJPO0kliunSp0gNFpavvsJA8mxbkk2tulmf
         P4W/6+iP0U/uwt+cNy990RQdx2XoJVvDDzUargutCWx+n4FiwJQuaJ9YtJzRyioiLAUI
         UWCcwBpmM4Wp7WLgquo1fqx5mIBqtx+EdQAlau9hZIOdBnG/pEuyMG5ITnV6YT5YgyO+
         JIFTU5ModdtRSfb2SckABUmPfLYtm/wSuafDzSpznBWg2EquJd4eRMgktPe0I8FdrMAX
         jgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730232; x=1773335032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0p6wM34Mfv4MrdThZ0NuNbl/BQ6PjSinfQE/9xPBxo=;
        b=U9E4zeiv2CD6KiIoTZaQvGbISYkG41GX3WiYgSI/db9rezTwFyCYwoYSjaqUMvqN8C
         S4TyqdgXg/copLfjYikbul7o17YchW90AkBJjkKzoxEldtPZRA61uOelwU1L1qYHAJNe
         H2S0pGXONzqIbzpu44rHqX+30X2Po2Lipyyq4QVBOPS0lyFr+o31CCPF/stbHJN62eLm
         y24FafPcEfsohoa0IKwhu5faBIpx0eJEflxRJVW3cBsugkBVmlm5M5EDifA657T6s34L
         gqjtQKXvKDaqyBrZV1/0ORnm1WcQOyv5WfMYjMTxHoMVHI3ovCp4cCOMGEE9mzPpC6AH
         PqNA==
X-Gm-Message-State: AOJu0YxMZ1OsZo3Eda9q+XN769wRTGFgz6Ivf05fg0/y6pEqh9K3s2Hc
	aDCPjP5sdwr0/MarfPE3XF9GrS2t76Ev9RCWY+M3CzrXPNV+mPg4Rj9AIiDrlULWEQZIjw0KrWe
	BF28y9qiaBTDO+xkwwCB6Jysotyj1kOyie9sABp10VdeME0CKp+zihOeNC0hlLwCpy56I+6Bexa
	oj3GlwwUXkIcNjGHqOsbe4q6BPteKt4sD4gkwwlaQ+6VPKQQ==
X-Received: from ejgi22.prod.google.com ([2002:a17:906:3c56:b0:b93:eebb:ad41])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2d8d:b0:b8f:e424:ae56 with SMTP id a640c23a62f3a-b9422a20e24mr21885266b.44.1772730231858;
 Thu, 05 Mar 2026 09:03:51 -0800 (PST)
Date: Thu,  5 Mar 2026 17:03:34 +0000
In-Reply-To: <20260305170335.963568-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260305170335.963568-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305170335.963568-2-smostafa@google.com>
Subject: [RFC PATCH 1/2] dma-mapping: Avoid double decrypting with DMA_RESTRICTED_POOL
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

In case a device have a restricted DMA pool, it will be decrypted.
However, in the path of dma_direct_alloc() memory can be allocated
from this pool using, __dma_direct_alloc_pages() =>
dma_direct_alloc_swiotlb()

After that from the same function, it will attempt to decrypt it
using dma_set_decrypted() if force_dma_unencrypted().

Which results in the memory being decrypted twice.

It's not clear how the does realm world/hypervisors deal with that,
for example:
- Clear a bit in the page table and call realm IPA_STATE_SET
- TDX: Seems to issue a hypercall also.
- pKVM: Which doesn't implement force_dma_unencrypted() at the moment,
  uses a share hypercall which is definitely not Idempotent.

This patch will only encrypt/decrypt memory that are not allocated
form the restricted dma pools.

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
2.53.0.473.g4a7958ca14-goog

