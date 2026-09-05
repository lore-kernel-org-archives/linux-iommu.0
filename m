Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C493F4125
	for <iommu@lists.linux.dev>; Sat,  5 Sep 2026 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788592765; cv=none; b=a/N5CsWJDnnATCy90NIveZpu2KKkq4gRABPUXat/mbuvrhVJ7EXzamhjbU5C6L5xAQFTEkmEQ3GLRWCEyJtc9d94bYRgJfkwYasfIO9RBbU9wiWMujo44NCw4ArAUz6uqenl4mZHpbijH362Rj+70u4Ak7WamgjvbuvchQFEO7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788592765; c=relaxed/simple;
	bh=6b8GbCqKZboTdKKyOVySbbcctduCni9WHEE4apbn298=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+PGx1pS/EVdrmljzX1bt4pbSaPGWofDsfld1A7D++b2b0OE2hX2o3a5XPWpCWn4KYC2bDdjOWVY87T5IEuOUDahw2QF5XGlq98vYVIeuiBnZPHrrjl7U9duTZzwQYb5LPvvcvAAeZm0aEs47UGv5Z5a/ZtxPNRsXV6qk0RAqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3NUIRRr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3NUIRRr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84e27035206so1610492b3a.3
        for <iommu@lists.linux.dev>; Sat, 05 Sep 2026 00:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788592763; x=1789197563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kniu51pKGU1eVNIl2Gb8/92qXSKg7BhfDHviVd7hho4=;
        b=L3NUIRRrMXFoaauzCw4DXktex0iiCJC/B3l02gib/hkjysrevmizR/UdpeNJ6hhH2J
         0CQChi5EkfnriccVDeKgMoRbvnN/3AzWaEzYUz0MD7gvb7yfuFnUm+n8S+RBVf/F3GiR
         9nXiffsRAG0ScUdzlmHNi5pVSu5KVGRTSAZwSxB/y76ObHyo0DG7kN7RTg/1rsd56NRM
         1iJ5poPx6w96q7z2eSj3nJWxqbtU0JVc70HhjKHJEaQ8j9X7nTkxofIAr5uE0TqRPtzU
         aC0m0V3Rog3WnfY33A8Lu3uKwKcMPLN/Q9nXpncgNjKFXTAQE6s/YZp7sS2EbgR2qKv4
         VJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788592763; x=1789197563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kniu51pKGU1eVNIl2Gb8/92qXSKg7BhfDHviVd7hho4=;
        b=NPhisLff8oa1/RO/zB4RDkmRVF/n9qkoY/A2XlMXFbKBCslrd3mXWJ0V0R+C/3os7p
         YUWuNwjBPkUafrgkEeX8bV/d1ZZn+EzJxM0noKRV3+j7RWsLbcgf6K914oS/LxzktxHc
         FSfgDsoIDGZGOMjbNlluWSsMDh522zo+PyWxtM8feoykFEIcRQ7C4i7Xfn9kh0n6PdXs
         85lV3yAHTnqBN+Gd79yiWBKoMc3Id1+Fel0+zR/r2MMP3yBi4HbtnjxwvrWD+cRhbW43
         YgDIv1ZAe1vejQRtGdzzOEv8pc5QUOCEobN7oBBDNGBmzzIiiWAQVf0sZmcQ8UOjk+Jb
         9K5A==
X-Forwarded-Encrypted: i=1; AKwUvByyOndzs+iVz9JJEOQ694pVRwBnW0DhCHq9cJkhrhT3Xcbpb2+OCp0aDnxeEg9Iyjd3frEYmA==@lists.linux.dev
X-Gm-Message-State: AFuF++mOvD17NnKQXkRhyqyuitoifiNehkRu1U1e1NZxgaOrdPTYGKQS
	tkz0gLK2VYoHGTXzA5Dp4abH7KWjJMmZCJzBSW+oCI418JoO8EE9Djj7EwK50mDU5A==
