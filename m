Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97E12B94
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120192; cv=none; b=HOrXEqabyCFyx7PX2sV24Qumy8VfCYsmBJrfGF8yyFCx3DXOKYINbdcLk+NMTDQP3NUjfkGxgUGrmELhyiSXvyqqv04ZsAbOw6uVRNUcuwKkhdy2xrKvaqpIzKNFIB+/sZNN4NP5JkIyQuk6aSE6Z6L5knV+CsWpHJBprxFZaUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120192; c=relaxed/simple;
	bh=zTdr4+6jkFuMQZOXbyFEnwK8Laq/5ftS584CszA5hkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY1bRVzVzSTsz7uXaubCYS8436KUU4CpIV76e0waZpcmpgqqial3KSH3cfjncrQtZ9jOo/h24kQF6MPTWcGfPekfVqFjgvjUfBaRpv8gXNuk8UeyAPf5j6qX2MifngbRQTDTwnaWRViaKve7IV2x7lz5XTilGSyDYyDtc4JW8O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyJorY4T; arc=none smtp.client-ip=74.125.227.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyJorY4T"
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3acc610014eso196589a91.0
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 20:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120190; x=1792724990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=;
        b=OyJorY4TyNFXKoZ1rl3YzeffQ+FMJxyalVizNVnOZCBw321yTfOt4KBYYsQJTjo4kc
         PsDcd+RRM5OfFcxyFZMkPhI5oYaHCVaxXI1OwOgRjV6++BUPWUTL4IPymMYSFGiS12aN
         nxgQmf8B43ReczN929nLOnvGrI5qTcIGb1Cm2I8OwCfgplRtF7SBrAlbk0gaj8EiWxd4
         KBvFJb0zFXA6DZH31TJw4t8QgL0mjU4Su00lRnhOykvDK5rmJnYepmb8HI4h3de1moZ2
         GuOBnAw+2rqp7zA4u7tlq9ahIdoN1BSHNH8GkYCVqFTz+8eJ6Skf/H3YOx1nXgvSA6hm
         gmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120190; x=1792724990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=;
        b=utFGQvWZPEvyEUnmpomkYNRq+368fOVwKXw39yT+AFehGNWA2emjdcZzecvml8Gey3
         Tbbl/axEdfxR122OBbpoYy8hV1WQplJyFTR45IwCLkwNh5ftY0faJE/2tnAZm9hAYBel
         MO22+uyfCAc2SYJNL97OBFUvvt5fDxbPkhCZOC8CzbemfJY3pjK5BNe50TDLWhqz4cjF
         KiyMxZKcxJc4Y+T3iZ8i7XHhcaMERmtBtGcPMNK3My8BW2P1/7jWhpF9jHHSsLrePH/M
         RKN8l732s5X4QHJoeqhwRFKbdPQVmVnCpI08fvywZq2fbgtwq9Ui1Q2x7NTtvkxrOO6J
         ihQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbznyBdQZ1T8Kmt4ksdf00rbUfCCRWzjBc+b7FNEOHof+TtKtIldmnvN8xg/WqDe+cfCKI3Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYKVS7ARdrf/c02oY+K6hvr8ZomSfci0dStPHCD9yil15IjzpxRk
	w4utCjl3IISFhvJAz7IIi1yfWXQcTuzD3d1q6ZEGLrC0yDt6mLfEXV0U
X-Gm-Gg: AYBFou1RYu0B2dRq6v5pSh14mLisEs5gzyqMrKpom41326+dSa7+7KHFK0TCgI/ZapX
	TRRfo+JxzM7suBnvVcEJxPVrdq509AXoRh9zZebfGdGgBjm9kP/6MiIQREz/Dr2vHExstxOAGH6
	mf91FVVkenmpLResHkyLUgdx7e6ng21Ws9JGl7hOwqkwuCHOGzXul2sJKVgBlawBtzWFLpMVfAK
	X84bUZAk2KeQ244aaOPR4oN3hNHImD8hsLSue2LnsffBSV3vkHLyHIwgOCiDGqcQAB3pVyiQPfJ
	bThzDvcZj6FFFTw2hItLybutIMR3681BTtvcRiZKU3LCBqsLI4ru/5kdxfxFq66RNy28efTPFi7
	bgO8R+SH907vDOnn0TEp8u90pJBMcGSba+pmmV1JogJXCSmnjJfOTGGX7tMxGFUs96fCGXwdtI7
	kOLCLckLV+N+0+G+9dxVgrPOsFr2oxruRSvYZw+DThUaHNlMCch4L5OCCAOdkEkDl1S+ia/U+HY
	3pDtctP6dg=
X-Received: by 2002:a17:90b:35cc:b0:3a5:147a:3b63 with SMTP id 98e67ed59e1d1-3ab3a33db36mr18094196a91.8.1792120190079;
        Thu, 15 Oct 2026 20:09:50 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3cc73c7sm370085a91.4.2026.10.15.20.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:09:49 -0700 (PDT)
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
Subject: [PATCH v8 3/8] crash_core: serialize crash header preparation against hotplug
Date: Fri, 16 Oct 2026 11:08:50 +0800
Message-ID: <20261016030855.4062882-4-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016030855.4062882-1-chenwandun1@gmail.com>
References: <20261016030855.4062882-1-chenwandun1@gmail.com>
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
kexec_file_load(). The x86/riscv memory hotplug path already takes
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
 arch/riscv/kernel/crash.c  |  2 +-
 arch/x86/kernel/crash.c    |  2 +-
 include/linux/crash_core.h |  2 ++
 kernel/crash_core.c        | 17 +++++++++++++++--
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/crash.c b/arch/riscv/kernel/crash.c
index fe5a4b306aae..ac8df2edf2a7 100644
--- a/arch/riscv/kernel/crash.c
+++ b/arch/riscv/kernel/crash.c
@@ -70,7 +70,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
+	if (__crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
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
index faa0f22dbb41..8a861a946e26 100644
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
@@ -344,8 +345,8 @@ int crash_exclude_core_ranges(struct crash_mem **cmem)
 	return 0;
 }
 
-int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
-			  unsigned long *nr_mem_ranges)
+int __crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
+			    unsigned long *nr_mem_ranges)
 {
 	unsigned int max_nr_ranges;
 	struct crash_mem *cmem;
@@ -382,6 +383,18 @@ int crash_prepare_headers(int need_kernel_map, void **addr, unsigned long *sz,
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

