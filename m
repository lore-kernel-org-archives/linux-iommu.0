Received: from mail-pz2-f10.google.com (mail-pz2-f10.google.com [74.125.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88463C0A0F
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334321; cv=none; b=FCSD4WnFIHeh3LXAI1tgn61ECHHuWUf77qC8RngYCHRdEa0hthqFxmOOzP0htgr99bdJKt8hJPILS7oeDfku+U5QJYMaYoqL67IuYVlarYYWRiAFk0mUcEH82lWxoNHUDXTjYrP9V6I43pH762gFnp8sI6opoR4QLu8mYN3dNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334321; c=relaxed/simple;
	bh=WTLR5meVohzCgam1peUGWMX1J+RDsSRr7L+2QxILnVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJRinSBbGnH7SgRK4Ho3bj/jPakxqZ+uUDD62/SOmbWVyzweqVxVp94Rewh+PGEW6YXawqZEJDKdt3b2qcHdnf+zA+pqlAcsB9hDDR4j1KcNIY1MtoXk+XdPTQSUzCZDP5rITJg+k8Jrvhqlv1KM8y59tpWrYWSuFJZlNFVs5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTf7TkR5; arc=none smtp.client-ip=74.125.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTf7TkR5"
Received: by mail-pz2-f10.google.com with SMTP id 41be03b00d2f7-cc1c753b1bbso175895a12.1
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788334319; x=1788939119; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cEYvUbaRHsvrLqexK6TwRNN/GB2ra0YD4DknJvJHsJI=;
        b=qTf7TkR5CfQHj0YQ7rdU7HxehQxWJQU6kK05E2adBNcIWJvuJ/nbhvPlCU01UCUkjU
         WuvYDznK3+5Fw4YH3P6CPyRKmAtHAefNvYu9AhFk4cUvbiHBYysJJ1N8sI+SL7iAJT7/
         Gh+40HkAHVuBUEAO/v0el7E055x8+IO6YseFB39ZL/4CO7D1Hv/Rj+jJO7yORnBUekWT
         Q5G9HWlstGh8eizgZV6naoS5ozZo1HiZ+tt2iP6djRNFrK/pRNbPH6mDFjZXhoSzWd3r
         HYUO5T9QQOP788JKfnU54WfCmeo+ZG1+Y6XFbSRGtzHlter5BKzs/rynktTxZtEopDZ8
         8sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788334319; x=1788939119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cEYvUbaRHsvrLqexK6TwRNN/GB2ra0YD4DknJvJHsJI=;
        b=NxM2Gbew2sq1GLTm+7aYW1/PXTr2tX4O7hyHZoC3DKACokGYbAhV01s+JoHK3p8b5g
         FkYrcRw8jkLhZBHELUwX+jm+1JWi/Ta67sCGoLjUex5NlGCzwtSAMJjHPh9plgq7RrwW
         NCNSht/Vv8qNttC6fzrIILz7f+0NaiCnBcrMv8D2W4zI62gmSIKYg1k+6xDyfIni+dPM
         s+u3+R3Mkf8lF7GMtWrxbzUjtH4Tvc7YTawlvfqZ5VVgGof/z2/6G3Rvm8eXjDlBFPYD
         1pIGWQMT1YH4d4qSFiA/YwgRY8UCZK1aQGsd1jx+t2eG4MEoBw48AgJ6Q3eNphfK40JL
         QgJQ==
X-Forwarded-Encrypted: i=1; AKwUvByCN6AgjZzF9DPxlbwFepODWEneTf47VVJqG5EQUU7R+2V1k9l6fuLyit1zB74jz2QRj3LzkQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mznMDm9kwIAyQbB6OY+cRMGraAn4Djg7NX76siDGBQ6G95dcsn
	Ga2zeaw2CsC0hTzzANPbO/f8znV5HmpjMMBxDzODROA2sP7YCv+hlVeT
X-Gm-Gg: AYBFou1JzIR1bG/FCbe6b9psIyK32bcDFFeag7Vd0sOc1dhVZWONjG2bNL7oaIM8SrP
	kpCmciy0Fwpoqf9/ogREtx2h7kJY/IcadOO710fwXhdSzuHhFuS0CFbq3TMiL1roGqH60pM4C4o
	jMlHeyCaMPDRwIAyzR78OK558NNXA+ykKgpO4j27GEX0VrwAP4zwgQLZedMq5fjaDUteb+27CtX
	8coD+ZCd8PuPGg8Tw2PI8Hghfm01Gj45N+z4jEbZ5akd5ia1rqL2nkZJ8vMzpFUF25Wh67i/NBI
	59Qw2gJcd2NWXAbYl6dlAuYux/T/zhfbkboAmjVbBMfoSDJTLmy/HJvsYYdrZQyt2baJyjAdSgp
	72WOnvxWlLA53VlEeRBVjhu18CatwOOifeHVQeymqdD+wb/q9ygtPJsnDYGiSFQy5wIbRlJOeli
	os2KAwIxvUqfOqjq/2dC6aCPUUBWjRmXZkEwlZuDlTn6GkGPTxaKmmBP9ExUXYo947U+vxLgja
X-Received: by 2002:a05:6a00:4188:b0:857:7384:b5fc with SMTP id d2e1a72fcca58-85ed4d137e7mr5136737b3a.24.1788334319386;
        Wed, 02 Sep 2026 00:31:59 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db2adcbedsm926914b3a.20.2026.09.02.00.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 00:31:58 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	m.szyprowski@samsung.com
Cc: mark.rutland@arm.com,
	kernel@xen0n.name,
	alex@ghiti.fr,
	hpa@zytor.com,
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
Subject: [PATCH v6 02/10] riscv: build crash_mem ranges from memblock instead of resource tree
Date: Wed,  2 Sep 2026 15:31:08 +0800
Message-ID: <20260902073116.802752-3-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902073116.802752-1-chenwandun1@gmail.com>
References: <20260902073116.802752-1-chenwandun1@gmail.com>
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
---
 arch/riscv/Kconfig                     |  2 +-
 arch/riscv/kernel/machine_kexec_file.c | 31 ++++++++++----------------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d6c2dbf8455c..1de14a2d5aba 100644
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

