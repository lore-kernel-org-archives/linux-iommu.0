Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D8A937;
	Sun, 21 Dec 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766333408; cv=none; b=qhoQfSh0Xk89EIGfqZ2Te+gZOFyYcW0ojLIiA90ZOTjrCTGQq+QXvyOXg7GJrusQTVgykRGYL0k7vpSOHXMEAz49B4BDbtPm/uU+FdVQnczaEM44IJ56owUixF3UNEyTcvAqqJ+Afi3UW2Iysa5WiVh4rynV8nZwUu0i1UgZ3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766333408; c=relaxed/simple;
	bh=eJPqgDOtHpLi3VP/nBSDuOYiluFmFPZ9E9ndit8hvJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epHGaWvurXki/y5TLAAShRz58XuOsHrZPoBJoYAPpMOHHs7VjVx1DWVHH0Btr1C0ZLEtxfJXKeynkairkmSvK066bA8AaTCsJO16nKPCzEJ2D+gwuEcRdn0rZwY2ypOy8K6pVA6IPD+J0eVe5WIE4VBefxa2ezkKjbWEeL8Ev1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz3v9Ila; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz3v9Ila"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDDAC19421;
	Sun, 21 Dec 2025 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766333407;
	bh=eJPqgDOtHpLi3VP/nBSDuOYiluFmFPZ9E9ndit8hvJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qz3v9IlaM2VeIF42CuB/XcXw0r9B4hNK2qLhuaTKLDEHvx934UM/e1Xb/Y7tkisWg
	 PXlg8WwpeqmAkGe3+HwvI9OwgLvdWh9AVz9FhC8pmFlcGWP1bpk1M80up3VeC6wGao
	 EHmvZvKc/CcTrHDUCHL3yJaTlYrzFTKACZOyLRc/kinAL+7vSGrefLA7CsjcKENTI1
	 85/TkNCLIB5e2fsSIkVWtIDrl218Ej3XLWFmqs3LbEBj5qk4/JLFhmOsdpuycFkJ1/
	 owEUeK+Dbel9IwxVvry62uKpfiDai9vf9Lbf4OgH7QsdUjYCFPsPvQf9kPVr0XL+Y6
	 J2B3ztUgVq+eQ==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	will@kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	robin.murphy@arm.com,
	suzuki.poulose@arm.com,
	akpm@linux-foundation.org,
	jgg@ziepe.ca,
	steven.price@arm.com,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH v2 2/4] coco: guest: arm64: Fetch host IPA change alignment via RHI hostconf
Date: Sun, 21 Dec 2025 21:39:18 +0530
Message-ID: <20251221160920.297689-3-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251221160920.297689-1-aneesh.kumar@kernel.org>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - add RHI hostconf SMC IDs and helper to query version, features, and IPA change alignment
 - derive the realm hypervisor page size during init and abort realm setup on invalid alignment
 - make `mem_encrypt_align()` realign to the host page size for realm guests and export the helper

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/mem_encrypt.h |  5 +--
 arch/arm64/include/asm/rhi.h         |  7 ++++
 arch/arm64/include/asm/rsi.h         |  1 +
 arch/arm64/kernel/Makefile           |  2 +-
 arch/arm64/kernel/rhi.c              | 54 ++++++++++++++++++++++++++++
 arch/arm64/kernel/rsi.c              | 13 +++++++
 arch/arm64/mm/mem_encrypt.c          |  8 +++++
 7 files changed, 85 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/kernel/rhi.c

diff --git a/arch/arm64/include/asm/mem_encrypt.h b/arch/arm64/include/asm/mem_encrypt.h
index b7ac143b81ce..06d3c30159a2 100644
--- a/arch/arm64/include/asm/mem_encrypt.h
+++ b/arch/arm64/include/asm/mem_encrypt.h
@@ -18,10 +18,7 @@ int set_memory_decrypted(unsigned long addr, int numpages);
 bool force_dma_unencrypted(struct device *dev);
 
 #define mem_encrypt_align mem_encrypt_align
-static inline size_t mem_encrypt_align(size_t size)
-{
-	return size;
-}
+size_t mem_encrypt_align(size_t size);
 
 int realm_register_memory_enc_ops(void);
 
diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
index a4f56f536876..414d9eab7f65 100644
--- a/arch/arm64/include/asm/rhi.h
+++ b/arch/arm64/include/asm/rhi.h
@@ -86,4 +86,11 @@ enum rhi_tdi_state {
 #define __REC_EXIT_DA_VDEV_MAP		0x6
 #define __RHI_DA_VDEV_SET_TDI_STATE	0x7
 
+unsigned long rhi_get_ipa_change_alignment(void);
+#define RHI_HOSTCONF_VER_1_0		0x10000
+#define RHI_HOSTCONF_VERSION		SMC_RHI_CALL(0x004E)
+
+#define __RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT BIT(0)
+#define RHI_HOSTCONF_FEATURES		SMC_RHI_CALL(0x004F)
+#define RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT	SMC_RHI_CALL(0x0050)
 #endif
diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
index c197bcc50239..2781d89827eb 100644
--- a/arch/arm64/include/asm/rsi.h
+++ b/arch/arm64/include/asm/rsi.h
@@ -79,5 +79,6 @@ static inline int rsi_set_memory_range_shared(phys_addr_t start,
 }
 
 bool rsi_has_da_feature(void);
+unsigned long realm_get_hyp_pagesize(void);
 
 #endif /* __ASM_RSI_H_ */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 76f32e424065..fcb67f50ea89 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -34,7 +34,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
 			   syscall.o proton-pack.o idle.o patching.o pi/	\
-			   rsi.o jump_label.o
+			   rsi.o jump_label.o rhi.o
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/rhi.c b/arch/arm64/kernel/rhi.c
new file mode 100644
index 000000000000..63360ed392e4
--- /dev/null
+++ b/arch/arm64/kernel/rhi.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#include <asm/rsi.h>
+#include <asm/rhi.h>
+
+/* we need an aligned rhicall for rsi_host_call. slab is not yet ready */
+static struct rsi_host_call hyp_pagesize_rhicall;
+unsigned long rhi_get_ipa_change_alignment(void)
+{
+	long ret;
+	unsigned long ipa_change_align;
+
+	hyp_pagesize_rhicall.imm = 0;
+	hyp_pagesize_rhicall.gprs[0] = RHI_HOSTCONF_VERSION;
+	ret = rsi_host_call(&hyp_pagesize_rhicall);
+	if (ret != RSI_SUCCESS)
+		goto err_out;
+
+	if (hyp_pagesize_rhicall.gprs[0] != RHI_HOSTCONF_VER_1_0)
+		goto err_out;
+
+	hyp_pagesize_rhicall.imm = 0;
+	hyp_pagesize_rhicall.gprs[0] = RHI_HOSTCONF_FEATURES;
+	ret = rsi_host_call(&hyp_pagesize_rhicall);
+	if (ret != RSI_SUCCESS)
+		goto err_out;
+
+	if (!(hyp_pagesize_rhicall.gprs[0] & __RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT))
+		goto err_out;
+
+	hyp_pagesize_rhicall.imm = 0;
+	hyp_pagesize_rhicall.gprs[0] = RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT;
+	ret = rsi_host_call(&hyp_pagesize_rhicall);
+	if (ret != RSI_SUCCESS)
+		goto err_out;
+
+	ipa_change_align = hyp_pagesize_rhicall.gprs[0];
+	/* This error needs special handling in the caller */
+	if (ipa_change_align & (SZ_4K - 1))
+		return 0;
+
+	return ipa_change_align;
+
+err_out:
+	/*
+	 * For failure condition assume host is built with 4K page size
+	 * and hence ipa change alignment can be guest PAGE_SIZE.
+	 */
+	return PAGE_SIZE;
+}
+
diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index aae24009cadb..57de4103be03 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -13,9 +13,12 @@
 #include <asm/io.h>
 #include <asm/mem_encrypt.h>
 #include <asm/rsi.h>
+#include <asm/rhi.h>
 
 static struct realm_config config;
 static u64 rsi_feat_reg0;
+static unsigned long ipa_change_alignment = PAGE_SIZE;
+
 
 unsigned long prot_ns_shared;
 EXPORT_SYMBOL(prot_ns_shared);
@@ -147,6 +150,11 @@ static int realm_ioremap_hook(phys_addr_t phys, size_t size, pgprot_t *prot)
 	return 0;
 }
 
+unsigned long realm_get_hyp_pagesize(void)
+{
+	return ipa_change_alignment;
+}
+
 void __init arm64_rsi_init(void)
 {
 	static_branch_enable(&rsi_init_call_done);
@@ -158,6 +166,11 @@ void __init arm64_rsi_init(void)
 	if (WARN_ON(rsi_get_realm_config(&config)))
 		return;
 
+	ipa_change_alignment = rhi_get_ipa_change_alignment();
+	/* If we don't get a correct alignment response, don't enable realm */
+	if (!ipa_change_alignment)
+		return;
+
 	if (WARN_ON(rsi_features(0, &rsi_feat_reg0)))
 		return;
 
diff --git a/arch/arm64/mm/mem_encrypt.c b/arch/arm64/mm/mem_encrypt.c
index deb364eadd47..6937f753e89d 100644
--- a/arch/arm64/mm/mem_encrypt.c
+++ b/arch/arm64/mm/mem_encrypt.c
@@ -64,3 +64,11 @@ bool force_dma_unencrypted(struct device *dev)
 	return is_realm_world();
 }
 EXPORT_SYMBOL_GPL(force_dma_unencrypted);
+
+size_t mem_encrypt_align(size_t size)
+{
+	if (is_realm_world())
+		return ALIGN(size, realm_get_hyp_pagesize());
+	return size;
+}
+EXPORT_SYMBOL_GPL(mem_encrypt_align);
-- 
2.43.0

