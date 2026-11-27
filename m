Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770475;
	b=SFEAmH8GXmV11WTX4wVsy514u5GR/235nW7YHTBiNqVkMZpIyzvaUCOqTt3tCaJDR5kb
	 dOgR6Y+P5PmyH9zejLVXhMzfJ7FoCUaEPBU3F4EWuKFIYOM6qPWHLU/Q0tlYaUmnsff/J
	 dRJ+H+TJFRrPhTl1Gl9j8yneKuvohZfDAyR1zNFSutUD4Mwtv+txNC7KBLT2ar6CmFBpm
	 HRWhrHXJL7n3njRsEWm7+c610Jlqr8Rv0KW6qzplO94I7ZPmr3ne8QjzQDHwcyIkbzkWd
	 Ey5CwZ55VnW0/lIzIAXdnyFgwj3sO7NUM7Bb5ztFKOEqhl8uKt89Og39eeiqeczXH0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dn1PH2ygUv/59VEsbUK76gNJjYdjlSTbo9l6L4HVgfw=;
	b=YmyMtZ6mH1+hhkw/aTlZTqLkRBU8lxgUKvQUHzkqhF6OtYD2YoUGG3ad3C9hu2mLI58T
	 MYxVTAZ+PtAYEz9SB663yr+w5KALYB2u9mE3eEZcuQz4jc/ke0jqq40lxWvKkci//uCqs
	 hVGTrsahIh1LbixOHKCYPXslReezLoTilAz/0RyZNRzvzt0qwePEgU6CYf5+NKYr20h41
	 3Cinp8JNkcOi+Na3QWnG2bZYLph9STDbJcD0bYSq5SsrwDUqpGNSmetKyjcUimYtwTbF2
	 yCGgR9idTVqmk+MLgcwRwDBfpnLpr7dT9eiHVXp/yqBaiIs3gIzJfTnNTYNm8CWA+pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KeEXQgo9;
	arc=none smtp.remote-ip=74.125.227.202
Received: from mail-pi2-f10.google.com (mail-pi2-f10.google.com [74.125.227.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044A606A321
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 09:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2044A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KeEXQgo9
Received: by mail-pi2-f10.google.com with SMTP id 41be03b00d2f7-cdac0ac5f19so3860070a12.1
        for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 01:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770473; x=1796375273; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dn1PH2ygUv/59VEsbUK76gNJjYdjlSTbo9l6L4HVgfw=;
        b=KeEXQgo9sgykEeX3/Bj1MwAl9iXvsR07hSoLK0PPsFub+sFLza3/XRZskDPnDyRspl
         hXLOWqEu7xTSwhK4KawfzkNUzXx9omxO5pD+fw5V8MEz9vK/Aey05TVv8gslmiEiXZQO
         AKgeVB9+0rfs0J/xtDC/O/93Hm5YMN61JdW0cKeGI3kO7+ZugDugrstM/Tc2IsQC1Hqp
         9wSsdGC3VBKQmqkYqFS3xoZtEXar5k8hg244hLJmcApXeZhUBKOWIRVsi8atDybjd/BR
         GkqarH4pp7fsx78gWmgjERYRdMW//66FPKearCApiStSJ/h9X0EJdyBGNNCRmFd+5Njh
         Vkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770473; x=1796375273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dn1PH2ygUv/59VEsbUK76gNJjYdjlSTbo9l6L4HVgfw=;
        b=UmxkP2FBLcbaXquAC3AZd/aq/SqbpEo16IMdOGkCpoFppWIQDGAzkQE5DU7byPUfRA
         cozF/vGPtxDfwdUPPBof+Jz7rl/jYT3pR7w2xNYKGHOK0rKiBHXtPLkth97HR5WbFrXi
         wougt4coJzPYzpN4RwDT+DSfT6UOVxXhZkPx8PVKhrFvb4C/hT0q+ts+3V/w2pjQRFkh
         a6LLP/RNlKy/q45oz9hlEeSglvVsfrc6oUrqkICeTDtAZRI5J3CWSaDG1DFUqdMj9Kbs
         MLcKmAKzNqsmn3gLg5XEQ7QA3nmmD2erFG8OSxF2MxrJedu45dow/44sOp7ul1xeYmNY
         9Tpg==
X-Forwarded-Encrypted: i=1; AL+hErE0/w3olSCoxNtbkQlnln3GYfHVbwrH+OIP8rlVUXyzzE6ql/MkzqY3BD7/bO95Ri2RFT8F/w==@lists.linux.dev
X-Gm-Message-State: APuU4Z98/v9GjeNOosOArx9A7Dwe/5Tda7UZlBOV80enh9uaXnQBZ+2Z
	z7qvaoXwguTUrPS7YpzXvbJyhCZu2IGAxE5VRwW+O4DixEqI84avCe3T
X-Gm-Gg: AZFdTZfbXGycC+rBnbCtpIp3mrUCmxZoLT9XJQL4ZzEC6eNA15Xi25UgqnR8jJQe68x
	KKSBgjN/fGU4TG4sjGlZiiWPrTOP/U14jL1LgNnIva9QuQq2/I126Q4+JKJoe6FH0RHl6ltEUxq
	BNe009a/zQR+BPA4xvkUBwNvjp6/LqkwdcA84A444A7gfMuklDttuxTzVS6n9LV2lRB0Az6LmC8
	QX5nXHiH+DA69nke1kferHET78aJu3itUhQLal/CrUeVUqYHM8ZPcuuGVbqE1KsUtNn33wmjm+8
	ov+YjuypykVfzZY54Apz17vroUp6k+ukqCVW1mdq37AA7DuAQIimms7oD6FCKDQETXJ0FH1RTX/
	dCoV7XjzQyhengRxZ7mU5uHQjV7z3Y1xbfiq6sSoPhaGt7HgprVT4JUyeTp3Epz53ymLjATh6wM
	HSjtgFtu0a69VvZMhPuxSR/A4CHK8qEo8Xa2cH53HD1nUXXlowDCB9JnYo5p6eMceGrJ2Du+bOb
	0vR8w83ochLF9ChPIliIk1A5xVMtGkKkrLrzm50VhdCwUhrBNlSyvTrgYEyXmFlcAcS7bMirMY3
	W79QW/N8wsC4RhDkfpq+PajXgWdUYdcn84KADDwHqw==
X-Received: by 2002:a05:6a20:7c20:b0:3de:557e:5ea6 with SMTP id adf61e73a8af0-40283cbd05cmr14085693637.27.1795770473349;
        Fri, 27 Nov 2026 01:07:53 -0800 (PST)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d06ee37sm11718725a12.28.2026.11.27.01.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:07:52 -0800 (PST)
From: Wandun Chen <chenwandun1@gmail.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
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
	ruanjinjie@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v10 1/8] riscv: build crash_mem ranges from memblock instead of resource tree
Date: Fri, 27 Nov 2026 17:07:16 +0800
Message-ID: <20261127090723.741253-2-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127090723.741253-1-chenwandun1@gmail.com>
References: <20261127090723.741253-1-chenwandun1@gmail.com>
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
index bffef6b903e1..0a426475a9fb 100644
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
index 26cd2a8bd0cd..dad7f02365d3 100644
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
+	phys_addr_t start, end;
+	u64 i;
 
-	walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback);
+	for_each_mem_range(i, &start, &end)
+		nr_ranges++;
 
 	return nr_ranges;
 }
 
-static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
+int arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	struct crash_mem *cmem = arg;
+	phys_addr_t start, end;
+	u64 i;
 
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

