Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17E3921ED
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131380; cv=none; b=GOnn/gAx7XUCGisIyoHFNBws/4w27VzzqOBmzyFDx/I+2DzgqKhxZwrRCNQTgwZqF3vpz6H4rooeY9uP4GWDJGv6IilIibTN0m8TT3HQcBjlb6gdMc6BYW2X/AFZlYzaOy7wmiZNB8LOs2tWySJXMIQYKQeArMSAD64Rfg5mlWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131380; c=relaxed/simple;
	bh=PT3LWhSw2vdV442dcbthELxWe2cTjR/Mhzld4jrWTDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVSBehnCMYGJ0uP3lAO/Wv8He7gzogtdb0L88l1gd6IqQFlCvh04bLEK1nmeYPC+4VEJundNJ5P/d1Pc1jPF4NKCjdbxIlGFUzxnH+eKPRuUUIGz1nOAJycTryUmiCgry5Qhi56+PgUWsJGLeinAuF3urCehbITemmyrz3AaOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/MxqcFO; arc=none smtp.client-ip=74.125.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/MxqcFO"
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cd3da0e82daso973526a12.1
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131378; x=1792736178; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pI8cU+3Va0VJY6BQ+e7sBVT9LPRu4J+OFo4gOdjLJ30=;
        b=e/MxqcFO/pVN1I19ucBJSTe7o1Z+smhFH5wX9Z4ZeyDZuBHfM9RGP0ZSucfcyRxu0q
         2oLOkQj7Uv8boF7gb8If/dzKyoT9MioYNT9HRn69EFDFnZE7hytl5Zypq9cXekZhOEJY
         i4TAfqTn65TDNJMPly2Y8rf471xZ+AAGXrTdrYWnBVZQr9y1XkhLUAMKtOC2uJN/TKPk
         YIXlPJbQVG6IQ6GJZ68KTgzGCrO276UaTiEhlXxf2ICLhNWHT5th1+LKwQ17zDbx1YfQ
         93cZe+w2G06c+Qzt2+nUe2nEpIW7VoAG9jEvuqMQ+b92At1IQb9KYsIhxQnnHn9VCimn
         4Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131378; x=1792736178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pI8cU+3Va0VJY6BQ+e7sBVT9LPRu4J+OFo4gOdjLJ30=;
        b=2gNlhBvBHkp11hF1enVc1fffhgOqm7f/rzZwdKL9eViax3swcHw7jOWofQMkAcqNOh
         MCfQcrxoBJ9mfhKiux0Wqjtz9y2zgBdB1fXP7Kjo3tfhY3f5CpXRxGsj9EH1/lENJzpf
         o0mVkX0+494NAqd5Mo5SBZlovQzZzp77UUtmw+CHaiyOs+Wpnl4oQgTztBahnSnspcdQ
         eJB7UtVaDIz+TVIkkG/NDLjmz4zHqXm7b+cmBgBYkOo33mxi58fZ3NP/3aAYlL80Mnf/
         6axJ70zoqUCsfkb1HA+QA5eTZSVjeDy4vh0UruoQRdbUF9uqyPx7eBgn3aVgZtzPfYOH
         mlpQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7zYDRrmvdLFGwTbScc1A5BkesjRL0M0dFZtBKWh8bS+7H/rAc65pLt68WjjsN0dLH5lqE+w==@lists.linux.dev
X-Gm-Message-State: AFq9FYLZ0FTOF1VG57k+RyFdAlzIL0d2Uqw+EtudK9Isw+u9RISrxHu4
	PVL7xcEYMdpJZYmUSHcvsDvcTV+bO7B3i9hD1XSRTtZApghoynpuRjva
X-Gm-Gg: AYBFou2GpCoTveSs3lIaK826+/PK/WUpRs2ygOL9JB/v8E18wWBtFFWF6yIQb9JUjci
	G0tTQ7GA8FgSCyy9YTBgLYWlmxVC32ZRbVSxtS2RK41KiNjEKzifnaT7XIXqK9jHEJ+p5+xUUko
	/e//J1+ZfeeWdSBvkqHsw6ZFp607M54vtNXrpdoQPUa7oekny6VTXj02qZW6Dl+J4fyuTvsfDbT
	bGT6nZAySQxleC0s8e058tNUk/sU+Yabl5xAsA4vdR7ZCKDsQbrECVRu86SigflCpV2Wmplo9GN
	qdKOoyy0Q9OIyttzjXqP7SzjIFCb81dRHKtDzD2VXe2xoZDaL+TJUGRHCTXRhtEXqvfrcVbqcjR
	GgYt/eUZ41uqLY1S5/CGeW6jPIf8t6dhBy90jasdHlzHYTL+KWEGrqbNlt0xrGarg/gKIIbS95T
	O3ZbqzUotfXM1ERmKMUsx9cHEDZF/exOnDTD9BmJ0E6dqdMSZhykFIqo2TbqqR06GbmCx48szMc
	xGvBa61nz8=
X-Received: by 2002:a05:6a00:2996:b0:878:3538:8f7d with SMTP id d2e1a72fcca58-897c79d707emr18459260b3a.43.1792131378226;
        Thu, 15 Oct 2026 23:16:18 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:16:17 -0700 (PDT)
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
Subject: [RESEND PATCH v8 1/8] riscv: build crash_mem ranges from memblock instead of resource tree
Date: Fri, 16 Oct 2026 14:15:42 +0800
Message-ID: <20261016061549.4181390-2-chenwandun1@gmail.com>
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

Replace walk_system_ram_res() with for_each_mem_range(). A later patch
introduces MEMBLOCK_NODUMP in memblock, the reserved-memory regions
marked with MEMBLOCK_NODUMP can be excluded from the vmcore by walking
memblock.

for_each_mem_range() iterates memblock.memory, which is freed after
init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs ARCH_KEEP_MEMBLOCK
to filter reserved memory from the vmcore, so extend its condition
(ACPI || KEXEC) with CRASH_DUMP. arm64 and loongarch already select
ARCH_KEEP_MEMBLOCK unconditionally.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 arch/riscv/Kconfig                     |  2 +-
 arch/riscv/kernel/machine_kexec_file.c | 31 ++++++++++----------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 62a4be0474e3..529310e3ae1e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -58,7 +58,7 @@ config RISCV
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
-	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC
+	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC || CRASH_DUMP
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 26cd2a8bd0cd..808e872f4063 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -37,39 +37,32 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_CRASH_DUMP
-static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
-{
-	unsigned int *nr_ranges = arg;
-
-	(*nr_ranges)++;
-	return 0;
-}
-
 unsigned int arch_get_system_nr_ranges(void)
 {
 	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
+	u64 i;
+	phys_addr_t start, end;
 
-	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+	for_each_mem_range(i, &start, &end)
+		nr_ranges++;
 
 	return nr_ranges;
 }
 
-static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
+int arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	struct crash_mem *cmem = arg;
+	u64 i;
+	phys_addr_t start, end;
 
-	cmem->ranges[cmem->nr_ranges].start = res->start;
-	cmem->ranges[cmem->nr_ranges].end = res->end;
-	cmem->nr_ranges++;
+	for_each_mem_range(i, &start, &end) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
 
 	return 0;
 }
 
-int arch_crash_populate_cmem(struct crash_mem *cmem)
-{
-	return walk_system_ram_res(0, -1, cmem, prepare_elf64_ram_headers_callback);
-}
-
 static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 				 unsigned long cmdline_len)
 {
-- 
2.43.0

