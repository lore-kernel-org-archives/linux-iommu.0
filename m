Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D91F2367
	for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285296; cv=none; b=OC8J1VX2Up6l3LCCywN6GKwK6Y2tvWkoM4c+CFWP7Zzk248Sk4MhZ8EIMs4OuavUXQ0mjnr7bCv5A9BWSrNhmLUFtVgcUJ4U7bl4EWUSECL7zZMwaPgxHmROP/lizzXxjcBnSGh3kQ/opbfGaIWCqng/2caafR2K8Dk8zLQgxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285296; c=relaxed/simple;
	bh=mOr4S7qkhDLpcbIsD1/DCdqTuP2d90+b5AQZeO6d3Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzTOU3MNMGfhckBergb9/96ohLn38FB1DU583fm9E29Wxypb7PAjonZH6XBqvAHLyL4UMZkEP0vudV9zNKzZoHq2EIVO8eBKGYfg/LsyAQJSOtFASzdO6CFKsXKQxPWW+AEGHmqjUaT10i8bIzr5boBeeUNfcMZu8RnFt0ZjcW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QWakJvfk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QWakJvfk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QWakJvfk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QWakJvfk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B9D93E9A0;
	Tue, 11 Feb 2025 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739275487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dd93zxOHd1VhtU6mAQSadywTP6rstYV/DWhGEd1EtSQ=;
	b=QWakJvfkC5i24MEMDLBVgyRlvu7G2gCf2hX7ThuqrvKd9Nu5oTpNA+H8WHPqrIpHmOX9Vd
	nQ5LmKooy+yXN7ajnbq7w43O3KiaP9VkD5bVcQg5u1okl6Ug5HCtJ2ZB3IjL+5PSuHf5A3
	qI0HzkA5q247LxPRLfjX/7iyTSkB5Ik=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QWakJvfk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1739275487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dd93zxOHd1VhtU6mAQSadywTP6rstYV/DWhGEd1EtSQ=;
	b=QWakJvfkC5i24MEMDLBVgyRlvu7G2gCf2hX7ThuqrvKd9Nu5oTpNA+H8WHPqrIpHmOX9Vd
	nQ5LmKooy+yXN7ajnbq7w43O3KiaP9VkD5bVcQg5u1okl6Ug5HCtJ2ZB3IjL+5PSuHf5A3
	qI0HzkA5q247LxPRLfjX/7iyTSkB5Ik=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F29BD13AA6;
	Tue, 11 Feb 2025 12:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TPfMOd48q2e+GgAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 11 Feb 2025 12:04:46 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	iommu@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 2/2] xen/swiotlb: don't destroy contiguous region in all cases
Date: Tue, 11 Feb 2025 13:04:32 +0100
Message-ID: <20250211120432.29493-3-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211120432.29493-1-jgross@suse.com>
References: <20250211120432.29493-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B9D93E9A0
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

In case xen_swiotlb_alloc_coherent() needed to create a contiguous
region only for other reason than the memory not being compliant with
the device's DMA mask, there is no reason why this contiguous region
should be destroyed by xen_swiotlb_free_coherent() later. Destroying
this region should be done only, if the memory of the region was
allocated with more stringent placement requirements than the memory
it did replace.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/xen/swiotlb-xen.h |  5 +++--
 arch/x86/xen/mmu_pv.c                  | 18 ++++++++++++------
 drivers/xen/swiotlb-xen.c              | 11 +++++++----
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/xen/swiotlb-xen.h b/arch/x86/include/asm/xen/swiotlb-xen.h
index abde0f44df57..a353f20c7e79 100644
--- a/arch/x86/include/asm/xen/swiotlb-xen.h
+++ b/arch/x86/include/asm/xen/swiotlb-xen.h
@@ -4,8 +4,9 @@
 
 int xen_swiotlb_fixup(void *buf, unsigned long nslabs);
 int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
-				unsigned int address_bits,
-				dma_addr_t *dma_handle);
+				 unsigned int address_bits,
+				 dma_addr_t *dma_handle,
+				 unsigned int *address_bits_in);
 void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order);
 
 #endif /* _ASM_X86_SWIOTLB_XEN_H */
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2c70cd35e72c..fb586238f7c4 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2208,19 +2208,22 @@ void __init xen_init_mmu_ops(void)
 static unsigned long discontig_frames[1<<MAX_CONTIG_ORDER];
 
 #define VOID_PTE (mfn_pte(0, __pgprot(0)))
