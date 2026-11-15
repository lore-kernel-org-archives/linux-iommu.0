Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794731110;
	b=rskUr1ZQ9imkZ7U/BqT3rcdw0eHxh4lQgqXLdf/iJLmWHq5Ei6LYjRTT+0dM9u1eXL1y
	 dPsbDlt7q0FYIiQ4LaPzkGfatkhLheRIYJh/rv6xp3qONU1kEO85DW4Q9gTq4w6StWdSH
	 0LjBLTAZZ8R/+3bo3nwpoFZi8B9kp2DCsspwu/8Bvy2YlyaZnqnXpxEFtfVFHpbqZMG/x
	 SBypz89N4ztPGwjO4/vEZJw8kxBKwms77Wl6/1hh2jbaOPDEyZ0ziSnH2vHAiz9uO/RVi
	 dJ8stXdSToCXZJAxqFpKor5K9vQw8y5nIy/l0ubVA03rGiJixWAfy1KXCc27DDNvA7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wnoWZ39CWKlVGBavzBsrpwv3xdsKQNy7nRW5s5dEtYk=;
	b=I4v9VqwsAUuj+z/eczT4DJ53p+NzWk2+zjYHqabnXEihGEVd1dm8KNp2Xqi+pr4MmZcl
	 jOJolXFOHkHPQ4n+M1EC+/M6GMgs4tLfdpZ9fuMZjGGgAYv/bdtElscIiVbllKFRmj6OD
	 S+dclHxnCmpWRU81uduVv5QCWhIjrQ9+cRWrGPOxdZZSu4Km1Wo6BaRhOwTQTTeDFrO5R
	 l0frGPdSt+b920Qi+6cZS8k0c3msxNkEbz9pSqIIRpG+vI1c146OHSZY5qBeVC282BNyL
	 K36OJ1ITN5q3QSkRM7VgO9Xm84D2bYiCRQBwQj2Edy5+qBtV5dyHmnujGL9MoOfZLig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T1TsYx0F;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ADC606A332
	for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 08:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6ADC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T1TsYx0F
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so27575435e9.2
        for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 00:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794731108; x=1795335908; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wnoWZ39CWKlVGBavzBsrpwv3xdsKQNy7nRW5s5dEtYk=;
        b=T1TsYx0FHQ0s1luqR8vCgaQK8yniHdhtLRRN2ZEUV7eIQcxEq3qmkjhOgdVbcOKuzF
         umqiY0wKq8Tj0+VeCqgpeHRMDzRfr5am6b/EqYbOMRpWCF+HDmBYMHSLNmPiHuReUVVd
         eTb7zwQdh1NxqcvipcH3qxHQwPgb62XjNyX5ACQw9x2o/bhx633IG/SyA+dzsrZLeqsM
         DtEykrRgoM37rOK0qxJ1XOmHKp7klLsPB79YbbEm2JUYPnTNj5VjUPbMc3t2ra225Dun
         r8z2BZ8qU6d99d3UvmuygnXmsDE6V1AaxcFmy41NynI5qjAJGs5H9e5hqRnvFOMolImU
         UPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794731108; x=1795335908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wnoWZ39CWKlVGBavzBsrpwv3xdsKQNy7nRW5s5dEtYk=;
        b=ri8mdn++QD8OA442YY+NVLCLJOeQ6/BJtgOnDA3WtB9oK6dtiG+xYK3E9/gYU4Fp0r
         22p6oyQkRfnefV47zUQLyLx1Yj7bYS1eOUU3HiGPF4kF1T1pSZJfhER6bT4Jq7eKsVjp
         xHumGQFlyMPNPOJa4V7fQl008+xbmR74fTUQYqnQPHpfHFd/no52wDigOFe4Og9e9L8C
         yW/2dO/7uQOaO7YGRu3hZwHMgpSW64OzYeqFazdRsfjmV3h5imdfyr5HOcfxpu50MNbi
         H5n3AxTLE7DGwMU8WhjsAfIX7z9PJ9YorJsX/ljqqkRf5NYsJCccGjeqw+kz4I8pdhzg
         8SOg==
