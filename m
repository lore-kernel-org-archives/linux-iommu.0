Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2ABC433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 12:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E2BA60ED7;
	Mon,  2 May 2022 12:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bQK1ajGu1Imr; Mon,  2 May 2022 12:54:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0F78F60ED5;
	Mon,  2 May 2022 12:54:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F43CC0080;
	Mon,  2 May 2022 12:54:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD27BC002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 12:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB68D4088B
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 12:54:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id spKEjkNzIWHa for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 12:54:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 746DF403C1
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 12:54:45 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id c14so3373848pfn.2
 for <iommu@lists.linux-foundation.org>; Mon, 02 May 2022 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iN/fKJaSIZtDp6gQxOCgt91Vdq1JSEAMP+iuJMs6E2A=;
 b=hrgLy/VpAgIhhjqt4SAwfD8DP+zK4BkEfr2buQP7FspXbT0PSM0e9Cbi8khqemP56W
 U8rv5ojLJlRhXNdeK9IfEizYG7JyZbbhGjvNsH4js/gdN7CZOxcCLiK5n+uhD/ErnRZN
 qqulEtGgDqLRKJHN9ls7JDscJV3a+D3lDHadEhLEgRXcoQgPb+8BJ2bUR33kQyXZ88fW
 EQbupi/9LoIDPhOBs1WAVllhJDWbGXfXNfQoqnQhodaQ2uTIU4bvM8QuHaCJ7WC9pjk6
 2pp3LUvs3ZgRhkZBWeRZrg64hY2JzwFDzuUdxkPYeB9TLoDY08Nfq6z8JaXr+msrmd00
 GfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iN/fKJaSIZtDp6gQxOCgt91Vdq1JSEAMP+iuJMs6E2A=;
 b=Fo6BDYN/k3T7HoH9rf1QCU3p4X7oEd3R0lm9Z9FW9msugjVSgQPVX5miXJ7YwoHQlL
 +3hrqgJFMBhfFo3mXEtv9CADrQ0f7KTSTZpRdvJKsndPzOfxJWrdIHTJw6M3+y6MUliw
 GnbbB75ljwnIYZjdkVSCD4zIReSK/4XvDs8OpE0fPVaHWwceZ9vhAFgKSzMambG/y6k8
 2LRgF5ooeGlgyjC0QVTxQ712QiBWZOtGCtQPw8mfWRVJu2L5MNYtU/jXz0MajDvwTQxH
 2U8oO+h3AWLiVy3QCOOh6Yizbp7Xqc3+brrQcoJGwXtdO+Zab2bWhsL/CAxhB1NM5jJx
 RpYg==
X-Gm-Message-State: AOAM531DubPWl01dvF5HDAo2hXF1al4zZPh4eKbb3hYOuF/dhZtp7SUY
 9xrmveHjUeIrqxkkgNwbONQ=
X-Google-Smtp-Source: ABdhPJxluc/MwrTa+ANe+CP4VNLdZ/2QrcVXP5LkWoKqW5fmpK1MYR0/ySmxJkMq30rZk3IKZqcZmA==
X-Received: by 2002:a63:8449:0:b0:3ab:5075:d40d with SMTP id
 k70-20020a638449000000b003ab5075d40dmr9636514pgd.12.1651496084809; 
 Mon, 02 May 2022 05:54:44 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:3:7753:ad69:7fc0:9dfc])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a62e505000000b0050dc76281cesm4634892pff.168.2022.05.02.05.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 May 2022 05:54:44 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 michael.h.kelley@microsoft.com, kys@microsoft.com
Subject: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Date: Mon,  2 May 2022 08:54:35 -0400
Message-Id: <20220502125436.23607-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502125436.23607-1-ltykernel@gmail.com>
References: <20220502125436.23607-1-ltykernel@gmail.com>
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-hyperv@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 kirill.shutemov@intel.com, iommu@lists.linux-foundation.org,
 andi.kleen@intel.com, brijesh.singh@amd.com, vkuznets@redhat.com, hch@lst.de
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

Traditionally swiotlb was not performance critical because it was only
used for slow devices. But in some setups, like TDX/SEV confidential
guests, all IO has to go through swiotlb. Currently swiotlb only has a
single lock. Under high IO load with multiple CPUs this can lead to
significant lock contention on the swiotlb lock.

This patch adds child IO TLB mem support to resolve spinlock overhead
among device's queues. Each device may allocate IO tlb mem and setup
child IO TLB mem according to queue number. Swiotlb code allocates
bounce buffer among child IO tlb mem iterately.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 include/linux/swiotlb.h |  7 +++
 kernel/dma/swiotlb.c    | 97 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7ed35dd3de6e..4a3f6a7b4b7e 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -89,6 +89,9 @@ extern enum swiotlb_force swiotlb_force;
  * @late_alloc:	%true if allocated using the page allocator
  * @force_bounce: %true if swiotlb bouncing is forced
  * @for_alloc:  %true if the pool is used for memory allocation
