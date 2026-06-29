Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2943ACA40
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782772696; cv=none; b=F5hiPMdB4konZ/y2VHSXXeQs9Y9Cn9ouXexqRvFzHPJUBe0Z0q0tSs/Ro+x5y+WmDESitgsOvHK7hnjeK4/UIU32k62jQJU8vWzln0ZTQLQ4cs2Prg2GbaBnmIH3nqTl5ROEwWRUhW3Jgpc5kOQ9X/bW5DPbRvAPMkxxWqnhEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782772696; c=relaxed/simple;
	bh=PebDSBjVnzJxPMYkMlZ7Ut6H199SaSMN65gFYPZM5mw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SX4mbpE/O3pMVtZ2WFp7RtGLl03hnEP40oWkShpq2ON3XJdwXl6wpVRbSgORN9yddVnR7yMxAAQdifJuhhkf2HVws9+EVRuo8fL9fSboVXH4th+IR0BziHLlzBFe3Esz8dUQ0po8KWKemOLkXZ/jbl1zqx1lmD9vRsGUBYHoPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sharaienko.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eY/kV9D2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sharaienko.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eY/kV9D2"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-845d3bef1e2so2263864b3a.0
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782772694; x=1783377494; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yKFJ2qfmBSJNvRDeviBTe+OrARoeY8Gr8ZW8qTJSJ58=;
        b=eY/kV9D27YRKW/YVR8Fml9bXe+g0bnQ4F7v5PnRU7IhoFlx+K85P0bs2XTa8CHl5eZ
         YK45hUvkM0QeOK5raRe+JtqFm92X2cLAvyope4CK8O+XsVIGNMa9fytVE8fQdS5KN++C
         KV5/2mJZE4CVEGN/ySmmwvps3hrIT8ur7eYEf3Yn8hHSMka1ZMGqwsA9CB73EJVw/1Bm
         Kaasli9uqQAXdzv32li7qE741GJCrjNSIcSxoW1UzTYI7LRn/5ViT9b9Jo5GuFRpLVNb
         5zpGu2+bgZ2wkaiSxz3fUQ+n6/BVUPZZdC5Xiw8EAoM4Tt8p7TCFLbU47lOxx9Vb1M5s
         L1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782772694; x=1783377494;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKFJ2qfmBSJNvRDeviBTe+OrARoeY8Gr8ZW8qTJSJ58=;
        b=LXJ11cGlRP6NLb0WnvD56Gi7sQUBw14bqkMU3RiPRetthexCCO9CJE0yWiJ38nqxXI
         HeakOM1u2PIAvS/p67Dr9a9Th+208cjlAge1hj0bp/1XTHjvQ/ytm/+OedbxSP71pH6h
         UiKL0Zp9vUVh+fuV8vW9TtMQ7ttJNY63xyV1Nx8k1FeBIxWnMWZB/fnhmj3bXwj6MhzE
         j+B8jHvB8h1RnXBf+8+rTii7Ewg0FjQDEBTN3i8FCgKpej1MJ4bmQm8AzSKTN2LLxBUS
         2ps9n1nGhlz8jlJQYREFnRSiGolx4hwSTvIAUGSvgGRvIeZvatJqLOdi15JtwN+oKeIp
         B4ZA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4bc2DQy9JjRSGP8H+aO5MglS6n0B3YGBzelYB4A29Eb3FaH5mlxLFu7rWSUAPE6l8UnTZaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXoD0s5p+HQQyeNK6bPmtiZfAC1iVRuoQozgrKu1oqc9d6OBh3
	QU3a+O6kaRRVAMQJAaw2LpzA2h9VSsoB9lR1fL8Bbo0l2AZDTb/ZYOVeWTHAjmVI0wDPMZqwM4v
	EOoODBXo3TtpZ62FSQcD1mg==
X-Received: from pfnx18.prod.google.com ([2002:aa7:84d2:0:b0:846:aff8:5614])
 (user=sharaienko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1ca6:b0:847:8250:2b2a with SMTP id d2e1a72fcca58-8479f40d50emr808631b3a.60.1782772693408;
 Mon, 29 Jun 2026 15:38:13 -0700 (PDT)
Date: Mon, 29 Jun 2026 22:37:58 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260629223759.2637162-1-sharaienko@google.com>
Subject: [PATCH v2] dma-coherent: use KiB in DMA allocation logs
From: Vova Sharaienko <sharaienko@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: android-mm@google.com, Vova Sharaienko <sharaienko@google.com>, kernel-team@android.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update DMA reserved memory pool allocation log messages to display
sizes in KiB instead of MiB. Using MiB caused allocations less than
1 MiB to be logged as 0 MiB due to integer truncation. KiB provides
better precision for smaller memory regions specified in the Device Tree.

Signed-off-by: Vova Sharaienko <sharaienko@google.com>
---
v1: https://lore.kernel.org/all/20260624000516.597555-1-sharaienko@google.com/
Addressed feedback from v1: changed %ld to %llu for size in KiB
to avoid truncation for sizes (which can be 64-bit on a 32-bit kernel)
larger than 4 GiB.

 kernel/dma/coherent.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index bcdc0f76d2e8..67f9a88ec4fe 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -69,8 +69,8 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	kfree(dma_mem);
 out_unmap_membase:
 	memunmap(mem_base);
-	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zd MiB\n",
-		&phys_addr, size / SZ_1M);
+	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zu KiB\n",
+		&phys_addr, size / SZ_1K);
 	return ERR_PTR(-ENOMEM);
 }

@@ -384,8 +384,8 @@ static int __init rmem_dma_setup(unsigned long node, struct reserved_mem *rmem)
 	}
 #endif

-	pr_info("Reserved memory: created DMA memory pool at %pa, size %ld MiB\n",
-		&rmem->base, (unsigned long)rmem->size / SZ_1M);
+	pr_info("Reserved memory: created DMA memory pool at %pa, size %llu KiB\n",
+		&rmem->base, (unsigned long long)(rmem->size / SZ_1K));
 	return 0;
 }

--
2.55.0.rc0.799.gd6f94ed593-goog