-static void xen_zap_pfn_range(unsigned long vaddr, unsigned int order,
-				unsigned long *in_frames,
-				unsigned long *out_frames)
+static int xen_zap_pfn_range(unsigned long vaddr, unsigned int order,
+			     unsigned long *in_frames,
+			     unsigned long *out_frames)
 {
 	int i;
+	u64 address_bits = 0;
 	struct multicall_space mcs;
 
 	xen_mc_batch();
 	for (i = 0; i < (1UL<<order); i++, vaddr += PAGE_SIZE) {
 		mcs = __xen_mc_entry(0);
 
-		if (in_frames)
+		if (in_frames) {
 			in_frames[i] = virt_to_mfn((void *)vaddr);
+			address_bits |= in_frames[i] << PAGE_SHIFT;
+		}
 
 		MULTI_update_va_mapping(mcs.mc, vaddr, VOID_PTE, 0);
 		__set_phys_to_machine(virt_to_pfn((void *)vaddr), INVALID_P2M_ENTRY);
@@ -2229,6 +2232,8 @@ static void xen_zap_pfn_range(unsigned long vaddr, unsigned int order,
 			out_frames[i] = virt_to_pfn((void *)vaddr);
 	}
 	xen_mc_issue(0);
+
+	return fls64(address_bits);
 }
 
 /*
@@ -2321,7 +2326,8 @@ static int xen_exchange_memory(unsigned long extents_in, unsigned int order_in,
 
 int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 				 unsigned int address_bits,
-				 dma_addr_t *dma_handle)
+				 dma_addr_t *dma_handle,
+				 unsigned int *address_bits_in)
 {
 	unsigned long *in_frames = discontig_frames, out_frame;
 	unsigned long  flags;
@@ -2336,7 +2342,7 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 	spin_lock_irqsave(&xen_reservation_lock, flags);
 
 	/* 1. Zap current PTEs, remembering MFNs. */
-	xen_zap_pfn_range(vstart, order, in_frames, NULL);
+	*address_bits_in = xen_zap_pfn_range(vstart, order, in_frames, NULL);
 
 	/* 2. Get a new contiguous memory extent. */
 	out_frame = virt_to_pfn((void *)vstart);
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 26c62e0d34e9..3f3724f53914 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -118,6 +118,7 @@ int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
 	int rc;
 	unsigned int order = get_order(IO_TLB_SEGSIZE << IO_TLB_SHIFT);
 	unsigned int i, dma_bits = order + PAGE_SHIFT;
+	unsigned int dummy;
 	dma_addr_t dma_handle;
 	phys_addr_t p = virt_to_phys(buf);
 
@@ -129,7 +130,7 @@ int xen_swiotlb_fixup(void *buf, unsigned long nslabs)
 		do {
 			rc = xen_create_contiguous_region(
 				p + (i << IO_TLB_SHIFT), order,
-				dma_bits, &dma_handle);
+				dma_bits, &dma_handle, &dummy);
 		} while (rc && dma_bits++ < MAX_DMA_BITS);
 		if (rc)
 			return rc;
@@ -144,6 +145,7 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
 {
 	u64 dma_mask = dev->coherent_dma_mask;
+	unsigned int address_bits = fls64(dma_mask), address_bits_in;
 	int order = get_order(size);
 	phys_addr_t phys;
 	void *ret;
@@ -160,10 +162,11 @@ xen_swiotlb_alloc_coherent(struct device *dev, size_t size,
 	if (*dma_handle + size - 1 > dma_mask ||
 	    range_straddles_page_boundary(phys, size) ||
 	    range_requires_alignment(phys, size)) {
-		if (xen_create_contiguous_region(phys, order, fls64(dma_mask),
-				dma_handle) != 0)
+		if (xen_create_contiguous_region(phys, order, address_bits,
+						 dma_handle, &address_bits_in))
 			goto out_free_pages;
-		SetPageXenRemapped(virt_to_page(ret));
+		if (address_bits_in > address_bits)
+			SetPageXenRemapped(virt_to_page(ret));
 	}
 
 	memset(ret, 0, size);
-- 
2.43.0

