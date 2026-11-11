Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395308;
	b=lEgOh/lgnziie1jFkS2qRSlPvNByF2Ai4Ji+sObOPG6yHYDqIg0af7ELk8RE4ipXtTP0
	 862oR6ZCX5kQx2/aTokXJkR5psRKR+tDUFIioHzk2/jRlpBVmNcu7oDdMdXlQSdhz2Yit
	 3ujjSwKX27dA8jETG6LP3R0AXUmcOhcSj7DqE5vvUPvffIdzsfOflHlALVOAZiV3ekezG
	 5u0TLA8acmCF3lOQLwx5vHJ9dFIz4EBCVhdaE/6W+bSPfLQwtl9oqxS2+6aegBO5VEH/2
	 yOlSBLkIpH3tB6NpAd2vZ+35AypjUwptgUQU4oaHfVbzHBl3/bfrtYWLLZxerelvqKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=t9e5fiKyui+gLN6NGnueZPdNy7gU/9XjTaWNkCYpwsg=;
	b=2J66ExHC5ypSY3GFT1Le+etWasg+h+dnh7jlSqlG2eJmwAsrh6WsiTKwI9foxdsNBeKS
	 dJ5mKM8N3rZkvFynOw89nIonqqUnqaaJWnzYlONn7zW1lwPUDtpub7XhcAak/69g6uOlt
	 gKfKYhBRweivvtyZUF9c1KPdp/98VdBqhNk/TjKJET9Cm71hs9i4GKtEzmrF0FIuJj6Ja
	 qkdtzCZmjRLT/S7eFlTTB1y1IVow3Ucubsu5oB23Y9xvNl7DdpIBMchgSsEu5vQ+tG5BN
	 PZJZFI3EK33CLCcpaxkJ9+Gfe/9LkapXfpt0XgWTLUP7hpXzt52NBLd3sAA74q1jgnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VaXxnSFb;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA66B606A8A2
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 11:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA66B606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VaXxnSFb
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-490d2ac331bso2576403f8f.0
        for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 03:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794395306; x=1795000106; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9e5fiKyui+gLN6NGnueZPdNy7gU/9XjTaWNkCYpwsg=;
        b=VaXxnSFb6u62I7fXcSBEHsKquOnwk5lHHv9xbvSUdxhsRngxe21RxN+kjpqF1BVuqL
         o1I5tVt3RMlbkKs1WYZLDLFkySuK24sjdgRJ3MDxESN7LcIARZj+Gxyfx6gJlP23QFRP
         Qif83mxxWTZC3bUjaAs299XxFGhN1RyJWMRcegNYXL04iOOb1ngL5m/RBOcENIVlJLA8
         0/b8KKgodVV7pLYLFggN4h1UfPVZdysVmEZZtbbK3jaVrkQx0bvTwiJKIvWyevKQyysG
         Nb3fefai1jo/X34KFF/lIa8xBk1E+jtyz5FsvhcpZeeBSmld7bzHgeEkpzvWUtKP2X2q
         CEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395306; x=1795000106;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t9e5fiKyui+gLN6NGnueZPdNy7gU/9XjTaWNkCYpwsg=;
        b=CUpyIv/F3QpdpEsjZQqQuMkB4+pK2i9HPndgxSlVSRJXUtjtSiqOKkd+rXL4UMLjWZ
         82NCPiHmo0E39inuATGItRnI4PNWPqpKMv6KJB+X/L7Maln3LwBjMwtLxuM35voyqlSO
         +EdgBIXfAO6Trr/y+2IFYm0kieFQtfgl5yxCKzXOhyOjQ72Dst2+E13aFPoZkDR2qZ1C
         YcrUfzwAggM6ahNjwqAldnQzhdM0cNMhDyG7jAf4KtZgjHyAl7W8wVsLPu8uRuV3zskO
         TZZTzBdFM1e4MQ3TRmwUSnIJyMQHTlA4rvcCbfd652zcpIqQ3ZTMRNpZb17i7iGgyAQJ
         kddg==
X-Forwarded-Encrypted: i=1; AL+hErGQtsina22L5+1WO1FPu3ba2FOx+vKXDiMjLNN5jQxXLw5O9QxbnwvPh/w4TwCKGgs2Pwvp8A==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jtc4+oxy+6igeuJIprEi7hWuWhzAa+kISDT7+seKr+TTXoYbx
	FdoLG0TPVLjAG+4Sd2mFIHCJHqmpLL8o8ayzhSkoKBnMG4nVQ0Hr9h4aEshPZbZINwFsPZ4vYaN
	dU8Wd+1zQAdIx0mik+I5JeQ==
X-Received: from wrsb1.prod.google.com ([2002:a5d:45c1:0:b0:48c:753a:6283])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e194:0:b0:491:6a7:b4ac with SMTP id ffacd0b85a97d-499c7b1aea4mr3063798f8f.56.1794395305902;
 Wed, 11 Nov 2026 03:08:25 -0800 (PST)
Date: Wed, 11 Nov 2026 11:07:33 +0000
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261111110738.872947-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111110738.872947-4-vdonnefort@google.com>
Subject: [PATCH v3 3/8] dma-contiguous: Expose rmem_cma_ops
From: Vincent Donnefort <vdonnefort@google.com>
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, 
	akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, 
	ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, 
	ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, 
	danielmentz@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Expose rmem_cma_ops via a kernel/dma-private header so the upcoming
lendable-dma-pool reserved-memory handler can wrap the CMA callbacks
instead of duplicating them.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/dma/contiguous.c |  4 +++-
 kernel/dma/contiguous.h | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 kernel/dma/contiguous.h

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 90937dc7c627..22d6e54aea35 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -46,6 +46,8 @@
 #include <linux/cma.h>
 #include <linux/nospec.h>
 
+#include "contiguous.h"
+
 #ifdef CONFIG_CMA_SIZE_MBYTES
 #define CMA_SIZE_MBYTES CONFIG_CMA_SIZE_MBYTES
 #else
@@ -578,7 +580,7 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 	return 0;
 }
 
-static const struct reserved_mem_ops rmem_cma_ops = {
+const struct reserved_mem_ops rmem_cma_ops = {
 	.node_validate  = rmem_cma_validate,
 	.node_fixup	= rmem_cma_fixup,
 	.node_init	= rmem_cma_setup,
diff --git a/kernel/dma/contiguous.h b/kernel/dma/contiguous.h
new file mode 100644
index 000000000000..9b1fdbfc794f
--- /dev/null
+++ b/kernel/dma/contiguous.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KERNEL_DMA_CONTIGUOUS_H
+#define _KERNEL_DMA_CONTIGUOUS_H
+
+#ifdef CONFIG_OF_RESERVED_MEM
+struct reserved_mem_ops;
+extern const struct reserved_mem_ops rmem_cma_ops;
+#endif
+
+#endif /* _KERNEL_DMA_CONTIGUOUS_H */
-- 
2.56.0.542.g3ef89b7020-goog

