Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723A52ED25
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 08:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066629; cv=none; b=JkhybI8f2kib1eCVTy4O8zMb9XSZrw6T7/zdQYrUdDZvzFX0FA0CThq9Z1bc2AJKFVGTydezCbRNPLq0f8qBeT0jR83886RQlBAssEBVx2N4er+yKhn0KkwUgc32etTVfTdSWGZGe4yNJRLhZelFCSn3Ininu38qGbqnh6q2xPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066629; c=relaxed/simple;
	bh=DYgu14ldWLDawZXAo/7e6ZGTkYuIhCDmacFGgdEgG38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqAA8yJFlQ7G+IeFYv4pzMZr7rnqYox8AExY0L4aqysVAQe/Hu0toPtLO07BNHFbrPkQobgWeE8BvO53+UyTuhPu25c66OVvV/YEhN8nXKJQa83emYT3U7BjjJlE3hp33Bh/XQ9IEKfNp4FCRc1qmToUU1REtZhGPMmaugva7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmiodWHq; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmiodWHq"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a0a87595so5078367a91.1
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066627; x=1790671427; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1DOWyR/dLH3AEbWE3m8aVGig/7kxpUIrM7nXUawY8c=;
        b=TmiodWHqIyELumgY/F2/gqIbaEbD8FGp+D9GNGFf/h/DxJ1oPJ8+7rWUcVjuv+SZ/u
         qPw2Lc8VctQxbotMyaDX0cZj/uzkaMRyIP/ZW0r+tTKyS677UBsgpvvAandbhtrShxsr
         XDPRpALiHejxiMcWHte41RiKfEXH8aR3upNSGHZZPzK/N93kLNe2gyAr984As5sSPu4J
         tdtRymhjjHXvqCGpTKLPFEa5zm++AmCfFvsU0FHCqQDpQUcTW+aKyrGCVSw1DmfFU0q6
         EL8k7RB2yK8N7LlEw5XeD2tl+Vz5JyGlDdD7/Iv6BF4+aSRPU5v5kFpcAAOjbNlQ5Oc7
         2EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066627; x=1790671427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a1DOWyR/dLH3AEbWE3m8aVGig/7kxpUIrM7nXUawY8c=;
        b=HhxhVZMdIaDuhpWFQI4DOlQlwzphS8pcICDdOrV9IYVO0TbMGeNjgDHFranmxDUnGK
         mjb/qt5ZOq8HO+UGrgO6ZBsG3S6qj6k7g0jXS4REGOzMaYSpXrAHFmdxu4vbsIcnLYkZ
         nYbdlPGsW9DBg2GakXF11KjUZJnB16BdJWEsuKs5szTrGxHQfR3/xMr0WpXSf77AZ4sp
         an419ExK+Rs6KtdBCNn5Tm94Y/pr0O3WnSc1HlwyeDR6eKtOYnPGGBWMRqKaDFv+Ey8x
         1pfDrusfO5nfg/C/JljqYKCZxzLKRj6HnLAUbtSCeCBuFXPkbjljgLmVIdCLEUvqPaRb
         AnuA==
X-Forwarded-Encrypted: i=1; AKwUvBxHYmdxqnH3oG1gDlAvYu6tEQe1iaWyyoxhvl4aGN12yadNePIL98em1ppdrwbprskv3bOEdg==@lists.linux.dev
X-Gm-Message-State: AFuF++k6erbmnL0nIwDVqRmh+1Hb0veM2lNYYNo+DfqneJchEFwCqxry
	we/oRSBMIcj56N6isxSJM/MoFrXbiE8tUPGLvCmrdZUW/4roUvCI6S7f
