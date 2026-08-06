Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A573F39FF
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786009012; cv=none; b=lElS853JigS9Q8Xh451A0l7vBqJaBb2wVtXcJq974VAa//3w2EX7HUrDoKF0OJfXAWNfjBoSNhGCk3dB0aLGYIkHgJW7qPT6Fi2ClMKOY53ifqnv2yzcZSxNvVHhH70jsNhIvt8Iwit2ETnvnhShLn/xcswQYgvlRtbwY4aFqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786009012; c=relaxed/simple;
	bh=3+eeaa1ZvEiSWwM8HzdyswyClU6vwmIcEhsy7E60oGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrH91P8zgRwgS3TkObydcNBB1ZRC/cV8BUHpWDxH1nI6vqr2HPcZ8LIaGWJsyx6HDQm2NgVnB6C73B9w5c1IRi7DLJ8KBYEJd8pBggCCm4ArIABr+PgW8egfDIS9I9qzUCIYubQgVLXjcjBaJ+mg9UbGrfKum/xC6OMVy+TD7Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjTUMpMi; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjTUMpMi"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-cab1b0bb489so1690812a12.0
        for <iommu@lists.linux.dev>; Thu, 06 Aug 2026 02:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786009007; x=1786613807; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wVDvUsuVz4fOLoguLRCQrGgJgNWPqJ2TDc/OI8CtAH0=;
        b=OjTUMpMigGWe23FBSmr0ua5c2M32ZnJEuBn2lmRgnp/V6MhO+1dCa7fhBbfa3yJdPA
         KD6LOSf6JbWjkxsYdMyV3GU344zMy/jgKYGSh94YbIiJCfssJZ9iz9HW/QacNp+ul+aQ
         SJymJSB5DP/fyRRIKfHs/4Hb6qXrndxSVUU1uS/rSynfXeRh4K2mcXsVkmAYRvG3iB5M
         RosV6ogMsKnVTK1eY9Vb7Vt3eFExeVASdXzWhbSFYOjo7MVVsub+BBoHV57dfEw5BCIb
         fvYSOjoNxNCFG/tLPTHuPjnDkWs3vWVYe2hcDCY1KMQ1GmTxouTXVsyRTb86Ctf6JCok
         lNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786009007; x=1786613807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wVDvUsuVz4fOLoguLRCQrGgJgNWPqJ2TDc/OI8CtAH0=;
        b=iVK854UgY1T0kmE2y4HCUz2pcoaeHcaO9uSgRYQ0FbstxLtJ17QzHzIRmI7MQLwbx2
         DXhPx6T6mrMIKeI9GKgpYEvxJy7/SlKAxtnRrD3XguNnvBD6jpNPHLX3MMob08f0moRC
         toWu0vUnTrd/MXjQesc/S9b+9ZfVpxm2eo6/Rb7ycO94nFc9MRdnek8GTz6vPft/a9tm
         ZTMG21ncODaaY+5oGlbKp0hBdH/LlHOghiIfCeoM+3AuPmrEbL6a0nVO2zJX53qDxX7G
         wqzn9fAUb0uMMa/I/HcODg7lBa4AB+/KXShe4KMyph0Nm/R6xKcaOVkIkM5Jmwmef57u
         /tBg==
X-Forwarded-Encrypted: i=1; AHgh+RqsFQdhlIlssHEXXwjVCLHLpNah+wfDTcjPhbzvjzV1q4q+Lg4FbWo0ilegSSmzqWuzY0s5Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXMVg480d51DDRBVlj3r7n7jkkNoN6iFD8gEefG/gTv85udYbv
	o5RpTQaNEN4R2SwR7cQiHyEkDtN1M4BXXIBL0MnRcO7hqrr1T8QlRCk5
X-Gm-Gg: AR+sD12Lm9essPPo+NhwH5XjujAqEv4t3wW6bgwfA6JgMq9JeYAthGsc9y82I4ljcP9
	EBl8ipj394HyBEgduywwlRlPPZ14+vn/bNbKZFebSmC9zE65HEs+sdd0I/4uMtr3ENik6c7wZPx
	IwycGmzEvfh4Rjb8ZFYzkHWcvxZ/1lpsJISmWF3WMOZ+KGtwv771zhkF4N6OuRHaBve8IXketoA
	XN6KjcFNlmfc7hj3sVe5PLp3HIBt1RedkW6rNkUh2jFhOuy5IT675N+NCoJPE6Yo32dQWyp9+os
	oAHaUu9p7j8qoSOFvynfLWnnmAWn4AhS1vCSGXeZaeaEpXmk59nzLWCv/ycZxmjEHcCyZKfwo7g
	QbDVKUuCeW3skp2AdBImuDMhliurvyjXVtBzz5jMhclOPv6oxVWDKLBebK8PbaulooywCAy2chi
	XNWduxdoeZUCNwZI5ofmVsZO0qSKs8EGuS/9FrDoM6awd4z2xZeXz50IwF1b1FQhTmcXTCTclk6
	IH0E/LTPl4b
