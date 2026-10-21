Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571444;
	b=lCt2cBL0D5SWz+d0k5DU4DDHnvmBV9ayISd4ph7AyBBq9TlEtTneyIPJ3Sh0XEEob+1G
	 AE/87bagelBNQXPYDAt/Saw7vmB0IvaORzj5V1s2LHDg5DtbSqerb6oEQtvJasOKPdjU/
	 zJABr4+lBm3866YgKP9uUkdgA5ielc1LuNxmLkixwryRqEySOdKL9hnvBZ8GBbDpLS0E7
	 +5nbIkwFCWL8WaccKj27fMVnKnIkeajKrkwyGGd3gtlFy7hwSZgmcVgm5GYXhp6zfEFpS
	 VOW/2TAmpQtdnaPcq9dhGRGT6mqPMnzlB1k5/qSmBs/+DGO9Cg/bn/xO4e1H4W5kqaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=e9/qG3hNPJNIGpwptQDGRFtRM3jaRgB/Z0bZ0bWRF/Y=;
	b=LzwFfo4sVb3O2vuKYgjpBzLZ76SgpxULZWE8lhfm6QQ9eO7IfBo1fmzYXwyWg8g3qchq
	 kzcRQyb0nURip+xZ6W/IvPPLjRiqMJVEWk51Q06r/m6givV7dD37t8EieY95MpVB7ZX6y
	 W2/FFHolHEHG8j6aTyzKz2dlBwBC68Xg0J1pwEpRnezdhwqw695KzEdKktBkxCi7CKI1d
	 GyDHf6cuLPHEhvy6JKOYcplP73ZikwKCz2tEnlUmrZmA88eSL1cFfuX88Ek0WU2x+7I5t
	 utq8bePZc3ZJ0rmD68BR4rQ14tg6ERkZkGY0FJ9NaITtEMNd3eu4sg1B+qf0hDiutFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iuBxRZ0b;
	arc=none smtp.remote-ip=74.125.228.1
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6AE606A31C
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 08:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A6AE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iuBxRZ0b
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cd63952c9f2so54348a12.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571443; x=1793176243; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e9/qG3hNPJNIGpwptQDGRFtRM3jaRgB/Z0bZ0bWRF/Y=;
        b=iuBxRZ0bjGgwItF62RhDP8GK5BHLhmxiJV165NKfPb1B03zdc8CJONBp0pEjoXd77s
         X9ONis8TYYfzc13eTfmcEWg0SNOpLWjnr0iFBmsgKNwnm/9+TrYP9RMKaqzr4mUXfYEw
         11qOOtWJuRoqG5ZXWcMyXx3hu1xuiQN86wxFXQIXveAJefkuQ7iAEJBmv4Rkxx7bP1Mx
         o7p90EPblKEgpnLw7ae4JzBBKLf57Y67qUg1vts7LqSSKayNr6fKFKQJ/Pb+PCKNNFoM
         qkP/ODeEIAuxFJuVvymUz20P3np+B6LhFx4kL1iR9/MCmPGCN6D+3LhIvVl1e+sqfQVE
         1OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571443; x=1793176243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e9/qG3hNPJNIGpwptQDGRFtRM3jaRgB/Z0bZ0bWRF/Y=;
        b=G5Mz5t0m0ZMwzbYNBpvDel8L9MnYBpjUz1BF+MUqxnvuDaJjyl19PvOhoc8W5cBiO/
         MlsZJ+A1NzPPI2Dt8gD00clDHeddxoV6N50sO1r0j8uDfp25e/1HUh3D5XB8uvUBl/3g
         xkRd65kw9ZSiCoKOfXCLiuZaYRVcT1rZ35pa700g7XhfKcnZ94d//OaULxHHiWtEG4vo
         /k16/PbAXIEvC7Nbp9pqh957UTQEEFfVSFjSk6//uQzvIgbvU38ZLWVw/ROPes1BVZHD
         /9hQTuj34IdqyQpHUFfe2CxBR3uGlhbgnlc/L0hXiMWzyLykbtp6sE7+LaZaBUCZx4XD
         7awA==
X-Forwarded-Encrypted: i=1; AKwUvBwfbmnbiqvUbNXswVSzaDz+KS1bNAC7hiyeaVj7x2SUciddkMVS0bdtZYpVJ/Bzvz7o7GC93Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYL5MjtBqQbIfAGBiTDN3x7Mcv06IeL6e33L1xiJL3Op9hJRH0Dz
	V9m99fjd6Ij1kIWPgAsq2Jf04lLBXsqp51Ze4urpHEyODWptxkGjU/eP
X-Gm-Gg: AYBFou193MeFzEhmmKikSUHPCTSKE90Z13UelX9Ss+JYA0E/puCXB7HjjwKBbT//PKh
	AJSXu0NDYC49r1b1UOxYKj2dL19eT1NMQ8dgbAmQ71p/V1zPqXEgExpmlVFLp9CFGlZBeH72/n7
	MGZuqbXiwvHpfik39J286ftg2lxbALT289Gj9pGQiv96M8GIsd3+GkHv6/yZGqtn+k1kJ+q7oLJ
	l3xdtLnGKoG74YTeD4xNkvSQ0smZaAwqHj36Mkv48OkXWsSxZymovbeLeJbnzos+y/Sgy07Pdmx
	znR2tZ3BqF+wEs4WmXus3qSOILZ0oXV5jnAF1BUnXb6kbgI531SqRySix2XIHj10ILFReb+4GLR
	Kt6yVNs640a+2v/pIWWT90G3RfCbIpWPCNLyLSMhMLzfHoz+xlb6wEZeHZXmnJ22Nn0OZbrJIvF
	3zGTkUQv5eP2UW9Sgq8i/bkwohkMG9NwLfc0rm6Ym0nv7aqG6jmxTwm8zwuWYNIJGu5kpCRbTXn
	ewspD1hNahJ7cfvU9w87oKlaKfODVbApiE9ueaKF53X7qgyARDDSEubS8Du+VZEJD7t
X-Received: by 2002:a05:6a00:a204:b0:874:708d:b620 with SMTP id d2e1a72fcca58-8a089d13a97mr1238939b3a.30.1792571443298;
        Wed, 21 Oct 2026 01:30:43 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:30:42 -0700 (PDT)
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
Subject: [PATCH v9 1/8] riscv: build crash_mem ranges from memblock instead of resource tree
Date: Wed, 21 Oct 2026 16:30:04 +0800
Message-ID: <20261021083011.2170525-2-chenwandun1@gmail.com>
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
index e7891a2a89da..e21d0bab77ee 100644
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

