Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979C3DEAF6
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730236; cv=none; b=d7SfDaJ21U4O4Q+ckRtrrsbZoV2R8bs+lA0WN0PFsviAw9YSs7EShXhdt350RnolMtr6MRdRdSlpcBLXySuNLj5AhbqsGNk/3eZs7LgOjsbu2/w3zeXZoo5c3OqF/lChbkhKkl1s/QeWzD+Yve7/WJc3mYn4IFPkEyJqVo/rHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730236; c=relaxed/simple;
	bh=ehXww4EBP5o9XNrGQRSCbBb/4KpkUed7aGW0wp59lFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RPbKjmtWYkJfbMbt3phD54joXpXTIsslvQjhyCL2UnEQa0EYk1PH8R/xJOriTIwvd8xUj8ipH9bxIMFOYH8qRrhn+VXs47tC5Ssv6QqEziri95YWOembgqlIzd8ouK88wyI+j9fJd6FNYXK0T1N3eCJ/dDn6QXwnaTE0qi85L1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0cIcBKwo; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0cIcBKwo"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837246211bso106052615e9.0
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 09:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730233; x=1773335033; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fS2TCdg+GqqKaNVQW4sApbDZr60XuAkM6k9PmxbMvJo=;
        b=0cIcBKwo4IhCYwoBfermdi6OqqLmm6zqeNxZOjPgomc9RdfX6OBecmL3/v2RsDdNj4
         4bcs1TSJ3L0WqOHXQP+P4c1zAkIh6wYbLd2LDE/e10bH9G2oN09RUXqODhEyBbNv+zS6
         pvbYWlEzCMQtdxpMuAEQVFHUne7vfjUOBW2DwgeB0LgLvqXsdTyJoTiwue3/QMhONGMM
         Rs1YwCC7igMulwwlH02S9P0L1ialfm8uTcRz8bBq83B4R2viFdzdOfcqo9AVeZyfGWa/
         VQykgNyMNveitkqBz8WQGUYZEFha0fBRh14qPBudN5YW6r0aZyRTsEFVafe9+iytVL4I
         OYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730233; x=1773335033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fS2TCdg+GqqKaNVQW4sApbDZr60XuAkM6k9PmxbMvJo=;
        b=GPelVRuuoFuheM8+8k9giuoT3WoihezaijED6Y4a1J8YTfVyTXVMugs6PJ1GoewA3c
         RmgmxoBA/xFNQ8yoGOs/LZXqxvE9u19QLkWjsiieh8JkPdZINAEPCQaOsXEd0ycN/Ye8
         o8OoVeKyk+Tjai6DGMiLtl/VTshgIM5SPFobMiYmTth4iRe16NaTpdwRq2wRkB+BNT34
         esQW496JuKsaSOOtvFkn2WSbWpfVbaMgK4CXOxtVPpLR0CpTVdKPEhAjfrObi2eccjfk
         yYcrsFkFaaWySGMx4VOUzbX7r6hArapBtqFYWK+k+B3cKuoe1tV3Jdac//uwHO+dHwl7
         x/nw==
X-Gm-Message-State: AOJu0Yx/2EjHHZVAvlwlXuKfp8xhcHcrGWL8cJ48Dy6USQSbGjunlQaR
	3xvMIhxZFQXHrgrKNxTYIPJIOYDun2IxrppuXmE5mmZkH686f1SPuKxURchboBXGNyNG8MSUBxw
	w3O7N0Y2gZraRsx+QzZ92hevC298EBv7Tk1LH8se0aQ95aNDn94l4YyGbXCIYgg8wZDHFcvunUl
	05GEephy8pxkgtZUxBD0HuHV1+Sbtx3ovyuN5DreszzPDlow==
X-Received: from wmbgy7.prod.google.com ([2002:a05:600c:8807:b0:483:6e65:5bb9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6098:b0:483:71f7:2782 with SMTP id 5b1f17b1804b1-485235bc44emr2834755e9.12.1772730233280;
 Thu, 05 Mar 2026 09:03:53 -0800 (PST)
Date: Thu,  5 Mar 2026 17:03:35 +0000
In-Reply-To: <20260305170335.963568-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260305170335.963568-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305170335.963568-3-smostafa@google.com>
Subject: [RFC PATCH 2/2] dma-mapping: Use the correct phys_to_dma() for DMA_RESTRICTED_POOL
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

As restricted dma pools are always decrypted, in swiotlb.c it uses
phys_to_dma_unencrypted() for address conversion.

However, in DMA-direct, calls to phys_to_dma_direct() with
force_dma_unencrypted() returning false, will fallback to
phys_to_dma() which is inconsistent for memory allocated from
restricted dma pools.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 27d804f0473f..1a402bb956d9 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -26,7 +26,7 @@ u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
 {
-	if (force_dma_unencrypted(dev))
+	if (force_dma_unencrypted(dev) || is_swiotlb_for_alloc(dev))
 		return phys_to_dma_unencrypted(dev, phys);
 	return phys_to_dma(dev, phys);
 }
-- 
2.53.0.473.g4a7958ca14-goog

