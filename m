Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67C3B47FF
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936367; cv=none; b=sHN8IMUjyWOLNhDJmdSL4BB1vhrGs6hURMR1CH0mylFZHecVLwHn9SNOMZLq9sIEttVwcIHw5h2aMpOOrNxnFVK3/86RyKq0+sgNvmXRgnwKll9/rXxGoflgmj1zKiepxm7FgmUIKi/cTT0cRgWOsMSIRNuBFkxIPlU/vtQwnYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936367; c=relaxed/simple;
	bh=aw4Rhoh3RwfLskd+wz0l+G13x6bu+xwyiBwtb7+fPgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmn6b8DrJNA28IdPHDFO04sz+tAJy14lVEJ4rsYn6cltek0KG2NSMjOqxyNkSKDoVzqt56Ur+P31XBg3CqOj7j/u6kzMZfAvch/h1+TH6rfEm4kckV4Bi8Mf9p2irAvgYYJKTYoOEh4TnFA6mmC8TAwGbkKfS5Glo5tlTTzyX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZAjK4ni; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZAjK4ni"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so42776445e9.2
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 23:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788936363; x=1789541163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYl1RTu0H7T966MjgfIs9rrG8GCdvOEJmaLrbPw3sSg=;
        b=RZAjK4niIJJgCiLdEIaq26rK0FgZkIaNzuE2a6q1gGZHxiNayKXxxFjtKkAaFU1uoC
         tBO/GT0eZaAqu8NGk5fAJws6AgOl4F/gQ+3uW7eM8teurxfaMOIrqlI7GL1m5QFSAUMx
         6ytJH57+FDCKthedLmNJc+YlNiOL7ijNjSSwO7rJ38SP8vv714H2m35ToE4L5DWRzgkv
         y4EACCqRzoxWJVWmF9Oj3hhx/WIRey8iy22QMQxdOyI4TkMXrpDQ89isLf4QcODviLwK
         q7G3+iM5J3181YzhjNMTXZ3vN7VekjbX3vwxOTqLlWASJW5dXI155gZeMp+azx5IWiec
         ezgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788936363; x=1789541163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYl1RTu0H7T966MjgfIs9rrG8GCdvOEJmaLrbPw3sSg=;
        b=j2GXjl2hkKY0zIkkvgSwM/LVs93n1f5MsL5NL23TnDE4+KK60XhZKIP3/98koYdp0Q
         /DqZz1wlYJiYIFHZdq/L46K8Is4RIIQ5Y2BlFC9WBwKrd0VPYQZ0xSpcIO+wuJ4K+RbL
         ueqjlEldvueiPDnZJRsmP2GHUlusc3Xurv/XeBXtwdtrN++M1h58Gx/OQK41DI5VGdDW
         P1O2WlfGlXjuclIK5f1hlYHWOy9rKd6S9nFxF5LjYAkDl/xOg+Enkb3S8ZEFxJZ50vav
         ZwP/VyoloCRUR3MpPEwiFDYavO6xxAsFD639NpGdv1tHYsrFBjegJFoLtHe87M+svMJ1
         BI9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxU0AYBmsNNCbZfCQeiG/YnaXsqBnVAMfAqJQNXjbOhzJ2GfsMlCNDGvt/B5P0EqpzyO9tDUg==@lists.linux.dev
X-Gm-Message-State: AFuF++nGkRhYXsP7f+RYr7eFv0gO//PjE6CaZrp2kajnG5pHI5afRMwG
	mVw3XWHq/tt1Nrcimc4Bw2pbVw3cMQuZZhyS70kn1Jv8Pp8bOBBG2UUa
