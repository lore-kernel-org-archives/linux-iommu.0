Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC75C4321E
	for <iommu@archiver.kernel.org>; Sun,  5 Dec 2021 08:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBC58605C2;
	Sun,  5 Dec 2021 08:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F5mxoxCPiVMH; Sun,  5 Dec 2021 08:18:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 66EC6607CC;
	Sun,  5 Dec 2021 08:18:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 449B1C002F;
	Sun,  5 Dec 2021 08:18:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFDB1C0012
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1D8C40416
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cgSB-BkJ_-xv for <iommu@lists.linux-foundation.org>;
 Sun,  5 Dec 2021 08:18:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 452C24040D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Dec 2021 08:18:20 +0000 (UTC)
Received: by mail-pl1-x634.google.com with SMTP id m24so5009227pls.10
 for <iommu@lists.linux-foundation.org>; Sun, 05 Dec 2021 00:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cx8DmDucAVd/dOxMJIWoV1500es0laNWH4pwuIs0A1I=;
 b=J9unkTMUHekG+nABUZyTJ0X6rMpuoJDQCrzyx8KcNnCmhLA9uf7j+JFT8N8nBXx1I3
 bPMxAe29BAcVjyDyUiex3xQtEDYRVZvtkgiLG5XywwOAdzEe6jOtQNlb5aYzkGoXQVcc
 WCgb2HNGKw6hZ3CYJ3s4I254Nmy777zDKyjc+ihnoRF9RnoWxtCAo0ABZ2UdyYtrpoR7
 imgQlRsfiX8tucfrcxXByhFEhwr4Tn+l9WlB3BXfnPRKJxivf+4D9LmBRTNlkBT5hKaU
 ZcMe91ws2Pkx3hJNuPzCWWAk+wpQzKKSR3DmIpZme3+OawdRrr+VnqykrehE/QugktXj
 Fpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cx8DmDucAVd/dOxMJIWoV1500es0laNWH4pwuIs0A1I=;
 b=tE+f5/X7eFQuFzMAe1XyJrLul66dmOd6bqYtNqsyW2FsBTGBWEbQz69zV2xoax9MpI
 A3qFO/oRnZ/7tATNlLQKbdBzqbFSGsHZ3G9vMY3zl3GfywdS+y9S0W06vW0f+TG4JAoU
 bw1iuDDEL23HlVcCoaDxH+SQNWJCabC67/kyq/jfx5tb6qC7WPr+t7Sg4KnNMYGmmWEY
 kmy0fJavF/x08/dgfwwqscdO8Qv/w4P+J7mtjMret5gT2Fdbb39DBVGe1pDTBjaLGM6Z
 eQbHFtOK4AifgTroivuIxAX6qFjx2HiwTckuzBI6L9016zbzDfVCKL3v4Fw3z9yifGYt
 p0HQ==
X-Gm-Message-State: AOAM532LCpvto1+1sWVNV5xIEJqP4qS3USTm1YKXfH+nfI0u0+BQUzwg
 mMbuxtGxZ+GC7CDZ2RA/lVY=
X-Google-Smtp-Source: ABdhPJw0sC++Y7ylQvcvWJ3gyPwvm3vBrUAwZo7z4zD8IOAhoofY0ZRb4CSQlUCNF7xqVz6XNKnpgQ==
X-Received: by 2002:a17:903:408c:b0:142:45a9:672c with SMTP id
 z12-20020a170903408c00b0014245a9672cmr35466353plc.7.1638692299698; 
 Sun, 05 Dec 2021 00:18:19 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:7:87aa:e334:f070:ebca])
 by smtp.gmail.com with ESMTPSA id s8sm6439905pgl.77.2021.12.05.00.18.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Dec 2021 00:18:19 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, jgross@suse.com, sstabellini@kernel.org,
 boris.ostrovsky@oracle.com, joro@8bytes.org, will@kernel.org,
 davem@davemloft.net, kuba@kernel.org, jejb@linux.ibm.com,
 martin.petersen@oracle.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 Tianyu.Lan@microsoft.com, xen-devel@lists.xenproject.org,
 michael.h.kelley@microsoft.com
Subject: [PATCH V4 1/5] Swiotlb: Add Swiotlb bounce buffer remap function for
 HV IVM
Date: Sun,  5 Dec 2021 03:18:09 -0500
Message-Id: <20211205081815.129276-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205081815.129276-1-ltykernel@gmail.com>
References: <20211205081815.129276-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: linux-arch@vger.kernel.org, parri.andrea@gmail.com,
 linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com, hch@lst.de
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

