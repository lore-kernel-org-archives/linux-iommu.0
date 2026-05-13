Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EB3B38AF
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709160; cv=none; b=WJ0jRYLxpnh0a+wTlkSEEniTJWOBmghK74MCenZ/fDwbKop32dGp5ugEu62K0qBfPVfFvetAGeVe4cXmgcloAHXoydgOFfqcYUYK92/7gWNgQ7l/aQEz3AEziFH0PJ1pVytnnNW27KqaNx4RNYy1b8nO4eftJXHEYDLXjuOCcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709160; c=relaxed/simple;
	bh=3+vC3XhrZHghazZCLS7MjjGZmWC6hN1vdgUjS/12R3g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYKEs2p7hYswU5GFfDH9xMDSw1fPH2aNXcrfAIe4HQPFqfvWxOYWvOednFoJEfhxV5k4SFawOfzAS+a8b3maBE7cnOLg5sn1DM0CLalPCs1t1bIg4eJAGlCZRCdd6vk8gcTiHw9+IV+uentxwyi2DNjXQCDTXTF2BUNdw4rVuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aglFLYb/; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aglFLYb/"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45b7ff2140eso2000883f8f.3
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778709158; x=1779313958; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jR1Wv4oMHHpwdm4XGb1XftGJUcGelJg9xckwdNKgGB0=;
        b=aglFLYb/iJuiceCrj5I9GKXOQRYzqdySULQqvgdCOeZOb75JGnQiupl5+v2OFwcABC
         ID8pQ3VOhJRI9m8GrJ37KAvHCxWJUXk5Ku9Dzqi5z5DxSdJd/jmisiGheAuA8WOWPBlX
         +GxzOttGyUDYQVu78aczTXj2UJ/y5hAfEVs9n54dIunFPew0H+PXGa6U24C7aV3RqIYc
         F1xI3DKBqltyBtrW5AvD0HzKQ/Gd4FUSvgP7ZewnFPk15GJGUEWHfzP66wrw97q4zSjZ
         ot2cpX//qC3Vco1YwaYUimCnoqiio9jUXjRqYLveFQns1CrmL90Z2Sp3NT8mSQT+vVUB
         IxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778709158; x=1779313958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jR1Wv4oMHHpwdm4XGb1XftGJUcGelJg9xckwdNKgGB0=;
        b=nW1EUVR3/Z9jrU4Kiq7FOVxsVopTNirPeuSP4nwgwN2SMxd45Gwii0VrRHe+Wgboee
         8uWM+kBbo/o+Ojd2jB0EOSSRxYfAfsXfk0cRaZ1jO2bQuAHfZ9xVmpqjqukjb7mxGmUa
         jDC3AiTLH+PDZxDdTtOvAqvh42ZH5+NqEK/ZNzhLk1bo6QDe7+3bXLZgI/R9WvpBLlBH
         7hf5bpkDQ5QfPA57pqFQQBvUGHyHyouqC/Pa5eyVJHeiDOHkZW/sEaA6Nlb4Up/kF1Na
         Eivyu5+SJlkoE8hhYoYcTLvlh1aMb8GNSGy0s8TJQYy7sB+rK4lOHgNcpV0+kCMtadVK
         QCYQ==
X-Gm-Message-State: AOJu0YzgIZZ4VZKiAgdtjV9s4Wqv2pFfyl5sJi+GszhYV5TkWu4uTR2I
	JxeIZgJMKkEFDRxjwsDQUN9bEhPRdvRqZokOq0S70pu/7pP5F1y/gtPpiCcRjrBCWW6BzZZjnft
	s/FBoxGuTpIRv/fwVtCeZpFce6Gp3bn9YubG3Q0HJdLXITVjFABRUIzHZzS4VuKwxp5u7wr5ewE
	fKXO4DI8cYJ/iOGMoYqPgv9ZiMX5bcouZ5ytF7r3H2kbWx1A==
X-Received: from wrxk8.prod.google.com ([2002:a05:6000:48:b0:44c:2fb:a56c])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4008:b0:446:96b1:f51 with SMTP id ffacd0b85a97d-45c59cd2144mr8466705f8f.22.1778709157467;
 Wed, 13 May 2026 14:52:37 -0700 (PDT)
Date: Wed, 13 May 2026 21:52:01 +0000
In-Reply-To: <20260513215203.3852661-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260513215203.3852661-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513215203.3852661-2-smostafa@google.com>
Subject: [PATCH 1/3] iommu/io-pgtable-arm: Use consistent sizes for page
 allocation and freeing
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

At the moment we use alloc_size to allocate memory but then there
is a logical error where we just size in the error and free path,
which might be smaller.
Also we size to do DMA-API operations, which is OK, but confusing.

Instead of this error-prone handling, just set size to alloc_size
and use it everywhere.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0208e5897c29..0cbe545c491d 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -253,7 +253,6 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 				    void *cookie)
 {
 	struct device *dev = cfg->iommu_dev;
-	size_t alloc_size;
 	dma_addr_t dma;
 	void *pages;
 
@@ -261,12 +260,11 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	 * For very small starting-level translation tables the HW requires a
 	 * minimum alignment of at least 64 to cover all cases.
 	 */
-	alloc_size = max(size, 64);
+	size = max(size, 64);
 	if (cfg->alloc)
-		pages = cfg->alloc(cookie, alloc_size, gfp);
+		pages = cfg->alloc(cookie, size, gfp);
 	else
-		pages = iommu_alloc_pages_node_sz(dev_to_node(dev), gfp,
-						  alloc_size);
+		pages = iommu_alloc_pages_node_sz(dev_to_node(dev), gfp, size);
 
 	if (!pages)
 		return NULL;
@@ -303,6 +301,9 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 				  struct io_pgtable_cfg *cfg,
 				  void *cookie)
 {
+	/* See __arm_lpae_alloc_pages(). */
+	size = max(size, 64);
+
 	if (!cfg->coherent_walk)
 		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
 				 size, DMA_TO_DEVICE);
-- 
2.54.0.563.g4f69b47b94-goog

