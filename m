Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79934C76191
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 09:31:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A09720665
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 09:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBPGqKzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A09720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1CCD71436;
	Thu, 18 Jul 2019 09:31:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 486ED1287
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 09:31:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6F72612E
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2gxiLn5BEacFuC640CIcD7DPsCB2l6+9AtpNV1TW7O8=;
	b=nBPGqKzYmotQ0YLQEVxGm55m3
	+K8rTElRkTZ4S23P7OKtXIWdhhJhex8dGoyG4qoM6XTcQ5k0qzlZL/fYuMLpU8KCyjcrOpNhc4VGq
	SFC2iKvhaQm9qq/19OUiNDNfuz1YxiFcO53dDRaQ91LpSkvyVtrr+Ui1AAm5I+B9V8I25hyGEUtBC
	eEtOzrfc0Xygf6TEpAq2Gje0Sk5Dc6WdN8gs8TDau7QvOQtkRbV84R+HvTxYRPIYELRh2J5ndX3Ex
	QuzxKsLn1FzbEY3T4GyHdBYorqn7qj1qzI/7IH3jbJ0LDOGUvj09Hq+1m4lrKdROt1COfGsx/VuAK
	yUyhtMAyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
	Linux)) id 1ho2l8-0004kp-20; Thu, 18 Jul 2019 09:31:30 +0000
Date: Thu, 18 Jul 2019 02:31:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Al Farleigh <AWFour@charter.net>
Subject: Re: x86-64 kernel dma issue; bisected
Message-ID: <20190718093129.GA25126@infradead.org>
References: <c04211d3-5e4a-daa2-4410-88c8c84e5735@charter.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c04211d3-5e4a-daa2-4410-88c8c84e5735@charter.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Tom Lendacky <thomas.lendacky@amd.com>, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Jul 16, 2019 at 10:43:33PM -0400, Al Farleigh wrote:
> re: the dma-direct code commit below
> 
> I have bisected the kernel to isolate a PCI board problem on my AMD x86-64
> ASROCK system. The board worked at (Fedora kernel) 4.18.16 but stopped when
> moving to (Fedora kernel) 5.0. I then used (git/torvalds/linux) 4.20-rc4 or
> so to locate the fault via bisect.
> 
> I now have two kernels, good/bad, that straddle the commit.
> 
> I was asked to try v5.2 just in case it was fixed; I compiled it and the
> fault appears to still be present.
> 
> Simply, mpeg video does not stream from board; no errors, but no video.
> 
> My work is documented at
> https://bugs.kde.org/show_bug.cgi?id=408004

I've looked through that log but I'm still not sure what driver
you are actually using for video capture.  Am I right in that your
are using the saa7134 driver based on the dmesg?

That driver uses a 32-bit DMA mask, so we should be bounce buffering.

We recently had a bug with the AMD memory encryption and the encrypted
bit, are you using that?  The "Freeing unused decrypted memory:" message
somehow suggests that but I can't find where that would come from by a
simple grep.  If your are using AMD memory encryption or are not sure
please try the patch below:

---
From 9087c37584fb7d8315877bb55f85e4268cc0b4f4 Mon Sep 17 00:00:00 2001
From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Wed, 10 Jul 2019 19:01:19 +0000
Subject: dma-direct: Force unencrypted DMA under SME for certain DMA masks

If a device doesn't support DMA to a physical address that includes the
encryption bit (currently bit 47, so 48-bit DMA), then the DMA must
occur to unencrypted memory. SWIOTLB is used to satisfy that requirement
if an IOMMU is not active (enabled or configured in passthrough mode).

However, commit fafadcd16595 ("swiotlb: don't dip into swiotlb pool for
coherent allocations") modified the coherent allocation support in
SWIOTLB to use the DMA direct coherent allocation support. When an IOMMU
is not active, this resulted in dma_alloc_coherent() failing for devices
that didn't support DMA addresses that included the encryption bit.

Addressing this requires changes to the force_dma_unencrypted() function
in kernel/dma/direct.c. Since the function is now non-trivial and
SME/SEV specific, update the DMA direct support to add an arch override
for the force_dma_unencrypted() function. The arch override is selected
when CONFIG_AMD_MEM_ENCRYPT is set. The arch override function resides in
the arch/x86/mm/mem_encrypt.c file and forces unencrypted DMA when either
SEV is active or SME is active and the device does not support DMA to
physical addresses that include the encryption bit.

Fixes: fafadcd16595 ("swiotlb: don't dip into swiotlb pool for coherent allocations")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
[hch: moved the force_dma_unencrypted declaration to dma-mapping.h,
      fold the s390 fix from Halil Pasic]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/Kconfig          |  1 +
 arch/s390/mm/init.c        |  7 ++++++-
 arch/x86/Kconfig           |  1 +
 arch/x86/mm/mem_encrypt.c  | 30 ++++++++++++++++++++++++++++++
 include/linux/dma-direct.h |  9 +++++++++
 kernel/dma/Kconfig         |  3 +++
 kernel/dma/direct.c        | 16 ++++------------
 7 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 5d8570ed6cab..a4ad2733eedf 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -189,6 +189,7 @@ config S390
 	select VIRT_CPU_ACCOUNTING
 	select ARCH_HAS_SCALED_CPUTIME
 	select HAVE_NMI
+	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select SWIOTLB
 	select GENERIC_ALLOCATOR
 
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index f0bee6af3960..78c319c5ce48 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -30,7 +30,7 @@
 #include <linux/export.h>
 #include <linux/cma.h>
 #include <linux/gfp.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
 #include <asm/pgtable.h>
@@ -161,6 +161,11 @@ bool sev_active(void)
 	return is_prot_virt_guest();
 }
 
