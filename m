Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C54C4707F
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:10:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBCD6136A
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BBCD6136A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3263605C6;
	Tue, 28 Sep 2021 19:10:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16ghD4bl6Q19; Tue, 28 Sep 2021 19:10:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9042660B4B;
	Tue, 28 Sep 2021 19:10:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30AC8C0029;
	Tue, 28 Sep 2021 19:10:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADB4EC0026
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8E6E8606B1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:10:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wXKQMUbTjD1S for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 19:10:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE69A60668
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:10:27 +0000 (UTC)
Received: from zn.tnic (p200300ec2f13b20078349fd04295260b.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f13:b200:7834:9fd0:4295:260b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA8AE1EC07DB;
 Tue, 28 Sep 2021 21:10:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1632856225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yHJ6e7Bmwkz50+RVEbqglMxxqHkOk9bZ0FbmEQ6oVM=;
 b=cRCuyVmyUGb8xOIQSMdFgh+q/yOODAlKAwtInSXnW0wUPS8DC3fX5MxGqbz/sv1xBIjmLG
 BoCCdS+ob7YklrRI3M7FYBFgEigdRC94JRaY484Z5hacTLLar7w1TNjumxLi0PurEgKc0Y
 5bMSbEm2y+BypOL4qe9f5gfnPVzSgec=
From: Borislav Petkov <bp@alien8.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] x86/sev: Replace occurrences of sev_es_active() with
 cc_platform_has()
Date: Tue, 28 Sep 2021 21:10:08 +0200
Message-Id: <20210928191009.32551-8-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928191009.32551-1-bp@alien8.de>
References: <20210928191009.32551-1-bp@alien8.de>
MIME-Version: 1.0
Cc: linux-efi@vger.kernel.org, kvm@vger.kernel.org,
 David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-s390@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org, amd-gfx@lists.freedesktop.org,
 Christoph Hellwig <hch@infradead.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Dave Young <dyoung@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, kexec@lists.infradead.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 linuxppc-dev@lists.ozlabs.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Tom Lendacky <thomas.lendacky@amd.com>

Replace uses of sev_es_active() with the more generic cc_platform_has()
using CC_ATTR_GUEST_STATE_ENCRYPT. If future support is added for other
memory encyrption techonologies, the use of CC_ATTR_GUEST_STATE_ENCRYPT
can be updated, as required.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mem_encrypt.h |  2 --
 arch/x86/kernel/sev.c              |  6 +++---
 arch/x86/mm/mem_encrypt.c          | 24 +++---------------------
 arch/x86/realmode/init.c           |  3 +--
 4 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index a5a58ccd1ee3..da14ede311aa 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,7 +51,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sev_es_active(void);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
@@ -74,7 +73,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sev_es_active(void) { return false; }
 
 static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a6895e440bc3..53a6837d354b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -11,7 +11,7 @@
 
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/printk.h>
 #include <linux/mm_types.h>
 #include <linux/set_memory.h>
@@ -615,7 +615,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 	int cpu;
 	u64 pfn;
 
-	if (!sev_es_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return 0;
 
 	pflags = _PAGE_NX | _PAGE_RW;
@@ -774,7 +774,7 @@ void __init sev_es_init_vc_handling(void)
 
 	BUILD_BUG_ON(offsetof(struct sev_es_runtime_data, ghcb_page) % PAGE_SIZE);
 
-	if (!sev_es_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		return;
 
 	if (!sev_es_check_cpu_features())
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 932007a6913b..2d04c39bea1d 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -361,25 +361,6 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 	return early_set_memory_enc_dec(vaddr, size, true);
 }
 
-/*
- * SME and SEV are very similar but they are not the same, so there are
- * times that the kernel will need to distinguish between SME and SEV. The
- * cc_platform_has() function is used for this.  When a distinction isn't
- * needed, the CC_ATTR_MEM_ENCRYPT attribute can be used.
- *
- * The trampoline code is a good example for this requirement.  Before
- * paging is activated, SME will access all memory as decrypted, but SEV
- * will access all memory as encrypted.  So, when APs are being brought
- * up under SME the trampoline area cannot be encrypted, whereas under SEV
- * the trampoline area must be encrypted.
- */
-
-/* Needs to be called from non-instrumentable code */
-bool noinstr sev_es_active(void)
-{
-	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
-}
-
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {
@@ -449,7 +430,7 @@ static void print_mem_encrypt_feature_info(void)
 		pr_cont(" SEV");
 
 	/* Encrypted Register State */
-	if (sev_es_active())
+	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		pr_cont(" SEV-ES");
 
 	pr_cont("\n");
@@ -468,7 +449,8 @@ void __init mem_encrypt_init(void)
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && !sev_es_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    !cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index c878c5ee5a4c..4a3da7592b99 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -2,7 +2,6 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/memblock.h>
-#include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
 
@@ -48,7 +47,7 @@ static void sme_sev_setup_real_mode(struct trampoline_header *th)
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
-	if (sev_es_active()) {
+	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
 		/*
 		 * Skip the call to verify_cpu() in secondary_startup_64 as it
 		 * will cause #VC exceptions when the AP can't handle them yet.
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
