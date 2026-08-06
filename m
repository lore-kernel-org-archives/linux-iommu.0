Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EEB4399CD
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 09:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008999; cv=none; b=iT5ADNBcd7Z9DvhwRlkZzQU5dezET+uVk4fH1VE+FPF9CSyUn0ZRm5lroFjDR0MukFXX6RpeddHgSurz+JwIDUlFFJ3driBhd08nSeBglo7LySHppU9k3NkWuppAsAwKa11nAuZbGCN2CEQ2NU69euPuZe9NSgnt9hUFT12Ab/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008999; c=relaxed/simple;
	bh=wy05bPp05mHS8vyW01X9jptReYWXDYKNhtr1n2hZSC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoQNX5TAooToP7jBvLUWQCLWWoArftHcrnZV57IWdYTGJ+UBSgRCUCdsz853zVq0QNdSYDyeW3iTqf3o+Wu0gB39yll930vooNUU6WI2uL9Y099BhnwJIy0LAzBtabkxprrK0b4wcpM4bNfvtRX1LRvF45g5kYiJknlqFue0lAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeeKCqHm; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeeKCqHm"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c888c001628so1207864a12.0
        for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 02:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008996; x=1786613796; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LuSw8PyHR5EplcrqG8+HZ+85Dl0Ckz8ecCi5UKpH+2g=;
        b=KeeKCqHmFjzxFgA1bvvg1ap9HL4bTZRMhywsrZPS0Lkoti3xXjP16Cs10mpUwfbE1J
         yYeYanZzzVQXbIqbuXxqozHqF4fi4aca7gH+NKrJmdkV8qL2aRMfrGlZnT2te0m6BSMD
         qboIYVVD4zdh2uhBLxj4AC9xClACKgVG+N0TQLWFmOxbgDn3LX3TVfjobuBpFlRKMmfw
         SHqfv8J10VovCVeWLQSeBATZBzfeFMmmyIZXDZYUEUDHQMrsVd3Fdl0tnrW9gRmO70XO
         JH0UlkEe29nClEFBWQ1GipmT0UzMrCu6unTEQTAbCSglOOwiiBGB1tRP1JvsXbUgP1Yo
         bFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008996; x=1786613796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LuSw8PyHR5EplcrqG8+HZ+85Dl0Ckz8ecCi5UKpH+2g=;
        b=dwSzen62mivvSKz50RSfjmf8EvGvoT1jgo9YerX/Exf5/O+MNaTLRcAH6Ur/ZvjP/c
         r+YDzPAJo7HGnTkWgjwAfrsE+KcY5ve9T3uEtdvUVLydAt/bWdoJi9tcnKg8f7kjrWoW
         wt1FB98p2QMpWBFImhVKXAb1QV6pVNX6uVARM7dCWn5yIpoEKZlzLMFIPnEioWZ/AzGc
         2LFRUCr2uw1/+Bsp0/IB1Aia0HkGqDLfVBVKj5Mxqg2hIMS3eDmJKzZT9EaFDOt43sSG
         k5H54xUZqjQfNWjJGIT2FllCJbyK54ugFAcRYSRE9IZiP5SLXcafk2gqArn6atb9IPX6
         sg3g==
X-Forwarded-Encrypted: i=1; AHgh+RpeZynpeI0vkcyh1daD54xK+3qPyJJmnxH029dRrCdxf0d+koU+b2u7+v/HqP0j/mQ795dcAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlP1fJrfGiA3S7rCkr5KSFg45xjII/mEhp2CK92TbNHC0BunET
	2ri5SUpe/eA8bwOfsnz/7UJHuDiZYfJv7kNL0gf5VEpwRTdthJABseDV
X-Gm-Gg: AR+sD11Azr3Qq0X0MCOWhsWmR0TTo73CLk7V6NNT9o1Ms9o39CXQFyJabVP3Q5/Bzhb
	VkSlQ1jHGLciJ2S5JxHRVgxyuQFs/xjnR4/Mm/DHuNmOl/TVVE26GWsHx9hY2NbOAcxyifhtZ+R
	sEbQkBiqXNLeBBcHuG5S2572CqOa3svw0PO3X1FwkFwhLSVRnKeTlazV1UAfyVByPzQevHn7b/I
	mngDCIlgpFdXglFIgBOXA0XUNX8ZGhjWay7BukoI3KPXs3A+Olc77RSxjKR9nkcsn4sXv66TXeB
	uUMRRt4QXa14MU2Dw/eDIfEPQTrbyXenSt6RD058w2XZ1b1nXtxlG68fNEzEloaiu2zbmifi8Vz
	0jT/p0s6OFQPHyRs4WvknDOuUCkeOyy57LDm1+Z3kdWVj7o0nkwzIK3+Due990yRKb86mbBuWpe
	UevKJY80ADH+Ac2B3tgWWHsVnGH6Ken/MYW6jBL3y3RKMOqG9Zt3bp2hON6gR/tjimB4Ka0/e8/
	w==
X-Received: by 2002:a05:6a00:298e:b0:845:dffa:3740 with SMTP id d2e1a72fcca58-84f2e0151aemr16066036b3a.4.1786008995542;
        Thu, 06 Aug 2026 02:36:35 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:36:34 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	saravanak@kernel.org,
	rppt@kernel.org,
	baoquan.he@linux.dev,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org,
	iommu@lists.linux.dev
Cc: kernel@xen0n.name,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com
Subject: [PATCH v5 5/8] riscv: build crash_mem ranges from memblock instead of resource tree
Date: Thu,  6 Aug 2026 17:35:16 +0800
Message-ID: <20260806093519.2907771-6-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806093519.2907771-1-chenwandun1@gmail.com>
References: <20260806093519.2907771-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

Replace walk_system_ram_res() with for_each_mem_range(). The
MEMBLOCK_NODUMP flag lives in memblock, so only by walking memblock
can the reserved-memory regions marked MEMBLOCK_NODUMP be excluded
from the vmcore.

for_each_mem_range() iterates memblock.memory, which is freed after
init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs
ARCH_KEEP_MEMBLOCK to filter reserved memory from the vmcore, so
extend its condition (ACPI || KEXEC) with (KEXEC_FILE &&
CRASH_DUMP). arm64 and loongarch already select ARCH_KEEP_MEMBLOCK
unconditionally.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 arch/riscv/Kconfig                     |  2 +-
 arch/riscv/kernel/machine_kexec_file.c | 31 ++++++++++----------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ef1101bec76c..bd8726b4dfbe 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -57,7 +57,7 @@ config RISCV
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
-	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC
+	select ARCH_KEEP_MEMBLOCK if ACPI || KEXEC || (KEXEC_FILE && CRASH_DUMP)
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

