Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7B3AAF52
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131405; cv=none; b=gZA7EQwmGonmFTP66WWS+DDh5s9ieD+cHNWt8GV5PZ92maDwgGMkvwSeo/FMhIZ+nox7g1Xx8B0Cz0GHJ+w7F3wCYfsFgxsJPWp96yA1tizIRGbYHuzvWpNq96HrE4Q3eT75hTfsSXBsQvqocR3JjqXCArv10FHupk6jsSazoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131405; c=relaxed/simple;
	bh=zTdr4+6jkFuMQZOXbyFEnwK8Laq/5ftS584CszA5hkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQnklt+RJDsvCV2Dg97EX7mDelEDYvwTaPwCM5QNUqwKgxBzqChDZwMrssZidvKvxaEFHONshnRLv9i4BQDxxMwx4CBaM1SgS917TBV4lh7q4dc509K07aBM1bzb75BJGxeN9gOfPNFZ3KmlAihmekKoEIezyesFXwAzBj5GDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnoJMGYk; arc=none smtp.client-ip=74.125.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnoJMGYk"
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-ccb794ce92fso507492a12.1
        for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131403; x=1792736203; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=;
        b=BnoJMGYkAVS3Bz3TcpmLXR7wtkGZJbohGuLoqXoseJ8liMlPLAMpGemkZeiSrtBKJt
         wPg6pWS148YZPWevb4Q12iPZGKPVFA0J1vftEsgg/tuPGFZRv2v1FqNcOLqs7PNRnRBl
         aLtuuW7ivR2vCyjIuNMOodG0+29TVbD+2EPg6GLqPAUEDY8aJAEI3S1UtulWiXLjGmEe
         tWAAHNL5K4pejBTidcxAbHH1ZYboGofN4CJzS20HkVebk0Tvay9Ls2CoUP9Z5EC2OV2u
         MOudqLOoXcbxdWagZE3vjWABlUE9loo0lcqCFtZ/2jmlQW5AW5wCRzdIQGjKvD1yenHw
         jc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131403; x=1792736203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4koY4BOyWDff98SibzubYxzBLIkRmqVVsOccvbFql8c=;
        b=MOtBO9fMTR0oEWLSBJbbRaMZxjqMM1Vr0+J81xX0IbtJqKdFVvZfj2wQUkDB/9y2sN
         9Oi7vfF8hQXl3SJ+PanCgUkN+VQozNE87F9AkC+6aW5iwCVrlo9noLv5FV0IjoFe+Ykg
         4tgTzsQjXCS6JXhjPwGspAkIuAkBkKIvw2qz11MVzWBajI3x83ONoU1GPRK09X5jNtwV
         5H3ZT8PPfpu7ajmir+P7J/uV0qS1c3frv3X6oQAx4rlyCyftGMqxFoqbGb7sNR0J73cZ
         WARjy3A1Vz0L/JY0eEsdo7gYu5zFnGUHyNl5UqQ8r+xXM+7ACytp0Re4YtyXs59Hc9TB
         CjJA==
X-Forwarded-Encrypted: i=1; AKwUvBwLXTG/79qpwGzdZlzjt9G6sqXUmryfRH/SKh9kZgB+Z8DaHUkuh9TB8KdcGMKZQzFPojmyFg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJqSXjMD5D4wuKV08LmjLs3W2UyE5JFXJb2WYiN4B1aDQiN92YF
	ReeiwmhU98ZgBGTNfcBRo3vG+V6hJIrKH60opPCO+Wuo05/aPlo1BsRa
X-Gm-Gg: AYBFou2Y99JRUZxwBRkcDlYPPvQidl0mCwiwyP25hfAPcXcjhRBzduTahZZhujLtqgG
	7r20LOZwOIOtkRO0mWCL+vuij4+2wcWgs02IgEjVo4iiNjm8K8gKaOy3B7wOcEr9to38aXqS9Hk
	Ax22z8w/mkK5wgxQqvGiomHcQkVDzpqAV+5ccSiN/5iyYHe1mEDqNe3nd+3/j3Day9+2fOyFAAs
	L+Twmcjo/vlVmPrDaqlZQqpTfVfX3cQjBp4gc1deRPvhlaVsyuXjMfgD65329IjFtdmDX5K4iw2
	lPZrIDYdtFz5yMmeDCNYw0x9uZ+pTeFEpqg6cLPnOn9eh+w87fOAXeNznh+zQeSQtJfdu1FeOb3
	X/izapBdUudCuq4kZB3jWzGO5PMfwHVhgkHKnPlrOU0JXLe2yCWDv+Ui2IpAUUTc4U9HSm/hjOs
	muZheTifO2UQGIlPTrMYqva7qVz+ZTKid734eicRhGUJlc0Fr7Kpm95p6EKWNwVgCM0ip2N55Aw
	006t3y/DqI=
X-Received: by 2002:a05:6a00:2e87:b0:881:c881:96e8 with SMTP id d2e1a72fcca58-897c6a340eamr18515355b3a.23.1792131403430;
        Thu, 15 Oct 2026 23:16:43 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57b334e6sm586375b3a.42.2026.10.15.23.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:16:42 -0700 (PDT)
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
Subject: [RESEND PATCH v8 3/8] crash_core: serialize crash header preparation against hotplug
Date: Fri, 16 Oct 2026 14:15:44 +0800
Message-ID: <20261016061549.4181390-4-chenwandun1@gmail.com>
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