+bool force_dma_unencrypted(struct device *dev)
+{
+	return sev_active();
+}
+
 /* protected virtualization */
 static void pv_init(void)
 {
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 879741336771..d1afe92bf994 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1528,6 +1528,7 @@ config AMD_MEM_ENCRYPT
 	depends on X86_64 && CPU_SUP_AMD
 	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
+	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	---help---
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index e0df96fdfe46..c805f0a5c16e 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -15,6 +15,10 @@
 #include <linux/dma-direct.h>
 #include <linux/swiotlb.h>
 #include <linux/mem_encrypt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
@@ -348,6 +352,32 @@ bool sev_active(void)
 }
 EXPORT_SYMBOL(sev_active);
 
+/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
+bool force_dma_unencrypted(struct device *dev)
+{
+	/*
+	 * For SEV, all DMA must be to unencrypted addresses.
+	 */
+	if (sev_active())
+		return true;
+
+	/*
+	 * For SME, all DMA must be to unencrypted addresses if the
+	 * device does not support DMA to addresses that include the
+	 * encryption mask.
+	 */
+	if (sme_active()) {
+		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
+		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
+						dev->bus_dma_mask);
+
+		if (dma_dev_mask <= dma_enc_mask)
+			return true;
+	}
+
+	return false;
+}
+
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_free_decrypted_mem(void)
 {
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index b7338702592a..adf993a3bd58 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -32,6 +32,15 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
+#ifdef CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED
+bool force_dma_unencrypted(struct device *dev);
+#else
+static inline bool force_dma_unencrypted(struct device *dev)
+{
+	return false;
+}
+#endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
+
 /*
  * If memory encryption is supported, phys_to_dma will set the memory encryption
  * bit in the DMA address, and dma_to_phys will clear it.  The raw __phys_to_dma
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 70f8f8d9200e..9decbba255fc 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -48,6 +48,9 @@ config ARCH_HAS_DMA_COHERENT_TO_PFN
 config ARCH_HAS_DMA_MMAP_PGPROT
 	bool
 
+config ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	bool
+
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index b90e1aede743..d7cec866d16b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -23,14 +23,6 @@
 #define ARCH_ZONE_DMA_BITS 24
 #endif
 
-/*
- * For AMD SEV all DMA must be to unencrypted addresses.
- */
-static inline bool force_dma_unencrypted(void)
-{
-	return sev_active();
-}
-
 static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
 {
 	if (!dev->dma_mask) {
@@ -46,7 +38,7 @@ static void report_addr(struct device *dev, dma_addr_t dma_addr, size_t size)
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
 		phys_addr_t phys)
 {
-	if (force_dma_unencrypted())
+	if (force_dma_unencrypted(dev))
 		return __phys_to_dma(dev, phys);
 	return phys_to_dma(dev, phys);
 }
@@ -67,7 +59,7 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 	if (dev->bus_dma_mask && dev->bus_dma_mask < dma_mask)
 		dma_mask = dev->bus_dma_mask;
 
-	if (force_dma_unencrypted())
+	if (force_dma_unencrypted(dev))
 		*phys_mask = __dma_to_phys(dev, dma_mask);
 	else
 		*phys_mask = dma_to_phys(dev, dma_mask);
@@ -159,7 +151,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	}
 
 	ret = page_address(page);
-	if (force_dma_unencrypted()) {
+	if (force_dma_unencrypted(dev)) {
 		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
 		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
 	} else {
@@ -192,7 +184,7 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
-	if (force_dma_unencrypted())
+	if (force_dma_unencrypted(dev))
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 
 	if (IS_ENABLED(CONFIG_ARCH_HAS_UNCACHED_SEGMENT) &&
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
