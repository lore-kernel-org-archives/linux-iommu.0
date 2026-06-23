Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ACCDDA9
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 00:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782173305; cv=none; b=cvk1+kfjKdTeovVm/+CFASBb0CLQByknp7djCyM0Y9K8UxWhNAKShqT5ElslAMxpCGKL/YwvRebjI5Rrjfn/SzQnsfF9HrRwxKHjvRJRq86E8I/q0QG60wzh67pwdAD7eflbJTLB8/oLWKzT8N9Cyh9qw6NR6OQNttwNWuZtCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782173305; c=relaxed/simple;
	bh=bxiEwAMW5AQXMqtf6AJ9fJZ5JQ55OzpMjbRYCa2FFPk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hjZKdtfe3UdKvKM4y1WWAQ7+FC1OlOjv1RV53SXQQcVn+WI55H4d2xcHMxr174gTnRbFTAnp7Pv88OHQSEOFzxTr9tcustuY3fjOA22qrIlY02C3F0l5rY5bVYiT8E1fzv6ojXXZzZ575PkFrd6DVk/ie+12U1bKGLtQmt4R1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sharaienko.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJruKStb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sharaienko.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJruKStb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6bbd0afffso91063495ad.0
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 17:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782173304; x=1782778104; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xQp1y6BeLSghjxVvGOCC8Rys2uDwd+KVV3uhnwJF7jw=;
        b=qJruKStbTqKXZPMK0+IPwPOAgkkMgASakuC5IlNNTrAVW7VkCWhAcROAItAMJr1vRe
         HS26i3MzDDfxQ8qWU+IZLop7/O2UiPkh6fB2f72xHvc9KmXMIe/47t0gVl36xKzj8sic
         tj8gxJmvsagz7W4YX7t1aYbn4pqNlhj2k7rwPPw/bTol7zhLqhWkRGT+q+EJX5k2hDVR
         j6ZwYnq5t9CeLmK8xoWF5kCfnSeUq57Zh7vkp9JPxr7tbGRcp0MqG/AMcPsURYWwY0Of
         7tnlorrFr+/wXvPKxxREm6T8qCShmDwrpHOTNb7DB/KOI62l5uNxvMR0NaSVsW36HTbL
         J0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782173304; x=1782778104;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQp1y6BeLSghjxVvGOCC8Rys2uDwd+KVV3uhnwJF7jw=;
        b=K2HuihS5GpMI8xARswbg/nymvjeHwiSxXQ7Zsu94wx/2aORui2nLfe9UKyVbGrKjod
         Vr22Vty6c0oD8Vacv6zlbBOobgms3ZOC0EPY2njDzWMh9UiGKnpXlCIRnAx5ANIoyzu2
         yqj7y0fYQPbiBWOOa9EjiGUdPf+x6T+ykLwGebmaaVE3dVuFd0z9/isvq9qv2srolB2a
         4S34JKWWunjOjo/4rsLr145i6dV/DgbpahBqqWjUJpfwlQTTasNBaad6SGUpSc71KzZl
         X52aS+CL+4xTTTgRF7/q4grh8EzPfgLkwYB5MSzdeOPn6vG3yWxREbyufXOug6+B/USF
         jLVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJ7xGFBkizUfMD4g2MZ2ZnCf9QM/FZz3Xe3UyJtjIbLGVMErF2ZVePyqmRAQVwwss7E5MmJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzJUsk+8oj40yBRovMUytq/BOInhSfS/I/XRwx0X7jU3K1WIelT
	po6wIu9tQGBmyAQjwQKBsQ02FJqFPhRD2r4I+KQPgRdz2tLoDRYpLmdOMqaK1M94GM3HQKQaOBO
	cF/elx1R9/x/A/kodX9CGmA==
X-Received: from plbw4.prod.google.com ([2002:a17:902:d3c4:b0:2b0:a8dc:303f])
 (user=sharaienko job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f68b:b0:2c6:d5da:838d with SMTP id d9443c01a7336-2c7c76fa522mr6142045ad.33.1782173303651;
 Mon, 22 Jun 2026 17:08:23 -0700 (PDT)
Date: Tue, 23 Jun 2026 00:08:20 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623000821.2269955-1-sharaienko@google.com>
Subject: [PATCH] kernel: dma: coherent: fix spacing coding style issue
From: Vova Sharaienko <sharaienko@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: Vova Sharaienko <sharaienko@google.com>, kernel-team@android.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fixed spacing around * coding style issue

Signed-off-by: Vova Sharaienko <sharaienko@google.com>
---
 kernel/dma/coherent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index bcdc0f76d2e8..480dd1766ece 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -28,7 +28,7 @@ static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *de
 }
 
 static inline dma_addr_t dma_get_device_base(struct device *dev,
-					     struct dma_coherent_mem * mem)
+					     struct dma_coherent_mem *mem)
 {
 	if (mem->use_dev_dma_pfn_offset)
 		return phys_to_dma(dev, PFN_PHYS(mem->pfn_base));
-- 
2.55.0.rc0.786.g65d90a0328-goog