In Isolation VM with AMD SEV, bounce buffer needs to be accessed via
extra address space which is above shared_gpa_boundary (E.G 39 bit
address line) reported by Hyper-V CPUID ISOLATION_CONFIG. The access
physical address will be original physical address + shared_gpa_boundary.
The shared_gpa_boundary in the AMD SEV SNP spec is called virtual top of
memory(vTOM). Memory addresses below vTOM are automatically treated as
private while memory above vTOM is treated as shared.

Expose swiotlb_unencrypted_base for platforms to set unencrypted
memory base offset and platform calls swiotlb_update_mem_attributes()
to remap swiotlb mem to unencrypted address space. memremap() can
not be called in the early stage and so put remapping code into
swiotlb_update_mem_attributes(). Store remap address and use it to copy
data from/to swiotlb bounce buffer.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v3:
	* Fix boot up failure on the host with mem_encrypt=on.
	  Move calloing of set_memory_decrypted() back from
	  swiotlb_init_io_tlb_mem to swiotlb_late_init_with_tbl()
	  and rmem_swiotlb_device_init().

Change since v2:
	* Leave mem->vaddr with phys_to_virt(mem->start) when fail
	  to remap swiotlb memory.

Change since v1:
	* Rework comment in the swiotlb_init_io_tlb_mem()
	* Make swiotlb_init_io_tlb_mem() back to return void.
---
 include/linux/swiotlb.h |  6 ++++++
 kernel/dma/swiotlb.c    | 43 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 569272871375..f6c3638255d5 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -73,6 +73,9 @@ extern enum swiotlb_force swiotlb_force;
  * @end:	The end address of the swiotlb memory pool. Used to do a quick
  *		range check to see if the memory was in fact allocated by this
  *		API.
+ * @vaddr:	The vaddr of the swiotlb memory pool. The swiotlb memory pool
+ *		may be remapped in the memory encrypted case and store virtual
+ *		address for bounce buffer operation.
  * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
  *		@end. For default swiotlb, this is command line adjustable via
  *		setup_io_tlb_npages.
@@ -92,6 +95,7 @@ extern enum swiotlb_force swiotlb_force;
 struct io_tlb_mem {
 	phys_addr_t start;
 	phys_addr_t end;
+	void *vaddr;
 	unsigned long nslabs;
 	unsigned long used;
 	unsigned int index;
@@ -186,4 +190,6 @@ static inline bool is_swiotlb_for_alloc(struct device *dev)
 }
 #endif /* CONFIG_DMA_RESTRICTED_POOL */
 
+extern phys_addr_t swiotlb_unencrypted_base;
+
 #endif /* __LINUX_SWIOTLB_H */
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8e840fbbed7c..34e6ade4f73c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -50,6 +50,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
 #include <linux/iommu-helper.h>
@@ -72,6 +73,8 @@ enum swiotlb_force swiotlb_force;
 
 struct io_tlb_mem io_tlb_default_mem;
 
+phys_addr_t swiotlb_unencrypted_base;
+
 /*
  * Max segment that we can provide which (if pages are contingous) will
  * not be bounced (unless SWIOTLB_FORCE is set).
@@ -155,6 +158,27 @@ static inline unsigned long nr_slots(u64 val)
 	return DIV_ROUND_UP(val, IO_TLB_SIZE);
 }
 
+/*
+ * Remap swioltb memory in the unencrypted physical address space
+ * when swiotlb_unencrypted_base is set. (e.g. for Hyper-V AMD SEV-SNP
+ * Isolation VMs).
+ */
+void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
+{
+	void *vaddr = NULL;
+
+	if (swiotlb_unencrypted_base) {
+		phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
+
+		vaddr = memremap(paddr, bytes, MEMREMAP_WB);
+		if (!vaddr)
+			pr_err("Failed to map the unencrypted memory %llx size %lx.\n",
+			       paddr, bytes);
+	}
+
+	return vaddr;
+}
+
 /*
  * Early SWIOTLB allocation may be too early to allow an architecture to
  * perform the desired operations.  This function allows the architecture to
@@ -172,7 +196,12 @@ void __init swiotlb_update_mem_attributes(void)
 	vaddr = phys_to_virt(mem->start);
 	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
 	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
-	memset(vaddr, 0, bytes);
+
+	mem->vaddr = swiotlb_mem_remap(mem, bytes);
+	if (!mem->vaddr)
+		mem->vaddr = vaddr;
+
+	memset(mem->vaddr, 0, bytes);
 }
 
 static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
@@ -196,7 +225,17 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
 	}
+
+	/*
+	 * If swiotlb_unencrypted_base is set, the bounce buffer memory will
+	 * be remapped and cleared in swiotlb_update_mem_attributes.
+	 */
+	if (swiotlb_unencrypted_base)
+		return;
+
 	memset(vaddr, 0, bytes);
+	mem->vaddr = vaddr;
+	return;
 }
 
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
@@ -371,7 +410,7 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
 	unsigned int tlb_offset, orig_addr_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
