Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571488;
	b=rCpubCa0BVe/Aa4yzrMbdQrir0P//+LivdMMBDyCFdhQCl/8Db9P1lC3CBIc7hipEvpc
	 xyXLG6b+P5R8J4fEvNtPsBhPY6WYJsjoKIaeBIKv4N4pOwLWZnaCfZEA004+Nnk4nDLpR
	 oQ7Sgmvzz/4nN+UXOM7udnMfSDyo3ckA0UCG946drk0fWySrFnm2UgcUN64F1htSnV9nF
	 eMt83h+q9x4M6UmrnxktZ1DUWggwFKjeXnBFQcV9zUuTfcJVfJS0SiHDC/g1uh/Qn1UR6
	 16vJfXu5j+OIn6pPclq1bTRtay0fZAyUdwTDXDsQYS35RwmR5V1ydqw1HcQQjkpLjqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
	b=y4mbiU3Ki4lxMBTe2mY81FttZHqOntR5TKH4I0rbJ9dCVlO7X21RH/VA3fG4Q/Wrk0jb
	 n68NWYMHSXz5mLCyGmxr4p9whrYfbWaaqb59d0IKKXG6hX/Fu6jKnx/eNv20x0sUCH4oQ
	 rvfCpGGi/tgru9ew+cMDJ/aU8au9hyq1sv2PLMWGXy9NO+JrUHG+Gnr0meFikkhyNnqwq
	 GYBs1xfvlNJYImbxTO08/9qPIYZFoQwiIK9O/XyOTwH4/V2Izceu8e+bwje3hgfTiAyZD
	 D1oaqzfEmUn3+PEgiIpIj5aKE1q+5a9OFOCpfLFCarUmzDhttX4h+5GXS8dniZB89hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="NcT05yD/";
	arc=none smtp.remote-ip=209.85.210.194
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128C606A31C
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 08:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B128C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NcT05yD/
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-89d6bd67045so227736b3a.0
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 01:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571487; x=1793176287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=NcT05yD/mGb6Ui3oGWlW+PZYbAUfFXMBR4BmzYxWEJU2iYSt1s0wG5Z727ldVeUkxz
         hP8rzXpHMiFDnx9xN0X5i7qJls2yM/8HYVQRBwaJSxZikrArXvSpJSZxdqJh2K+UamFu
         8DalDx0gaqwpvD1pNlY/axfTf5qTNftzzJNFWmuRWSaXeycTUHyVfWF2zIv+JkRujRJc
         C4tLRYa6Wpxld0e4BsumdSeYA8ZwCkDPqqE47yj2WPQfKmYhL+aRec0P/883P/bf5iDE
         pXZE15po/ROvcj1VONPtP7Tka1GoGeZPw6j/AoeyjYOKyNiihuwmn+iVZNsBHLY4mXE5
         j9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571487; x=1793176287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=CqyI/GpDbCKJkazor10eB33jwW5A59lv6gFQ2IekAqYJumVXtpAS8yw+blb4IfAYy0
         XtNJ1v6l+AXww7kFcQppSYzvRrjq91PuD4YqPX8Q/5NZ/y/R+axI/witAC3Ql7BBZwQ0
         QHOyOMRSFSbegn37RZ0kWn3FSx02C5SiGrpGlOfmOtjKQLhS7FfTxuGOQKnBSTjcr6eG
         6UMlB6Asxb2Vn5E4kv/bS29FBTy1Wparhuxx4P0HuNofyukF0w/+qp6Dg/DDZ94cV1Dg
         bGGj7Kj51AXdnjZI+XHVHsyMoibqgDoBBxHAr7MgCqJ5gbbgB8VvJALKEPIRWrDuD/Ci
         xk+w==
X-Forwarded-Encrypted: i=1; AKwUvBzF2d2BPZP/ZBxVHAUneSa9tSIGnmXYqNkF29Eh/2PaBi+diyomRE2vIXKQPaftJzfKkg97iQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIjqPZh+Nyhk6oAXycWv0yHwPVPIDVrQ+8KdnJ0EaptKTUciYLn
	B8Ra78kPz1gnLHLh2U14662N0fVeFFyxR/zcEQCytBfFocBaPp2ZoH3e
X-Gm-Gg: AYBFou1eD8uWXXT2+cC6w8uJ3y+jE7AMOtWFqCU1lKFs8XFY92qBBBSEgHCO1m9hko+
	6we2MzTW+N6jGkXU3qtZ7+lx4NDem1d2ZVe9u8QQ/ZfSm9333tMn9hXVgeuZNu92dpwYk6cZA17
	nG+4PyprhBD0h/w9t8381oau/Uxsi4p6nUA0ep0v3yKQUBWE7KQG4HwQ1wdAlF687XMYzGN7tTN
	ltTyc1nIFKyk5gDut3Rtp0Rvyz6qRK4ZdApvxT7HQvFp5O78Z++eLb7XX7o04+AUdewN/SRu7CF
	+xPX9P2HzQe5zR6+nxXDHr8L9JwFiI0c9G0bB2N3paXYhDqKfW3MUBr/0Vr8iav67QaTeY5ibyT
	jYX3RsykrSWjOcdetwIIUK5hvPMYVdcNN8EoxKzjhCW/GQ1LiWU7EUiLOb4s/cDsIzS2BNG46EC
	3FdS3xzY16VSD5S/eSf4G9BDGMw5PIcWJdC9UQ3Df0Mq5npoFYpuS1cWhZ58rnWJvHs8QMN/7Sn
	EjtboyISYEUtN7ry3jkv3sG3vpPq6Gkv2sBYUsZAdcNF79M0F6dou8HKh4jr1h51YYVPit1pu0d
	9mzaQfCWEZISAA==
X-Received: by 2002:a05:6a00:2e1e:b0:8a0:4d37:660d with SMTP id d2e1a72fcca58-8a07bf67824mr2764848b3a.2.1792571486193;
        Wed, 21 Oct 2026 01:31:26 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:31:25 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v9 4/8] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Wed, 21 Oct 2026 16:30:07 +0800
Message-ID: <20261021083011.2170525-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021083011.2170525-1-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
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

From: Wandun Chen <chenwandun@lixiang.com>

for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
weak defaults to for_each_mem_region(), which exposes struct
memblock_region and per-region flags, and filter NOMAP regions explicitly
via the new crash_should_skip_region() helper. This prepares for a
subsequent patch to extend the skip filter.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 kernel/crash_core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8a861a946e26..e161c8b65e00 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -283,25 +283,34 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 }
 
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+/* Exclude NOMAP regions from the vmcore. */
+static bool crash_should_skip_region(struct memblock_region *reg)
+{
+	return memblock_is_nomap(reg);
+}
+
 unsigned int __weak arch_get_system_nr_ranges(void)
 {
 	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
-	phys_addr_t start, end;
-	u64 i;
+	struct memblock_region *reg;
 
-	for_each_mem_range(i, &start, &end)
+	for_each_mem_region(reg) {
+		if (crash_should_skip_region(reg))
+			continue;
 		nr_ranges++;
+	}
 	return nr_ranges;
 }
 
 int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	phys_addr_t start, end;
-	u64 i;
+	struct memblock_region *reg;
 
-	for_each_mem_range(i, &start, &end) {
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
+	for_each_mem_region(reg) {
+		if (crash_should_skip_region(reg))
+			continue;
+		cmem->ranges[cmem->nr_ranges].start = reg->base;
+		cmem->ranges[cmem->nr_ranges].end = reg->base + reg->size - 1;
 		cmem->nr_ranges++;
 	}
 	return 0;
-- 
2.43.0