X-Forwarded-Encrypted: i=1; AL+hErEBcNFo/Yww0KHV8iMn/QsOyZY5EynH3jgdU+GN6XeNQMB+0YWfoiJiA3a1pwnnP7hp72HiJA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Egmsnvr0350+pNimXJKnHPJEvgeJRcJ39TCnzCu+UMBcakrJY
	y0ml33xtC95A61U+QQIGPYxbmbH/h6lcKf6hsc5aZTe2peHg9Pi5yk02
X-Gm-Gg: AYBFou3AyS3BSLVPn3LmoPv4XWDBbJfKbb0GmCG2mkBcpQljZNdsIjQyatSAbHh+6yt
	DQ+iGlmoboYl7xHtvGPnLxYOdSZVNbKeAGIv2CgSb/hlm7s6Vjhac4PZRjQM/ghOziD72i4JOuS
	C/jzdV6JS7GGbNPLGSJXcvsKAtO9zX6es9yN5NWXfYyRNfUFGJR6dVsVfrCDAOA0YiWwXCzAZFm
	FQyIjuGZ33IUPJEwSdK+DCAbK+OXckkt8HxTMIkWwNvhHbQCzVQVXbQd25sJix+lb2EoNC7wM+H
	qUxYed5CvCP8KVafliWEPC4C9uAUV/uI1ETo/x51s2i9TIkCzwWYrXDFfUg3nK5Z21ms3u7tNP1
	BCq77AfX2oXiVUaUho+DHPP9CnNu+i6e2VPby96OcdqW4YfxYwygQ6nsErXvYIZKY8HzGwuQXmJ
	7EttLG9WI2l19js4NZAcww2NcfEAAglkDSGctYh7HFkwxnEzmmvBgqLFvP9FqZU4YH/XV4ZOR4y
	xziQzAdmU7Bse0NrGfxErzwLvHnd6H/ozXwFeBkdy7sr8IguLtkuWIwbegeNsPHIEzfwZfLhm9v
	wZe1QJKFYJ14vmel/xs6v4YBEtEQr94ILWdc0Q==
X-Received: by 2002:a05:600c:3486:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4bb55a6a828mr164742915e9.10.1794731107999;
        Sun, 15 Nov 2026 00:25:07 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:474b:1700:dc0a:bc51:e26f:5cf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e28d0b2sm236796415e9.7.2026.11.15.00.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:25:07 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Anthony Iliopoulos <ailiop@suse.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma-debug: Avoid uninitialized hash traversal in mapping dumps
Date: Sun, 15 Nov 2026 10:25:06 +0200
Message-ID: <20261115082505.2012573-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Booting with dma_debug=off causes dma_debug_init() to return before
initializing the hash buckets. The debugfs dump file is registered
independently, so reading it traverses an uninitialized list and
triggers a NULL pointer dereference in dump_show(). The
debug_dma_dump_mappings() helper has the same unchecked traversal.

Skip both dump paths until dma_debug_initialized is set. Check the
initialization state rather than global_disable so that mappings
recorded before DMA debugging disables itself at runtime remain
available.

With CONFIG_DMA_API_DEBUG=y and CONFIG_DEBUG_FS=y, reading the dump
with dma_debug=off triggers an oops in the unpatched kernel. The
patched kernel returns an empty dump, while dumping with DMA debugging
enabled still returns mapping information.

Fixes: 173735c346c4 ("dma-debug: fix debugfs initialization order")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/dma/debug.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 36c1f7cbb2ae..2f487246d8ce 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -543,6 +543,9 @@ void debug_dma_dump_mappings(struct device *dev)
 	int idx;
 	phys_addr_t cln;
 
+	if (!dma_debug_initialized)
+		return;
+
 	for (idx = 0; idx < HASH_SIZE; idx++) {
 		struct hash_bucket *bucket = &dma_entry_hash[idx];
 		struct dma_debug_entry *entry;
@@ -576,6 +579,9 @@ static int dump_show(struct seq_file *seq, void *v)
 	int idx;
 	phys_addr_t cln;
 
+	if (!dma_debug_initialized)
+		return 0;
+
 	for (idx = 0; idx < HASH_SIZE; idx++) {
 		struct hash_bucket *bucket = &dma_entry_hash[idx];
 		struct dma_debug_entry *entry;

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