X-Gm-Gg: AYBFou1NFPgYAnFyAQSkmzLeQmxG6tq6e+nHNzyWub21rqOvACmSX9fTrzyS4rFIr5p
	T4Akc4jNDMbTWvSs3ZtAULy2krrZC6WENgKLuI6Lq7qHRghepvTo1v4XDuX4iCmgAmV13b4KwB4
	hSg2x1RVIH6kXDBTPmzbj9+hH/ris2nCcqxuDXxWRT3hRzlm8DNERat/OOU8lX1CapzBL++hHHO
	fI0/OxTD6t6T/S8udGVUXdgS39AW07rkOqGjivCLkvEAcKtHVCrT/20M/RdouuaSHzdSTiLo3aw
	afwC59KhOb7120GjE7LMg7CwjkQ90Elmd4eeSy0Ly+3pwKOMUKGZFAmosRqCRjsSnZ53kyDm5Zg
	YhxU8l7sujtif+90LzSliG6lETg1D0wKzceOQm7OK3WOev9zH2+bZNMb79ngxVVwxno8wc/lVC+
	GN7xUzmotiwCLDtdJ70CVEru8fs9S9SfUavi5BNT/aonYQbeKqV1NH3cFLVkHz5Lfnu73//ptfN
	0Hd6hePIIg=
X-Received: by 2002:a17:90b:5546:b0:39e:14db:437c with SMTP id 98e67ed59e1d1-3a07309c886mr542158a91.4.1790066626997;
        Tue, 22 Sep 2026 01:43:46 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:43:46 -0700 (PDT)
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
Subject: [PATCH v7 3/9] crash_core: serialize crash header preparation against hotplug
Date: Tue, 22 Sep 2026 16:42:50 +0800
Message-ID: <20260922084256.1515554-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084256.1515554-1-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

crash_prepare_headers() counts memory ranges before populating the
allocated crash_mem array. The weak implementation used by ARM64,
RISC-V and LoongArch walks memblock.memory, while x86 performs the same
two-pass operation over system RAM resources. Concurrent memory hotplug
can change range source between the two walks and make the populate
pass overflow cmem->ranges.

Take device_hotplug_lock when preparing crash headers during
kexec_file_load(). The x86 memory hotplug path already takes
device_hotplug_lock, so call __crash_prepare_headers() directly
to avoid recursive locking.

Sashiko reported this issue in [1].

Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://sashiko.dev/#/message/20260806101002.1F84E1F000E9@smtp.kernel.org [1]
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 arch/x86/kernel/crash.c    |  2 +-
 include/linux/crash_core.h |  2 ++
 kernel/crash_core.c        | 17 +++++++++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e6f23933a6df..bef008a0cb22 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -465,7 +465,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
+	if (__crash_prepare_headers(IS_ENABLED(CONFIG_X86_64), &elfbuf, &elfsz, NULL)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index bc087124cd78..28e7a81cf263 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -61,6 +61,8 @@ extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_ma
 				       void **addr, unsigned long *sz);
 extern int crash_prepare_headers(int need_kernel_map, void **addr,
 				 unsigned long *sz, unsigned long *nr_mem_ranges);
+int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
+			    unsigned long *nr_mem_ranges);
 extern int crash_exclude_core_ranges(struct crash_mem **cmem);
 
 struct kimage;
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index d201638d11f3..d0cc2496dc09 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
+#include <linux/device.h>
 #include <linux/kmemleak.h>
 #include <linux/crash_core.h>
 #include <linux/reboot.h>
@@ -338,8 +339,8 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
 	return 0;
 }
 
-int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
-			  unsigned long *nr_mem_ranges)
+int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
+			    unsigned long *nr_mem_ranges)
 {
 	unsigned int max_nr_ranges;
 	struct crash_mem *cmem;
@@ -376,6 +377,18 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
 	return ret;
 }
 
+int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
+			  unsigned long *nr_mem_ranges)
+{
+	int ret;
+
+	lock_device_hotplug();
+	ret = __crash_prepare_headers(need_kernel_map, addr, sz, nr_mem_ranges);
+	unlock_device_hotplug();
+
+	return ret;
+}
+
 /**
  * crash_exclude_mem_range - exclude a mem range for existing ranges
  * @mem: mem->range contains an array of ranges sorted in ascending order
-- 
2.43.0