X-Gm-Gg: AYBFou08OzIFT+lJ427iPlQiKofXHH4fYeTt+MEbL8l2fk66qlHSOGrmEWurnd9ug9A
	L0KQtjti8a/FDj62leXf18DGT8rnbAMR1Jo8iZVhj66EO3wk6I7ZovnaixzpOzb1hsDRZy04wwL
	QVJSRAW8tpHWoHOVO7XytnL4lGrCim0ZHW5WesZoWyBGbI10lLV1sb2d67+jVAejChN+b6snYhc
	eVUysYxrVP7vp4nge6+Cjd89cvbPcKbhAjT43+Jn+aMnLYS7RXPPgQtp4I98xqeqK1rzI8IcWkR
	qnoBCHzgUpowhFCJo/aSRgyXTYt+gvN0/a9uzDavJGjNxO/5O1FMKu0YQ6iWxIysckbbHs7nxan
	rAWdinJAsX0VMGRQRjxYqyp3oCu2IDpS1gQKhDb61QvaTkI7kLU5KoK9swSn4pi6TNX8WsMWSMd
	RgKxv0ZKiCwFo79DNKf5jchhvSqVWbvoVgTxQa1li2lTueyMRnnLS4k0D9LAIorJPh27SjXP5gx
	jIjeuIeFRvzYrc=
X-Received: by 2002:a05:6a00:3008:b0:857:3b70:209 with SMTP id d2e1a72fcca58-86167aa9918mr14558768b3a.1.1788592763408;
        Sat, 05 Sep 2026 00:19:23 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-861520404f7sm2033047b3a.16.2026.09.05.00.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:19:22 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH] dma-mapping: don't trace the DMA address when the allocation fails
Date: Sat,  5 Sep 2026 16:19:19 +0900
Message-ID: <20260905071919.30784-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_alloc_attrs() passes *dma_handle to trace_dma_alloc() and
debug_dma_alloc_coherent() without checking whether the allocation
succeeded. No backend writes it on failure: dma_direct_alloc(),
iommu_dma_alloc() and the dma_map_ops instances assign it only on the
path that returns a buffer. Callers usually pass an uninitialized
automatic variable, so with the tracepoint enabled a failed allocation
records whatever the stack held, next to the virt_addr=(null) that marks
the record as an error.

The device coherent pool path is the same: a non-zero return from
dma_alloc_from_dev_coherent() means the request was handled, not that it
succeeded, so cpu_addr is NULL and dma_handle untouched once the pool
runs out.

Split both sites on cpu_addr, as dma_alloc_pages() and
dma_alloc_noncontiguous() do further down the file, and pass 0 for the
failure case like the two error paths already in this function.

Fixes: 038eb433dc14 ("dma-mapping: add tracing for dma-mapping API calls")
Fixes: 68b6dbf1f441 ("dma-mapping: trace more error paths")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Compile-tested only, with CONFIG_DMA_API_DEBUG=y and CONFIG_TRACEPOINTS=y
so that both changed calls are built. The claim that no backend writes
*dma_handle on failure was checked against dma_direct_alloc() and its
helpers, iommu_dma_alloc(), iommu_dma_alloc_remap() and every in-tree
dma_map_ops .alloc implementation.

 kernel/dma/mapping.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index bf2651a70b7c..098cd57e1157 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -656,8 +656,12 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
-		trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
-				DMA_BIDIRECTIONAL, flag, attrs);
+		if (cpu_addr)
+			trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
+					DMA_BIDIRECTIONAL, flag, attrs);
+		else
+			trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL,
+					flag, attrs);
 		return cpu_addr;
 	}
 
@@ -676,9 +680,15 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		return NULL;
 	}
 
-	trace_dma_alloc(dev, cpu_addr, *dma_handle, size, DMA_BIDIRECTIONAL,
-			flag, attrs);
-	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
+	if (cpu_addr) {
+		trace_dma_alloc(dev, cpu_addr, *dma_handle, size,
+				DMA_BIDIRECTIONAL, flag, attrs);
+		debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr,
+					 attrs);
+	} else {
+		trace_dma_alloc(dev, NULL, 0, size, DMA_BIDIRECTIONAL, flag,
+				attrs);
+	}
 	return cpu_addr;
 }
 EXPORT_SYMBOL(dma_alloc_attrs);
-- 
2.53.0