+ * @child_nslot:The number of IO TLB slot in the child IO TLB mem.
+ * @num_child:  The child io tlb mem number in the pool.
+ * @child_start:The child index to start searching in the next round.
  */
 struct io_tlb_mem {
 	phys_addr_t start;
@@ -102,6 +105,10 @@ struct io_tlb_mem {
 	bool late_alloc;
 	bool force_bounce;
 	bool for_alloc;
+	unsigned int num_child;
+	unsigned int child_nslot;
+	unsigned int child_start;
+	struct io_tlb_mem *child;
 	struct io_tlb_slot {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e2ef0864eb1e..32e8f42530b6 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -207,6 +207,26 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 		mem->force_bounce = true;
 
 	spin_lock_init(&mem->lock);
+
+	if (mem->num_child) {
+		mem->child_nslot = nslabs / mem->num_child;
+		mem->child_start = 0;
+
+		/*
+		 * Initialize child IO TLB mem, divide IO TLB pool
+		 * into child number. Reuse parent mem->slot in the
+		 * child mem->slot.
+		 */
+		for (i = 0; i < mem->num_child; i++) {
+			mem->child[i].slots = mem->slots + i * mem->child_nslot;
+			mem->child[i].num_child = 0;
+
+			swiotlb_init_io_tlb_mem(&mem->child[i],
+				start + ((i * mem->child_nslot) << IO_TLB_SHIFT),
+				mem->child_nslot, late_alloc);
+		}
+	}
+
 	for (i = 0; i < mem->nslabs; i++) {
 		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
@@ -336,16 +356,18 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 
 	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 		get_order(array_size(sizeof(*mem->slots), nslabs)));
-	if (!mem->slots) {
-		free_pages((unsigned long)vstart, order);
-		return -ENOMEM;
-	}
+	if (!mem->slots)
+		goto error_slots;
 
 	set_memory_decrypted((unsigned long)vstart, bytes >> PAGE_SHIFT);
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, true);
 
 	swiotlb_print_info();
 	return 0;
+
+error_slots:
+	free_pages((unsigned long)vstart, order);
+	return -ENOMEM;
 }
 
 void __init swiotlb_exit(void)
@@ -483,10 +505,11 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
  * Find a suitable number of IO TLB entries size that will fit this request and
  * allocate a buffer from that IO TLB pool.
  */
-static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
-			      size_t alloc_size, unsigned int alloc_align_mask)
+static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
+				 struct device *dev, phys_addr_t orig_addr,
+				 size_t alloc_size,
+				 unsigned int alloc_align_mask)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
@@ -565,6 +588,46 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	return index;
 }
 
+static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
+			      size_t alloc_size, unsigned int alloc_align_mask)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_mem *child_mem = mem;
+	int start = 0, i = 0, index;
+
+	if (mem->num_child) {
+		i = start = mem->child_start;
+		mem->child_start = (mem->child_start + 1) % mem->num_child;
+		child_mem = mem->child;
+	}
+
+	do {
+		index = swiotlb_do_find_slots(child_mem + i, dev, orig_addr,
+					      alloc_size, alloc_align_mask);
+		if (index >= 0)
+			return i * mem->child_nslot + index;
+		if (++i >= mem->num_child)
+			i = 0;
+	} while (i != start);
+
+	return -1;
+}
+
+static unsigned long mem_used(struct io_tlb_mem *mem)
+{
+	int i;
+	unsigned long used = 0;
+
+	if (mem->num_child) {
+		for (i = 0; i < mem->num_child; i++)
+			used += mem->child[i].used;
+	} else {
+		used = mem->used;
+	}
+
+	return used;
+}
+
 phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		unsigned int alloc_align_mask, enum dma_data_direction dir,
@@ -594,7 +657,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		if (!(attrs & DMA_ATTR_NO_WARN))
 			dev_warn_ratelimited(dev,
 	"swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-				 alloc_size, mem->nslabs, mem->used);
+				     alloc_size, mem->nslabs, mem_used(mem));
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
@@ -617,9 +680,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	return tlb_addr;
 }
 
-static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
+static void swiotlb_do_release_slots(struct io_tlb_mem *mem,
+				     struct device *dev, phys_addr_t tlb_addr)
 {
-	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
@@ -660,6 +723,20 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	spin_unlock_irqrestore(&mem->lock, flags);
 }
 
+static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	int index, offset;
+
+	if (mem->num_child) {
+		offset = swiotlb_align_offset(dev, tlb_addr);	
+		index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
+		mem = &mem->child[index / mem->child_nslot];
+	}
+
+	swiotlb_do_release_slots(mem, dev, tlb_addr);
+}
+
 /*
  * tlb_addr is the physical address of the bounce buffer to unmap.
  */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