X-Gm-Gg: AYBFou1lu1auMfV3oHSProLE/KPr2DaFhOTf2Qdyv6cKb6/xIkGdWigRvaObBvSqjpv
	H6btfPdDKLp4HwcqugTuV3viizO8NVG9CQyUVUBfCHDQsP3EH7F6Tg2UBnRbEgpT1DIIXhAZEvA
	nPvpUQBwTx8E7stK8d4Kd6uuTZvDQOHknKykQb/s22iah7NFPBIh4khs+M08zLmx1kVhwO7uq2D
	n9VUGWnFrdLy0RLzxj1FMyY3Vk0GcHASKHTec01uTixq3oRarqiTOqLsB9J0MC9avRyN/+vHJmL
	j7Nl7EoJAQ+Q2NFk1kZGzHYgNSBIoQm0BlQSrjgJs6wWnpPfiY9sV4LTB5MLmlBPAXRlAOGJSTS
	2ogD7vp8kAUdnDZM1ymTw3jiSuU5L4n35MKBx6JAgoberQvLPS8aNk1YI7iYXlLTodfrArFdbkT
	wIPg9qhfaq3QQ1ZO5BMPDkSR7ls4gVa8rBkjYhurlxTNhKszh2EMfhEkR3foXhe87IeZgff0OBL
	JDhH35UWc1tf9OS7nnWyQBKwNqEincBqsef8s7riugHKa6ece4poS7QTP/J61Kp+aEDU6V+9Pk9
	Q1Y1dIlfDHqoklJw0PwUa5flZm8Mj5JEa3twZzYBW9XYrCZ2no7i
X-Received: by 2002:a05:600c:1914:b0:499:60bf:c6f7 with SMTP id 5b1f17b1804b1-49cf8269fdfmr325273315e9.13.1788936362969;
        Tue, 08 Sep 2026 23:46:02 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-095-114-212-219.95.114.pool.telefonica.de. [95.114.212.219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fc1be3sm17238355e9.4.2026.09.08.23.46.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Sep 2026 23:46:02 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dma-mapping: split cache maintenance at highmem boundary
Date: Wed,  9 Sep 2026 08:44:43 +0200
Message-Id: <20260909064443.90544-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dma_cache_maint_page() processes highmem pages one at a time, but passes
the complete remaining range to a cache operation when the current page
is lowmem. If a physically contiguous range starts in lowmem and crosses
into highmem, the operation continues beyond high_memory through virtual
addresses which do not map the highmem pages.

On a Raspberry Pi 400 running an ARM32 LPAE kernel, an 8 KiB scatterlist
entry crossing this boundary caused a deterministic data abort at f0000000
in v7_dma_clean_range().

Limit the crossing lowmem iteration to the end of its page. Subsequent
iterations advance page by page until the existing highmem path takes
over. Keep the bulk operation for ranges contained in lowmem.

Fixes: 43377453af83 ("[ARM] introduce dma_cache_maint_page()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Testing:

- Raspberry Pi 400, ARM32 LPAE, 8 KiB scatterlist entry crossing the
  0x30000000 lowmem/highmem boundary: all four unpatched boots panicked at
  f0000000 in v7_dma_clean_range(). All four patched boots completed. Three
  100-iteration patched runs checked 409,600 bytes in each DMA direction
  with zero mismatches.
- W=1 builds of arch/arm/mm/dma-mapping.o passed with CONFIG_HIGHMEM=y and
  CONFIG_HIGHMEM=n. They emitted only five pre-existing kernel-doc warnings.

The hardware kernels used base 986c24e0fe44. dma-mapping.c is unchanged
between that commit and this patch's base, 893e11787f78.

 arch/arm/mm/dma-mapping.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 7761099dde9e..887209a09226 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -663,6 +663,9 @@ static void dma_cache_maint_page(phys_addr_t phys, size_t size,
 		} else {
 			phys += offset;
 			vaddr = phys_to_virt(phys);
+			if (IS_ENABLED(CONFIG_HIGHMEM) &&
+			    len > (unsigned long)high_memory - (unsigned long)vaddr)
+				len = PAGE_SIZE - offset;
 			op(vaddr, len, dir);
 		}
 		offset = 0;
-- 
2.53.0