X-Received: by 2002:a05:6a00:3687:b0:848:467d:293b with SMTP id d2e1a72fcca58-84f2dfb4e5bmr16809060b3a.11.1786009006714;
        Thu, 06 Aug 2026 02:36:46 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b0aeasm1043878b3a.13.2026.08.06.02.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 02:36:46 -0700 (PDT)
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
Subject: [PATCH v5 6/8] crash_core: fold duplicated memblock arch hooks into the weak default
Date: Thu,  6 Aug 2026 17:35:17 +0800
Message-ID: <20260806093519.2907771-7-chenwandun1@gmail.com>
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

The weak defaults are only consumed by crash_prepare_headers(), which is
called only by arm64, riscv, loongarch (via the weak default) and x86
(via its own non-weak override).

arm64, loongarch and riscv open-code the same memblock walk in
arch_get_system_nr_ranges() and arch_crash_populate_cmem(). Move it into
the __weak defaults in kernel/crash_core.c and delete the arch copies.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 arch/arm64/kernel/machine_kexec_file.c     | 29 ----------------------
 arch/loongarch/kernel/machine_kexec_file.c | 27 --------------------
 arch/riscv/kernel/machine_kexec_file.c     | 26 -------------------
 kernel/crash_core.c                        | 25 +++++++++++++++++--
 4 files changed, 23 insertions(+), 84 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 854d872dfd0f..34d944d3f22f 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -14,7 +14,6 @@
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/libfdt.h>
-#include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
@@ -39,34 +38,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_CRASH_DUMP
-unsigned int arch_get_system_nr_ranges(void)
-{
-	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range(i, &start, &end)
-		nr_ranges++;
-
-	return nr_ranges;
-}
-
-int arch_crash_populate_cmem(struct crash_mem *cmem)
-{
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range(i, &start, &end) {
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
-		cmem->nr_ranges++;
-	}
-
-	return 0;
-}
-#endif
-
 /*
  * Tries to add the initrd and DTB to the image. If it is not possible to find
  * valid locations, this function will undo changes to the image and return non
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 5412aa9f3568..481b8f906a56 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -13,7 +13,6 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
-#include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -56,32 +55,6 @@ static void cmdline_add_initrd(struct kimage *image, unsigned long *cmdline_tmpl
 }
 
 #ifdef CONFIG_CRASH_DUMP
-unsigned int arch_get_system_nr_ranges(void)
-{
-	int nr_ranges = 2; /* for exclusion of crashkernel region */
-	phys_addr_t start, end;
-	uint64_t i;
-
-	for_each_mem_range(i, &start, &end)
-		nr_ranges++;
-
-	return nr_ranges;
-}
-
-int arch_crash_populate_cmem(struct crash_mem *cmem)
-{
-	phys_addr_t start, end;
-	uint64_t i;
-
-	for_each_mem_range(i, &start, &end) {
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
-		cmem->nr_ranges++;
-	}
-
-	return 0;
-}
-
 /*
  * Add the "mem=size@start" command line parameter to command line, indicating the
  * memory region the new kernel can use to boot into.
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 808e872f4063..fdc6695e8588 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -37,32 +37,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 }
 
 #ifdef CONFIG_CRASH_DUMP
-unsigned int arch_get_system_nr_ranges(void)
-{
-	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* For exclusion of crashkernel region */
-	u64 i;
-	phys_addr_t start, end;
-
-	for_each_mem_range(i, &start, &end)
-		nr_ranges++;
-
-	return nr_ranges;
-}
-
-int arch_crash_populate_cmem(struct crash_mem *cmem)
-{
-	u64 i;
-	phys_addr_t start, end;
-
-	for_each_mem_range(i, &start, &end) {
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
-		cmem->nr_ranges++;
-	}
-
-	return 0;
-}
-
 static char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
 				 unsigned long cmdline_len)
 {
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 2b36aa9fade0..77285ae3ce60 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -281,8 +281,29 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 	return cmem;
 }
 
-unsigned int __weak arch_get_system_nr_ranges(void) { return 0; }
-int __weak arch_crash_populate_cmem(struct crash_mem *cmem) { return -1; }
+unsigned int __weak arch_get_system_nr_ranges(void)
+{
+	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
+	phys_addr_t start, end;
+	u64 i;
+
+	for_each_mem_range(i, &start, &end)
+		nr_ranges++;
+	return nr_ranges;
+}
+
+int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
+{
+	phys_addr_t start, end;
+	u64 i;
+
+	for_each_mem_range(i, &start, &end) {
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
+	return 0;
+}
 int __weak arch_crash_exclude_ranges(struct crash_mem *cmem) { return 0; }
 
 int __weak arch_crash_exclude_mem_range(struct crash_mem **mem,
-- 
2.43.0

