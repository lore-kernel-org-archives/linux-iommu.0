Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039BBC433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 14:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 538C04044D;
	Tue, 23 Nov 2021 14:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EIZEiZ0HsQMg; Tue, 23 Nov 2021 14:36:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 17410403D7;
	Tue, 23 Nov 2021 14:36:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2BBCC001E;
	Tue, 23 Nov 2021 14:36:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9DAEC0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B923A80EEE
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:36:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v8LxF03EjN-v for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 14:36:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EA7980DA1
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 14:36:55 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 gb13-20020a17090b060d00b001a674e2c4a8so3065533pjb.4
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 06:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZLZVOIJvkNfO78QMd8KmGxzLi6165uI7/yB2dxT/Ykk=;
 b=gqnaX3y9BYxnolIAz6ohPiMx1+uWA+HB/7pfL/hta47mhZY1SESuVh6AyO6OrBvHl4
 /npGN7awBKNSRQFcgIEBAnGQLe1TLQvX5fWEjykeGyOCPelkp+IbfbQTIgCNlY5OeAD+
 eVdYJFoj6/DSB36poZtkhDU8kI/BioBEeklOVgEjpy6HVmrGKC3iurU9Am5/L4pKcVQo
 9HwmXweKaCVV+o0dnMKeqaMyEJBq/18jyvil0UQJaUHJwzq84trc9n7cG5YlBsDNaByO
 nmFEsY5HrfMbnqBJoHTKUUSzYWMoT5zH1nz7N3YVt/hbwdgqDBDxMpSC2gh1veDdQaDJ
 hKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZLZVOIJvkNfO78QMd8KmGxzLi6165uI7/yB2dxT/Ykk=;
 b=X/QuPEee7xXPHOwndHAO05GP+BkhiA4+ufDvmU11LaRGVOyZ4xoJR/eQJ9mRnTP73P
 55g/JBBtjpl7JlkMBisAdLX6mwBClc/E5ot7e/IB70yQRrBXNbK3gpu0Ozv5U71XH5wu
 ppi2CFLX+ItmBoAeAvEZv6MId2Z8aq0vVgiQHnKpbPWc33N2IxWWev6FZTbaXrjiT6hK
 ixG9rBGr2oEYXbWe1R6X8Rgv27lE4abMPno1DKvWYHX97HH4G11lGGnaP6vQTkcEn+W6
 yPliCJEnzuoyCMNVPDTAuRDDFFJjEtvJLijE6b+TblY449L4dS7UUALsr4oVjq1Ipoko
 edbQ==
X-Gm-Message-State: AOAM5318P5dGiyqWcDy4Wmcb0H/HEnk8viVvS7dvEx1dt0DgHmh3OtuL
 tb4r95S682WouN7DppvoLbw=
X-Google-Smtp-Source: ABdhPJw6FmBtePaEKtdoENI4y3Ha3Tjj5xx6DbA0cDTOhxNZa7Gb4JErBed6/HhU6blkX6qlJforYg==
X-Received: by 2002:a17:90b:4d92:: with SMTP id
 oj18mr3481484pjb.188.1637678215409; 
 Tue, 23 Nov 2021 06:36:55 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:1:af65:c3d4:6df:5a8b])
 by smtp.gmail.com with ESMTPSA id j13sm11926127pfc.151.2021.11.23.06.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 06:36:54 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, jgross@suse.com,
 sstabellini@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, joro@8bytes.org, will@kernel.org, davem@davemloft.net,
 kuba@kernel.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
 hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
 Tianyu.Lan@microsoft.com, thomas.lendacky@amd.com,
 xen-devel@lists.xenproject.org, michael.h.kelley@microsoft.com
Subject: [PATCH V2 1/6] Swiotlb: Add Swiotlb bounce buffer remap function for
 HV IVM
Date: Tue, 23 Nov 2021 09:30:32 -0500
Message-Id: <20211123143039.331929-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211123143039.331929-1-ltykernel@gmail.com>
References: <20211123143039.331929-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, linux-hyperv@vger.kernel.org, brijesh.singh@amd.com,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dave.hansen@intel.com,
 iommu@lists.linux-foundation.org, vkuznets@redhat.com
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
Change since v1:
	* Rework comment in the swiotlb_init_io_tlb_mem()
	* Make swiotlb_init_io_tlb_mem() back to return void.
---
 include/linux/swiotlb.h |  6 +++++
 kernel/dma/swiotlb.c    | 53 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 5 deletions(-)

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
index 8e840fbbed7c..c303fdeba82f 100644
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
@@ -155,6 +158,31 @@ static inline unsigned long nr_slots(u64 val)
 	return DIV_ROUND_UP(val, IO_TLB_SIZE);
 }
 
+/*
+ * Remap swioltb memory in the unencrypted physical address space
+ * when swiotlb_unencrypted_base is set. (e.g. for Hyper-V AMD SEV-SNP
+ * Isolation VMs).
+ */
+void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
+{
+	void *vaddr;
+
+	if (swiotlb_unencrypted_base) {
+		phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
+
+		vaddr = memremap(paddr, bytes, MEMREMAP_WB);
+		if (!vaddr) {
+			pr_err("Failed to map the unencrypted memory %llx size %lx.\n",
+			       paddr, bytes);
+			return NULL;
+		}
+
+		return vaddr;
+	}
+
+	return phys_to_virt(mem->start);
+}
+
 /*
  * Early SWIOTLB allocation may be too early to allow an architecture to
  * perform the desired operations.  This function allows the architecture to
@@ -172,7 +200,14 @@ void __init swiotlb_update_mem_attributes(void)
 	vaddr = phys_to_virt(mem->start);
 	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
 	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
-	memset(vaddr, 0, bytes);
+
+	mem->vaddr = swiotlb_mem_remap(mem, bytes);
+	if (!mem->vaddr) {
+		pr_err("Fail to remap swiotlb mem.\n");
+		return;
+	}
+
+	memset(mem->vaddr, 0, bytes);
 }
 
 static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
@@ -196,7 +231,18 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
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
+	set_memory_decrypted((unsigned long)vaddr, bytes >> PAGE_SHIFT);
 	memset(vaddr, 0, bytes);
+	mem->vaddr = vaddr;
+	return;
 }
 
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
@@ -318,7 +364,6 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	if (!mem->slots)
 		return -ENOMEM;
 
-	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
 
 	swiotlb_print_info();
@@ -371,7 +416,7 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
 	unsigned long pfn = PFN_DOWN(orig_addr);
-	unsigned char *vaddr = phys_to_virt(tlb_addr);
+	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
 	unsigned int tlb_offset, orig_addr_offset;
 
 	if (orig_addr == INVALID_PHYS_ADDR)
@@ -806,8 +851,6 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			return -ENOMEM;
 		}
 
-		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
-				     rmem->size >> PAGE_SHIFT);
 		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false);
 		mem->force_bounce = true;
 		mem->for_alloc = true;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
