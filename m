Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571474;
	b=OivAiE0EwnsVID/9shPMWIQnpuaiqEmjp72YGCpz25g/ZVMHtNomcbylJGY3jouEzqWY
	 w6BSXmxH6pUccG6sujuWBKSJehhAfAByaEr4UfEcjHPr3rJbhNxKHYVMwGZPaqKjp3hxK
	 T2UOcVc3hdvPrpT+oT3/H+ahRIrBpeR7XqlWKQ1U09RshAXglfMJ1HS4bvD+imM4GexUH
	 biJyxXq4fEBA16QLaOY3AUyO7/j7Pc9qxF+mZGTU0J1AYYfFy5WK65DwvCWTUBH3whNTm
	 qIMFsvl9O+/9Wes5De8tQCqQl4AYLfbUOSbhYTjK3TTmFMQPiYO3lOwQ4g3DVuv0VEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=;
	b=iV7nGKPK+tp0PBBefALOrQdBK5Qazzp0zI+SN3o6J5RolpxxaMvtFVY+eXnCfQBhQTvk
	 AdU+4J50SAENV07eM9NQVclK1lujzc4uAdm/DcvQnbDUalWt+LMQi/U3RNOb1MHsrXJhX
	 PnUw6zWz8ENFTUWZsGNVU4re7xGoJ9FRZaraJ7xul/KqfNpCPGF/KxP6oKVoYvRyBntVH
	 RMo8SD4aoBDz6++6L2xgi0A5LbWgSH06Ql8T1MdQoQGRhoeDzmH/kR35zG3VEskGtA3B9
	 afhaqQ6EN6EKVhhN3LYk407EK0yHV8SeFpSAAkBMfZxscPTORdxq+E3vknT03NVYtnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VeE0pprj;
	arc=none smtp.remote-ip=74.125.228.8
Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42708606A31E
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 08:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42708606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VeE0pprj
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cd5cd8e8104so19938a12.0
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 01:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571473; x=1793176273; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=;
        b=VeE0pprjnWUYdznJAYr3jWkZhfPnrEe7Gn28WlFnK5szeN3mfEvQoRrMv/fHBkLLwi
         siTvEpJn6drfGZmV/Z+G3CMKPzLpUvLj9honNmhtGCbPl6nL3tWfa9nejdy9fuy8nrx7
         jXZP6V43gr/LthBZYReLL4L7UJ2ZsLGCG02Lp/7Oj24Kg3P37Li8ERd6v6gxFB9l0Hdb
         x+6T7AsQ/+g+LD+QltcgIyDL9RuIV60Nlie4HFUKWwyjq+MI9cFDx24w8HWtGsE5ql6l
         xABJybNHwJve+QH88aF1Rg4ydzEeeUAGxBSkelHhbeZt+UWLtbe5nj2ZKtNLUVCOy9I+
         MF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571473; x=1793176273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=;
        b=gGJnvrHGuJh1Lou6WM4uj/AsOi3qEnbDYyK8HvAXRZlGCzI0p3uNFITcgZreaW4vdn
         r+lC4Ji1BWPMAs02TROXGF30UAqP0CpQHm7bu4tFvpXQbyPwNOkTj9vjcsn2ltPw3mY3
         IJ5bju/Yn7CjAQkkHiCDzNSKJWCMEo+fJBTLDgALlHpK09Rb0gLRCW76oeNCBjIXJ8tK
         WrrKeZK3/iCaJ1+XiuiIYVSKDxjf/1x3B7mQk+sDfhYD9Gp/sQRdoLRMNFBcGg6HxgzW
         DpoN1cgFKEGQfKLvqXCmeXhkIxLCJ17qbjKWXJzw2Y+NV/+uN6PpXXZiLMOkpyOZdF+G
         EhFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxx36zMn3beaEezG1ruS8eRZX9AmqELP6xB5uZW41rjlrA++93rcDw+TLiBpgheqIpeNIgbHQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLN5AB9PGtG4ZUxnCO581PQQREBFBaHqY0mExsPF78mnuBrKjGt
	EgeyV6cdPoGrEIadwTA1NfaUK6N/InI9QGLMNgSL6xbAWt2+yzp84jaA
X-Gm-Gg: AYBFou10v9Mx1b5MjlaMIkkxHpW9rp6HSqo//2+bQDtTUI0TuOvKhmA+nSZMkkuvBO8
	bPk8QOagrFszI5IEgPZ69iZDkF8XHvHPqbHXxhBfljGN/SpChGhEz92XnlI+5GgUpD21wnn3umS
	Zmi3eWLdNHr3jV4RI/jmW5CrEnlyHmGMHG6PcHPzOyZZ7hZtTKQUYEO18B+oBBDLOSps/Owgfgl
	xrv00ubn/jOPh3fQ1c5y8OHgkP7Ean0kGKPGHLiwmUYDreG0bEXj4pwGXL3uJ3ceDwykMsixD44
	PzY1938S3Je/eAsaH2eSACsbyETkq1orbTHEmHj3cHkqnoc15I/7ScdcY4g46b6BvZ8O/Xy7h+V
	YTtXGgJelDTKfyHwRfDzvseXZB7My/eF7dLTvW5/BWBLkB7vgR6vLQSXt79cxeSIE1ueSyTMOBS
	zGojJZs+lM454/wFmOvNQ0kTXPYmi3nz4+ElJuASbYM3nK1a2V4tVFABJ0x3qLfrKXXRf9oEr5f
	T1v3y+0hiS1bDCn6s009JVycSqBP90GnzYb/Px7w7QWye7Pw60O/ndDRF5XZoem6fdw
X-Received: by 2002:a05:6a00:4b04:b0:89e:8242:f35f with SMTP id d2e1a72fcca58-8a089cf006cmr1210490b3a.13.1792571473289;
        Wed, 21 Oct 2026 01:31:13 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895e273bsm600653b3a.41.2026.10.21.01.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:31:12 -0700 (PDT)
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
Subject: [PATCH v9 3/8] crash_core: serialize crash header preparation against hotplug
Date: Wed, 21 Oct 2026 16:30:06 +0800
Message-ID: <20261021083011.2170525-4-chenwandun1@gmail.com>
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

