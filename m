Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A6B3B059E
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131417; cv=none; b=V/8vrsrIC7F9kNeJK+4U9GpIB9YU/nSeh+5IwDztCgBGyXFJYOBpyogVyBN0mHpF0482Csf5aLSalj3lPdVV2J/egShJRN866gPCMIGvwSJa0w8Wk+sUmb573nUWATTo+ZVoyQ+FLdeRe8C8FWozq/SvsWaOHnr1M3Xn3fErRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131417; c=relaxed/simple;
	bh=EtNWhbSSACfAtj7n0OC8kGNnI/X08sTb/SdHGhlyA3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf1lfcasRLK3ZfTFsqjWrX+oeDI+JcleNhy9ISn4Zlz5Bar/i/Jxol3POfRx38QvaLUDQ2cjlj4pO0MNeleK6qqrVhEX2lDnHXfgLuhFKLtR7CnLE/aoxtyKZ4YzF+qzGl0bIFI8/CMerddnV40CA3+UpCf7e2C5NYBJD4aCxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzijWz2Q; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzijWz2Q"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cc1631a57d2so1161802a12.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131416; x=1792736216; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=FzijWz2Qp7PlR2Wu4akCF+7Br5TL1NWqfHgVA8fMQQC27IA2O1IPBOB2Nxg21pO0yE
         607mnxO95XP20osx4NucKk8pFtZV2jEPXlvgkdGJOAS4KFaoMBe9GK/l4nxu4Ap8vQGQ
         9aTMq6FZH4Nn6dXjt0Rgyh4vZ6g/97kyQOVdFE3eY9xDXkopAMcoRlxUKOVPIuS/trLO
         qltcn0OGotPnl3ei8qh0PzWR9NZE4YCrhdKIxznJBLXCY9s+/Irf+LaiVj2bH61fJ2/F
         RRvJes2Gigtlbg7vOXZNyxHJ3FDYr63hzptU7Chu/j7PFMdt69YPDGGobgio6xs/ga/m
         omIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131416; x=1792736216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=AZUWmnpHF9NnyNNVT9VclzSLCmojqqLRegaapx7DQUXrCKEUsS/GAMOmbyYfjtKzTE
         OwdjnzizoNt9Uk2GlF8OFIHA8CYeHWVckG+ImknObuCe7EFNnVb9w7xDRAsp7fCu9XtH
         HwJtSj+701+XveCzuBIajlHO8Wr+0BzC03oY2zFT0gI9opsjfa/KXv5uOjCv9yUGWsm3
         NuLteuOkJtI+ZxJzX6ZHfxM7Upd+BKgRFw3U0yGQfPMT59nItOuuWk2VPXo7Dyc8MKMs
         wwWQUMPos2id9MnQgVolSn7NFAlGG8yXyFwQ2WtZyRuw2YvTmlhQ6pQwyIWrMtF7rOiD
         iVwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWOpn3FNzkeuXZz5F8MzisTIpFyQ6OavM2g2IK2jmXbkaxhdZ2hFwyYZnGf9+Ov0iEK6CGQQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYI6PmEskFoyToDu3j44jXeG3ibrXgm2UzxTt43SUgMLS+5RSti5
	eCQQjzH7PgdfltOqOqjealuMnhCRrmbZKLfBuJ8YZFoW835tyR0XeStx
X-Gm-Gg: AYBFou0DHFxAjjdnvh0+J5iaMb5pPkCrl4afjwOw6rqqvTUv0iDUufisXJRbDWnmFcY
	ziUIgot+XF42pw0kIbj0GpH0X9ZlK4ipJTAlF7L/CU+do7T//jk0Hy/L8L5e9pwp3WZisH1yDEG
	1DnnrX/8mK+6KUncsUtey45KVcaXLznidaFeCXrRsjAMudBpgnfk1Kk1XsbdnHYYG/S63/oE9fM
	q+SplJXB7HzFjYc6NzH1spsRegoo8fUO3Bp8YnnB8N+qO58PgJ7gV1K8PAmAyK8VlLzYPHLYM44
	wKMT3/BDhWct/o6yq4mOgXwqAK3Bb0ztMXfgAq9uMIOOqdhwfi+0JqTy3XfIBbC/9t0GbDKaUkX
	Koe3m+LRS8li9auyuyLCVfmYSvoxTdw9/BITPxV7cA1FyY0Ke10tS+Qx4Au+u1iUGGKiVQqIgxs
	DHKHlKcE1sXieBp3e5n4SNlcfyRYt+ThgD+09P1/IKB0tjm/lFE4ILeD27XDsWSa5O5+H396z2x
	LIhurU2Fqs=
X-Received: by 2002:a05:6a00:b8d:b0:89d:ec58:ce47 with SMTP id d2e1a72fcca58-89dec58cf9dmr5849396b3a.55.1792131415787;
        Thu, 15 Oct 2026 23:16:55 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:16:55 -0700 (PDT)
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
Subject: [RESEND PATCH v8 4/8] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Fri, 16 Oct 2026 14:15:45 +0800
Message-ID: <20261016061549.4181390-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016061549.4181390-1-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
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

